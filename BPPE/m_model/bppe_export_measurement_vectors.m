function report=bppe_export_measurement_vectors(output_dir)
% Isolate bounded beat-window SQI/model gating/regression, preserving faults.
root=fileparts(mfilename('fullpath'));
if nargin<1, output_dir=fullfile(root,'artifacts','measurement-vectors'); end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
fid=fopen(fullfile(output_dir,'measurement_vectors.csv'),'w');
assert(fid>=0,'BPPE:Vectors','Cannot open measurement vectors.');
cleanup=onCleanup(@()fclose(fid));
fprintf(fid,['case,feature_f,regression_f,channels,primary,beats_limit,min_amplitude,max_amplitude,max_cv,sqi_threshold,' ...
    'configured,calibrated,demo_only,allow_demo,center,scale,beta,min_enabled,feature_min,max_enabled,feature_max,' ...
    'bp_min,bp_max,rejected,beats,before_faults,has_features,features,sqi,channel_sqi,reasons,valid,pressure_raw,codes,after_faults\n']);
report=struct('cases',0,'valid',0,'numeric_faults',0); seed=4208; rng(seed,'twister');
for name={'compact','balanced','wide'}
    p=bppe_fixed_profile(name{1}); one=2^p.feature_f; cfg=bppe_demo_config();
    nominal=round([0.8,0.25,0.33,0.30,0.04]*one);
    for channels=1:3
        cfg.channels=channels;
        for n=0:4
            beats=repmat({repmat(nominal,n,1)},1,channels);
            run_case(sprintf('channels_%d_n_%d',channels,n),cfg,p,beats,zeros(1,channels),[0 0 0]);
        end
    end
    cfg=bppe_demo_config(); full={repmat(nominal,4,1)};
    for delta=[-1 0 1]
        beats=full; beats{1}(:,5)=round(cfg.min_ac_dc*one)+delta;
        run_case(sprintf('min_amplitude_%d',delta),cfg,p,beats,0,[0 0 0]);
        beats=full; beats{1}(:,5)=round(cfg.max_ac_dc*one)+delta;
        run_case(sprintf('max_amplitude_%d',delta),cfg,p,beats,0,[0 0 0]);
    end
    run_case('rejected_beats',cfg,p,full,12,[0 0 0]);
    for mode=1:3
        c=cfg;
        if mode==1
            c.model.configured=false;
        elseif mode==2
            c.model.calibrated=false;
        else
            c.allow_demo_model=false;
        end
        run_case(sprintf('model_gate_%d',mode),c,p,full,0,[0 0 0]);
    end
    c=cfg; c.model.feature_min(1)=0.6; c.model.feature_max(1)=0.7;
    run_case('feature_envelope',c,p,full,0,[0 0 0]);
    c=cfg; c.model.scale(1)=1/(4*one);
    run_case('scale_underflow',c,p,full,0,[0 0 0]);
    c=cfg; c.model.scale(1)=1/one; c.model.center(1)=0;
    run_case('z_saturation',c,p,full,0,[0 0 0]);
    c=cfg; c.max_period_cv=1/(4*one);
    run_case('cv_threshold_underflow',c,p,full,0,[0 0 0]);
    beats=full; beats{1}(:,1)=0;
    run_case('zero_period_mean',cfg,p,beats,0,[0 0 0]);
    c=cfg; c.model.beta(1,:)=[120 120];
    run_case('pressure_order',c,p,full,0,[0 0 0]);
    c=cfg; c.model.beta(1,:)=[280 80];
    run_case('pressure_limits',c,p,full,0,[0 0 0]);
    c=cfg; c.model.beta(1,:)=[512 80];
    run_case('output_saturation',c,p,full,0,[0 0 0]);
    run_case('latched_saturation',cfg,p,full,0,[1 0 0]);
    run_case('latched_precision',cfg,p,full,0,[0 0 1]);
    c=cfg; c.beats_per_result=64;
    run_case('window_64',c,p,{repmat(nominal,64,1)},0,[0 0 0]);
    for trial=1:60
        c=cfg; c.channels=1+mod(trial,3); c.primary_channel=1+mod(trial,c.channels);
        beats=cell(1,c.channels);
        for k=1:c.channels
            values=repmat(nominal,4,1)+randi([-max(1,round(.015*one)),max(1,round(.015*one))],4,5);
            if mod(trial,2)==0, values(:,1)=randi([round(.35*one),round(1.5*one)],4,1); end
            values(:,5)=max(0,values(:,5)); beats{k}=values;
        end
        rejected=randi([0 2],1,c.channels);
        run_case(sprintf('seeded_%d',trial),c,p,beats,rejected,[0 0 0]);
    end
end
clear cleanup
parameters=report; parameters.seed=seed;
bppe_write_manifest(output_dir,'measurement-vectors',parameters);
fprintf('EXPORTED_MEASUREMENT_VECTORS cases=%d valid=%d numeric=%d\n',report.cases,report.valid,report.numeric_faults);

    function run_case(name,cfg,p,beats,rejected,seed_faults)
        cfg.model.extractor=bppe_extractor_signature(cfg);
        state=bppe_init_fixed(cfg,p); fx=state.fx; q=fx.math;
        q.saturation_count=q.saturation_count+seed_faults(1);
        q.divzero_count=q.divzero_count+seed_faults(2);
        q.precision_fault_count=q.precision_fault_count+seed_faults(3);
        for ch=1:cfg.channels, state.p.channel(ch).beats=beats{ch}; state.p.channel(ch).rejected_beats=rejected(ch); end
        before=[q.saturation_count,q.divzero_count,q.precision_fault_count];
        result=bppe_measurement_fixed(state.p,cfg,1,0,fx);
        has_features=all(isfinite(result.features)); features=zeros(1,5); pressure=zeros(1,2);
        if has_features, features=round(result.features*2^p.feature_f); end
        if result.result_valid, pressure=round([result.sbp,result.dbp]*2^p.regression_f); end
        lo=fx.feature_min; hi=fx.feature_max; lo_enabled=isfinite(lo); hi_enabled=isfinite(hi);
        lo(~lo_enabled)=0; hi(~hi_enabled)=0;
        beat_words=cell(1,cfg.channels);
        for ch=1:cfg.channels, beat_words{ch}=codes(beats{ch}.'); end
        meta=[p.feature_f,p.regression_f,cfg.channels,cfg.primary_channel,cfg.beats_per_result, ...
            fx.min_amplitude,fx.max_amplitude,fx.max_cv,cfg.sqi_threshold,cfg.model.configured, ...
            cfg.model.calibrated,cfg.model.demo_only,cfg.allow_demo_model];
        fprintf(fid,'%s_%s,',p.name,name); fprintf(fid,'%.0f,',meta);
        fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%d,%s,%d,%s,%d,%d,%s,%s,%s\n', ...
            codes(fx.center),codes(fx.scale),codes(fx.beta.'),codes(lo_enabled),codes(lo), ...
            codes(hi_enabled),codes(hi),codes(fx.bp_min),codes(fx.bp_max),codes(rejected), ...
            strjoin(beat_words,'|'),codes(before),has_features,codes(features),result.sqi, ...
            codes(result.channel_sqi),result.reason_flags,result.result_valid,codes(pressure), ...
            codes([result.sbp_uq9_7,result.dbp_uq9_7]),codes([q.saturation_count,q.divzero_count,q.precision_fault_count]));
        report.cases=report.cases+1; report.valid=report.valid+result.result_valid;
        report.numeric_faults=report.numeric_faults+q.failed();
    end
end
function text=codes(values)
if isempty(values), text='-'; else, text=strjoin(compose('%.0f',values(:)),';'); end
end
