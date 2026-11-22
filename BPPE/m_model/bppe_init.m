function state = bppe_init(cfg)
%BPPE_INIT Validate and lock configuration; starts disabled, no pending result.
if nargin == 0, cfg = bppe_default_config(); end
validateattributes(cfg.fs_hz, {'numeric'}, {'scalar','finite','positive'});
validateattributes(cfg.tick_period_ns, {'numeric'}, {'scalar','finite','positive'});
validateattributes(cfg.channels, {'numeric'}, {'scalar','integer','>=',1,'<=',3});
validateattributes(cfg.primary_channel, {'numeric'}, ...
    {'scalar','integer','>=',1,'<=',cfg.channels});
validateattributes(cfg.config_epoch, {'numeric'}, {'scalar','integer','>=',0,'<=',255});
validateattributes(cfg.beats_per_result, {'numeric'}, {'scalar','integer','>=',2});
validateattributes(cfg.dc_cutoff_hz, {'numeric'}, {'scalar','finite','positive','<',cfg.fs_hz/2});
validateattributes(cfg.lowpass_hz, {'numeric'}, {'scalar','finite','>',cfg.dc_cutoff_hz,'<',cfg.fs_hz/2});
validateattributes(cfg.warmup_s, {'numeric'}, {'scalar','finite','nonnegative'});
validateattributes(cfg.min_period_s, {'numeric'}, {'scalar','finite','positive'});
validateattributes(cfg.max_period_s, {'numeric'}, {'scalar','finite','>',cfg.min_period_s});
validateattributes(cfg.timeout_s, {'numeric'}, {'scalar','finite','>',cfg.max_period_s});
validateattributes(cfg.max_sample_jitter_fraction, {'numeric'}, {'scalar','finite','>=',0,'<',1});
validateattributes(cfg.max_channel_skew_s, {'numeric'}, {'scalar','finite','nonnegative','<',1/cfg.fs_hz});
validateattributes(cfg.min_ac_dc, {'numeric'}, {'scalar','finite','positive'});
validateattributes(cfg.max_ac_dc, {'numeric'}, {'scalar','finite','>',cfg.min_ac_dc});
validateattributes(cfg.max_period_cv, {'numeric'}, {'scalar','finite','positive'});
validateattributes(cfg.sqi_threshold, {'numeric'}, {'scalar','integer','>=',0,'<=',255});
assert(cfg.tick_period_ns*1e-9*2^31 > cfg.timeout_s+cfg.warmup_s, ...
    'BPPE:Config', 'Timestamp unambiguous horizon is too short.');
assert(all(size(cfg.model.beta)==[6,2]) && all(isfinite(cfg.model.beta(:))), ...
    'BPPE:Config', 'beta must be finite 6-by-2.');
assert(isequal(cfg.model.feature_names, bppe_feature_names()) && ...
    strcmp(cfg.model.profile,cfg.profile), 'BPPE:Config', 'Model schema mismatch.');
if cfg.model.configured
    assert(isequaln(cfg.model.extractor,bppe_extractor_signature(cfg)), ...
        'BPPE:Config', 'Model was fitted with a different feature configuration.');
end
for name={'configured','calibrated','demo_only'}
    validateattributes(cfg.model.(name{1}), {'numeric','logical'}, {'scalar','binary'});
end
validateattributes(cfg.allow_demo_model, {'numeric','logical'}, {'scalar','binary'});
for name = {'center','scale','feature_min','feature_max'}
    assert(isequal(size(cfg.model.(name{1})),[1,5]), 'BPPE:Config', 'Invalid model vector shape.');
end
assert(all(isfinite(cfg.model.center)) && all(isfinite(cfg.model.scale)) && ...
    all(cfg.model.scale>0), 'BPPE:Config', 'Invalid normalization.');
assert(all(cfg.model.feature_min <= cfg.model.feature_max) && ...
    ~any(isnan([cfg.model.feature_min cfg.model.feature_max])), ...
    'BPPE:Config', 'Invalid feature envelope.');
for name = {'sbp_limits','dbp_limits'}
    v = cfg.(name{1});
    assert(isequal(size(v),[1,2]) && all(isfinite(v)) && ...
        v(1)>=0 && v(2)>v(1) && v(2)<=65535/128, 'BPPE:Config', 'Invalid pressure limits.');
end
state.cfg = cfg;
state.running = false;
state.pending = false;
state.snapshot = [];
state.result_counter = 0;
state.fault_flags = uint16(0);
state.p = bppe_processing_init(cfg);
end
