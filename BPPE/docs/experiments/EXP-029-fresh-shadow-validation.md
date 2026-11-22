# EXP-029: frozen morphology screening on a fresh synthetic validation set

Date: 2026-11-06. Baseline: db9e617b95a4ccb0a98c510169539743fb520720.
MATLAB R2026b, balanced single-channel numerical model at 100 Hz. This is an
offline quality/coverage experiment; no production algorithm, threshold,
C++ reference, RTL, calibration or timing constraints change.

## Protocol and separation from development data

EXP-028 selected two research candidates using its now-observed data:
maximum within-window morphology CV <= 0.20, and SQI >= 200 as a comparator.
Both rules only screen candidates already accepted by the unchanged baseline
(whose SQI threshold remains 150). This experiment fixes those two rules;
there is no threshold grid search or retuning on the new data.

The frozen input is `m_model/experiments/shadow_quality_protocol.json`, SHA-256
`788EEF12E38A0924080916ACE4E3B52468330FD482B1623050F08E9257CCA991`.
It was authored at 20:28:14 UTC, before the first data run at 20:33:35 UTC.
Two earlier Code Analyzer preflights stopped before any data generation;
only formatting findings were corrected. The successful run binds all 52
MATLAB source files, the protocol hash, tool version and enable flag before
evaluating the first case. The study uses all declared cases, including
unfavorable outcomes, and does not select cases by their results.

The 408 records comprise 24 signal configurations, each with one clean control
and 16 noisy variants (four fresh seeds times four noise conditions):

- Duration 40 seconds, 4,000 frames per record; 1,632,000 frames total.
- Constant rates 55, 85, 110 and 140 bpm; a 55-to-140 bpm ramp during seconds
  8 through 24; and an 85-to-125 bpm step at second 16.
- Original and broader two-Gaussian pulse shapes, each at 15,000 and 45,000
  ADC-code amplitudes over a 1,048,576-code baseline. The JSON specifies every
  center, width and secondary-bump gain. These amplitudes and rates differ
  from EXP-028's controls; one shape family intentionally remains comparable.
- Fresh seeds 1009, 2017, 3019 and 4021, disjoint from all ten EXP-028 seeds.
- Impulsive noise at 0 and 6 dB, white noise at 15 dB and periodic interference
  at 15 dB, using the existing deterministic injector. SNR is mean-removed
  whole-record clean RMS relative to added noise RMS; it is not a vendor pSNR.
  Actual post-rounding SNR and clipping counts are exported per run.

Seeds are deliberately paired across conditions, amplitudes and pulse shapes.
Consequently the 408 records and their windows are correlated constructed
trials, not independent subjects. A new seed set prevents reuse of the old
tuning samples; it does not establish independence from the synthetic signal
and noise families used during development.

## Reference, defaults and fidelity checks

The generator integrates the prescribed rate with a left-constant rate on each
100 Hz sample interval. Pulse phase is that integral modulo one cycle. For
each detected window, the reference is 60 times phase advance divided by
elapsed time between its first accepted cycle start and last accepted cycle
end. This is an interval-average reference, not the instantaneous rate at
publication. It includes gaps between accepted cycles. Filter delay and
transition behavior can therefore affect the error proxy; a window's count
is not a beat-by-beat matching result.

As in EXP-028, an accepted candidate is marked as a period-proxy error when
the rate implied by its mean period differs from this reference by more than
5 bpm. This threshold is a research diagnostic, not a BP accuracy criterion.
"Low-error" below means <= 5 bpm under this definition; it does not establish
correct waveform morphology or clinically useful pressure.

`bppe_shadow_morphology` defaults to disabled and exactly preserves the input
valid mask, including cases with nonfinite shape metrics. Explicit `true`
requires a finite nonnegative maximum CV <= 0.20. Unit checks exercise the
inclusive boundary, immediately-above boundary, negative/nonfinite values,
invalid mask/type/shape, and row/column/empty inputs. Every study window also
checks that the omitted enable argument leaves baseline validity unchanged.

The CV is the maximum population standard-deviation-to-mean ratio across
the accepted cycles' normalized rise time, half-height width and area. It is
computed offline in floating arithmetic from fixed feature codes; no integer
implementation or new hardware cost is asserted. `bppe_shadow_reconstruct`
retains EXP-028's diagnostic kernel replay, checking every reconstructed beat
event and candidate against the unmodified public fixed run. It is not an
independent algorithmic oracle. The separate verification recomputes phase
references, rule masks, per-run gaps and aggregate counts in Python.

All three alternatives see the same candidates and timestamps. Screening
does not feed back into the controller, refill a window, change ACK/pending
behavior or carry state across rejected outputs. Coverage means retained
candidate availability, not host-delivered throughput. Per-run no-report gaps
include both record edges (0 and 40 seconds); a zero-report run has a 40-second
gap. These finite-record gaps are not a recovery-latency or worst-case bound.

## Results

All 408 cases / 1,632,000 frames complete with no input rejection, clipping,
numeric fault or replay mismatch. There are 6,120 candidate windows and 4,618
baseline-valid candidates; 6 of the latter exceed the 5 bpm proxy, leaving
4,612 baseline low-error candidates. Each rule is applied once without tuning.

| Fixed offline rule | Retained candidates | Retained proxy errors | Removed low-error candidates | Runs with no retained report | Median of each run's largest no-report gap |
| --- | ---: | ---: | ---: | ---: | ---: |
| Baseline SQI150 | 4618 | 6 | 0 | 8 / 408 | 6.620 s |
| SQI200 | 3911 | 0 | 701 / 4612 (15.20%) | 16 / 408 | 10.425 s |
| Morphology CV <= 0.20 | 4067 | 2 | 547 / 4612 (11.86%) | 26 / 408 | 7.405 s |

All alternatives have a 40-second maximum no-report gap. Shape screening
retains more candidates overall than SQI200, yet leaves two observed errors
and more completely silent records. Aggregate output count alone therefore
does not establish a better quality/coverage tradeoff.

| Input stratum | Baseline retained / errors | SQI200 retained / errors | Morphology retained / errors |
| --- | ---: | ---: | ---: |
| Clean constant, 16 records | 240 / 0 | 240 / 0 | 240 / 0 |
| Clean changing rate, 8 records | 136 / 0 | 124 / 0 | 136 / 0 |
| Noisy constant, 256 records | 2710 / 2 | 2323 / 0 | 2363 / 0 |
| Noisy changing rate, 128 records | 1532 / 4 | 1224 / 0 | 1328 / 2 |

The morphology rule retains all 376 clean accepted candidates, whereas SQI200
removes 12 clean changing-rate candidates. This is finite coverage of the two
specified trajectories, not a guarantee for arbitrary physiological changes.

The aggregate advantage also reverses when restricted to impulses:

| Noisy stratum, 96 records each | Baseline retained / errors | SQI200 retained / errors; low-error loss | Morphology retained / errors; low-error loss |
| --- | ---: | ---: | ---: |
| Impulsive 0 dB | 544 / 4 | 323 / 0; 217 | 281 / 2; 261 |
| Impulsive 6 dB | 830 / 2 | 568 / 0; 260 | 546 / 0; 282 |
| White 15 dB | 1372 / 0 | 1214 / 0; 158 | 1368 / 0; 4 |
| Periodic interference 15 dB | 1496 / 0 | 1442 / 0; 54 | 1496 / 0; 0 |

The morphology rule loses more low-error impulse candidates than SQI200
(543 versus 477), while its much smaller white/interference losses improve
the pooled count. The noise mixture is prescribed by this study, not measured
deployment prevalence, so its pooled ranking must not select product policy.

### Counterexamples and paired observations

The six errors form three paired outcomes, repeated at the two amplitude
settings with the same seeded disturbance. They are not six independent
failure mechanisms. The rows below identify each pair in the exported CSV:

| Cases / candidate | Signal and disturbance | Reference / estimated bpm | SQI | Shape CV | Morphology outcome |
| --- | --- | ---: | ---: | ---: | --- |
| 45, 62 / 5 | Constant55, broad, impulse6dB, seed3019 | 55 / 109.360329 | 194 | 0.844056 | rejected |
| 274, 291 / 8 | Ramp, original, impulse0dB, seed1009 | 138.4946 / 146.128061 | 159 | 0.314248 | rejected |
| 308, 325 / 11 | Ramp, broad, impulse0dB, seed1009 | 140 / 146.656721 | 186 | 0.15135 | **still accepted** |

The last pair occurs at frame3025 / 30.24s, after the prescribed ramp has
finished. Thus its residual error is not explained simply by comparing a
changing window to the wrong instantaneous reference. Similar detected-cycle
shape does not guarantee correct period correspondence. This fresh result
disconfirms treating CV0.20 as a complete fix for the observed impulse gap.
No threshold is adjusted in response; these cases remain in the evidence.

### Verification and recommendation

All four new MATLAB files pass Code Analyzer; default-off and boundary tests
pass. The Python checker independently verifies all 6,120 phase references,
1,224 per-run rule results and 45 stratified summaries, source hashes and
matrix membership. Four deliberately corrupted copies (reference, retained
count, source hash and enable flag) are rejected. Production and user-file
hashes remain unchanged before installing only the research sources/docs.

Keep the shape branch default-off. Do not promote either candidate solely
from this study. SQI200 removes all six observed errors here but has a larger
overall low-error loss, including clean rate changes; morphology preserves
more pooled reports but misses errors and produces more silent runs.
An owner decision is needed before changing the prototype's acceptance
contract: prioritize artifact rejection, retained low-error coverage, or a
bounded no-report objective, and define an appropriate validation domain.
Further independent beat-correspondence analysis can proceed without making
that product decision. Any proposed integer/RTL gate also needs its own
numerical contract, latency/resource study and new confirmation data.

## Reproduce

```matlab
addpath(fullfile(pwd,'m_model'));
test_shadow_morphology();
out=fullfile(pwd,'m_model','artifacts','fresh-shadow-validation');
report=bppe_validate_shadow_quality(out,true); % Explicit research opt-in.
```

Capture the MATLAB console/error logs, then verify on Python 3 without `-O`:

```text
python testcode/verify_shadow_quality.py --output <out> --source-root <repo> --log <console.log> --error-log <error.log>
```

The checker targets this frozen Windows MATLAB study and expects the recorded
explicit research enable flag. It writes `verification.json` with artifact
and verifier hashes. The optional `quality_coverage.png` presents residual
proxy errors and removed low-error candidates by clean/noisy and rate-change
strata; it is a generated illustration, not a source asset.

Use a new output directory: the experiment refuses to overwrite an existing
run manifest. Omitting the second argument defaults to pass-through for the
morphology alternative; its enable state is recorded in metadata. SQI200 is
always a separately labeled offline comparator. Neither function is called
by the production streaming path.

Outputs include the frozen protocol, source/parameter manifests, input ADC/
timestamp/frame-sequence hashes, per-run records, candidate windows, per-run
gates, stratified summary and MAT snapshot. The input hash encodes little-
endian uint32 columns in the order ADC, timestamp, frame sequence. Interim
CSVs checkpoint every 24 runs; only the final PASS and complete expected
matrix establish completion. Generated evidence stays outside source control.

## Limits and decision boundary

This remains one channel, one fixed-point profile, short synthetic records,
two related pulse families and the existing noise generator. There are no
human recordings, BP labels, clinical sensitivity/specificity estimates,
population confidence intervals or guarantees against unobserved artifacts.
Morphology is constant within each record while heart rate may change; abrupt
shape changes, gain changes and physical sensor behavior are not covered.
The fresh data become observed after this study; any future tuning needs a
new untouched confirmation set. O-20 remains open until an owner-approved
quality/coverage objective and adequate new validation justify promotion.
Board transport, physical constraints and Vivado 18-8777 remain separate open
items; this experiment makes no new timing or board-readiness claim.

Verification record SHA-256: D7187650DCC9425562731D3DEC13B10F45C3FD67DCC32B74D364E38E6042C8BA.
