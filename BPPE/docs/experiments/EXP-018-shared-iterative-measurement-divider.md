# EXP-018: Shared iterative division in the measurement evaluator

Numerical baseline: main 21aae12e2b755fd1b49624d3b7dea830686f7c51 (same RTL as
EXP-016/a54879e). This changes measurement arithmetic scheduling, not numerical
profiles, algorithm parameters, channel/buffer capacities or system interfaces.

## Implementation and exact arithmetic contract

bppe_rounded_divider captures signed 64-bit numerator/denominator on ready/valid
acceptance. Zero divisor is tested FIRST and returns zero with one divzero
delta, even when the numerator is outside the exact host domain. Otherwise a
magnitude above 2^53-1 returns zero with one precision delta. These guards use
the full 64-bit inputs, including INT64_MIN; healthy magnitudes alone are
narrowed to 53 bits. Precision is not reduced.

Healthy division uses 53 restoring iterations, producing quotient and remainder
together. A final step rounds nearest with ties away from zero and restores the
sign. Accepted edge 0 produces the healthy output at edge 54; with no output
stall the unit's initiation interval is 55 cycles. Guarded faults complete on
the acceptance edge. Output result/flags remain stable under backpressure.
Reset aborts in-flight work and clears held output. Consuming an output and
accepting the next operation on the same edge is supported.

Every rounded division in bppe_measurement_core now uses this ONE shared unit:
period mean, variance mean, CV, regularity, cleanliness, quality scaling,
feature means, standardization, regression terms and pressure encoding. Explicit
request/wait/continuation states preserve arithmetic order, clipping points and
the original zero/precision/saturation counter updates. QUALITY is split across
registered stages instead of chaining its divisions in a single cycle.

The complete request window/model/fault snapshot remains latched atomically.
The caller can still change input arrays after acceptance and collect the next
window while the evaluator is busy. Published results and final fault totals
remain bit-exact. Live diagnostic counter updates occur later as operations
complete; no old cycle-by-cycle busy-state timing is promised. No multicycle or
false-path timing exception was added to hide combinational paths.

## Functional verification

QuestaSim 10.6c: 23 positive simulations pass with zero errors/warnings, plus
one intentionally rejected ACK/publication collision:

| Suite | Evidence |
| --- | --- |
| Divider | 14,481 independent exact-Python boundary/random records; all signs, odd/even ties, zero, +/-2^53 boundaries, INT64 extrema, blocked inputs/outputs, reset during iteration and simultaneous consume/accept |
| Measurement/window | 288 unchanged MATLAB records, including 180 deterministic randomized cases (seed 4208), amplitude/CV/model/fault boundaries; nine vector/flow/window simulations |
| Single-channel prototype | 52,800 unchanged frames / 126 candidates; six vector/flow simulations |
| Multichannel system | 151,200 unchanged frames / 303 candidates; seven positive vector/reset/fault simulations and the expected ACK-collision rejection |

Divider stimulus seed is 18053: 12,376 healthy, 21 zero-divisor and 2,084
precision-fault records. Expected results use arbitrary-precision integer
divmod and explicit rounding, independent of the restoring RTL implementation.
The measurement cases still compare directly to the public MATLAB fixed model.
Golden numerical values and counter expectations were not changed.

Tests cover reset during the new divider's iterations as well as sqrt/search,
active system measurement, held candidate/pending results and output stalls.
Fault counters, snapshot isolation, frame-error recovery and serialized ACK
behavior remain verified. The existing impulsive-noise quality gap is retained.
Neither the MATLAB algorithm nor C++ references were edited in this experiment.

## Latency and watchdog derivation

A measurement has at most 6*3+5+5+10+2 = 40 divisions. Budget 58 clocks per
healthy request/iteration/round/continuation sequence; guarded cases are shorter.
Remaining loops are bounded by 64 beats, three channels, five feature means
and the <=28-step sqrt search. numeric_latency_bounds.svh derives:

- Measurement watchdog: 40*58 + 3*(2*64+32+8) + 5*64+64 = 3208 cycles.
- Single-channel watchdog: 4010 cycles, adding a 304-sample channel scan and control.
- Multichannel watchdog: 5358 cycles, adding three such channel scans/control.

An initial window-store test still had its old 2000-cycle timeout and failed;
all evaluator consumers now use the derived bounds, retaining deadlock checks.
The independent three-channel/64-beat flow case passes the measurement bound.
These are experimental test bounds, not approved product latency requirements.

Observed max processing latency (before external completion stalls):

| Workload | Before | After |
| --- | ---: | ---: |
| Single-channel compact | 253 | 1849 |
| Single-channel balanced/wide | 270 | 1866 |
| Multichannel compact | 620 | 2900 |
| Multichannel balanced | 653 | 2933 |
| Multichannel wide | 665 | 2945 |

Healthy calls add 57 cycles versus the prior in-state expression (28 calls in
the full single-channel case, 40 in the full three-channel case). This trades
parallel combinational logic for cycles. The preprocessing interval remains
eleven cycles. Full-frame input is also gated by channel work, measurement and
completion readiness; it is not an eleven-cycle frame initiation guarantee.
Arbitrary consumer stalls remain unbounded. No achieved Hz, minimum real-time
sampling throughput or board clock is inferred from simulation cycle counts.

## Same-device synthesis comparison

Both completed runs use SynthesisThreads=1 (one synthesis worker, in addition
to Vivado's manager/helper processes). The fresh original-RTL baseline
20261106T044822717-5ac48456 reproduces EXP-017's two-worker netlist checksum
51c8cc9a, resource counts and timing values. The new divider definition was also
parsed in the matched baseline read list but is not instantiated by its old
measurement core. Only the optimized core instantiates the shared unit.

Vivado 2026.1 build 6511674, xc7a200tfbg484-2, balanced defaults, three physical
channel cores, identical script/constraints. Synthesis is unconstrained; the
10ns analysis clock is applied AFTER synthesis. No I/O delays, board pins,
placement/routing or implemented timing signoff exist.

| Metric | Before | After |
| --- | ---: | ---: |
| Full-top LUT | 328859 | 288918 |
| Full-top FF | 140037 | 140614 |
| DSP | 391 | 391 |
| BRAM / latch | 0 / 0 | 0 / 0 |
| Measurement hierarchy LUT | 57821 | 17765 |
| Setup WNS, ns | -427.170 | -216.433 |
| Setup TNS, ns | -12768501 | -12602351 |
| Failing setup endpoints | 80541 | 79321 |

Measured integrated divider attribution is 607 LUT, 227 FF, zero DSP. The
measurement hierarchy LUT reduction is 69.3%, and full-top LUT reduction is
12.1%. Hierarchy attribution includes cross-boundary optimization/packing and
is not a sum of independent stand-alone core measurements.

Worst path moves from measurement/deviation_reg to measurement/quality_reg
(437.124ns, 2370 levels) to acquisition/channels[0].core/beat/cycle_y_reg[119][0]
through beat/precision_count_reg[10] (226.387ns, 1206 levels). The remaining
beat engine's combinational arithmetic is now the leading critical path.

The optimized top STILL DOES NOT FIT AX7A200: 288,918/134,600 LUT = 214.65%.
The resource-capacity gate therefore intentionally returns failure after the
completed batch and retained reports. Negative WNS still fails the 10ns
analysis assumption; no timing closure or usable board frequency is claimed.
1,827 inputs and 861 outputs still lack delay constraints; HD.CLK_SRC is unset.

The first two-worker optimized attempt was deliberately stopped when available
host memory fell to about 493MiB. Its partial output is not a synthesis result.
Lower-concurrency fresh runs preserve separate source manifests and reports;
only this task's verified process tree was stopped. No user process was stopped.

## Cache mapping assessment and next work

Whole-cycle semantics and capacities remain unchanged: the beat core declares
305 slots (304 samples plus a closing boundary) for each of cycle_t/cycle_y,
and windows support 64 beats per channel. BRAM use remains zero. The source
has multiple write-address forms, two writes during RESTART, combinational
indexed reads, and whole-window parallel ports/snapshot copies. These patterns
require deliberate address/port/read-latency restructuring for BRAM inference;
shrinking the data history or silently reducing numeric widths is not the fix.

A next cache iteration can retain the complete wave while using explicit
memory ports, synchronous-read staging, sequential restart writes and cached
previous timestamps. Any 48-bit time / SIGNAL_W storage narrowing must retain
explicit signed-64 read/arithmetic semantics and be justified by the existing
clip contract. Window snapshots can use isolated banks/atomic bank selection;
next-window collection must remain independent of the evaluator snapshot.
No such storage-interface change is implemented or frozen here.

Priority remains replacing beat-engine combinational divisions with scheduled
shared arithmetic, then BRAM-oriented storage and renewed whole-top PPA.
Product bus/physical ADC buffering, minimum throughput and clock targets remain
unfrozen. This experiment changes no AHB/AXI protocol or product interface.

## Reproduce

```powershell
python ./toolchain/generate_divider_vectors.py ./build/divider-vectors
./toolchain/run_divider_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_measurement_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_prototype_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_system_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_system_vivado.ps1 -VivadoBat C:/path/to/Vivado/bin/vivado.bat -SynthesisThreads 1
```

Regenerate MATLAB vectors with the existing EXP-011/012/016 exporters first if
they are not available; convert the measurement CSV with
measurement_vectors_to_mem.py before its RTL runner. Divider vectors were
generated with Python 3.13.0. Each simulator/synthesis run records raw source,
script/vector hashes and tool metadata. Generated MEM/log/checkpoint/report
files remain outside version control. The completed optimized run is
20261106T043732754-864b08f1; its capacity-gate failure is expected.
