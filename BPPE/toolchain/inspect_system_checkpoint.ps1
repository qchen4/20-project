param(
    [Parameter(Mandatory=$true)][string]$VivadoBat,
    [Parameter(Mandatory=$true)][string]$Checkpoint,
    [string]$ExpectedSha256='',
    [string]$BuildRoot=''
)
$ErrorActionPreference='Stop'
$inputFile=(Resolve-Path -LiteralPath $Checkpoint).Path
$tool=(Resolve-Path -LiteralPath $VivadoBat).Path
$before=(Get-FileHash -LiteralPath $inputFile -Algorithm SHA256).Hash
if($ExpectedSha256 -and $before -ne $ExpectedSha256){throw 'Checkpoint hash differs from expected evidence'}
if(!$BuildRoot){$BuildRoot=Join-Path (Split-Path $PSScriptRoot -Parent) 'build\checkpoint-inspection'}
$run=Join-Path $BuildRoot ([DateTime]::UtcNow.ToString('yyyyMMddTHHmmssfff')+'-'+[Guid]::NewGuid().ToString('N').Substring(0,8))
New-Item -ItemType Directory -Path $run | Out-Null
$tcl=Join-Path $PSScriptRoot 'inspect_system_checkpoint.tcl'
$scriptHashes=@($tcl,$PSCommandPath | ForEach-Object {Get-FileHash -LiteralPath $_ -Algorithm SHA256})
@{checkpoint=$inputFile;checkpoint_sha256=$before;tool=$tool;scripts=$scriptHashes;read_only_checkpoint=$true;board_signoff=$false} |
    ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $run 'inspection_manifest.json') -Encoding utf8
$log=Join-Path $run 'vivado.log'
Push-Location -LiteralPath $run
try {
    & $tool -mode batch -nojournal -notrace -log $log -source $tcl -tclargs $inputFile (Join-Path $run 'reports')
    $status=$LASTEXITCODE
} finally {
    Pop-Location
    $after=(Get-FileHash -LiteralPath $inputFile -Algorithm SHA256).Hash
    @{before=$before;after=$after;unchanged=($before -eq $after)} | ConvertTo-Json |
        Set-Content -LiteralPath (Join-Path $run 'checkpoint_integrity.json') -Encoding utf8
    if($before -ne $after){throw 'Checkpoint changed during inspection'}
}
$text=Get-Content -LiteralPath $log -Raw
if($status -ne 0 -or !$text.Contains('BPPE_CHECKPOINT_INSPECTION_COMPLETED') -or $text -match '(?m)^(ERROR|CRITICAL WARNING):'){
    throw "Checkpoint inspection failed; inspect $log"
}
$reports=Join-Path $run 'reports'
$context=[ordered]@{}
Import-Csv -LiteralPath (Join-Path $reports 'context.tsv') -Delimiter "`t" | ForEach-Object {$context[$_.metric]=[int]$_.value}
$timing=Get-Content -LiteralPath (Join-Path $reports 'timing.rpt') -Raw
$match=[regex]::Match($timing,'(?m)^\s*WNS\(ns\)[^\r\n]*\r?\n[^\r\n]*\r?\n([^\r\n]+)')
if(!$match.Success){throw 'Missing checkpoint timing summary'}
$values=$match.Groups[1].Value.Trim() -split '\s+'
if($values.Count -ne 12){throw 'Unexpected checkpoint timing summary shape'}
$n=@($values | ForEach-Object {[double]::Parse($_,[Globalization.CultureInfo]::InvariantCulture)})
function Timing-Count([string]$label){
    $m=[regex]::Match($timing,[regex]::Escape($label)+'\s*\((\d+)\)')
    if(!$m.Success){throw "Missing timing check $label"}; [int]$m.Groups[1].Value
}
$drc=@(Import-Csv -LiteralPath (Join-Path $reports 'drc.tsv') -Delimiter "`t")
$methodology=@(Import-Csv -LiteralPath (Join-Path $reports 'methodology.tsv') -Delimiter "`t")
$counts=@($methodology | Group-Object {($_.violation -split '#')[0]} | ForEach-Object {
    @{rule=$_.Name;reported_violations=$_.Count;severities=@($_.Group.severity | Sort-Object -Unique)}
})
$critical=@(($drc+$methodology) | Where-Object {$_.severity -in @('Error','Critical Warning')})
$internalChecks=($context.fully_routed -eq 1 -and $context.route_errors -eq 0 -and
    $n[0] -ge 0 -and $n[2] -eq 0 -and $n[4] -ge 0 -and $n[6] -eq 0 -and $n[8] -ge 0 -and $n[10] -eq 0 -and
    (Timing-Count 'no_clock') -eq 0 -and (Timing-Count 'unconstrained_internal_endpoints') -eq 0 -and $critical.Count -eq 0)
$summary=[ordered]@{
    checkpoint_sha256=$before;checkpoint_unchanged=$true;context=$context
    setup_wns_ns=$n[0];setup_tns_ns=$n[1];setup_failing_endpoints=$n[2]
    hold_whs_ns=$n[4];hold_ths_ns=$n[5];hold_failing_endpoints=$n[6]
    pulse_wpws_ns=$n[8];pulse_failing_endpoints=$n[10]
    no_clock=(Timing-Count 'no_clock');unconstrained_internal_endpoints=(Timing-Count 'unconstrained_internal_endpoints')
    inputs_without_delay=(Timing-Count 'no_input_delay');outputs_without_delay=(Timing-Count 'no_output_delay')
    drc=$drc;methodology_reported_counts=$counts;methodology_counts_may_be_capped=$true
    saved_internal_checks_passed=$internalChecks;implementation_warnings_resolved=$false
    boundary_routes_verified=$false;external_timing_verified=$false;board_timing_signoff=$false
}
$summary | ConvertTo-Json -Depth 7 | Set-Content -LiteralPath (Join-Path $run 'checkpoint_summary.json') -Encoding utf8
if(!$internalChecks){throw "Saved internal checks failed; inspect $run"}
"VIVADO_CHECKPOINT_INSPECTION_PASSED $run"
