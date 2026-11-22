param(
    [Parameter(Mandatory=$true)][string]$VivadoBat,
    [string]$Part='xc7a200tfbg484-2',
    [double]$AnalysisClockNs=33.333,
    [string]$BuildRoot=''
)
$ErrorActionPreference='Stop'
if($AnalysisClockNs -le 0 -or [double]::IsNaN($AnalysisClockNs) -or [double]::IsInfinity($AnalysisClockNs)){throw 'Analysis clock must be positive and finite'}
$repoRoot=(Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
if(!$BuildRoot){$BuildRoot=Join-Path $repoRoot 'build\vivado-frame'}
$runDir=Join-Path $BuildRoot ([DateTime]::UtcNow.ToString('yyyyMMddTHHmmssfff')+'-'+[Guid]::NewGuid().ToString('N').Substring(0,8))
New-Item -ItemType Directory -Path $runDir -Force | Out-Null
$tcl=Join-Path $PSScriptRoot 'synth_frame_ooc.tcl'
$hashes=@('rtl\bppe_frame_dispatch.sv','toolchain\synth_frame_ooc.tcl','toolchain\run_frame_vivado.ps1') |
    ForEach-Object {Get-FileHash -LiteralPath (Join-Path $repoRoot $_) -Algorithm SHA256}
@{part=$Part;top='bppe_frame_dispatch';source_hashes=$hashes;analysis_clock_ns=$AnalysisClockNs;clock_applied='post-synthesis only';threads=2;implementation=$false;io_delays=$false} |
    ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $runDir 'source_manifest.json') -Encoding utf8
$log=Join-Path $runDir 'vivado.log'
$period=$AnalysisClockNs.ToString([Globalization.CultureInfo]::InvariantCulture)
Push-Location -LiteralPath $runDir
try {
    & $VivadoBat -mode batch -nojournal -notrace -log $log -source $tcl -tclargs (Join-Path $runDir 'synth') $Part $period
    $exitCode=$LASTEXITCODE
    $text=Get-Content -LiteralPath $log -Raw
    if($exitCode -ne 0 -or !$text.Contains('BPPE_OOC_SYNTHESIS_PASSED') -or $text -match '(?m)^ERROR:'){throw "OOC synthesis failed; inspect $log"}
    Write-Output "VIVADO_FRAME_OOC_PASSED $runDir"
} finally {Pop-Location}
