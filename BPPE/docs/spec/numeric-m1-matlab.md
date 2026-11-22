# BPPE MATLAB 整数定点基线

版本：M1-MATLAB-v1；状态：Experimental；日期：2026-10-22。

实现对应 M0-morphology-v1，保留输入帧、质量、模型配置、输出快照和 ACK 约束。它是用于定点探索的 MATLAB 整数参考，不是已签核的 C++ M1 或 RTL。

## 表示与算术合同

基础 MATLAB 中的 double 数组用作整数码容器，所有数据通路变量存储 q，解释为 q×2^-F。此用法不依赖 fi。乘法、加法的保守操作数界限保证绝对值不超过 2^53−1，因而整数精确可表示；越界时记录 precision_fault 并使测量无效，绝不把失去整数精度的结果继续作为有效输出。

每次缩位/除法采用最近舍入，中点远离零。除法通过整数商与余数修正及比较实现；平方根通过整数二分搜索和整数余量判断舍入。目标格式越界时饱和并锁存 NUMERIC_FAULT。除零同时设置 DIVZERO。数值故障锁存到 reset/configure；ACK 或 clear_faults 不清除算术内核的故障状态。

滤波系数的 exp、配置阈值换算和系数装载属于主机侧常量准备。输入时间戳和序号使用精确整数。double 秒数、解码后的特征/压力仅用于轨迹和报告，不回流到定点 DSP。控制层仍是事务级软件，不提供硬件周期模型。

## 默认平衡配置

格式按 (S,W,F)；所有数值定义和可选 profile 的可执行来源为 `m_model/bppe_fixed_profile.m`。

- 输入 ADC：(0,24,0)，转换到信号二进制小数位时精确左移。
- DC、滤波状态、差分和幅度：(1,34,8)。物理范围约 ±2^25 ADC code。
- 两个滤波系数：(0,18,18)，范围 [0,1)。
- 周期/插值时间：(1,48,8)，单位为采集 tick；默认 1 ms/tick 时子 tick 分辨率为 3.90625 µs。
- 周期秒数、形态特征、特征均值、中心和尺度：(1,20,16)，范围 [-8,8)。
- 标准化特征 z：(1,22,16)，范围 [-32,32)。
- 回归系数 beta：(1,26,16)，范围 [-512,512)。
- 回归累加器：(1,36,16)。
- 最终压力：(0,16,7)，保持顶层输出格式。

compact 对应信号 F=0、系数 F=8、特征/回归 F=8、时间 F=0。wide 对应信号 F=10、系数 F=18、特征/回归 F=18、时间 F=10；宽度按代码中的整数保护位规则增加。wide 没有增加滤波系数精度，因此高输入幅度下的滤波误差不一定比 balanced 小。

当前额外实施限制：tick_period_ns 是不大于 10^9 的正整数；每结果心搏数至多 64；只接受三组已定义 profile。此限制是实验模型适用范围，不新增系统层承诺。

## 逐级运算

1. DC 差分先饱和到信号格式；乘以已量化系数，完整整数乘积右移系数小数位并舍入，再更新并饱和 DC 状态。
2. AC 与低通差分分别落到信号格式；乘法、移位、状态更新顺序与 DC 相同。
3. 过零时间通过 `(-previous_y * delta_time)/(y-previous_y)` 的整数除法获得子 tick 偏移，再加入上一帧时间。
4. 周期使用原始 tick 及整数纳秒参数转换为秒的定点码；上升比、半高宽和 AC/DC 使用整数比值。
5. 正面积先把每个正样本除以正峰值、量化到特征格式，再对归一化样本积分；梯形求和采用完整整数积与和，最后除以 2×周期。这是明确的中间量化点。
6. 四周期均值逐特征整数求和后除以 N；周期方差基于量化均值计算，总体方差除以 N 后进行整数平方根，再计算 CV。
7. 质量阈值量化到特征格式。regularity 与 clean_fraction 采用特征格式；相乘并乘以 255 后舍入到整数 SQI。
8. 标准化按 `(feature-center)*2^Freg/scale`，落到 z 格式；逐项乘 beta，将每项乘积从 2Freg 舍入到 Freg，再按固定特征顺序累加并饱和。
9. 压力门控之后产生 UQ9.7 编码。无效结果的压力为 NaN、载荷码为零，与浮点接口一致。

完整乘积/求和不隐式裁切到操作数宽度。MATLAB 内核的精确整数界限有单独保护；它不是某个最终硬件乘法器或除法器的面积/周期实现。后续 RTL 必须按实际范围及上述中间截位位置配置内部宽度。

## 状态与数值故障

参数、系数或运算结果饱和会锁存数值故障，后续测量即使压力数值看似合理也不能标为有效，直到 reset/configure。输入断流、增益变化等仍按 M0 清部分观测，不会擦除数值故障。

当前会对已有完整特征的低质量窗口计算回归调试路径；全量程跳变可使 z 超出 ±32，触发数值故障。浮点同一输入也无效，但原因位没有定点的 NUMERIC_FAULT。此差异在报告中单独计数。是否把模型运算放在 SQI 门控之后属于未来算法/架构变更，当前不通过修改浮点参考掩盖差异。

每个 fixed state 包含独立的算术统计 handle；拷贝 state 不能用于分叉两个独立实验，应重新调用 bppe_init_fixed。运行中的原始状态码是整数，trace 中的波形为解码显示值。

## 对照与验收

评估对同一输入运行浮点及三组定点模型。按“前一个候选结果的输入帧索引、本候选结果的输入帧索引”严格匹配观测区间；不做时间偏移拟合或宽松最近邻匹配。未匹配窗口、有效性差异、原因位差异、心搏发生帧差异和接受差异分别报告。

SBP/DBP 新增误差只统计已匹配且双方有效的窗口，同时报告全部结果计数及有效率。编码后差异另以 UQ9.7 LSB 计。样本级滤波误差包含双方存在有限轨迹的帧，包括预热；不把故障帧 NaN 当零。

实验使用合成数据和人为压力系数，没有参考血压标签。报告只证明该实现的量化影响和边界行为，不能据此冻结真实算法精度预算或宣称临床准确性。结果见 [EXP-002](../experiments/EXP-002-fixed-point.md)。


## Observation control timing revision

ADR-005 and EXP-012 introduce integer tick window deadlines in the shared MATLAB control path. This changes the observed exact timeout boundary, not feature-kernel arithmetic. Host constant conversion is audited when tick nanoseconds and rounded duration nanoseconds are exact bounded integers; the hardware exporter rejects configurations outside that domain. Runtime states saved before this change must be reinitialized. The general M0 host fallback is not a verified hardware timing profile.
