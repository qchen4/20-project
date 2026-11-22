`include "numeric_latency_bounds.svh"
    parameter integer PROFILE=1;
    localparam integer SF=(PROFILE==0)?0:((PROFILE==1)?8:10),CF=(PROFILE==0)?8:18,TF=SF;
    localparam integer FF=(PROFILE==0)?8:((PROFILE==1)?16:18),SW=26+SF,FW=4+FF,BW=10+FF,AW=20+FF;
    logic clk=0;always #5 clk=~clk;
    logic rst=1,in_valid=0,ack=0;
    logic signed [63:0] warmup_ticks=0,timeout_ticks=0,initial_deadline_ticks=0;
    wire in_ready,sample_done,candidate_valid,pending;
    logic [71:0] in_adc=0;
    logic [95:0] in_timestamp=0;
    logic [31:0] in_tag=0;
    logic [1:0] cfg_channels,cfg_primary;
    logic [31:0] cfg_min_delta,cfg_max_delta,cfg_max_abs_skew;
    logic in_config_error=0,in_gain_transition=0,sample_ready=0;
    logic [2:0] in_channel_valid=0,in_channel_saturated=0;
    logic [7:0] in_gain=0,in_optical=0;
    logic [15:0] in_sequence=0;
    wire sample_accepted;
    wire [15:0] sample_reasons;
    logic [CF-1:0] dc_coefficient,lowpass_coefficient;
    logic [29:0] tick_period_ns;
    logic signed [FW-1:0] min_period,max_period,in_min_amplitude,in_max_amplitude,in_max_cv;
    logic signed [47:0] max_period_ticks;
    logic [6:0] in_beats_required;
    logic [7:0] in_sqi_threshold;
    logic in_configured,in_calibrated,in_demo_only,in_allow_demo;
    logic signed [FW-1:0] in_center[0:4],in_scale[0:4],in_feature_min[0:4],in_feature_max[0:4];
    logic signed [BW-1:0] in_beta[0:5][0:1];
    logic [4:0] in_min_enabled,in_max_enabled;
    logic signed [AW-1:0] in_bp_min[0:1],in_bp_max[0:1];
    logic [63:0] initial_saturations=0,initial_divzero=0,initial_precision=0;
    wire [31:0] sample_tag,candidate_tag,candidate_timestamp,snapshot_tag,snapshot_timestamp;
    wire [63:0] sample_saturations,sample_divzero,sample_precision;
    wire candidate_result_valid,candidate_has_features,snapshot_result_valid,snapshot_has_features;
    wire [15:0] candidate_seq,candidate_reasons,snapshot_seq,snapshot_reasons,result_counter,fault_flags;
    wire [7:0] candidate_sqi,snapshot_sqi;
    wire signed [FW-1:0] candidate_features[0:4],snapshot_features[0:4];
    wire signed [AW-1:0] candidate_pressure_raw[0:1],snapshot_pressure_raw[0:1];
    wire [15:0] candidate_codes[0:1],snapshot_codes[0:1];
`ifdef BPPE_OOC_CLOCKED
    `define BPPE_SYSTEM_DUT_CORE dut.core
    bppe_ooc_clocked_top #(.SIGNAL_F(SF),.COEFFICIENT_F(CF),.TIME_F(TF),.FEATURE_F(FF)) dut(.*);
`else
    `define BPPE_SYSTEM_DUT_CORE dut
    bppe_multichannel_prototype #(.SIGNAL_F(SF),.COEFFICIENT_F(CF),.TIME_F(TF),.FEATURE_F(FF)) dut(.*);
`endif
