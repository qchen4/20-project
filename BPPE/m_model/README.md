# BPPE MATLAB 浮点模型 M0

已实现可逐帧运行的实验基线 `M0-morphology-v1`。依赖基础 MATLAB，无 Signal Processing、Statistics、Fixed-Point Designer 工具箱要求。实际验证环境为 MATLAB R2026b。

当前用途：检验输入协议、因果预处理、心搏特征、质量门控、回归接口和结果保持。尚未使用真实数据标定，演示压力数值来自人为构造系数；`demo_only=true` 必须随结果保留。默认模型未配置，不会产生有效压力。

## 快速运行

在 MATLAB 中执行：

```matlab
% 从项目根目录运行；不依赖固定磁盘路径。
addpath(fullfile(pwd,'m_model'));
run_bppe_tests;
run = demo_bppe;
```

演示输出到 `m_model/artifacts/demo/`：`synthetic_demo.png` 波形图、`synthetic_results.csv` 结果、`synthetic_run.mat` 完整输入/配置/轨迹。测试输出到 `m_model/artifacts/tests/`。生成目录已被 Git 忽略，可随时重新生成。

## 统一工程验证

```matlab
addpath(fullfile(pwd,'m_model'));
report = validate_bppe;
```

统一运行单元测试、Code Analyzer 及六个固定噪声案例。工程门槛与强脉冲漏判分开报告；`known_quality_gap=true` 表示仍有已知质量问题，不能把退出码为零当成质量算法签核。默认输出在 `artifacts/validation/`。

测试与两类完整扫描会自动生成 `source_manifest.csv` 和 `run_metadata.json`，记录精确 MATLAB 源码哈希、环境及运行参数。默认产物留在本地。详见 [EXP-004](../docs/experiments/EXP-004-engineering-regressions.md)。

## 正常模式与演示模式

```matlab
cfg = bppe_default_config();       % 未配置的正常模式
frames = bppe_synthetic(cfg, 24);
run = bppe_run(frames, cfg);       % 有质量/特征，血压结果为无效

cfg = bppe_demo_config();         % 显式允许人为测试系数
run = bppe_run(bppe_synthetic(cfg, 24), cfg);
```

演示的 result_valid 仅表示软件门控通过，同时 `demo_only=true`，不能作为真实血压估算效果。默认模型输出 MODEL_UNCONFIGURED 和 NaN 压力；无效结果的 UQ9.7 字段为零，不能忽略 valid 读取。

## 输入与逐帧接口

每个 frame 包含：

- `frame_seq`：0～65535 整数模序号。
- `ppg`：活动通道数长度的向量，整数 0～2^24−1。
- `timestamp`：同长度向量，整数 0～2^32−1 的采集 tick。
- `channel_valid`、`channel_saturated`：同长度布尔向量。
- `gain_transition`：布尔标量。
- `gain_profile_id`、`optical_profile_id`：0～255 整数标量。

这里使用活动通道向量；与三槽 MMIO 暂存区的转换属于外部适配器。行/列向量均可。每次调用代表已在总线侧接受的一帧，out.accepted 进一步表示通过算法输入校验；不模拟总线 FIFO 和 AHB 周期。

```matlab
state = bppe_control(bppe_init(cfg), 'start');
[out, state, trace] = bppe_step_float(frames(1), state);
% 每个后续 frame 重复调用；out.published 表示快照新提交。
% 主机完成读取后调用：
state = bppe_control(state, 'ack');
```

`out.candidate` 是本次完成的测量候选；`out.snapshot` 是保留给主机的结果，两者在结果溢出时不同。`bppe_run` 默认自动 ACK；第三参数 false 可验证未读保护。原始故障既出现在本次 out.fault_flags，也累计在 state.fault_flags。

`bppe_control` 支持 start、abort、disable、ack、clear_faults、reset、configure。M0 的 reset 清运行状态但保留调用者给定的 cfg；如需恢复默认配置，用 bppe_init(bppe_default_config())。它不是硬件寄存器复位模型。

## 特征与标定入口

特征按固定顺序为：周期秒数、上升占比、正半波半高宽占比、正面积占比、AC/DC 比。每个结果取主通道最近四个完整周期的均值；其余通道分别参与质量门控。没有 PTT/PWV 或多通道时间差估算。

获得真实配对数据后，先用同一 cfg 提取合格窗口特征，并自行按受试者/会话划分训练、标定和独立测试集。不能把未配置模型的所有候选无条件当作合格特征。

```matlab
% Xtrain: N×5 合格特征；Ytrain: N×2 配对的 [SBP DBP]
provenance = struct('id','research-model-001', ...
    'data_kind','recorded','split_id','subject-separated-training-v1');
[model, training_report] = bppe_fit_model(Xtrain, Ytrain, cfg, provenance);
cfg.model = model;
```

fit 只负责标准化与岭回归，不负责自动寻找参考标签、时间配对或拆分数据。training_report 仅为训练残差；函数返回 calibrated 表示系数拟合就绪，不等于临床验证或产品签核。合成数据拟合会强制 demo_only=true。特征超出训练最小/最大包络时拒绝结果；该保守规则可在后续研究中评审调整。

更改采样率、滤波器、窗口或质量参数后，已配置模型的 extractor 签名不匹配会报错，需要重新提取特征和拟合。不要直接改签名绕过检查。

## 范围与后续

现已增加 MATLAB 显式整数定点模型，覆盖内部数据通路。尚未完成全输入范围证明、真实血压验证、完整 C++/RTL 或周期精确总线仿真。质量分数是实验性启发式，不能保证识别所有运动伪影。

完整公式、默认参数和生命周期见 [M0 算法细则](../docs/spec/algorithm-m0.md)。

## 定点运行与效果评估

```matlab
cfg = bppe_demo_config();
frames = bppe_synthetic(cfg, 24);
profile = bppe_fixed_profile('balanced');
fixed_run = bppe_run(frames, cfg, true, profile);
report = evaluate_bppe_fixed; % compact/balanced/wide，23 个合成场景
```

逐帧接口为 bppe_init_fixed / bppe_step_fixed，控制动作仍使用 bppe_control。定点 state 包含统计 handle；创建独立实验时重新 init，不通过拷贝 state 分叉运行。

默认 balanced 对本次 143 个匹配且双方有效的结果，SBP/DBP 最大新增误差约 0.002643/0.001332 mmHg，编码后最大差异均为 1 LSB；没有有效性差异。全量程跳变另有 5 次标准化饱和，输出无效并锁存数值故障直到 reset/configure。compact 在质量阈值附近出现误接受，不推荐。

定点模型使用 double 保存整数码，乘加和除法受精确整数范围保护；数据通路的量化、舍入、饱和均显式实现，不依赖 fi 工具箱。它不是将原有浮点压力结果简单转换为整数。

详细格式见 [定点规格](../docs/spec/numeric-m1-matlab.md)，完整结果与局限见 [EXP-002](../docs/experiments/EXP-002-fixed-point.md)。所有数字只描述当前合成数据/演示系数的定点新增误差，不代表真实血压准确性。

## 随机噪声与周报图表

```matlab
report = evaluate_bppe_noise; % 5 类干扰 × 5 档 SNR × 5 个种子
build_weekly_figures;         % 需先有 fixed / noise 实验结果
```

支持白噪声、相关噪声、基线漂移、周期干扰和脉冲干扰。SNR 按干净 AC RMS 与添加噪声 RMS 定义，记录种子、实现后的 SNR 和裁剪标记。统计报告机会覆盖率、有效输出的周期折算心率误差、漏检 / 多检及浮定点新增差异。

本轮 125 次仿真、41 项测试完成。新噪声集最大浮定点压力差异约 0.06146 mmHg（15 dB 白噪声），大于上述 EXP-002 的范围；不能把其 1 LSB 结论推广到任意噪声。强脉冲干扰还出现质量门控漏判。方法与完整限制见 [EXP-003](../docs/experiments/EXP-003-noise-robustness.md)，汇报用 本地生成的周报图片（`reports/` 不纳入源码版本）。

## 独立 C++ 数值对照

`bppe_export_integer_vectors` 导出标量整数运算和故障计数，供 [C++ checker](../c_model/README.md) 逐项核对。当前仅验证数值基础层，不等于完整 M1 或 RTL 已实现。

`bppe_export_preprocess_vectors` 进一步从既有私有整数核导出隔离的预处理状态及故障事件，用于 C++ 逐样本对照，见 [EXP-006](../docs/experiments/EXP-006-causal-preprocessing.md)。


## Channel RTL observations

Run bppe_export_pipeline_vectors(output_dir) to export accepted ADC-to-feature raw states and complete cycle buffers for the isolated RTL channel pipeline. This bypasses acquisition-frame validation. See [EXP-009](../docs/experiments/EXP-009-channel-pipeline.md).


## Window measurement observations

Run bppe_export_measurement_vectors(output_dir) for reproducible bounded-window SQI, model-gating and regression raw-code comparisons against C++. These are numerical fixtures, not clinical validation or full controller tests. See [EXP-010](../docs/experiments/EXP-010-window-measurement-reference.md).


## Integer observation deadlines and accepted-frame export

Runtime timeout decisions now compare elapsed ticks against an integer deadline, as owner-approved in [ADR-005](../docs/decisions/ADR-005-integer-window-deadlines.md). Audited host constants are rounded to nanoseconds then rounded up to ticks; initial warmup plus timeout is converted together. Seconds remain reporting fields. Reinitialize old saved runtime states. All 48 tests pass. bppe_export_prototype_vectors exports public fixed-step candidates, pending snapshots and global faults for the [accepted single-channel RTL comparison](../docs/experiments/EXP-012-accepted-single-channel-prototype.md).


## Offline strong-impulse diagnosis

`bppe_analyze_impulse(output_dir,'matrix')` reconstructs every pre-clear beat window and compares offline shadow SQI/shape rules across78 fixed synthetic runs. `'focus'` reproduces clean75bpm and impulse seed37 only. `bppe_probe_impulse_domains(output_dir)` reruns the observed outliers in floating and fixed models. These scripts generate CSV/MAT/PNG evidence and do not alter production gating, defaults, calibration or RTL. The >5bpm criterion is the existing synthetic period-error diagnostic, not a clinical BP threshold. See [EXP-028](../docs/experiments/EXP-028-impulse-root-cause-and-shadow-gates.md).


## Default-off fresh shape-screening experiment

`test_shadow_morphology()` checks the optional offline gate. Run
`bppe_validate_shadow_quality(new_output_dir,true)` to explicitly evaluate the
frozen shape-CV0.20 candidate on the EXP-029 matrix. Omitting `true` keeps that
alternative in exact pass-through mode; production remains unchanged in both
cases. The JSON protocol freezes seeds, waveforms and rules before evaluation.
The SQI200 alternative is a separate offline comparator. See
[EXP-029](../docs/experiments/EXP-029-fresh-shadow-validation.md) for the
phase-derived reference, results, coverage costs, reproducible outputs and
limits. This is not a new acceptance contract or clinical validation.


## Observed cycle-correspondence diagnosis

`bppe_probe_cycle_correspondence(exp029_output_dir,new_output_dir)` replays
the six observed EXP-029 outliers and six matched clean inputs with exact input
hash checks. It exports accepted cycles, every positive crossing, traces and
correctly separated floating/fixed candidates. Use
`python testcode/analyze_cycle_correspondence.py --output <out> --source-root <repo>`
for independent phase/crossing/period checks and diagnostic correspondence.
This is explanation of observed failures, not fresh validation or a gate.
See [EXP-030](../docs/experiments/EXP-030-cycle-correspondence.md).
