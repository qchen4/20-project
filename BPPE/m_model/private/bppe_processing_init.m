function p = bppe_processing_init(cfg)
p.have_frame = false;
p.last_seq = 0;
p.last_ts = zeros(1, cfg.channels);
p.elapsed_s = 0;
p.elapsed_ticks = 0; % Exact accumulation used by the integer datapath.
p.window_start_s = cfg.warmup_s;
timing=bppe_window_timing(cfg);
p.timeout_ticks=timing.timeout_ticks;
p.window_deadline_ticks=timing.initial_deadline_ticks;
p.last_gain = 0;
p.last_optical = 0;
c = struct('initialized', false, 'dc', 0, 'y', 0, 'previous_y', 0, ...
    'previous_t', 0, 'tracking', false, 'cycle_t', [], 'cycle_y', [], ...
    'beats', zeros(0,5), 'beat_times', [], 'rejected_beats', 0);
p.channel = repmat(c, 1, cfg.channels);
end
