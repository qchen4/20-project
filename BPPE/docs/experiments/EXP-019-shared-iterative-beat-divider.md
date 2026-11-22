# EXP-019: Shared iterative division in the whole-cycle beat engine

Baseline: 7dec62f0c2434594dc175a7763e666f50e0c4ca4 (EXP-018). This iteration
changes beat arithmetic scheduling, retaining the existing algorithm, numerical
profiles, 304-sample capacity plus closing slot, three physical channel cores,
64-beat windows and external ready/valid ports.

## Implementation and numerical contract

Each bppe_beat_core now instantiates one bppe_rounded_divider, shared across
crossing interpolation, period-to-seconds conversion, rise, every normalized
sample, width, area and amplitude/DC ratio. The multichannel top has three such
beat units plus the existing measurement divider. A common request/wait path
and explicit continuations replace all combinational divq calls in this core.

The unit retains full signed-64 input guards, zero-divisor priority, the exact
53-bit healthy domain, and nearest rounding with ties away from zero. Operands,
the crossing base timestamp, sample and configuration are captured before the
host may change inputs. Each operation's fault delta is applied before its
continuation. Existing multiplication/addition guards and final clipping order
are retained. Busy-state counter update times change; completed transaction
codes, cumulative counters and fault/rejection behavior remain the comparison
contract. No old busy-state cycle timing or new minimum throughput is promised.

The normalization loop now returns to its request state for each stored sample.
Reset aborts both controller and divider, preventing a delayed quotient or fault
delta from leaking into the next history. Idle-only history clear preserves the
existing cumulative fault counters. Blocked output remains stable and input
remains backpressured. Whole-wave storage and window snapshots are unchanged;
there is no narrower numerical profile, shortened history or reduced channel
count in this iteration.

## Functional verification

QuestaSim 10.6c: 32 positive simulations have zero errors and warnings, plus
one intentionally rejected ACK/publication collision. Existing MATLAB golden
vectors are unchanged; MATLAB/C++ algorithm sources are unchanged.

| Suite | Completed comparisons |
| --- | --- |
| Beat | 39,120 sample/state records, 42 profile/case combinations, 570 emitted beats; complete retained buffer contents and final fault counters |
| Channel pipeline | 19,524 ADC samples; output stalls, two occupied stages, simultaneous acceptance/consumption and upstream fault snapshot isolation |
| Frame dispatch and acquisition | Each path checks 17,856 complete frames and 288 beats; malformed-frame rejection, history-reset fencing, held output and fault carry |
| Single-channel prototype | 52,800 frames / 126 candidates; all three numerical profiles, pending/overflow/ACK and integer deadline regressions |
| Multichannel prototype | 151,200 frames / 303 candidates; one to three channels, primary-channel choices, numeric/measurement/pending reset, initial faults and expected ACK collision |

Directed beat tests additionally reset during each of seven divider
continuations, wait beyond the abandoned operation's completion time, and check
for leaked outputs/faults. A hand-computed rectangular waveform fills all 304
permitted samples and closes through slot 305. All three profiles produce the
expected five features, crossing time, counters and restarted buffer. Input and
configuration poisoning, retained output, capacity-overrun and numeric-fault
recovery remain covered.

The initial staged implementation missed the return from NORM_DONE to INTEGRATE;
unchanged golden vectors caught the area mismatch, and the continuation was
fixed before final testing/synthesis. One frame test still had a fixed
3000-cycle timeout; it now uses the derived channel bound, without changing
golden values. An initial simulator invocation used a relative custom log path
and failed before simulation; final runs use absolute isolated directories.

The known impulsive-noise false-valid quality behavior is preserved, not fixed
or presented as clinical validation.

## Latency and watchdog bounds

A complete beat requires at most 305 normalization divisions plus crossing,
period, rise and three final features: 311 divisions. Allow 58 cycles per
request/iteration/round/continuation, two complete buffer scans and control:

- Beat bound: (304+7)*58 + 2*(304+1) + 64 = 18,712 cycles.
- Channel bound: 18,776 cycles, including preprocessing/elastic control margin.
- Measurement bound remains 3,208 cycles from EXP-018.
- Single-channel bound: 3,208 + 18,776 + 128 = 22,112 cycles.
- Multichannel bound: 3,208 + 3*18,776 + 128 = 59,664 cycles.

These are conservative test watchdogs for default experimental capacities,
excluding arbitrary external output stalls. They are not product deadlines.
The maximum-capacity beat test measures 18,340 cycles in every profile. Existing
beat vectors measure a maximum of 9,313 cycles. The independent acquisition
stress test measures a maximum full-frame latency of 15,606 cycles, including
its deterministic completion stalls.

| Existing end-to-end workload | EXP-018 max cycles | EXP-019 max cycles |
| --- | ---: | ---: |
| Single compact | 1849 | 7150 |
| Single balanced/wide | 1866 | 7167 |
| Multichannel compact | 2900 | 17948 |
| Multichannel balanced | 2933 | 17981 |
| Multichannel wide | 2945 | 17993 |

The preprocessing-only minimum initiation interval remains 11 cycles. It is
not a complete-frame input interval: channel work, measurement, assembly and
completion readiness gate the actual top. Sensor timestamps in golden vectors
do not establish constant-rate real-time ingress on a physical board.

## Same-condition full-top synthesis

Vivado 2026.1 build 6511674, xc7a200tfbg484-2, balanced defaults, three
physical channel cores and one synthesis worker, with the identical EXP-018
scripts. Synthesis itself is unconstrained; the 10ns analysis clock is applied
after synthesis. No timing exception was added. The existing completed baseline
is 20261106T043732754-864b08f1; this run is 20261106T052726949-94f655c6.

| Metric | EXP-018 | EXP-019 |
| --- | ---: | ---: |
| LUT | 288918 | 121495 |
| FF | 140614 | 142156 |
| DSP | 391 | 391 |
| BRAM_tile | 0 | 0 |
| latch | 0 | 0 |
| Setup WNS, ns | -216.433 | -23.151 |
| Setup TNS, ns | -1.26024e+07 | -71134.1 |
| Failing setup endpoints | 79321 | 67582 |

Full-top LUT falls by 57.9%. The three beat hierarchy LUT counts change
from [91705, 66155, 65968] to [45576, 19722, 19542]. Hierarchical attribution includes cross-boundary
optimization and is not an independent-core area sum.

The top passes the full-top device resource-capacity gate: 121495 of
134,600 LUT (90.26%). Resource fit alone is not
timing closure or board readiness. WNS is -23.151ns under the
10ns assumption, with no placement/routing. The new worst path is
`acquisition/channels[0].core/beat/cycle_t_reg[119][1]/C` to
`acquisition/channels[0].core/beat/precision_count_reg[60]/D`;
data path 33.105ns  (logic 22.185ns (67.014%)  route 10.920ns (32.986%)),
logic levels 86  (CARRY4=64 DSP48E1=4 LUT1=1 LUT2=3 LUT3=2 LUT4=1 LUT5=3 LUT6=5 MUXF7=2 MUXF8=1).

1827 input ports and 861 output
ports lack delay constraints; HD.CLK_SRC is unset. No board pins/IOSTANDARD,
physical input adapter/FIFO, implemented clock or I/O timing contract has been
validated. Cache organization is unchanged; BRAM use is
0. Next use the reported remaining paths
to schedule guarded products and restructure storage with explicit synchronous
memory ports while retaining complete cycles and snapshot isolation.


## Reproduce and evidence

```powershell
./toolchain/run_beat_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_channel_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_frames_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_prototype_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_system_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_system_vivado.ps1 -VivadoBat C:/path/to/Vivado/bin/vivado.bat -SynthesisThreads 1
```

Use the existing EXP-008/009/015/012/016 MATLAB exporters if their MEM vectors
are absent. Each run records source/script/vector hashes and simulator metadata.
For a custom BuildRoot supply an absolute directory. Generated vectors, logs,
wave databases, reports and checkpoints remain outside version control.

Completed simulation run IDs:

- Beat: 20261106T052631428-3b933ac4.
- Channel: 20261106T052727032-6c2efe82.
- Frame/acquisition: 20261106T052852940-e8f620fc.
- Single-channel: 20261106T052913721-c9d92a63.
- Multichannel: 20261106T052932787-73229967.

Product bus, physical ADC buffering, IRQ/W1C/lifecycle and ACK/publication race
priority remain unfrozen. The approved serialized ACK behavior is preserved.
