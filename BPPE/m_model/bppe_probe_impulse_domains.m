function result=bppe_probe_impulse_domains(analysis_dir)
% Reproduce the observed shadow-study outliers in both unchanged domains.
% The fixed artifact selects cases; no production threshold is modified.
data=load(fullfile(analysis_dir,'impulse_analysis.mat'),'report');
report=data.report;cfg=report.config;p=bppe_fixed_profile();
bad=report.windows(report.windows.baseline_valid & report.windows.bad_hr_proxy,:);
rows=struct([]);
for k=1:height(bad)
    w=bad(k,:);s=report.runs(report.runs.case_id==w.case_id,:);
    clean=bppe_synthetic(cfg,32,struct('noise_std',0,'heart_rate_bpm',s.true_bpm));
    frames=bppe_inject_noise(clean,cfg,s.kind{1},s.snr_db,s.seed);
    floating=bppe_run(frames,cfg);fixed=bppe_run(frames,cfg,true,p);
    compared=bppe_compare_candidates(floating,fixed);
    fi=find(fixed.candidate_frame_index==w.frame);fl=find(floating.candidate_frame_index==w.frame);
    assert(isscalar(fi),'BPPE:Probe','Recorded fixed outlier boundary did not reproduce.');
    fixed_hr=60/fixed.candidates(fi).features(1);
    assert(fixed.candidates(fi).result_valid && abs(fixed_hr-w.hr_bpm)<1e-10, ...
        'BPPE:Probe','Recorded fixed outlier changed.');
    floating_hr=NaN;floating_sqi=NaN;floating_valid=false;
    if isscalar(fl)
        floating_hr=60/floating.candidates(fl).features(1);
        floating_sqi=double(floating.candidates(fl).sqi);floating_valid=floating.candidates(fl).result_valid;
    end
    row=struct('case_id',w.case_id,'true_bpm',s.true_bpm,'snr_db',s.snr_db,'seed',s.seed, ...
        'candidate_frame',w.frame,'fixed_hr',fixed_hr,'fixed_sqi',double(fixed.candidates(fi).sqi), ...
        'floating_boundary_matched',isscalar(fl),'floating_valid',floating_valid, ...
        'floating_hr',floating_hr,'floating_sqi',floating_sqi,'all_matched',compared.matched, ...
        'unmatched',compared.unmatched_reference+compared.unmatched_actual, ...
        'validity_mismatches',compared.validity_mismatches);
    if isempty(rows),rows=row;else,rows(end+1)=row;end %#ok<AGROW>
end
result=struct2table(rows);writetable(result,fullfile(analysis_dir,'domain_probe.csv'));disp(result);
fprintf('IMPULSE_DOMAIN_PROBE_PASSED outliers=%d\n',height(result));
end
