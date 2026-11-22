# EXP-013: Preprocessing out-of-context synthesis baseline

Tool: native Windows Vivado 2026.1, software build 6511674. The synthesis license
was successfully acquired for `xc7a200t`; this goes beyond version/part-query
startup checks. No hardware was connected and system settings were not changed.

Target: `xc7a200tfbg484-2`; top: `bppe_preprocess_core`, default balanced
parameters (signal/time F=8, coefficient F=18). Source SHA256:
`cc7e33bcb24b76a6083d0933b638522e26dcfb4122199e1cd198733e81d2488b`.

## Reproduce

```powershell
./toolchain/run_preprocess_vivado.ps1 -VivadoBat C:/path/to/Vivado/bin/vivado.bat `
  -Part xc7a200tfbg484-2 -AnalysisClockNs 10 -BuildRoot C:/temp/bppe-ooc
```

The runner creates a new run directory, records source/script hashes and
assumptions, caps the session to two synthesis processes, and retains the
checkpoint and reports. The Tcl script requires a fresh output directory.
Generated logs/reports/checkpoints remain local, outside committed source.

## Measured result and constraints

Synthesis completed successfully, process exit 0:

| Resource | Used |
| --- | ---: |
| LUT | 990 |
| Flip-flop | 239 |
| Latch | 0 |
| DSP48E1 | 8 |
| Block RAM | 0 |

This is one preprocessing core, not complete BPPE resource utilization.

Synthesis itself had no XDC timing constraints. A 10.000 ns clock was applied
**after synthesis** for exploratory synthesized-netlist timing analysis; 100 MHz
is an analysis assumption, not an approved product or board requirement.
Reported setup WNS was **-35.150 ns**, TNS **-3629.452 ns**, with 132 failing
endpoints. The implementation does not meet that assumed period in this
estimate. Do not turn these values into an achieved frequency or timing signoff.

There were no unclocked registers or unconstrained internal maximum-delay
endpoints, but 128 input and 248 output ports lacked delay constraints. No board
pin constraints, placement or routing were performed. Vivado warned about the
flat primitive-heavy netlist and missing OOC HD.CLK_SRC, which prevents clock
delay/skew estimation. These warnings and limitations remain recorded.

## Implications

Functional simulation success and synthesis success do not establish timing
closure. The current one-cycle preprocessing datapath needs a separate
timing-aware architecture/implementation study after clock, interface and
resource goals are chosen. Retiming/pipelining must preserve raw codes, fault
accounting and ready/valid behavior and rerun the existing comparisons.

Beat/window/measurement cores and the integrated single-channel prototype were
not synthesized in this experiment. Their wide division/product operations and
snapshot banks remain unoptimized. Full-IP PPA, implemented STA and AX7A200
board validation are still open.
