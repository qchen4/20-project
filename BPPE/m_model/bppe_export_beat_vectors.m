function report = bppe_export_beat_vectors(output_dir)
% Full downstream state observations, plus ADC-to-feature integration cases.
root=fileparts(mfilename('fullpath'));
if nargin<1, output_dir=fullfile(root,'artifacts','beat-vectors'); end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
fid=fopen(fullfile(output_dir,'beat_vectors.csv'),'w');
assert(fid>=0,'BPPE:Vectors','Cannot open beat vectors.');
cleanup=onCleanup(@()fclose(fid));
mem=fopen(fullfile(output_dir,'beat_vectors.mem'),'w');
assert(mem>=0,'BPPE:Vectors','Cannot open beat RTL vectors.');
mem_cleanup=onCleanup(@()fclose(mem));
fprintf(fid,['case,frame,action,kind,signal_f,time_f,feature_f,tick_ns,min_period,max_period,' ...
    'max_ticks,capacity,beats_limit,a,b,ticks,input,dc,time,warmup,previous_y,previous_t,' ...
    'tracking,rejected,cycle_t,cycle_y,beat_times,beats,emitted,features,saturations,divzero,precision\n']);
report=struct('rows',0,'cases',0,'emitted',0,'rejections',0,'fault_observations',0);
for name={'compact','balanced','wide'}
    p=bppe_fixed_profile(name{1}); cfg=bppe_default_config(); cfg.warmup_s=0;
    for period=[20 35 80 150 151]
        phase=(0:period-1)'/period;
        wave=round(1000*sin(2*pi*phase)); wave(1)=0;
        y=repmat(wave,12,1)*2^p.signal_f;
        run_case(sprintf('sine_%d',period),'filtered',cfg,p,y,[],repmat(100000*2^p.signal_f,size(y)),{});
    end
    y=repmat([0;100;100;50;0;-100;0;100;50;0;-100],70,1)*2^p.signal_f;
    run_case('tied_peaks','filtered',cfg,p,y,(0:numel(y)-1)'*50,ones(size(y))*100000*2^p.signal_f,{});
    y=repmat([0;100;0;-100],100,1)*2^p.signal_f;
    run_case('nonpositive_dc','filtered',cfg,p,y,(0:numel(y)-1)'*200,zeros(size(y)),{});
    run_case('ratio_saturation','filtered',cfg,p,y,(0:numel(y)-1)'*200,ones(size(y)),{});
    y=[-1;ones(310,1)]*2^p.signal_f;
    run_case('buffer_limit','filtered',cfg,p,y,zeros(size(y)),ones(size(y))*2^p.signal_f,{});
    cfg.warmup_s=2;
    y=repmat(round(1000*sin(2*pi*(0:79)'/80)),14,1)*2^p.signal_f;
    run_case('warmup','filtered',cfg,p,y,[],ones(size(y))*100000*2^p.signal_f,{});
    cfg.warmup_s=0;
    ticks=[0;2^(47-p.time_f)-1;0;10;20;0;10];
    y=[-1000;1000;-1000;1000;0;-1000;1000]*2^p.signal_f;
    actions={'sample';'sample';'clear';'sample';'sample';'reset';'sample'};
    run_case('fault_recovery','filtered',cfg,p,y,ticks,ones(size(y))*100000*2^p.signal_f,actions);
    cfg=bppe_default_config(); cfg.channels=3; frames=bppe_synthetic(cfg,16);
    for channel=1:cfg.channels
        values=vertcat(frames.ppg);
        run_case(sprintf('adc_channel_%d',channel),'adc',cfg,p,values(:,channel),[],[],{});
    end
end
clear cleanup mem_cleanup
bppe_write_manifest(output_dir,'beat-extraction-vectors',report);
fprintf('EXPORTED_BEAT_VECTORS rows=%d cases=%d beats=%d\n',report.rows,report.cases,report.emitted);

    function run_case(name,kind,cfg,p,values,ticks,dc,actions)
        if isempty(ticks), ticks=(0:numel(values)-1)'*10; end
        if isempty(actions), actions=repmat({'sample'},numel(values),1); end
        state=bppe_init_fixed(cfg,p); c=state.p.channel(1); fx=state.fx;
        assert(~fx.math.failed(),'BPPE:Vectors','Unexpected host-loading fault.');
        report.cases=report.cases+1;
        for k=1:numel(values)
            if strcmp(actions{k},'clear')
                processing=bppe_processing_init(cfg); c=processing.channel(1);
            elseif strcmp(actions{k},'reset')
                state=bppe_init_fixed(cfg,p); c=state.p.channel(1); fx=state.fx;
            end
            if strcmp(kind,'adc')
                [c,beat]=bppe_channel_fixed(c,values(k),ticks(k),cfg,fx);
                t=c.previous_t;
            else
                c.y=values(k); c.dc=dc(k); t=ticks(k)*2^p.time_f;
                [c,beat]=bppe_beat_fixed(c,t,ticks(k),cfg,fx);
            end
            meta=[p.signal_f,p.time_f,p.feature_f,cfg.tick_period_ns,fx.min_period,fx.max_period, ...
                round(cfg.max_period_s*1e9/cfg.tick_period_ns*2^p.time_f), ...
                ceil(2*cfg.fs_hz*cfg.max_period_s)+4,cfg.beats_per_result,fx.a,fx.b,ticks(k), ...
                values(k),c.dc,t,ticks(k)*cfg.tick_period_ns<round(cfg.warmup_s*1e9), ...
                c.previous_y,c.previous_t,c.tracking,c.rejected_beats];
            fprintf(fid,'%s_%s,%d,%s,%s,',p.name,name,k,actions{k},kind);
            fprintf(fid,'%.0f,',meta);
            fprintf(fid,'%s,%s,%s,%s,%d,%s,%.0f,%.0f,%.0f\n', ...
                codes(c.cycle_t),codes(c.cycle_y),codes(c.beat_times),codes(c.beats.'), ...
                ~isempty(beat),codes(beat),fx.math.saturation_count,fx.math.divzero_count,fx.math.precision_fault_count);
            feature_codes=zeros(1,5); if ~isempty(beat), feature_codes=beat; end
            words=[report.cases,k,strcmp(actions{k},'clear')+2*strcmp(actions{k},'reset'), ...
                p.signal_f,p.time_f,p.feature_f,cfg.tick_period_ns,fx.min_period,fx.max_period, ...
                meta(7),meta(8),c.y,c.dc,t,meta(16),c.previous_y,c.previous_t,c.tracking, ...
                c.rejected_beats,numel(c.cycle_t),~isempty(beat),feature_codes, ...
                fx.math.saturation_count,fx.math.divzero_count,fx.math.precision_fault_count];
            emitted_time=0; if ~isempty(beat), emitted_time=c.beat_times(end); end
            buffers=[c.cycle_t;c.cycle_y]; all_words=[words,emitted_time,buffers(:).'];
            hex=cellstr(dec2hex(typecast(int64(all_words),'uint64'),16));
            fprintf(mem,'%s\n',strjoin(hex,' '));
            report.rows=report.rows+1; report.emitted=report.emitted+~isempty(beat);
            report.fault_observations=report.fault_observations+fx.math.failed();
        end
        report.rejections=report.rejections+c.rejected_beats;
    end
end

function text=codes(values)
if isempty(values), text='-'; else, text=strjoin(compose('%.0f',values(:)),';'); end
end
