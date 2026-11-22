param(
    [Parameter(Mandatory=$true)][string]$QuestaBin,
    [string]$Vectors='',
    [string]$BuildRoot=''
)
$ErrorActionPreference='Stop'
$repoRoot=(Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
if (!$Vectors) { $Vectors=Join-Path $repoRoot 'm_model\artifacts\pipeline-vectors\pipeline_vectors.mem' }
$vectorPath=(Resolve-Path -LiteralPath $Vectors).Path
if (!$BuildRoot) { $BuildRoot=Join-Path $repoRoot 'build\questa-channel' }
$runDir=Join-Path $BuildRoot ([DateTime]::UtcNow.ToString('yyyyMMddTHHmmssfff')+'-'+[Guid]::NewGuid().ToString('N').Substring(0,8))
New-Item -ItemType Directory -Path $runDir -Force | Out-Null
$doFile=Join-Path $runDir 'run.do'
@('onerror {quit -code 1}','run -all','quit -code 0') | Set-Content -LiteralPath $doFile -Encoding ascii
$sources=@('rtl\bppe_guarded_multiplier.sv','rtl\bppe_rounded_divider.sv','rtl\bppe_preprocess_core.sv','rtl\bppe_beat_core.sv','rtl\bppe_channel_core.sv','testcode\tb_bppe_channel.sv','testcode\tb_bppe_channel_flow.sv')
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
        foreach ($kind in @('vectors','flow')) {
            $top=if($kind -eq 'vectors'){'tb_bppe_channel'}else{'tb_bppe_channel_flow'}
            $marker=if($kind -eq 'vectors'){"RTL_CHANNEL_PASSED profile=$profileIndex rows=6508 cases=10"}else{"RTL_CHANNEL_FLOW_PASSED profile=$profileIndex"}
            $log=Join-Path $runDir "$kind-$profileIndex.log"
            $simArguments=@('-c','-onfinish','stop','-l',$log,"-gPROFILE=$profileIndex","work.$top","+VECTORS=$($vectorPath.Replace('\','/'))",'-do',$doFile)
            & (Join-Path $QuestaBin 'vsim.exe') @simArguments
            $text=Get-Content -LiteralPath $log -Raw
            if ($LASTEXITCODE -ne 0 -or !$text.Contains($marker) -or
                $text.Contains('** Fatal:') -or $text.Contains('** Error:') -or $text -match 'Errors:\s*[1-9]') {
                throw "Questa channel check failed (profile=$profileIndex); log: $log"
            }
        }
    }
    Write-Output "QUESTA_CHANNEL_SUITE_PASSED $runDir"
} finally { Pop-Location }
