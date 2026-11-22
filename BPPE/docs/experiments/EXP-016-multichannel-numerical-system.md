# EXP-016: Raw multichannel frame to pending measurement prototype

Baseline: main 5ed9230aaf586cd781b877c901c9b603e3ecdd21.
New top: bppe_multichannel_prototype. Existing single-channel and numerical
cores remain unchanged. This connects the EXP-015 acquisition wrapper to the
bounded window and SQI/regression cores with integer deadlines and the approved
first-pending snapshot policy.

## Local running-session contract

The frame source uses ready/valid and holds each offered frame until accepted.
Only one frame is processed at a time. All active channel results enter the
window before a measurement trigger is evaluated. Enough beats means EVERY
active channel has the required count; the configured primary channel selects
the regression features. The measurement timestamp is channel-zero timestamp
plus the largest signed modular channel skew, including across 32-bit wrap.

sample_done is a held completion-valid signal in THIS new top: completion,
sample_accepted/reasons, fault counters and any candidate fields remain until
sample_ready. Input stays blocked during processing and completion backpressure.
This differs from the pulse-only diagnostic of the older single-channel top;
that older module/interface is unchanged. Pending does not itself block new
frames. Host completion stalls can stop acquisition indefinitely: this is not a
physical ADC buffering solution or an approved product interface.

Configuration is static per reset/run. Reset release represents a running
session; product start/enable/configuration/lifecycle is not implemented.
cfg_primary is zero-based locally. in_config_error still represents an
upstream mismatch in unexposed host config fields, as documented in EXP-015.
The owner-approved integer warmup/timeout/deadline conversion is reused.

Ordinary frame rejection clears channel histories and the complete window,
then resets the deadline to initial_deadline_ticks. Configuration errors retain
those states. Neither kind discards the pending snapshot, result counter or
numerical fault lifetime. Rejection completion reports the frame reason, as
the public MATLAB early-return path does. Global faults retain prior bits.

Channel numerical counters are aggregated across all three independent cores.
Host-loading faults are seeded separately; measurement-only counter increments
are accumulated as deltas from the measurement request seed. Thus later frame
history clears do not erase prior measurement/configuration faults, and each
new measurement sees the same shared fault lifetime as MATLAB.

Measurements clear only the beat window and rejection baseline, preserving the
ongoing beat cycle. A first candidate creates the pending snapshot. Subsequent
candidates continue calculation while retaining that first snapshot and setting
sticky RESULT_OVERFLOW. ACK releases pending and retains snapshot payload and
faults. Tests serialize ACK between frames. ACK concurrent with publication
raises a simulation fatal; no product race priority, IRQ or W1C semantics are
defined by this experiment. Candidate/completion transfer is not product ACK.

## Public-model evidence

bppe_export_system_vectors calls bppe_step_fixed and bppe_control directly.
No alternative frame, window, trigger or regression algorithm supplies expected
values. Raw frames begin near sequence/timestamp wrap and include positive and
negative channel skew. All primary-channel indices are exercised. The MEM
format preserves exact double integer codes before int64 serialization.

The dataset includes eight scenarios for each 1/2/3-channel configuration and
each compact/balanced/wide profile: clean/jittered PPG, held pending, delayed
ACK, flat-wave timeout, scale underflow plus frame errors, frame-error recovery,
configuration-error same-frame retry, and the known impulsive-noise gap.

| Observation | Count |
| --- | ---: |
| Profile-cases | 72 |
| Raw frames | 151,200 |
| Candidate measurements | 303 |
| Overflow candidates retaining a pending snapshot | 117 |
| Rejected frames | 108 |
| Rejections while pending | 90 |
| Rejections with nonzero numerical counters | 45 |

Rejection reasons: LOW_SQI 18, SAMPLE_GAP 36, ADC_SATURATED 18,
TIMESTAMP_ERROR 18, CONFIG_ERROR 18. Reference audit confirms rejected frames
retain snapshot payload and numerical counters; ordinary errors reset timing
while configuration errors preserve it. RTL compares every frame's decision,
completion counters, global reasons, deadline/history state, candidate payload,
snapshot payload/tag, pending state and result counter against those records.

Three full QuestaSim 10.6c runs pass: each profile has 24 cases, 50,400 frames,
101 candidates and 50 ACKs. Every completion is held for three additional
cycles and rechecked; input cannot be consumed during that hold. Maximum
observed processing latencies are 620/653/665 cycles for compact/balanced/wide,
excluding the deliberately held completion. These are stimulus observations,
not worst-case guarantees or an achieved board sampling rate. The eleven-cycle
preprocessor interval remains enforced by the inherited ready/valid path.

Four additional directed simulations pass: reset during numerical processing,
reset during measurement evaluation, reset with a held candidate/pending result,
and host-initialized fault counters 3/4/5 surviving an ordinary frame rejection.
The initial-fault test also checks that full reset restores configured seeds
and clears sticky runtime flags/snapshots. No stale work emerges after reset.
These seven positive simulations have zero errors/warnings. One negative ACK
collision simulation intentionally terminates at the documented concurrency
guard; the runner requires that exact fatal rather than treating it as success
of a functional case.

MATLAB complete suite: 51 passed, zero failed/incomplete. Code Analyzer has no
findings for the new exporter. The known strong-impulse false-valid HR case is
still present once per profile (three total); it is explicitly asserted for
balanced single-channel. No algorithm quality or clinical accuracy claim is
implied by bit-exact agreement.

## Reproduce and limits

```matlab
addpath(fullfile(pwd,'m_model'));
bppe_export_system_vectors;
```

```powershell
./toolchain/run_system_questa.ps1 -QuestaBin C:/path/to/questa/win64
```

MEM SHA256: 59f2ea11d9fad99a71f5e6331e96ddf990f5d81872cc924dd9c1c1c1cca85159.
Unique run directories preserve source/script/vector hashes, MATLAB metadata
and simulator logs. The 154MB generated MEM and other build products are not
source-control inputs; they can be regenerated with the commands above.

This experiment does NOT synthesize or implement the new multichannel top.
Standalone preprocessing/frame-adapter resource and timing estimates do not
establish full-system PPA, frequency or timing closure. Full-top synthesis,
placement/routing, proper clock/I/O/pin constraints and board validation remain
open. The previously used 10ns clock remains an analysis assumption only.

Further work: resource/critical-path analysis of the integrated top; broaden
temporal/randomized coverage and capacity/fault boundary cases; then choose
the physical acquisition/host bridge and lifecycle contract with the owner.
AHB/IRQ/W1C, ACK/publication priority and physical buffering are still unfrozen.
