function timing=bppe_window_timing(cfg)
% Host conversion only. Runtime deadlines and elapsed comparisons use ticks.
warmup_ns=round(cfg.warmup_s*1e9);timeout_ns=round(cfg.timeout_s*1e9);
tick=cfg.tick_period_ns;limit=2^53-1;
timing.exact_ns_constants=tick==fix(tick) && tick>=1 && tick<=limit && ...
    timeout_ns>=1 && warmup_ns>=0 && warmup_ns+timeout_ns<=limit;
if timing.exact_ns_constants
    timing.warmup_ticks=ceil_ratio(warmup_ns,tick);
    timing.timeout_ticks=ceil_ratio(timeout_ns,tick);
    timing.initial_deadline_ticks=ceil_ratio(warmup_ns+timeout_ns,tick);
else
    % Preserve general M0 host-configuration availability. Fractional-ns or
    % very large constants are outside the audited hardware timing profile.
    tick_s=tick*1e-9;
    timing.warmup_ticks=ceil(warmup_ns/tick);
    timing.timeout_ticks=max(1,ceil(cfg.timeout_s/tick_s));
    timing.initial_deadline_ticks=ceil((cfg.warmup_s+cfg.timeout_s)/tick_s);
end
end
function result=ceil_ratio(n,d)
base=floor(n/d);remainder=n-base*d;
if remainder<0,base=base-1;remainder=remainder+d;end
if remainder>=d,base=base+1;remainder=remainder-d;end
result=base+double(remainder>0);
end
