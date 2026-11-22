# EXP-030: detected-cycle correspondence in observed counterexamples

Date: 2026-11-06. Baseline: bc6b2a3d151c5684b9693008cd7d54a8bc5c54d0.
This is a bounded diagnosis of already-observed EXP-029 cases, not another
validation set or threshold search. No production algorithm, acceptance
criterion, numerical format, C++/RTL, clock constraint or calibration changes.

## Scope and reproducibility

Replay the six EXP-029 false-valid windows' complete input records and six
matched clean controls: cases35/45,52/62,273/274,290/291,307/308,324/325.
These contain 48,000 frames,672 accepted beats,810 positive filtered crossings
and166 candidate results. The six failures are three paired scenarios at
two amplitudes, not independent population events.

The frozen EXP-029 generator is copied verbatim into the probe. Every replay's
ADC/timestamp/frame-sequence bytes must reproduce the original SHA-256. The
prior52 MATLAB source hashes and every recorded fixed candidate's frame,
validity, reasons, SQI and period-derived HR are checked. Original EXP-029
artifacts are read-only. Newly exported crossings are calculated with the
same integer rounding, then independently checked in Python against the
filter trace. Accepted closing crossings must coincide with beat endpoints.

The initial diagnostic accidentally passed a fixed profile to the intended
floating run; identical domain results revealed the mistake before publication.
That output is excluded and retained only in a local `invalid-fixed-domain`
archive. The corrected probe calls `bppe_run(frames,cfg)` and explicitly
asserts that floating state has no `fx` field while fixed state does. The full
12-record probe was rerun; all reported domain comparisons use that corrected
run. This correction does not alter any production or EXP-029 source/result.

## Diagnostic definitions and checks

For each accepted interval, report exact generated phase advance and the
nearest clean-filtered positive crossing at each endpoint. Nearest matching
uses temporal distance, with ties choosing the earlier crossing; there is no
acceptance threshold or learned alignment. It is an explanatory mapping,
not a clinical beat-matching score or a causal hardware estimator.

Generated main-lobe centers are phase m+0.22, as specified by both synthetic
pulse shapes. Their count uses the open-start/closed-end interval. This labels
constructed source lobes; it does not establish correspondence in real PPG.
Noisy and clean inputs share the same generated phase before noise injection.

An interval's duration difference from its mapped clean interval equals end
boundary displacement minus start boundary displacement. The checker verifies
this identity, integer period encoding, all810 crossing locations and all
48,000 phase samples/input bytes. Its340 clean accepted intervals map exactly
to one adjacent clean interval with zero displacement. Deterministic tests
cover one interval, split intervals, skipped intervals, shifted boundaries,
ties and invalid inputs. Corrupted ADC bytes, crossing times and period codes
are each rejected. The new MATLAB probe passes Code Analyzer without findings.

## Three distinct observed mechanisms

Representative values below use the15,000-code amplitude; paired45,000-code
records show the same mechanism with small rounding differences.

| Cases / candidate | Reported / reference bpm | Four accepted durations (s) | Accepted source-phase advance | Observation |
| --- | ---: | --- | ---: | --- |
|45,62 / 5|109.360329 / 55|0.581711,0.524033,0.566986,0.521851|2.011693 cycles|Four detections cover two source lobes; two intervals map to the same nearest clean boundary at both ends.|
|274,291 / 8|146.128061 /138.4946|0.419220,0.386688,0.434784,0.401672|3.792499 cycles|Four source lobes, one internal non-emitting crossing and a69.504ms gap omitted from accepted-period averaging.|
|308,325 /11|146.656721 /140|0.424362,0.430756,0.408127,0.373245|3.818482 cycles|Four source lobes and four adjacent clean intervals, no internal non-emitting crossing or omitted gap; boundaries move earlier.|

### Residual CV0.20 failure is boundary displacement

Cases308/325 remain valid under the offline shape rule (shape CV about0.15135,
SQI186). The generated rate is already constant140bpm at this window; the ramp
ended at24s and the candidate appears at30.24s. Each accepted interval maps to
one clean interval, so this example is not another doubled detection count.

The first boundary is1.695ms earlier than its matched clean crossing; the last
is78.574ms earlier. Their net difference shortens the four-interval sum by
**76.879ms**, from1.713371s for the matched clean intervals to1.636492s.
The accepted source phase advances only3.818482 cycles. Shape similarity and
period regularity can remain sufficient for the current gates despite this
systematic endpoint displacement. This is an observed mechanism, not a proof
that all residual errors share it or that nearest matching is unique in
arbitrary signals.

For cases274/291, the accepted durations total1.642363s while the full interval
envelope is1.711867s. The69.504ms omitted gap and displaced boundaries both
matter; one additional crossing produces no accepted beat. A proposed fix
that addresses only extra accepted cycles would miss this distinction.
That short interval is below the unchanged0.35s minimum accepted period.
Rejecting it prevents an extra accepted beat, but does not include its time
in the mean of the four accepted periods.

## Floating versus fixed evidence

All166 candidate frame boundaries agree between the corrected floating and
fixed runs. At all six focused windows, both domains report valid and the
same SQI. Representative floating rates are109.360627,146.130996 and146.655093
bpm respectively; paired amplitudes differ slightly. The largest focused
float/fixed rate difference is about0.0030bpm. Replacing quantized periods by
the exact observed crossing intervals also leaves the error.

Thus these reproduced errors persist in the shared detection/quality method;
they are not explained by fixed-point rounding. This statement concerns these
specific fixtures and does not certify every other numerical corner case.

## Reproduce and outputs

```matlab
addpath(fullfile(pwd,'m_model'));
report=bppe_probe_cycle_correspondence(exp029_output_dir,new_output_dir);
```

```text
python testcode/analyze_cycle_correspondence.py --output <new_output_dir> --source-root <repo>
```

Use Python without `-O`. The probe refuses to overwrite an existing manifest.
It exports runs,beats,crossings,windows,float_candidates,traces and manifests.
The Python analysis exports cycle_details.csv,cycle_summary.csv and
correspondence_analysis.json with source/input hashes. An optional generated
cycle_correspondence.png overlays clean/noisy filtered signals and displays
per-interval source-phase advance; generated data/figures are not committed.

## Consequence for the remaining project

Do not adjust CV or SQI using these now-observed cases. The bounded diagnosis
is complete: extra accepted cycles, omitted short gaps and boundary shifts
all occur. Keep the current prototype and default-off experiment available.
A new quality algorithm needs an agreed objective/domain and new confirmation
data, not another threshold sweep on EXP-029. No clinical effectiveness,
pressure accuracy or real-motion guarantee is inferred.

For the next engineering milestone, the higher-value dependency is the first
board demonstration and its verified board context. See
[prototype next decisions](../prototype-next-decisions.md). Numerical-core
verification is mature enough to prepare that step once the owner chooses
the path; additional unbounded synthetic sweeps would not resolve the missing
board information or quality acceptance objective.

Verification record SHA-256: 2E8428AA92DA6DE1DF073E547DFCC94CA25105976872BDE0F15CBDC11D9CA2CD.
