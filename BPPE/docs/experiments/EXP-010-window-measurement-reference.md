# EXP-010: Bounded-window SQI and regression integer reference

Baseline: MATLAB `private/bppe_measurement_fixed.m`, EXP-008 beat reference
and EXP-009 accepted ADC-to-feature RTL pipeline.

## Scope

`c_model/include/bppe/measurement.hpp` evaluates an already collected bounded
beat window for one to three channels. It preserves integer period mean,
population deviation/CV, inclusive amplitude checks, rejected-beat clean
fraction, per-channel and minimum SQI, primary-channel feature means, model
configuration/calibration/demo gates, feature envelope checks, standardization,
fixed-order linear regression, pressure gates and UQ9.7 output encoding.

Configuration is supplied as the existing MATLAB host-encoded integer codes.
Disabled infinite feature bounds become explicit optional bounds. The caller
also supplies existing arithmetic fault counts; evaluation retains them and
adds new faults. No floating-point DSP or coefficient fitting is introduced.

The reference preserves existing behavior even for rejected candidates:
regression may execute when SQI is low or another channel lacks beats, and
numeric faults invalidate the result even if predicted pressures look plausible.
Invalid results expose zero pressure payloads. Feature presence is separate
from result validity. Synthetic demo coefficients remain explicitly gated.

`beat_extractor::clear_window()` clears stored beats/times and rejection count
after a measurement while retaining the tracked cycle and previous sample.
It does not clear the caller's arithmetic faults. This is distinct from full
history clear.

This stage does **not** port acquisition-frame validation, elapsed-time/window
trigger scheduling, result sequence/publication/overflow/ACK, the product bus,
or the window/SQI/regression RTL. These remain separate implementation stages.

## Reproduce

Add the absolute `m_model` directory to MATLAB's path and run:

```matlab
bppe_export_measurement_vectors(output_dir);
```

Configure CMake with `-DBPPE_SANITIZE=ON` and
`-DBPPE_MEASUREMENT_VECTORS=/absolute/path/measurement_vectors.csv`, build and
run CTest. Optional integer/preprocessing/beat vector paths enable their existing
cross-language regression tests in the same build. The CSV retains complete
encoded configuration, channel beat matrices/rejection counts, before/after
faults, expected raw features, channel/SQI values, reason flags and pressures.
Generated results and source hashes are kept outside version-controlled source.

## Measured results

MATLAB R2026b and GCC 15.2.0 with UBSan:

- 288 window cases across compact/balanced/wide matched exactly in C++;
  114 had valid synthetic-demo outputs and 21 carried numeric faults.
- Coverage includes zero through four beats, one through three channels,
  rotating primary channel, a 64-beat window, inclusive amplitude thresholds
  and adjacent raw codes, rejected beats, model gates/envelopes, scale and CV
  threshold underflow, zero period mean, z/output saturation, pressure order
  and range gates, and pre-existing sticky faults.
- Sixty deterministic randomized windows per format use seed 4208, alternating
  regular and irregular periods with varying primary channel and rejected beats.
- Hand-computed properties check constant 120/80 demo outputs, SQI 255, SQI 64
  with twelve rejected beats, partial-channel reason bits, division faults and
  window clear preserving cycle state and sticky faults.
- All 15 CTests passed with UBSan, including existing integer/preprocessing/beat
  vectors. The new MATLAB exporter has zero Code Analyzer findings.
- Deliberately changing a valid window's expected SQI from 255 to 254 is
  rejected at that exact case, demonstrating the checker detects numeric errors.

No clinical accuracy, noise robustness improvement, timing or resource result
is inferred. The known strong-impulse quality gap remains open. The next steps
are window/SQI/regression RTL, then controller/window-trigger and full-system
comparisons, followed by synthesis/STA and AX7A200 board validation.
