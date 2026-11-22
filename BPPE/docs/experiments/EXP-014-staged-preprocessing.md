# EXP-014: Numerically equivalent staged preprocessing

Baseline: main b3b5a5e16dbde0dafed39f13c5d6c9e87daf672d, EXP-013.
This experiment changes only preprocessing scheduling and arithmetic widths;
golden raw integer codes, profiles and algorithm parameters are unchanged.

## Bottleneck and implementation

The baseline worst path ran from dc_state_reg[0] to saturation_count_reg[63],
with 45.176ns data delay and 141 logic levels. Both recursive filters, wide
magnitude/rounding/clipping and fault accumulation occupied one cycle.

The replacement sequences delta, shared multiply, rounding, state update, AC,
second-filter delta/multiply/round/update, and atomic commit. Signal sums and
differences use W+1 bits; the shared product uses W+coefficient_F bits. For all
three audited profiles, abs(product)<2^53. Nearest rounding with ties away is
implemented by an arithmetic shift of product+half (nonnegative) or
product+half-1 (negative), avoiding serial magnitude/negation chains. Six
possible saturation events accumulate locally before one 64-bit counter add.

An accepted input commits its held output ten rising edges later. Without
stalls the initiation interval is eleven cycles, versus one for the baseline.
This trades throughput for area and shorter combinational paths; it is an
engineering prototype choice, not a frozen acquisition-rate requirement.
ADC, tick and both coefficients are captured on acceptance. Output data,
history and faults commit together; stalled output stays stable. Reset aborts
in-flight work. History clear still requires idle/empty and retains faults.

## Verification

QuestaSim 10.6c, all compact/balanced/wide profiles:

| Suite | Compared data | Simulations |
| --- | --- | ---: |
| Preprocessing | 9,924 unchanged MATLAB raw-code records / 24 profile-cases | 6 |
| ADC-to-feature channel | 19,524 frames / 30 profile-cases / 162 beats | 6 |
| Accepted single-channel prototype | 52,800 frames / 21 profile-cases / 126 candidates | 6 |

All 18 simulations passed with zero errors/warnings. Tests now wait on
ready/valid rather than assume immediate arithmetic completion; expected
values were not changed. Flow tests cover coefficient/input changes after
acceptance, held output, simultaneous consume/accept, fault attribution,
history clear and reset during active arithmetic. Maximum observed integrated
latencies were 253/270/270 cycles, ten more than baseline, not worst-case bounds.
Pending/overflow and the known strong-impulse quality gap remain unchanged.

Reproduce using run_preprocess_questa.ps1, run_channel_questa.ps1 and
run_prototype_questa.ps1 with the existing MATLAB-generated vector files.
Each run records source/script/vector hashes and simulator version locally.

## Same-condition synthesis comparison

Vivado 2026.1 build 6511674, balanced default profile, xc7a200tfbg484-2,
same run_preprocess_vivado.ps1 / synth_preprocess_ooc.tcl as EXP-013:

| Metric | Baseline | Staged |
| --- | ---: | ---: |
| LUT | 990 | 489 |
| Flip-flop | 239 | 541 |
| DSP48E1 | 8 | 2 |
| Latch / Block RAM | 0 / 0 | 0 / 0 |
| Setup WNS, ns | -35.150 | +4.840 |
| Setup TNS, ns | -3629.452 | 0.000 |
| Failing endpoints | 132 | 0 |

Optimized worst reported path: base_dc_reg[0] to multiplied/B[0], 4.712ns
data delay, 12 logic levels. Synthesis completed with no errors or critical
warnings. The missing OOC HD.CLK_SRC warning remains.

Synthesis was unconstrained; a 10ns clock was added AFTER synthesis for
exploratory timing estimation. This is not timing-driven implementation or
proof of a 100MHz board clock. I/O delays/pins, clock placement, placement and
routing remain absent; no timing signoff, full-IP resource result, or board
validation is claimed. Other wide arithmetic remains unoptimized.

## Acquisition front-end preparation

bppe_frame_tick_bounds is a host-only encoder of the existing MATLAB jitter
and signed modular-skew predicates. Binary searches evaluate the same floating
expressions and tolerance at exact integer boundaries. Defaults encode delta
8..12 and abs(skew)<=2 ticks; 0.5ms ticks encode 15..25 and <=4. Invalid or
empty audited domains are rejected. Public bppe_step_float frame acceptance
is not changed. Dedicated tests compare boundary neighborhoods across 144
configurations, modular half-range limits and unsupported-domain rejection.
The complete MATLAB suite passes 51 tests (zero failed/incomplete); Code
Analyzer reports no findings for the new helper and its tests. An initial
zero-jitter half-range fixture assumed exact real arithmetic and failed; the
corrected test explicitly preserves the public floating-expression rejection.

This prepares configuration inputs for an ordered one-to-three-channel frame
validator/dispatcher; that RTL and its integration are not implemented by this
experiment. Rejection precedence, history reset versus config-error retention,
and ordered rejection events must match the public model. Product bus/IRQ/W1C
and ACK/publication priority remain deferred.
