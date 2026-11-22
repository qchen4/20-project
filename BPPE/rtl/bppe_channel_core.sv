`timescale 1ns/1ps
`default_nettype none
// Experimental single-channel ADC-to-feature pipeline. Sidebands and upstream
// fault snapshots travel with each accepted sample through the elastic slot.
module bppe_channel_core #(
    parameter integer SIGNAL_F=8,COEFFICIENT_F=18,TIME_F=8,FEATURE_F=16,
    parameter integer CYCLE_CAPACITY=304,SIGNAL_W=26+SIGNAL_F,FEATURE_W=4+FEATURE_F
) (
    input wire clk,rst,clear_history,
    input wire in_valid,
    output wire in_ready,
    input wire [23:0] in_adc,
    input wire signed [63:0] in_ticks,
    input wire [31:0] in_tag,
    input wire in_warmup,
    input wire [COEFFICIENT_F-1:0] dc_coefficient,lowpass_coefficient,
    input wire [29:0] tick_period_ns,
    input wire signed [FEATURE_W-1:0] min_period,max_period,
    input wire signed [47:0] max_period_ticks,
    output wire out_valid,
    input wire out_ready,
    output logic [31:0] out_tag,
    output logic out_warmup,
    output logic signed [SIGNAL_W-1:0] out_dc,out_filtered,
    output logic signed [47:0] out_time,
    output wire out_beat_valid,
    output wire signed [47:0] beat_time,
    output wire signed [FEATURE_W-1:0] features[0:4],
    output wire tracking,
    output wire [63:0] rejected_beats,
    output wire [63:0] out_saturation_count,out_divzero_count,out_precision_count,
    output wire out_numeric_fault,numeric_fault,idle
);
    wire pre_valid,beat_ready,pre_fault,beat_fault,initialized;
    wire signed [SIGNAL_W-1:0] pre_dc,pre_filtered;
    wire signed [47:0] pre_time;
    wire [63:0] pre_saturations,pre_precision,beat_saturations,beat_divzero,beat_precision;
    logic [31:0] slot_tag;
    logic slot_warmup;
    logic [29:0] slot_tick_ns;
    logic signed [FEATURE_W-1:0] slot_min_period,slot_max_period;
    logic signed [47:0] slot_max_ticks;
    logic [63:0] sample_pre_saturations,sample_pre_precision;
    logic [1:0] in_flight;

    bppe_preprocess_core #(.SIGNAL_F(SIGNAL_F),.COEFFICIENT_F(COEFFICIENT_F),.TIME_F(TIME_F),.SIGNAL_W(SIGNAL_W)) preprocess (
        .clk(clk),.rst(rst),.clear_history(clear_history),.in_valid(in_valid),.in_ready(in_ready),
        .in_adc(in_adc),.in_ticks(in_ticks),.dc_coefficient(dc_coefficient),.lowpass_coefficient(lowpass_coefficient),
        .out_valid(pre_valid),.out_ready(beat_ready),.initialized(initialized),.out_dc(pre_dc),
        .out_filtered(pre_filtered),.out_time(pre_time),.saturation_count(pre_saturations),
        .precision_count(pre_precision),.numeric_fault(pre_fault)
    );
    bppe_beat_core #(.SIGNAL_F(SIGNAL_F),.TIME_F(TIME_F),.FEATURE_F(FEATURE_F),.CYCLE_CAPACITY(CYCLE_CAPACITY),
        .SIGNAL_W(SIGNAL_W),.FEATURE_W(FEATURE_W)) beat (
        .clk(clk),.rst(rst),.clear_history(clear_history),.in_valid(pre_valid),.in_ready(beat_ready),
        .in_filtered(pre_filtered),.in_dc(pre_dc),.in_time(pre_time),.in_warmup(slot_warmup),
        .tick_period_ns(slot_tick_ns),.min_period(slot_min_period),.max_period(slot_max_period),.max_period_ticks(slot_max_ticks),
        .out_valid(out_valid),.out_ready(out_ready),.beat_valid(out_beat_valid),.beat_time(beat_time),.features(features),
        .tracking(tracking),.rejected_beats(rejected_beats),.saturation_count(beat_saturations),
        .divzero_count(beat_divzero),.precision_count(beat_precision),.numeric_fault(beat_fault)
    );
    // A prefetched sample may fault before the previous result is consumed.
    // Transaction counters use that result's upstream snapshot, not live totals.
    assign out_saturation_count=sample_pre_saturations+beat_saturations;
    assign out_divzero_count=beat_divzero;
    assign out_precision_count=sample_pre_precision+beat_precision;
    assign out_numeric_fault=(out_saturation_count!=0 || out_divzero_count!=0 || out_precision_count!=0);
    assign numeric_fault=pre_fault || beat_fault; // Live sticky pipeline diagnostic.
    assign idle=(in_flight==0);

    always @(posedge clk) begin
        if (rst || clear_history) begin
            in_flight<=0; slot_tag<=0; slot_warmup<=0; slot_tick_ns<=0;
            slot_min_period<=0; slot_max_period<=0; slot_max_ticks<=0;
            out_tag<=0; out_warmup<=0; out_dc<=0; out_filtered<=0; out_time<=0;
            if (rst) begin sample_pre_saturations<=0; sample_pre_precision<=0; end
        end else begin
            case ({in_valid&&in_ready,out_valid&&out_ready})
                2'b10: in_flight<=in_flight+1'b1;
                2'b01: in_flight<=in_flight-1'b1;
                default: in_flight<=in_flight;
            endcase
            if (in_valid && in_ready) begin
                slot_tag<=in_tag; slot_warmup<=in_warmup; slot_tick_ns<=tick_period_ns;
                slot_min_period<=min_period; slot_max_period<=max_period; slot_max_ticks<=max_period_ticks;
            end
            if (pre_valid && beat_ready) begin
                out_tag<=slot_tag; out_warmup<=slot_warmup; out_dc<=pre_dc; out_filtered<=pre_filtered; out_time<=pre_time;
                sample_pre_saturations<=pre_saturations; sample_pre_precision<=pre_precision;
            end
        end
    end
`ifndef SYNTHESIS
    always @(posedge clk) if (!rst) begin
        if (clear_history && !idle) $fatal(1,"Pipeline history clear requires all samples drained");
        if (in_flight>2) $fatal(1,"Pipeline occupancy exceeded two samples");
        if (out_valid && out_ready && idle) $fatal(1,"Pipeline output without an accepted sample");
    end
`endif
endmodule
`default_nettype wire
