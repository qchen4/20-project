function [out, state, trace] = bppe_step_float(frame, state, cfg)
%BPPE_STEP_FLOAT One accepted frame per call; causal, transaction-level M0.
% cfg is optional. Changing it mid-session is rejected without using the frame.
if nargin<3, cfg=state.cfg; end
f=bppe_flags();
out=struct('accepted',false,'published',false,'candidate',[], ...
    'pending',state.pending,'snapshot',state.snapshot,'fault_flags',uint16(0));
trace=struct('elapsed_s',state.p.elapsed_s,'dc',nan(1,state.cfg.channels), ...
    'filtered',nan(1,state.cfg.channels),'new_beat',false(1,state.cfg.channels));
if ~isequaln(cfg,state.cfg)
    [out,state]=fault(out,state,f.CONFIG_ERROR,false); return
end
if ~state.running, return; end
[ok,reason]=check_frame(frame,cfg);
if ~ok
    [out,state]=fault(out,state,reason,true); return
end
ts=reshape(double(frame.timestamp(1:cfg.channels)),1,[]);
seq=double(frame.frame_seq);
p=state.p;
skew=mod(ts-ts(1)+2^31,2^32)-2^31;
if any(abs(skew)*cfg.tick_period_ns*1e-9>cfg.max_channel_skew_s)
    [out,state]=fault(out,state,f.TIMESTAMP_ERROR,true); return
end
if frame.gain_transition || (p.have_frame && ...
        (frame.gain_profile_id~=p.last_gain || frame.optical_profile_id~=p.last_optical))
    [out,state]=fault(out,state,f.LOW_SQI,true); return
end
if p.have_frame
    ds=mod(seq-p.last_seq,65536);
    dticks=mod(ts-p.last_ts,2^32);
    dt=dticks*cfg.tick_period_ns*1e-9;
    if ds~=1
        [out,state]=fault(out,state,f.SAMPLE_GAP,true); return
    end
    if any(dticks==0 | dticks>=2^31) || ...
            any(abs(dt-1/cfg.fs_hz)>cfg.max_sample_jitter_fraction/cfg.fs_hz+1e-12)
        [out,state]=fault(out,state,f.TIMESTAMP_ERROR,true); return
    end
    % Keep host observation timing exact in ticks in both reference models.
    % Repeated floating-second sums otherwise create spurious timeout shifts.
    p.elapsed_ticks=p.elapsed_ticks+dticks(1);
    p.elapsed_s=p.elapsed_ticks*cfg.tick_period_ns*1e-9;
end
p.have_frame=true; p.last_seq=seq; p.last_ts=ts;
p.last_gain=frame.gain_profile_id; p.last_optical=frame.optical_profile_id;
for k=1:cfg.channels
    t=p.elapsed_s+skew(k)*cfg.tick_period_ns*1e-9;
    if isfield(state,'fx')
        [p.channel(k),beat]=bppe_channel_fixed(p.channel(k),double(frame.ppg(k)), ...
            p.elapsed_ticks+skew(k),cfg,state.fx);
        trace.dc(k)=p.channel(k).dc/2^state.fx.profile.signal_f;
        trace.filtered(k)=p.channel(k).y/2^state.fx.profile.signal_f;
    else
        [p.channel(k),beat]=bppe_channel_step(p.channel(k),double(frame.ppg(k)),t,cfg);
        trace.dc(k)=p.channel(k).dc; trace.filtered(k)=p.channel(k).y;
    end
    trace.new_beat(k)=~isempty(beat);
end
out.accepted=true; trace.elapsed_s=p.elapsed_s;
enough=all(arrayfun(@(c) size(c.beats,1)>=cfg.beats_per_result,p.channel));
timeout=p.elapsed_ticks>=p.window_deadline_ticks;
if enough || timeout
    state.result_counter=state.result_counter+1;
    latest=mod(ts(1)+max(skew),2^32);
    if isfield(state,'fx')
        r=bppe_measurement_fixed(p,cfg,state.result_counter,latest,state.fx);
    else
        r=bppe_measurement(p,cfg,state.result_counter,latest);
    end
    out.candidate=r;
    if state.pending
        state.fault_flags=bitor(state.fault_flags,f.RESULT_OVERFLOW);
        out.fault_flags=f.RESULT_OVERFLOW;
    else
        state.snapshot=r; state.pending=true; out.published=true;
    end
    for k=1:cfg.channels
        p.channel(k).beats=zeros(0,5); p.channel(k).beat_times=[];
        p.channel(k).rejected_beats=0;
    end
    p.window_start_s=p.elapsed_s;
    p.window_deadline_ticks=p.elapsed_ticks+p.timeout_ticks;
end
state.p=p;
if isfield(state,'fx') && state.fx.math.failed()
    reason=f.NUMERIC_FAULT;
    if state.fx.math.divzero_count>0, reason=bitor(reason,f.DIVZERO); end
    state.fault_flags=bitor(state.fault_flags,reason);
    out.fault_flags=bitor(out.fault_flags,reason);
end
out.pending=state.pending; out.snapshot=state.snapshot;
end

function [out,state]=fault(out,state,reason,reset_processing)
state.fault_flags=bitor(state.fault_flags,reason);
out.fault_flags=reason;
if reset_processing, state.p=bppe_processing_init(state.cfg); end
end

function [ok,reason]=check_frame(frame,cfg)
f=bppe_flags(); ok=false; reason=f.CONFIG_ERROR;
required={'frame_seq','channel_valid','channel_saturated','gain_transition', ...
    'gain_profile_id','optical_profile_id','ppg','timestamp'};
if ~isstruct(frame) || ~isscalar(frame) || ~all(isfield(frame,required)), return; end
if ~integer_in(frame.frame_seq,0,65535,1) || ...
        ~integer_in(frame.gain_profile_id,0,255,1) || ...
        ~integer_in(frame.optical_profile_id,0,255,1) || ...
        ~integer_in(frame.gain_transition,0,1,1)
    return
end
if ~integer_in(frame.channel_valid,0,1,cfg.channels) || ...
        ~integer_in(frame.channel_saturated,0,1,cfg.channels)
    return
end
if ~integer_in(frame.ppg,0,2^24-1,cfg.channels) || ...
        ~integer_in(frame.timestamp,0,2^32-1,cfg.channels)
    return
end
if ~all(frame.channel_valid(1:cfg.channels))
    reason=f.SAMPLE_GAP; return
end
if any(frame.channel_saturated(1:cfg.channels))
    reason=f.ADC_SATURATED; return
end
ok=true; reason=uint16(0);
end

function yes=integer_in(x,lo,hi,n)
yes=(isnumeric(x)||islogical(x)) && isreal(x) && isvector(x) && ...
    numel(x)==n && all(isfinite(double(x(:)))) && ...
    all(double(x(:))>=lo & double(x(:))<=hi & double(x(:))==fix(double(x(:))));
end
