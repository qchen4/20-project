# Board, clock and ingress evidence for the engineering prototype

Status: preparation evidence, not an enabled board constraint set. Core target
30 MHz is owner-confirmed in ADR-006. The owner identified AX7A200; PCB/core-board
revision and matching delivered schematic/XDC are still unconfirmed.

## Board-document provenance

Official document entries exist for
[AX7A200](https://www.alinx.com/public/upload/file/AX7A200_User_Manual.pdf),
[AX7A200B](https://www.alinx.com/public/upload/file/AX7A200B_UG.pdf) and
[AC7A200](https://www.alinx.com/public/upload/file/AC7A200_UG.pdf).
Direct retrieval on 2026-11-06 returned an HTML verification response, not PDF
bytes. No official-download hash or AX7A200B full-document comparison was obtained.

The ALINX-branded AX7A200 manual was read from this
[document mirror](https://github.com/fpgauk/pdf/blob/main/alinx/ax7a200/AX7A200_User_Manual.pdf).
Its printed version is Rev 1.0, 2019-07-10, 59 pages; file SHA-256 is
F1AB843010A163484846BB3CB8F60E91C68C0A4F0D6695FE739FADD77E516DB9.
It was text-extracted and pages 14, 48 and 55 were visually checked.
The mirror has not been byte-matched to the official download or the owner's
delivered documents. PDFs/screenshots are not redistributed in this repository.

| Candidate fact in that manual | Page | Status for this project |
| --- | ---: | --- |
| XC7A200T-2FBG484I | 12 | Consistent with the current xc7a200tfbg484-2 analysis target; verify physical part/revision |
| 200 MHz differential system oscillator; SYS_CLK_P R4, SYS_CLK_N T4 | 14 | Candidate source/pin pair; no active pin or electrical-standard constraint |
| Separate 125 MHz GTP reference | 15 | Not selected as the prototype core clock source |
| UART1_RXD L14, UART1_TXD L15 | 48 | Candidate labels; establish FPGA-side direction and electrical interface before use |
| RESET F15, active-low button | 54–55 | Candidate board input; core currently requires synchronous active-high reset |

No IOSTANDARD, termination, voltage, jitter or clock-generation parameters are
inferred from the oscillator's name. The 200-to-30 frequency ratio alone does
not validate an MMCM/PLL configuration. A delivered reference XDC/schematic,
actual bank supplies and clocking-tool checks are needed before activation.

## Implemented numerical boundary versus board boundary

bppe_multichannel_prototype consumes normalized complete ready/valid frames and
static configuration. It has synchronous reset and ready/valid completion,
with first-pending snapshot retention and serialized ACK/publication events.
It is not a board pin interface or an implemented AHB/AXI/UART endpoint.

EXP-022's bppe_ooc_clocked_top adds one BUFG inside an OOC implementation
harness. The clock buffer is placed by Vivado, not assigned to a guessed board
location. Its clk port is an abstract 30 MHz source. Internal clock/data routes
can be evaluated while oscillator/MMCM, boundary routes, board pins, CDC and
external I/O timing remain outside the result. No bitstream is generated.
This follows the distinction in
[AMD UG905, I/O and Clock Buffers](https://docs.amd.com/r/2022.1-English/ug905-vivado-hierarchical-design/I/O-and-Clock-Buffers).

## Ingress and buffering conditions

The model default is 100 frames/s with 1 ms acquisition ticks. Each frame
contains 1–3 active channels; channel count does not multiply frame frequency.
The accepted 8 ms minimum timestamp spacing represents a 125-frame/s arrival
stress only if wall-clock delivery follows those timestamps. Host replay can
burst faster. No actual ADC, AFE adapter, peak/burst envelope or host transport
has yet been accepted for the first board demonstration.

EXP-021's conditional default-capacity budget is 88,060 clocks, or 2.93533 ms
at nominal 30 MHz before arbitrary external stalls. This is a regression
watchdog derived from scheduled loops, not a formal WCET or physical service
guarantee. The core's sample_ready input can delay completion indefinitely.
Consequently no finite FIFO depth can currently be justified as lossless for
continuous nonstallable input. Queue sizing needs an arrival envelope, service
bound, maximum consumer stalls and their repetition/recovery behavior.

For a source that respects in_ready, holding the complete frame until transfer
preserves data without choosing a physical ADC overflow policy. For a
nonstallable source, dropping newest/oldest, reporting overflow and continuing
history versus aborting the window are product decisions; the current proposed
register FIFO text must not silently choose them for this prototype.

## Decisions and evidence still needed

The first demonstration can be chosen without redefining the final product bus:

| Candidate path | What it establishes | Additional work / limit |
| --- | --- | --- |
| Small board-local vector ROM plus JTAG/ILA observation (suggested first step) | Known input/result sequence on the FPGA with a source that obeys ready | Select a bounded fixture and capture depth; account for ROM/ILA resources; does not exercise a physical ADC or host data link |
| Host USB-UART frame replay/result readback | Host-to-core framing and backpressure in addition to the numerical chain | Confirm UART wiring, clock-domain crossing, baud/framing, flow control and buffer/overflow rules before implementation |
| Internal implementation and simulation only for now | Continues numerical/structural/timing verification while board details are unavailable | No claim about oscillator, pins, physical transport or real-board execution |

These are options, not accepted interfaces. A short ROM fixture would complement
the full host-side regression, not replace it; its exact vectors and observation
checks must be selected before allocating storage. No option is assumed chosen.

1. Match the board/core revision and device marking to delivered schematic/XDC.
2. Select the first demonstration path: board-local vector replay plus JTAG/ILA,
   host UART replay, or implementation-only work for now. A question was sent
   to the owner; no answer is assumed here.
3. For that path, define reset/clock generation, input/output timing or CDC,
   accepted framing, burst/stall limits and observation method.
4. Only then size/integrate the physical queue and constrain its board signals.
   Validate reset recovery, missing/extra frames, overflow and long stalls.
5. Perform full-context implementation/DRC/timing and board capture. Internal
   OOC setup/hold results alone cannot close this milestone.
