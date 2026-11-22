# BPPE C++ 整数参考模型

这是与当前 MATLAB/RTL 工程原型对应的独立 C++ 整数参考。现有标量算术、因果预处理、整周期心搏特征、窗口 SQI/回归、运行期帧校验，以及完整运行会话的测量触发、整数 deadline、pending 快照和错开的 ACK。它不是产品总线、物理采集或完整 START/ABORT 生命周期模型。

## 合同与边界

- 以 `int64_t` 保存原始整数码，但保留 MATLAB 的 `2^53−1` 精确整数保护，不因容器变宽而改变模型行为。
- 加法按操作数绝对值之和作保守保护，即使发生正负抵消也不放宽；乘法保护与 MATLAB 标量调用的参数顺序一致。
- 正负中点都远离零；除零返回零并累计故障，非法宽度或分数位参数抛出异常。
- 支持位宽 1～52、分数位 0～52。只接收整数，不处理 NaN/Inf、数组广播或主机侧浮点常量 `encode`。
- 不是周期模型；已实现运行会话的结果快照控制，但不定义硬件接口、并发事件优先级或物理流量。数值对照不能替代产品或板级签核。

生产头文件使用标准 C++17。性质测试的独立精确算术 oracle 使用 GCC/Clang 的 `__int128`；当前构建测试工具链要求支持该类型。本轮使用 WSL GCC 15.2.0、CMake 4.2.3、Ninja。

## 构建与独立性质测试

在项目根目录的 WSL shell 中运行：

```sh
cmake -S c_model -B c_model/build -G Ninja -DBPPE_SANITIZE=ON
cmake --build c_model/build
ctest --test-dir c_model/build --output-on-failure
```

编译启用严格警告并视为错误。`BPPE_SANITIZE=ON` 打开未定义行为检查，首个发现即失败。测试包含边界与小范围穷举、确定性随机输入、除法有理数距离性质和平方根整数边界性质；不以另一份相同实现当唯一 oracle。

## MATLAB 逐项对照

先在项目根目录的 MATLAB 中执行：

```matlab
addpath(fullfile(pwd,'m_model'));
bppe_export_integer_vectors;
```

再在项目根目录的 WSL shell 中执行：

```sh
cmake -S c_model -B c_model/build -G Ninja -DBPPE_SANITIZE=ON \
  -DBPPE_MATLAB_VECTORS="$PWD/m_model/artifacts/integer-vectors/integer_vectors.csv"
cmake --build c_model/build
ctest --test-dir c_model/build --output-on-failure
```

对照同时核对整数结果和三类故障计数，覆盖 19,783 个标量案例。C++ checker 另有故意错误结果和错误故障标志的负向测试。生成向量、MATLAB 参数/源码清单以及 CMake 的 `source_manifest.txt` 留在本地；后者绑定编译器、sanitizer 设置、C++ 源码和向量哈希。

本轮结果与限制见 [EXP-005](../docs/experiments/EXP-005-scalar-integer-reference.md)。原有尾随空格的空目录 `c_model ` 保留本地；本目录是标准路径 `c_model/`。

## 因果预处理状态

`causal_preprocessor.hpp` 增加已接受样本的 DC/低通和时间码计算，保留现有三组格式及中间截位位置。原始系数由 MATLAB 主机侧准备，不在此处重新推导。历史清理与数值故障清理分开，各通道通过同一算术实例累计故障。

先在 MATLAB 运行 `bppe_export_preprocess_vectors`，再在上面的 CMake 配置命令中增加：

```sh
-DBPPE_PREPROCESS_VECTORS="$PWD/m_model/artifacts/preprocess-vectors/preprocess_vectors.csv"
```

同时给出两组向量路径时，CTest 共 8 项检查。预处理向量覆盖 24 场景、9,924 条样本/通道记录，包含三通道状态、故障保持和恢复。它不包含输入帧检查、心搏或总线语义，详见 [EXP-006](../docs/experiments/EXP-006-causal-preprocessing.md)。


## Whole-cycle beat reference

The experimental beat_extractor.hpp preserves MATLAB crossing, whole-cycle feature and rolling-history behavior. Export bppe_export_beat_vectors, configure BPPE_BEAT_VECTORS to its CSV, and run CTest with BPPE_SANITIZE=ON. See [EXP-008](../docs/experiments/EXP-008-whole-cycle-beat-features.md) for scope and measured results.


## Bounded-window SQI and regression reference

The measurement.hpp integer evaluator preserves MATLAB channel SQI, primary feature means, model gates, regression, reason flags and invalid zero payloads. The caller supplies encoded configuration and existing arithmetic faults. Export bppe_export_measurement_vectors and set BPPE_MEASUREMENT_VECTORS in CMake. beat_extractor::clear_window clears completed-window beats and rejection counts while retaining the current cycle and numeric faults. See [EXP-010](../docs/experiments/EXP-010-window-measurement-reference.md).


## Matching numerical RTL

The 288 measurement-reference cases also match the isolated bounded-window/SQI/regression RTL; see [EXP-011](../docs/experiments/EXP-011-window-sqi-regression-rtl.md). Running-session timeout/publication integration was subsequently completed in EXP-027 below; the isolated comparison alone does not establish system behavior.

## Running-session frame reference and acquisition comparison

`frame_validator.hpp` implements the existing normalized complete-frame contract:
ordered rejection reasons, modular sequence/timestamp checks, signed channel skew,
configuration-error history retention, other-error history reset, sticky frame
faults and accepted channel tick values. Static tick bounds come from MATLAB's
`bppe_frame_tick_bounds`; C++ does not rederive floating configuration thresholds.
Malformed calls outside the typed RTL port domain throw before state mutation;
they are separate from valid wire transactions that report CONFIG_ERROR.

`bppe_check_frame_vectors` composes this validator with the existing independent
preprocessor/beat reference, using one arithmetic instance in channel order.
It checks raw intermediate histories, emitted features/times and fault counters.
The frame validator itself does not own numeric faults or the measurement window.
Its `reset()` clears frame runtime/faults while retaining constructor configuration;
the caller separately owns DSP history and arithmetic reset lifetimes.

Export `bppe_export_frame_vectors` in MATLAB, then add this CMake option:

```sh
-DBPPE_FRAME_VECTORS="$PWD/m_model/artifacts/frame-vectors/frame_vectors.mem"
```

With all five component MATLAB vector options, the EXP-026 baseline ran 31 tests,
including 19 expected negative checker tests. Frame negatives require both exit code 1 and the
specific expected diagnostic. With no external vector paths the local property,
fixture and rejection tests still run. See [EXP-026](../docs/experiments/EXP-026-cpp-acquisition-reference.md).

## Integrated running-session reference

`system_reference.hpp` owns frame, per-channel filter/beat, measurement window,
shared arithmetic faults, integer deadlines, visible 16-bit result sequence,
first-pending snapshot and sticky frame/numeric/overflow flags. `step(frame,tag)`
returns one atomic transaction result; `ack()` is a separate serialized action.
`reset()` restores configured initial arithmetic-fault seeds and a ready running
session. It does not implement MATLAB's stopped START/ABORT lifecycle or choose
simultaneous ACK/publication/reset priority. Configuration is immutable.

`bppe_check_system_vectors` compares every sample decision, acquisition/deadline
state, numerical counter, candidate and retained snapshot in the existing
151,200-frame MATLAB export. Add the sixth vector option after exporting
`bppe_export_system_vectors`:

```sh
-DBPPE_SYSTEM_VECTORS="$PWD/m_model/artifacts/system-vectors/system_vectors.mem"
```

With all six vector paths, the current CTest suite contains 53 tests: 15 positive
and 38 expected negative checks. The new system negatives also require the exact
expected rejection diagnostic and exit code 1. See [EXP-027](../docs/experiments/EXP-027-cpp-running-system-reference.md)
for results, supported metadata and the retained known impulse defect.
