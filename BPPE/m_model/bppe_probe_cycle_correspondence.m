function report=bppe_probe_cycle_correspondence(study_dir,output_dir)
% Bounded diagnostic of observed EXP-029 failures, NOT fresh validation.
% No thresholds, gating, production kernels or controller state are changed.
root=fileparts(mfilename('fullpath'));
if nargin<2,output_dir=fullfile(root,'artifacts','cycle-correspondence');end
assert(~exist(fullfile(output_dir,'run_metadata.json'),'file'),'BPPE:OutputExists','Use a new output directory.');
if ~exist(output_dir,'dir'),mkdir(output_dir);end
P=jsondecode(fileread(fullfile(study_dir,'frozen_protocol.json')));
assert(strcmp(hashfile(fullfile(study_dir,'frozen_protocol.json')), ...
    '788eef12e38a0924080916ace4e3b52468330fd482b1623050f08e9257cca991'),'BPPE:Protocol','Unexpected frozen study.');
old_sources=readtable(fullfile(study_dir,'source_manifest.csv'),'TextType','string');
for k=1:height(old_sources)
    path=fullfile(root,extractAfter(old_sources.Path(k),'m_model/'));
    assert(strcmp(hashfile(path),old_sources.SHA256(k)),'BPPE:Provenance','Original model source changed.');
end
R=readtable(fullfile(study_dir,'runs.csv'),'TextType','string');
E=readtable(fullfile(study_dir,'candidate_windows.csv'),'TextType','string');
bad_ids=unique(E.case_id(logical(E.baseline_valid)&logical(E.bad_hr_proxy)))';
assert(isequal(bad_ids,[45 62 274 291 308 325]),'BPPE:Study','Unexpected observed counterexamples.');
ids=bad_ids;clean_ids=zeros(size(bad_ids));
for k=1:numel(bad_ids)
    r=R(R.case_id==bad_ids(k),:);
    clean=R(R.pattern==r.pattern&R.shape==r.shape&R.amplitude==r.amplitude&R.kind=="clean",:);
    assert(height(clean)==1,'BPPE:Study','Ambiguous matched clean input.');
    clean_ids(k)=clean.case_id;ids(end+1)=clean.case_id; %#ok<AGROW>
end
ids=unique(ids);assert(numel(ids)==12,'BPPE:Study','Expected six failures and six clean controls.');
input_hashes=struct('protocol',hashfile(fullfile(study_dir,'frozen_protocol.json')), ...
    'runs',hashfile(fullfile(study_dir,'runs.csv')),'windows',hashfile(fullfile(study_dir,'candidate_windows.csv')), ...
    'sources',hashfile(fullfile(study_dir,'source_manifest.csv')));
bppe_write_manifest(output_dir,'observed-cycle-correspondence',struct('cases',ids, ...
    'input_hashes',input_hashes,'production_changed',false,'fresh_validation',false));
cfg=bppe_demo_config();p=bppe_fixed_profile();
all_beats=struct([]);all_windows=struct([]);all_crossings=struct([]);float_rows=struct([]);traces=table();
selected=R(ismember(R.case_id,ids),:);selected.clean_case_id=zeros(height(selected),1);
selected.is_error_case=ismember(selected.case_id,bad_ids);
for ci=1:height(selected)
    r=selected(ci,:);case_id=r.case_id;
    if r.is_error_case,clean_id=clean_ids(bad_ids==case_id);else,clean_id=case_id;end
    selected.clean_case_id(ci)=clean_id;
    s=struct('pattern',char(r.pattern),'shape',char(r.shape),'amplitude',r.amplitude, ...
        'dynamic',logical(r.is_dynamic),'bpm',NaN,'kind',char(r.kind),'snr_db',r.snr_db, ...
        'seed',r.seed,'split','observed_diagnostic');
    if ~s.dynamic,s.bpm=str2double(extractAfter(s.pattern,'constant'));end
    [clean,time,phase]=make_signal(cfg,P,s);
    if r.is_clean,frames=clean;else,frames=bppe_inject_noise(clean,cfg,s.kind,s.snr_db,s.seed);end
    raw=[uint32(vertcat(frames.ppg)),uint32(vertcat(frames.timestamp)),uint32([frames.frame_seq]')];
    assert(strcmp(sha256(typecast(raw(:),'uint8')),r.input_sha256_le_u32_columns), ...
        'BPPE:Reproduction','Input bytes differ from EXP-029.');
    actual=bppe_run(frames,cfg,true,p);
    assert(all(actual.accepted)&&~actual.state.fx.math.failed(),'BPPE:Domain','Unexpected input/numeric fault.');
    [w,b]=bppe_shadow_reconstruct(actual,frames,cfg,p,s,case_id);
    expected=E(E.case_id==case_id,:);
    assert(isequal([w.frame]',expected.frame)&&isequal(double([w.sqi]'),expected.sqi)&& ...
        isequal(double([w.baseline_valid]'),double(expected.baseline_valid))&& ...
        isequal([w.reason]',expected.reason),'BPPE:Reproduction','Candidate behavior changed.');
    finite=isfinite(expected.hr_bpm);
    assert(isequal(isfinite([w.hr_bpm]'),finite)&&all(abs([w(finite).hr_bpm]'-expected.hr_bpm(finite))<1e-9), ...
        'BPPE:Reproduction','Candidate period changed.');
    x=crossings(actual,b,cfg,p,case_id,time,phase);
    if isempty(all_beats),all_beats=b;all_windows=w;all_crossings=x;
    else,all_beats=[all_beats b];all_windows=[all_windows w];all_crossings=[all_crossings x];end %#ok<AGROW>
    n=numel(frames);
    T=table(repmat(case_id,n,1),(1:n)',time,phase,double(raw(:,1)),actual.trace.filtered(:), ...
        'VariableNames',{'case_id','frame','time_s','phase','adc','filtered'});
    traces=[traces;T]; %#ok<AGROW>
    floating=bppe_run(frames,cfg);
    assert(~isfield(floating.state,'fx')&&isfield(actual.state,'fx'), ...
        'BPPE:Domain','Floating and fixed runs must use distinct numeric domains.');
    assert(all(floating.accepted),'BPPE:Domain','Floating input rejection.');
    for k=1:numel(floating.candidates)
        candidate=floating.candidates(k);hr=NaN;
        if all(isfinite(candidate.features)),hr=60/candidate.features(1);end
        row=struct('case_id',case_id,'candidate',k,'frame',floating.candidate_frame_index(k), ...
            'baseline_valid',candidate.result_valid,'reason',double(candidate.reason_flags), ...
            'sqi',double(candidate.sqi),'hr_bpm',hr);
        if isempty(float_rows),float_rows=row;else,float_rows(end+1)=row;end %#ok<AGROW>
    end
    fprintf('CYCLE_PROBE_CASE %d/12 case=%d clean=%d frames=%d beats=%d crossings=%d candidates=%d float_candidates=%d\n', ...
        ci,case_id,clean_id,n,numel(b),numel(x),numel(w),numel(floating.candidates));
end
writetable(selected,fullfile(output_dir,'runs.csv'));
writetable(struct2table(all_beats),fullfile(output_dir,'beats.csv'));
writetable(struct2table(all_windows),fullfile(output_dir,'windows.csv'));
writetable(struct2table(all_crossings),fullfile(output_dir,'crossings.csv'));
writetable(struct2table(float_rows),fullfile(output_dir,'float_candidates.csv'));
writetable(traces,fullfile(output_dir,'traces.csv'));
copyfile(fullfile(study_dir,'candidate_windows.csv'),fullfile(output_dir,'observed_study_windows.csv'));
copyfile(fullfile(study_dir,'frozen_protocol.json'),fullfile(output_dir,'frozen_protocol.json'));
report=struct('cases',ids,'frames',height(traces),'beats',numel(all_beats),'crossings',numel(all_crossings), ...
    'candidates',numel(all_windows),'source_inputs',input_hashes);
save(fullfile(output_dir,'probe_metadata.mat'),'report');
fprintf('CYCLE_PROBE_PASSED cases=%d frames=%d beats=%d crossings=%d candidates=%d\n', ...
    numel(ids),height(traces),numel(all_beats),numel(all_crossings),numel(all_windows));
end

function x=crossings(run,b,cfg,p,case_id,time,phase)
initial=bppe_init_fixed(cfg,p);q=initial.fx.math;
y=round(run.trace.filtered(:)*2^p.signal_f);step=1e9/cfg.fs_hz/cfg.tick_period_ns*2^p.time_f;
x=struct([]);
for n=2:numel(y)
    if time(n)>=cfg.warmup_s&&y(n-1)<=0&&y(n)>0
        raw=(n-2)*step+q.divide(q.mul(-y(n-1),step),y(n)-y(n-1));
        tc=raw/2^p.time_f*cfg.tick_period_ns*1e-9;
        emitted=find([b.frame]==n);accepted=~isempty(emitted);
        if accepted,assert(abs(b(emitted).end_s-tc)<1e-12,'BPPE:Crossing','Closing crossing mismatch.');end
        row=struct('case_id',case_id,'crossing',numel(x)+1,'frame',n,'time_s',tc, ...
            'phase',interp1(time,phase,tc),'accepted_closing',accepted);
        if isempty(x),x=row;else,x(end+1)=row;end %#ok<AGROW>
    end
end
assert(~q.failed(),'BPPE:Crossing','Crossing observation numeric fault.');
end

function hash=hashfile(path)
fid=fopen(path,'rb');assert(fid>=0,'BPPE:File','Cannot read source.');
cleanup=onCleanup(@()fclose(fid));bytes=fread(fid,Inf,'*uint8');clear cleanup
hash=sha256(bytes);
end

function hash=sha256(bytes)
digest=javaMethod('getInstance','java.security.MessageDigest','SHA-256');digest.update(typecast(bytes(:),'int8'));
hash=lower(reshape(dec2hex(typecast(digest.digest(),'uint8'),2).',1,[]));
end

% Generator copied verbatim from frozen EXP-029; input hashes checked.
function [frames,t,phase]=make_signal(cfg,P,s)
frames=bppe_synthetic(cfg,P.duration_s,struct('noise_std',0));n=numel(frames);t=(0:n-1)'/cfg.fs_hz;
if ~s.dynamic
    rate=repmat(s.bpm,n,1);
elseif strcmp(s.pattern,'ramp55to140')
    rate=55+85*min(1,max(0,(t-P.ramp_start_s)/(P.ramp_end_s-P.ramp_start_s)));
elseif strcmp(s.pattern,'step85to125')
    rate=85+40*(t>=P.step_time_s);
else
    error('BPPE:Protocol','Unknown pattern.');
end
% Left-constant rate on each sample interval. Linear interpolation of phase
% is therefore the exact generator reference between sample timestamps.
phase=cumsum([0;rate(1:end-1)/(60*cfg.fs_hz)]);fraction=mod(phase,1);shape=P.([s.shape '_shape']);
pulse=exp(-0.5*((fraction-shape.main_center)/shape.main_width).^2)+ ...
    shape.bump_gain*exp(-0.5*((fraction-shape.bump_center)/shape.bump_width).^2);
raw=P.baseline_adc+s.amplitude*pulse;
assert(all(raw>=0&raw<=2^24-1),'BPPE:StudyDomain','Clean input clipping.');
for k=1:n,frames(k).ppg=round(raw(k));frames(k).channel_saturated=false;end
end
