function bounds=bppe_frame_tick_bounds(cfg)
%BPPE_FRAME_TICK_BOUNDS Encode existing M0 frame timing tests for RTL.
% Host-only conversion. The public frame checker remains authoritative.
% No new jitter/skew thresholds or protocol semantics are introduced.
tick=double(cfg.tick_period_ns); fs=double(cfg.fs_hz);
jitter=double(cfg.max_sample_jitter_fraction); skew=double(cfg.max_channel_skew_s);
if ~isscalar(tick) || ~isfinite(tick) || tick<1 || tick>1e9 || tick~=fix(tick) || ...
        ~isscalar(fs) || ~isfinite(fs) || fs<=0 || ...
        ~isscalar(jitter) || ~isfinite(jitter) || jitter<0 || jitter>=1 || ...
        ~isscalar(skew) || ~isfinite(skew) || skew<0
    error('BPPE:FrameTickDomain','Unsupported audited frame timing domain.');
end
% Evaluate the original expression in the same operation order, including
% its 1e-12 tolerance. Valid positive modular deltas form one integer interval.
valid=@(n) abs(n*tick*1e-9-1/fs)<=jitter/fs+1e-12;
center=1/(fs*tick*1e-9);
pivot=min(2^31-1,max(1,floor(center)));
if ~valid(pivot), pivot=min(2^31-1,pivot+1); end
if ~valid(pivot)
    error('BPPE:FrameTickDomain','No representable accepted sample interval.');
end
lo=1; hi=pivot;
while lo<hi
    mid=floor((lo+hi)/2);
    if valid(mid), hi=mid; else, lo=mid+1; end
end
bounds.min_delta_ticks=lo;
lo=pivot; hi=2^31-1;
while lo<hi
    mid=ceil((lo+hi)/2);
    if valid(mid), lo=mid; else, hi=mid-1; end
end
bounds.max_delta_ticks=lo;
% Include abs(-2^31), which is representable as signed modular skew.
lo=0; hi=2^31;
while lo<hi
    mid=ceil((lo+hi)/2);
    if mid*tick*1e-9<=skew, lo=mid; else, hi=mid-1; end
end
bounds.max_abs_skew_ticks=lo;
end
