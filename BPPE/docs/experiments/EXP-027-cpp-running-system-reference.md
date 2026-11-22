# EXP-027: independent C++ running-session system reference

Date: 2026-11-06. Baseline: 5f7378e99d476f6fb953811acd72271bcb7c66b9.
GCC 15.2.0 / C++17 / CMake / Ninja; warnings as errors, fail-fast UBSan.
Only C++ reference/tests/build files and documentation change. Production RTL,
MATLAB algorithms and original system vectors remain unchanged.

## Implemented contract

`system_reference.hpp` connects the EXP-026 normalized frame validator,
per-channel causal preprocessing/whole-cycle beat state, bounded measurement
windows and existing SQI/regression evaluator. One integer arithmetic instance
preserves MATLAB's channel/measurement operation order and cumulative faults.
The caller supplies encoded static configuration and host-generated initial
numeric fault seeds; initialization does not encode coefficients a second time.

Each step is one atomic running-session frame transaction. It implements:

- integer elapsed ticks and inclusive elapsed >= deadline triggering, or an
  observation when every active channel has enough beats;
- latest channel timestamp using signed circular skew and unsigned wrap;
- 16-bit visible result sequence, caller tag, raw features/pressure, codes,
  SQI, reasons, validity and candidate publication;
- continued computation while pending, first-snapshot retention and a sticky
  RESULT_OVERFLOW on later candidates; ACK clears only pending;
- window clear after measurement while retaining the ongoing causal cycle;
- frame-error processing-history/deadline reset while retaining pending,
  result sequence and numeric faults; CONFIG_ERROR retains processing history;
- rejection reasons returned without appending existing numeric faults, as in
  MATLAB's immediate rejection return; subsequent accepted frames surface them;
- coordinated reset restoring configured fault seeds, clearing runtime and
  snapshot state, and retaining static configuration.

ACK is a separate method called between atomic steps. Reset initializes a ready
running session, corresponding to the numerical RTL boundary / MATLAB reset
followed by start. The stopped START/ABORT/DISABLE lifecycle, configuration
updates, bus accesses, IRQ/W1C and simultaneous ACK/reset/publication are not
implemented or newly defined. No cycle, backpressure or clock-domain timing is
inferred from method execution. Existing exact-host integer-domain checks do
not choose a product session-duration limit.

## Verification results

The final source passes all 53 CTests: 15 positive tests and 38 expected negative
checker tests. This phase adds 22 tests: system properties, a hand-calculated
seven-frame mailbox/timeout fixture, the full MATLAB replay, and 19 negative
checks. New negatives require exit code 1 plus the specific expected diagnostic;
unrelated failures and successful comparisons are rejected by the test driver.

| Existing system-vector check | Matched result |
| --- | ---: |
| Profile cases / frames | 72 / 151,200 |
| Accepted / rejected frames | 151,092 / 108 |
| Candidate measurements | 303 |
| Published snapshots / overflow candidates | 186 / 117 |
| Serialized ACK events | 150 |
| Frames with sticky RESULT_OVERFLOW | 38,664 |
| Frames with nonzero numeric fault counters | 14,400 |
| Rejected frames retaining pending | 90 |
| Existing known-impulse false-valid HR outliers | 3 |

Every frame compares sample decision/reasons, elapsed/deadline/have-frame state,
all three numeric counters, candidate presence/payload, pending, retained snapshot,
visible result counter and sticky flags. Snapshot tags and timestamps are checked
after ACK and across frame errors. All three compact/balanced/wide formats and
one-to-three-channel cases use the same original vectors as the RTL system suite.
The known-gap diagnostic uses the exporter's impulsive case positions and 75 bpm
synthetic fixture; it is not a general clinical metric or an acceptance target.

Directed C++ properties additionally verify the exact 8020 -> 18020 integer
deadline (18019 does not expire), wrapped latest-channel timestamps, empty and
repeated ACK, retained first pending snapshot, config retry, frame-error recovery,
seeded numeric faults across rejection/reset, and malformed-host-call atomicity.
A flat timeout fixture publishes 65,537 results to cross the visible 16-bit
result sequence wrap while preserving the full caller tag. It exercises the
defined numerical boundary without selecting a physical frame rate.

The original scalar, preprocessing, beat, measurement and acquisition suites
also pass. System raw-code equality complements their intermediate-state checks;
the system MEM format does not contain every internal filter/window state or
per-channel SQI. Per-channel SQI remains covered by the measurement vectors.
Product config_epoch/model_id, floating reporting metadata and bus fields are
outside this RTL-facing system format and are not claimed compared here.

## Provenance and reproduction

The unchanged system MEM was exported by MATLAB R2026b at
2026-11-06T03:55:57Z. All 46 MATLAB source hashes in its manifest still match the
current repository. MATLAB, Questa and Vivado were not rerun in this phase;
the EXP-025 normal/BUFG RTL suite previously matched the same MEM, and production
RTL has not changed. Thus this phase adds a third implementation-language
comparison for the running-session contract, not a new RTL or board test.

At the repository root, export in MATLAB:

```matlab
addpath(fullfile(pwd,'m_model'));
bppe_export_system_vectors;
```

Then configure the GCC/Clang build:

```sh
cmake -S c_model -B c_model/build -G Ninja -DBPPE_SANITIZE=ON \
  -DBPPE_SYSTEM_VECTORS="$PWD/m_model/artifacts/system-vectors/system_vectors.mem"
cmake --build c_model/build
ctest --test-dir c_model/build --output-on-failure
```

To reproduce all 53 tests, also supply the five component vector options listed
in c_model/README.md. Without those paths their external comparisons are not
registered, so a smaller local test set must not be reported as a complete
MATLAB replay. Source/fixture/compiler/sanitizer and vector hashes are recorded
in source_manifest.txt and the respective vector manifests. Local run_cpp.sh,
configure.log, build.log, ctest.log and verification.json preserve this run.

## Remaining boundary

The independent running-session numerical reference is now integrated. This
does not complete the product lifecycle or bus, physical acquisition/CDC,
board clock/reset/pins, queue policy or real-data validation. First-board-demo
transport and matching delivered board documents still require the owner's
decision/evidence. The 30 MHz target, prior internal OOC implementation evidence,
unresolved 18-8777 warning and known impulse quality defect are unchanged.
No new PPA, worst-case latency, throughput, bitstream or board signoff is claimed.

System MEM SHA-256: 59F2EA11D9FAD99A71F5E6331E96DDF990F5D81872CC924DD9C1C1C1CCA85159.
Verification record SHA-256: F6C8C0DEFC32023EFCE1A705DCC9EB28477B026E003E5BAD71FDB12834F820DA.
