function report=bppe_export_system_vectors(output_dir)
% Public fixed-step raw-frame/multichannel/publication golden records.
root=fileparts(mfilename('fullpath'));
if nargin<1, output_dir=fullfile(root,'artifacts','system-vectors'); end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
fid=fopen(fullfile(output_dir,'system_vectors.mem'),'w');
assert(fid>=0,'BPPE:Vectors','Cannot open prototype vectors.');
cleanup=onCleanup(@()fclose(fid));
report=struct('cases',0,'frames',0,'candidates',0,'overflows',0,'bad_hr_valid_candidates',0);
for profile_name={'compact','balanced','wide'}
    p=bppe_fixed_profile(profile_name{1});
    for channels=1:3
        cfg=bppe_demo_config();cfg.channels=channels;cfg.primary_channel=channels;
        run_case('clean',cfg,p,12,'auto',false,false);
        run_case('hold_pending',cfg,p,24,'hold',false,false);
        run_case('delayed_ack',cfg,p,24,'delayed',false,false);
        run_case('flat_timeout',cfg,p,24,'auto',true,false);
        c=cfg;c.model.scale(1)=2^(-p.feature_f-2);
        run_case('scale_underflow',c,p,16,'hold',false,false);
        run_case('frame_errors',cfg,p,24,'hold',false,false);
        run_case('config_retry',cfg,p,12,'auto',false,false);
        run_case('impulsive_known_gap',cfg,p,32,'auto',false,true);
    end
end
clear cleanup
bppe_write_manifest(output_dir,'raw-multichannel-system-prototype',report);
fprintf('EXPORTED_SYSTEM_VECTORS cases=%d frames=%d candidates=%d known_gap=%d\n', ...
    report.cases,report.frames,report.candidates,report.bad_hr_valid_candidates);

    function run_case(name,cfg,p,duration,ack_mode,flat,impulsive)
        if cfg.channels==3 && strcmp(name,'clean'),cfg.primary_channel=1;end
        if cfg.channels==3 && strcmp(name,'hold_pending'),cfg.primary_channel=2;end
        cfg.model.extractor=bppe_extractor_signature(cfg);
        options=struct('noise_std',0,'heart_rate_bpm',75,'start_tick',2^32-100,'start_seq',65520);
        frames=bppe_synthetic(cfg,duration,options);
        if flat, for n=1:numel(frames), frames(n).ppg=repmat(2^20,1,cfg.channels);end,end
        if impulsive, frames=bppe_inject_noise(frames,cfg,'impulsive',0,37);end
        config_errors=false(1,numel(frames));
        if strcmp(name,'config_retry')
            config_errors([600 900])=true;original=frames;offset=0;
            for n=1:numel(frames)
                frames(n)=original(n-offset);
                offset=offset+config_errors(n);
            end
        end
        offsets=[0 -1 2];if cfg.channels==2,offsets=[0 1];end
        for n=1:numel(frames)
            frames(n).timestamp=mod(frames(n).timestamp+offsets(1:cfg.channels),2^32);
            if strcmp(name,'clean'),frames(n).timestamp=mod(frames(n).timestamp+mod(n,3)-1,2^32);end
        end
        if ismember(name,{'frame_errors','scale_underflow'})
            frames(800).channel_valid(1)=false;frames(800).channel_saturated(1)=true;
            frames(801).channel_saturated(cfg.channels)=true;
            frames(802).gain_transition=true;
            frames(803).frame_seq=frames(802).frame_seq;
            frames(803).timestamp=frames(802).timestamp;
            % After re-anchor, force a second time/sequence rejection.
            frames(805).timestamp=frames(804).timestamp;
        end
        state=bppe_init_fixed(cfg,p);state=bppe_control(state,'start');fx=state.fx;q=fx.math;
        timing=bppe_window_timing(cfg);assert(timing.exact_ns_constants,'BPPE:Timing','Use the audited integer-ns timing profile.');
        report.cases=report.cases+1;snapshot_frame=0;case_candidates=0;case_bad_hr=0;
        lo=fx.feature_min;hi=fx.feature_max;lo_enabled=isfinite(lo);hi_enabled=isfinite(hi);
        lo(~lo_enabled)=0;hi(~hi_enabled)=0;
        bounds=bppe_frame_tick_bounds(cfg);
        config=[0,report.cases,p.signal_f,p.coefficient_f,p.time_f,p.feature_f,fx.a,fx.b,cfg.tick_period_ns, ...
            fx.min_period,fx.max_period,round(cfg.max_period_s*1e9/cfg.tick_period_ns*2^p.time_f), ...
            cfg.beats_per_result,fx.min_amplitude,fx.max_amplitude,fx.max_cv,cfg.sqi_threshold, ...
            cfg.model.configured,cfg.model.calibrated,cfg.model.demo_only,cfg.allow_demo_model, ...
            fx.center,fx.scale,reshape(fx.beta.',1,[]),lo_enabled,lo,hi_enabled,hi,fx.bp_min,fx.bp_max, ...
            q.saturation_count,q.divzero_count,q.precision_fault_count, ...
            timing.warmup_ticks,timing.timeout_ticks,timing.initial_deadline_ticks,cfg.channels,cfg.primary_channel-1, ...
            bounds.min_delta_ticks,bounds.max_delta_ticks,bounds.max_abs_skew_ticks];
        assert(numel(config)==78);write_words(config);
        for frame_index=1:numel(frames)
            do_ack=state.pending && (strcmp(ack_mode,'auto') || ...
                (strcmp(ack_mode,'delayed') && mod(frame_index,1000)==0));
            if do_ack, state=bppe_control(state,'ack');end
            passed_cfg=cfg;if config_errors(frame_index),passed_cfg.config_epoch=cfg.config_epoch+1;end
            [out,state]=bppe_step_fixed(frames(frame_index),state,passed_cfg);
            if out.published, snapshot_frame=frame_index;end
            candidate=payload(out.candidate,p);snapshot=payload(state.snapshot,p);
            frame=frames(frame_index);adcs=zeros(1,3);timestamps=adcs;
            adcs(1:cfg.channels)=double(frame.ppg);timestamps(1:cfg.channels)=double(frame.timestamp);
            valid=sum(double(frame.channel_valid).*2.^(0:cfg.channels-1));
            saturated=sum(double(frame.channel_saturated).*2.^(0:cfg.channels-1));
            words=[1,report.cases,frame_index,do_ack,double(out.accepted),double(out.fault_flags), ...
                state.p.elapsed_ticks,state.p.window_deadline_ticks,state.p.have_frame, ...
                q.saturation_count,q.divzero_count,q.precision_fault_count,~isempty(out.candidate),candidate, ...
                state.pending,snapshot(1),snapshot_frame,snapshot(2:end),mod(state.result_counter,65536),double(state.fault_flags), ...
                config_errors(frame_index),double(frame.frame_seq),double(frame.gain_profile_id),double(frame.optical_profile_id), ...
                double(frame.gain_transition),valid,saturated,adcs,timestamps];
            assert(numel(words)==60);write_words(words);
            report.frames=report.frames+1;
            if ~isempty(out.candidate)
                case_candidates=case_candidates+1;
                if out.candidate.result_valid && abs(60/out.candidate.features(1)-75)>5,case_bad_hr=case_bad_hr+1;end
                report.overflows=report.overflows+~out.published;
            end
        end
        report.candidates=report.candidates+case_candidates;
        if impulsive
            report.bad_hr_valid_candidates=report.bad_hr_valid_candidates+case_bad_hr;
            if strcmp(p.name,'balanced') && cfg.channels==1,assert(case_bad_hr>0,'BPPE:KnownGap','Known impulse gap was not reproduced.');end
        end
        fprintf('SYSTEM_CASE %s_%s_%d candidates=%d bad_hr_valid=%d\n',p.name,name,cfg.channels,case_candidates,case_bad_hr);
    end
    function write_words(words)
        assert(isa(words,'double') && all(abs(words)<=2^53-1) && all(words==fix(words)), ...
            'BPPE:Vectors','Rows must remain exact double integer codes before int64 serialization.');
        hex=cellstr(dec2hex(typecast(int64(words),'uint64'),16));fprintf(fid,'%s\n',strjoin(hex,' '));
    end
end
function words=payload(result,p)
words=zeros(1,15);if isempty(result),return,end
has_features=all(isfinite(result.features));features=zeros(1,5);pressure=zeros(1,2);
if has_features,features=round(result.features*2^p.feature_f);end
if result.result_valid,pressure=round([result.sbp,result.dbp]*2^p.regression_f);end
words=[double(result.result_seq),double(result.result_ts),has_features,result.result_valid,double(result.reason_flags), ...
    double(result.sqi),features,pressure,double(result.sbp_uq9_7),double(result.dbp_uq9_7)];
end
