# EXP-023: tool diagnostics and saved-checkpoint audit

Date: 2026-11-06. Baseline: 004e9213ca489d89715366d386a103a77b9d2c1d
(EXP-022). Vivado 2026.1 build 6511674; xc7a200tfbg484-2; one worker.
The owner-confirmed core target remains 30 MHz / 33.333 ns.

## Question and scope

EXP-022 completed internal placement/routing but emitted Constraints 18-8777:
"Unable to split tiles. All required files are not available."
This experiment investigates that diagnostic without changing installed tools,
inventing board constraints or suppressing the message. It also checks whether
the saved implementation reproduces the reported internal checks.

No BPPE numerical RTL, cycle schedule, whole-cycle storage, handshake, fault
ordering or configuration changes. No new synthesis or implementation of BPPE
is needed. The small counter below is a separate tool diagnostic and never
becomes part of the BPPE datapath. Clinical accuracy and the retained impulse
false-valid gap are outside this experiment.

## Minimal reproducer

The standalone vivado_ooc_probe has a 16-bit synchronous reset/enable counter.
WITH_BUFG selects either one internal BUFG or a direct abstract clock. Both
variants run synth_design -mode out_of_context, create_clock, opt_design,
place_design and route_design at 33.333 ns on the same part. They have no
floorplan, partition pins, board pins, I/O delays or bitstream generation.
The direct-clock variant is a diagnostic control, not a proposed BPPE clock tree.

| Diagnostic | With BUFG | Direct clock |
| --- | ---: | ---: |
| Emitted 18-8777 lines | 1 | 1 |
| Fully routed, before/after DCP reopen | 1 / 1 | 1 / 1 |
| Route errors, before/after reopen | 0 / 0 | 0 / 0 |
| PROHIBIT sites before save | 200 | 200 |
| PROHIBIT sites after reopen | 0 | 0 |

Both live counter utilization reports, like EXP-022, list 800 prohibited LUTs
and 1,600 prohibited FFs. Reopening a DCP does not reproduce the same
site-property count observed in the live run. Therefore a zero count
queried after reopen cannot establish that the implementation used all
sites; use the original utilization denominator. The experiment did not
set PROHIBIT, and the underlying reservation mechanism remains unisolated.

Packaged runs: packaged-probe-1 and packaged-probe-0. Initial exploratory
counter runs (without DCP reopen) independently showed the same warning
reproduction and successful internal route status in both variants.


Reproduction without any BPPE code establishes that the warning is not unique
to the BPPE algorithm or its numerical widths. Both variants reproduce the
warning, so adding a BUFG does not resolve it; EXP-022 already contains one.
Missing HD.CLK_SRC in the direct-clock probe is another
warning specific to that control; no clock location is guessed to silence it.

The exact missing files and tool subsystem are still unidentified. No primary
AMD explanation of this exact message was located during this investigation.
The counter is small enough to supply independently if vendor support or a
separate supported-tool installation becomes available. It is not evidence
that every effect of 18-8777 is harmless, that partition-boundary export works,
or that partial reconfiguration is supported by this result.

## Saved BPPE implementation

Reopened EXP-022 routed.dcp, SHA-256
74E09D410A3FB30B361EC34682B751DB8A6F8F4BCFEB813A69EACA5B81F7068E.
Inspection run: 20261106T190038777-a5b8c306. No change to the DCP hash.

| Internal metric | Original EXP-022 | Reopened checkpoint |
| --- | ---: | ---: |
| Setup WNS, ns | +9.544 | +9.544 |
| Hold WHS, ns | +0.026 | +0.026 |
| Pulse WPWS, ns | +15.536 | +15.536 |
| Setup/hold/pulse failing endpoints | 0 / 0 / 0 | 0 / 0 / 0 |
| Route errors | 0 | 0 |
| Unclocked registers / unconstrained internal endpoints | 0 / 0 | 0 / 0 |

These checks reproduce the saved internal result under the same abstract
clock assumptions; they are not independent physical-board validation.
In particular, +0.026 ns hold margin must be reassessed with the real clock
and external interfaces. A clean reopen does not resolve the original
implementation warning.


The exported XDC contains only the 33.333 ns prototype clock. There are no
valid timing exceptions, waiver objects or pblocks. Reopened design properties
identify an OOC block, with HD.OVERRIDE_PERSIST=1; no user partition or board
configuration was introduced. These observations are context, not a causal
explanation of 18-8777. PROHIBIT on sites/BELs is queried using the documented
[AMD property](https://docs.amd.com/r/en-US/ug912-vivado-properties/PROHIBIT).

Methodology reports contain warnings for six RAMs without a merged output
register, 20 small multiplier instances and 32 decomposed wide multiplier
instances. These are optimization recommendations; they do not by themselves
invalidate the passing internal timing checks or justify a change to validated
latency. TIMING-18 reports 1,000 missing-delay entries. Treat this as a reported
count, not an exhaustive port inventory: timing checks independently identify
1,827 inputs and 861 outputs without external delays. Report-count limits and
repeated-message suppression must not be read as complete coverage. See
[report_methodology](https://docs.amd.com/r/en-US/ug835-vivado-tcl-commands/report_methodology).

## Verification tooling

inspect_system_checkpoint.ps1 checks an optional expected SHA-256 before
launching Vivado, creates a unique report directory, records script hashes,
and verifies that the input DCP is unchanged afterward. Its Tcl script only
opens the checkpoint and writes reports; it never optimizes, places, routes,
writes a checkpoint or changes constraints. It reports saved internal
setup/hold/pulse, route, clock, DRC and methodology checks. Board-signoff and
warning-resolution fields remain false. A mismatched expected hash is tested
to stop before creating a run or launching Vivado.

audit_system_impl.ps1 now rejects a Critical Warning anywhere in the log,
including a message absent from the final DRC collection. It also retains
emitted warning IDs/counts and an explicit 18-8777 presence flag. Counts may be
suppressed by the tool; they are not an all-instance inventory. A copied
EXP-022 evidence set passes, while the same reports with an injected Critical
Warning fail before a success summary is produced. Original evidence is
hash-checked and unchanged. This is an audit regression, not another BPPE RTL
simulation or implementation run.

## Reproduce

From the repository root, use absolute paths for the installed Vivado and
external build/evidence directories:

```powershell
.\toolchain\inspect_system_checkpoint.ps1 -VivadoBat '<Vivado>\bin\vivado.bat' -Checkpoint '<EXP-022 run>\impl\routed.dcp' -ExpectedSha256 '74E09D410A3FB30B361EC34682B751DB8A6F8F4BCFEB813A69EACA5B81F7068E' -BuildRoot '<fresh build root>'
.\testcode\test_implementation_audit.ps1 -CompletedRun '<EXP-022 run>' -BuildRoot '<fresh build root>'
```

For each minimal probe, start Vivado in a separate empty working directory so
its generated logs/cache are isolated. Pass 1 for the buffered variant and 0
for the direct-clock variant; each report directory must not exist yet:

```powershell
& '<Vivado>\bin\vivado.bat' -mode batch -nojournal -notrace -log '<run>\vivado.log' -source '<repo>\toolchain\probe_vivado_ooc.tcl' -tclargs 1 '<run>\reports'
```

The probe saves and reopens its own diagnostic DCP and reports route/site
properties on both sides. It never overwrites the BPPE checkpoint. Retain
tool version, source hashes, logs, reports and generated DCP locally; the
repository contains only diagnostic source, tests and this record.

## Limits and next step

Constraints 18-8777 remains open. Its presence alone did not make the audited
internal route or setup/hold/pulse checks fail, but this experiment does not
prove absence of other effects. Do not waive it or use the result to sign off
partition boundaries, external timing, board clocks/reset or a bitstream.
No license, installation or tool parameter changes were made.

Board/core revision, delivered XDC/schematic, oscillator electrical/timing
properties and the first demonstration transport still need confirmation.
Physical arrival/stall bounds are still needed before choosing a lossless
FIFO depth. No product AHB/AXI/IRQ/W1C or concurrent ACK behavior is frozen here.
The next board implementation must rerun timing/DRC in its complete clock and
I/O context, and revisit this tool diagnostic in that context.

Local verification record SHA-256: 3C1CE69C1BEE2B73BF6FA6C14216A2A3E17498F8C9DB939D9471E3A2811F88FE.
Checkpoint summary SHA-256: 1D9CDB19083614C5C55955E583EF962FDF204989F23BEB3BCA01331C0FA29492.
Audit regression run: 20261106T190138313-edf9d773.


## Follow-up: ordinary top-level control (2026-11-06)

The probe now accepts optional third argument `ooc` (default) or `full`. On the
same Vivado version, part, clock and buffered 16-bit RTL, a fresh ordinary
top-level run emits no 18-8777, while a fresh OOC run emits it once. Both finish
with full internal routes and no route errors before and after DCP reopen.
The ordinary design has IS_BLOCK=0 and 19 inserted I/O buffers; the OOC design
has IS_BLOCK=1 and none. Thus synthesis mode and I/O context changed together:
the result narrows the trigger to this OOC/boundary context, but does not identify
the exact missing files or prove the particular internal cause.

Both flows still show 200 PROHIBIT sites live and zero after reopen. This
resource-report observation therefore also occurs without 18-8777 and must not
be treated as a diagnostic for that warning. The full probe has NSTD-1 and
UCIO-1 Critical Warnings plus CFGBVS-1 Warning because board standards/pins are
unspecified. They are retained, not waived; full mode is only a tool control,
not a board design, DRC pass or bitstream candidate. No generated pin assignment
is adopted by BPPE. Run IDs: full-context-probe / ooc-context-probe in EXP-024's
local evidence directory; source hashes are retained alongside their logs.

Official AMD UG905 documents that boundary nets in module analysis are not
routed by default, and that context constraints are needed for their routing:
[Context Constraints](https://docs.amd.com/r/2021.2-English/ug905-vivado-hierarchical-design/Context-Constraints).
It separately states that a BUFG inside an OOC module uses the global routing
network: [I/O and Clock Buffers](https://docs.amd.com/r/2022.1-English/ug905-vivado-hierarchical-design/I/O-and-Clock-Buffers).
These statements support EXP-022's internal-versus-boundary distinction; neither
document explains 18-8777 or certifies that it has no other effects. Searches of
official AMD/Xilinx material and installed plain-text scripts/data did not find
an exact explanation. No installation repair, undocumented parameter or warning
suppression was attempted. O-19 stays open pending an authoritative explanation
or an independently validated complete implementation context.

To reproduce the ordinary control, use a fresh work/report directory and append
`full` to the probe command: `-tclargs 1 '<run>/reports' full`. Omit it to retain
the original OOC flow. This follow-up does not rerun or alter BPPE placement.
