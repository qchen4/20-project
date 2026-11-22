# BPPE

**Blood Pressure Processing Element**：面向 MCU SoC 的 PPG 血压估算硬件 IP 工程原型。

项目先用合成 PPG 建立 MATLAB → C++ → RTL 的数值与事务验证链路，再评估 FPGA 资源和实现可行性。当前已实现多通道数值原型，尚未完成可上板、可集成的完整硬件 IP。真实产品替代与真实血压准确性另行验收，范围见 [ADR-003](docs/decisions/ADR-003-fpga-engineering-prototype.md)。

[当前状态](#当前状态) · [架构与边界](#架构与边界) · [快速开始](#快速开始) · [分层复现与验证](#分层复现与验证) · [已知限制与下一步](#已知限制与下一步) · [文件导航](#文件导航)

## 当前状态

以下汇总截至 **2026-11-06 已记录的实验基线**；数字仅适用于对应工具、配置、数据和源码版本。

| 层次 | 已有能力与验证证据 | 尚未代表 |
| --- | --- | --- |
| MATLAB | 因果浮点模型、compact / balanced / wide 显式整数定点模型；[EXP-016](docs/experiments/EXP-016-multichannel-numerical-system.md) 记录完整测试集 51 项通过 | 真实血压准确性、周期精确总线模型 |
| C++17 | 独立整数、预处理、整周期心搏特征、窗口 / SQI / 回归参考；四组 MATLAB 向量齐备时共 15 项 UBSan CTest，见 [C++ 说明](c_model/README.md) | 完整逐帧控制模型 M1 |
| RTL | 1～3 通道原始帧到结果保持的数值链路；151,200 帧、303 个候选与公共 MATLAB 定点模型对照通过，7 项正向仿真及 1 项预期 ACK 冲突拒绝，见 [EXP-016](docs/experiments/EXP-016-multichannel-numerical-system.md) | 物理采集、主机桥接、完整产品接口 |
| FPGA | balanced 完整数值顶层已做 Vivado OOC（上下文外）综合；[EXP-017](docs/experiments/EXP-017-full-top-ooc-capacity.md) 记录 **328,859 LUT / 134,600 可用（244.32%）**，无法装入目标器件 | 布局布线、板级时序、目标采样率或功耗签核 |

EXP-017 的目标为 `xc7a200tfbg484-2`（AX7A200 基线）。10 ns 仅在综合后用于探索性分析，WNS 为 **−427.170 ns**；未完成板级约束或布局布线。局部预处理核的优化结果不能替代完整顶层容量和时序结论。

## 架构与边界

当前实验算法是 `M0-morphology-v1`：以完整 PPG 周期提取形态特征，经质量门控后作标准化线性回归。其他通道参与质量检查；没有实现 PTT / PWV 或跨通道传播时间估算。算法定义见 [M0 细则](docs/spec/algorithm-m0.md)，定点截位与格式见 [数值细则](docs/spec/numeric-m1-matlab.md)。

```text
规范化 PPG 帧（1～3 通道，24 位样本 + 32 位采集 tick + 元数据）
  → 帧校验与有序通道调度
  → 各通道独立：DC / 低通预处理 → 完整周期缓存与 5 项特征
  → 多通道滚动心搏窗口 → 共享 SQI / 模型门控 / 回归
  → 测量候选 → 首个 pending 结果快照 → 串行主机 ACK
```

当前数值顶层为 [bppe_multichannel_prototype.sv](rtl/bppe_multichannel_prototype.sv)，使用内部 valid/ready 握手，配置在一次运行中保持静态。它实现的是复位后运行会话；产品 START / ENABLE / ABORT、配置装载、CSR、IRQ / W1C 尚未完整实现或冻结。32 位 AHB-Lite 从接口是[系统草案](docs/spec/system.md)中的提案，当前没有 AHB 或 AXI 总线实现。

原型在 pending 期间继续计算，保留首个快照，后续候选记录 `RESULT_OVERFLOW`。ACK 与发布必须串行，碰撞由仿真报错；这不是已批准的产品并发优先级，见 [ADR-004](docs/decisions/ADR-004-prototype-pending-result.md)。

## 快速开始

从仓库根目录运行。建议先执行 MATLAB 工程回归，再按需要进入 C++ 或 RTL 对照。

| 工作流 | 所需环境 |
| --- | --- |
| MATLAB 模型与测试 | 基础 MATLAB；已有记录使用 R2026b，无额外工具箱要求 |
| C++ 参考 | WSL / Linux、CMake ≥ 3.16、Ninja、支持 C++17 与 `__int128` 的 GCC / Clang；已有记录使用 GCC 15.2.0、CMake 4.2.3 |
| RTL 仿真 | Windows PowerShell、QuestaSim；已有记录使用 10.6c win64 |
| FPGA OOC 综合 | Windows PowerShell、Vivado；已有记录使用 2026.1 |

在 MATLAB 中执行：

```matlab
addpath(fullfile(pwd,'m_model'));
report = validate_bppe;
```

该入口运行单元测试、Code Analyzer 和固定回归案例，默认产物位于 `m_model/artifacts/validation/`。成功时输出测试汇总；**`known_quality_gap=true` 仍表示强脉冲误接受缺口存在**，工程回归通过不等于质量算法验收。

需要查看合成演示时：

```matlab
run = demo_bppe;
```

演示图、结果 CSV 和运行状态保存到 `m_model/artifacts/demo/`。默认配置的模型未配置，不产生有效血压；演示显式启用人为系数，结果带 `demo_only=true`。`result_valid` 只表示工程门控通过，不能解释为临床有效性或血压准确性证据。配置和逐帧 API 见 [MATLAB 说明](m_model/README.md)。

## 分层复现与验证

### C++ 独立性质与负向测试

在仓库根目录的 WSL / Linux shell 中执行：

```sh
cmake -S c_model -B c_model/build -G Ninja -DBPPE_SANITIZE=ON
cmake --build c_model/build
ctest --test-dir c_model/build --output-on-failure
```

干净构建不需要 MATLAB 向量，注册 11 项性质、夹具和负向检查；负向检查通过表示错误数据被正确拒绝。加入 MATLAB 标量、预处理、心搏和测量四组导出向量后，共 15 项。导出函数、CMake 路径参数和原始整数码 / 故障计数对照方法见 [C++ 复现说明](c_model/README.md)。

### 多通道 RTL 数值系统对照

先在仓库根目录的 MATLAB 中生成公共定点模型向量：

```matlab
addpath(fullfile(pwd,'m_model'));
bppe_export_system_vectors;
```

再在仓库根目录的 Windows PowerShell 中执行；把 `$QuestaBin` 设为实际包含 `vsim.exe`、`vlog.exe`、`vlib.exe` 的安装目录：

```powershell
$QuestaBin = Read-Host 'QuestaSim win64 目录'
.\toolchain\run_system_questa.ps1 -QuestaBin $QuestaBin
```

默认读取 `m_model/artifacts/system-vectors/system_vectors.mem`，向量约 154 MB；运行器在 `build/questa-system/` 下创建独立运行目录并保留哈希清单和日志。整套通过标记为 `QUESTA_SYSTEM_SUITE_PASSED`；其中 ACK 碰撞用例必须命中指定错误，不能将任意仿真失败当成预期拒绝。支持 `-Vectors`、`-BuildRoot` 指定独立路径。其他分块入口见 [RTL 说明](rtl/README.md)，覆盖与局限以 [EXP-016](docs/experiments/EXP-016-multichannel-numerical-system.md) 为准。

### FPGA 资源与时序探索

在 Windows PowerShell 中执行；`$VivadoBat` 为实际 `vivado.bat` 路径：

```powershell
$VivadoBat = Read-Host 'vivado.bat 路径'
.\toolchain\run_system_vivado.ps1 -VivadoBat $VivadoBat `
  -Part xc7a200tfbg484-2 -AnalysisClockNs 10
```

默认产物位于 `build/vivado-system/` 的独立运行目录。以 EXP-017 源码基线运行时，Vivado 分析完成后**应因容量超限而失败**；检查 `resource_timing_summary.json`、`utilization.rpt`、`utilization_hierarchical.rpt`、`timing_synthesis_estimate.rpt` 和 `critical_paths.rpt`。较新 RTL 必须重新综合，不能沿用旧资源数字；容量门槛通过也不等于板级时序通过。流程和分析假设见 [EXP-017](docs/experiments/EXP-017-full-top-ooc-capacity.md)。

生成向量、构建目录和工具日志留在本地，不作为源码提交。实验记录绑定源码、向量、参数和工具版本；复现时应保留相应清单，避免混用不同基线的结果。

## 已知限制与下一步

- **信号质量**：强脉冲干扰仍可能产生错误但被接受的周期；整数码一致不代表鲁棒性改善。见 [EXP-003](docs/experiments/EXP-003-noise-robustness.md)。
- **真实血压**：尚无真实配对数据、独立受试者 / 会话划分及批准的评价协议；合成演示压力和定点新增误差不能证明真实血压效果。
- **硬件实现**：已记录的完整顶层容量失败需先通过算术共享、跨周期调度与存储架构优化解决，并保持原始码和故障行为回归；再做同器件综合、布局布线及上板验证。
- **采集与接口**：下游完成反压可阻塞新帧，当前握手不能解决持续物理 ADC 的缓冲 / 溢出问题。主机连接、板卡时钟 / 复位 / 引脚约束、产品总线及控制语义仍需确认。
- **验证范围**：现有场景对照不等于全输入范围证明或覆盖率签核；需继续扩展时序、边界与随机验证。完整 UVM 环境尚未建立。

系统规格仍为 **Draft**。实验范围内已接受的行为不自动冻结产品接口或性能指标。待决项见 [open-issues.md](docs/open-issues.md)，阶段推进见 [prototype-plan.md](docs/prototype-plan.md)。

## 文件导航

| 路径 | 用途 |
| --- | --- |
| [m_model/](m_model/README.md) | MATLAB 浮点 / 定点模型、合成输入、测试与向量导出 |
| [c_model/](c_model/README.md) | 独立 C++17 数值参考、性质与向量检查；使用无尾空格的标准路径 |
| [rtl/](rtl/README.md) | 分块数值核、采集封装及单 / 多通道原型 |
| [testcode/](testcode/) | SystemVerilog 原始码对照、握手与异常测试 |
| [toolchain/](toolchain/) | Questa / Vivado 运行器、OOC 审计、向量转换 |
| [docs/](docs/README.md) | [系统](docs/spec/system.md)、[算法](docs/spec/algorithm.md)、[数值](docs/spec/numeric.md)、[架构](docs/spec/architecture.md)、[寄存器](docs/spec/registers.md)、[验证](docs/spec/verification.md)草案 |
| [docs/decisions/](docs/decisions/README.md) | 设计决策及其适用范围 |
| [docs/experiments/](docs/experiments/README.md) | 分阶段方法、执行证据、结果和局限 |
| `uvm/` | 本地预留空目录，尚无可运行的 UVM 环境 |
