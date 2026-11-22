function report=bppe_export_pipeline_vectors(output_dir)
% Accepted ADC-to-feature observations; frame validation and SQI are outside.
root=fileparts(mfilename('fullpath'));
if nargin<1, output_dir=fullfile(root,'artifacts','pipeline-vectors'); end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
fid=fopen(fullfile(output_dir,'pipeline_vectors.mem'),'w');
assert(fid>=0,'BPPE:Vectors','Cannot open pipeline vectors.');
cleanup=onCleanup(@()fclose(fid));
report=struct('rows',0,'cases',0,'beats',0,'fault_observations',0);
for name={'compact','balanced','wide'}
    p=bppe_fixed_profile(name{1}); cfg=bppe_default_config();
    run_case('zero',cfg,p,zeros(128,1),[],{});
    run_case('maximum',cfg,p,repmat(2^24-1,128,1),[],{});
    run_case('steps',cfg,p,repmat([zeros(32,1);repmat(2^24-1,32,1)],4,1),[],{});
    source_cfg=cfg; source_cfg.channels=3; frames=bppe_synthetic(source_cfg,16);
    samples=vertcat(frames.ppg);
    for channel=1:3, run_case(sprintf('synthetic_%d',channel),cfg,p,samples(:,channel),[],{}); end
    frames=bppe_synthetic(cfg,8); samples=vertcat(frames.ppg);
    run_case('jitter',cfg,p,samples,(0:numel(samples)-1)'*10+repmat([0;1;-1;0],200,1),{});
    run_case('warmup_sideband',cfg,p,repmat([1000;2000;3000;1000],64,1),repmat([1990;2000;2010;1990],64,1),{});
    limit=2^(47-p.time_f);
    ticks=[0;1;limit-1;limit;limit+1;1;2;3;0;2^53;0;0];
    actions=repmat({'sample'},12,1); actions{6}='clear'; actions{9}='reset'; actions{11}='clear'; actions{12}='reset';
    run_case('time_recovery',cfg,p,zeros(12,1),ticks,actions);
    cfg.dc_cutoff_hz=1e-7; cfg.lowpass_hz=2e-7;
    run_case('zero_coefficients',cfg,p,repmat([1000;2000;0;2^24-1],32,1),[],{});
end
clear cleanup
bppe_write_manifest(output_dir,'channel-pipeline-vectors',report);
fprintf('EXPORTED_PIPELINE_VECTORS rows=%d cases=%d beats=%d\n',report.rows,report.cases,report.beats);

    function run_case(name,cfg,p,values,ticks,actions)
        if isempty(ticks), ticks=(0:numel(values)-1)'*10; end
        if isempty(actions), actions=repmat({'sample'},numel(values),1); end
        state=bppe_init_fixed(cfg,p); c=state.p.channel; fx=state.fx;
        assert(~fx.math.failed(),'BPPE:Vectors','Unexpected host configuration fault.');
        report.cases=report.cases+1;
        for k=1:numel(values)
            if strcmp(actions{k},'clear')
                processing=bppe_processing_init(cfg); c=processing.channel;
            elseif strcmp(actions{k},'reset')
                state=bppe_init_fixed(cfg,p); c=state.p.channel; fx=state.fx;
            end
            [c,beat]=bppe_channel_fixed(c,values(k),ticks(k),cfg,fx);
            features=zeros(1,5); beat_time=0;
            if ~isempty(beat), features=beat; beat_time=c.beat_times(end); end
            words=[report.cases,k,strcmp(actions{k},'clear')+2*strcmp(actions{k},'reset'), ...
                p.signal_f,p.time_f,p.feature_f,fx.a,fx.b,cfg.tick_period_ns,fx.min_period,fx.max_period, ...
                round(cfg.max_period_s*1e9/cfg.tick_period_ns*2^p.time_f), ...
                ceil(2*cfg.fs_hz*cfg.max_period_s)+4,values(k),ticks(k), ...
                ticks(k)*cfg.tick_period_ns<round(cfg.warmup_s*1e9),c.dc,c.y,c.previous_t, ...
                c.previous_y,c.previous_t,c.tracking,c.rejected_beats,numel(c.cycle_t), ...
                ~isempty(beat),features,beat_time,fx.math.saturation_count,fx.math.divzero_count,fx.math.precision_fault_count];
            buffers=[c.cycle_t;c.cycle_y]; all_words=[words,buffers(:).'];
            hex=cellstr(dec2hex(typecast(int64(all_words),'uint64'),16));
            fprintf(fid,'%s\n',strjoin(hex,' '));
            report.rows=report.rows+1; report.beats=report.beats+~isempty(beat);
            report.fault_observations=report.fault_observations+fx.math.failed();
        end
        fprintf('PIPELINE_CASE %s_%s\n',p.name,name);
    end
end
