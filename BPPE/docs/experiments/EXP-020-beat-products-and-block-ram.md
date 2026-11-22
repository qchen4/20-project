# EXP-020: Scheduled beat products and synchronous whole-cycle block RAM

Baseline: c63fcca439c7b752a3343436828de9245ab3edf9 (EXP-019). This iteration
separates beat multiplication, precision checking, accumulation and memory reads
across clock cycles. It retains the three numerical profiles, 304 retained
samples plus the closing slot, three physical channel cores, 64-beat windows,
existing feature definitions and external ports.

## Arithmetic and fault order

Each beat engine now shares one bppe_guarded_multiplier. It captures signed-64
operands and guards, registers a 53-by-53-bit magnitude product, then checks the
106-bit product and restores its sign. It accepts a transaction at edge zero
and asserts its result at edge two; minimum initiation interval is three clocks
when output is consumed. Backpressured output is held; consumption and a new
acceptance can coincide. Reset aborts all stages.

Let L=2^53-1. The previous mulq faults when abs(x*y)>L, including its asymmetric
special case y=0 and abs(x)>L. The new precheck abs(x)>L OR
(abs(y)>L AND abs(x)!=0), followed by a full-product range check, is equivalent:
for nonzero integer operands, either out-of-domain magnitude makes the product
too large; x=0 remains a valid zero except when the first-operand guard itself
fails. Thus x=0,y=INT64_MIN is valid zero, while x=INT64_MIN,y=0 faults. The
independent Python reference computes the mathematical product directly with
unbounded integers, without duplicating this decomposed RTL precheck.

All beat mulq calls use this unit. Each multiply fault delta is applied before
the next arithmetic continuation. Integral width multiplication, width addq,
area multiplication and area addq execute in the original order. The existing
divider, addition guards, clipping, rejection and counter-wrap behavior are
unchanged. Busy-state counter update times change; completed sample/beat codes,
cumulative counters and handshake-visible results are the comparison contract.
No earlier internal busy timing or new minimum throughput is promised.

## Whole-cycle storage and reset safety

Both cycle_t and cycle_y remain signed-64 arrays with 305 entries. They now have
one synchronous read port and one write port, mutually exclusive in the
controller. SCAN/SCAN_EVAL and INTEGRATE/NORM_PREP separate read request from use.
The first timestamp and previous integration timestamp are cached in registers.
A crossing is written before scanning; restart writes the crossing and first
positive sample on separate cycles before releasing the completed transaction.

RAM contents are not reset. Reset clears tracking/length/control and aborts the
shared arithmetic units, so no stale entry is read before a valid history is
written. Idle-only history clear retains cumulative numeric faults, as before.
Assertions check valid read range, write capacity and nonoverlapping read/write
phases. Output stability, input/config capture, capacity rejection and history
fencing are retained. The coding pattern follows the synchronous-memory approach
in [AMD UG901](https://docs.amd.com/r/en-US/ug901-vivado-synthesis/Simple-Dual-Port-Block-RAM-with-Single-Clock-Verilog);
the actual inferred resources are checked below.

## Functional verification

QuestaSim 10.6c: 33 positive simulations with zero errors/warnings, plus one
expected ACK/publication collision failure. All source/script/vector hashes
were checked against the completed run manifests. Existing MATLAB/C++ sources
and golden vectors are unchanged; those model test suites were not rerun in
this iteration. The known strong-impulse false-valid quality defect is retained.

| Suite | Completed evidence |
| --- | --- |
| Guarded multiplier | 14,481 boundary/random mathematical-reference records, seed 20053; 4,483 healthy and 9,998 precision faults; signed extremes, asymmetric zero, poisoned inputs, held output, reset at every stage, consume/accept coincidence |
| Beat | 39,120 sample/state records, 42 profile/case combinations, 570 beats; complete retained-buffer contents and final fault counters |
| Channel | 19,524 samples; output stalls, two occupied stages, simultaneous acceptance/consumption, upstream fault isolation |
| Frame and acquisition | Each path: 17,856 frames and 288 beats; malformed rejection, reset fencing, held output and fault carry |
| Single-channel | 52,800 frames and 126 candidates; all profiles, pending/overflow/ACK, integer deadlines |
| Multichannel | 151,200 frames and 303 candidates; 1–3 channels and primary choices, numeric/measurement/pending reset, initial faults, expected ACK collision |

Each profile additionally tests reset in seven divider continuations and 13
new product/RAM/control stages, then waits beyond an abandoned operation's
completion and checks for leaked outputs/fault deltas. A hand-computed waveform
fills all 305 slots and checks five features, time, counters and restarted
history. Initial staged compilation found a declaration-order dependency under
Questa 10.6c; declarations were moved before use before the final simulations.

Multiplier MEM SHA-256:
14a4b88ad0f5f7bf4b55917a344092ff1dc74908c9342826512b7e44d314bdcb.

## Observed latency and conditional budgets

| Workload | EXP-019 maximum cycles | EXP-020 maximum cycles |
| --- | ---: | ---: |
| Existing beat golden vectors | 9313 | 12222 |
| Directed full 305-slot beat | 18340 | 24156 |
| Acquisition stress frame, including its deterministic stalls | 15606 | 20347 |
| Single compact | 7150 | 8824 |
| Single balanced/wide | 7167 | 8841 |
| Multichannel compact | 17948 | 22685 |
| Multichannel balanced | 17981 | 22718 |
| Multichannel wide | 17993 | 22730 |

These maxima describe the exercised workloads, not all possible inputs. The
full-capacity beat increases by 5,816 cycles; synchronous reads and scheduled
products trade service latency for resources and shorter combinational paths.

For N<=305 stored points, a complete beat uses at most N+6=311 divisions and
3N+4=919 multiplications: crossing (1), period (2), rise (1), normalization (N),
two integral products per segment (2N-2), final width and amplitude (2).
Allow 58 clocks per division and 8 per product, including request/wait/resume;
6N additional clocks cover synchronous read/scan/integration control and 128
fixed clocks cover preparation, finalization and restart. The test watchdogs in
numeric_latency_bounds.svh are therefore:

- Beat: 311*58 + 919*8 + 6*305 + 128 = 27,348 clocks.
- Channel: beat + 64 = 27,412 clocks, including preprocessing/control margin.
- Measurement: unchanged 3,208 clocks (EXP-018).
- Single-channel: 3,208 + 27,412 + 128 = 30,748 clocks.
- Three-channel system: 3,208 + 3*27,412 + 128 = 85,572 clocks.

These are analytically budgeted regression watchdogs for the supported profiles,
default capacities, stable valid configuration and no arbitrary external stalls
or reset. They are not a formal WCET proof or a product deadline. Hardware or
capacity changes require rederivation; unbounded consumer delay has no finite
completion bound. The preprocess-only 11-clock initiation interval remains
unchanged and does not describe the top-level complete-frame throughput.

## Sampling, backpressure and physical buffering

The actual model default is 100Hz, 1ms timestamp ticks and one channel
(m_model/bppe_default_config.m); the prototype supports up to three channels
inside each frame. Three channels do not imply three times the frame arrival
rate. Frame-bound tests accept 8–12 ticks by default. An 8ms spacing corresponds
to a 125-frame/s stress arrival only if wall-clock delivery follows timestamps;
it is not a new configured sample rate or a verified product limit. Recorded
frames can arrive in bursts regardless of their timestamp spacing.

bppe_multichannel_prototype accepts input only in INPUT with channel_ready;
its RESPONSE phase holds completion until sample_ready. Acquisition serializes
channel events, so the system budget includes three channel services. Pending
result retention itself does not halt computation; later results set overflow,
while ACK remains separate and serialized away from publication as agreed.

Using the conditional C=85,572-clock budget above, excluding external stalls:

| Hypothetical core clock | C/f service time | Comparison |
| --- | ---: | --- |
| 1MHz | 85.572ms | Exceeds nominal 10ms frame period |
| 10MHz | 8.5572ms | Leaves 1.4428ms at 100Hz; exceeds the 8ms stress period |
| 100MHz | 0.85572ms | Leaves 9.14428ms at 100Hz or 7.14428ms at 8ms spacing |

These are arithmetic scenarios, not achieved clock rates or supported maximum
sampling rates. With zero other stalls, C/period requires 8.5572MHz for 100Hz
or 10.6965MHz for the 8ms stress interval. A bounded external stall S adds
S/f seconds when S is in core clocks. The 100MHz scenario is specifically not
supported by the present negative 10ns timing slack.

A ready/valid source can hold a frame until accepted. A physical nonstallable
ADC needs a buffering adapter whose depth depends on ingress bursts, service
time, consumer-stall duration/frequency and the implemented clock. In general
the queue must cover sup_t(A(t)-D(t)) for cumulative arrivals/departures under
the stated traffic/service assumptions. An isolated stall can accumulate
ceil(frame_rate*stall_seconds) arrivals plus an initial burst, but repeated
stalls also require enough recovery service; this is not a universal FIFO
formula. With unbounded sample_ready stalls, no finite FIFO guarantees lossless
continuous ingress. No physical FIFO depth, product throughput target, clock,
bus/IRQ contract or ACK race priority is frozen by this experiment.

## Same-condition synthesis

Vivado 2026.1 build 6511674, xc7a200tfbg484-2, balanced defaults and
three physical channel cores; one synthesis worker, unchanged synthesis options
and timing assumptions. Only the new source was added to the runner/Tcl input
lists. Synthesis is unconstrained; the 10ns clock is applied after synthesis.
No false path or multicycle timing exception was added. Existing baseline:
20261106T052726949-94f655c6; this run: 20261106T055206747-0a9ab406.

| Metric | EXP-019 | EXP-020 |
| --- | ---: | ---: |
| LUT | 121495 | 69474 |
| FF | 142156 | 54488 |
| DSP | 391 | 139 |
| BRAM_tile | 0 | 6 |
| latch | 0 | 0 |
| Setup WNS, ns | -23.151 | -21.001 |
| Setup TNS, ns | -71134.1 | -6560.71 |
| Failing setup endpoints | 67582 | 766 |

LUT decreases 42.8%,
FF 61.7% and
DSP 64.5%.
All six cycle_t/cycle_y arrays are reported as block RAM, with two RAMB36E1 per
beat core. This is actual synthesis inference, not a conclusion from ram_style
alone. Storage widths and the complete 305-slot capacity are retained.
Beat hierarchy LUT counts are [28153, 4083, 3830]; cross-boundary
optimization makes these unsuitable as independent-core area estimates.

The full top fits device resource capacity: 69,474 / 134,600 LUT (51.62%).
The former cache-to-precision-counter worst path is no longer the top path.
The new worst path runs from `measurement/regularity_reg[0]/C` to
`measurement/div_numerator_reg[24]/D` in the measurement core:
30.955ns  (logic 22.412ns (72.401%)  route 8.543ns (27.599%)); 65  (CARRY4=46 DSP48E1=6 LUT1=1 LUT2=4 LUT3=4 LUT4=1 LUT5=1 LUT6=2).
The measurement arithmetic was not changed in this iteration.

WNS remains -21.001ns under the 10ns analysis assumption. This is not timing
closure, achieved Fmax or board signoff. There is no placement/routing or board
pin/IOSTANDARD assignment; 1,827 inputs and 861 outputs lack delay constraints,
and HD.CLK_SRC is unset. No post-synthesis equivalence or gate-level simulation
was performed. Balanced is the only synthesized profile; all three profiles
were functionally simulated.

Warnings by ID: {'Synth 8-6014': 23, 'Synth 8-11357': 2, 'Synth 8-3332': 89, 'Synth 8-13373': 30, 'Synth 8-3936': 1, 'Timing 38-242': 1}. They include unused temporary/optimized
registers, the existing window-array runtime warning and missing HD.CLK_SRC.
No ERROR or CRITICAL WARNING appears. Vivado also reports that the six RAMs lack
an optional internal output register; an added register may improve later
timing, but was not silently inserted into this functional contract. Other
window/snapshot arrays remain register based. synth_design elapsed 3m48s;
report_timing_summary 1m11s; these local run times are not another-CPU benchmarks.


## Reproduce and evidence

```powershell
python ./toolchain/generate_multiplier_vectors.py ./build/multiplier-vectors
./toolchain/run_multiplier_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_beat_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_channel_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_frames_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_prototype_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_system_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_system_vivado.ps1 -VivadoBat C:/path/to/Vivado/bin/vivado.bat -SynthesisThreads 1
```

Existing EXP-008/009/015/012/016 MATLAB exporters provide the other golden MEM
vectors if absent. Use absolute custom BuildRoot directories. Each completed
run records source/script/vector hashes and tool metadata. Generated vectors,
logs, waves, reports and checkpoints remain outside version control.

| Completed run | ID |
| --- | --- |
| Multiplier | 20261106T054937582-500ffafa |
| Beat | 20261106T055038455-4a90a84a |
| Channel | 20261106T055207763-1ce15927 |
| Frame/acquisition | 20261106T055222551-0bdcd7d7 |
| Single-channel | 20261106T055243215-f7f7f01a |
| Multichannel | 20261106T055300084-649e85db |
| Vivado | 20261106T055206747-0a9ab406 |

Next inspect the reported measurement product/guard path, keeping fault order
and exact arithmetic. Board implementation/I/O constraints and a bounded
physical ingress/consumer contract remain necessary before real-time signoff.
No clinical accuracy or real-sensor validation is claimed.
