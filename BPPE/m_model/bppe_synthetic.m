function [frames, meta] = bppe_synthetic(cfg, duration_s, options)
%BPPE_SYNTHETIC Deterministic pulse-shaped TEST stimulus, no true BP labels.
if nargin<2, duration_s=24; end
if nargin<3, options=struct(); end
defaults=struct('heart_rate_bpm',75,'baseline',2^20,'amplitude',30000, ...
    'noise_std',20,'seed',7,'start_tick',0,'start_seq',0);
names=fieldnames(defaults);
for k=1:numel(names)
    if ~isfield(options,names{k}), options.(names{k})=defaults.(names{k}); end
end
validateattributes(duration_s,{'numeric'},{'scalar','finite','positive'});
validateattributes(options.heart_rate_bpm,{'numeric'},{'scalar','finite','positive'});
validateattributes(options.noise_std,{'numeric'},{'scalar','finite','nonnegative'});
n=floor(duration_s*cfg.fs_hz);
t=(0:n-1)'/cfg.fs_hz;
phase=mod(t*options.heart_rate_bpm/60,1);
% Asymmetric positive pulse plus small secondary bump, purely constructed.
pulse=exp(-0.5*((phase-0.22)/0.08).^2)+0.22*exp(-0.5*((phase-0.48)/0.10).^2);
stream=RandStream('mt19937ar','Seed',options.seed);
template=struct('frame_seq',0,'channel_valid',true(1,cfg.channels), ...
    'channel_saturated',false(1,cfg.channels),'gain_transition',false, ...
    'gain_profile_id',0,'optical_profile_id',0,'ppg',zeros(1,cfg.channels), ...
    'timestamp',zeros(1,cfg.channels));
frames=repmat(template,n,1);
for i=1:n
    raw=options.baseline+options.amplitude*pulse(i)*(1+0.03*(0:cfg.channels-1)) ...
        +options.noise_std*randn(stream,1,cfg.channels);
    frames(i).ppg=round(min(max(raw,0),2^24-1));
    frames(i).channel_saturated=raw<0 | raw>2^24-1;
    frames(i).frame_seq=mod(options.start_seq+i-1,65536);
    frames(i).timestamp=repmat(mod(options.start_tick+round(t(i)/(cfg.tick_period_ns*1e-9)),2^32),1,cfg.channels);
end
meta=struct('source','synthetic','has_reference_bp',false,'options',options, ...
    'duration_s',duration_s,'fs_hz',cfg.fs_hz,'time_s',t);
end
