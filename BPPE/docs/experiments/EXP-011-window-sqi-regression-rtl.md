# EXP-011: Bounded-window, SQI and regression RTL

Baseline: MATLAB fixed measurement behavior and the EXP-010 C++ reference.
This stage adds an isolated numerical evaluator and a rolling window store;
it does not freeze acquisition/controller, CSR, IRQ, W1C or ACK semantics.

## Numerical evaluator

`rtl/bppe_measurement_core.sv` accepts one complete host-encoded window/model
snapshot through an experimental ready/valid request. It locks all active data,
configuration, tag and incoming fault counts. SQI, primary-channel means,
model/envelope gates, fixed-order regression, pressure gates and UQ9.7 encoding
preserve MATLAB operation/rounding/fault behavior. Population deviation uses
an iterative exact integer square root.

The response reports feature presence, all five raw means, channel/minimum SQI,
reason bits, validity, pressure raw/codes and cumulative faults. Invalid pressure
payloads are zero. Low quality or incomplete other channels do not suppress the
existing regression arithmetic; numeric faults still invalidate a candidate.
Blocked responses hold every field and reject new requests. Reset aborts both
in-flight work and a pending response.

The caller owns the shared arithmetic-fault lifetime and supplies complete
before-counts on each request. Counts must carry forward between requests;
independent experiments reset the evaluator. Simulation assertions reject
decreasing incoming counts without reset. This internal handshake is not a
product result-ACK protocol.

## Rolling window store

`rtl/bppe_window_store.sv` consumes accepted per-channel result events. An event
may carry a beat and always carries that channel's cumulative rejected-beat
count. Each channel retains the last configured N beats (1..64), in order.
Window-relative rejected counts use a baseline against the upstream cumulative
counter. `clear_window` clears counts and advances rejection baselines without
changing upstream filter/beat-cycle state or numeric faults. An event held
across clear is backpressured and accepted once into the next window.

A measurement request can snapshot the store on the same clock edge as its
window clear: the evaluator captures the old contents and collection starts a
new window on subsequent edges. New events may then arrive while the numerical
snapshot is being evaluated. Full history clear resets counter baselines and
must coordinate with upstream history clear; simultaneous history/window clear
is outside the interface and is asserted against. The beat limit changes only
after history clear/reset. Only elements below each channel's count are valid;
unused memory is not reset or part of a snapshot's numerical meaning.

Automatic enough-beats/timeout triggering, shared-channel scheduling and the
connection to the ADC pipeline are not implemented in this stage.

## Reproduce and provenance

Export CSV using `bppe_export_measurement_vectors` (EXP-010), then:

```sh
python toolchain/measurement_vectors_to_mem.py /absolute/measurement_vectors.csv /absolute/measurement_vectors.mem
```

The standard-library converter writes 88 fixed 64-bit hex words plus active
beat matrices per record, with a SHA256 input/output manifest. The fixed words
are case/profile, window shape, quality/model configuration, encoded model
vectors/bounds, three counts/rejection counts, before-faults, and all expected
response values. Signed codes use two's complement.

```powershell
./toolchain/run_measurement_questa.ps1 -QuestaBin C:/path/to/questasim/win64 `
  -Vectors C:/absolute/measurement_vectors.mem -BuildRoot C:/temp/bppe-measurement
```

The runner uses new isolated directories and records simulator, source,
testbench include, converter, runner and vector hashes. The observed CSV SHA256
is `9732742f4bcf306334032327d0d2c95825a0585760dc77fbe59c73b677ba751c`;
the corresponding MEM SHA256 is
`b9b66217a0c5d45cc71e1e0ea4074c6f7c4b594f3f78b3b181612b685595391b`.

## Observed validation

QuestaSim 10.6c compiled without errors/warnings and all nine simulations passed:

- Three vector runs matched the existing 288 MATLAB/C++ cases exactly, with
  96 cases and 38 valid synthetic-demo results per format. Comparisons include
  raw means/pressures, channel SQI, reason bits and every arithmetic fault count.
- Each format performed 288 blocked-response comparisons. Inputs, complete
  window matrices, model coefficients and seed counts are deliberately changed
  after acceptance, demonstrating request snapshot isolation.
- Flow runs covered reset inside integer square root, blocked-response reset,
  three-channel 64-beat evaluation, hand-computed 120/80 outputs and SQI 255/64,
  divide faults, fault carry and clean reset recovery.
- Window integration runs covered rolling order, channel isolation, nonbeat
  rejection updates, clear-window backpressure, rejection baselines, 64-beat
  capacity and evaluation of one snapshot while a different next window fills.
- The largest latency in the 96-vector corpus was 472 clock cycles. This is an
  observation of that corpus, not a system worst-case bound or frequency claim.
- A negative control changed one valid case's expected SQI from 255 to 254;
  both the testbench and runner rejected that exact case.

Wide arithmetic, variable integer division and full register-bank snapshots are
unoptimized. No synthesis, STA, resource/power or AX7A200 board result is claimed.
The strong-impulse quality gap remains open; bit agreement is not a robustness
or clinical-accuracy improvement.
