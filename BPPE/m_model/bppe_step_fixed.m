function [out,state,trace] = bppe_step_fixed(frame,state,cfg)
% Shared transaction validation; DSP dispatches exclusively to integer kernels.
assert(isfield(state,'fx'),'BPPE:FixedState','Use bppe_init_fixed.');
if nargin<3, cfg=state.cfg; end
[out,state,trace]=bppe_step_float(frame,state,cfg);
end
