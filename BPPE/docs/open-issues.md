# BPPE 待决事项

版本：0.2-draft.1；状态：Draft；整理日期：2026-10-22。所有事项当前均为 Open；责任人只指定角色，实际姓名和期限待分配。P0 表示系统/算法基线阻塞，P1 表示相关模块冻结阻塞，P2 表示规划或工程整理。

## 原始规格中的问题

- **O-01｜P0｜算法负责人**：确定估算算法族、通道物理含义、适用模式和所需特征。影响 ALG-001、SYS-003 和整个数据通路。关闭依据：批准的 profile 和数据可行性证据。
- **O-02｜P0｜AFE 负责人**：ADC 编码、归一化、通道顺序、增益变化与光路标记。影响 ALG-002、NUM-001。关闭依据：输入编码说明及转换向量。
- **O-03｜P0｜系统/算法负责人**：timestamp 来源、tick、回绕无歧义范围、最大通道偏差与缺口。影响 ALG-005、REG 结果时间戳。关闭依据：量化阈值、示例与异常恢复规则。
- **O-04｜P0｜产品/算法负责人**：使用场景、标定、参考测量、准确性与无效率目标。影响 ALG-007/010、SYS-005。关闭依据：批准的评价协议及门槛。
- **O-05｜P0｜SoC 负责人**：确认 slave-only、MMIO 输入、支持访问类型和 burst。影响 SYS-002、REG-001/002。关闭依据：集成合同及总线波形。
- **O-06｜P1｜算法负责人**：采样率、预热、窗口、SQI、拒绝/等待与超时。影响 ALG-004～008。关闭依据：公式、参数、状态迁移和测试向量。
- **O-07｜P1｜微架构负责人**：HCLK、FIFO、stall、计算/中断延迟、idle 可见形式、门控及 PPA。影响 SYS-009～011、ARCH-008/009。关闭依据：有单位与条件的预算和资源估算。
- **O-08｜P1｜算法/RTL 负责人**：系数/标定装载、完整性、数值格式、BUSY 更新、epoch。影响 NUM-003～006、REG-008、ARCH-002。关闭依据：数值记录、装载协议和生效边界。
- **O-09｜P1｜固件/RTL 负责人**：结果保留、溢出、故障可见位置、IRQ/W1C/ACK。尤其须解决 RESULT_STATUS[2] 实时更新与快照稳定约束，以及 ACK 是否清 IRQ 原因。影响 REG-005～007。关闭依据：逐字段状态规则与竞态波形。
- **O-10｜P2｜系统负责人**：ECG/IMU/TEMP、流接口、DMA/Master 路线。关闭依据：独立扩展范围；不阻塞无此功能的 v1。

## 本次整理新增问题

- **O-11｜P1｜RTL/固件负责人**：冻结 START/ABORT/RESET、单次/连续模式、pending 期间计算、FIFO 生命周期、未写齐帧判定、非法访问/故障记录例外、同周期优先级、全部 CSR 位域和复位值。影响 ARCH-004～007、REG-003/009。关闭依据：完整状态迁移和寄存器行为；可拆分子问题但保留父编号。
- **O-12｜P2｜工程维护者**：现存 `c_model ` 目录尾随空格会触发 Git 路径警告。统一为标准路径并检查工具引用。本次文档整理未改名。
- **O-13｜P0｜算法/数据负责人**：建立数据格式、参考血压配对、受试者/会话划分、标定隔离、版本及存储协议。影响 ALG-003/010、NUM-008/009。关闭依据：数据说明与可复现实验输入。
- **O-14｜P1｜算法/数值负责人**：定点新增误差预算、有效性差异容限、合法饱和与恢复要求。影响 NUM-007～009。关闭依据：有依据的数值门槛及评价集合。
- **O-15｜P1｜验证负责人**：确定工具/版本、仿真器、MATLAB 工具箱、覆盖目标、协议断言与签核流程。影响 VER-001～004。关闭依据：可执行回归入口与批准的验证计划。

## 关闭与变更规则

2026-10-22 进展：O-01/O-06/O-08/O-09/O-11 在 [M0 实验基线](spec/algorithm-m0.md) 中选定了可执行的实验行为；O-15 已确认本机 MATLAB R2026b 可运行基础 MATLAB 回归。上述系统级问题仍为 Open，实验没有冻结真实算法、硬件接口或验证签核要求。

同日定点进展：O-08/O-14 已有三组位宽的 [实测新增误差与边界差异](experiments/EXP-002-fixed-point.md)，balanced 为实验默认；全范围阶跃引起的标准化饱和及复位恢复规则已记录。O-14 仍待真实参数和批准误差预算，不能凭演示数据关闭。

每项关闭时补充：决定内容、批准人、日期、适用版本、决策记录、受影响需求及验证证据。实验结果支持提案，但不自动等于批准。决定被替代时重新打开关联问题或建立新编号并链接原记录。

2026-11-06 进展：O-15 已实测本机 QuestaSim 10.6c 的预处理核仿真，见 EXP-007；O-07/O-09/O-11/O-14 仍开放，局部流控实验没有冻结产品总线、控制优先级或性能预算。


2026-11-06 prototype update: the owner confirmed continued computation while a result is pending, retaining the first snapshot and recording RESULT_OVERFLOW for later candidates; see ADR-004. O-09/O-11 remain Open for ACK/publication concurrency, IRQ/W1C and product register semantics. EXP-011 numerical/window validation does not close these system issues.


2026-11-06 integration update: EXP-012 validates accepted single-channel numerical processing and first-pending snapshot control. The owner selected serialized ACK/publication; collisions are rejected in simulation, and O-09/O-11 remain Open for product concurrency/bus/IRQ semantics. O-07 now has a preprocessing-only Vivado baseline (EXP-013): synthesis succeeds, but the assumed 10ns synthesized-netlist timing estimate fails; complete constraints and implementation are absent.

O-16 (prototype timing defect): exact 10-second floating comparison at ticks 8020->18020 could expire one frame late. The owner approved integer tick deadlines (ADR-005); MATLAB float/fixed and RTL boundary regressions now pass. This closes that defect in the audited experimental timing profile, without freezing a product timing/clock contract.


O-17 (Open, P1, RTL architecture; hardware implementation blocker): EXP-017 full balanced multichannel synthesis uses 328,859 LUT versus AX7A200's 134,600 (244.32%). FF/DSP fit, but 10ns analysis-only WNS is -427.170ns and BRAM use is zero. Close the capacity portion with behavior-preserving arithmetic/storage changes, passing raw-code/fault regressions and a same-target full-top capacity gate. Resource fit alone does not close O-07 implementation/constraint/timing work. No reduced channel/precision/buffer scope or replacement FPGA has been approved.


O-17 progress (still Open): EXP-018 replaces measurement rounded divisions with one shared iterative unit and registered SQI steps. Matched full-top LUT improves 328,859 to 288,918 (214.65% of AX7A200), and the 10ns post-synthesis WNS improves -427.170ns to -216.433ns. 23 positive simulations plus one expected ACK collision rejection preserve reference results/faults. The leading path moves to beat-engine arithmetic. Capacity and implementation timing remain blockers; cycle latency increases and no new throughput contract is implied. Whole-cycle caches/windows remain unchanged and still use no BRAM.


O-17 progress: EXP-019 schedules one guarded divider per beat engine, preserving completed raw codes, faults, whole-cycle capacity and handshake semantics. 32 positive Questa simulations pass, plus the expected ACK collision rejection. Full-top LUT changes 288,918 to 121495 (90.26%); the design passes the full-top device resource-capacity gate. The 10ns post-synthesis WNS is -23.151ns; no implementation timing signoff exists. Maximum observed multichannel processing latency is 17,993 cycles; the full 305-slot beat test takes 18,340 cycles. Physical throughput/buffering and product interfaces remain unfrozen. Resource-capacity evidence does not close O-07 clock/constraints/implementation work.


O-17 progress: EXP-020 shares a registered guarded multiplier per beat engine and maps all six whole-cycle arrays to six RAMB36 blocks without reducing numerical width or capacity. 33 positive Questa simulations pass plus the expected ACK collision rejection. Full-top LUT falls 121,495 to 69,474 (51.62%); FF 142,156 to 54,488 and DSP 391 to 139. The 10ns post-synthesis WNS is -21.001ns, with the remaining worst path in measurement arithmetic. No implementation timing signoff exists. Observed multichannel maximum is 22,730 cycles and the 305-slot beat takes 24,156 cycles. The conditional 85,572-cycle system test budget excludes external stalls; it is not a product WCET or minimum-throughput guarantee. EXP-020 quantifies nominal 100Hz model traffic separately from hypothetical clocks and the 8ms timestamp stress interval. Unbounded completion backpressure cannot be solved by a finite FIFO. O-07 clock/I/O/implementation work, physical ADC buffering and product concurrency remain open; see [EXP-020](experiments/EXP-020-beat-products-and-block-ram.md).


O-17 progress: EXP-021 shares registered products in measurement, preserves completed raw codes and faults, and adopts the owner-confirmed 30MHz/33.333ns target (ADR-006). 22 positive Questa simulations pass plus the expected ACK collision. At the same 33.333ns period, full-top LUT changes 69,474 to 67684 (50.29%), DSP 139 to 42, and post-synthesis WNS +2.332ns to +22.643ns. No placed/routed or board timing signoff exists. Observed multichannel maximum is 23,165 cycles; the conditional 88,060-cycle system budget is 2.93533ms at 30MHz, excluding external stalls and not a product WCET guarantee. The core target is now confirmed; O-07 still requires verified oscillator/clock generation, board I/O constraints, implementation and validation. Physical input buffering and product concurrency remain open. See [EXP-021](experiments/EXP-021-measurement-products-30mhz.md).


O-07/O-17 implementation progress: EXP-022 places and routes the balanced internal numerical core with one BUFG at 33.333ns on xc7a200tfbg484-2. It uses 67010 LUT (50.08%), 54943 FF, 42 DSP and 6 BRAM tiles. Internal routed setup WNS +9.544ns, hold WHS +0.026ns and pulse WPWS +15.536ns pass with no failing endpoints. Frame/acquisition and normal/clocked system RTL pass 21 positive simulations and two expected ACK-collision rejections with unchanged observed system data/latency. The acquisition history-clear feedback is removed; numerical arithmetic is unchanged. This is internal OOC implementation, not board timing signoff: clock source, boundary routes, board pins, external delays and CDC remain open. EXP-022 establishes internal resource/routing/timing evidence, while O-07 remains open for board context and physical traffic. The conditional 88,060-clock budget still excludes external stalls; it does not prove a FIFO depth or physical sampling rate. See [EXP-022](experiments/EXP-022-internal-clocked-implementation.md) and [board evidence](board-bringup-evidence.md).

O-18 (prototype structural-feedback defect, resolved in EXP-022): Vivado pre-place DRC found LUTLP-1 across acquisition ev_ready/clear_history/core_ready despite passing RTL simulations. The rejection clear now depends directly on the registered idle fence and rejection event; no protocol cycle, numerical precision or fault ordering changes. The original checkpoint reproduces the pre-place rejection, corrected source passes 21 positive simulations plus two expected ACK collision failures, and corrected internal route/DRC checks pass. No ALLOW_COMBINATORIAL_LOOPS waiver is used.

O-19 (Open, P2, implementation tooling): Constraints 18-8777 appears in EXP-022 and standalone 16-bit OOC counters both with and without BUFG on Vivado 2026.1. It is not BPPE-specific; exact missing files and boundary/export effects remain unidentified. EXP-023 reproduces saved internal timing (WNS +9.544ns, WHS +0.026ns) and zero route errors without exceptions or waivers, but does not establish that every effect of the warning is harmless. Preserve the diagnostic and recheck in full board context or with vendor guidance; do not suppress it or treat internal OOC results as board signoff. The audit now rejects all Error/Critical Warning log messages and records emitted warning IDs. See [EXP-023](experiments/EXP-023-tool-diagnostics-and-checkpoint-audit.md).

O-15 verification progress: EXP-024 adds seeded temporal system replay for all three profiles and normal/BUFG tops. 26 positives and four expected negative tests pass; 907,200 full-replay frames preserve the MATLAB results and observed processing maxima. Offered-frame/held-response stability and exactly-once checks supplement fixed three-cycle stalls. X/Z-sensitive raw-code comparisons now reject unknown expected features. This is finite RTL coverage, not formal/clinical/board signoff. O-19 remains open: ordinary top-level counter implementation does not emit 18-8777 while OOC does, but mode and I/O buffers differ together; the exact missing-file cause remains unknown.

O-15 verification progress: EXP-025 adds complete reference-case replay after coordinated local reset in seven three-channel contexts and idempotent idle ACK checks. All profiles and normal/BUFG tops pass 74 positives plus four expected negative tests, with unchanged production RTL, model results and observed latency maxima. Runtime faults reset to configured seeds; no second reset is inserted before replay. Product reset/abort/publication priorities, physical reset/CDC and board I/O remain open. These finite tests do not close O-07/O-09/O-11 or unresolved tool diagnostic O-19.

O-15 / V-BITTRUE progress: EXP-026 adds an independent C++ normalized frame validator and acquisition composition. 17,856 frames / 288 beats match the existing MATLAB export; 128 error combinations and 240,000 modular translation pairs pass under UBSan. All 31 CTests pass (12 positive, 19 expected negative). Full M1 measurement scheduling/pending control remains incomplete; board transport and product interfaces are not selected. See the updated prototype plan for current priorities.

O-15 / V-BITTRUE progress: EXP-027 completes the independent C++ running-session numerical controller, including measurement triggering, integer deadline, first-pending snapshot and serialized ACK. 151,200 frames / 303 candidates match MATLAB, including 117 overflow candidates, retained faults and all three known impulse outliers. UBSan-enabled CTest passes 53 tests (15 positive, 38 expected negative). Full product lifecycle/bus/concurrent event semantics, physical acquisition and board evidence remain outside this completed prototype reference scope. No RTL/PPA/board claim changes.

O-20 (Open, P1, prototype signal quality): EXP-028 traces seed37 impulse false acceptance to extra filtered zero crossings producing four regular ~0.4s cycles. Period CV0.049, accepted amplitude and zero rejected beats yield SQI193, while the true synthetic period is0.8s. Floating and fixed both accept the153bpm result. An expanded78-run study reveals a second120->126.38bpm outlier. Shadow SQI/shape gates trade fewer observed outliers for lost low-error reports; none is promoted. Close only with an approved quality/coverage objective, fresh validation and any required integer/RTL revalidation. This is separate from clinical/product O-04/O-13 acceptance.


O-20 fresh validation: EXP-029 freezes CV0.20 and SQI200 before 408 new synthetic records / 1,632,000 frames. All 6,120 windows replay exactly; independent phase/rule/summary checks pass. Of 4,618 baseline-valid candidates, six exceed the synthetic 5bpm period-error proxy (three paired outcomes across amplitudes). CV0.20 leaves two errors, removes 547 low-error candidates and increases zero-report runs from 8 to 26. SQI200 leaves zero observed errors but removes 701 low-error candidates, including 12 clean changing-rate results, with 16 zero-report runs. Morphology is worse on impulse-only retention despite better pooled retention. It stays default-off; neither rule is promoted and O-20 remains open. An acceptance objective and suitable new validation are required before a production decision; no clinical or board claim follows. See [EXP-029](experiments/EXP-029-fresh-shadow-validation.md).


O-20 bounded diagnosis: EXP-030 replays six observed EXP-029 error cases and
six clean controls with exact input hashes,48,000 frames,672 beats and810
crossings. Floating/fixed candidate boundaries match at all166 results; the
focused errors remain valid in both domains. One paired scenario doubles
detections, another omits a69.504ms short interval, and the CV0.20 residual
maps four generated lobes to four detections but shortens their summed duration
by76.879ms through boundary displacement. No threshold is changed or new
validation claim made. The bounded diagnosis is complete; further quality
changes require an objective/domain and independent confirmation data.
See [EXP-030](experiments/EXP-030-cycle-correspondence.md) and the
[next decisions](prototype-next-decisions.md).
