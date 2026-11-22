# ADR-005: Integer tick observation deadlines

Status: owner-confirmed for the engineering prototype, 2026-11-06.

The owner approved replacing floating-second timeout comparisons with integer
tick deadlines, updating both MATLAB and RTL and adding boundary regressions.
Observed failure: with 1 ms ticks, an observation starting at tick 8020 and
ending at 18020 has floating elapsed difference `9.9999999999999982`; the old
`>=10` test misses that exact 10-second boundary and waits another frame.

For the audited integer-nanosecond timing profile, host configuration converts
warmup/timeout seconds to nearest integer nanoseconds once. Positive duration
thresholds are then rounded up to sampling ticks using exact bounded integer
quotient/remainder arithmetic. The initial deadline rounds the combined
warmup-plus-timeout duration once. Subsequent deadlines are the completed
window's elapsed tick plus the encoded timeout duration. Warmup uses its own
rounded-up tick threshold. Runtime decisions compare integer elapsed ticks.

Reporting fields in seconds remain descriptive and do not decide expiry.
The numerical helper reports whether constants are in the audited exact domain:
integer-ns tick, positive encoded timeout, and nanosecond sums <= 2^53-1.
General M0 host configurations outside that domain retain a host conversion
fallback; they are not accepted by the hardware prototype vector exporter or
claimed as verified hardware configurations. No product timing profile is
frozen by this experiment.

The frame-level comparison is evaluated on accepted acquisition ticks, not
simulation-clock latency. Snapshot/window clear preserves the causal beat
cycle. Legacy saved runtime states must be reinitialized to obtain the new
deadline fields. Feature-kernel arithmetic is unchanged.

MATLAB float/fixed boundary tests and prototype RTL test both the tick just
before expiry and the exact deadline. See EXP-012 for integrated validation.
