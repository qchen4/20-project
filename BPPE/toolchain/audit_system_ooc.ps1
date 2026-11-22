param([Parameter(Mandatory=$true)][string]$RunDirectory,[switch]$RequireCapacity)
$ErrorActionPreference='Stop'
$run=(Resolve-Path -LiteralPath $RunDirectory).Path
$manifest=Get-Content -LiteralPath (Join-Path $run 'source_manifest.json') -Raw | ConvertFrom-Json
$log=Get-Content -LiteralPath (Join-Path $run 'vivado.log') -Raw
if(!$log.Contains('BPPE_SYSTEM_OOC_SYNTHESIS_PASSED') -or $log -match '(?m)^ERROR:'){
    throw 'OOC batch analysis did not complete successfully; inspect vivado.log'
}
$util=Get-Content -LiteralPath (Join-Path $run 'synth\utilization.rpt') -Raw
$timing=Get-Content -LiteralPath (Join-Path $run 'synth\timing_synthesis_estimate.rpt') -Raw
$culture=[Globalization.CultureInfo]::InvariantCulture
function Read-Resource([string]$Label) {
    $pattern='\|\s*'+[regex]::Escape($Label)+'\*?\s*\|\s*([\d.]+)\s*\|\s*[\d.]+\s*\|\s*[\d.]+\s*\|\s*([\d.]+)\s*\|\s*([\d.]+)\s*\|'
    $m=[regex]::Match($util,$pattern)
    if(!$m.Success){throw "Missing utilization row: $Label"}
    $used=[double]::Parse($m.Groups[1].Value,$culture)
    $available=[double]::Parse($m.Groups[2].Value,$culture)
    @{used=$used;available=$available;percent=[double]::Parse($m.Groups[3].Value,$culture);within_capacity=($used -le $available)}
}
$resources=[ordered]@{LUT=(Read-Resource 'Slice LUTs');FF=(Read-Resource 'Slice Registers');DSP=(Read-Resource 'DSPs');BRAM_tile=(Read-Resource 'Block RAM Tile');latch=(Read-Resource 'Register as Latch')}
$fit=$true
foreach($resource in $resources.Values){$fit=$fit -and $resource.within_capacity}
$m=[regex]::Match($timing,'(?m)^\s*WNS\(ns\)[^\r\n]*\r?\n[^\r\n]*\r?\n\s*(-?[\d.]+)\s+(-?[\d.]+)\s+(\d+)\s+(\d+)')
if(!$m.Success){throw 'Missing setup timing summary'}
$wns=[double]::Parse($m.Groups[1].Value,$culture)
$tns=[double]::Parse($m.Groups[2].Value,$culture)
$failing=[int]$m.Groups[3].Value
function Read-PathField([string]$Label) {
    $x=[regex]::Match($timing,'(?m)^\s*'+[regex]::Escape($Label)+':\s*([^\r\n]+)')
    if(!$x.Success){throw "Missing critical-path field: $Label"}
    $x.Groups[1].Value.Trim()
}
function Read-CheckCount([string]$Label) {
    $x=[regex]::Match($timing,[regex]::Escape($Label)+'\s*\((\d+)\)')
    if(!$x.Success){throw "Missing timing check: $Label"}
    [int]$x.Groups[1].Value
}
$summary=[ordered]@{
    part=$manifest.part;top=$manifest.top;profile=$manifest.profile
    resources=$resources;fits_device_resource_capacity=$fit
    analysis_clock_ns=$manifest.analysis_clock_ns;clock_applied=$manifest.clock_applied
    setup_wns_ns=$wns;setup_tns_ns=$tns;setup_failing_endpoints=$failing
    analysis_setup_satisfied=($wns -ge 0 -and $failing -eq 0)
    critical_path=@{source=(Read-PathField 'Source');destination=(Read-PathField 'Destination');data_delay=(Read-PathField 'Data Path Delay');logic_levels=(Read-PathField 'Logic Levels')}
    no_clock=(Read-CheckCount 'no_clock');unconstrained_internal_endpoints=(Read-CheckCount 'unconstrained_internal_endpoints')
    inputs_without_delay=(Read-CheckCount 'no_input_delay');outputs_without_delay=(Read-CheckCount 'no_output_delay')
    implementation=$false;board_pins=$false;board_timing_signoff=$false
}
$summary | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $run 'resource_timing_summary.json') -Encoding utf8
[pscustomobject]$summary
if($RequireCapacity -and !$fit){
    $exceeded=@($resources.Keys | Where-Object {!$resources[$_].within_capacity} | ForEach-Object {"$_ $($resources[$_].used)/$($resources[$_].available)"}) -join ', '
    throw "Synthesized design exceeds target resource capacity: $exceeded. Reports and resource_timing_summary.json are preserved in $run"
}
