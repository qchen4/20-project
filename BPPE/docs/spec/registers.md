# BPPE 寄存器与总线规格

版本：0.2-draft.1；状态：Draft；批准：未批准。来源：原文 §3～5、§8。以下偏移与位域保持原文提案，TBD 不表示零或无副作用。

## 总线合同

- **REG-001｜提案**：仅支持对齐 32 位访问，HSIZE=2、地址低两位为零。其他大小/未对齐访问返回 ERROR。基地址由 SoC 指定。合法地址相位按 HSEL、HTRANS[1] 和 HREADY 识别，并锁存地址/控制供对应数据相位使用。
- **REG-002｜候选要求**：等待时保持配对；副作用只在成功完成的有效写事务发生一次。ERROR 遵守 AHB-Lite 两周期响应。读等待、最大等待、支持的 burst 及非法地址/权限行为见 O-05/O-11，须补充波形。
- **REG-003｜提案**：保留位写零、读零。保留位非零写入是忽略还是报错、RO 写入及 WO 读取如何响应，待 O-11。HMASTLOCK 不改变 DSP 算法；HPROT 默认不实施额外访问策略。

## 地址清单

所有寄存器宽度 32 位、按字对齐。下列逐项复位读值除明确描述外均为 TBD；不能据名称补造位域。

### 控制区

- `0x000 IP_ID` RO：标识值 TBD。
- `0x004 IP_VERSION` RO：主/次版本编码 TBD。
- `0x008 CONTROL` RW：bit0 ENABLE；bit1 SOFT_RESET（自清）；bit2 START；bit3 ABORT；其余保留。START/ABORT 脉冲、自清和读回语义 TBD。
- `0x00C STATUS` RO：IDLE、BUSY、RESULT_PENDING、INPUT_FULL、ERROR 概要；位分配 TBD。
- `0x010 IRQ_ENABLE` RW：结果与故障原因使能；位分配及复位值 TBD。
- `0x014 IRQ_STATUS` W1C：粘滞中断原因；位分配 TBD。结果保留由 RESULT_ACK 控制。
- `0x018 MODE_CFG` RW：1/2/3 通道、算法选择；枚举编码与位域 TBD。
- `0x01C TICK_PERIOD_NS` RW：采集 tick 周期；粒度、有效范围和零值行为 TBD。
- `0x020 WINDOW_CFG` RW：心搏数或样本窗口策略；字段与合法组合 TBD。
- `0x024 SQI_THRESHOLD` RW：质量阈值；字段及判定边界 TBD。
- `0x028 NUM_CFG` RW：数值策略/系数 profile/舍入；实际可配置项 TBD。
- `0x02C MODEL_CFG` RW：估算 profile 和标定状态；字段 TBD，不能视作完整系数装载接口。

### 输入区

- `0x100 FRAME_META` RW：bits[2:0] channel_valid；[5:3] channel_saturation；[6] gain_transition；[14:7] gain_profile_id；[22:15] optical_profile_id；[31:23] 保留。
- `0x104 PPG0_DATA` RW：bits[23:0] 样本 0；[31:24] 保留。
- `0x108 PPG0_TS` RW：bits[31:0] 通道 0 采集 tick。
- `0x10C PPG1_DATA` RW：bits[23:0] 样本 1；[31:24] 保留。
- `0x110 PPG1_TS` RW：bits[31:0] 通道 1 采集 tick。
- `0x114 PPG2_DATA` RW：bits[23:0] 样本 2；[31:24] 保留。
- `0x118 PPG2_TS` RW：bits[31:0] 通道 2 采集 tick。
- `0x11C FRAME_SEQ` RW：bits[15:0] 主机模序号；[31:16] 保留。
- `0x120 FRAME_PUSH` WO：写 bit0=1 请求原子提交；其他位保留。写零及读取语义 TBD。
- `0x124 FIFO_LEVEL` RO：占用量/可用容量；位域和饱和表示 TBD。

### 结果区

- `0x200 RESULT_STATUS` RO：bit0 RESULT_PENDING；bit1 RESULT_VALID；bit2 RESULT_OVERFLOW；bits[15:8] config_epoch。其余位保留。bit2 是实时粘滞状态还是快照字段仍有冲突，见 O-09。
- `0x204 RESULT_SEQ` RO：结果序号；逻辑结果结构宽度 16，放置在低 16 位及高位读零是本次提案，待确认。
- `0x208 BP_VALUE` RO：bits[15:0] SBP，bits[31:16] DBP，均暂定 (0,16,7)，单位 mmHg。
- `0x20C RESULT_QUALITY` RO：bits[7:0] SQI；[23:8] reason_flags；[31:24] 保留。
- `0x210 RESULT_TS` RO：最近一个参与估算的采样 tick；跨通道模时间排序规则待 O-03。
- `0x214 RESULT_ACK` WO：写 bit0=1 释放快照；其他位保留。写零、无 pending 时写入及读取语义 TBD。

## 提交与结果

- **REG-004｜候选要求**：成功的 FRAME_PUSH 原子复制暂存字段入 FIFO。FIFO 满时原文提案为返回 ERROR 并记录输入溢出，不得部分入队；有界等待是未采纳备选。PUSH 与 pop 同周期能否接受待 O-11。
- **REG-005｜候选要求**：pending 期间压力、质量、时间戳、序号、epoch 和有效位保持同一快照；读取不确认。主机必须读取状态并用 valid 判定压力是否可用。
- **REG-006｜原文提案**：出现第二个结果时保留首个结果并报告 RESULT_OVERFLOW，后续结果不可静默替换首个。错误记录的位置、结果序号推进方式及 pending 期间是否继续计算待 O-09/O-11。
- **REG-007｜候选要求**：IRQ_STATUS W1C 与 RESULT_ACK 是不同动作，必须明确各自对 pending、irq、粘滞原因和结果有效位的影响。原文 smoke 要求 ACK 后 IRQ 清除，但持久化原因是否需额外 W1C 尚待 O-09 决定。
- **REG-008｜候选要求**：BUSY 时影响计算的配置更新必须统一拒绝或延迟激活；不得实现依赖。系数装载、epoch 递增/回绕及完整性校验待 O-08。
- **REG-009｜候选要求**：非法访问不得意外修改目标数据或处理状态；是否允许同时记录 BUS_ACCESS_ERROR 必须写明作为例外，见 O-11。无效帧、未写齐暂存字段及未使能时 PUSH 的行为待 O-11。

## 原因位提案

reason_flags[15:0]：0 LOW_SQI；1 SAMPLE_GAP；2 ADC_SATURATED；3 TIMESTAMP_ERROR；4 INSUFFICIENT_BEATS；5 MODEL_UNCONFIGURED；6 NUMERIC_FAULT；7 DIVZERO；8 INPUT_OVERFLOW；9 RESULT_OVERFLOW；10 CONFIG_ERROR；11 ABORTED；12 BUS_ACCESS_ERROR；[15:13] 保留。

原因位不自动等于 IRQ_STATUS 位。没有结果快照时，输入、总线和控制故障如何保存与读取尚未定义；不得为塞入错误而修改未读快照。

## 软件流程提案

复位 → 配置模式、tick、窗口和模型 → ENABLE/START → 按模式写元数据、样本、时间戳、序号 → PUSH → 检查接受结果 → 等待 pending/irq → 读取完整快照 → 检查 valid → ACK → 按批准规则清中断 → 下一测量或禁用。

该流程是评审依据，尚不能作为驱动实现合同；必须先关闭相关 O-05/O-08/O-09/O-11。
