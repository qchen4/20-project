function report=bppe_export_prototype_vectors(output_dir)
% Accepted single-channel frames, with the approved integer-tick deadlines.
root=fileparts(mfilename('fullpath'));
if nargin<1, output_dir=fullfile(root,'artifacts','prototype-vectors'); end
if ~exist(output_dir,'dir'), mkdir(output_dir); end
fid=fopen(fullfile(output_dir,'prototype_vectors.mem'),'w');
assert(fid>=0,'BPPE:Vectors','Cannot open prototype vectors.');
cleanup=onCleanup(@()fclose(fid));
report=struct('cases',0,'frames',0,'candidates',0,'overflows',0,'bad_hr_valid_candidates',0);
for profile_name={'compact','balanced','wide'}
    p=bppe_fixed_profile(profile_name{1}); cfg=bppe_demo_config();
    run_case('clean',cfg,p,16,'auto',false,false);
    run_case('hold_pending',cfg,p,32,'hold',false,false);
    run_case('delayed_ack',cfg,p,32,'delayed',false,false);
    c=bppe_default_config();run_case('unconfigured',c,p,16,'auto',false,false);
    run_case('flat_timeout',cfg,p,32,'auto',true,false);
    c=cfg;c.model.scale(1)=2^(-p.feature_f-2);
    run_case('scale_underflow',c,p,16,'auto',false,false);
    run_case('impulsive_known_gap',cfg,p,32,'auto',false,true);
end
clear cleanup
bppe_write_manifest(output_dir,'accepted-single-channel-prototype',report);
fprintf('EXPORTED_PROTOTYPE_VECTORS cases=%d frames=%d candidates=%d known_gap=%d\n', ...
    report.cases,report.frames,report.candidates,report.bad_hr_valid_candidates);

    function run_case(name,cfg,p,duration,ack_mode,flat,impulsive)
        cfg.model.extractor=bppe_extractor_signature(cfg);
        options=struct('noise_std',0,'heart_rate_bpm',75);
        frames=bppe_synthetic(cfg,duration,options);
        if flat, for n=1:numel(frames), frames(n).ppg=2^20;end,end
        if impulsive, frames=bppe_inject_noise(frames,cfg,'impulsive',0,37);end
        state=bppe_init_fixed(cfg,p);state=bppe_control(state,'start');fx=state.fx;q=fx.math;
        timing=bppe_window_timing(cfg);assert(timing.exact_ns_constants,'BPPE:Timing','Use the audited integer-ns timing profile.');
        report.cases=report.cases+1;snapshot_frame=0;case_candidates=0;case_bad_hr=0;
        lo=fx.feature_min;hi=fx.feature_max;lo_enabled=isfinite(lo);hi_enabled=isfinite(hi);
        lo(~lo_enabled)=0;hi(~hi_enabled)=0;
        config=[0,report.cases,p.signal_f,p.coefficient_f,p.time_f,p.feature_f,fx.a,fx.b,cfg.tick_period_ns, ...
            fx.min_period,fx.max_period,round(cfg.max_period_s*1e9/cfg.tick_period_ns*2^p.time_f), ...
            cfg.beats_per_result,fx.min_amplitude,fx.max_amplitude,fx.max_cv,cfg.sqi_threshold, ...
            cfg.model.configured,cfg.model.calibrated,cfg.model.demo_only,cfg.allow_demo_model, ...
            fx.center,fx.scale,reshape(fx.beta.',1,[]),lo_enabled,lo,hi_enabled,hi,fx.bp_min,fx.bp_max, ...
            q.saturation_count,q.divzero_count,q.precision_fault_count, ...
            timing.warmup_ticks,timing.timeout_ticks,timing.initial_deadline_ticks];
        assert(numel(config)==73);write_words(config);
        for frame_index=1:numel(frames)
            do_ack=state.pending && (strcmp(ack_mode,'auto') || ...
                (strcmp(ack_mode,'delayed') && mod(frame_index,1000)==0));
            if do_ack, state=bppe_control(state,'ack');end
            ticks=state.p.elapsed_ticks;
            if state.p.have_frame, ticks=ticks+mod(frames(frame_index).timestamp-state.p.last_ts,2^32);end
            warmup=ticks*cfg.tick_period_ns<round(cfg.warmup_s*1e9);
            timeout=ticks>=state.p.window_deadline_ticks;
            [out,state]=bppe_step_fixed(frames(frame_index),state,cfg);
            assert(out.accepted,'BPPE:Vectors','Prototype scope requires already accepted frames.');
            if out.published, snapshot_frame=frame_index;end
            candidate=payload(out.candidate,p);snapshot=payload(state.snapshot,p);
            words=[1,report.cases,frame_index,do_ack,frames(frame_index).ppg,ticks,frames(frame_index).timestamp,warmup,timeout, ...
                q.saturation_count,q.divzero_count,q.precision_fault_count,~isempty(out.candidate),candidate, ...
                state.pending,snapshot(1),snapshot_frame,snapshot(2:end),mod(state.result_counter,65536),double(state.fault_flags)];
            assert(numel(words)==47);write_words(words);
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
            if strcmp(p.name,'balanced'),assert(case_bad_hr>0,'BPPE:KnownGap','Known impulse gap was not reproduced.');end
        end
        fprintf('PROTOTYPE_CASE %s_%s candidates=%d bad_hr_valid=%d\n',p.name,name,case_candidates,case_bad_hr);
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
