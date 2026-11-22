# EXP-028: strong-impulse false acceptance, cause and shadow-gate tradeoffs

Date: 2026-11-06. Baseline: bda6fa0acbf7bd385ef59f0c9c3f2b722bfdb50b.
MATLAB R2026b, balanced single channel. Research scripts only: no production
filter, beat detector, SQI, regression, threshold, C++ or RTL behavior changes.

## Verified cause of the fixed seed37 failure

The existing 32-second, 75 bpm synthetic PPG with 0 dB impulsive noise/seed37
publishes candidate4 at frame1204 (12.03 seconds) as valid, SQI193, reasons0.
Its four accepted periods are 0.400864,0.407959,0.359299,0.400604 seconds.
Their quantized mean is0.392181396484375s: the reported period implies
152.990429bpm, versus the known synthetic75bpm. This is the previously recorded
quality gap, now traced to its pre-clear beat window.

Impulses introduce additional positive zero crossings in the filtered signal.
The detector accepts four roughly half-length cycles: each stays within the
existing0.35–1.5s period range, with positive peak/DC. Their relative dispersion
is small even though they represent the wrong waveform cycles. In this window:

| Existing quality term | Observed value |
| --- | ---: |
| Period CV |0.0489807|
| Regularity, approximately1 − CV/0.20 |0.7550964|
| Rejected beats |0|
| Clean fraction |1|
| All AC/DC amplitudes in configured bounds |true|
| Quantized SQI |193|
| Current acceptance threshold |150|

The source paths are `private/bppe_beat_fixed.m` (positive crossing, period gate)
and `private/bppe_measurement_fixed.m` (period CV, amplitude and rejected-beat
quality). The current gate rewards regularity of the detected cycles; it does
not establish correspondence with the original pulses. Rise/width/area vary
markedly between these cycles, but those shape-consistency measures are not
currently part of SQI. Their maximum within-window population CV is0.787267.

The unchanged floating model also accepts this exact boundary with SQI193 and
152.991740bpm. All10 floating/fixed candidate boundaries match with no validity
mismatch. Therefore this reproduced failure is a shared algorithmic weakness,
not a fixed-point-only or RTL-only numerical discrepancy. Removing the injected
noise gives9 valid clean candidates without the >5bpm proxy error.

## Diagnosis method and fidelity checks

`bppe_analyze_impulse` runs the unmodified public fixed model, then reconstructs
pre-clear beat windows from its exact binary-scaled DC/filter trace codes using
the existing beat and measurement kernels. Every reconstructed beat event and
candidate features/SQI/reasons/validity/pressure is checked against the public
run before any research metric is reported. All249600 input frames were accepted
and free of numeric faults; cases outside that diagnostic domain fail explicitly.
This reconstruction is an instrumented explanation of existing kernels, not an
independent new quality oracle. The known synthetic heart rate supplies only
the already-used EXP-004 period-error proxy (>5bpm), not blood-pressure truth.

The diagnostic plot `known_impulse_window.png` shows injected ADC disturbance,
clean/noisy filtered signals, accepted closing crossings and the four periods
against the synthetic0.8s period. It is generated in the output directory and
is not committed as a source asset. `emitted_beats.csv` and
`candidate_windows.csv` preserve individual beat and window measurements.

## Prespecified shadow study

Before inspecting the expanded results, the script fixed this matrix and gate
grid. All runs use32s,100Hz, one synthetic pulse template, balanced arithmetic:

- Three clean controls:60,75,120bpm.
- Fifteen discovery runs: those rates,0dB impulses, seeds11/23/37/51/79.
- Sixty held-out-at-design-time runs: those rates, new seeds101/211/307/401/503,
  each with0dB impulses,6dB impulses,15dB white noise and15dB periodic motion.
- Shadow alternatives: SQI at least175/200/225, or maximum within-window CV of
  rise/width/area at most0.10/0.20/0.30/0.50. All operate only on candidates that
  the unchanged baseline already accepted. No rule is enabled in production.

There are78 runs,249600 frames,766 candidates and472 baseline-valid candidates.
Two valid candidates exceed the existing5bpm synthetic period-error proxy.
The expanded data are now observed; any selected rule needs fresh validation,
not a claim that this same held-out set remains untouched confirmation data.

The new observed outlier is seed401,6dB impulses,120bpm: candidate10/frame2656
reports126.383184bpm with SQI160, one rejected beat, period CV0.0434875 and
shape CV0.292417. Floating reproduces the same boundary/validity/SQI and
126.383360bpm; all12 boundaries match. This smaller error differs from the
original doubled-period-frequency failure and defeats a loose shape gate.

| Shadow rule | Discovery: retained / bad | Discovery: removed low-error candidates | Held-out: retained / bad | Held-out: removed low-error candidates |
| --- | ---: | ---: | ---: | ---: |
|baseline|47 / 1|0|395 / 1|0|
|sqi175|33 / 1|14|370 / 0|24|
|sqi200|29 / 0|17|340 / 0|54|
|sqi225|21 / 0|25|266 / 0|128|
|morph010|16 / 0|30|288 / 0|106|
|morph020|32 / 0|14|364 / 0|30|
|morph030|38 / 0|8|381 / 1|14|
|morph050|46 / 0|0|391 / 1|4|

All eight rules retain all30 valid clean-control candidates. "Low-error" means
baseline-valid with period-derived HR error <=5bpm in this synthetic fixture;
it does not certify a clinically useful waveform or pressure result. Counts
are candidate-weighted, not independent subjects or population probabilities.
The maximum interval without a retained report is32s in the noisy groups even
for baseline, because some runs have no valid output. It is a finite-record
coverage diagnostic, including record edges, not measured recovery latency.

## Options and recommendation for the next decision

1. **Raise the SQI threshold**:200 rejects both observed outliers, but removes
   71 of470 baseline low-error candidates across the full matrix (17 discovery,
   54 held-out; clean controls unchanged). This is a simple policy change with
   a clear coverage cost; the default remains150 until separately approved.
2. **Add a shape-consistency gate**:CV<=0.50 rejects the original failure with
   little loss, but misses the new outlier. CV<=0.20 rejects both observed
   outliers while removing44 of470 low-error candidates (14 discovery,30 held-
   out), fewer than SQI200 here. It is a research candidate, not a frozen or
   generally superior threshold. The diagnostic uses floating statistical
   calculations; a hardware version needs its own integer contract, regression,
   latency/resource analysis and new waveform/HR-transition validation.
3. **Change impulse preprocessing or beat acceptance**:could address extra
   crossings earlier, but changes feature extraction, delay and calibration
   compatibility. No median filter, clipping rule, refractory period or absolute
   HR restriction is silently introduced. Such a branch needs a selected scope
   and complete model/C++/RTL revalidation.

Recommended next experiment, if authorized: investigate a switchable shape-
consistency branch with a fresh predeclared validation set and explicit coverage
reporting. Keep baseline behavior available. The owner still needs to choose
the quality/coverage objective before promoting any rule to the prototype's
acceptance contract. There is no evidence here for clinical BP accuracy, disease
prevention, real-motion robustness or a completed quality fix.

## Reproduce and evidence

```matlab
addpath(fullfile(pwd,'m_model'));
out=fullfile(pwd,'m_model','artifacts','impulse-analysis');
report=bppe_analyze_impulse(out,'matrix');
domains=bppe_probe_impulse_domains(out);
```

`focus` runs only clean75bpm and the original seed37 case for quick diagnosis.
The matrix exports runs/candidate_windows/emitted_beats/shadow_gates CSVs, a MAT
snapshot, the plot and source/parameter manifests. The follow-up exports
domain_probe.csv. Both research files pass MATLAB Code Analyzer with zero
findings;78 complete window reconstructions and both domain probes pass.
The matrix source manifest predates addition of the separate domain-probe
function; verification.json additionally records both research-source hashes.
No existing MATLAB unit-test expectation, numerical reference or RTL is changed.
Current OOC timing and unresolved18-8777 are unrelated and remain unchanged.

Verification record SHA-256: 593C7710ED1A3E59442B3F343A8D044F5E82BAB9DDED4C006C27EBA7D89BA934.
