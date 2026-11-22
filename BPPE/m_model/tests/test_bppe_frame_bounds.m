function tests=test_bppe_frame_bounds
tests=functiontests(localfunctions);
end

function testDefaultAndHalfMillisecond(t)
cfg=bppe_default_config(); b=bppe_frame_tick_bounds(cfg);
verifyEqual(t,[b.min_delta_ticks b.max_delta_ticks b.max_abs_skew_ticks],[8 12 2]);
cfg.tick_period_ns=500000; b=bppe_frame_tick_bounds(cfg);
verifyEqual(t,[b.min_delta_ticks b.max_delta_ticks b.max_abs_skew_ticks],[15 25 4]);
end

function testExactBoundaryPredicates(t)
% Independent exhaustive local comparison, including nonintegral nominal
% periods, zero jitter, ns ticks and modular half-range limits.
for tick=[1 37 1000 500000 1000000 1000000000]
    for fs=[0.1 1 73 100 125 1000]
        for jitter=[0 0.01 0.25 0.99]
            cfg=bppe_default_config(); cfg.tick_period_ns=tick;
            cfg.fs_hz=fs; cfg.max_sample_jitter_fraction=jitter;
            center=1/(fs*tick*1e-9);
            candidates=unique(min(2^31-1,max(1,[floor(center) ceil(center)])));
            accepted=@(n) abs(n*tick*1e-9-1/fs)<=jitter/fs+1e-12;
            if ~any(accepted(candidates))
                verifyError(t,@() bppe_frame_tick_bounds(cfg),'BPPE:FrameTickDomain');
                continue
            end
            b=bppe_frame_tick_bounds(cfg);
            n=unique([max(1,b.min_delta_ticks-100):min(2^31-1,b.min_delta_ticks+100), ...
                max(1,b.max_delta_ticks-100):min(2^31-1,b.max_delta_ticks+100)]);
            verifyEqual(t,n>=b.min_delta_ticks & n<=b.max_delta_ticks,accepted(n));
            k=b.max_abs_skew_ticks;
            verifyTrue(t,k*tick*1e-9<=cfg.max_channel_skew_s);
            if k<2^31, verifyFalse(t,(k+1)*tick*1e-9<=cfg.max_channel_skew_s); end
        end
    end
end
end

function testHalfRangeAndInvalidDomain(t)
cfg=bppe_default_config(); cfg.max_channel_skew_s=2^31;
cfg.tick_period_ns=1e9; cfg.fs_hz=1/(2^31-1); cfg.max_sample_jitter_fraction=0;
% Original floating operation order rejects this ideal zero-jitter period.
% Preserve that behavior rather than silently widening the host contract.
verifyError(t,@() bppe_frame_tick_bounds(cfg),'BPPE:FrameTickDomain');
cfg.max_sample_jitter_fraction=1e-12;
b=bppe_frame_tick_bounds(cfg);
verifyEqual(t,[b.min_delta_ticks b.max_delta_ticks b.max_abs_skew_ticks], ...
    [2^31-1 2^31-1 2^31]);
cfg.tick_period_ns=0.5;
verifyError(t,@() bppe_frame_tick_bounds(cfg),'BPPE:FrameTickDomain');
cfg.tick_period_ns=1; cfg.max_sample_jitter_fraction=1;
verifyError(t,@() bppe_frame_tick_bounds(cfg),'BPPE:FrameTickDomain');
end
