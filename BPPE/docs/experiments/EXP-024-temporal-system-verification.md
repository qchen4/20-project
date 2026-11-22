# EXP-024: deterministic temporal system verification

Date: 2026-11-06. Baseline: e28e72470331ad662d24da468475764f0803d396.
QuestaSim 10.6c; compact/balanced/wide numerical profiles; ordinary numerical
top and the existing internal-BUFG harness. No production RTL is changed.

## Gap and unchanged contracts

The original system replay holds each completion for exactly three cycles and
does not exercise a legal future-frame offer held behind an earlier completion.
This experiment varies transaction timing while preserving every accepted raw
frame, timestamp, configuration, ACK order and MATLAB expected result.

The source must hold valid and frame data until accepted. Completion and its
payload remain until sample_ready; only one frame is outstanding. Configuration
changes occur after draining and resetting between vector cases. ACK is kept
between completed frames and the next acceptance, never concurrent with
publication. This does not choose a product ACK race priority or bus protocol.

## Stress driver and checks

Optional TEMPORAL_STRESS uses a local 32-bit xorshift generator with explicitly
recorded nonzero seeds (1 and 20261106); it does not depend on simulator random
state. Input bubbles range from 0 to 7 clocks. Some responses see sample_ready
already asserted during computation; others are held 0 to 31 clocks, with
selected 2,047-clock holds. These are chosen stimulus lengths, not a maximum
allowed external stall or a sampling-rate guarantee.

Some completions remain blocked while the next real vector frame is offered.
That future frame is held for 1 to 16 additional cycles before releasing the
previous response, then remains stable through acceptance. Its data cannot
affect the older completion. A monitor checks source ready/valid stability,
all completion/candidate/snapshot fields while stalled, exactly-once acceptance
and consumption, and at most one outstanding transaction. Model scoreboarding
rechecks the current response on every deliberately held cycle. ACK events
release any older completion first; they do not race with publication.

An additional scoreboard gap was corrected: signed feature/pressure/tick
comparisons now use four-state case inequality, so X/Z cannot evade a comparison
by producing an unknown Boolean condition. A negative fixture corrupts one
expected candidate feature with X and must stop at the feature-mismatch check.
This deliberately corrupts the test oracle, not the hardware design or positive
reference vectors. No unknown-value RTL defect was observed in the positive runs.

The initial temporal-only version passed the ordinary-top suite and is archived
separately. After strengthening the comparisons, the final version was rerun on
both tops. Only the final runs below count toward this phase's result.

## Verified results

Ordinary run: 20261106T192310817-f9b21ae7.
Clocked run: 20261106T192518335-1298d391.

Each top passes seven existing positive tests (three full profiles plus four
directed reset/fault tests) and six temporal runs (two seeds x three profiles).
Both expected negative tests reject the documented ACK/publication collision
and the deliberately unknown expected feature. Total: 26 positive simulations
and four expected negative rejections, with zero errors/warnings in positives.

The final full replays cover 907,200 frames: 302,400 baseline and 604,800 temporal.
Each replay has 24 cases, 50,400 accepted and completed frames, 101 candidates,
50 ACKs and 12,888 overflow-flagged frames. The original MATLAB vector hash is
unchanged: 59F2EA11D9FAD99A71F5E6331E96DDF990F5D81872CC924DD9C1C1C1CCA85159.

Every temporal run preserves the baseline's exact candidate, pending snapshot,
fault, rejection, deadline and raw numeric comparisons. Observed maximum
processing latencies remain 22,895 / 23,093 / 23,165 clocks across the three
profiles, excluding completion stalls and input wait. These are observations,
not formal worst-case bounds.

For each profile and seed, scheduling counters match between the two tops.
The table below shows the balanced profile; all six profile/seed records are
retained in the verification JSON. ACK placement can vary between numerical
profiles and affects scheduling, so identical counters across profiles are not
required. Counts are per 50,400-frame replay and include carry-over response
stalls in addition to explicitly scheduled holds.

| Metric | Seed 1 | Seed 20261106 |
| --- | ---: | ---: |
| Input wait cycles with valid asserted | 180,516 | 178,548 |
| Completion stall cycles | 1,133,671 | 1,112,264 |
| Candidate held cycles | 1,545 | 3,558 |
| Rejected completion held cycles | 772 | 666 |
| Responses with ready already asserted | 12,627 | 12,587 |
| Scheduled 2047-clock holds | 149 | 140 |
| Completions carried to the next vector iteration | 18,995 | 18,819 |
| Input gap cycles | 176,475 | 176,149 |

## Reproduce and limits

```powershell
.\toolchain\run_system_questa.ps1 -QuestaBin '<Questa>\win64' -Vectors '<system_vectors.mem>' -TemporalStress -StressSeeds 1,20261106
.\toolchain\run_system_questa.ps1 -QuestaBin '<Questa>\win64' -Vectors '<system_vectors.mem>' -TemporalStress -StressSeeds 1,20261106 -ClockedOoc -UnisimDirectory '<Vivado>\data\verilog\src\unisims'
```

Omitting TemporalStress retains the original deterministic timing replay plus
the new unknown-value negative test. Unique run directories retain tool version,
all source/include/vector hashes, seeds and logs. The known impulse false-valid
quality gap is preserved. These finite seeded RTL simulations are not exhaustive
formal verification, gate-level/SDF validation, clinical evidence or hardware
tests. Existing directed reset tests remain separate from the stress replay,
whose vector-case reset requires draining outstanding work first.

No hardware latency, arithmetic, whole-cycle storage, pending policy or
backpressure contract changes. Consequently no new BPPE synthesis/PPA run is
claimed; EXP-022 remains the internal 30 MHz implementation evidence. Finite
stress holds do not bound real acquisition arrivals/consumer stalls or establish
a lossless FIFO depth. Board clocks/I/O and product interfaces remain open.

Verification record SHA-256: 909EC2FA091AD4377CE8CD4258C0C36CF7CDB4EE54F99BC850D21322D03FA394.
