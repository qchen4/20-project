function cfg = bppe_demo_config(cfg)
%BPPE_DEMO_CONFIG Artificial coefficients for software tests ONLY.
% No relationship to real physiological accuracy is asserted.
if nargin==0, cfg=bppe_default_config(); end
cfg.allow_demo_model=true;
cfg.model.configured=true;
cfg.model.calibrated=true;
cfg.model.demo_only=true;
cfg.model.id='SYNTHETIC-DEMO-NOT-A-BP-CALIBRATION';
cfg.model.profile=cfg.profile;
cfg.model.feature_names=bppe_feature_names();
cfg.model.center=[0.8,0.25,0.33,0.30,0.04];
cfg.model.scale=[0.2,0.1,0.1,0.1,0.02];
cfg.model.beta=[120,80; -3,-2; 1,0.5; 1,0.5; 1,0.5; 2,1];
cfg.model.feature_min=-inf(1,5);
cfg.model.feature_max=inf(1,5);
cfg.model.extractor=bppe_extractor_signature(cfg);
end
