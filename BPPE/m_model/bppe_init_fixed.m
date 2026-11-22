function state = bppe_init_fixed(cfg, profile)
% Experimental fixed-point counterpart; same input/configuration contract.
if nargin<1, cfg=bppe_default_config(); end
if nargin<2, profile=bppe_fixed_profile(); end
state=bppe_init(cfg);
assert(isequaln(profile,bppe_fixed_profile(profile.name)), ...
    'BPPE:FixedProfile','Use a named audited format profile.');
assert(cfg.tick_period_ns==fix(cfg.tick_period_ns) && cfg.tick_period_ns<=1e9, ...
    'BPPE:FixedConfig','Integer nanosecond tick up to one second required.');
assert(cfg.beats_per_result<=64,'BPPE:FixedConfig','At most 64 beats supported.');
state.fx.profile=profile;
q=bppe_integer_math(); state.fx.math=q;
p=profile;
state.fx.a=q.encode(1-exp(-2*pi*cfg.dc_cutoff_hz/cfg.fs_hz),p.coefficient_f,p.coefficient_f,false,'filter_coefficient');
state.fx.b=q.encode(1-exp(-2*pi*cfg.lowpass_hz/cfg.fs_hz),p.coefficient_f,p.coefficient_f,false,'filter_coefficient');
state.fx.center=q.encode(cfg.model.center,p.feature_w,p.feature_f,true,'model_center');
state.fx.scale=q.encode(cfg.model.scale,p.feature_w,p.feature_f,true,'model_scale');
state.fx.beta=q.encode(cfg.model.beta,p.beta_w,p.regression_f,true,'model_beta');
if any(state.fx.scale==0), q.divzero_count=q.divzero_count+1; end
state.fx.min_period=q.encode(cfg.min_period_s,p.feature_w,p.feature_f,true,'period_threshold');
state.fx.max_period=q.encode(cfg.max_period_s,p.feature_w,p.feature_f,true,'period_threshold');
state.fx.min_amplitude=q.encode(cfg.min_ac_dc,p.feature_w,p.feature_f,true,'amplitude_threshold');
state.fx.max_amplitude=q.encode(cfg.max_ac_dc,p.feature_w,p.feature_f,true,'amplitude_threshold');
state.fx.max_cv=q.encode(cfg.max_period_cv,p.feature_w,p.feature_f,true,'cv_threshold');
state.fx.bp_min=q.encode([cfg.sbp_limits(1) cfg.dbp_limits(1)],p.accumulator_w,p.regression_f,true,'bp_threshold');
state.fx.bp_max=q.encode([cfg.sbp_limits(2) cfg.dbp_limits(2)],p.accumulator_w,p.regression_f,true,'bp_threshold');
% Infinite training bounds mean disabled comparisons, not saturating constants.
state.fx.feature_min=cfg.model.feature_min; state.fx.feature_max=cfg.model.feature_max;
for k=1:5
    if isfinite(cfg.model.feature_min(k))
        state.fx.feature_min(k)=q.encode(cfg.model.feature_min(k),p.feature_w,p.feature_f,true,'feature_bound');
    end
    if isfinite(cfg.model.feature_max(k))
        state.fx.feature_max(k)=q.encode(cfg.model.feature_max(k),p.feature_w,p.feature_f,true,'feature_bound');
    end
end
state.p.elapsed_ticks=0;
end
