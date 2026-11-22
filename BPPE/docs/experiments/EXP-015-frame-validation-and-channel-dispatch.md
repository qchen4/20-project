# EXP-015: Ordered frame validation and multi-channel acquisition

Baseline: main 1a45faeb133f47e1af8ef6673f1972cf3deb71dd.
Scope: running-session typed acquisition frames through preprocessing and
whole-cycle beat/features, with one to three independent channel histories.
This is not the complete multi-channel measurement/publication engine.

## RTL contract and ordering

bppe_frame_dispatch buffers a complete frame and validates it before exposing
any channel event. Accepted frames emit channels 0 through N-1 in order.
Rejected frames emit exactly one rejection event, with the original tag and
sequence. Events use ready/valid and remain stable under output backpressure;
ingress cannot accept another frame until the current frame has dispatched.
The source must retain a presented frame until accepted. There is no implicit
ADC FIFO or guarantee against physical acquisition overrun.
Simulation rejects sessions approaching the limit of MATLAB's exactly
representable integer elapsed ticks; it does not invent a product overflow
reason or a maximum session-duration requirement.

The checker follows public bppe_step_float precedence:

1. Configuration mismatch: CONFIG_ERROR (1024), retain processing history.
2. Missing active-channel valid bit: SAMPLE_GAP (2).
3. Active-channel saturation bit: ADC_SATURATED (4).
4. Excess signed modular channel skew: TIMESTAMP_ERROR (8).
5. Gain transition or changed gain/optical profile: LOW_SQI (1).
6. Non-unit modulo-65536 sequence delta: SAMPLE_GAP (2).
7. Zero/half-range or out-of-bounds modulo-2^32 sample delta: TIMESTAMP_ERROR (8).

All represented errors other than configuration mismatch re-anchor processing
history, including sequence, timestamps, gain/optical state and elapsed ticks.
Frame reason bits remain sticky until reset. Accepted channel time is the
channel-zero accumulated integer ticks plus signed modular channel skew.
Inactive channel bits and sample slots are ignored. The existing
bppe_frame_tick_bounds helper supplies exact jitter/skew comparison limits.

Configuration fields exposed on the adapter are captured during reset and
compared at frame acceptance. in_config_error is an upstream indication that
OTHER host configuration fields differ from the locked session config; the
adapter does not compare an entire product configuration structure itself.
Numerical configuration remains static per run. Typed ports cannot represent
malformed host structures, missing fields, NaN, or out-of-range integers.
Lifecycle/start/abort, config-loading protocol, CSR, IRQ and W1C remain outside
this local contract. Reset is coordinated across the adapter and channel cores.

bppe_acquisition_channels implements the ordered consumer in RTL: three
independent channel cores, one numerical event in flight, and one held output.
A rejection cannot clear history until prior numerical outputs have been
consumed and all cores are idle. Configuration errors retain history; ordinary
frame errors clear all channel histories while retaining numerical faults.
Frame-fault snapshots are captured with each event: a later buffered frame's
fault may update the live diagnostic without changing an older held result.
The replication/serialization choice is an experimental implementation, not
an approved product resource or throughput target.

## Reference and simulation evidence

bppe_export_frame_vectors calls the public bppe_step_fixed entry point, not
a separately reimplemented frame checker. It records accepted/reason/sticky
flags, per-channel integer time/DC/filter state, tracking/rejections and beat
features. Config-error cases retry the same sample after restoring config,
proving retained history rather than merely checking a reason bit.

The configured 64-beat window and 1000s timeout prevent measurement publication
within these short cases. Reference generation asserts no candidate and no
numerical fault, deliberately isolating acquisition/channel behavior. Numeric
fault generation/retention has separate kernel coverage (EXP-007/008/009/014);
this dataset does not add numerical-fault/measurement interaction coverage.

Golden dataset: 63 profile-cases, 17,856 frames, 17,562 accepted, 294 rejected,
35,415 ordered output events, 288 beats. Each of compact/balanced/wide includes
all 1/2/3-channel configurations and seven scenarios:

- 16s deterministic synthetic PPG with actual beat extraction;
- sequence/timestamp wrap;
- negative skew across timestamp wrap;
- overlapping metadata errors and their reason precedence;
- exact accepted/rejected jitter and modular half-range boundaries;
- config-error retention and same-frame retry;
- 0.5ms timestamp ticks.

QuestaSim 10.6c: all SEVEN simulations passed, zero errors/warnings. Three
direct-dispatch integration runs and three synthesizable-wrapper runs each
compare the entire golden dataset across profiles; one adapter flow run covers
inactive-channel masking, config-pin mismatch priority, history re-anchoring,
reset during validation and reset during partial dispatch. Combined resets also
abort active numerical processing and held numerical output.

Wrapper tests continuously offer frames and periodically stall the output.
Per profile they observe 68,974 blocked-output cycles, 126 cycles with a later
live frame fault differing from an older result snapshot, and 1,520 cycles
where a rejection waits behind older work. Stability and exact snapshots are
asserted throughout. Every channel acceptance respects the staged preprocessor's
eleven-cycle minimum interval. Maximum observed frame acceptance-to-final-output
latency is 558 cycles under this stimulus/stall schedule, not a universal bound.
Arbitrary consumer stalls can extend latency indefinitely. No board clock or
guaranteed real acquisition throughput is inferred from these cycle counts.

MATLAB: complete 51-test suite passes, zero failed/incomplete. Code Analyzer
reports no findings for the new exporter. Initial development failures exposed
testbench enable/ready sampling and EOF handling; both were fixed without
changing golden values or the public model.

## Reproduce

```matlab
addpath(fullfile(pwd,'m_model'));
bppe_export_frame_vectors;
```

```powershell
./toolchain/run_frames_questa.ps1 -QuestaBin C:/path/to/questa/win64
./toolchain/run_frame_vivado.ps1 -VivadoBat C:/path/to/Vivado/bin/vivado.bat
```

Unique build directories preserve source/script/vector hashes and logs.
Golden MEM SHA256:
413a14efc1a07723ff50b4112e025c2bc94a10423ab33b84096b7ab815a6de4c.
Generated vectors, logs, netlists and checkpoints stay outside source control.

## Synthesis scope and remaining work

Actual Vivado 2026.1 OOC synthesis of bppe_frame_dispatch alone succeeds for
xc7a200tfbg484-2: 897 LUT, 548 FF, zero DSP/BRAM/latches. The exploratory 10ns
clock is applied AFTER unconstrained synthesis; WNS +2.311ns, TNS 0.000ns.
Warnings concern constant unused reason bits, flat netlist and missing
HD.CLK_SRC. This does not synthesize the three-core wrapper or establish its
resources/timing. No pin/I/O delays, placement/routing or board timing signoff
exist, and 10ns remains only an analysis assumption. The runner's printed
success label was corrected after the recorded run; its synthesis commands and
Tcl/source files are unchanged.

Next connect these per-channel outputs to the bounded window/SQI/regression
path, retaining a global numeric-fault lifetime and atomic multi-channel
measurement trigger. Frame-error resets must also reset window/deadline state
while retaining pending snapshots as the reference does. Product lifecycle,
AHB/IRQ/W1C, ACK/publication priority, physical ADC buffering and target-rate
requirements remain unfrozen. The known strong-impulse quality gap is not
addressed by this acquisition stage; no clinical accuracy claim is made.
