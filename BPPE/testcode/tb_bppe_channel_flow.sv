`timescale 1ns/1ps
`default_nettype none
module tb_bppe_channel_flow;
    `include "numeric_latency_bounds.svh"
    parameter integer PROFILE=1;
    localparam integer SF=(PROFILE==0)?0:((PROFILE==1)?8:10),TF=SF;
    localparam integer CF=(PROFILE==0)?8:18,FF=(PROFILE==0)?8:((PROFILE==1)?16:18);
    localparam integer SW=26+SF,FW=4+FF;
    logic clk=0; always #5 clk=~clk;
    logic rst=1,clear_history=0,in_valid=0,out_ready=0,in_warmup=0;
    wire in_ready,out_valid,out_beat_valid,tracking,out_numeric_fault,numeric_fault,idle;
    logic [23:0] in_adc=0;
    logic signed [63:0] in_ticks=0;
    logic [31:0] in_tag=0;
    logic [CF-1:0] dc_coefficient=0,lowpass_coefficient=0;
    logic [29:0] tick_period_ns=1000000;
    logic signed [FW-1:0] min_period=(35*(64'sd1<<FF)+50)/100,max_period=3*(64'sd1<<FF)/2;
    logic signed [47:0] max_period_ticks=1500<<TF;
    wire [31:0] out_tag;
    wire out_warmup;
    wire signed [SW-1:0] out_dc,out_filtered;
    wire signed [47:0] out_time,beat_time;
    wire signed [FW-1:0] features[0:4];
    wire [63:0] rejected_beats,out_saturation_count,out_divzero_count,out_precision_count;
    bppe_channel_core #(.SIGNAL_F(SF),.COEFFICIENT_F(CF),.TIME_F(TF),.FEATURE_F(FF)) dut(.*);
    integer watchdog,k;
    logic found;
    task automatic send(input logic [23:0] adc,input logic signed [63:0] ticks,input logic [31:0] tag,input logic warmup);
        begin
            @(negedge clk); in_adc=adc; in_ticks=ticks; in_tag=tag; in_warmup=warmup; in_valid=1;
            watchdog=0;
            do begin @(posedge clk); watchdog=watchdog+1; if(watchdog>2*CHANNEL_LATENCY_BOUND+32) $fatal(1,"Flow input timeout"); end while(!in_ready);
            @(negedge clk); in_valid=0;
        end
    endtask
    task automatic await_output;
        begin
            watchdog=0;
            while(!out_valid) begin @(negedge clk); watchdog=watchdog+1; if(watchdog>2*CHANNEL_LATENCY_BOUND+32) $fatal(1,"Flow output timeout"); end
        end
    endtask
    task automatic consume;
        begin await_output(); out_ready=1; @(negedge clk); out_ready=0; end
    endtask
    initial begin
        repeat(2) @(negedge clk); rst=0;
        send(0,0,11,1); send(0,64'sd9007199254740992,22,0); await_output();
        watchdog=0;
        while(!numeric_fault)begin @(negedge clk);watchdog=watchdog+1;if(watchdog>32)$fatal(1,"Prefetched arithmetic did not complete");end
        if(out_tag!=11 || !out_warmup || out_precision_count!=0 || out_numeric_fault || !numeric_fault || dut.in_flight!=2)
            $fatal(1,"Prefetched fault contaminated previous output or metadata");
        repeat(5) begin @(negedge clk); if(out_tag!=11 || out_precision_count!=0 || !numeric_fault || in_ready) $fatal(1,"Blocked snapshot changed"); end
        consume(); await_output();
        if(out_tag!=22 || out_warmup || out_precision_count!=1 || !out_numeric_fault || !numeric_fault)
            $fatal(1,"Fault snapshot did not follow its sample");
        consume();
        if(!idle) $fatal(1,"Pipeline did not drain");
        clear_history=1; @(negedge clk); clear_history=0;
        if(!numeric_fault || out_precision_count!=1 || !idle) $fatal(1,"History clear lost fault");
        rst=1; @(negedge clk); rst=0;
        if(numeric_fault || !idle || out_valid) $fatal(1,"Reset failed to clear fault");
        send(1000,0,33,0); send(2000,10,44,1); await_output();
        if(dut.in_flight!=2) $fatal(1,"Expected two occupied stages");
        rst=1; @(negedge clk); rst=0;
        if(!idle || out_valid || dut.pre_valid || numeric_fault) $fatal(1,"Reset did not flush both stages");
        send(123,10,99,0); await_output();
        if(out_tag!=99 || out_dc!=(123<<SF) || out_filtered!=0 || out_time!=(10<<TF) || out_warmup || out_numeric_fault)
            $fatal(1,"Post-reset sample identity/state mismatch");
        consume();
        // Force a feature scan while another ADC sample occupies the elastic slot.
        rst=1; @(negedge clk); rst=0;
        dc_coefficient=1<<(CF-1); lowpass_coefficient=1<<(CF-1); out_ready=1; found=0;
        for(k=0;k<200 && !found;k=k+1) begin
            send((k%40<20)?24'd11000:24'd9000,k*20,32'(k+200),0);
            if(dut.beat.phase!=0) found=1;
        end
        if(!found || dut.in_flight!=2) $fatal(1,"Did not exercise scan plus another accepted sample");
        out_ready=0; rst=1; @(negedge clk); rst=0;
        if(!idle || out_valid || dut.pre_valid || tracking) $fatal(1,"Reset during scan left queued work");
        send(777,0,1234,1); await_output();
        if(out_tag!=1234 || out_dc!=(777<<SF) || out_filtered!=0 || !out_warmup || out_numeric_fault)
            $fatal(1,"Recovery after pipeline scan reset failed");
        consume();
        if(!idle) $fatal(1,"Final pipeline output duplicated");
        $display("RTL_CHANNEL_FLOW_PASSED profile=%0d",PROFILE); $finish;
    end
    initial begin #1000000; $fatal(1,"Flow global watchdog"); end
endmodule
`default_nettype wire
