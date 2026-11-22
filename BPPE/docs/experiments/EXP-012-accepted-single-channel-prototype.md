# EXP-012: Accepted single-channel ADC-to-result prototype

Scope: compose preprocessing, beat/feature extraction, rolling window storage,
SQI/regression and first-pending snapshot control using the existing numerical
behavior. Acquisition frame validation, shared multi-channel scheduling,
abort/disable/reconfiguration, AHB, IRQ/W1C and product control remain outside.

`rtl/bppe_single_channel_prototype.sv` accepts one already-validated sample with
elapsed integer tick, raw timestamp and opaque tag. It serializes accepted
samples until their numerical work completes. No throughput target is implied.
Configuration remains fixed for a run; host-encoded initial configuration fault
counts are included, rather than silently discarded.

The prototype determines warmup and timeout from encoded integer tick constants
(ADR-005); enough beats also close the window. Measurement request and window
clear occur atomically. The ongoing causal beat cycle is retained. Independent
channel-kernel counters and measurement-only fault deltas are combined so
measurement faults persist into subsequent samples/windows exactly as in the
shared MATLAB arithmetic handle.

While pending, later candidates continue to be calculated. The first snapshot
is immutable and later candidates latch live RESULT_OVERFLOW without modifying
it (ADR-004). ACK releases pending but retains payload and sticky faults.
The owner confirmed serializing ACK/publication in this prototype: simultaneous
events are rejected by a simulation guard. No priority for that collision, or
AHB/IRQ/W1C behavior, is implemented or frozen.

## Reproduce

Add the absolute `m_model` directory to MATLAB's path, reinitialize any old
runtime states, and run:

```matlab
run_bppe_tests;
bppe_export_prototype_vectors(output_dir);
```

Then invoke `toolchain/run_prototype_questa.ps1` with `-QuestaBin`, `-Vectors`
pointing to `prototype_vectors.mem`, and an optional isolated `-BuildRoot`.
The runner records source/include/runner/vector hashes and simulator version.

MEM uses 73-word configuration records (kind 0) and 47-word frame/response
records (kind 1). Configuration includes formats, filter/model constants,
quality/period thresholds, initial arithmetic faults and three tick thresholds.
Each frame carries actual ADC/ticks/timestamp and an ACK action before input,
expected timing predicates, complete candidate/pending payloads, sequence,
live fault flags and global arithmetic counters. Signed fields are 64-bit
two's complement. Runtime type/exactness assertions prevent MATLAB integer
concatenation from silently narrowing whole serialized rows.

## Observed results

- MATLAB R2026b: all 48 tests passed; changed/new MATLAB files have zero Code
  Analyzer findings. Tests include exact 8020-to-18020 tick expiry in both
  float/fixed control and constant conversion at fractional tick boundaries.
- QuestaSim 10.6c: three vector runs and three control runs passed with zero
  errors/warnings. Each format matched 7 cases, 17,600 accepted frames and
  42 candidates: 21 cases / 52,800 frames / 126 candidates in total.
- Every sample's fault counters, timing predicates, pending/control flags,
  candidate and retained snapshot fields matched the actual MATLAB public
  fixed-step model. Cases include clean input, held pending, delayed ACK,
  unconfigured model, flat timeout, scale underflow and known impulsive noise.
- Each format executed 27 serialized ACKs. Overflow remains sticky after ACK;
  first snapshots are retained while later candidates continue to advance.
- Flow tests cover reset during measurement and with pending output, empty ACK,
  initial numeric faults, post-ACK publication and the exact integer deadline.
- The 0 dB impulsive fixture (seed 37) still has one valid candidate per format
  whose derived heart rate is wrong by more than 5 bpm. All three are explicitly
  recorded as the existing quality gap, not fixed or reclassified as success.

This is accepted-frame numerical/control equivalence for a single channel,
not a full acquisition/controller or board demonstration. Counter conservation
depends on the fixed-run configuration and bounded input contract. Synthesizing
the complete prototype, physical timing closure, board pins/constraints and
real-data accuracy remain unverified. EXP-013 reports only an isolated
preprocessing synthesis baseline and its failed 10 ns timing estimate.
