param(
    [Parameter(Mandatory=$true)][string]$CompletedRun,
    [string]$BuildRoot=''
)
$ErrorActionPreference='Stop'
$repoRoot=Split-Path $PSScriptRoot -Parent
$audit=Join-Path $repoRoot 'toolchain\audit_system_impl.ps1'
$source=(Resolve-Path -LiteralPath $CompletedRun).Path
if(!$BuildRoot){$BuildRoot=Join-Path $repoRoot 'build\audit-regression'}
$run=Join-Path $BuildRoot ([DateTime]::UtcNow.ToString('yyyyMMddTHHmmssfff')+'-'+[Guid]::NewGuid().ToString('N').Substring(0,8))
$inputs=@('source_manifest.json','vivado.log','impl\timing_routed.rpt','impl\utilization.rpt',
    'impl\route_metrics.tsv','impl\drc_metrics.tsv','impl\clock_buffers.tsv')
$before=@($inputs | ForEach-Object {Get-FileHash -LiteralPath (Join-Path $source $_) -Algorithm SHA256})
foreach($case in @('positive','critical-warning')){
    $target=Join-Path $run $case
    New-Item -ItemType Directory -Path (Join-Path $target 'impl') | Out-Null
    foreach($rel in $inputs){Copy-Item -LiteralPath (Join-Path $source $rel) -Destination (Join-Path $target $rel)}
}
$positive=Join-Path $run 'positive'
& $audit -RunDirectory $positive | Out-Null
$result=Get-Content -LiteralPath (Join-Path $positive 'implementation_summary.json') -Raw | ConvertFrom-Json
if(!$result.internal_ooc_checks_passed -or $result.board_timing_signoff -or $result.tool_warnings_resolved){throw 'Positive audit or scope fields incorrect'}
$originalLog=Get-Content -LiteralPath (Join-Path $source 'vivado.log') -Raw
$expectedWarning=($originalLog -match '(?m)^WARNING: \[Constraints 18-8777\]')
if($result.constraints_18_8777_emitted -ne $expectedWarning){throw 'Diagnostic presence not preserved'}
$negative=Join-Path $run 'critical-warning'
Add-Content -LiteralPath (Join-Path $negative 'vivado.log') -Value "`nCRITICAL WARNING: [BPPE TEST-1] Deliberate audit rejection fixture." -Encoding utf8
$rejected=$false
try {& $audit -RunDirectory $negative | Out-Null}
catch {
    if($_.Exception.Message -notlike 'Implementation incomplete or contains Error/Critical Warning*'){throw}
    $rejected=$true
}
if(!$rejected -or (Test-Path -LiteralPath (Join-Path $negative 'implementation_summary.json'))){throw 'Critical log message was not rejected before producing a success summary'}
foreach($h in $before){if((Get-FileHash -LiteralPath $h.Path -Algorithm SHA256).Hash -ne $h.Hash){throw 'Original implementation evidence changed'}}
@{positive_passed=$true;critical_warning_rejected=$true;original_evidence_unchanged=$true;
    audit_sha256=(Get-FileHash -LiteralPath $audit -Algorithm SHA256).Hash;inputs=$before} |
    ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $run 'verification.json') -Encoding utf8
"IMPLEMENTATION_AUDIT_REGRESSION_PASSED $run"
