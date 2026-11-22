# EXP-025: coordinated reset recovery and serialized ACK boundaries

Date: 2026-11-06. Baseline: 2a76ccc21a8c21a02b5e142c58f6ca2a709a1ce0.
QuestaSim 10.6c; compact/balanced/wide profiles; numerical and BUFG harness tops.
Only testbench, runner and documentation change. No production RTL/model change.

## Gap and contract

Existing system reset tests check clearing and then finish. Beat/measurement
unit tests cover many internal abort states, but they do not prove that the
integrated three-channel acquisition/window/pending pipeline can process a
complete reference waveform after interruption. This phase adds that recovery
comparison and explicit idle/duplicate ACK checks.

The local coordinated synchronous rst input resets runtime and retains the
static caller configuration. The MATLAB bppe_control reset/ack actions and
[M0 lifecycle](../spec/algorithm-m0.md) provide the transaction-level reference.
ACK clears pending and retains snapshot payload and independent fault state.
[ADR-004](../decisions/ADR-004-prototype-pending-result.md) still leaves product
bus/IRQ/W1C and publication races open. No test chooses those event priorities.

## Reset injection and replay

Each recovery run injects exactly one reset at a selected point with three
active channels. Busy targets precede publication; held-result targets are
checked after publication has completed. The injection explicitly rejects an
active measure_transfer or ACK. The test source cancels valid during reset;
this does not specify a physical ADC/FIFO or external source's reset behavior.

Reset is held for two local clock cycles. Readiness must be low while asserted.
For 96 idle cycles after deassertion, the checker requires idle channel engines,
zero cycle/window counts, cleared completion/candidate/pending/snapshot state,
the configured initial deadline, and restored initial fault counters. Whole-cycle
RAM contents are not required to be physically erased: validity/state must fence
old data, and fresh waveform replay checks that they actually do so.

The test rewinds the vector file to the CURRENT CASE'S FIRST DATA RECORD, using
a saved ftell/fseek offset. It does not reload configuration or issue a second
reset. Case-entry test counters are restored so discarded partial work is not
counted as a completed reference replay. The entire selected case then passes
the unchanged raw-code, sample decision, fault, deadline, candidate and snapshot
scoreboard, including at least one fresh candidate. The remaining suite continues.

Cases have different lengths. An initial test-development run wrongly assumed
the 2,100-frame suite average for each case and rejected the first otherwise
matching replay. Its log and source are retained separately and excluded from
final results. The corrected checker requires reaching the actual case boundary;
the evidence verifier independently counts records and candidates in the original
MEM file and matches every recovery record to those counts.

The table shows balanced-profile results; all three profiles and both tops are
recorded in verification.json. Every target occurs in a three-channel case.

| Target | Trigger | Case | Discarded prefix frames | Replayed case frames | Fresh candidates |
| --- | --- | ---: | ---: | ---: | ---: |
| PREPROCESS_CH2 | Channel 2 preprocessing MULTIPLY | 41 | 1 | 1200 | 2 |
| BEAT_DIV_CH1 | Channel 1 beat divider, remaining=40 | 41 | 247 | 1200 | 2 |
| BEAT_RAM_CH0 | Channel 0 beat SCAN_EVAL, index>=3 | 41 | 327 | 1200 | 2 |
| MEASURE_DIV | Measurement divider, remaining=40 | 41 | 567 | 1200 | 2 |
| MEASURE_MUL | Measurement multiplier MULTIPLY | 41 | 567 | 1200 | 2 |
| PENDING_HELD | Published candidate and pending result held | 41 | 567 | 1200 | 2 |
| FAULT_HELD | Held response with new runtime numeric fault | 45 | 567 | 1600 | 2 |

The fault case starts with a configured division-by-zero count of one and
accumulates another runtime event before reset. Reset must restore the configured
seed, not erase it to zero or retain the runtime increment. Replaying the case
must reproduce the reference fault again. No fault behavior is changed.

## ACK boundaries

ACK_BOUNDARIES delivers three consecutive local ACK cycles while the engine is
idle: the first clears pending; the next two must be idempotent. It checks empty
mailboxes immediately after case initialization and all normal vector ACK points.
Snapshot metadata/features/pressure, result counter, sticky faults and reported
numeric counters must remain unchanged, with no spontaneous completion/candidate.

Each run checks 74 ACK groups: 24 initially empty and 50 pending. Normal frame
replay continues against the original expected values. This exercises logical
prototype ACK behavior, not an AHB write width, IRQ clear or bus pulse contract.
No ACK is concurrent with publication or a held completion transfer in this test.

## Final verification

Normal run: 20261106T194421506-f21b0e1a.
Clocked run: 20261106T194442360-21bc6e1a.


Each top passes 37 positives: seven existing baseline/directed tests, six seeded
temporal replays, 21 reset-recovery runs (seven targets x three profiles), and
three ACK-boundary replays. The expected ACK/publication-collision and unknown
expected-feature failures remain enforced. Total: 74 positive simulations and
four expected negative rejections; positives report zero errors/warnings.

There are 66 complete reference-suite replays, counting 3,326,400 input-handshake
frames, including accepted and rejected sample decisions. Discarded reset prefixes
are additional stimulus and are reported separately. Every full replay retains
24 cases, 50,400 counted frames, 101 candidates, 50 reference ACK events and
12,888 overflow-flagged frames. The reset-case frame/candidate counts, ACK checks
and temporal statistics match between the numerical and clocked tops.

Observed maximum processing latencies remain 22,895 / 23,093 / 23,165 clocks.
These exclude reset observation time, input waits and completion stalls; they
are not worst-case guarantees. The original 151,200-row, three-profile MATLAB
dataset is replayed repeatedly, not replaced by millions of independent samples.

The existing functional testbench uses a 10 ns simulation clock and no routed
delay annotation. These are cycle/behavior checks, not a 100 MHz hardware claim.
The FPGA target remains 30 MHz (33.333 ns implementation constraint); the three
observed cycle maxima correspond to about 0.763 / 0.770 / 0.772 ms at 30 MHz,
excluding the waits noted above. This phase does not change timing constraints
or rerun implementation, and supplies no new board timing or FIFO guarantee.

Across 42 recovery runs, discarded prefixes total 17058 input frames; the complete replayed target cases contain 52800 frames.

## Reproduce and limits

```powershell
.\toolchain\run_system_questa.ps1 -QuestaBin '<Questa>\win64' -Vectors '<system_vectors.mem>' -TemporalStress -RecoveryChecks
.\toolchain\run_system_questa.ps1 -QuestaBin '<Questa>\win64' -Vectors '<system_vectors.mem>' -TemporalStress -RecoveryChecks -ClockedOoc -UnisimDirectory '<Vivado>\data\verilog\src\unisims'
```

RecoveryChecks is optional. Unique build directories record source/include/vector
hashes and simulator version; each target/profile has a separate log with the
injection and successful replay markers. Numerical vectors and production RTL
are unchanged, so no new BPPE synthesis/PPA result is claimed.

The matrix samples seven system contexts; it is not exhaustive reset-at-every-cycle
or formal verification. The 96-cycle idle observation is a test interval, not a
product recovery-latency promise. Existing impulse false-valid quality behavior
remains. Physical asynchronous reset, CDC, board pins/clock, external acquisition
buffering and product reset/abort/publication priority remain unverified/unfrozen.
O-19's 18-8777 tool diagnostic remains unresolved; internal OOC timing evidence
still does not establish board signoff. No requirement decision was needed here.

Reference MEM SHA-256: 59F2EA11D9FAD99A71F5E6331E96DDF990F5D81872CC924DD9C1C1C1CCA85159.
Verification record SHA-256: D26B9ADC764530B344E7D4CB8CB661C2A6C4C79FEC39D986954A44AF16E027A7.
