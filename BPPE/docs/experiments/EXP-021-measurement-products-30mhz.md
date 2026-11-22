# EXP-021: Scheduled measurement products at the 30 MHz prototype target

Baseline: 366d1d5024dfaad471a17e3bc57b58cf0753d7f8 (EXP-020). The owner changed
the engineering-prototype target to 30 MHz; see ADR-006. This experiment both
reanalyses that baseline at 33.333 ns and measures a new arithmetic schedule at
the same period. It does not attribute the clock-relaxation benefit to RTL changes.

## Implementation and exact behavior

One existing bppe_guarded_multiplier is now shared by the measurement engine.
It replaces every mulq expression: variance squares, deviation/CV scaling,
the two ordered SQI products, standardization and each regression term. The
guarded divider remains unchanged. Registering the operands, product and guard
result removes the previous two guarded products plus division-request logic
from one CLEAN_DONE cycle. Integral beat logic and whole-cycle BRAM are unchanged.

The multiplier retains the EXP-020 full signed-64 guards and healthy 53-bit
domain, including asymmetric zero behavior. A common request/wait/continuation
path applies each precision delta before consuming its result. Variance addq
follows the square; CV clipping precedes its product; the first quality product
precedes the cleanliness product and division. Regression division, guarded
addition, accumulator clipping and final reason construction retain their
original order. Busy counter update times change; completed raw codes, final
fault counters and handshake-visible behavior remain the comparison contract.

Integer square-root trial and rounding squares also share the multiplier.
Search bounds are unchanged: 0 <= operand <= 94,906,265, and
94,906,265^2 = 9,007,199,136,250,225 < 2^53-1. Thus these formerly unguarded
squares are exactly representable and cannot introduce a precision fault.
A simulation assertion checks this invariant at every square completion.
The binary-search decision and nearest-integer rounding rule are unchanged.

The complete input/model/fault snapshot is still captured atomically. New
operands and the cleanliness quotient are retained across scheduled states.
Reset aborts the controller, multiplier and divider; blocked outputs remain
stable. Consuming a result and accepting the next request at the same edge is
supported. Pending result retention, overflow and serialized ACK behavior are
unchanged. No numeric width, channel count, window capacity, accuracy threshold
or product interface was changed.

## Functional verification

QuestaSim 10.6c: 22 positive simulations have zero errors and warnings, plus
one expected ACK/publication collision failure. Final source/script/vector
hashes match the completed run manifests. The unchanged multiplier retains
its EXP-020 independent arbitrary-precision boundary/random verification;
that unit test was not rerun for this unchanged file.

| Suite | Final completed evidence |
| --- | --- |
| Measurement/window | 288 unchanged MATLAB records, including 180 seeded random cases (4208), numeric/model/amplitude/CV boundaries; nine vector/flow/window simulations |
| Single-channel | 52,800 unchanged frames / 126 candidates; six vector/flow simulations |
| Multichannel | 151,200 unchanged frames / 303 candidates; seven positive vector/reset/fault simulations and the expected ACK collision |

New flow tests reset each of the 11 added request/wait/continuation states,
then check for leaked outputs and fault deltas. Existing divider, sqrt and
blocked-result reset tests remain. A simultaneous consume/accept test poisons
inputs after acceptance and checks snapshot isolation. Hand-computed full
three-channel/64-beat windows cover both zero variance and nonzero variance:
symmetric periods p +/- ONE/4 yield exact mean p, variance (ONE/4)^2, excessive
CV, SQI zero and only the low-quality reason. Balanced/wide exercise the capped
square-root search range; neither case acquires an arithmetic fault.

The newly scheduled work required replacing the old 500-cycle sqrt-entry
watchdog with the derived measurement budget. Golden values were not changed.
MATLAB/C++ algorithms and their saved vectors are unchanged; their own test
suites were not rerun. The known strong-impulse false-valid quality defect
remains; this is no evidence of clinical accuracy.

## Latency and throughput at 30 MHz

| Workload | EXP-020 max cycles | EXP-021 max cycles |
| --- | ---: | ---: |
| Measurement vectors, compact | 2394 | 2794 |
| Measurement vectors, balanced | 2436 | 3046 |
| Measurement vectors, wide | 2437 | 3052 |
| Single compact | 8824 | 8989 |
| Single balanced/wide | 8841 | 9091 |
| Multichannel compact | 22685 | 22895 |
| Multichannel balanced | 22718 | 23093 |
| Multichannel wide | 22730 | 23165 |

The baseline measurement-vector maxima are from EXP-018's completed runs;
that measurement RTL and those vectors remained unchanged through EXP-020.
The new directed 3x64 zero-variance case takes 4,126 cycles in all profiles;
nonzero variance takes 4,342 compact / 4,612 balanced and wide. These are
observations, not worst-case guarantees. The largest observed system latency,
23,165 cycles, corresponds to about 0.77217 ms at the target 30 MHz, excluding
arbitrary external completion stalls. Target-clock conversion is not a claim
that the FPGA has been implemented or run at that clock.

For default capacities and valid static configuration there are at most 40
divisions and 303 products per measurement. Products comprise three channels
times (64 variance + 27 search + 1 rounding + 4 quality), plus five standardization
and ten regression operations. Budget 58 clocks/division and eight/product
including request/wait/continuation, with loop/control margins:

- Measurement: 40*58 + 303*8 + 3*(2*64+32+8) + 5*64 + 128 = 5,696 clocks.
- Channel: unchanged EXP-020 budget, 27,412 clocks.
- Single-channel: 5,696 + 27,412 + 128 = 33,236 clocks.
- Three-channel: 5,696 + 3*27,412 + 128 = 88,060 clocks.

These conditional analytical regression watchdogs exclude external stalls and
reset; they are not formal WCET proofs or product throughput commitments.
At 30 MHz the system budget is 2.93533 ms, versus 2.85240 ms for EXP-020. This
leaves 7.06467 ms within the model's nominal 10 ms/100 Hz period, or 5.06467 ms
within an 8 ms timestamp-spacing stress interval, before other stalls. Three
channels share a frame; the budget already includes their serialized service.
Acquisition ticks remain 1 ms by default and do not set the core frequency.

The preprocess-only 11-cycle initiation interval is unchanged and is not a
full-frame throughput promise. The top's RESPONSE phase can wait indefinitely
for sample_ready; physical ADC ingress may be nonstallable or bursty regardless
of recorded timestamp spacing. Finite FIFO sizing still requires bounds on
bursts, consumer-stall duration/frequency and implemented service. Unbounded
backpressure cannot be made lossless by any finite FIFO. No queue depth or
bus/IRQ/concurrency semantics are frozen here.

## Matched 30 MHz synthesis comparison

Vivado 2026.1 build 6511674, xc7a200tfbg484-2, balanced defaults,
three physical channels and one synthesis worker. Baseline checkpoint:
20261106T055206747-0a9ab406; new full-top run: 20261106T145613229-d5a09bec.
Synthesis options and capacities are unchanged; the core clock is applied after
synthesis for both timing estimates. No false path or multicycle exception was
added. The original EXP-020 10ns WNS was -21.001ns; the same checkpoint at
33.333ns gives +2.332ns. That improvement is solely the target-period change.

| Metric | EXP-020 at 33.333 ns | EXP-021 at 33.333 ns |
| --- | ---: | ---: |
| LUT | 69474 | 67684 |
| FF | 54488 | 54943 |
| DSP | 139 | 42 |
| BRAM_tile | 6 | 6 |
| latch | 0 | 0 |
| Setup WNS, ns | 2.332 | 22.643 |
| Setup TNS, ns | 0 | 0 |
| Failing setup endpoints | 0 | 0 |

Full-top LUT changes by -1790
(-2.6%), and DSP by
-97. The measurement
hierarchy reports LUT/FF/DSP [15822, 22665, 9]; hierarchical attribution includes
cross-boundary optimization and is not an independent-core resource estimate.
The top uses 50.29% of device LUT capacity.

New worst path: `measurement/quality_reg[1][1]/C` to
`measurement/reason_flags_reg[0]/CE`; 10.450ns  (logic 4.870ns (46.603%)  route 5.580ns (53.397%));
32  (CARRY4=24 LUT2=1 LUT3=1 LUT4=3 LUT6=3).
Post-synthesis setup analysis satisfied: True.
This is a netlist estimate only, not achieved frequency or board readiness.

There is no placement/routing, full I/O delay or board pin/IOSTANDARD assignment.
HD.CLK_SRC remains unset; 1827 inputs and
861 outputs lack delay constraints. Internal endpoints
without a clock: 0; unconstrained internal endpoints:
0. Only balanced was synthesized; all
three profiles were simulated. No formal/netlist equivalence, gate-level
simulation or real-board capture was performed.

Synthesis warning counts: {'Synth 8-6014': 23, 'Synth 8-11357': 2, 'Synth 8-3936': 1, 'Synth 8-3332': 100, 'Timing 38-242': 1}. No ERROR or CRITICAL WARNING appears.
Known diagnostics include trimmed temporary/register bits, block-RAM optional
output-register advice, window-array handling and missing clock-location data.
The verified numerical result and actual mapping reports, rather than warning
absence alone, are the evidence for this iteration.

Baseline checkpoint SHA-256: D808CD694961C2F5CB8AD96CE56C677E6510CC6C06FBE75D16DB8E467B73FD04.


## Reproduce and evidence

```powershell
./toolchain/run_measurement_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_prototype_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_system_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_system_vivado.ps1 -VivadoBat C:/path/to/Vivado/bin/vivado.bat -SynthesisThreads 1 -AnalysisClockNs 33.333
```

Generate absent golden MEM vectors with the existing measurement/prototype/system
MATLAB exporters. Use absolute custom BuildRoot directories. Generated reports,
wave databases, vectors and checkpoints remain outside version control.

The baseline was reanalysed without resynthesis or modifying its checkpoint:

```tcl
open_checkpoint <EXP-020/synth/synthesized.dcp>
create_clock -name prototype_analysis_clk -period 33.333 [get_ports clk]
report_timing_summary -delay_type max -report_unconstrained -max_paths 20 -file <fresh-report>
report_clocks -file <fresh-clock-report>
```

Without -add, create_clock replaces the existing clock on this source/name;
see [AMD UG835](https://docs.amd.com/r/en-US/ug835-vivado-tcl-commands/create_clock).
The final analysis asserts a single clock with period 33.333 ns. Two initial
local checkpoint-analysis attempts stopped before reporting due to Tcl command
usage (read_checkpoint without an open design, then unsupported delete_clocks).
Neither resynthesized or modified the source checkpoint; only the completed
open_checkpoint/create_clock run is used for conclusions.

Final functional run IDs:

- Measurement/window: 20261106T145654635-fa759af5.
- Single-channel: 20261106T145307824-e76eef91.
- Multichannel: 20261106T145325301-9f62e756.

The prototype clock, frame and preprocess runners all default to 33.333 ns;
their PowerShell AST/default values were checked. Frame/preprocess standalone
synthesis was not repeated because only their default clock argument changed.
Testbench clocks retain their functional simulation periods; cycle counts,
not simulator nanoseconds, are used for the 30 MHz throughput calculation.
