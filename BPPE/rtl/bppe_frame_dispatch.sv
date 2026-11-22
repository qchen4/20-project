`timescale 1ns/1ps
`default_nettype none
// Running-session prototype adapter, not a bus or lifecycle controller.
// One complete frame is validated before any channel event becomes visible.
// Rejection is an ordered event: the consumer must drain older numerical work
// before accepting history_reset. Config errors retain processing history.
module bppe_frame_dispatch (
    input wire clk,rst,
    input wire [1:0] cfg_channels,
    input wire [31:0] cfg_min_delta,cfg_max_delta,cfg_max_abs_skew,
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
    output wire out_reject,out_history_reset,out_first,out_last,
    output wire [15:0] out_reason,out_frame_faults,
    output wire [1:0] out_channel,
    output wire [23:0] out_adc,
    output wire [31:0] out_timestamp,out_tag,
    output wire [15:0] out_sequence,
    output wire signed [63:0] out_ticks,
    output logic [15:0] frame_faults,
    output wire idle
);
    localparam [15:0] LOW_SQI=16'd1,SAMPLE_GAP=16'd2,ADC_SATURATED=16'd4,
        TIMESTAMP_ERROR=16'd8,CONFIG_ERROR=16'd1024;
    typedef enum logic [1:0] {EMPTY,CHECK,EMIT} phase_t;
    phase_t phase;
    logic [1:0] channels,index;
    logic [31:0] min_delta,max_delta,max_skew;
    logic have_frame,config_error,gain_transition;
    logic [71:0] adc;
    logic [95:0] timestamp,last_timestamp;
    logic [2:0] valid_bits,saturated_bits;
    logic [7:0] gain,optical,last_gain,last_optical;
    logic [15:0] sequence_number,last_sequence,reason,checked_reason;
    logic [31:0] tag;
    logic signed [63:0] elapsed_ticks,event_elapsed;
    logic signed [31:0] skew[0:2];
    logic [31:0] delta[0:2];
    logic bad_valid,bad_saturation,bad_skew,bad_delta;
    function automatic [31:0] abs_skew(input logic signed [31:0] s);
        abs_skew=s[31]?(~$unsigned(s)+32'd1):$unsigned(s);
    endfunction
    always @* begin
        bad_valid=0;bad_saturation=0;bad_skew=0;bad_delta=0;
        for(integer j=0;j<3;j=j+1)begin
            skew[j]=$signed(timestamp[j*32+:32]-timestamp[0+:32]);
            delta[j]=timestamp[j*32+:32]-last_timestamp[j*32+:32];
            if(j<channels)begin
                bad_valid=bad_valid || !valid_bits[j];
                bad_saturation=bad_saturation || saturated_bits[j];
                bad_skew=bad_skew || abs_skew(skew[j])>max_skew;
                bad_delta=bad_delta || delta[j]==0 || delta[j]>=32'h80000000 ||
                    delta[j]<min_delta || delta[j]>max_delta;
            end
        end
        // Exact public MATLAB precedence; only the first reason is emitted.
        checked_reason=0;
        if(config_error)checked_reason=CONFIG_ERROR;
        else if(bad_valid)checked_reason=SAMPLE_GAP;
        else if(bad_saturation)checked_reason=ADC_SATURATED;
        else if(bad_skew)checked_reason=TIMESTAMP_ERROR;
        else if(gain_transition || (have_frame && (gain!=last_gain || optical!=last_optical)))checked_reason=LOW_SQI;
        else if(have_frame && (16'(sequence_number-last_sequence)!=16'd1))checked_reason=SAMPLE_GAP;
        else if(have_frame && bad_delta)checked_reason=TIMESTAMP_ERROR;
    end
    assign in_ready=!rst && phase==EMPTY;
    assign out_valid=!rst && phase==EMIT;
    assign idle=phase==EMPTY;
    assign out_reject=reason!=0;
    assign out_history_reset=reason!=0 && reason!=CONFIG_ERROR;
    assign out_first=index==0;
    assign out_last=out_reject || index==channels-1'b1;
    assign out_reason=reason;
    assign out_frame_faults=frame_faults;
    assign out_channel=index;
    assign out_adc=adc[index*24+:24];
    assign out_timestamp=timestamp[index*32+:32];
    assign out_tag=tag;
    assign out_sequence=sequence_number;
    assign out_ticks=event_elapsed+$signed({{32{skew[index][31]}},skew[index]});
    always @(posedge clk)begin
        if(rst)begin
            phase<=EMPTY;channels<=cfg_channels;min_delta<=cfg_min_delta;
            max_delta<=cfg_max_delta;max_skew<=cfg_max_abs_skew;
            have_frame<=0;last_timestamp<=0;last_sequence<=0;last_gain<=0;last_optical<=0;
            elapsed_ticks<=0;event_elapsed<=0;frame_faults<=0;index<=0;reason<=0;
            adc<=0;timestamp<=0;valid_bits<=0;saturated_bits<=0;gain_transition<=0;
            gain<=0;optical<=0;sequence_number<=0;tag<=0;config_error<=0;
        end else case(phase)
            EMPTY:if(in_valid && in_ready)begin
                adc<=in_adc;timestamp<=in_timestamp;valid_bits<=in_channel_valid;
                saturated_bits<=in_channel_saturated;gain_transition<=in_gain_transition;
                gain<=in_gain;optical<=in_optical;sequence_number<=in_sequence;tag<=in_tag;
                config_error<=in_config_error || cfg_channels!=channels || cfg_min_delta!=min_delta ||
                    cfg_max_delta!=max_delta || cfg_max_abs_skew!=max_skew;
                phase<=CHECK;
            end
            CHECK:begin
                reason<=checked_reason;index<=0;phase<=EMIT;
                frame_faults<=frame_faults | checked_reason;
                if(checked_reason==0)begin
                    event_elapsed<=elapsed_ticks+(have_frame?{32'd0,delta[0]}:64'd0);
                    elapsed_ticks<=elapsed_ticks+(have_frame?{32'd0,delta[0]}:64'd0);
                    have_frame<=1;last_timestamp<=timestamp;last_sequence<=sequence_number;
                    last_gain<=gain;last_optical<=optical;
                end else if(checked_reason!=CONFIG_ERROR)begin
                    have_frame<=0;last_timestamp<=0;last_sequence<=0;last_gain<=0;last_optical<=0;
                    elapsed_ticks<=0;event_elapsed<=0;
                end
            end
            EMIT:if(out_ready)begin
                if(out_last)phase<=EMPTY;else index<=index+1'b1;
            end
            default:phase<=EMPTY;
        endcase
    end
`ifndef SYNTHESIS
    always @(posedge clk)if(!rst)begin
        if(channels<1 || channels>3 || min_delta<1 || min_delta>max_delta ||
            max_delta>=32'h80000000 || max_skew>32'h80000000)
            $fatal(1,"Unsupported frame-dispatch configuration");
        // Signed elapsed time must remain within the audited MATLAB integer
        // range. Session duration limits are not a product interface yet.
        if(phase==CHECK && checked_reason==0 &&
            (elapsed_ticks>64'sd9007194959773695))
            $fatal(1,"Frame elapsed ticks outside audited exact host domain");
    end
`endif
endmodule
`default_nettype wire
