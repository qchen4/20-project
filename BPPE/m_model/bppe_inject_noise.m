function [noisy, meta] = bppe_inject_noise(clean, cfg, kind, snr_db, seed)
% Add reproducible synthetic interference. SNR uses mean-removed clean RMS.
% This is not the ADI vendor's frequency-domain pSNR or a human-motion dataset.
validateattributes(snr_db,{'numeric'},{'scalar','real','finite'});
validateattributes(seed,{'numeric'},{'scalar','integer','nonnegative'});
n=numel(clean); assert(n>=10,'BPPE:Noise','Need at least ten samples.');
stream=RandStream('mt19937ar','Seed',seed);
t=(0:n-1)'/cfg.fs_hz;
raw=vertcat(clean.ppg); signal_rms=sqrt(mean((raw-mean(raw,1)).^2,1));
assert(all(signal_rms>0),'BPPE:Noise','Clean AC must be nonzero.');
added=zeros(size(raw));
for channel=1:cfg.channels
    switch kind
        case 'white'
            z=randn(stream,n,1);
        case 'colored'
            z=filter(1,[1,-0.85],randn(stream,n,1));
        case 'baseline'
            phase=2*pi*rand(stream);
            z=sin(2*pi*0.18*t+phase)+0.3*sin(2*pi*0.07*t+phase/2);
        case 'periodic_motion'
            phase=2*pi*rand(stream);
            % 1.7 Hz interference competes with the 1.25 Hz test pulse.
            z=(0.8+0.2*sin(2*pi*0.11*t+phase)).*sin(2*pi*1.7*t+phase) ...
                +0.15*filter(1,[1,-0.7],randn(stream,n,1));
        case 'impulsive'
            impulses=randn(stream,n,1).*(rand(stream,n,1)<0.015);
            z=filter(exp(-(0:9)/2),1,impulses)+0.02*randn(stream,n,1);
        otherwise
            error('BPPE:Noise','Unknown noise type: %s',kind);
    end
    z=z-mean(z);
    added(:,channel)=z/sqrt(mean(z.^2))*signal_rms(channel)*10^(-snr_db/20);
end
combined=raw+added;
clipped=combined<0 | combined>2^24-1;
noisy=clean;
for i=1:n
    noisy(i).ppg=round(min(max(combined(i,:),0),2^24-1));
    noisy(i).channel_saturated=noisy(i).channel_saturated | clipped(i,:);
end
actual=vertcat(noisy.ppg)-raw;
meta=struct('kind',kind,'seed',seed,'target_snr_db',snr_db, ...
    'realized_snr_db',20*log10(signal_rms./sqrt(mean(actual.^2,1))), ...
    'clipped_samples',sum(clipped,'all'),'signal_rms',signal_rms, ...
    'noise_rms',sqrt(mean(actual.^2,1)));
end
