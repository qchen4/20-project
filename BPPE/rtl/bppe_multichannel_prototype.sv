`timescale 1ns/1ps
`default_nettype none
// Running-session raw-frame numerical prototype with integer tick deadlines.
// Completion/candidate fields are held until sample_ready. No AHB/IRQ/W1C.
// Config is static; ACK/publication conflicts remain rejected in simulation.
module bppe_multichannel_prototype #(
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
    typedef enum logic [2:0] {INPUT,CHANNEL_WAIT,CHECK_WINDOW,MEASURE_REQUEST,MEASURE_WAIT,RESPONSE} phase_t;
    phase_t phase;
    wire channel_ready,channel_valid,channel_beat,channel_idle,channel_tracking,channel_live_fault;
    wire signed [SIGNAL_W-1:0] channel_dc,channel_filtered;
    wire signed [47:0] channel_time,channel_beat_time;
    wire [31:0] channel_tag;
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
    wire channel_reject,channel_history_reset,channel_first,channel_last;
    wire [1:0] channel_index;
    wire [15:0] channel_reasons;
    wire [31:0] channel_timestamp;
    wire signed [63:0] channel_ticks;
    logic [31:0] request_base_timestamp;
    logic signed [31:0] latest_skew;
    wire signed [31:0] current_skew=$signed(channel_timestamp-request_base_timestamp);
    wire history_clear=channel_valid && phase==CHANNEL_WAIT && channel_reject && channel_history_reset;
    logic enough;
    always @* begin
        enough=1;
        for(integer ch=0;ch<3;ch=ch+1)if(ch<cfg_channels && counts[ch]<in_beats_required)enough=0;
    end
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

    bppe_acquisition_channels #(.SIGNAL_F(SIGNAL_F),.COEFFICIENT_F(COEFFICIENT_F),.TIME_F(TIME_F),.FEATURE_F(FEATURE_F)) acquisition(
        .clk(clk),.rst(rst),.cfg_channels(cfg_channels),.cfg_min_delta(cfg_min_delta),.cfg_max_delta(cfg_max_delta),.cfg_max_abs_skew(cfg_max_abs_skew),
        .dc_coefficient(dc_coefficient),.lowpass_coefficient(lowpass_coefficient),.tick_period_ns(tick_period_ns),
        .min_period(min_period),.max_period(max_period),.max_period_ticks(max_period_ticks),.warmup_ticks(warmup_ticks),
        .in_valid(in_valid && phase==INPUT),.in_ready(channel_ready),.in_config_error(in_config_error),
        .in_adc(in_adc),.in_timestamp(in_timestamp),.in_channel_valid(in_channel_valid),.in_channel_saturated(in_channel_saturated),
        .in_gain_transition(in_gain_transition),.in_gain(in_gain),.in_optical(in_optical),.in_sequence(in_sequence),.in_tag(in_tag),
        .out_valid(channel_valid),.out_ready(phase==CHANNEL_WAIT && (channel_reject || store_ready)),
        .out_reject(channel_reject),.out_history_reset(channel_history_reset),.out_first(channel_first),.out_last(channel_last),
        .out_reason(channel_reasons),.out_frame_faults(),.out_channel(channel_index),.out_adc(),.out_timestamp(channel_timestamp),
        .out_tag(channel_tag),.out_sequence(),.out_ticks(channel_ticks),.out_dc(channel_dc),.out_filtered(channel_filtered),
        .out_time(channel_time),.beat_time(channel_beat_time),.out_beat_valid(channel_beat),.tracking(channel_tracking),.features(channel_features),
        .rejected_beats(channel_rejected),.saturation_count(channel_saturations),.divzero_count(channel_divzero),.precision_count(channel_precision),
        .live_frame_faults(),.numeric_fault(channel_live_fault),.idle(channel_idle)
    );
    bppe_window_store #(.FEATURE_F(FEATURE_F)) window(
        .clk(clk),.rst(rst),.clear_history(history_clear),.clear_window(store_clear),.in_valid(channel_valid && phase==CHANNEL_WAIT && !channel_reject),
        .in_ready(store_ready),.in_channel(channel_index),.beats_required(in_beats_required),.in_beat_valid(channel_beat),
        .in_features(channel_features),.in_rejected_total(channel_rejected),.out_counts(counts),.out_beats(beats),.out_rejected(rejected)
    );
    bppe_measurement_core #(.FEATURE_F(FEATURE_F),.REGRESSION_F(FEATURE_F)) measurement(
        .clk(clk),.rst(rst),.in_valid(measure_request),.in_ready(measure_ready),.in_tag(request_tag),
        .in_channels(cfg_channels),.in_primary(cfg_primary),.in_beats_required(in_beats_required),.in_counts(counts),.in_beats(beats),.in_rejected(rejected),
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
            request_tag<=0;request_timestamp<=0;request_timeout<=0;request_base_timestamp<=0;latest_skew<=0;sample_accepted<=0;sample_reasons<=0;
            request_ticks<=0;window_deadline_ticks<=initial_deadline_ticks;
            channel_sat_snapshot<=0;channel_div_snapshot<=0;channel_prec_snapshot<=0;
            extra_saturations<=initial_saturations;extra_divzero<=initial_divzero;extra_precision<=initial_precision;
            sample_tag<=0;sample_saturations<=initial_saturations;sample_divzero<=initial_divzero;sample_precision<=initial_precision;
            candidate_seq<=0;candidate_tag<=0;candidate_timestamp<=0;candidate_reasons<=0;candidate_sqi<=0;candidate_result_valid<=0;candidate_has_features<=0;
            snapshot_seq<=0;snapshot_tag<=0;snapshot_timestamp<=0;snapshot_reasons<=0;snapshot_sqi<=0;snapshot_result_valid<=0;snapshot_has_features<=0;
            for(i=0;i<5;i=i+1) begin candidate_features[i]<=0;snapshot_features[i]<=0;end
            for(i=0;i<2;i=i+1) begin candidate_codes[i]<=0;snapshot_codes[i]<=0;candidate_pressure_raw[i]<=0;snapshot_pressure_raw[i]<=0;end
        end else begin
            if(ack) pending<=0; // Payload is retained, as in bppe_control('ack').
            case(phase)
                INPUT: if(in_valid && in_ready) begin
                    request_tag<=in_tag;request_base_timestamp<=in_timestamp[31:0];request_timestamp<=in_timestamp[31:0];
                    latest_skew<=0;request_ticks<=0;request_timeout<=0;phase<=CHANNEL_WAIT;
                end
                CHANNEL_WAIT: if(channel_valid && (channel_reject || store_ready)) begin
                    channel_sat_snapshot<=channel_saturations;channel_div_snapshot<=channel_divzero;channel_prec_snapshot<=channel_precision;
                    if(channel_reject)begin
                        if(channel_history_reset)window_deadline_ticks<=initial_deadline_ticks;
                        sample_done<=1;sample_accepted<=0;sample_reasons<=channel_reasons;sample_tag<=request_tag;
                        sample_saturations<=channel_saturations+extra_saturations;
                        sample_divzero<=channel_divzero+extra_divzero;sample_precision<=channel_precision+extra_precision;
                        fault_flags<=fault_flags|channel_reasons;phase<=RESPONSE;
                    end else begin
                        if(channel_first)begin request_ticks<=channel_ticks;request_timeout<=channel_ticks>=window_deadline_ticks;end
                        if(current_skew>latest_skew)begin latest_skew<=current_skew;request_timestamp<=channel_timestamp;end
                        if(channel_last)phase<=CHECK_WINDOW;
                    end
                end
                CHECK_WINDOW: begin
                    if(enough || request_timeout) phase<=MEASURE_REQUEST;
                    else begin
                        sample_done<=1;sample_accepted<=1;sample_tag<=request_tag;sample_saturations<=total_sat;sample_divzero<=total_div;sample_precision<=total_prec;
                        sample_reasons<=numeric_bits(total_sat,total_div,total_prec);fault_flags<=fault_flags|numeric_bits(total_sat,total_div,total_prec);phase<=RESPONSE;
                    end
                end
                MEASURE_REQUEST: if(measure_ready) begin
                    seed_sat<=total_sat;seed_div<=total_div;seed_prec<=total_prec;result_counter<=result_counter+1'b1;
                    window_deadline_ticks<=request_ticks+timeout_ticks;phase<=MEASURE_WAIT;
                end
                MEASURE_WAIT: if(measure_valid) begin
                    sample_done<=1;sample_accepted<=1;sample_tag<=request_tag;sample_saturations<=measure_saturations;sample_divzero<=measure_divzero;sample_precision<=measure_precision;
                    extra_saturations<=extra_saturations+(measure_saturations-seed_sat);
                    extra_divzero<=extra_divzero+(measure_divzero-seed_div);extra_precision<=extra_precision+(measure_precision-seed_prec);
                    sample_reasons<=numeric_bits(measure_saturations,measure_divzero,measure_precision)|(pending?16'h0200:16'h0000);
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
                    phase<=RESPONSE;
                end
                RESPONSE:if(sample_ready)begin sample_done<=0;candidate_valid<=0;phase<=INPUT;end
                default: phase<=INPUT;
            endcase
        end
    end
`ifndef SYNTHESIS
    always @(posedge clk) if(!rst) begin
        if(in_valid && in_ready && (timeout_ticks<=0 || warmup_ticks<0 || initial_deadline_ticks<0 || cfg_channels<1 || cfg_channels>3 || cfg_primary>=cfg_channels))
            $fatal(1,"Invalid integer tick timing configuration/input");
        if(ack && measure_transfer) $fatal(1,"ACK/publication concurrency is not defined in this prototype");
        if(measure_transfer && (measure_saturations<seed_sat || measure_divzero<seed_div || measure_precision<seed_prec))
            $fatal(1,"Measurement fault delta underflow");
    end
`endif
endmodule
`default_nettype wire
