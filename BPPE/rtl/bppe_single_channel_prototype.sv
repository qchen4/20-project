`timescale 1ns/1ps
`default_nettype none
// Accepted-frame numerical prototype with host-encoded integer tick deadlines.
// No acquisition validator, AHB, IRQ or W1C.
module bppe_single_channel_prototype #(
    parameter integer SIGNAL_F=8,COEFFICIENT_F=18,TIME_F=8,FEATURE_F=16,
    parameter integer SIGNAL_W=26+SIGNAL_F,FEATURE_W=4+FEATURE_F,
    parameter integer BETA_W=10+FEATURE_F,ACC_W=20+FEATURE_F
) (
    input wire clk,rst,in_valid,
    output wire in_ready,
    input wire [23:0] in_adc,
    input wire signed [63:0] in_ticks,
    input wire [31:0] in_tag,in_timestamp,
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
    typedef enum logic [2:0] {INPUT,CHANNEL_WAIT,CHECK_WINDOW,MEASURE_REQUEST,MEASURE_WAIT} phase_t;
    phase_t phase;
    wire channel_ready,channel_valid,channel_beat,channel_idle,channel_tracking,channel_out_fault,channel_live_fault;
    wire signed [SIGNAL_W-1:0] channel_dc,channel_filtered;
    wire signed [47:0] channel_time,channel_beat_time;
    wire [31:0] channel_tag;
    wire channel_warmup;
    wire signed [FEATURE_W-1:0] channel_features[0:4];
    wire [63:0] channel_rejected,channel_saturations,channel_divzero,channel_precision;
    wire store_ready,measure_ready,measure_valid;
    wire [6:0] counts[0:2];
    wire signed [FEATURE_W-1:0] beats[0:2][0:63][0:4];
    wire [63:0] rejected[0:2];
    wire [31:0] measure_tag;
    wire measure_has_features,measure_result_valid;
    wire signed [FEATURE_W-1:0] measure_features[0:4];
    wire [7:0] measure_sqi,measure_channel_sqi[0:2];
    wire [15:0] measure_reasons,measure_codes[0:1];
    wire signed [ACC_W-1:0] measure_pressure[0:1];
    wire [63:0] measure_saturations,measure_divzero,measure_precision;
    logic [31:0] request_tag,request_timestamp;
    logic request_timeout;
    logic signed [63:0] request_ticks,window_deadline_ticks;
    wire in_warmup=in_ticks<warmup_ticks;
    logic [63:0] channel_sat_snapshot,channel_div_snapshot,channel_prec_snapshot;
    logic [63:0] extra_saturations,extra_divzero,extra_precision,seed_sat,seed_div,seed_prec;
    wire [63:0] total_sat=channel_sat_snapshot+extra_saturations;
    wire [63:0] total_div=channel_div_snapshot+extra_divzero;
    wire [63:0] total_prec=channel_prec_snapshot+extra_precision;
    wire measure_request=phase==MEASURE_REQUEST;
    wire measure_transfer=measure_valid && phase==MEASURE_WAIT;
    wire store_clear=measure_request && measure_ready;
    integer i;
    function automatic [15:0] numeric_bits(input logic [63:0] s,d,p);
        numeric_bits=((s!=0 || d!=0 || p!=0)?16'h0040:16'h0000)|((d!=0)?16'h0080:16'h0000);
    endfunction
    assign in_ready=!rst && phase==INPUT && channel_ready;

    bppe_channel_core #(.SIGNAL_F(SIGNAL_F),.COEFFICIENT_F(COEFFICIENT_F),.TIME_F(TIME_F),.FEATURE_F(FEATURE_F)) channel(
        .clk(clk),.rst(rst),.clear_history(1'b0),.in_valid(in_valid && phase==INPUT),.in_ready(channel_ready),
        .in_adc(in_adc),.in_ticks(in_ticks),.in_tag(in_tag),.in_warmup(in_warmup),.dc_coefficient(dc_coefficient),
        .lowpass_coefficient(lowpass_coefficient),.tick_period_ns(tick_period_ns),.min_period(min_period),.max_period(max_period),
        .max_period_ticks(max_period_ticks),.out_valid(channel_valid),.out_ready(phase==CHANNEL_WAIT && store_ready),
        .out_tag(channel_tag),.out_warmup(channel_warmup),.out_dc(channel_dc),.out_filtered(channel_filtered),.out_time(channel_time),
        .out_beat_valid(channel_beat),.beat_time(channel_beat_time),.features(channel_features),.tracking(channel_tracking),
        .rejected_beats(channel_rejected),.out_saturation_count(channel_saturations),.out_divzero_count(channel_divzero),
        .out_precision_count(channel_precision),.out_numeric_fault(channel_out_fault),.numeric_fault(channel_live_fault),.idle(channel_idle)
    );
    bppe_window_store #(.FEATURE_F(FEATURE_F)) window(
        .clk(clk),.rst(rst),.clear_history(1'b0),.clear_window(store_clear),.in_valid(channel_valid && phase==CHANNEL_WAIT),
        .in_ready(store_ready),.in_channel(2'd0),.beats_required(in_beats_required),.in_beat_valid(channel_beat),
        .in_features(channel_features),.in_rejected_total(channel_rejected),.out_counts(counts),.out_beats(beats),.out_rejected(rejected)
    );
    bppe_measurement_core #(.FEATURE_F(FEATURE_F),.REGRESSION_F(FEATURE_F)) measurement(
        .clk(clk),.rst(rst),.in_valid(measure_request),.in_ready(measure_ready),.in_tag(request_tag),
        .in_channels(2'd1),.in_primary(2'd0),.in_beats_required(in_beats_required),.in_counts(counts),.in_beats(beats),.in_rejected(rejected),
        .in_min_amplitude(in_min_amplitude),.in_max_amplitude(in_max_amplitude),.in_max_cv(in_max_cv),.in_sqi_threshold(in_sqi_threshold),
        .in_configured(in_configured),.in_calibrated(in_calibrated),.in_demo_only(in_demo_only),.in_allow_demo(in_allow_demo),
        .in_center(in_center),.in_scale(in_scale),.in_beta(in_beta),.in_min_enabled(in_min_enabled),.in_max_enabled(in_max_enabled),
        .in_feature_min(in_feature_min),.in_feature_max(in_feature_max),.in_bp_min(in_bp_min),.in_bp_max(in_bp_max),
        .in_saturations(total_sat),.in_divzero(total_div),.in_precision(total_prec),.out_valid(measure_valid),.out_ready(phase==MEASURE_WAIT),
        .out_tag(measure_tag),.has_features(measure_has_features),.result_valid(measure_result_valid),.features(measure_features),
        .sqi(measure_sqi),.channel_sqi(measure_channel_sqi),.reason_flags(measure_reasons),.pressure_raw(measure_pressure),
        .pressure_codes(measure_codes),.saturation_count(measure_saturations),.divzero_count(measure_divzero),.precision_count(measure_precision)
    );
    always @(posedge clk) begin
        if(rst) begin
            phase<=INPUT;sample_done<=0;candidate_valid<=0;pending<=0;result_counter<=0;fault_flags<=0;
            request_tag<=0;request_timestamp<=0;request_timeout<=0;
            request_ticks<=0;window_deadline_ticks<=initial_deadline_ticks;
            channel_sat_snapshot<=0;channel_div_snapshot<=0;channel_prec_snapshot<=0;
            extra_saturations<=initial_saturations;extra_divzero<=initial_divzero;extra_precision<=initial_precision;
            sample_tag<=0;sample_saturations<=initial_saturations;sample_divzero<=initial_divzero;sample_precision<=initial_precision;
            candidate_seq<=0;candidate_tag<=0;candidate_timestamp<=0;candidate_reasons<=0;candidate_sqi<=0;candidate_result_valid<=0;candidate_has_features<=0;
            snapshot_seq<=0;snapshot_tag<=0;snapshot_timestamp<=0;snapshot_reasons<=0;snapshot_sqi<=0;snapshot_result_valid<=0;snapshot_has_features<=0;
            for(i=0;i<5;i=i+1) begin candidate_features[i]<=0;snapshot_features[i]<=0;end
            for(i=0;i<2;i=i+1) begin candidate_codes[i]<=0;snapshot_codes[i]<=0;candidate_pressure_raw[i]<=0;snapshot_pressure_raw[i]<=0;end
        end else begin
            sample_done<=0;candidate_valid<=0;
            if(ack) pending<=0; // Payload is retained, as in bppe_control('ack').
            case(phase)
                INPUT: if(in_valid && in_ready) begin
                    request_tag<=in_tag;request_timestamp<=in_timestamp;request_ticks<=in_ticks;
                    request_timeout<=in_ticks>=window_deadline_ticks;phase<=CHANNEL_WAIT;
                end
                CHANNEL_WAIT: if(channel_valid && store_ready) begin
                    channel_sat_snapshot<=channel_saturations;channel_div_snapshot<=channel_divzero;channel_prec_snapshot<=channel_precision;
                    phase<=CHECK_WINDOW;
                end
                CHECK_WINDOW: begin
                    if(counts[0]>=in_beats_required || request_timeout) phase<=MEASURE_REQUEST;
                    else begin
                        sample_done<=1;sample_tag<=request_tag;sample_saturations<=total_sat;sample_divzero<=total_div;sample_precision<=total_prec;
                        fault_flags<=fault_flags|numeric_bits(total_sat,total_div,total_prec);phase<=INPUT;
                    end
                end
                MEASURE_REQUEST: if(measure_ready) begin
                    seed_sat<=total_sat;seed_div<=total_div;seed_prec<=total_prec;result_counter<=result_counter+1'b1;
                    window_deadline_ticks<=request_ticks+timeout_ticks;phase<=MEASURE_WAIT;
                end
                MEASURE_WAIT: if(measure_valid) begin
                    sample_done<=1;sample_tag<=request_tag;sample_saturations<=measure_saturations;sample_divzero<=measure_divzero;sample_precision<=measure_precision;
                    extra_saturations<=extra_saturations+(measure_saturations-seed_sat);
                    extra_divzero<=extra_divzero+(measure_divzero-seed_div);extra_precision<=extra_precision+(measure_precision-seed_prec);
                    candidate_valid<=1;candidate_seq<=result_counter;candidate_tag<=request_tag;candidate_timestamp<=request_timestamp;
                    candidate_reasons<=measure_reasons;candidate_sqi<=measure_sqi;candidate_result_valid<=measure_result_valid;candidate_has_features<=measure_has_features;
                    for(i=0;i<5;i=i+1) candidate_features[i]<=measure_features[i];
                    for(i=0;i<2;i=i+1) begin candidate_codes[i]<=measure_codes[i];candidate_pressure_raw[i]<=measure_pressure[i];end
                    fault_flags<=fault_flags|numeric_bits(measure_saturations,measure_divzero,measure_precision)|(pending?16'h0200:16'h0000);
                    if(!pending) begin
                        pending<=1;snapshot_seq<=result_counter;snapshot_tag<=request_tag;snapshot_timestamp<=request_timestamp;
                        snapshot_reasons<=measure_reasons;snapshot_sqi<=measure_sqi;snapshot_result_valid<=measure_result_valid;snapshot_has_features<=measure_has_features;
                        for(i=0;i<5;i=i+1) snapshot_features[i]<=measure_features[i];
                        for(i=0;i<2;i=i+1) begin snapshot_codes[i]<=measure_codes[i];snapshot_pressure_raw[i]<=measure_pressure[i];end
                    end
                    phase<=INPUT;
                end
                default: phase<=INPUT;
            endcase
        end
    end
`ifndef SYNTHESIS
    always @(posedge clk) if(!rst) begin
        if(in_valid && in_ready && (in_ticks<0 || timeout_ticks<=0 || warmup_ticks<0 || initial_deadline_ticks<0))
            $fatal(1,"Invalid integer tick timing configuration/input");
        if(ack && measure_transfer) $fatal(1,"ACK/publication concurrency is not defined in this prototype");
        if(measure_transfer && (measure_saturations<seed_sat || measure_divzero<seed_div || measure_precision<seed_prec))
            $fatal(1,"Measurement fault delta underflow");
    end
`endif
endmodule
`default_nettype wire
