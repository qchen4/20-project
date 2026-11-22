param([Parameter(Mandatory=$true)][string]$QuestaBin,[string]$Vectors='',[string]$BuildRoot='')
$ErrorActionPreference='Stop'
$repoRoot=(Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
if(!$Vectors){$Vectors=Join-Path $repoRoot 'build\multiplier-vectors\multiplier_vectors.mem'}
$vectorPath=(Resolve-Path -LiteralPath $Vectors).Path
if(!$BuildRoot){$BuildRoot=Join-Path $repoRoot 'build\questa-multiplier'}
$runDir=Join-Path $BuildRoot ([DateTime]::UtcNow.ToString('yyyyMMddTHHmmssfff')+'-'+[Guid]::NewGuid().ToString('N').Substring(0,8))
New-Item -ItemType Directory -Path $runDir -Force | Out-Null
$sources=@('rtl\bppe_guarded_multiplier.sv','testcode\tb_bppe_guarded_multiplier.sv')
$hashes=@($sources | ForEach-Object {Get-FileHash -LiteralPath (Join-Path $repoRoot $_) -Algorithm SHA256})
$hashes+=Get-FileHash -LiteralPath $vectorPath -Algorithm SHA256
$hashes+=Get-FileHash -LiteralPath $PSCommandPath -Algorithm SHA256
$hashes+=Get-FileHash -LiteralPath (Join-Path $repoRoot 'toolchain\generate_multiplier_vectors.py') -Algorithm SHA256
$version=(& (Join-Path $QuestaBin 'vsim.exe') -version | Out-String).Trim()
@{simulator=$version;sources=$hashes;vector=$vectorPath} | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $runDir 'source_manifest.json') -Encoding utf8
$doFile=Join-Path $runDir 'run.do'
@('onerror {quit -code 1}','run -all','quit -code 0') | Set-Content -LiteralPath $doFile -Encoding ascii
Push-Location -LiteralPath $runDir
try {
    & (Join-Path $QuestaBin 'vlib.exe') work
    if($LASTEXITCODE -ne 0){throw 'vlib failed'}
    $paths=@($sources | ForEach-Object {Join-Path $repoRoot $_})
    & (Join-Path $QuestaBin 'vlog.exe') -sv -work work @paths
    if($LASTEXITCODE -ne 0){throw 'vlog failed'}
    $log=Join-Path $runDir 'multiplier.log'
    & (Join-Path $QuestaBin 'vsim.exe') -c -onfinish stop -l $log work.tb_bppe_guarded_multiplier "+VECTORS=$($vectorPath.Replace('\','/'))" -do $doFile
    $text=Get-Content -LiteralPath $log -Raw
    if($LASTEXITCODE -ne 0 -or !$text.Contains('RTL_MULTIPLIER_PASSED rows=14481 max_latency=2') -or $text.Contains('** Fatal:') -or $text.Contains('** Error:') -or $text -match 'Errors:\s*[1-9]'){
        throw "Multiplier regression failed; inspect $log"
    }
    "QUESTA_MULTIPLIER_SUITE_PASSED $runDir"
} finally {Pop-Location}
