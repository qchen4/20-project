# EXP-008: Whole-cycle beat and feature prototype

Scope: preserve the existing MATLAB fixed-point beat algorithm, using the
whole-cycle buffer approved by the project owner. This is an engineering
prototype, not a blood-pressure accuracy result or a completed M1 system.

## Implementation

- `m_model/private/bppe_beat_fixed.m` is the downstream portion extracted from
  `bppe_channel_fixed.m`, preserving its operations and order. Preprocessing
  continues to call it; the public MATLAB interface is unchanged.
- `c_model/include/bppe/beat_extractor.hpp` implements crossing interpolation,
  inclusive encoded period bounds, first-maximum peak selection, half-height
  width, positive normalized area and amplitude/DC ratio. Samples are appended
  before the existing strict timeout/capacity checks. A bounded software beat
  history mirrors MATLAB's `beats_per_result` window.
- `rtl/bppe_beat_core.sv` is a single-channel, multi-cycle downstream engine.
  It stores a whole cycle and scans it before emitting the five raw feature
  codes. Sample input is ready/valid; **every accepted sample** produces one
  output transaction, with `beat_valid` identifying a completed accepted beat.
  It consumes already-preprocessed signed signal codes, signed 48-bit time,
  and a host-derived warmup flag. This is an experimental internal interface.
  Beat-window aggregation, SQI and regression are outside this module.
- Configuration is latched per input transaction. The default 304-sample
  capacity is the existing MATLAB default `ceil(2*fs*max_period_s)+4`, not a
  product requirement. Parameter/configuration values must agree with MATLAB.
- Reset synchronously aborts in-flight work and pending output and clears
  arithmetic faults. History clear requires idle with empty output; it clears
  signal/beat history while retaining arithmetic faults. Output and input
  handshakes do not clear faults.

The RTL uses explicit wide integer products and variable integer divisions.
These are deliberately unoptimized operators. **No synthesis, STA, utilization,
frequency or power claim is supported by these simulation results.** Width
reduction, resource sharing and implementation on AX7A200 need separate work.

## Reproduce

From MATLAB, add the absolute `m_model` directory to the search path, then:

```matlab
results = run_bppe_tests;
bppe_export_beat_vectors(fullfile(tempdir,'bppe-beat-vectors'));
```

From a GCC/Clang environment with CMake and Ninja:

```sh
cmake -S c_model -B build/beat-cpp -G Ninja -DBPPE_SANITIZE=ON \
  -DBPPE_BEAT_VECTORS=/absolute/path/beat_vectors.csv
cmake --build build/beat-cpp
ctest --test-dir build/beat-cpp --output-on-failure
```

From PowerShell:

```powershell
./toolchain/run_beat_questa.ps1 -QuestaBin C:/path/to/questasim/win64 `
  -Vectors C:/absolute/path/beat_vectors.mem -BuildRoot C:/temp/bppe-beat-questa
```

CSV records carry configuration, accepted input, full current cycle buffer,
rolling beat history, emitted features and cumulative arithmetic counters.
MEM records carry 30 hexadecimal words followed by `(time,y)` pairs for each
current buffered sample: case, frame, action (sample/clear/reset = 0/1/2),
signal/time/feature fractional bits, tick nanoseconds, encoded minimum/maximum
period, maximum-period raw ticks, capacity, filtered input, DC input, sample
time, warmup, previous y/time, tracking, rejected beats, buffer length, emitted,
five features, saturation/divzero/precision counts, emitted beat time.
Signed values use 64-bit two's-complement encoding.

## Observed validation

Validation used MATLAB R2026b, GCC 15.2.0 with UBSan and QuestaSim 10.6c:

- All 46 existing MATLAB tests passed. The three changed/new MATLAB functions
  have zero Code Analyzer findings.
- Original unmodified channel and extracted channel produced byte-identical
  CSV observations (SHA256
  `c19ead40af24f2de2d2178a24f3de4d4b9ca1cbd4611a380a70289f5a215fe34`).
- 42 scenarios / 39,120 samples / 570 emitted beats matched in C++, including
  every buffered time/value and the entire rolling beat history. Scenarios
  cover below/minimum/nominal/maximum/above-maximum periods, tied peaks,
  nonpositive DC, ratio saturation, capacity overflow, warmup, numeric faults,
  history clear/reset and three independent synthetic ADC channels.
- All 13 CTests passed with UBSan enabled. A hand-computed triangular cycle
  checks all five features; valid and deliberately incorrect vector fixtures
  exercise the checker independently of the exported dataset.
- Three RTL vector runs each passed 13,040 samples, 14 scenarios, 190 beat
  outputs and 1,863 blocked-output checks. Every current cycle buffer element,
  raw feature, beat time and downstream fault counter matched MATLAB.
- Three additional RTL flow runs passed reset during scanning, reset with
  blocked output, hand-computed features, in-flight configuration/input
  changes, precision-fault retention through history clear and reset recovery.
  Compile/simulation reported zero errors and warnings.

Results and source manifests live in the isolated validation workspace, not
version-controlled generated artifacts. Negative-control results are retained
there separately from passing runs.

## Limits and next work

- Direct filtered fixtures isolate the downstream algorithm; ADC integration
  fixtures exercise each of three synthetic channels separately in C++.
  This does not prove shared multi-channel scheduling or a full RTL pipeline.
- The existing known strong-impulse quality gap remains; reproducing feature
  codes does not resolve or conceal it.
- Numeric-fault outputs are retained for diagnosis. Emitting feature codes
  does not establish their validity for SQI/regression or clinical use.
- Integrate preprocessing and beat handshakes, then add the bounded beat
  window, SQI and regression with the same staged raw-code comparisons.
