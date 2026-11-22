`timescale 1ns/1ps
`default_nettype none
// Internal placement/routing harness, not an AX7A200 board top.
// A real BUFG is inside this OOC module so internal clock routing is evaluated.
// Input clk is an abstract 30MHz source: no oscillator/MMCM/pin is implied.
// All data/config/result ports retain the numerical core contract. Boundary
// routes and external timing are deliberately outside this experiment.
module bppe_ooc_clocked_top #(
    parameter integer SIGNAL_F=8,COEFFICIENT_F=18,TIME_F=8,FEATURE_F=16,
    parameter integer SIGNAL_W=26+SIGNAL_F,FEATURE_W=4+FEATURE_F,
    parameter integer BETA_W=10+FEATURE_F,ACC_W=20+FEATURE_F
) (
    input wire clk,rst,in_valid,
    output wire in_ready,
    input wire [71:0] in_adc,
    input wire [95:0] in_timestamp,
    input wire [31:0] in_tag,
    input wire [1:0] cfg_channels,cfg_primary,
    input wire [31:0] cfg_min_delta,cfg_max_delta,cfg_max_abs_skew,
    input wire in_config_error,in_gain_transition,
    input wire [2:0] in_channel_valid,in_channel_saturated,
    input wire [7:0] in_gain,in_optical,
    input wire [15:0] in_sequence,
    input wire sample_ready,
    output logic sample_accepted,
    output logic [15:0] sample_reasons,
    input wire ack,
    input wire signed [63:0] warmup_ticks,timeout_ticks,initial_deadline_ticks,
    input wire [COEFFICIENT_F-1:0] dc_coefficient,lowpass_coefficient,
    input wire [29:0] tick_period_ns,
    input wire signed [FEATURE_W-1:0] min_period,max_period,
    input wire signed [47:0] max_period_ticks,
    input wire [6:0] in_beats_required,
    input wire signed [FEATURE_W-1:0] in_min_amplitude,in_max_amplitude,in_max_cv,
    input wire [7:0] in_sqi_threshold,
    input wire in_configured,in_calibrated,in_demo_only,in_allow_demo,
    input wire signed [FEATURE_W-1:0] in_center[0:4],in_scale[0:4],in_feature_min[0:4],in_feature_max[0:4],
    input wire signed [BETA_W-1:0] in_beta[0:5][0:1],
    input wire [4:0] in_min_enabled,in_max_enabled,
    input wire signed [ACC_W-1:0] in_bp_min[0:1],in_bp_max[0:1],
    input wire [63:0] initial_saturations,initial_divzero,initial_precision,
    output logic sample_done,
    output logic [31:0] sample_tag,
    output logic [63:0] sample_saturations,sample_divzero,sample_precision,
    output logic candidate_valid,candidate_result_valid,candidate_has_features,
    output logic [15:0] candidate_seq,candidate_reasons,
    output logic [31:0] candidate_tag,candidate_timestamp,
    output logic [7:0] candidate_sqi,
    output logic signed [FEATURE_W-1:0] candidate_features[0:4],
    output logic signed [ACC_W-1:0] candidate_pressure_raw[0:1],
    output logic [15:0] candidate_codes[0:1],
    output logic pending,snapshot_result_valid,snapshot_has_features,
    output logic [15:0] snapshot_seq,snapshot_reasons,result_counter,fault_flags,
    output logic [31:0] snapshot_tag,snapshot_timestamp,
    output logic [7:0] snapshot_sqi,
    output logic signed [FEATURE_W-1:0] snapshot_features[0:4],
    output logic signed [ACC_W-1:0] snapshot_pressure_raw[0:1],
    output logic [15:0] snapshot_codes[0:1]
);
    wire core_clk;
    BUFG core_clock_buffer(.I(clk),.O(core_clk));
    bppe_multichannel_prototype #(
        .SIGNAL_F(SIGNAL_F),.COEFFICIENT_F(COEFFICIENT_F),.TIME_F(TIME_F),.FEATURE_F(FEATURE_F),
        .SIGNAL_W(SIGNAL_W),.FEATURE_W(FEATURE_W),.BETA_W(BETA_W),.ACC_W(ACC_W)
    ) core(.clk(core_clk),.*);
endmodule
`default_nettype wire
