# BPPE M0 浮点实验基线

版本：M0-morphology-v1；状态：Experimental；日期：2026-10-22。

用户授权在顶层约束内自由调整内部实现，并指定先使用合成数据。本文件记录实际运行的内部选择；不将实验参数升级为已批准的系统预算或医学模型。对应 [决策 ADR-001](../decisions/ADR-001-m0-baseline.md)。

## 输入与时序

输入契约沿用 ALG-002：1～3 通道、24 位规范化无符号采样、32 位采集 tick、16 位帧序号及元数据。实验默认 100 Hz、1 ms/tick、通道 1 为主通道。默认值均可配置。

序号必须满足模 65536 的差值为 1；每通道 tick 差必须非零且小于 2^31，采样间隔相对 1/fs 的误差不得超过 25%。跨通道有符号模差不得超过 2 ms，配置上限必须小于一个采样周期。

缺样、坏时间、非法输入、饱和、增益/光路变化会拒绝该帧并清除部分观测、滤波和心搏状态，下一合法帧重新锚定并预热。错误保存在独立故障状态中；已有未读结果保持不变。不为每个输入故障额外生成一个测量快照。

## 因果预处理

各通道独立保存 dc 和 y。首个样本令 dc=x、y=0。每个后续样本按顺序执行：

```text
a = 1 - exp(-2*pi*0.5/fs)
b = 1 - exp(-2*pi*8/fs)
dc[n] = dc[n-1] + a * (x[n] - dc[n-1])
ac[n] = x[n] - dc[n]
y[n]  = y[n-1] + b * (ac[n] - y[n-1])
```

0.5 Hz 与 8 Hz 是实验系数参数，可通过 cfg 改变；不声称上述组合严格达到指定频率处的理想响应。前 2 秒只更新滤波状态，不采纳心搏。滤波系数按名义采样率计算，不为每个允许范围内的时间抖动重新计算。

## 完整周期与特征

检测 y 从非正到正的上升过零，用前后两个已获得样本线性插值过零时刻，因此不读取未来帧。相邻上升过零之间定义一个完整周期；峰值定位为该周期采样最大值位置。周期必须在 0.35～1.5 秒，正峰值和 dc 必须大于零。

在边界添加 y=0，令周期起止为 t0、t1，P=t1−t0，正峰值为 A，峰值时刻为 tp：

1. period_s = P。
2. rise_fraction = (tp−t0)/P。
3. positive_width_fraction = trapz(t, y>=A/2)/P；这是布尔采样积分近似，不是精确半高交点插值。
4. positive_area_fraction = trapz(t, max(y,0))/(A*P)。
5. ac_dc_ratio = (max(y)−min(y))/dc；使用周期结束帧更新后的 dc。

每个通道保留至多四个特征向量（可配置）。周期波形存储超过 max_period 或样本上限就丢弃该周期并累计 rejected_beats。主通道的最近四周期均值作为回归输入；其他通道不提供传播时间或回归特征。

## 质量与观测窗口

各通道必须积累四个完整周期，且每个周期的 ac_dc_ratio 在 [0.002,0.20]。周期 CV=总体标准差/均值；规则性分数 max(0,1−CV/0.20)。

```text
clean_fraction = beats_per_result / (beats_per_result + rejected_beats)
SQI_channel = round(255 * amplitude_ok * regularity * clean_fraction)
SQI = min(SQI_channel)
```

默认 SQI>=150 才通过。该分数只是确定性启发式，未校准且没有临床置信度含义。不能保证拒绝周期性运动干扰。

所有通道足够周期时尝试发布；预热结束后等待满 10 秒仍不足，也发布无效测量，并报告 INSUFFICIENT_BEATS/LOW_SQI。一次测量完成后清特征集合及拒绝计数，保留滤波器与当前周期，继续采集；每通道至多保留四个最近完整周期。

window_start_s/window_end_s 表示本次结果收集阶段的本地时间范围，不表示滤波器只依赖范围内样本。断流恢复后本地时间重新从零开始；配对结果应使用 result_seq、config_epoch 和采集 tick，不能仅按本地时间排序。跨通道不执行逐搏匹配，某路丢搏后可能采用不同周期集合；当前 profile 用其他通道作质量检查，不把这些周期解释为同步传播特征。

## 回归与输出

标准化线性回归：z=(features−center)./scale；[SBP DBP]=[1 z]*beta，beta 为 6×2。拟合使用增广最小二乘形式的岭回归，截距不惩罚，默认 lambda=0.001。训练特征的 min/max 作为推理包络；训练残差独立标记为 training_only。

默认模型未配置。测试配置使用人为系数并标记 demo_only，只有显式 allow_demo_model 才允许其工程 valid 为真。没有真实参考血压标签，演示不计算或宣称血压准确率。

有效输出要求：所有通道质量通过、模型已配置且拟合就绪、demo 策略允许、特征落在包络、计算有限、SBP>DBP。实验输出范围为 SBP [40,260]、DBP [20,180] mmHg，仅用于实现门控测试，不代表临床适用范围。超范围和超包络暂用 CONFIG_ERROR，非有限算术用 NUMERIC_FAULT；未来需评审是否新增专用原因位。

无效压力为 NaN，编码载荷为 0。有效输出按 round(BP*128) 写入 UQ9.7；这只是最终编码，不是内部定点模型。结果携带 demo_only、模型 ID、特征和通道 SQI 作为 M0 调试扩展，不改变硬件寄存器布局。

## 生命周期与结果保持

- init：禁用、无 pending、故障清零；配置冻结在 state.cfg。
- start：从空闲开始连续采集，清部分处理状态，保留已有快照。
- BUSY 配置变更：拒绝，记录 CONFIG_ERROR；configure 仅允许空闲且无 pending。
- ACK：释放 pending，保留旧载荷供调试；不清独立故障。
- clear_faults：清独立故障，不释放 pending。
- abort/disable：停止采集、清部分处理状态，记录 ABORTED，保留已有快照。
- reset：清运行状态，保留调用者配置。硬件 CSR 复位不在 M0 范围。
- pending 时继续计算，后续结果丢弃并记录独立 RESULT_OVERFLOW，首个快照不变。result_seq 按完成的候选结果递增并模 65536，丢弃会造成已发布序号不连续。

result_ts 取发布候选时最近的活动通道采集 tick，使用相对首通道的有符号模偏移排序。M0 无周期精确 IRQ、AHB、FIFO 模型；调用顺序定义控制与帧事件的先后，不冻结 RTL 同周期优先级。

## 验证与限制

测试与命令见 [MATLAB 模型说明](../../m_model/README.md)，M0 初始执行证据见 [EXP-001](../experiments/EXP-001-m0-synthetic.md)。后续已增加 [MATLAB 内部定点模型及评估](../experiments/EXP-002-fixed-point.md)，真实数据评价、C++ M1 和 RTL 仍未实现。


## Experimental timing revision, 2026-11-06

Owner-approved ADR-005 replaces timeout subtraction in floating seconds with integer elapsed/deadline ticks. Audited warmup/timeout constants are quantized once to integer nanoseconds, then rounded up to ticks; the initial deadline converts their combined duration once. A completed window starts the next deadline at its actual elapsed tick plus timeout_ticks. Reported window_start_s/window_end_s remain seconds. The owner also confirmed continued calculation while pending and serialized prototype ACK/publication (ADR-004); product event priorities remain draft.
