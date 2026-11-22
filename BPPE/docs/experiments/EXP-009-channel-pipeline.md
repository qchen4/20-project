# EXP-009: Accepted ADC-to-feature RTL pipeline

Baseline: EXP-007 preprocessing and EXP-008 whole-cycle beat/feature cores.
`rtl/bppe_channel_core.sv` composes them without changing either core.

## Internal transaction contract

An input transaction contains one accepted 24-bit ADC sample, elapsed ticks,
an opaque 32-bit tag, a host-derived warmup flag and numeric configuration.
The preprocessing output slot stores the corresponding tag, warmup and beat
configuration. Those sidebands advance only with the matching sample.

The pipeline can hold two samples: one in preprocessing and one in the beat
engine or its output slot. Backpressure eventually reaches the input; a
prefetched sample may remain upstream while a feature scan or output stalls.
Every accepted sample produces exactly one ordered output transaction, including
samples without a beat. `out_beat_valid` identifies the five-feature output.

Output metadata includes the tag, warmup, raw DC/filter/time, beat time,
features and cumulative arithmetic faults **through that sample**. Preprocessing
fault counters are snapshotted when that sample enters the beat core. A fault
in a prefetched future sample cannot contaminate an older output.
`out_numeric_fault` belongs to that output transaction; `numeric_fault` is the
live sticky diagnostic for the whole pipeline and can assert earlier.

Reset synchronously aborts all in-flight samples and clears faults. History
clear requires `idle` (all output transactions drained); it clears processing
history while preserving numeric faults. This is an experimental internal
interface, not the frozen product bus or acquisition-frame contract.

## Verification

MATLAB R2026b generated observations directly from `bppe_channel_fixed`:
`bppe_export_pipeline_vectors(output_dir)`. The exporter has zero Code Analyzer
findings. The 34 fixed hexadecimal words in each MEM record contain case/frame,
control action, formats, coefficients, timing/period configuration, input ADC
and ticks, warmup, DC/filter/time, previous y/time, tracking/rejected count,
cycle length, emitted flag, five features, beat time and three fault counters;
full `(time,y)` buffer pairs follow. Signed values use 64-bit two's complement.

Run `toolchain/run_channel_questa.ps1` with `-QuestaBin`, `-Vectors` and optional
`-BuildRoot`, following the same isolated-run pattern as EXP-007/008. Each run
records simulator version and source/vector/runner SHA256 hashes.

QuestaSim 10.6c results:

- Three vector simulations passed: 6,508 samples, 10 cases and 54 beats per
  format (19,524 samples, 30 cases, 162 beats total). Raw preprocessing,
  complete current cycle buffers, beat features/time, fault counters and tags
  matched MATLAB for every consumed output.
- Each format exercised 3,033 blocked-output cycles, 2,867 simultaneous
  input/output handshakes and maximum occupancy of two samples. The scoreboard
  detects missing, extra, reordered and modified blocked outputs.
- Cases include zero/max ADC, steps, each of three synthetic PPG channels,
  timestamp jitter, alternating warmup sidebands, timestamp numeric limits,
  history clear/reset and zero coefficients.
- Three flow simulations passed prefetched-fault isolation, metadata ordering,
  history-clear fault retention, two-stage reset, reset during feature scanning
  with another sample prefetched, and clean recovery without stale output.
- All compile and passing simulation logs reported zero errors and warnings.

The jitter/warmup fixtures intentionally feed accepted kernel inputs directly;
they do not prove acquisition-frame rejection rules. The synthetic channels are
tested independently, not scheduled through a shared multi-channel pipeline.

## Limits and next stage

This connects ADC preprocessing to beat features only. Beat-window aggregation,
SQI, regression, frame validation, result publication and bus behavior remain
separate stages. Variable division and wide arithmetic are unoptimized; no
synthesis, utilization, STA, power, AX7A200 board or clinical accuracy result
is claimed. The documented strong-impulse quality gap remains open.
