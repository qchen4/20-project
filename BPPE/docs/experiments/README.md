# BPPE 实验记录

用于浮点算法、范围分析、定点精度、位宽扫描和性能实验。已有 [EXP-001 M0 合成验证](EXP-001-m0-synthetic.md)。

定点实现与三组位宽评估见 [EXP-002](EXP-002-fixed-point.md)。

五类干扰、125 次随机噪声评估及有效输出边界见 [EXP-003](EXP-003-noise-robustness.md)。

固定失效案例、严格区间匹配和自动源码清单见 [EXP-004](EXP-004-engineering-regressions.md)。

C++ 标量整数参考、独立性质测试和 MATLAB 向量对照见 [EXP-005](EXP-005-scalar-integer-reference.md)。

C++ 因果预处理状态与逐样本原始码对照见 [EXP-006](EXP-006-causal-preprocessing.md)。

预处理 RTL、原始码和流控仿真见 [EXP-007](EXP-007-preprocessing-rtl.md)。

从 [模板](template.md) 创建 `EXP-001-主题.md` 等文件。记录输入与版本以及真实执行状态；不得将脚本生成或静态检查描述成 MATLAB 仿真通过。

大型数据和日志的保存位置由数据协议确定；清单应记录稳定标识与校验值。报告可入仓库，原始数据是否入仓库需按数据协议决定。


- [EXP-008: Whole-cycle beat/features](EXP-008-whole-cycle-beat-features.md): C++ reference and isolated RTL, raw-state comparisons and reset/backpressure checks.


- [EXP-009: ADC-to-feature pipeline](EXP-009-channel-pipeline.md): elastic integration, tagged scoreboard and prefetched-fault isolation.


- [EXP-010: Window/SQI/regression reference](EXP-010-window-measurement-reference.md): bounded-window integer evaluation, model gates and sticky-fault comparisons.


- [EXP-011: Window/SQI/regression RTL](EXP-011-window-sqi-regression-rtl.md): exact measurement snapshots, rolling storage, request isolation and nine QuestaSim checks.


- [EXP-012: Accepted single-channel prototype](EXP-012-accepted-single-channel-prototype.md): ADC-to-result integration, autonomous tick deadlines, pending/ACK, fault conservation and the retained impulse gap.
- [EXP-013: Preprocessing OOC synthesis](EXP-013-preprocess-ooc-synthesis.md): actual Vivado synthesis/resource baseline; negative timing estimate and incomplete constraints explicitly recorded.

- [EXP-014: staged preprocessing and acquisition preparation](EXP-014-staged-preprocessing.md) — unchanged raw-code regression, same-condition synthesis comparison and host timing-bound tests.

- [EXP-015: frame validation and channel dispatch](EXP-015-frame-validation-and-channel-dispatch.md) — public-model frame/error ordering, continuous-traffic acquisition wrapper and adapter-only synthesis.

- [EXP-016: multichannel numerical system](EXP-016-multichannel-numerical-system.md) — raw frames through windows/SQI/regression/pending, public-model comparison, backpressure, reset and fault lifetime.

- [EXP-017: full-top OOC capacity failure](EXP-017-full-top-ooc-capacity.md) — measured AX7A200 resource overflow, critical path, constraint limits and a resource-capacity gate.

- [EXP-018: shared iterative measurement divider](EXP-018-shared-iterative-measurement-divider.md) — exact signed division, SQI scheduling, boundary/random/reference regressions and matched full-top PPA comparison.

- [EXP-019: shared iterative beat divider](EXP-019-shared-iterative-beat-divider.md) — whole-cycle bit-exact scheduling, reset/capacity regressions, latency and full-top PPA.

- [EXP-020: scheduled beat products and block RAM](EXP-020-beat-products-and-block-ram.md) — bit-exact guarded multiplication, synchronous whole-cycle storage, reset/latency/backpressure coverage and matched full-top synthesis.

- [EXP-021: measurement products at 30 MHz](EXP-021-measurement-products-30mhz.md) — bit-exact scheduled products, reset/backpressure/full-window tests, matched-period synthesis and conditional latency budgets.

- [EXP-022: internal clocked implementation](EXP-022-internal-clocked-implementation.md): BUFG harness, unchanged numerical behavior, normal/clocked RTL regressions, internal placement/routing/setup/hold/DRC and explicit board-context limits.

- [EXP-023: tool diagnostics and checkpoint audit](EXP-023-tool-diagnostics-and-checkpoint-audit.md): minimal 18-8777 reproduction, unchanged saved timing/route checks, warning inventory and fail-closed audit regression.

- [EXP-024: deterministic temporal system verification](EXP-024-temporal-system-verification.md): seeded ready/valid stress, exactly-once/model checks and unknown-value scoreboard rejection.

- [EXP-025: reset recovery and serialized ACK boundaries](EXP-025-reset-recovery-and-ack-boundaries.md): seven integrated abort/replay contexts, restored fault seeds, empty/repeated ACK and all-profile normal/BUFG regressions.

- [EXP-026: C++ frame/acquisition reference](EXP-026-cpp-acquisition-reference.md): ordered frame validation and composed preprocessing/beat comparison on 17,856 MATLAB frames; 31 CTests pass including expected negative checks.

- [EXP-027: C++ running-session system reference](EXP-027-cpp-running-system-reference.md): integrates integer deadlines, windows/measurement, pending snapshots and serialized ACK; 151,200 frames / 303 candidates match, all 53 CTests pass including expected negative checks.

- [EXP-028: impulse false-acceptance cause and shadow gates](EXP-028-impulse-root-cause-and-shadow-gates.md): exact bad-window reconstruction, float/fixed reproduction and a78-run synthetic tradeoff study; no production threshold change.


- [EXP-029: fresh morphology-screening validation](EXP-029-fresh-shadow-validation.md): frozen default-off CV0.20 experiment on 408 new synthetic records, with dynamic-rate controls, independent result checks and explicit quality/coverage tradeoffs.


- [EXP-030: observed cycle correspondence](EXP-030-cycle-correspondence.md): bounded replay separates doubled detections, omitted short intervals and shifted boundaries; all12 records reproduce, no tuning or acceptance change.
