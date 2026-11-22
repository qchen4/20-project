param([Parameter(Mandatory=$true)][string]$RunDirectory)
$ErrorActionPreference='Stop'
$run=(Resolve-Path -LiteralPath $RunDirectory).Path
$manifest=Get-Content -LiteralPath (Join-Path $run 'source_manifest.json') -Raw | ConvertFrom-Json
$log=Get-Content -LiteralPath (Join-Path $run 'vivado.log') -Raw
if(!$log.Contains('BPPE_INTERNAL_OOC_IMPLEMENTATION_COMPLETED') -or $log -match '(?m)^(ERROR|CRITICAL WARNING):'){throw 'Implementation incomplete or contains Error/Critical Warning; inspect vivado.log'}
$warningCounts=@([regex]::Matches($log,'(?m)^WARNING: \[([^\]]+)\]') | Group-Object {$_.Groups[1].Value} | ForEach-Object {
    @{diagnostic=$_.Name;emitted_lines=$_.Count}
})
$impl=Join-Path $run 'impl'
$timing=Get-Content -LiteralPath (Join-Path $impl 'timing_routed.rpt') -Raw
$util=Get-Content -LiteralPath (Join-Path $impl 'utilization.rpt') -Raw
$culture=[Globalization.CultureInfo]::InvariantCulture
$m=[regex]::Match($timing,'(?m)^\s*WNS\(ns\)[^\r\n]*\r?\n[^\r\n]*\r?\n([^\r\n]+)')
if(!$m.Success){throw 'Missing routed timing summary'}
$values=$m.Groups[1].Value.Trim() -split '\s+'
if($values.Count -ne 12){throw 'Unexpected min/max timing summary shape'}
$n=@($values | ForEach-Object {[double]::Parse($_,$culture)})
function Read-Resource([string]$Label){
    $pattern='\|\s*'+[regex]::Escape($Label)+'\*?\s*\|\s*([\d.]+)\s*\|\s*[\d.]+\s*\|\s*[\d.]+\s*\|\s*([\d.]+)\s*\|\s*([\d.]+)\s*\|'
    $x=[regex]::Match($util,$pattern)
    if(!$x.Success){throw "Missing resource $Label"}
    $used=[double]::Parse($x.Groups[1].Value,$culture);$available=[double]::Parse($x.Groups[2].Value,$culture)
    @{used=$used;available=$available;percent=[double]::Parse($x.Groups[3].Value,$culture);within_capacity=($used -le $available)}
}
function Read-Count([string]$Label){
    $x=[regex]::Match($timing,[regex]::Escape($Label)+'\s*\((\d+)\)')
    if(!$x.Success){throw "Missing timing check $Label"};[int]$x.Groups[1].Value
}
$resources=[ordered]@{LUT=(Read-Resource 'Slice LUTs');FF=(Read-Resource 'Slice Registers');DSP=(Read-Resource 'DSPs');BRAM_tile=(Read-Resource 'Block RAM Tile');latch=(Read-Resource 'Register as Latch')}
$route=[ordered]@{}
Import-Csv -LiteralPath (Join-Path $impl 'route_metrics.tsv') -Delimiter "`t" | ForEach-Object {$route[$_.metric]=[int]$_.value}
foreach($key in @('PLACED_FULLY','ROUTED_FULLY','ERRORS_IN_ROUTES','UNROUTED','PARTIAL','GAPS','CONFLICTS','HIERPORT')){if(!$route.Contains($key)){throw "Missing route metric $key"}}
$drc=@(Import-Csv -LiteralPath (Join-Path $impl 'drc_metrics.tsv') -Delimiter "`t")
$critical=@($drc | Where-Object {$_.severity -in @('Error','Critical Warning')})
$clockBuffers=@(Import-Csv -LiteralPath (Join-Path $impl 'clock_buffers.tsv') -Delimiter "`t")
$fit=$true;foreach($r in $resources.Values){$fit=$fit -and $r.within_capacity}
$internalPass=($fit -and $n[0] -ge 0 -and $n[2] -eq 0 -and $n[4] -ge 0 -and $n[6] -eq 0 -and $n[8] -ge 0 -and $n[10] -eq 0 -and $route.PLACED_FULLY -eq 1 -and $route.ROUTED_FULLY -eq 1 -and $route.ERRORS_IN_ROUTES -eq 0 -and $route.UNROUTED -eq 0 -and $route.PARTIAL -eq 0 -and $route.GAPS -eq 0 -and $route.CONFLICTS -eq 0 -and $critical.Count -eq 0 -and $clockBuffers.Count -eq 1 -and (Read-Count 'no_clock') -eq 0 -and (Read-Count 'unconstrained_internal_endpoints') -eq 0)
$summary=[ordered]@{
    part=$manifest.part;top=$manifest.top;clock_period_ns=$manifest.clock_period_ns;resources=$resources
    setup_wns_ns=$n[0];setup_tns_ns=$n[1];setup_failing_endpoints=$n[2]
    hold_whs_ns=$n[4];hold_ths_ns=$n[5];hold_failing_endpoints=$n[6]
    pulse_wpws_ns=$n[8];pulse_failing_endpoints=$n[10]
    route=$route;drc=$drc;clock_buffers=$clockBuffers;internal_ooc_checks_passed=$internalPass
    log_warning_counts=$warningCounts;warning_counts_may_be_capped=$true
    tool_warnings_resolved=$false
    constraints_18_8777_emitted=($log -match '(?m)^WARNING: \[Constraints 18-8777\]')
    no_clock=(Read-Count 'no_clock');unconstrained_internal_endpoints=(Read-Count 'unconstrained_internal_endpoints')
    inputs_without_delay=(Read-Count 'no_input_delay');outputs_without_delay=(Read-Count 'no_output_delay')
    placed_and_routed=$true;boundary_routes_verified=$false;external_timing_verified=$false
    oscillator_or_mmcm_verified=$false;board_pins_verified=$false;board_timing_signoff=$false
}
$summary | ConvertTo-Json -Depth 7 | Set-Content -LiteralPath (Join-Path $run 'implementation_summary.json') -Encoding utf8
[pscustomobject]$summary
if(!$internalPass){throw "Internal OOC audit did not pass; inspect reports and implementation_summary.json in $run"}
