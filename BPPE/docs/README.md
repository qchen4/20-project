# BPPE 规格导航与协作流程

- 文档集版本：0.2-draft.1
- 状态：Draft
- 整理日期：2026-10-22
- 来源：`doc/BPPE_Specification_v0_1_download.docx`，BPPE-SPEC-001，v0.1，2026-10-08。
- 审批：未批准；批准人、日期和适用版本待填写。

本次整理将原始 Word 的系统、接口、算法和验证内容拆分成可版本管理的 Markdown，并补充需求编号、待决事项、验收方法和协作记录。0.2-draft.1 是本次文档集标识，不表示原始设计已升级或通过评审。

## 阅读顺序与信息归属

1. [system.md](spec/system.md)：功能边界、外部约束、系统验收。
2. [algorithm.md](spec/algorithm.md)：计算含义、数据协议、观测和有效性。
3. [numeric.md](spec/numeric.md)：位宽、量化、算术行为与误差预算。
4. [architecture.md](spec/architecture.md)：模块、控制、缓存、资源和时序。
5. [registers.md](spec/registers.md)：软件可见地址、字段及副作用。
6. [verification.md](spec/verification.md)：需求到测试的映射及发布门槛。
7. [待决事项](open-issues.md)：跨文档未决问题和责任角色。

已实现的实验算法另见 [M0 浮点细则](spec/algorithm-m0.md) 和 [运行说明](../m_model/README.md)。它记录实际内部选择，不自动冻结本套系统草案。

定点实现见 [M1-MATLAB 数值细则](spec/numeric-m1-matlab.md)，评估见 [EXP-002](experiments/EXP-002-fixed-point.md)。独立 C++ 标量数值层见 [EXP-005](experiments/EXP-005-scalar-integer-reference.md)，尚非完整 C++ M1。

同一参数只在所属规格中维护定义，其他文档引用其条目。地址和位域以 registers.md 为归属文档；数值格式以 numeric.md 为归属文档；算法含义以 algorithm.md 为归属文档。数据与模型配置的可执行文件在格式批准后引入，当前没有可执行配置或生成器。

如 Word、Markdown、模型或 RTL 不一致，记录问题并核对批准版本。当前 Markdown 是候选工作基线，Word 是历史来源；两者均未批准，不能仅凭文件日期判定争议内容已经生效。

## 状态与要求用语

文档状态使用 Draft、In Review、Approved、Superseded。只有获得明确批准并记录版本、批准人、日期后，才可标记 Approved。未填写批准信息时保持 Draft。

条目状态使用：

- **候选要求**：来自原始规格或本次补充的预期行为，审批后成为实现约束。
- **提案**：需要明确选择的方案，不得自动当成已冻结要求。
- **TBD**：尚无足够信息，链接到待决事项。

本套文档中的“必须/不得”描述候选要求的验收语义，不代表已经批准。原始规格中的 proposed、TBD 不因迁移而升级。新增细化内容均是提案；批准时应逐项检查。

需求编号稳定且不复用：SYS、ALG、NUM、ARCH、REG、VER。删除要求时保留废止记录及替代编号。修正措辞不改变编号；实质变更需记录原因和受影响测试。

## 与 Codex 的工作约定

每个任务先指定相关需求、输入文件、交付物和通过条件。Codex 读取对应规格与待决事项后，可完成文档草案、实现、实验和验证记录；不能自行将 TBD 填为已批准参数，不能宣称未运行的测试通过。

探索性实现允许临时参数，但必须标记 experimental，记录假设和适用范围。临时参数不得反向成为已批准规格。算法调整、模型重新训练与位宽调整应分别记录，便于归因。

任务完成时记录：

1. 修改的需求、文件及原因。
2. 使用的数据、模型、参数及版本。
3. 实际执行命令、环境和结果；失败与未执行项分别列明。
4. 新增或关闭的待决事项。
5. 下一步及阻塞条件。

涉及架构选择时建立 [决策记录](decisions/README.md)；涉及数据、精度或性能比较时建立 [实验记录](experiments/README.md)。一般文档修正可直接通过 Git 差异追踪，不必每次生成独立记录。

## 当前阶段与推进顺序

- 已有：原始 v0.1 Word、本套候选规格、MATLAB M0 实验模型及合成测试；执行记录见 [EXP-001](experiments/EXP-001-m0-synthetic.md)。
- 已增加：MATLAB 内部定点实验模型、三组位宽扫描与精度/行为差异评估。
- 未有：系统级批准的算法、真实数据集协议、正式误差预算、C++ M1、完整 RTL 和真实血压评价。
- 首先：解决 O-01～O-05，明确输入、算法方向与系统边界。
- 然后：建立因果浮点模型和测试数据，冻结控制/寄存器语义。
- 再后：范围分析与定点化、C++ 模型、RTL 和逐位回归。

接口骨架可在相关接口条目批准后先行实现。测试结果发生器必须与真实血压估算模型区分，并明确不提供算法有效性证据。

## 来源覆盖

- 原文 §1～3、§9～10、§13：system.md 与 architecture.md。
- 原文 §4、§5.2.1、§5.4.1：registers.md。
- 原文 §5、§7：algorithm.md 与 numeric.md。
- 原文 §6、§8、附录 A：architecture.md、registers.md 与 verification.md。
- 原文 §11～12、§13.2：verification.md。
- 原文 §14：open-issues.md 的 O-01～O-10；O-11 起为整理时补充。

本套文件是结构化整理，不是逐字转录。原始图示和外部参考保留在 Word 中，本次未独立验证其外部引用。

局部硬件进展：独立预处理核已完成 [QuestaSim 原始码/流控验证](experiments/EXP-007-preprocessing-rtl.md)，尚非完整系统 RTL。


Current implementation evidence: [EXP-022](experiments/EXP-022-internal-clocked-implementation.md) records the internal 30MHz placed/routed numerical prototype. [Board, clock and ingress evidence](board-bringup-evidence.md) separates documented candidate facts from unconfirmed board constraints and physical-buffer requirements. Board-level signoff and product bus/control remain open.
