`include "numeric_latency_bounds.svh"
    parameter integer PROFILE=1;
    localparam integer FF=(PROFILE==0)?8:((PROFILE==1)?16:18),RF=FF;
    localparam integer FW=4+FF,BW=10+RF,AW=20+RF;
    logic clk=0;always #5 clk=~clk;
    logic rst=1,in_valid=0,out_ready=0;
    wire in_ready,out_valid,has_features,result_valid;
    logic [31:0] in_tag=0;
    wire [31:0] out_tag;
    logic [1:0] in_channels,in_primary;
    logic [6:0] in_beats_required,in_counts[0:2];
    logic signed [FW-1:0] in_beats[0:2][0:63][0:4];
    logic [63:0] in_rejected[0:2];
    logic signed [FW-1:0] in_min_amplitude,in_max_amplitude,in_max_cv;
    logic [7:0] in_sqi_threshold;
    logic in_configured,in_calibrated,in_demo_only,in_allow_demo;
    logic signed [FW-1:0] in_center[0:4],in_scale[0:4],in_feature_min[0:4],in_feature_max[0:4];
    logic signed [BW-1:0] in_beta[0:5][0:1];
    logic [4:0] in_min_enabled,in_max_enabled;
    logic signed [AW-1:0] in_bp_min[0:1],in_bp_max[0:1];
    logic [63:0] in_saturations=0,in_divzero=0,in_precision=0;
    wire signed [FW-1:0] features[0:4];
    wire [7:0] sqi,channel_sqi[0:2];
    wire [15:0] reason_flags,pressure_codes[0:1];
    wire signed [AW-1:0] pressure_raw[0:1];
    wire [63:0] saturation_count,divzero_count,precision_count;
    bppe_measurement_core #(.FEATURE_F(FF),.REGRESSION_F(RF)) dut(.*);
    function automatic [1023:0] packet;
        packet={out_tag,has_features,result_valid,features[0],features[1],features[2],features[3],features[4],
            sqi,channel_sqi[0],channel_sqi[1],channel_sqi[2],reason_flags,pressure_raw[0],pressure_raw[1],
            pressure_codes[0],pressure_codes[1],saturation_count,divzero_count,precision_count};
    endfunction
