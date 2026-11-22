function report=bppe_export_frame_vectors(output_dir)
%BPPE_EXPORT_FRAME_VECTORS Public fixed-step reference for acquisition RTL.
% Typed ports exclude malformed structures/NaN/out-of-range fields. Running
% sessions only; no bus, lifecycle/ACK or measurement scheduler is modeled.
root=fileparts(mfilename('fullpath'));
if nargin<1, output_dir=fullfile(root,'artifacts','frame-vectors'); end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
fid=fopen(fullfile(output_dir,'frame_vectors.mem'),'w');
assert(fid>=0,'BPPE:Vectors','Cannot open frame vectors.');
cleanup=onCleanup(@()fclose(fid));
report=struct('rows',0,'cases',0,'accepted',0,'rejected',0,'events',0,'beats',0);
profiles={'compact','balanced','wide'};
for profile_id=0:2
    p=bppe_fixed_profile(profiles{profile_id+1});
    for channels=1:3
        cfg=bppe_default_config(); cfg.channels=channels;
        % Keep measurement scheduling outside this acquisition/channel stage.
        cfg.beats_per_result=64; cfg.timeout_s=1000;
        frames=bppe_synthetic(cfg,16);
        run_case('synthetic',cfg,p,profile_id,frames,zeros(1,numel(frames)));
        frames=frames(1:64);
        for i=1:numel(frames)
            frames(i).frame_seq=mod(65520+i-1,65536);
            frames(i).timestamp=mod(2^32-100+(i-1)*10+(0:channels-1),2^32);
        end
        run_case('wrap',cfg,p,profile_id,frames,zeros(1,numel(frames)));
        for i=1:numel(frames)
            offsets=[0 -1 1];
            frames(i).timestamp=mod((i-1)*10+offsets(1:channels),2^32);
        end
        run_case('negative_skew',cfg,p,profile_id,frames,zeros(1,numel(frames)));
        % Each error is followed by re-anchoring; overlap fixtures test reason
        % precedence instead of accepting an unordered union of fault bits.
        frames=bppe_synthetic(cfg,0.64);
        frames(5).channel_valid(1)=false;
        frames(5).channel_saturated(1)=true;
        frames(10).channel_saturated(channels)=true;
        frames(15).gain_transition=true;
        frames(20).gain_profile_id=1;
        frames(25).optical_profile_id=1;
        frames(30).frame_seq=frames(29).frame_seq;
        frames(30).timestamp=frames(29).timestamp;
        if channels>1
            frames(35).timestamp(channels)=frames(35).timestamp(1)+3;
            frames(35).gain_transition=true;
        end
        frames(40).timestamp(1)=frames(39).timestamp(1);
        frames(45).timestamp(1)=mod(frames(44).timestamp(1)+2^31,2^32);
        run_case('precedence',cfg,p,profile_id,frames,zeros(1,numel(frames)));
        % All channels move together: isolate per-channel inter-frame jitter.
        frames=bppe_synthetic(cfg,0.64); cursor=0;
        deltas=[10 8 12 7 10 13 10 0 10 2^31 10 2^31-1 10 9 11 10];
        for i=1:numel(frames)
            cursor=mod(cursor+deltas(mod(i-1,numel(deltas))+1),2^32);
            frames(i).timestamp=repmat(cursor,1,channels);
        end
        run_case('jitter',cfg,p,profile_id,frames,zeros(1,numel(frames)));
        frames=bppe_synthetic(cfg,0.64); errors=zeros(1,numel(frames)); n=1;
        for i=1:numel(frames)
            if ismember(i,[5 15 25 35]), errors(i)=1; end
            frames(i).frame_seq=mod(n-1,65536);
            frames(i).timestamp=repmat((n-1)*10,1,channels);
            if errors(i)==0, n=n+1; end
        end
        run_case('config_retry',cfg,p,profile_id,frames,errors);
        cfg.tick_period_ns=500000;
        frames=bppe_synthetic(cfg,0.64);
        run_case('half_ms',cfg,p,profile_id,frames,zeros(1,numel(frames)));
    end
end
clear cleanup
bppe_write_manifest(output_dir,'frame-dispatch-vectors',report);
fprintf('EXPORTED_FRAME_VECTORS rows=%d cases=%d accepted=%d rejected=%d events=%d beats=%d\n', ...
    report.rows,report.cases,report.accepted,report.rejected,report.events,report.beats);

    function run_case(name,cfg,p,profile_id,frames,errors)
        state=bppe_control(bppe_init_fixed(cfg,p),'start');
        b=bppe_frame_tick_bounds(cfg); report.cases=report.cases+1;
        for r=1:numel(frames)
            frame=frames(r); passed_cfg=cfg;
            if errors(r), passed_cfg.config_epoch=cfg.config_epoch+1; end
            [out,state,trace]=bppe_step_fixed(frame,state,passed_cfg);
            assert(isempty(out.candidate),'BPPE:Vectors','Unexpected measurement.');
            assert(~state.fx.math.failed(),'BPPE:Vectors','Unexpected numeric fault.');
            adcs=zeros(1,3); timestamps=adcs; ticks=adcs; dc=adcs; y=adcs; times=adcs;
            tracking=adcs; rejected=adcs; beat_valid=adcs; beat_time=adcs; features=zeros(3,5);
            adcs(1:cfg.channels)=double(frame.ppg);
            timestamps(1:cfg.channels)=double(frame.timestamp);
            skew=mod(timestamps-timestamps(1)+2^31,2^32)-2^31;
            for c=1:cfg.channels
                ch=state.p.channel(c);
                ticks(c)=state.p.elapsed_ticks+skew(c);
                dc(c)=ch.dc; y(c)=ch.y; times(c)=ch.previous_t;
                tracking(c)=ch.tracking; rejected(c)=ch.rejected_beats;
                beat_valid(c)=trace.new_beat(c);
                if beat_valid(c), features(c,:)=ch.beats(end,:); beat_time(c)=ch.beat_times(end); end
            end
            valid=sum(double(frame.channel_valid).*2.^(0:cfg.channels-1));
            saturated=sum(double(frame.channel_saturated).*2.^(0:cfg.channels-1));
            words=[report.cases r profile_id cfg.channels b.min_delta_ticks b.max_delta_ticks ...
                b.max_abs_skew_ticks cfg.tick_period_ns state.fx.a state.fx.b state.fx.min_period ...
                state.fx.max_period round(cfg.max_period_s*1e9/cfg.tick_period_ns*2^p.time_f) ...
                ceil(cfg.warmup_s*1e9/cfg.tick_period_ns) errors(r) double(frame.frame_seq) ...
                double(frame.gain_profile_id) double(frame.optical_profile_id) double(frame.gain_transition) ...
                valid saturated r adcs timestamps double(out.accepted) double(out.fault_flags) ...
                double(state.fault_flags) state.p.elapsed_ticks ticks dc y times tracking rejected ...
                beat_valid reshape(features.',1,[]) beat_time state.fx.math.saturation_count ...
                state.fx.math.divzero_count state.fx.math.precision_fault_count];
            assert(isa(words,'double') && numel(words)==74 && all(isfinite(words)) && all(words==fix(words)), ...
                'BPPE:Vectors','Frame words must be exact double integer codes.');
            fprintf(fid,'%s\n',strjoin(cellstr(dec2hex(typecast(int64(words),'uint64'),16)),' '));
            report.rows=report.rows+1; report.accepted=report.accepted+out.accepted;
            report.rejected=report.rejected+~out.accepted;
            report.events=report.events+out.accepted*cfg.channels+~out.accepted;
            report.beats=report.beats+sum(beat_valid);
        end
        fprintf('FRAME_CASE %s_%s_%d\n',p.name,name,cfg.channels);
    end
end
