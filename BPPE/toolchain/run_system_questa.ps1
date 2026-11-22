param(
    [Parameter(Mandatory=$true)][string]$QuestaBin,
    [string]$Vectors='',
    [string]$BuildRoot='',
    [switch]$ClockedOoc,
    [string]$UnisimDirectory='',
    [switch]$TemporalStress,
    [ValidateRange(1,2147483647)][int[]]$StressSeeds=@(1,20261106),
    [switch]$RecoveryChecks
)
$ErrorActionPreference='Stop'
if($TemporalStress -and (!$StressSeeds.Count -or @($StressSeeds | Select-Object -Unique).Count -ne $StressSeeds.Count)){throw 'Provide distinct nonzero stress seeds'}
$repoRoot=(Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
if (!$Vectors) { $Vectors=Join-Path $repoRoot 'm_model\artifacts\system-vectors\system_vectors.mem' }
$vectorPath=(Resolve-Path -LiteralPath $Vectors).Path
if (!$BuildRoot) { $BuildRoot=Join-Path $repoRoot 'build\questa-system' }
$runDir=Join-Path $BuildRoot ([DateTime]::UtcNow.ToString('yyyyMMddTHHmmssfff')+'-'+[Guid]::NewGuid().ToString('N').Substring(0,8))
New-Item -ItemType Directory -Path $runDir -Force | Out-Null
$doFile=Join-Path $runDir 'run.do'
@('onerror {quit -code 1}','run -all','quit -code 0') | Set-Content -LiteralPath $doFile -Encoding ascii
$sources=@('rtl\bppe_guarded_multiplier.sv','rtl\bppe_preprocess_core.sv','rtl\bppe_beat_core.sv','rtl\bppe_channel_core.sv','rtl\bppe_frame_dispatch.sv','rtl\bppe_acquisition_channels.sv','rtl\bppe_window_store.sv','rtl\bppe_rounded_divider.sv','rtl\bppe_measurement_core.sv','rtl\bppe_multichannel_prototype.sv','testcode\tb_bppe_system.sv')
$primitiveSources=@();$defines=@()
if($ClockedOoc){
    if(!$UnisimDirectory){throw 'ClockedOoc needs the installed Vivado unisims directory'}
    $primitiveSources=@((Resolve-Path -LiteralPath (Join-Path $UnisimDirectory 'BUFG.v')).Path)
    $sources+=@('rtl\bppe_ooc_clocked_top.sv')
    $defines=@('+define+BPPE_OOC_CLOCKED')
}
$hashes=@($sources | ForEach-Object { Get-FileHash -LiteralPath (Join-Path $repoRoot $_) -Algorithm SHA256 })
$hashes+=@($primitiveSources | ForEach-Object {Get-FileHash -LiteralPath $_ -Algorithm SHA256})
$hashes+=Get-FileHash -LiteralPath (Join-Path $repoRoot 'testcode\system_tb_ports.svh') -Algorithm SHA256
$hashes+=Get-FileHash -LiteralPath (Join-Path $repoRoot 'testcode\system_temporal_stress.svh') -Algorithm SHA256
$hashes+=Get-FileHash -LiteralPath (Join-Path $repoRoot 'testcode\system_recovery_checks.svh') -Algorithm SHA256
$hashes+=Get-FileHash -LiteralPath $vectorPath -Algorithm SHA256
$hashes+=Get-FileHash -LiteralPath $PSCommandPath -Algorithm SHA256
$hashes+=Get-FileHash -LiteralPath (Join-Path $repoRoot 'testcode\numeric_latency_bounds.svh') -Algorithm SHA256
$version=(& (Join-Path $QuestaBin 'vsim.exe') -version | Out-String).Trim()
@{ simulator=$version; clocked_ooc=[bool]$ClockedOoc; sources=$hashes; vector=$vectorPath; profiles=@(0,1,2);temporal_stress=[bool]$TemporalStress;stress_seeds=$StressSeeds;recovery_checks=[bool]$RecoveryChecks } |
    ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $runDir 'source_manifest.json') -Encoding utf8
Push-Location -LiteralPath $runDir
try {
    & (Join-Path $QuestaBin 'vlib.exe') work
    if ($LASTEXITCODE -ne 0) { throw 'vlib failed' }
    $sourcePaths=$primitiveSources+@($sources | ForEach-Object { Join-Path $repoRoot $_ })
    & (Join-Path $QuestaBin 'vlog.exe') -sv -work work "+incdir+$repoRoot/testcode" @defines @sourcePaths
    if ($LASTEXITCODE -ne 0) { throw 'vlog failed' }
    foreach ($profileIndex in @(0,1,2)) {
        $log=Join-Path $runDir "system-$profileIndex.log"
        & (Join-Path $QuestaBin 'vsim.exe') -c -onfinish stop -l $log "-gPROFILE=$profileIndex" work.tb_bppe_system "+VECTORS=$($vectorPath.Replace('\','/'))" -do $doFile
        $text=Get-Content -LiteralPath $log -Raw
        if ($LASTEXITCODE -ne 0 -or !$text.Contains("RTL_SYSTEM_PASSED profile=$profileIndex cases=24 frames=50400") -or
            $text.Contains('** Fatal:') -or $text.Contains('** Error:') -or $text -match 'Errors:\s*[1-9]') {
            throw "Questa system check failed (profile=$profileIndex); log: $log"
        }
    }
    foreach ($mode in @('RESET_NUMERIC','RESET_MEASUREMENT','RESET_PENDING','INITIAL_FAULTS')) {
        $log=Join-Path $runDir "$mode.log"
        & (Join-Path $QuestaBin 'vsim.exe') -c -onfinish stop -l $log -gPROFILE=1 work.tb_bppe_system "+VECTORS=$($vectorPath.Replace('\','/'))" "+$mode" -do $doFile
        $text=Get-Content -LiteralPath $log -Raw
        if ($LASTEXITCODE -ne 0 -or !$text.Contains("RTL_SYSTEM_FLOW_PASSED $mode") -or
            $text.Contains('** Fatal:') -or $text.Contains('** Error:') -or $text -match 'Errors:\s*[1-9]') {
            throw "Questa directed system flow failed ($mode); log: $log"
        }
    }
    $log=Join-Path $runDir 'negative-ack.log'
    & (Join-Path $QuestaBin 'vsim.exe') -c -onfinish stop -l $log -gPROFILE=1 work.tb_bppe_system "+VECTORS=$($vectorPath.Replace('\','/'))" +ACK_COLLISION -do $doFile
    $text=Get-Content -LiteralPath $log -Raw
    if (!$text.Contains('** Fatal: ACK/publication concurrency is not defined in this prototype') -or $text.Contains('RTL_SYSTEM_PASSED')) {
        throw "ACK collision was not rejected; inspect $log"
    }
    $log=Join-Path $runDir 'negative-unknown-expected.log'
    & (Join-Path $QuestaBin 'vsim.exe') -c -onfinish stop -l $log -gPROFILE=1 work.tb_bppe_system "+VECTORS=$($vectorPath.Replace('\','/'))" +UNKNOWN_EXPECTED -do $doFile
    $text=Get-Content -LiteralPath $log -Raw
    if(!$text.Contains('INJECTING_UNKNOWN_EXPECTED_FEATURE') -or !$text.Contains('** Fatal: Prototype feature mismatch') -or $text.Contains('RTL_SYSTEM_PASSED')){
        throw "Unknown expected feature was not rejected; inspect $log"
    }
    if($TemporalStress){
        foreach($seed in $StressSeeds){foreach($profileIndex in @(0,1,2)){
            $log=Join-Path $runDir "temporal-$seed-$profileIndex.log"
            & (Join-Path $QuestaBin 'vsim.exe') -c -onfinish stop -l $log "-gPROFILE=$profileIndex" work.tb_bppe_system "+VECTORS=$($vectorPath.Replace('\','/'))" +TEMPORAL_STRESS "+STRESS_SEED=$seed" -do $doFile
            $text=Get-Content -LiteralPath $log -Raw
            if($LASTEXITCODE -ne 0 -or !$text.Contains("RTL_SYSTEM_TEMPORAL_PASSED profile=$profileIndex seed=$seed accepted=50400 consumed=50400") -or
                !$text.Contains("RTL_SYSTEM_PASSED profile=$profileIndex cases=24 frames=50400") -or $text.Contains('** Fatal:') -or $text.Contains('** Error:') -or $text -match 'Errors:\s*[1-9]'){
                throw "Questa temporal system check failed (profile=$profileIndex seed=$seed); log: $log"
            }
        }}
    }
    if($RecoveryChecks){
        foreach($profileIndex in @(0,1,2)){
            foreach($target in @('PREPROCESS_CH2','BEAT_DIV_CH1','BEAT_RAM_CH0','MEASURE_DIV','MEASURE_MUL','PENDING_HELD','FAULT_HELD')){
                $log=Join-Path $runDir "recovery-$profileIndex-$target.log"
                & (Join-Path $QuestaBin 'vsim.exe') -c -onfinish stop -l $log "-gPROFILE=$profileIndex" work.tb_bppe_system "+VECTORS=$($vectorPath.Replace('\','/'))" "+RECOVERY_TARGET=$target" -do $doFile
                $text=Get-Content -LiteralPath $log -Raw
                if($LASTEXITCODE -ne 0 -or !$text.Contains("RTL_SYSTEM_RECOVERY_PASSED profile=$profileIndex target=$target") -or
                    !$text.Contains("RTL_SYSTEM_PASSED profile=$profileIndex cases=24 frames=50400") -or $text.Contains('** Fatal:') -or $text.Contains('** Error:') -or $text -match 'Errors:\s*[1-9]'){
                    throw "Questa reset recovery failed (profile=$profileIndex target=$target); log: $log"
                }
            }
            $log=Join-Path $runDir "ack-boundaries-$profileIndex.log"
            & (Join-Path $QuestaBin 'vsim.exe') -c -onfinish stop -l $log "-gPROFILE=$profileIndex" work.tb_bppe_system "+VECTORS=$($vectorPath.Replace('\','/'))" +ACK_BOUNDARIES -do $doFile
            $text=Get-Content -LiteralPath $log -Raw
            if($LASTEXITCODE -ne 0 -or !$text.Contains("RTL_SYSTEM_ACK_BOUNDARIES_PASSED profile=$profileIndex checks=74") -or
                !$text.Contains("RTL_SYSTEM_PASSED profile=$profileIndex cases=24 frames=50400") -or $text.Contains('** Fatal:') -or $text.Contains('** Error:') -or $text -match 'Errors:\s*[1-9]'){
                throw "Questa ACK boundary check failed (profile=$profileIndex); log: $log"
            }
        }
    }
    Write-Output "QUESTA_SYSTEM_SUITE_PASSED $runDir"
} finally { Pop-Location }
