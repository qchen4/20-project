`timescale 1ns/1ps
`default_nettype none
module tb_bppe_frame_flow;
    logic clk=0;always #5 clk=~clk;
    logic rst=1;
    logic [1:0] cfg_channels=1;
    logic [31:0] cfg_min_delta=8,cfg_max_delta=12,cfg_max_abs_skew=2;
    logic in_valid=0,in_config_error=0,out_ready=0;
    wire in_ready,out_valid,out_reject,out_history_reset,out_first,out_last,idle;
    logic [71:0] in_adc=0;
    logic [95:0] in_timestamp=0;
    logic [2:0] in_channel_valid=1,in_channel_saturated=0;
    logic in_gain_transition=0;
    logic [7:0] in_gain=0,in_optical=0;
    logic [15:0] in_sequence=0;
    logic [31:0] in_tag=0;
    wire [15:0] out_reason,out_frame_faults,frame_faults,out_sequence;
    wire [1:0] out_channel;
    wire [23:0] out_adc;
    wire [31:0] out_timestamp,out_tag;
    wire signed [63:0] out_ticks;
    bppe_frame_dispatch dut(.*);
    task automatic reset_adapter;
        begin
            @(negedge clk);rst=1;in_valid=0;out_ready=0;
            repeat(2)@(negedge clk);rst=0;
            if(out_valid || frame_faults!=0)$fatal(1,"Adapter reset failed");
        end
    endtask
    task automatic send_frame(input logic [31:0] ts,input logic [15:0] seq);
        begin
            @(negedge clk);in_timestamp={ts,ts,ts};in_sequence=seq;in_valid=1;
            if(!in_ready)$fatal(1,"Unexpected busy ingress");
            @(posedge clk);#1;@(negedge clk);in_valid=0;
            while(!out_valid)@(negedge clk);
        end
    endtask
    task automatic check_one(input logic [15:0] reason,input logic signed [63:0] ticks);
        begin
            if(out_reason!=reason || out_reject!==(reason!=0) ||
                out_history_reset!==(reason!=0 && reason!=1024) || !out_first || !out_last)
                $fatal(1,"Flow decision mismatch");
            if(reason==0 && out_ticks!=ticks)$fatal(1,"Flow elapsed time mismatch");
            out_ready=1;@(posedge clk);#1;@(negedge clk);out_ready=0;
        end
    endtask
    initial begin
        reset_adapter();in_channel_saturated=3'b110;
        send_frame(100,65535);check_one(0,0); // Inactive channel bits ignored.
        in_channel_saturated=0;send_frame(110,0);check_one(0,10);
        cfg_min_delta=9;in_channel_valid=0;in_channel_saturated=1;in_gain_transition=1;
        send_frame(120,1);check_one(1024,0); // Config comparison precedes other errors.
        cfg_min_delta=8;in_channel_valid=1;in_channel_saturated=0;in_gain_transition=0;
        send_frame(120,1);check_one(0,20); // Same sample retried; history retained.
        in_channel_valid=0;in_channel_saturated=1;
        send_frame(130,2);check_one(2,0);
        in_channel_valid=1;in_channel_saturated=0;in_gain=4;in_optical=5;
        send_frame(200,99);check_one(0,0); // Re-anchor clears previous gain/sequence.
        if(frame_faults!=1026)$fatal(1,"Sticky frame faults lost");
        // Abort while validation is pending, before it can emit an event.
        @(negedge clk);in_timestamp={3{32'd210}};in_sequence=100;in_valid=1;
        @(posedge clk);#1;reset_adapter();repeat(4)@(negedge clk);
        if(out_valid || !idle)$fatal(1,"Reset during CHECK leaked an event");
        // Abort a partially dispatched three-channel frame, including held event.
        cfg_channels=3;reset_adapter();in_channel_valid=7;
        send_frame(0,0);
        if(out_channel!=0 || !out_first || out_last)$fatal(1,"First channel mismatch");
        out_ready=1;@(posedge clk);#1;@(negedge clk);out_ready=0;
        if(out_channel!=1 || out_first || out_last)$fatal(1,"Second channel mismatch");
        reset_adapter();repeat(4)@(negedge clk);
        if(out_valid || !idle)$fatal(1,"Reset during EMIT leaked a channel");
        $display("RTL_FRAME_FLOW_PASSED");$finish;
    end
    initial begin #100000;$fatal(1,"Frame flow timeout");end
endmodule
`default_nettype wire
