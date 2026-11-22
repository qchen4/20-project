param(
    [Parameter(Mandatory=$true)][string]$QuestaBin,
    [string]$Vectors='',
    [string]$BuildRoot=''
)
$ErrorActionPreference='Stop'
$repoRoot=(Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
if (!$Vectors) { $Vectors=Join-Path $repoRoot 'm_model\artifacts\frame-vectors\frame_vectors.mem' }
$vectorPath=(Resolve-Path -LiteralPath $Vectors).Path
if (!$BuildRoot) { $BuildRoot=Join-Path $repoRoot 'build\questa-frames' }
$runDir=Join-Path $BuildRoot ([DateTime]::UtcNow.ToString('yyyyMMddTHHmmssfff')+'-'+[Guid]::NewGuid().ToString('N').Substring(0,8))
New-Item -ItemType Directory -Path $runDir -Force | Out-Null
$doFile=Join-Path $runDir 'run.do'
@('onerror {quit -code 1}','run -all','quit -code 0') | Set-Content -LiteralPath $doFile -Encoding ascii
$sources=@('rtl\bppe_guarded_multiplier.sv','rtl\bppe_rounded_divider.sv','rtl\bppe_preprocess_core.sv','rtl\bppe_beat_core.sv','rtl\bppe_channel_core.sv','rtl\bppe_frame_dispatch.sv','rtl\bppe_acquisition_channels.sv','testcode\tb_bppe_frames.sv','testcode\tb_bppe_acquisition.sv','testcode\tb_bppe_frame_flow.sv')
$hashes=@($sources | ForEach-Object { Get-FileHash -LiteralPath (Join-Path $repoRoot $_) -Algorithm SHA256 })
$hashes+=Get-FileHash -LiteralPath $vectorPath -Algorithm SHA256
$hashes+=Get-FileHash -LiteralPath $PSCommandPath -Algorithm SHA256
$hashes+=Get-FileHash -LiteralPath (Join-Path $repoRoot 'testcode\numeric_latency_bounds.svh') -Algorithm SHA256
$version=(& (Join-Path $QuestaBin 'vsim.exe') -version | Out-String).Trim()
@{ simulator=$version; sources=$hashes; vector=$vectorPath; profiles=@(0,1,2) } |
    ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $runDir 'source_manifest.json') -Encoding utf8
Push-Location -LiteralPath $runDir
try {
    & (Join-Path $QuestaBin 'vlib.exe') work
    if ($LASTEXITCODE -ne 0) { throw 'vlib failed' }
    $sourcePaths=@($sources | ForEach-Object { Join-Path $repoRoot $_ })
    & (Join-Path $QuestaBin 'vlog.exe') -sv -work work "+incdir+$repoRoot/testcode" @sourcePaths
    if ($LASTEXITCODE -ne 0) { throw 'vlog failed' }
    foreach ($profileIndex in @(0,1,2)) {
        $log=Join-Path $runDir "frames-$profileIndex.log"
        & (Join-Path $QuestaBin 'vsim.exe') -c -onfinish stop -l $log "-gPROFILE=$profileIndex" work.tb_bppe_frames "+VECTORS=$($vectorPath.Replace('\','/'))" -do $doFile
        $text=Get-Content -LiteralPath $log -Raw
        if ($LASTEXITCODE -ne 0 -or !$text.Contains("RTL_FRAMES_PASSED profile=$profileIndex cases=21 rows=5952") -or
            $text.Contains('** Fatal:') -or $text.Contains('** Error:') -or $text -match 'Errors:\s*[1-9]') {
            throw "Questa frame integration check failed (profile=$profileIndex); log: $log"
        }
    }
    foreach ($profileIndex in @(0,1,2)) {
        $log=Join-Path $runDir "acquisition-$profileIndex.log"
        & (Join-Path $QuestaBin 'vsim.exe') -c -onfinish stop -l $log "-gPROFILE=$profileIndex" work.tb_bppe_acquisition "+VECTORS=$($vectorPath.Replace('\','/'))" -do $doFile
        $text=Get-Content -LiteralPath $log -Raw
        if ($LASTEXITCODE -ne 0 -or !$text.Contains("RTL_ACQUISITION_PASSED profile=$profileIndex cases=21 rows=5952") -or
            $text.Contains('** Fatal:') -or $text.Contains('** Error:') -or $text -match 'Errors:\s*[1-9]') {
            throw "Questa acquisition integration check failed (profile=$profileIndex); log: $log"
        }
    }
    $log=Join-Path $runDir 'frame-flow.log'
    & (Join-Path $QuestaBin 'vsim.exe') -c -onfinish stop -l $log work.tb_bppe_frame_flow -do $doFile
    $text=Get-Content -LiteralPath $log -Raw
    if ($LASTEXITCODE -ne 0 -or !$text.Contains('RTL_FRAME_FLOW_PASSED') -or
        $text.Contains('** Fatal:') -or $text.Contains('** Error:') -or $text -match 'Errors:\s*[1-9]') {
        throw "Questa frame flow check failed; log: $log"
    }
    Write-Output "QUESTA_FRAMES_SUITE_PASSED $runDir"
} finally { Pop-Location }
