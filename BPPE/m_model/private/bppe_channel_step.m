function [c, beat] = bppe_channel_step(c, x, t, cfg)
% Causal DC tracker + one-pole low pass; full cycles at rising zero crossings.
beat = [];
if ~c.initialized
    c.dc = x; c.initialized = true; c.previous_t = t;
end
a = 1-exp(-2*pi*cfg.dc_cutoff_hz/cfg.fs_hz);
b = 1-exp(-2*pi*cfg.lowpass_hz/cfg.fs_hz);
c.dc = c.dc + a*(x-c.dc);
c.y = c.y + b*((x-c.dc)-c.y);
if t < cfg.warmup_s
    c.previous_y = c.y; c.previous_t = t;
    return
end
crossing = c.previous_y <= 0 && c.y > 0;
if crossing
    fraction = -c.previous_y/(c.y-c.previous_y);
    tc = c.previous_t + fraction*(t-c.previous_t);
    if c.tracking
        tt = [c.cycle_t, tc]; yy = [c.cycle_y, 0];
        period = tc-tt(1);
        [peak, ip] = max(yy);
        amplitude = max(yy)-min(yy);
        if period>=cfg.min_period_s && period<=cfg.max_period_s && peak>0 && c.dc>0
            rise = (tt(ip)-tt(1))/period;
            width = trapz(tt,double(yy>=0.5*peak))/period;
            area = trapz(tt,max(yy,0))/(peak*period);
            beat = [period, rise, width, area, amplitude/c.dc];
            if all(isfinite(beat))
                c.beats(end+1,:) = beat;
                c.beat_times(end+1) = tc;
                % Bounded feature history; no whole-record waveform storage.
                if size(c.beats,1)>cfg.beats_per_result
                    c.beats(1,:)=[]; c.beat_times(1)=[];
                end
            else
                beat=[]; c.rejected_beats=c.rejected_beats+1;
            end
        else
            c.rejected_beats=c.rejected_beats+1;
        end
    end
    c.tracking=true; c.cycle_t=tc; c.cycle_y=0;
end
if c.tracking
    c.cycle_t(end+1)=t; c.cycle_y(end+1)=c.y;
    if t-c.cycle_t(1)>cfg.max_period_s || ...
            numel(c.cycle_t)>ceil(2*cfg.fs_hz*cfg.max_period_s)+4
        c.tracking=false; c.cycle_t=[]; c.cycle_y=[];
        c.rejected_beats=c.rejected_beats+1;
    end
end
c.previous_y=c.y; c.previous_t=t;
end
