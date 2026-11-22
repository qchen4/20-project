param(
    [Parameter(Mandatory=$true)][string]$VivadoBat,
    [string]$Part='xc7a200tfbg484-2',
    [double]$ClockPeriodNs=33.333,
    [ValidateSet(1,2)][int]$Threads=1,
    [string]$BuildRoot=''
)
$ErrorActionPreference='Stop'
if($ClockPeriodNs -le 0 -or [double]::IsNaN($ClockPeriodNs) -or [double]::IsInfinity($ClockPeriodNs)){throw 'Positive finite clock period required'}
$repoRoot=(Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
if(!$BuildRoot){$BuildRoot=Join-Path $repoRoot 'build\vivado-system-implementation'}
$runDir=Join-Path $BuildRoot ([DateTime]::UtcNow.ToString('yyyyMMddTHHmmssfff')+'-'+[Guid]::NewGuid().ToString('N').Substring(0,8))
New-Item -ItemType Directory -Path $runDir -Force | Out-Null
$sources=@('bppe_guarded_multiplier.sv','bppe_preprocess_core.sv','bppe_beat_core.sv','bppe_channel_core.sv','bppe_frame_dispatch.sv','bppe_acquisition_channels.sv','bppe_window_store.sv','bppe_rounded_divider.sv','bppe_measurement_core.sv','bppe_multichannel_prototype.sv','bppe_ooc_clocked_top.sv')
$paths=@($sources | ForEach-Object {Join-Path 'rtl' $_})
$paths+=@('toolchain\implement_system_ooc.tcl','toolchain\run_system_impl.ps1','toolchain\audit_system_impl.ps1')
$hashes=@($paths | ForEach-Object {Get-FileHash -LiteralPath (Join-Path $repoRoot $_) -Algorithm SHA256})
@{part=$Part;top='bppe_ooc_clocked_top';profile='balanced defaults';source_hashes=$hashes;clock_period_ns=$ClockPeriodNs;threads=$Threads;clock_buffer='internal BUFG, tool placed';synthesis_clock='post-synthesis';implementation=$true;boundary_routes=$false;io_delays=$false;board_pins=$false;board_signoff=$false} |
    ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $runDir 'source_manifest.json') -Encoding utf8
$log=Join-Path $runDir 'vivado.log'
$period=$ClockPeriodNs.ToString([Globalization.CultureInfo]::InvariantCulture)
Push-Location -LiteralPath $runDir
try {
    & $VivadoBat -mode batch -nojournal -notrace -log $log -source (Join-Path $PSScriptRoot 'implement_system_ooc.tcl') -tclargs (Join-Path $runDir 'impl') $Part $period $Threads
    $status=$LASTEXITCODE
    $text=Get-Content -LiteralPath $log -Raw
    if($status -ne 0 -or !$text.Contains('BPPE_INTERNAL_OOC_IMPLEMENTATION_COMPLETED') -or $text -match '(?m)^ERROR:'){throw "Internal OOC implementation failed; inspect $log"}
    & (Join-Path $PSScriptRoot 'audit_system_impl.ps1') -RunDirectory $runDir
    "VIVADO_INTERNAL_OOC_AUDIT_PASSED $runDir"
} finally {Pop-Location}
