param(
    [Parameter(Mandatory=$true)][string]$VivadoBat,
    [string]$Part='xc7a200tfbg484-2',
    [double]$AnalysisClockNs=33.333,
    [ValidateSet(1,2)][int]$SynthesisThreads=1,
    [string]$BuildRoot=''
)
$ErrorActionPreference='Stop'
if($AnalysisClockNs -le 0 -or [double]::IsNaN($AnalysisClockNs) -or [double]::IsInfinity($AnalysisClockNs)){throw 'Analysis clock must be positive and finite'}
$repoRoot=(Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
if(!$BuildRoot){$BuildRoot=Join-Path $repoRoot 'build\vivado-system'}
$runDir=Join-Path $BuildRoot ([DateTime]::UtcNow.ToString('yyyyMMddTHHmmssfff')+'-'+[Guid]::NewGuid().ToString('N').Substring(0,8))
New-Item -ItemType Directory -Path $runDir -Force | Out-Null
$tcl=Join-Path $PSScriptRoot 'synth_system_ooc.tcl'
$sources=@('bppe_guarded_multiplier.sv','bppe_preprocess_core.sv','bppe_beat_core.sv','bppe_channel_core.sv','bppe_frame_dispatch.sv','bppe_acquisition_channels.sv','bppe_window_store.sv','bppe_rounded_divider.sv','bppe_measurement_core.sv','bppe_multichannel_prototype.sv')
$paths=@($sources | ForEach-Object {Join-Path 'rtl' $_})
$paths+=@('toolchain\synth_system_ooc.tcl','toolchain\run_system_vivado.ps1','toolchain\audit_system_ooc.ps1')
$hashes=@($paths | ForEach-Object {Get-FileHash -LiteralPath (Join-Path $repoRoot $_) -Algorithm SHA256})
@{part=$Part;top='bppe_multichannel_prototype';source_hashes=$hashes;profile='balanced defaults';channels='3 physically instantiated, runtime selection';analysis_clock_ns=$AnalysisClockNs;clock_applied='post-synthesis only';threads=$SynthesisThreads;implementation=$false;io_delays=$false;board_pins=$false} |
    ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $runDir 'source_manifest.json') -Encoding utf8
$log=Join-Path $runDir 'vivado.log'
$period=$AnalysisClockNs.ToString([Globalization.CultureInfo]::InvariantCulture)
Push-Location -LiteralPath $runDir
try {
    & $VivadoBat -mode batch -nojournal -notrace -log $log -source $tcl -tclargs (Join-Path $runDir 'synth') $Part $period $SynthesisThreads
    $exitCode=$LASTEXITCODE
    $text=Get-Content -LiteralPath $log -Raw
    if($exitCode -ne 0 -or !$text.Contains('BPPE_SYSTEM_OOC_SYNTHESIS_PASSED') -or $text -match '(?m)^ERROR:'){throw "Full-top OOC synthesis failed; inspect $log"}
    & (Join-Path $PSScriptRoot 'audit_system_ooc.ps1') -RunDirectory $runDir -RequireCapacity
    Write-Output "VIVADO_SYSTEM_OOC_CAPACITY_PASSED $runDir"
} finally {Pop-Location}
