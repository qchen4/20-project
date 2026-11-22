# BPPE FPGA 工程原型推进计划

范围依据：[ADR-003](decisions/ADR-003-fpga-engineering-prototype.md)。本节状态更新至 EXP-028；下方阶段记录保留当时的结果与限制。当前已完成合成 PPG 多通道数值 RTL 和 30 MHz 内部 OOC 布局布线，尚未上板或完成产品接口。独立 C++ 已连接完整运行会话的数值、测量调度、整数 deadline 和 pending/错开 ACK，并匹配已有系统向量；产品总线和 START/ABORT 生命周期仍不在该模型范围内。

## 已完成的基础

- 因果浮点/整数定点模型、合成发生器、三组位宽、故障与固定失效案例；强脉冲误判仍保留。
- 从完整帧校验到多通道预处理、整周期特征、窗口、SQI/回归和 pending 快照的 RTL 原型；EXP-024/025 补充背压、复位恢复和错开的 ACK 验证。
- 独立 C++ 标量、预处理、心搏、测量模块；EXP-026 补齐采集，EXP-027 连接运行会话调度/pending 控制，151,200 帧、303 候选与 MATLAB 一致，强脉冲已知缺陷继续保留。
- QuestaSim 10.6c 回归及带来源哈希的实验记录；模型、C++、RTL 和实现证据分别报告。
- Vivado 2026.1 在 xc7a200tfbg484-2、33.333 ns 下完成内部 OOC 布局布线（EXP-022/023）。这不是板级签核；18-8777 的具体成因和全部影响仍未确认。

## 下一项优先工作

1. **运行会话参考已完成**：EXP-027 完成上述 C++ 集成并在 UBSan 下通过 53 项测试。后续模型/RTL 修改应继续运行模块和完整系统对照；证据不覆盖周期时序、产品生命周期或并发事件优先级。
2. **需要 Jeremy 选择**：首次上板演示采用片上短向量 ROM + JTAG/ILA、主机 UART，还是暂维持实现/仿真。前者可避免先定义物理采集链路；UART 需要额外的帧格式、流控、CDC 和溢出合同。尚未选择任何一种。
3. **需要实物证据**：核实 PCB/core-board 版本、器件标识与交付 XDC/原理图，确定时钟/复位电气条件和实际连接，再做完整约束实现与板上捕获。不得根据候选手册引脚直接生成可下载工程。
4. 产品模块替代、真实数据和临床准确性独立验收；当前合成工程原型不能证明这些目标。

## 推进顺序

1. **可复现基线**：已有测试与固定噪声案例可一条命令运行；工程回归门槛与已知质量缺口分别报告。见 [EXP-004](experiments/EXP-004-engineering-regressions.md)。
2. **原型合同**：确认板卡、工具、输入/输出传输、时钟复位、最小控制/结果行为。现有 AHB-Lite 是系统候选方案；是否用于首次 FPGA 演示仍待确认。
3. **独立整数参考**：以实际 MATLAB 截位点及故障行为为合同，建立 C++ 参考、输入/预期输出向量和中间状态对照。不得只比较最终压力数值。
4. **RTL 分块实现**：先控制/缓冲与一条通道，再扩大到完整链路。验证背压、事务只消费一次、复位/中止恢复及结果保持。
5. **目标器件实现**：使用确认的 Vivado 版本、器件及板卡约束，完成综合、STA、资源报告与上板回放。频率、资源及功耗目标由负责人确认，不能把工具默认值当成产品要求。

## 当前需要确认

- 已确认板卡 AX7A200，仿真使用 QuestaSim。完整 FPGA part、板卡版本和匹配的官方约束/原理图在上板前核对。
- 已运行 QuestaSim 10.6c 和 Vivado 2026.1；工具可用性不再是阻碍，板级匹配资料仍缺。
- 首次演示采用片上预存合成向量回放，还是通过主机逐帧传输；后者还需确认主机连接。
- 最小接口、异常与结果有效性规则，以及用于工程比较的基线与门槛。已有 O-07/O-09/O-11/O-14 继续开放。

## 验收边界

模型测试通过、定点新增误差、RTL 逐位一致性和 FPGA 时序/资源分别记录。真实产品模块替代还需要现有模块的接口和对照数据；真实血压评价需要独立数据及批准协议，均不由当前合成演示替代。

用户的商业意图原文保留本地，不纳入源码版本。


## Beat/feature stage update

The owner approved whole-cycle caching for the prototype. The C++ beat reference and isolated multi-cycle beat/feature RTL are verified against MATLAB; see [EXP-008](experiments/EXP-008-whole-cycle-beat-features.md). Next integrate preprocessing and beat handshakes, then implement beat-window/SQI/regression. Full RTL pipeline, target synthesis/STA and board validation remain outstanding.


## ADC-to-feature pipeline update

Preprocessing and whole-cycle beat RTL are connected and verified with two samples in flight; see [EXP-009](experiments/EXP-009-channel-pipeline.md). Next stages are bounded beat-window/SQI/regression reference comparisons, then RTL integration and full transaction behavior. Target synthesis and board verification remain pending.


## Window measurement reference update

The bounded-window C++ SQI/model-gating/regression evaluator now matches MATLAB, including reason flags and sticky faults; see [EXP-010](experiments/EXP-010-window-measurement-reference.md). Its clear_window operation retains the ongoing beat cycle. Window/SQI/regression RTL, timeout/publication controller and full-system comparisons remain to be implemented.


## Window/SQI/regression RTL update

The rolling window store and isolated numerical evaluator now match the 288 MATLAB/C++ cases; see [EXP-011](experiments/EXP-011-window-sqi-regression-rtl.md). Atomic snapshot/window clear and next-window collection are verified. Next connect the channel pipeline and shared numeric-fault lifetime, then implement observation triggering/publication. [ADR-004](decisions/ADR-004-prototype-pending-result.md) records the owner-confirmed pending policy; ACK/publication races and bus/IRQ/W1C remain open.


## Accepted single-channel integration and OOC baseline

[EXP-012](experiments/EXP-012-accepted-single-channel-prototype.md) connects the accepted ADC sample through the complete numerical path and first-pending snapshot control. It matches MATLAB on 52,800 frames and 126 candidates, with owner-approved integer tick deadlines (ADR-005) and serialized ACK events (ADR-004). Next are acquisition validation, multi-channel scheduling and remaining product control. [EXP-013](experiments/EXP-013-preprocess-ooc-synthesis.md) records actual preprocessing-only synthesis: 990 LUT, 239 FF, 8 DSP, but -35.150ns post-synthesis WNS under a 10ns assumption. Full-IP synthesis, timing closure and board validation remain open.


## Staged preprocessing and acquisition preparation

[EXP-014](experiments/EXP-014-staged-preprocessing.md) resolves the original preprocessing combinational bottleneck by a numerically equivalent shared-multiplier schedule. All 18 relevant Questa simulations pass; full prototype latency increases by ten cycles. The preprocessing-only 10ns synthesis estimate improves to +4.840ns WNS, without implementation timing signoff. The host frame-tick bound encoder is verified against the current MATLAB predicates. Next implement ordered frame validation and one-to-three-channel dispatch, preserving rejection precedence and history-reset behavior; frame errors must be ordered after older accepted numerical work. Whole-system multi-channel numerical integration, product control, full-IP implementation and board validation remain open.


## Acquisition/channel integration update

[EXP-015](experiments/EXP-015-frame-validation-and-channel-dispatch.md) verifies full-frame validation, ordered one-to-three-channel dispatch and the synthesizable acquisition wrapper through beat/features. Seven Questa simulations cover 17,856 frames, 35,415 events, 288 beats, backpressure, coordinated reset, rejection fences and fault snapshots. The 11-cycle preprocessing input constraint is respected; measured frame latency is stimulus-dependent, not a guaranteed physical ADC rate. Frame-adapter-only Vivado synthesis passes; the replicated wrapper has not been synthesized. Next integrate multi-channel window/SQI/regression and global fault/publication lifetime. Preserve pending snapshots on frame errors according to MATLAB. Product lifecycle/control and physical acquisition buffering still require their own contracts and verification.


## Multichannel window/publication integration update

[EXP-016](experiments/EXP-016-multichannel-numerical-system.md) completes the running-session raw-frame to pending-measurement numerical prototype. Its 72 profile-cases cover 151,200 frames, 303 candidates, 117 overflow candidates and 108 rejected frames, including pending/numerical-fault retention across errors. Seven positive Questa simulations and one expected ACK-collision rejection pass; MATLAB's 51-test suite also passes. The known impulsive-noise gap remains explicit. Next evaluate full-top synthesis/resources/critical paths and broaden temporal/boundary coverage, then agree the physical acquisition/host bridge and lifecycle contract. No full-system timing signoff or board-rate claim is available.


## Measured full-top capacity blocker

[EXP-017](experiments/EXP-017-full-top-ooc-capacity.md) completes actual balanced full-top Vivado OOC analysis for AX7A200. Current LUT use is 244.32%; the 10ns analysis-only setup WNS is -427.170ns. Hardware implementation is blocked despite the EXP-016 functional comparisons. The reproducible flow now fails a resource-capacity gate and preserves a JSON summary plus raw reports. Priority is shared iterative division, scheduled QUALITY operations and BRAM-oriented storage without silently reducing numeric/channel/buffer capabilities. After raw-code/fault regressions pass, repeat same-target PPA before implementation/board work. No product rate, larger board or bus/ADC contract was selected.


## Shared-divider measurement iteration

[EXP-018](experiments/EXP-018-shared-iterative-measurement-divider.md) implements shared iterative rounded division and registered SQI/measurement scheduling without changing algorithms, profiles or external core interfaces. All 23 positive Questa simulations pass and the expected ACK-collision guard is retained. Matched one-worker full-top synthesis reduces LUT by 12.1% and measurement hierarchy LUT by 69.3%; WNS improves to -216.433ns under a 10ns post-synthesis assumption. The design still exceeds AX7A200 LUT capacity by more than 2x. Next apply scheduled arithmetic to the beat engine, then evaluate explicit BRAM ports/read staging and banked window snapshots while preserving full-cycle history and isolation. Hardware capacity, implementation STA and physical host/ADC integration remain open; no minimum real-time throughput or product protocol was frozen.


## Beat arithmetic scheduling iteration

EXP-019 schedules one guarded divider per beat engine, preserving completed raw codes, faults, whole-cycle capacity and handshake semantics. 32 positive Questa simulations pass, plus the expected ACK collision rejection. Full-top LUT changes 288,918 to 121495 (90.26%); the design passes the full-top device resource-capacity gate. The 10ns post-synthesis WNS is -23.151ns; no implementation timing signoff exists. Maximum observed multichannel processing latency is 17,993 cycles; the full 305-slot beat test takes 18,340 cycles. Physical throughput/buffering and product interfaces remain unfrozen. See [EXP-019](experiments/EXP-019-shared-iterative-beat-divider.md). Continue remaining-path and explicit-memory-port work without reducing channel count, buffer capacity or numerical precision.


## Beat products and BRAM iteration

EXP-020 shares a registered guarded multiplier per beat engine and maps all six whole-cycle arrays to six RAMB36 blocks without reducing numerical width or capacity. 33 positive Questa simulations pass plus the expected ACK collision rejection. Full-top LUT falls 121,495 to 69,474 (51.62%); FF 142,156 to 54,488 and DSP 391 to 139. The 10ns post-synthesis WNS is -21.001ns, with the remaining worst path in measurement arithmetic. No implementation timing signoff exists. Observed multichannel maximum is 22,730 cycles and the 305-slot beat takes 24,156 cycles. The conditional 85,572-cycle system test budget excludes external stalls; it is not a product WCET or minimum-throughput guarantee. See [EXP-020](experiments/EXP-020-beat-products-and-block-ram.md). Next inspect the reported measurement product/guard path while preserving numerical order. Physical clock, ingress burst/consumer stall bounds and buffering remain required before a real-time claim.


## Measurement products at the confirmed clock target

EXP-021 shares registered products in measurement, preserves completed raw codes and faults, and adopts the owner-confirmed 30MHz/33.333ns target (ADR-006). 22 positive Questa simulations pass plus the expected ACK collision. At the same 33.333ns period, full-top LUT changes 69,474 to 67684 (50.29%), DSP 139 to 42, and post-synthesis WNS +2.332ns to +22.643ns. No placed/routed or board timing signoff exists. Observed multichannel maximum is 23,165 cycles; the conditional 88,060-cycle system budget is 2.93533ms at 30MHz, excluding external stalls and not a product WCET guarantee. See [EXP-021](experiments/EXP-021-measurement-products-30mhz.md). Next establish an implementation-level clock/I/O context and bounded physical ingress/consumer behavior before claiming board readiness or sizing a FIFO.


## Internal implementation milestone

EXP-022 places and routes the balanced internal numerical core with one BUFG at 33.333ns on xc7a200tfbg484-2. It uses 67010 LUT (50.08%), 54943 FF, 42 DSP and 6 BRAM tiles. Internal routed setup WNS +9.544ns, hold WHS +0.026ns and pulse WPWS +15.536ns pass with no failing endpoints. Frame/acquisition and normal/clocked system RTL pass 21 positive simulations and two expected ACK-collision rejections with unchanged observed system data/latency. The acquisition history-clear feedback is removed; numerical arithmetic is unchanged. This is internal OOC implementation, not board timing signoff: clock source, boundary routes, board pins, external delays and CDC remain open. See [EXP-022](experiments/EXP-022-internal-clocked-implementation.md). Next resolve [board, clock and ingress evidence](board-bringup-evidence.md), select the first demonstration transport and establish bounded arrival/consumer behavior before physical FIFO sizing and full-context board implementation.


## Impulse-quality investigation

[EXP-028](experiments/EXP-028-impulse-root-cause-and-shadow-gates.md) reconstructs the known false-valid window and confirms the same failure in float/fixed. A78-run balanced single-channel study compares shadow SQI and shape-consistency gates and finds a second outlier on a new seed. No gate is enabled: selecting a quality/coverage objective and any experimental branch remains an owner decision, followed by fresh validation and integer/RTL work if needed. Existing board-transport and physical-constraint decisions remain pending.


## Fresh default-off morphology validation

[EXP-029](experiments/EXP-029-fresh-shadow-validation.md) completes the authorized
independent experiment: 408 new synthetic records, 1,632,000 frames, all 6,120
window reconstructions and independent phase-reference checks pass. Fixed
CV0.20 leaves two of six observed period-proxy errors, removes 547 low-error
candidates and produces 26 zero-report runs versus baseline's eight. SQI200
leaves zero observed errors but removes 701 low-error candidates, including
12 clean changing-rate candidates. The pooled retention advantage of shape
screening reverses in the impulse-only strata. Neither candidate is promoted;
production thresholds and numerical/RTL contracts remain unchanged.

Next independent work may inspect detected-cycle correspondence using the
known generated phase, retaining these counterexamples. Before adopting a
quality rule, select the quality/coverage/no-report objective and validation
domain; any retuning needs a new untouched confirmation set, and any hardware
gate needs an integer contract plus timing/resource verification. Board/demo
transport and physical constraints remain owner-dependent open items.


## Current next milestone after EXP-030

The bounded observed-counterexample diagnosis is complete:12 records reproduce
exactly; source-phase checks distinguish extra detections, omitted short gaps
and boundary displacement. The residual shape-screening failure persists in
floating arithmetic. Production criteria remain unchanged, and no further
threshold sweep on EXP-029 is planned.

The next high-value milestone is a first physical demonstration. Recommend
board-local ROM replay plus JTAG/ILA, subject to owner selection and verified
board/core revision, delivered XDC/schematic and clock/reset information.
UART is an alternative with additional transport/flow-control/CDC requirements.
Quality-policy changes need a separate objective and validation decision but
need not block demonstrating the existing numerical contract and known limits.
See [concrete decisions and proposed execution](prototype-next-decisions.md).
