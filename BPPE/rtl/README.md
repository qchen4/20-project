# BPPE 独立预处理 RTL 实验核

`bppe_preprocess_core.sv` 是已接受 ADC 样本的 DC 跟踪和低通实验实现，尚不是完整 BPPE IP。数值基线为现有 compact、balanced、wide 三组 MATLAB 格式；整数系数由主机准备。

## 局部实验合同

- 单时钟、同步高有效复位；复位清历史、输出和数值故障。
- 一项输出缓冲，ready/valid 只在接受事件更新历史；输出受阻时输入不被重复消费，载荷与故障计数保持。
- 可在消费旧输出的同一周期接收下一样本。
- `clear_history` 只在输出槽为空时使用，清历史但保留数值故障；仿真断言拒绝占用时清理。这不是系统 ABORT/ACK/CSR 并发优先级的批准决定。
- `in_ticks` 是上游已经展开的内部 tick，可含通道偏移；不是原始 32 位采集时间戳。输入帧合法性与时序异常检测属于后续适配层。
- 每项接受事件使用原始整数系数；本轮各案例内系数稳定。不定义产品配置加载、epoch 或在线更新协议。
- 原始 DC、低通与时间码及 64 位诊断计数用于工程对照，不是最终寄存器格式或面积预算。

乘积与加法的宽容器只用于保留既有中间结果，不改变截位点。合法格式中最大的信号乘积为 `2^35 × (2^18−1) < 2^53`，加法操作数保守界小于 `2^36`，因此 DSP 段不会额外触发 MATLAB 精度保护。内部时间左移仍显式检查 `2^53−1` 界限；饱和与精度故障保持到完整复位。缩位按最近、中点远离零执行，固定分母不为零。

## 复现 QuestaSim 对照

在项目根目录 MATLAB 中生成观察向量：

```matlab
addpath(fullfile(pwd,'m_model'));
bppe_export_preprocess_vectors;
```

在项目根目录 PowerShell 中执行：

```powershell
.\toolchain\run_preprocess_questa.ps1 -QuestaBin '实际的QuestaSim安装目录\win64'
```

默认读取 `m_model/artifacts/preprocess-vectors/preprocess_vectors.mem`。可通过 `-Vectors` 和 `-BuildRoot` 指定独立输入/输出位置。每次运行建立新目录，编译源码、执行三组格式的原始码与流控检查，并保存工具版本及源码/向量/运行器哈希。退出码、明确成功标记和仿真错误共同决定是否通过。

本轮实际使用 QuestaSim 10.6c win64，编译零错误、零警告。三组原始码对照共 9,924 条记录均通过；另验证背靠背吞吐、输出受阻、复位与清理，并验证错误预期值会被拒绝。见 [EXP-007](../docs/experiments/EXP-007-preprocessing-rtl.md)。

本轮未执行综合、STA、资源/功耗估算或上板；testbench 的时钟周期只服务仿真，不是 FPGA 目标频率。尚无心搏、SQI、回归、总线接口或完整产品效果验证。


## Whole-cycle beat/feature engine

The experimental bppe_beat_core accepts preprocessed raw signal/DC/time and a warmup flag. Each accepted sample produces an output transaction; beat_valid identifies a five-feature beat. Configuration is latched, processing is multi-cycle, and blocked output stops input. Reset aborts work and clears faults; history clear requires idle/empty and retains faults. Run toolchain/run_beat_questa.ps1 against bppe_export_beat_vectors MEM output. The original EXP-008 baseline used combinational division. Current beat division and guarded products are scheduled through shared units, with synchronous whole-cycle BRAM storage (EXP-019/020). Measurement products are also scheduled (EXP-021); board implementation and timing validation remain pending. See [EXP-008](../docs/experiments/EXP-008-whole-cycle-beat-features.md).


## ADC-to-feature channel pipeline

The bppe_channel_core wrapper connects preprocessing to the beat engine through an elastic slot. Tags, warmup, configuration and upstream fault snapshots stay with their samples. Run toolchain/run_channel_questa.ps1 with bppe_export_pipeline_vectors output. See [EXP-009](../docs/experiments/EXP-009-channel-pipeline.md) for backpressure, reset and fault-alignment validation and remaining limits.


## Bounded-window SQI and regression RTL

The bppe_window_store collects last-N per-channel features and rejection baselines. The bppe_measurement_core snapshots a complete window/model/fault state and evaluates SQI, means, gates and regression with held ready/valid responses. Run measurement_vectors_to_mem.py on MATLAB measurement CSV, then run_measurement_questa.ps1. Nine simulations cover all 288 reference cases, reset, fault carry, snapshot isolation, next-window collection and 64-beat bounds. See [EXP-011](../docs/experiments/EXP-011-window-sqi-regression-rtl.md). These internal handshakes do not implement product ACK/IRQ/CSR semantics, and wide arithmetic remains unoptimized.


## Accepted single-channel prototype and synthesis baseline

The bppe_single_channel_prototype connects ADC, features, window and measurement with autonomous integer-tick deadlines and first-pending snapshot retention. Serialized ACK releases pending while retaining payload/faults; ACK/publication collisions are rejected in simulation. See [EXP-012](../docs/experiments/EXP-012-accepted-single-channel-prototype.md). Accepted-frame validation, shared multi-channel scheduling, bus/IRQ/W1C and implementation remain outside scope. The isolated preprocessing core has now synthesized in Vivado 2026.1, but its 10ns post-synthesis estimate fails (-35.150ns WNS); see [EXP-013](../docs/experiments/EXP-013-preprocess-ooc-synthesis.md). No full-IP timing signoff is claimed.


## Current preprocessing architecture (supersedes the original single-cycle timing)

Preprocessing is now a shared-multiplier multi-cycle engine: accepted input commits after ten edges, with an eleven-cycle minimum initiation interval. Coefficients and input metadata are captured on acceptance; held ready/valid output and fault alignment remain verified. clear_history requires idle/empty. [EXP-014](../docs/experiments/EXP-014-staged-preprocessing.md) records unchanged raw-code comparisons and the new 489 LUT / 541 FF / 2 DSP synthesis result. The old negative-WNS result above is the EXP-013 baseline. Current +4.840ns WNS is only a 10ns post-synthesis assumption, without placement/routing or I/O constraints. Full-IP timing remains unverified.


## Ordered frame and multi-channel acquisition RTL

The bppe_frame_dispatch adapter checks a complete typed running-session frame before emitting ordered channel events or one rejection event. The bppe_acquisition_channels wrapper serializes events through three independent channel histories and fences history resets behind older outputs. A later frame fault cannot contaminate a held result's fault snapshot. Both use local ready/valid contracts, with static numerical configuration and coordinated reset; they do not freeze product bus/lifecycle/ACK semantics. All seven simulations pass against 17,856 public-model frames and 288 beats; see [EXP-015](../docs/experiments/EXP-015-frame-validation-and-channel-dispatch.md). run_frames_questa.ps1 reproduces the tests. run_frame_vivado.ps1 synthesizes the adapter alone, not the full wrapper. Window/measurement integration and full-IP PPA remain next.


## Raw multichannel measurement prototype

The bppe_multichannel_prototype now connects acquisition, all-channel beat windows and shared SQI/regression/publication control. Frame errors re-anchor channel/window/deadline history while preserving pending snapshots and global numeric-fault counters. Configuration errors preserve history. Integer tick deadlines and signed modular latest-channel timestamps match MATLAB. sample_done is held until sample_ready in this new local interface; the older single-channel pulse interface remains unchanged. Pending allows further computation, preserving the first snapshot and recording RESULT_OVERFLOW. Serialize ACK with publication; the simulation guard rejects a collision. See [EXP-016](../docs/experiments/EXP-016-multichannel-numerical-system.md) and run_system_questa.ps1. Full-top PPA, physical buffering and product lifecycle/bus/IRQ/W1C remain unverified or unfrozen.


## Full-top synthesis blocker

The balanced bppe_multichannel_prototype maps to 328,859 LUT (244.32% of AX7A200), 140,037 FF, 391 DSP and zero BRAM. It cannot fit the current target. The exploratory post-synthesis 10ns estimate is -427.170ns WNS; the worst reported path runs through measurement QUALITY's serial wide arithmetic. See [EXP-017](../docs/experiments/EXP-017-full-top-ooc-capacity.md). run_system_vivado.ps1 preserves utilization/hierarchy/critical-path/checkpoint evidence and rejects resource overflow through audit_system_ooc.ps1. No numerical RTL changed in this experiment. Next share/schedule rounded divisions and rework storage toward BRAM, preserving exact codes, fault order and whole-cycle support. Board clocks/I/O/constraints and product interfaces remain separate work.


## Shared iterative measurement division

The measurement evaluator now shares one bppe_rounded_divider across its rounded divisions. It keeps full signed-64 fault guards, zero-divisor priority, exact 53-bit healthy magnitudes and nearest ties-away rounding. Explicit continuations preserve snapshots, fault order, backpressure and reset; external core ports are unchanged. [EXP-018](../docs/experiments/EXP-018-shared-iterative-measurement-divider.md) records 14,481 divider boundary/random records, 288 MATLAB measurement cases, 204,000 single/multichannel frames and directed tests. Same-condition full-top LUT drops 328,859 to 288,918; measurement hierarchy LUT drops 57,821 to 17,765. WNS under the post-synthesis 10ns assumption improves -427.170ns to -216.433ns. The top remains oversized (214.65% LUT) and has no implementation timing signoff. Maximum observed multichannel processing latency increases 665 to 2945 cycles; preprocessing's 11-cycle interval remains unchanged. New numeric_latency_bounds.svh derives watchdogs from division/loop counts. Cache organization and the approved whole-cycle semantics remain unchanged; BRAM inference is a later iteration.


## Shared iterative whole-cycle beat division

EXP-019 schedules one guarded divider per beat engine, preserving completed raw codes, faults, whole-cycle capacity and handshake semantics. 32 positive Questa simulations pass, plus the expected ACK collision rejection. Full-top LUT changes 288,918 to 121495 (90.26%); the design passes the full-top device resource-capacity gate. The 10ns post-synthesis WNS is -23.151ns; no implementation timing signoff exists. Maximum observed multichannel processing latency is 17,993 cycles; the full 305-slot beat test takes 18,340 cycles. Physical throughput/buffering and product interfaces remain unfrozen. See [EXP-019](../docs/experiments/EXP-019-shared-iterative-beat-divider.md) for arithmetic order, reset/capacity coverage, latency bounds and matched PPA.


## Scheduled beat products and synchronous whole-cycle storage

EXP-020 shares a registered guarded multiplier per beat engine and maps all six whole-cycle arrays to six RAMB36 blocks without reducing numerical width or capacity. 33 positive Questa simulations pass plus the expected ACK collision rejection. Full-top LUT falls 121,495 to 69,474 (51.62%); FF 142,156 to 54,488 and DSP 391 to 139. The 10ns post-synthesis WNS is -21.001ns, with the remaining worst path in measurement arithmetic. No implementation timing signoff exists. Observed multichannel maximum is 22,730 cycles and the 305-slot beat takes 24,156 cycles. The conditional 85,572-cycle system test budget excludes external stalls; it is not a product WCET or minimum-throughput guarantee. See [EXP-020](../docs/experiments/EXP-020-beat-products-and-block-ram.md) for guard equivalence, reset/read fencing, latency assumptions, FIFO implications and matched synthesis.


## Measurement product scheduling and 30 MHz target

EXP-021 shares registered products in measurement, preserves completed raw codes and faults, and adopts the owner-confirmed 30MHz/33.333ns target (ADR-006). 22 positive Questa simulations pass plus the expected ACK collision. At the same 33.333ns period, full-top LUT changes 69,474 to 67684 (50.29%), DSP 139 to 42, and post-synthesis WNS +2.332ns to +22.643ns. No placed/routed or board timing signoff exists. Observed multichannel maximum is 23,165 cycles; the conditional 88,060-cycle system budget is 2.93533ms at 30MHz, excluding external stalls and not a product WCET guarantee. See [EXP-021](../docs/experiments/EXP-021-measurement-products-30mhz.md) and [ADR-006](../docs/decisions/ADR-006-30mhz-prototype-clock.md). Current system/frame/preprocess Vivado runner defaults are 33.333ns; historical 10ns runs require an explicit override.


## Internal clocked placement and routing

EXP-022 places and routes the balanced internal numerical core with one BUFG at 33.333ns on xc7a200tfbg484-2. It uses 67010 LUT (50.08%), 54943 FF, 42 DSP and 6 BRAM tiles. Internal routed setup WNS +9.544ns, hold WHS +0.026ns and pulse WPWS +15.536ns pass with no failing endpoints. Frame/acquisition and normal/clocked system RTL pass 21 positive simulations and two expected ACK-collision rejections with unchanged observed system data/latency. The acquisition history-clear feedback is removed; numerical arithmetic is unchanged. This is internal OOC implementation, not board timing signoff: clock source, boundary routes, board pins, external delays and CDC remain open. See [EXP-022](../docs/experiments/EXP-022-internal-clocked-implementation.md). run_system_impl.ps1 creates the isolated implementation and audits timing/route/DRC; run_system_questa.ps1 -ClockedOoc checks the harness using the installed BUFG primitive. The wrapper is not a board top.


## Tool diagnostics and checkpoint inspection

[EXP-023](../docs/experiments/EXP-023-tool-diagnostics-and-checkpoint-audit.md) reproduces Constraints 18-8777 in a standalone tool probe and reopens EXP-022 without changing its DCP or internal timing results. The underlying missing files remain unresolved. inspect_system_checkpoint.ps1 records hashes, constraints, methodology and saved route/timing checks; audit_system_impl.ps1 rejects Critical Warning log messages and retains warning IDs. test_implementation_audit.ps1 checks this rejection against copied implementation evidence. No numerical RTL or interfaces change, and no board signoff is claimed.


## Deterministic temporal system verification

[EXP-024](../docs/experiments/EXP-024-temporal-system-verification.md) adds optional `run_system_questa.ps1 -TemporalStress -StressSeeds 1,20261106`. It varies input gaps and completion backpressure, offers real future frames while blocked, checks stable payloads and exactly-once transactions, and reuses the unchanged MATLAB raw-code oracle. Normal/BUFG tops and all three profiles pass; unknown expected features are explicitly rejected. Production RTL and physical throughput assumptions are unchanged.


## Integrated reset recovery and serialized ACK checks

[EXP-025](../docs/experiments/EXP-025-reset-recovery-and-ack-boundaries.md) adds `run_system_questa.ps1 -RecoveryChecks`. Seven three-channel reset contexts replay the complete current MATLAB case after a single coordinated reset, preserving configuration and checking restored fault seeds. Empty/repeated idle ACK retains snapshot/counters/faults. All profiles and normal/BUFG tops pass; numerical RTL, physical reset assumptions and product event priorities are unchanged.
