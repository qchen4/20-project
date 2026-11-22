# ADR-006: 30 MHz FPGA engineering-prototype target

Status: owner-confirmed for the engineering prototype, 2026-11-06.

The owner changed the FPGA prototype clock target to 30 MHz. The analysis
period is 33.333 ns (a slightly conservative three-decimal representation of
1000/30 ns). This replaces the earlier exploratory 10 ns assumption for current
acceptance discussions. Historical experiment reports retain their actual
clock assumptions; their slack must not be compared directly across periods.

The full-system, frame and preprocessing Vivado runners now default to 33.333
ns and retain an explicit AnalysisClockNs override for reproducible historical
comparisons. The Tcl scripts apply create_clock to the core clk port using this
parameter. Current OOC experiments apply the clock after synthesis; they are
netlist timing estimates, not timing-driven implementation or board signoff.

Core clock and sample timestamps are separate domains of meaning. The model's
100 Hz default sampling, 1 ms acquisition ticks, integer observation deadlines,
numeric formats and algorithms are unchanged. Testbench clock periods are
functional simulation settings; measured cycle counts must be converted using
the target clock when assessing throughput. The 30 MHz target alone does not
freeze minimum sample throughput, arrival bursts, bounded consumer stalls or
physical FIFO depth.

No oscillator frequency, clock input pin, MMCM/PLL configuration, generated
clock, I/O delay, electrical standard or board reset timing is inferred from
the board model. Those require verified AX7A200 board/interface information.
No false-path or multicycle exception is introduced to satisfy the target.

Report these milestones separately: post-synthesis estimates; placed/routed
timing under stated constraints; complete board-clock/I/O/CDC and interface
validation. A positive OOC setup slack completes only the first milestone.

See EXP-021 for the same-period baseline/optimized comparison and conditional
latency/backpressure budget at 30 MHz.
