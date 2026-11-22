# EXP-022: internal clocked implementation at 30 MHz

Date: 2026-11-06. Baseline: db410452505301c0e1060deea2d55a7578873dac
(EXP-021). Scope: the balanced three-channel numerical prototype on
xc7a200tfbg484-2, with the owner-confirmed 33.333 ns core clock target.

## Purpose and unchanged contracts

EXP-021 only estimated delay on a synthesized netlist. This experiment adds
placement, physical optimization and routing for the internal core, using an
explicit global clock buffer. It does not assign the abstract core ports to
board pins, select a host/ADC protocol, generate a bitstream or close board timing.

The new bppe_ooc_clocked_top passes every parameter and signal to the existing
bppe_multichannel_prototype and adds one BUFG on its clock. The numerical
arithmetic, whole-cycle caches, precision and division/product schedules are
byte-identical to EXP-021. The acquisition handshake expression is corrected as
described below, preserving accepted edges and fault ordering. First-pending snapshot
retention and serialized ACK/publication remain in force. The known impulsive
noise false-valid gap is unchanged; these are synthetic engineering results,
not clinical evidence.

The BUFG is inside the OOC design so Vivado can place and route the internal
global clock network. Its site is selected by the tool. The input clk remains
an abstract source: oscillator, input buffer, clock-generation circuit and
board source location are not modeled. See
[AMD UG905](https://docs.amd.com/r/2022.1-English/ug905-vivado-hierarchical-design/I/O-and-Clock-Buffers).

## Functional validation and interruption recovery

The system testbench can instantiate either numerical top or clocked harness;
hierarchical diagnostic checks resolve to the same core. Clocked simulation
uses BUFG.v from the installed Vivado unisims directory, whose hash is recorded;
vendor source is not copied into this repository. This is behavioral RTL
simulation, not a routed netlist simulation or formal equivalence proof.

Normal run: 20261106T150928313-4e9097e4. Its three completed vector logs were
verified after reconnection and reused. The interrupted RESET_NUMERIC.log is
retained as incomplete evidence and excluded from the result. Four directed
tests and the expected ACK collision were then run into separate *.resumed.log
files using the same checked compiled sources, vectors and simulator version.
Clocked run: 20261106T180439782-4b6a6e01, completed independently after reconnection.

Each top passes seven positive simulations: three profiles against 24 cases
and 50,400 frames each, plus RESET_NUMERIC, RESET_MEASUREMENT, RESET_PENDING and
INITIAL_FAULTS. Each also rejects the deliberate ACK/publication collision.
This pre-fix baseline has 14 positive simulations and two expected negative simulations.
Each top covers 151,200 frames and 303 candidates. Positive logs report zero
errors and warnings. Test/source/vector hashes were rechecked after completion.

The two pre-fix tops have identical candidate, ACK, overflow and latency summaries:
profile maximum processing latencies are 22,895 / 23,093 / 23,165 clocks.
These are observed maxima of the supplied vectors, not worst-case guarantees.
The behavioral testbench clock is merely a simulator timebase; routed STA uses
the separate 33.333 ns constraint.

## Implementation-discovered feedback and correction

Initial implementation 20261106T180608229-40011487 reported a pre-place critical
LUTLP-1 warning: ten LUTs formed a combinational loop across the frame adapter
and channel readiness. That run was stopped after confirming its task-specific
process identity; its log, synthesized checkpoint and source snapshot are kept.
It has no completed implementation or usable timing-closure claim.

The previous clear_channels expression was ev_valid && ev_ready && ev_reset,
while ev_ready depended on selected core_ready. The preprocessor inhibits
core_ready when clear_history is asserted, creating structural feedback.
For a history-reset rejection, dispatcher ev_reset implies ev_reject, and the
rejection branch already accepts independently of numerical core_ready.

The correction derives rejection acceptance directly from ev_valid, the
WAIT_EVENT/all-core-idle fence and ev_reject, then gates history clear with
ev_reset. With ev_reset=0 both old/new clears are zero; with ev_reset=1,
ev_reject=1 makes both acceptance expressions equal to the idle fence. This
removes the ready-to-clear feedback without adding a cycle or changing the
ordered rejection edge. A simulation guard checks the reset-implies-rejection
invariant. No combinational-loop waiver or timing exception is introduced.

After this RTL change, the full normal and clocked system suites were rerun,
along with seven frame/acquisition checks. The final revision passes 21 positive
simulations and two expected ACK-collision rejections. Frame/acquisition tests
cover 17,856 frames and 35,415 numerical/rejection events, including 294 rejected
frames, held outputs, rejection fences behind older work, future-fault isolation
and reset recovery. Both system tops preserve the pre-fix candidate/ACK/overflow
counts and the observed 22,895 / 23,093 / 23,165-clock maxima exactly.
All three numerical profiles were tested; none of these observations is a WCET.

The implementation runner now reports/checks DRC immediately after opt_design,
before placement, so an Error or Critical Warning stops that run early. Final
route/DRC/timing audit is still required. The first failed run remains separate
from the corrected implementation below.

## Implementation evidence

Vivado 2026.1 build 6511674, one worker; run 20261106T181903034-c9b4d646.
Flow: synth_design -mode out_of_context; create_clock -period 33.333;
opt_design; place_design; phys_opt_design; route_design. The clock is applied
after synthesis, as in EXP-021, and is available throughout implementation.
No false path, multicycle exception, floorplan or board pin was added.

| Metric | EXP-021 synthesis estimate | EXP-022 routed internal OOC |
| --- | ---: | ---: |
| LUT | 67684 | 67010 |
| FF | 54943 | 54943 |
| DSP | 42 | 42 |
| BRAM_tile | 6 | 6 |
| latch | 0 | 0 |
| Setup WNS, ns | 22.643 | 9.544 |
| Setup TNS, ns | 0 | 0 |
| Hold WHS, ns | Not used as implementation evidence | 0.026 |
| Pulse WPWS, ns | Not used as implementation evidence | 15.536 |

The routed report uses 133800 available LUTs
and 267600 available FFs as denominators;
it lists 800 LUTs and 1,600 FFs as prohibited. No explicit site prohibition was
added by this experiment. EXP-021's synthesis report instead had 134,600/269,200
available LUTs/FFs. The new 50.08% is relative
to the routed report's available capacity, not an identical denominator.
This table contrasts different analysis stages, not a new arithmetic optimization:
clock-buffer insertion and physical implementation can change mapping and delay.
Setup/hold/pulse failing endpoints are respectively
0.0 / 0.0 / 0.0.
Reported worst setup-path clock uncertainty is 0.035ns with tool-default
system jitter 0.071ns, input jitter 0 and phase error 0; these are not measured
oscillator/MMCM properties. The positive 0.026ns hold margin must be reassessed
with the eventual full clock/reset/I/O context.
Registers without a clock: 0; unconstrained internal endpoints:
0.

Worst reported setup path: `core/measurement/primary_reg[1]/C` to
`core/measurement/div_numerator_reg[61]/D`. Data path delay: 23.658ns  (logic 4.228ns (17.871%)  route 19.430ns (82.129%)).
Logic levels: 25  (CARRY4=13 LUT2=1 LUT5=2 LUT6=5 MUXF7=2 MUXF8=2). These are routed internal path
results in this context; no external input/output or board-clock path is covered.

Route metrics: PLACED_FULLY=1, PARTIALLY_ROUTED=0, ROUTED_FULLY=1, ERRORS_IN_ROUTES=0, UNROUTED=0, PARTIAL=0, GAPS=0, CONFLICTS=0, HIERPORT=2662.
The raw route report counts 95,427 routable nets and 95,427 fully routed nets,
with zero routing errors. The BUFG output clock net is separately reported
ROUTED with a complete internal global-clock route tree.
Global clock buffer: core_clock_buffer (BUFG, BUFGCTRL_X0Y16). The route audit checks internal nets; HIERPORT
nets belong to the unimplemented OOC boundary and do not establish board routing.
DRC violations: CFGBVS-1 (Warning) x1, DPOP-1 (Warning) x11, DPOP-2 (Warning) x26, RTSTAT-10 (Warning) x1. Log warning counts by diagnostic ID: {'Synth 8-6014': 23, 'Synth 8-11357': 2, 'Synth 8-3936': 1, 'Synth 8-3332': 100, 'DRC 23-814': 4, 'Route 35-198': 100, 'Constraints 18-8777': 1}.
There are no ERROR or CRITICAL WARNING log messages. Missing external delays,
source-clock location and other intentional OOC exclusions are not board closure.
Route 35-198 reports missing HD.PARTPIN_LOCS for boundary ports. These interfaces
are deliberately not placed/routed; no guessed partition pins are added. The
tool suppresses repeated messages after its reporting limit, so the diagnostic
counts above count emitted log lines, not every affected port. CFGBVS-1 remains
open for the physical board, and DPOP warnings are pipelining advice rather
than waived setup/hold failures.
RTSTAT-10 lists 834 nets without routable loads, including output-facing result
and ready signals. This does not validate their eventual external consumers;
the OOC boundary is excluded as described above.
The tool also emits Constraints 18-8777 (unable to split tiles; required files
unavailable). Its underlying installation/OOC-context cause has not been
isolated; the warning is retained, not suppressed or declared harmless. The
result below is limited to the explicitly audited internal routes and timing;
partition-boundary export, partial reconfiguration and board implementation
are not validated by it. Revisit this diagnostic when constructing full context.

1827 input ports and 861 output ports
have no delay constraints. Boundary routes, source oscillator/MMCM, board pins,
I/O electrical standards, external timing and CDC remain unverified. Internal
setup/hold/pulse checks passed under this abstract clock context; no board
frequency, bitstream or real-device success is claimed.

Routed checkpoint SHA-256: 74E09D410A3FB30B361EC34682B751DB8A6F8F4BCFEB813A69EACA5B81F7068E.
Source manifest SHA-256: F3AA1681D02E2BBBB5E6B032994A5B4F0D730F2F120D0FB7FDAA8530606F0029.
Implementation summary SHA-256: 93E91F51D1055F40CA89F07A97CFD066004716787D82DBA00521417C1B2F33C9.

Observed elapsed phases on this laptop with one worker: synth_design 3m22s,
place_design 7m37s, phys_opt_design 32s, route_design 5m36s. Complete batch,
including reports/checkpoint, approximately 20m32s (18:19:03 to 18:39:35 UTC).
This is one run, not a cross-machine performance benchmark.

Corrected source test runs: normal 20261106T181606891-cd97ce67;
clocked 20261106T181652666-c744c947;
frame/acquisition 20261106T181547323-a798d0ed.
Test verification SHA-256: E5C36B2E3A638833134BB12E816A670360F92FB0BC3F91887DA44C8201CDB02D.
The saved old netlist reproduces LUTLP-1#1 as Critical Warning at the new
pre-place gate (EXPECTED_LUTLP_PREPLACE_GATE_PASSED); corrected DRC has no such
waiver or violation. Failed-run evidence is retained separately.


## Reproduce and retain evidence

From the project root, provide installed tool paths and exported system vectors:

```powershell
.\toolchain\run_frames_questa.ps1 -QuestaBin '<Questa>\win64' -Vectors '<frame_vectors.mem>'
.\toolchain\run_system_questa.ps1 -QuestaBin '<Questa>\win64' -Vectors '<system_vectors.mem>'
.\toolchain\run_system_questa.ps1 -QuestaBin '<Questa>\win64' -Vectors '<system_vectors.mem>' -ClockedOoc -UnisimDirectory '<Vivado>\data\verilog\src\unisims'
.\toolchain\run_system_impl.ps1 -VivadoBat '<Vivado>\bin\vivado.bat' -Threads 1
```

Generate the frame and system vectors through the existing MATLAB exporters.
The implementation runner creates a fresh isolated build directory. It records
source/tool-script SHA-256, part, profile, clock period and thread limit. It runs
synthesis, opt_design, place_design, phys_opt_design and route_design, then
preserves DCPs, utilization, setup/hold/pulse analysis, clock and route reports,
DRC details and a machine-readable implementation_summary.json. The audit
rejects internal timing, route, capacity or critical DRC failures; board-signoff
fields remain false regardless of the internal result. Outputs remain local
generated evidence and are not versioned as source.

The ordinary synthesis-only runner remains available and its estimates must not
be compared as if they were routed timing. Only balanced defaults were physically
implemented; all three profiles were simulated.

## Throughput, board evidence and remaining work

This wrapper adds no pipeline register or protocol buffering. EXP-021's
conditional default-capacity regression budget remains 88,060 clocks, or
2.93533 ms at nominal 30 MHz, excluding external stalls. It is not a formal
WCET or a guaranteed physical sampling rate. The model's 100 frames/s default
and conditional 8 ms timestamp stress are distinct from a host's possible burst
rate. An unbounded sample_ready stall admits no finite lossless FIFO guarantee.

[Board, clock and ingress evidence](../board-bringup-evidence.md) records the
manual provenance and candidate board facts without enabling speculative pins
or IOSTANDARDs. Board/core revision, delivered schematic/XDC, first demonstration
transport, clock/reset generation, I/O/CDC timing, bounded arrivals and consumer
stalls remain unconfirmed. Product lifecycle/AHB/AXI/IRQ/W1C and concurrent ACK
semantics are also open. Internal OOC closure alone does not close these items.
