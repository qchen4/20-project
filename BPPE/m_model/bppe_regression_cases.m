function report = bppe_regression_cases()
% Fixed EXP-003 reproductions; engineering guards, not product accuracy limits.
cfg = bppe_demo_config();
clean = bppe_synthetic(cfg,32,struct('noise_std',0,'heart_rate_bpm',75));
kinds = {'white','impulsive','impulsive','impulsive','impulsive','impulsive'};
snr = [15,0,0,0,0,0]; seeds = [37,11,23,37,51,79];
rows = struct([]);
for k = 1:numel(kinds)
    frames = bppe_inject_noise(clean,cfg,kinds{k},snr(k),seeds(k));
    floating = bppe_run(frames,cfg);
    fixed = bppe_run(frames,cfg,true,bppe_fixed_profile());
    c = bppe_compare_candidates(floating,fixed);
    valid = fixed.results([fixed.results.result_valid]);
    if isempty(valid), errors = []; else
        features = vertcat(valid.features); errors = abs(60./features(:,1)-75);
    end
    row = struct('kind',kinds{k},'snr_db',snr(k),'seed',seeds(k), ...
        'matched',c.matched,'unmatched',c.unmatched_reference+c.unmatched_actual, ...
        'validity_mismatches',c.validity_mismatches,'reason_mismatches',c.reason_mismatches, ...
        'acceptance_mismatches',sum(floating.accepted~=fixed.accepted), ...
        'valid_pairs',c.valid_pairs, ...
        'bp_max',c.bp_max,'numeric_fault',fixed.state.fx.math.failed(), ...
        'total_reports',numel(fixed.results),'valid_reports',numel(valid), ...
        'valid_rate',NaN,'bad_hr_reports',sum(errors>5), ...
        'quality_status','no-observed-error');
    if row.total_reports>0, row.valid_rate = row.valid_reports/row.total_reports; end
    if isempty(valid), row.quality_status = 'no-valid-output'; end
    if row.bad_hr_reports>0, row.quality_status = 'known-gap'; end
    if isempty(rows), rows = row; else, rows(end+1) = row; end %#ok<AGROW>
end
report.detail = struct2table(rows);
% 0.1 mmHg is a regression ceiling for these six demo cases only.
% It intentionally does not extend the older "1 LSB" result to noisy input.
report.engineering_passed = all([rows.unmatched]==0) && ...
    all([rows.validity_mismatches]==0) && all([rows.acceptance_mismatches]==0) && ...
    ~any([rows.numeric_fault]) && ...
    all(isnan([rows.bp_max]) | [rows.bp_max]<0.1) && rows(1).valid_pairs>0;
report.known_quality_gap = any([rows.bad_hr_reports]>0);
report.scope = 'Six synthetic demo cases; no real blood pressure reference';
end
