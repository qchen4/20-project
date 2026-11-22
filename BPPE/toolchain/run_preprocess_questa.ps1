param(
    [Parameter(Mandatory=$true)][string]$QuestaBin,
    [string]$Vectors="",
    [string]$BuildRoot=""
)
$ErrorActionPreference='Stop'
$repoRoot=(Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
if (!$Vectors) { $Vectors=Join-Path $repoRoot 'm_model\artifacts\preprocess-vectors\preprocess_vectors.mem' }
$vectorPath=(Resolve-Path -LiteralPath $Vectors).Path
if (!$BuildRoot) { $BuildRoot=Join-Path $repoRoot 'build\questa' }
$runDir=Join-Path $BuildRoot ([DateTime]::UtcNow.ToString('yyyyMMddTHHmmssfff')+'-'+[Guid]::NewGuid().ToString('N').Substring(0,8))
New-Item -ItemType Directory -Path $runDir -Force | Out-Null
$doFile=Join-Path $runDir 'run.do'
@('onerror {quit -code 1}','run -all','quit -code 0') | Set-Content -LiteralPath $doFile -Encoding ascii
$sources=@('rtl\bppe_preprocess_core.sv','testcode\tb_bppe_preprocess.sv','testcode\tb_bppe_preprocess_flow.sv')
$hashes=@($sources | ForEach-Object { Get-FileHash -LiteralPath (Join-Path $repoRoot $_) -Algorithm SHA256 })
$hashes+=Get-FileHash -LiteralPath $vectorPath -Algorithm SHA256
$hashes+=Get-FileHash -LiteralPath $PSCommandPath -Algorithm SHA256
$version=(& (Join-Path $QuestaBin 'vsim.exe') -version | Out-String).Trim()
@{ simulator=$version; sources=$hashes; vector=$vectorPath; profiles=@(0,1,2) } |
    ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $runDir 'source_manifest.json') -Encoding utf8
Push-Location -LiteralPath $runDir
try {
    & (Join-Path $QuestaBin 'vlib.exe') work
    if ($LASTEXITCODE -ne 0) { throw 'vlib failed' }
    $sourcePaths=@($sources | ForEach-Object { Join-Path $repoRoot $_ })
    & (Join-Path $QuestaBin 'vlog.exe') -sv -work work @sourcePaths
    if ($LASTEXITCODE -ne 0) { throw 'vlog failed' }
    foreach ($profileIndex in @(0,1,2)) {
        foreach ($kind in @('vectors','flow')) {
            $top=if ($kind -eq 'vectors') {'tb_bppe_preprocess'} else {'tb_bppe_preprocess_flow'}
            $marker=if ($kind -eq 'vectors') {"RTL_PREPROCESS_PASSED profile=$profileIndex rows=3308 cases=8"} else {"RTL_FLOW_PASSED profile=$profileIndex"}
            $log=Join-Path $runDir "$kind-$profileIndex.log"
            $simArguments=@('-c','-onfinish','stop','-l',$log,"-gPROFILE=$profileIndex","work.$top","+VECTORS=$($vectorPath.Replace('\','/'))",'-do',$doFile)
            & (Join-Path $QuestaBin 'vsim.exe') @simArguments
            $exitCode=$LASTEXITCODE
            $text=Get-Content -LiteralPath $log -Raw
            if ($exitCode -ne 0 -or !$text.Contains($marker) -or $text.Contains('** Fatal:') -or $text.Contains('** Error:') -or $text -match 'Errors:\s*[1-9]') {
                throw "Questa check failed ($kind profile=$profileIndex); log: $log"
            }
        }
    }
    Write-Output "QUESTA_PREPROCESS_SUITE_PASSED $runDir"
} finally { Pop-Location }
