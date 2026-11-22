# EXP-026: independent C++ frame and acquisition reference

Date: 2026-11-06. Baseline: 97c78883408fa8baa901790c6885274e602d0140.
GCC 15.2.0, C++17, CMake/Ninja, strict warnings as errors and fail-fast undefined
behavior sanitizer. Only C++ reference/tests/build files and documentation change.
Production RTL, MATLAB, synthetic algorithms and existing vectors are unchanged.

## Priority and completed scope

After EXP-025's integrated RTL recovery checks, the independent C++ M1 still
lacked input-frame validation. MATLAB/RTL system agreement did not supply a
third complete transaction reference. This phase fills the normalized frame
layer and composes it with existing C++ preprocessing/beat code in a checker.
It advances the current prototype plan without selecting a product interface,
physical transport, error threshold or clinical requirement.

`frame_validator.hpp` takes complete typed frames in a running session, with
static one-to-three-channel tick bounds already encoded by MATLAB's
`bppe_frame_tick_bounds`. The host supplies configuration-mismatch status.
The validator does not inspect arbitrary MATLAB structures or float parameters.
Host calls wider than the actual three-bit mask/24-bit ADC ports are rejected
with exceptions before state mutation; these exceptions are not new wire faults.

Rejection precedence is CONFIG_ERROR, missing channel, ADC saturation, channel
skew, gain/optical change, sequence discontinuity, then timestamp delta. Only the
first reason is emitted. Configuration errors preserve history; other frame
errors clear it. Sticky frame faults survive rejection recovery. Accepted frames
produce elapsed and signed channel-relative ticks, including sequence/timestamp
wrap. Signed modular conversion avoids implementation-defined signed narrowing.
Explicit frame reset clears runtime/frame faults and retains static configuration.
Numeric faults and DSP/window reset lifetime remain caller-owned.

The checker composes the validator with one preprocessor and whole-cycle beat
state per channel, sharing one integer arithmetic instance in MATLAB channel
order. It initializes each beat time on the first accepted sample and applies
history clears only when requested by frame validation. Configuration errors
do not process the rejected sample. This is transaction-level composition; it
does not estimate RTL cycle timing or implement a ready/valid queue.

## Verified results

All 31 CTests pass: 12 positive tests and 19 expected negative checker tests.
The 16 new tests comprise frame properties, a two-row hand-calculated fixture,
the MATLAB acquisition replay and 13 expected negative rejections. The latter
require exit code 1 plus the specified diagnostic; an unrelated failure or
successful completion cannot satisfy the negative test.

| Check | Result |
| --- | --- |
| Existing MATLAB acquisition data | 63 cases, 17,856 frames; compact/balanced/wide, 1/2/3 channels |
| Frame decisions | 17,562 accepted; 294 rejected; 35,415 channel/rejection events |
| Beat outputs | 288 emitted beats, all five raw features and times match |
| Intermediate state | DC/filter code, previous time, tracking, rejected beats, elapsed ticks and frame/numeric faults match |
| Ordered overlapping errors | All 128 combinations of seven predicates pass |
| Modular translation property | Seed 20261106; 240,000 paired frames (480,000 validator calls) preserve decisions, elapsed ticks and recovery |
| Boundary cases | Inclusive 8/12 tick limits, zero/half-range delta rejection, sequence/timestamp wrap, signed skew extrema, inactive channels and profile changes |
| Bad-oracle/parser tests | Decision, sticky fault, elapsed/signed ticks, history, beat valid, numeric fault, order/config, ADC domain, boolean, hex and truncation are rejected |
| Existing C++ suites | Scalar properties and 19,783 vectors; 9,924 preprocessing rows; 39,120 beat rows/570 beats; 288 measurement cases all pass |

The 63 MATLAB cases are the unchanged EXP-015 acquisition fixture. All 45 source
hashes in that export's MATLAB manifest still match the current repository.
The export was produced by MATLAB R2026b at 2026-11-06T03:37:16Z; MATLAB and
Questa were not rerun in this phase. Previous RTL acquisition comparisons use
the same MEM data (EXP-015, with later RTL regressions recorded separately).
This is an additional independent-language check, not a new physical test.

The acquisition fixture's numeric fault counters are zero. Nonzero numerical
fault behavior remains covered by the existing arithmetic/beat/measurement
tests and RTL system tests; this phase does not claim new full-M1 numeric-fault
lifetime coverage. Frame rejection and sticky frame faults are exercised here.

## Reproduce

From MATLAB at the repository root:

```matlab
addpath(fullfile(pwd,'m_model'));
bppe_export_frame_vectors;
```

From a GCC/Clang shell at the repository root:

```sh
cmake -S c_model -B c_model/build -G Ninja -DBPPE_SANITIZE=ON \
  -DBPPE_FRAME_VECTORS="$PWD/m_model/artifacts/frame-vectors/frame_vectors.mem"
cmake --build c_model/build
ctest --test-dir c_model/build --output-on-failure
```

That command enables the frame replay and local properties/fixtures. To run the
exact 31-test set, also supply BPPE_MATLAB_VECTORS, BPPE_PREPROCESS_VECTORS,
BPPE_BEAT_VECTORS and BPPE_MEASUREMENT_VECTORS using their documented exports.
Without external paths, local tests still run and external comparisons are not
registered; their absence must not be reported as MATLAB validation.

The build records compiler/sanitizer settings and source/fixture hashes in
source_manifest.txt and the frame input hash in frame_vector_manifest.txt.
The phase's local run_cpp.sh/configure.log/build.log/ctest.log and verification.json
preserve the exact executed paths and results. Generated build/vector files stay
outside the committed source set.

## Remaining work and decisions

The full C++ measurement scheduler, integer deadline, pending snapshot and
serialized ACK integration remain incomplete. Connecting those existing module
contracts against the 151,200-frame system vectors is the next independent
reference step; no product event-priority choice is needed for serialized events.

Board progress still needs Jeremy's first-demo transport choice (short ROM plus
JTAG/ILA, host UART, or implementation-only for now), matching physical board
revision/device/XDC/schematic and electrical clock/reset evidence. No transport
is silently selected. Product bus/IRQ/W1C and concurrent ACK/reset/publication
priorities remain open. No new PPA, physical sampling/FIFO bound, bitstream or
board signoff is claimed; the 30 MHz target and unresolved 18-8777 diagnostic
remain as recorded previously. The known impulse false-valid gap is unchanged.

Frame MEM SHA-256: 413A14EFC1A07723FF50B4112E025C2BC94A10423AB33B84096B7AB815A6DE4C.
Verification record SHA-256: D459454E518D7E76439575C598EED5C8903DCE321520CC2A9115C09081971F74.
