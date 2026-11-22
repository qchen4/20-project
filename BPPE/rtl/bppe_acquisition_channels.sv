`timescale 1ns/1ps
`default_nettype none
// Prototype integration: one validator, three independent channel histories,
// one numerical event in flight. Rejections fence/clear older numerical work.
// Replication/serialization are prototype choices, not frozen product PPA.
module bppe_acquisition_channels #(
    parameter integer SIGNAL_F=8,COEFFICIENT_F=18,TIME_F=8,FEATURE_F=16,
    CYCLE_CAPACITY=304,SIGNAL_W=26+SIGNAL_F,FEATURE_W=4+FEATURE_F
) (
    input wire clk,rst,
    input wire [1:0] cfg_channels,
    input wire [31:0] cfg_min_delta,cfg_max_delta,cfg_max_abs_skew,
    input wire [COEFFICIENT_F-1:0] dc_coefficient,lowpass_coefficient,
    input wire [29:0] tick_period_ns,
    input wire signed [FEATURE_W-1:0] min_period,max_period,
    input wire signed [47:0] max_period_ticks,
    input wire signed [63:0] warmup_ticks,
    input wire in_valid,
    output wire in_ready,
    input wire in_config_error,
    input wire [71:0] in_adc,
    input wire [95:0] in_timestamp,
    input wire [2:0] in_channel_valid,in_channel_saturated,
    input wire in_gain_transition,
    input wire [7:0] in_gain,in_optical,
    input wire [15:0] in_sequence,
    input wire [31:0] in_tag,
    output wire out_valid,
    input wire out_ready,
    output wire out_reject,
    output logic out_history_reset,out_first,out_last,
    output logic [15:0] out_reason,out_frame_faults,
    output logic [1:0] out_channel,
    output logic [23:0] out_adc,
    output logic [31:0] out_timestamp,out_tag,
    output logic [15:0] out_sequence,
    output logic signed [63:0] out_ticks,
    output wire signed [SIGNAL_W-1:0] out_dc,out_filtered,
    output wire signed [47:0] out_time,beat_time,
    output wire out_beat_valid,tracking,
    output wire signed [FEATURE_W-1:0] features[0:4],
    output wire [63:0] rejected_beats,saturation_count,divzero_count,precision_count,
    output wire [15:0] live_frame_faults,
    output wire numeric_fault,idle
);
    typedef enum logic [1:0] {WAIT_EVENT,WAIT_NUMERIC,REJECT_EVENT} phase_t;
    phase_t phase;
    wire ev_valid,ev_ready,ev_reject,ev_reset,ev_first,ev_last,adapter_idle;
    wire [15:0] ev_reason,ev_faults,ev_sequence;
    wire [1:0] ev_channel;
    wire [23:0] ev_adc;
    wire [31:0] ev_timestamp,ev_tag;
    wire signed [63:0] ev_ticks;
    wire [2:0] core_ready,core_valid,core_idle,core_beat,core_tracking,core_fault;
    wire signed [SIGNAL_W-1:0] dc[0:2],filtered[0:2];
    wire signed [47:0] sample_time[0:2],core_beat_time[0:2];
    wire signed [FEATURE_W-1:0] core_features[0:2][0:4];
    wire [63:0] rejected[0:2],sat[0:2],dz[0:2],prec[0:2];
    // A rejection never enters a numerical core. Derive its acceptance from
    // the idle fence, independently of core_ready: clear_history suppresses
    // core_ready, so feeding ev_ready back here creates a structural LUT loop.
    // ev_reset implies ev_reject in the dispatcher; the transfer edge and
    // ordered-history semantics therefore remain unchanged.
    wire event_slot_idle=phase==WAIT_EVENT && (&core_idle);
    wire reject_transfer=ev_valid && event_slot_idle && ev_reject;
    wire clear_channels=reject_transfer && ev_reset;
    bppe_frame_dispatch adapter(
        .clk(clk),.rst(rst),.cfg_channels(cfg_channels),.cfg_min_delta(cfg_min_delta),.cfg_max_delta(cfg_max_delta),.cfg_max_abs_skew(cfg_max_abs_skew),
        .in_valid(in_valid),.in_ready(in_ready),.in_config_error(in_config_error),.in_adc(in_adc),.in_timestamp(in_timestamp),
        .in_channel_valid(in_channel_valid),.in_channel_saturated(in_channel_saturated),.in_gain_transition(in_gain_transition),
        .in_gain(in_gain),.in_optical(in_optical),.in_sequence(in_sequence),.in_tag(in_tag),
        .out_valid(ev_valid),.out_ready(ev_ready),.out_reject(ev_reject),.out_history_reset(ev_reset),
        .out_first(ev_first),.out_last(ev_last),.out_reason(ev_reason),.out_frame_faults(ev_faults),
        .out_channel(ev_channel),.out_adc(ev_adc),.out_timestamp(ev_timestamp),.out_tag(ev_tag),
        .out_sequence(ev_sequence),.out_ticks(ev_ticks),.frame_faults(live_frame_faults),.idle(adapter_idle));
    assign ev_ready=event_slot_idle && (ev_reject || core_ready[ev_channel]);
    for(genvar g=0;g<3;g=g+1)begin:channels
        bppe_channel_core #(.SIGNAL_F(SIGNAL_F),.COEFFICIENT_F(COEFFICIENT_F),.TIME_F(TIME_F),.FEATURE_F(FEATURE_F),
            .CYCLE_CAPACITY(CYCLE_CAPACITY),.SIGNAL_W(SIGNAL_W),.FEATURE_W(FEATURE_W)) core(
            .clk(clk),.rst(rst),.clear_history(clear_channels),
            .in_valid(ev_valid && phase==WAIT_EVENT && (&core_idle) && !ev_reject && ev_channel==g),.in_ready(core_ready[g]),
            .in_adc(ev_adc),.in_ticks(ev_ticks),.in_tag(ev_tag),.in_warmup(ev_ticks<warmup_ticks),
            .dc_coefficient(dc_coefficient),.lowpass_coefficient(lowpass_coefficient),.tick_period_ns(tick_period_ns),
            .min_period(min_period),.max_period(max_period),.max_period_ticks(max_period_ticks),
            .out_valid(core_valid[g]),.out_ready(phase==WAIT_NUMERIC && out_channel==g && out_ready),
            .out_tag(),.out_warmup(),.out_dc(dc[g]),.out_filtered(filtered[g]),.out_time(sample_time[g]),
            .out_beat_valid(core_beat[g]),.beat_time(core_beat_time[g]),.features(core_features[g]),.tracking(core_tracking[g]),
            .rejected_beats(rejected[g]),.out_saturation_count(sat[g]),.out_divzero_count(dz[g]),.out_precision_count(prec[g]),
            .out_numeric_fault(),.numeric_fault(core_fault[g]),.idle(core_idle[g]));
    end
    assign out_reject=phase==REJECT_EVENT;
    assign out_valid=!rst && (out_reject || (phase==WAIT_NUMERIC && core_valid[out_channel]));
    assign out_dc=dc[out_channel];assign out_filtered=filtered[out_channel];assign out_time=sample_time[out_channel];
    assign out_beat_valid=!out_reject && core_beat[out_channel];assign beat_time=core_beat_time[out_channel];
    assign tracking=core_tracking[out_channel];assign rejected_beats=rejected[out_channel];
    for(genvar f=0;f<5;f=f+1)assign features[f]=core_features[out_channel][f];
    assign saturation_count=sat[0]+sat[1]+sat[2];assign divzero_count=dz[0]+dz[1]+dz[2];
    assign precision_count=prec[0]+prec[1]+prec[2];assign numeric_fault=|core_fault;
    assign idle=adapter_idle && phase==WAIT_EVENT && (&core_idle);
    always @(posedge clk)begin
        if(rst)begin
            phase<=WAIT_EVENT;out_history_reset<=0;out_first<=0;out_last<=0;out_reason<=0;out_frame_faults<=0;
            out_channel<=0;out_adc<=0;out_timestamp<=0;out_tag<=0;out_sequence<=0;out_ticks<=0;
        end else if(ev_valid && ev_ready)begin
            out_history_reset<=ev_reset;out_first<=ev_first;out_last<=ev_last;out_reason<=ev_reason;out_frame_faults<=ev_faults;
            out_channel<=ev_channel;out_adc<=ev_adc;out_timestamp<=ev_timestamp;out_tag<=ev_tag;out_sequence<=ev_sequence;out_ticks<=ev_ticks;
            phase<=ev_reject?REJECT_EVENT:WAIT_NUMERIC;
        end else if(out_valid && out_ready)phase<=WAIT_EVENT;
    end
`ifndef SYNTHESIS
    always @(posedge clk)if(!rst)begin
        if(clear_channels && core_idle!=3'b111)$fatal(1,"Rejection overtook numerical work");
        if(ev_valid && ev_reset && !ev_reject)$fatal(1,"History reset requires a rejection event");
    end
`endif
endmodule
`default_nettype wire
