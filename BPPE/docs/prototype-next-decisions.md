# Next decisions for the BPPE engineering prototype

Current assessment after EXP-030,2026-11-06. This document distinguishes
completed evidence from the decisions needed to finish an on-board prototype.
It proposes a path; it does not approve interfaces or physical constraints.

## What is established

- MATLAB and independent C++ running-session references cover normalized input
  frames through preprocessing, beats, windows, SQI/regression and pending/ACK
  behavior. EXP-027:151,200 frames/303 candidates match;53 CTests pass including
  expected failures. Product START/ABORT and concurrent bus semantics are outside
  this contract.
- Multichannel RTL has numerical, temporal, backpressure and coordinated-reset
  regressions (EXP-024/025). The owner-approved whole-cycle cache, serialized
  ACK/publication, first-pending retention and integer deadlines are retained.
- At the owner-confirmed30MHz target, the internal OOC clocked core was placed
  and routed on xc7a200tfbg484-2:67,010 LUT,54,943 FF,42 DSP,6 BRAM; setup WNS
  +9.544ns and hold WHS+0.026ns (EXP-022/023). This is internal implementation
  evidence, not full board timing or a physical acquisition guarantee.
- Signal-quality limitations are reproducible, diagnosed and preserved.
  EXP-029's frozen fresh study and EXP-030's bounded follow-up establish
  distinct error mechanisms; neither SQI200 nor shape CV0.20 is promoted.

## Decisions in priority order

| Decision / evidence | Recommendation | Alternative and consequence | Work unlocked |
| --- | --- | --- | --- |
| First on-board demonstration | Board-local ROM replay of a bounded existing golden fixture, with JTAG/ILA observation. Keep its source compliant with ready/valid and use serialized ACK. | UART host replay if exercising a host link is the immediate goal; it adds framing, wiring, baud, flow-control, CDC and overflow decisions. Remaining in simulation avoids board integration but does not complete an on-board milestone. | Choose fixture/capture capacity, build a small demonstration wrapper, measure added resources and compare captured results. |
| Exact board/core revision and delivered files | Confirm the physical AX7A200/core revision and device marking; use matching delivered schematic/reference XDC and oscillator/reset electrical information. | A candidate manual or AX7A200B document is not sufficient evidence for this physical board. | Validated clock generation, reset synchronization, pins/bank standards, full-context implementation and board programming/capture. |
| Quality acceptance objective, before changing criteria | Keep baseline behavior for numerical demonstration, explicitly include a known failing quality case, and define the next quality study separately. Select acceptable error/coverage/no-report objectives and the intended data domain before promotion. | SQI200 removes all six observed EXP-029 proxy errors but loses701 low-error candidates; CV0.20 loses547 but retains two errors and has more zero-report runs. These counts do not determine a universally preferable policy. | A scoped algorithm branch, independent confirmation data, and any needed integer/C++/RTL revalidation. |
| Physical acquisition / host buffering, when a real source is selected | Obtain frame arrival/burst bounds, whether input can stall, maximum downstream stalls and overflow/recovery semantics. | For a controlled ROM source, honoring ready avoids choosing a physical ADC overflow policy. Continuous nonstallable acquisition needs an explicit bounded service/queue contract. | Defensible FIFO depth, CDC/adapters and missing/overflow recovery tests. |

The first two items unlock the next engineering milestone. Quality-policy
changes are not prerequisites for demonstrating known numerical behavior on
the board, provided the known quality limitations remain visible. No assumption
is made that the owner has selected ROM/ILA or UART.

## Proposed execution once the first path is selected

1. Verify delivered board evidence against the actual device; activate only
   confirmed clock/reset/I/O constraints.30MHz is already approved, while the
   oscillator and clock-generation details remain unverified for this board.
2. Build the smallest selected demonstration adapter using the existing core
   handshake/ACK behavior. For ROM/ILA, use a bounded golden input/result
   fixture and account for ROM/debug resources; no product AHB/AXI bus is needed
   merely to observe that fixture.
3. Simulate the wrapper, then perform full-context synthesis, placement/routing,
   clock/CDC/reset review, DRC and timing analysis. Revisit Vivado18-8777 without
   suppression; its exact cause and full-context implications remain unresolved.
4. Capture actual board operation and compare expected frames/results and
   reset behavior. Report physical execution separately from simulation and
   internal OOC evidence.

Do not freeze product bus/register/IRQ/W1C/START/ABORT concurrency merely to
finish this demonstration. Those become a separate integration contract when
the intended host/SoC is identified. No claim of product replacement, clinical
BP accuracy or completed board signoff follows from the present evidence.

Supporting records: [board evidence](board-bringup-evidence.md),
[prototype plan](prototype-plan.md), [open issues](open-issues.md),
[EXP-029](experiments/EXP-029-fresh-shadow-validation.md),
[EXP-030](experiments/EXP-030-cycle-correspondence.md).
