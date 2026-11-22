function state = bppe_control(state, action, cfg)
% Transaction-level lifecycle; not an AHB/CSR cycle model.
f = bppe_flags();
switch lower(action)
    case 'start'
        assert(~state.running, 'BPPE:Busy', 'Already running.');
        state.p = bppe_processing_init(state.cfg);
        state.running = true;
    case {'abort','disable'}
        state.running = false;
        state.p = bppe_processing_init(state.cfg);
        state.fault_flags = bitor(state.fault_flags, f.ABORTED);
    case 'ack'
        state.pending = false; % Payload retained, not a new measurement.
    case 'clear_faults'
        state.fault_flags = uint16(0);
    case 'reset'
        if isfield(state,'fx')
            state=bppe_init_fixed(state.cfg,state.fx.profile);
        else
            state = bppe_init(state.cfg); % Keeps supplied configuration, resets runtime.
        end
    case 'configure'
        assert(~state.running && ~state.pending, 'BPPE:Busy', ...
            'Configuration requires idle and no unread result.');
        assert(nargin==3, 'BPPE:Config', 'Supply complete configuration.');
        if isfield(state,'fx')
            state=bppe_init_fixed(cfg,state.fx.profile);
        else
            state = bppe_init(cfg);
        end
    otherwise
        error('BPPE:Control', 'Unknown action: %s', action);
end
end
