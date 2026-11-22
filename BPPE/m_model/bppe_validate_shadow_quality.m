function report=bppe_validate_shadow_quality(output_dir,enable_morphology)
% Frozen offline experiment. Does not change production state or validity.
% Calling without the second argument leaves the morphology gate disabled.
root=fileparts(mfilename('fullpath'));
if nargin<1,output_dir=fullfile(root,'artifacts','fresh-shadow-validation');end
if nargin<2,enable_morphology=false;end
assert(islogical(enable_morphology)&&isscalar(enable_morphology),'BPPE:ShadowInput','Scalar logical required.');
protocol_path=fullfile(root,'experiments','shadow_quality_protocol.json');
protocol=jsondecode(fileread(protocol_path));
assert(isempty(intersect(protocol.fresh_seeds,protocol.previously_used_seeds)) && ...
    protocol.morphology_cv_limit==0.20 && protocol.comparison_sqi_minimum==200 && ...
    ~protocol.morphology_enabled_by_default,'BPPE:Protocol','Frozen protocol changed.');
assert(~exist(fullfile(output_dir,'run_metadata.json'),'file'),'BPPE:OutputExists','Use a new output directory.');
if ~exist(output_dir,'dir'),mkdir(output_dir);end
copyfile(protocol_path,fullfile(output_dir,'frozen_protocol.json'));
protocol_hash=sha256(uint8(fileread(protocol_path)));
bppe_write_manifest(output_dir,'fresh-shadow-validation',struct('protocol_sha256',protocol_hash, ...
    'enable_morphology',enable_morphology,'production_changed',false));
cfg=bppe_demo_config();p=bppe_fixed_profile();
assert(cfg.channels==protocol.channels && cfg.fs_hz==protocol.fs_hz && strcmp(p.name,protocol.profile), ...
    'BPPE:Protocol','Unexpected model configuration.');
spec=make_cases(protocol);assert(numel(spec)==protocol.expected_total_runs,'BPPE:Protocol','Case count mismatch.');
windows=struct([]);runs=struct([]);case_gates=struct([]);
for case_id=1:numel(spec)
    s=spec(case_id);[clean,time,phase]=make_signal(cfg,protocol,s);
    noise=struct('realized_snr_db',Inf,'clipped_samples',0);
    if strcmp(s.kind,'clean'),frames=clean;
    else,[frames,noise]=bppe_inject_noise(clean,cfg,s.kind,s.snr_db,s.seed);end
    assert(noise.clipped_samples==0,'BPPE:StudyDomain','Input clipping: retain evidence and investigate.');
    actual=bppe_run(frames,cfg,true,p);
    assert(all(actual.accepted)&&~actual.state.fx.math.failed(),'BPPE:StudyDomain','Rejected input or numeric fault.');
    [w,b]=bppe_shadow_reconstruct(actual,frames,cfg,p,s,case_id);
    for k=1:numel(w)
        w(k).pattern=s.pattern;w(k).shape=s.shape;w(k).amplitude=s.amplitude;
        w(k).is_clean=strcmp(s.kind,'clean');w(k).is_dynamic=s.dynamic;
        last=NaN;reference=NaN;
        if w(k).count>0
            last=b(w(k).last_beat).end_s;first=w(k).window_start_s;
            assert(first>=time(1)&&last<=time(end)&&last>first,'BPPE:Truth','Window outside generated phase.');
            reference=60*(interp1(time,phase,last)-interp1(time,phase,first))/(last-first);
        end
        w(k).window_end_s=last;w(k).reference_hr_bpm=reference;
        w(k).hr_error_bpm=abs(w(k).hr_bpm-reference);
        w(k).bad_hr_proxy=w(k).hr_error_bpm>protocol.error_proxy_bpm;
        assert(~w(k).baseline_valid||isfinite(w(k).hr_error_bpm),'BPPE:Truth','Valid candidate has no reference.');
    end
    valid=logical([w.baseline_valid]);bad=logical([w.bad_hr_proxy]);cv=[w.morphology_cv_max];
    assert(isequal(bppe_shadow_morphology(valid,cv),valid),'BPPE:ShadowDefault','Default altered validity.');
    keeps=[valid(:),valid(:)&[w.sqi]'>=protocol.comparison_sqi_minimum, ...
        bppe_shadow_morphology(valid(:),cv(:),enable_morphology)];
    names={'baseline','sqi200','morph020'};
    for gate=1:3
        keep=keeps(:,gate)';times=[w(keep).time_s];gaps=diff([0 times protocol.duration_s]);
        row=struct('case_id',case_id,'gate',names{gate},'pattern',s.pattern,'shape',s.shape, ...
            'amplitude',s.amplitude,'kind',s.kind,'snr_db',s.snr_db,'seed',s.seed, ...
            'is_clean',strcmp(s.kind,'clean'),'is_dynamic',s.dynamic, ...
            'baseline_valid',sum(valid),'baseline_bad',sum(valid&bad),'retained',sum(keep), ...
            'retained_bad',sum(keep&bad),'removed_low_error',sum(valid&~bad&~keep), ...
            'max_no_report_s',max(gaps),'zero_report',~any(keep));
        if isempty(case_gates),case_gates=row;else,case_gates(end+1)=row;end %#ok<AGROW>
    end
    raw=[uint32(vertcat(frames.ppg)),uint32(vertcat(frames.timestamp)),uint32([frames.frame_seq]')];
    r=struct('case_id',case_id,'pattern',s.pattern,'shape',s.shape,'amplitude',s.amplitude, ...
        'kind',s.kind,'snr_db',s.snr_db,'seed',s.seed,'is_clean',strcmp(s.kind,'clean'), ...
        'is_dynamic',s.dynamic,'frames',numel(frames),'candidates',numel(w), ...
        'baseline_valid',sum(valid),'baseline_bad',sum(valid&bad), ...
        'realized_snr_db',noise.realized_snr_db,'clipped_samples',noise.clipped_samples, ...
        'input_sha256_le_u32_columns',sha256(typecast(raw(:),'uint8')));
    if isempty(runs),runs=r;windows=w;else,runs(end+1)=r;windows=[windows w];end %#ok<AGROW>
    fprintf('SHADOW_CASE %d/%d %s %s amp=%g %s snr=%g seed=%d candidates=%d valid=%d bad=%d\n', ...
        case_id,numel(spec),s.pattern,s.shape,s.amplitude,s.kind,s.snr_db,s.seed,numel(w),sum(valid),sum(valid&bad));
    if mod(case_id,24)==0||case_id==numel(spec)
        writetable(struct2table(runs),fullfile(output_dir,'runs.csv'));
        writetable(struct2table(windows),fullfile(output_dir,'candidate_windows.csv'));
        writetable(struct2table(case_gates),fullfile(output_dir,'per_run_gates.csv'));
    end
end
R=struct2table(runs);W=struct2table(windows);C=struct2table(case_gates);
assert(height(R)==protocol.expected_total_runs&&sum(R.frames)==protocol.expected_total_frames && ...
    sum(R.is_clean)==protocol.expected_clean_runs,'BPPE:Protocol','Incomplete matrix.');
G=summarize(C);writetable(G,fullfile(output_dir,'summary.csv'));
report=struct('protocol',protocol,'protocol_sha256',protocol_hash,'morphology_enabled',enable_morphology, ...
    'runs',R,'windows',W,'per_run_gates',C,'summary',G);
save(fullfile(output_dir,'shadow_validation.mat'),'report');
fprintf('SHADOW_VALIDATION_PASSED cases=%d frames=%d candidates=%d baseline_valid=%d baseline_bad=%d enabled=%d\n', ...
    height(R),sum(R.frames),height(W),sum(W.baseline_valid),sum(W.baseline_valid&W.bad_hr_proxy),enable_morphology);
end

function spec=make_cases(P)
spec=struct([]);
for pi=1:numel(P.patterns)
    pattern=P.patterns{pi};dynamic=~startsWith(pattern,'constant');bpm=NaN;
    if ~dynamic,bpm=str2double(extractAfter(pattern,'constant'));end
    for sh=1:numel(P.shapes)
        for amplitude=P.amplitudes(:)'
            add('clean',Inf,0);
            for seed=P.fresh_seeds(:)'
                for ni=1:numel(P.noise_kinds),add(P.noise_kinds{ni},P.noise_snr_db(ni),seed);end
            end
        end
    end
end
    function add(kind,snr,seed)
        s=struct('pattern',pattern,'shape',P.shapes{sh},'amplitude',amplitude, ...
            'dynamic',dynamic,'bpm',bpm,'kind',kind,'snr_db',snr,'seed',seed,'split','fresh');
        if isempty(spec),spec=s;else,spec(end+1)=s;end
    end
end

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

function G=summarize(C)
strata={'all','clean','noisy','constant','dynamic','clean_constant','clean_dynamic', ...
    'noisy_constant','noisy_dynamic','impulse0','impulse6','white15','motion15','original','broad'};
rows=struct([]);
for k=1:numel(strata)
    switch strata{k}
        case 'all',mask=true(height(C),1);
        case 'clean',mask=C.is_clean;
        case 'noisy',mask=~C.is_clean;
        case 'constant',mask=~C.is_dynamic;
        case 'dynamic',mask=C.is_dynamic;
        case 'clean_constant',mask=C.is_clean&~C.is_dynamic;
        case 'clean_dynamic',mask=C.is_clean&C.is_dynamic;
        case 'noisy_constant',mask=~C.is_clean&~C.is_dynamic;
        case 'noisy_dynamic',mask=~C.is_clean&C.is_dynamic;
        case 'impulse0',mask=strcmp(C.kind,'impulsive')&C.snr_db==0;
        case 'impulse6',mask=strcmp(C.kind,'impulsive')&C.snr_db==6;
        case 'white15',mask=strcmp(C.kind,'white');
        case 'motion15',mask=strcmp(C.kind,'periodic_motion');
        otherwise,mask=strcmp(C.shape,strata{k});
    end
    for gate={'baseline','sqi200','morph020'}
        T=C(mask&strcmp(C.gate,gate{1}),:);
        row=struct('stratum',strata{k},'gate',gate{1},'runs',height(T), ...
            'baseline_valid',sum(T.baseline_valid),'baseline_bad',sum(T.baseline_bad), ...
            'retained',sum(T.retained),'retained_bad',sum(T.retained_bad), ...
            'removed_low_error',sum(T.removed_low_error),'zero_report_runs',sum(T.zero_report), ...
            'median_run_max_no_report_s',median(T.max_no_report_s),'maximum_no_report_s',max(T.max_no_report_s));
        if isempty(rows),rows=row;else,rows(end+1)=row;end %#ok<AGROW>
    end
end
G=struct2table(rows);
end

function hash=sha256(bytes)
digest=javaMethod('getInstance','java.security.MessageDigest','SHA-256');
digest.update(typecast(bytes(:),'int8'));
hash=lower(reshape(dec2hex(typecast(digest.digest(),'uint8'),2).',1,[]));
end
