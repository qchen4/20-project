function run = bppe_run(frames, cfg, auto_ack, fixed_profile)
%BPPE_RUN Batch convenience wrapper over the identical streaming step.
if nargin<3, auto_ack=true; end
if nargin>=4 && ~isempty(fixed_profile)
    state=bppe_control(bppe_init_fixed(cfg,fixed_profile),'start');
else
    state=bppe_control(bppe_init(cfg),'start');
end
n=numel(frames);
run.results=struct([]); run.candidates=struct([]);
run.candidate_frame_index=[];
run.trace.elapsed_s=zeros(n,1);
run.trace.filtered=nan(n,cfg.channels); run.trace.dc=nan(n,cfg.channels);
run.trace.new_beat=false(n,cfg.channels);
run.accepted=false(n,1); run.fault_flags=zeros(n,1,'uint16');
for i=1:n
    [out,state,tr]=bppe_step_float(frames(i),state);
    run.accepted(i)=out.accepted; run.fault_flags(i)=out.fault_flags;
    run.trace.elapsed_s(i)=tr.elapsed_s;
    run.trace.filtered(i,:)=tr.filtered; run.trace.dc(i,:)=tr.dc;
    run.trace.new_beat(i,:)=tr.new_beat;
    if ~isempty(out.candidate)
        run.candidate_frame_index(end+1)=i;
        if isempty(run.candidates), run.candidates=out.candidate;
        else, run.candidates(end+1)=out.candidate; end
    end
    if out.published
        if isempty(run.results), run.results=out.snapshot;
        else, run.results(end+1)=out.snapshot; end
        if auto_ack, state=bppe_control(state,'ack'); end
    end
end
run.state=state; run.cfg=cfg;
end
