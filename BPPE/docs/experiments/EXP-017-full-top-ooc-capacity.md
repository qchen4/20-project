# EXP-017: Full numerical top OOC synthesis and capacity failure

Measured source: main a54879eae0eb2e5a5c013aa45bc3bcd973f6c0af.
Top: bppe_multichannel_prototype, balanced default parameters (signal/time F=8,
coefficient F=18, feature/regression F=16). Three channel cores are physically
instantiated even when runtime cfg_channels selects fewer channels. The 304
sample whole-cycle buffers and 64-beat windows are unchanged.

Tool: native Windows Vivado 2026.1 build 6511674; synthesis license acquired.
Target: xc7a200tfbg484-2 (AX7A200 device family/package/speed baseline).
Two synthesis processes; isolated output directory. The full batch completed,
including hierarchical utilization, timing reports and a synthesized checkpoint.
No RTL or model behavior was changed by this experiment.

## Result: this implementation does not fit the target

| Resource | Used | Device capacity | Utilization |
| --- | ---: | ---: | ---: |
| LUT | 328,859 | 134,600 | 244.32% |
| FF | 140,037 | 269,200 | 52.02% |
| DSP48E1 | 391 | 740 | 52.84% |
| Block RAM tile | 0 | 365 | 0% |
| Latch | 0 | — | 0 |

LUT usage exceeds capacity by 194,259. At least 59.1% of the present LUT count
must be removed merely to reach the device ceiling; this is not a placement,
routing or timing margin guarantee. A slower clock cannot fix the LUT capacity
failure. Synthesis success is not resource-fit success.

Hierarchy attribution identifies acquisition at 264,052 LUT, measurement at
57,821 LUT, and the window store at 6,857 LUT. The three beat instances account
for the largest acquisition costs (reported 91,667 / 66,119 / 65,929 LUT).
Cross-boundary optimization and packing affect hierarchy attribution: these
rows should not be treated as sums of independent stand-alone core estimates.
In particular the small-core EXP-014/015 results do not predict integrated area.

Caches and snapshots consume many FFs, and only 44 LUTs are used as distributed
RAM; no block RAM was inferred. Existing multi-write/parallel-array access
patterns are not a BRAM-oriented storage architecture. The RTL elaboration
statistics also report 30 64x64 multiplier operators; that is an intermediate
operator count, not a count of final DSP blocks or duplicated mapped units.

## Clock, I/O and critical path

Synthesis has NO clock/XDC timing constraint. After synthesis, a 10.000ns clock
is created only for exploratory synthesized-netlist timing estimation, matching
earlier experiments. This is not the owner's approved final clock requirement,
timing-driven synthesis, or implemented STA.

- Setup WNS: -427.170ns.
- Setup TNS: -12,768,501.000ns; 80,541 failing endpoints.
- Worst source: measurement/deviation_reg[0]/C.
- Worst destination: measurement/quality_reg[0][32]/D.
- Data delay: 437.124ns (340.562ns logic, 96.566ns estimated routing).
- Logic levels: 2,370, including 2,307 CARRY4 and six DSP48E1.

The source maps to the QUALITY state in bppe_measurement_core: CV, regularity,
cleanliness and final quality calculations combine multiple wide rounded
divisions/products in one cycle. Variable division is also explicit in the
beat engine. The observed path supports scheduling these operations across
cycles; it does not establish a reliable maximum board frequency.

There are zero unclocked register/latch pins and zero unconstrained INTERNAL
maximum-delay endpoints. However, 1,827 input ports and 861 output ports have
no I/O delay constraints. No package-pin/IOSTANDARD constraints, clock-buffer
placement, placement/routing, board voltage/temperature timing assumptions or
physical clock/reset/CDC/host bridge have been signed off. The missing
HD.CLK_SRC OOC warning remains. These wide parallel ports are internal prototype
interfaces, not a proposal to connect all of them to package pins.

The report therefore proves a current capacity failure and failure of the
10ns analysis assumption. It does not prove board feasibility at any frequency.

## Concrete correction and next implementation work

Added run_system_vivado.ps1 and synth_system_ooc.tcl for reproducible full-top
analysis, plus audit_system_ooc.ps1 for machine-readable capacity/timing results.
The audit requires a completed batch log and rejects partial/failed runs.
The runner now refuses to return a capacity-pass marker when any mapped
resource exceeds device capacity; it preserves all reports and JSON first.
Negative WNS is reported separately, because 10ns is still only an assumption.
The capacity rejection was tested against these actual reports, and PowerShell
parsing passed. The initial measured runner predated this final audit/gate;
Vivado commands, Tcl and RTL are unchanged, and the audit was then executed on
the completed output. No second synthesis was needed for the gate change.

Priority for the next architectural iteration, preserving raw codes and faults:

1. Use shared iterative rounded-division arithmetic, producing quotient and
   remainder together. Preserve 64-bit guard behavior, zero/precision fault
   ordering, signs and ties-away rounding. Healthy operand magnitudes are
   bounded by the existing 2^53-1 guard; explicit widths may exploit that fact
   without accepting previously rejected inputs or changing numeric profiles.
2. Split QUALITY and other multi-operation phases into explicit scheduled
   steps, retaining request context and ready/valid/reset behavior. This must
   preserve the model's operation/fault order, not reassociate arithmetic.
3. Rework full-cycle caches and snapshot/window storage toward BRAM, preserving
   the owner-approved whole-cycle buffering and existing snapshot isolation.
   Do not silently shrink channel count, 304-sample capacity or 64-beat support.
4. Rerun beat/measurement edge vectors and the complete EXP-016 comparison,
   then repeat this same-target synthesis and measure cycle latency. A test
   watchdog change must follow a justified new latency bound, not conceal a
   deadlock. Lower LUT estimates alone are not implemented timing closure.

No larger FPGA, reduced numeric format, reduced feature set or product sampling
rate was selected. Host/physical ADC buffering, bus/IRQ/W1C and ACK/publication
priority remain unfrozen. They need owner decisions before a board bridge is
implemented, but do not prevent the internal arithmetic work above.

## Reproduce and evidence

```powershell
./toolchain/run_system_vivado.ps1 -VivadoBat C:/path/to/Vivado/bin/vivado.bat `
  -Part xc7a200tfbg484-2 -AnalysisClockNs 10 -BuildRoot C:/temp/bppe-full-ooc
```

The current revision is expected to finish Vivado analysis and then FAIL the
capacity gate. Inspect resource_timing_summary.json, utilization.rpt,
utilization_hierarchical.rpt, timing_synthesis_estimate.rpt and critical_paths.rpt.
The checkpoint/report files stay local; hashes of all eight RTL sources and
tooling are recorded per run. Stand-alone audit without -RequireCapacity emits
the summary; adding that switch rejects this oversized design.

Measured run: 20261106T040540196-c11582ec. Synthesis itself took 8m41s elapsed;
the whole batch, including timing/checkpoint generation, about 11m52s. Reported
main-process peak was approximately 4.3GB; parallel helpers also used memory
during synthesis. All processes completed normally. No user process or system
setting was changed. Existing EXP-016 functional evidence still applies because
the numerical RTL was not edited; it is not a hardware-fit result.
