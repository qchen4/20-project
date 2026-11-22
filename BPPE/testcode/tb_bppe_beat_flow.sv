`timescale 1ns/1ps
`default_nettype none
module tb_bppe_beat_flow;
    `include "numeric_latency_bounds.svh"
    parameter integer PROFILE=1;
    localparam integer SF=(PROFILE==0)?0:((PROFILE==1)?8:10),TF=SF;
    localparam integer FF=(PROFILE==0)?8:((PROFILE==1)?16:18),SW=26+SF,FW=4+FF;
    localparam signed [63:0] SCALE=64'sd1<<FF;
    logic clk=0; always #5 clk=~clk;
    logic rst=1,clear_history=0,in_valid=0,out_ready=0,in_warmup=0;
    wire in_ready,out_valid,beat_valid,tracking,numeric_fault;
    logic signed [SW-1:0] in_filtered=0,in_dc=10000<<SF;
    logic signed [47:0] in_time=0,max_period_ticks=1500<<TF;
    logic [29:0] tick_period_ns=1000000;
    logic signed [FW-1:0] min_period=(35*SCALE+50)/100,max_period=3*SCALE/2;
    wire signed [47:0] beat_time;
    wire signed [FW-1:0] features[0:4];
    wire [63:0] rejected_beats,saturation_count,divzero_count,precision_count;
    bppe_beat_core #(.SIGNAL_F(SF),.TIME_F(TF),.FEATURE_F(FF)) dut(.*);
    integer wait_cycles,i,reset_stage;
    integer reset_targets[0:12];
    logic signed [63:0] expected_period,expected_rise,expected_width;
    task automatic accept(input logic signed [63:0] y,t);
        begin
            @(negedge clk); in_filtered=y<<SF; in_time=t; in_valid=1;
            do @(posedge clk); while(!in_ready);
            @(negedge clk); in_valid=0;
        end
    endtask
    task automatic drain;
        begin
            wait_cycles=0;
            while(!out_valid) begin @(negedge clk); wait_cycles=wait_cycles+1; if(wait_cycles>BEAT_LATENCY_BOUND) $fatal(1,"Flow timeout"); end
            out_ready=1; @(negedge clk); out_ready=0;
        end
    endtask
    task automatic triangle_prefix;
        begin
            accept(0,0); drain(); accept(100,200<<TF); drain(); accept(0,400<<TF); drain();
            accept(-100,600<<TF); drain(); accept(0,800<<TF); drain();
        end
    endtask
    initial begin
        repeat(2) @(negedge clk); rst=0;
        triangle_prefix(); accept(100,1000<<TF);
        wait_cycles=0;
        while(dut.phase!=dut.SCAN) begin
            @(negedge clk); wait_cycles=wait_cycles+1;
            if(wait_cycles>BEAT_LATENCY_BOUND) $fatal(1,"Scan entry timeout");
        end
        if(in_ready || out_valid) $fatal(1,"Engine did not enter multi-cycle scan");
        rst=1; @(negedge clk); rst=0;
        if(out_valid || tracking || dut.cycle_count!=0 || numeric_fault) $fatal(1,"Reset failed during scan");
        triangle_prefix(); accept(100,1000<<TF);
        // Change inputs and configuration while the engine owns the sample.
        in_valid=1; in_filtered=-1; in_dc=0; in_time=-1; tick_period_ns=0; min_period=0; max_period=0; max_period_ticks=0;
        while(!out_valid) begin @(negedge clk); if(in_ready) $fatal(1,"Accepted extra sample while busy"); end
        if(!beat_valid || beat_time!=(800<<TF) || $signed(features[0])!=(4*SCALE+2)/5 ||
            $signed(features[1])!=SCALE/4 || $signed(features[2])!=SCALE/4 ||
            $signed(features[3])!=SCALE/4 || $signed(features[4])!=(SCALE+25)/50 || numeric_fault)
            $fatal(1,"Hand-computed triangular features or latched configuration mismatch");
        repeat(7) begin @(negedge clk); if(in_ready || !out_valid || !beat_valid) $fatal(1,"Blocked beat lost"); end
        rst=1; @(negedge clk); rst=0; in_valid=0;
        if(out_valid || beat_valid || tracking) $fatal(1,"Reset failed with blocked output");
        in_dc=10000<<SF; tick_period_ns=1000000; min_period=(35*SCALE+50)/100; max_period=3*SCALE/2; max_period_ticks=1500<<TF;
        accept(-1000,0); drain(); accept(1000,(64'sd1<<47)-1); drain();
        if(precision_count!=1 || !numeric_fault || tracking || rejected_beats!=1) $fatal(1,"Precision guard/recovery mismatch");
        clear_history=1; @(negedge clk); clear_history=0;
        if(precision_count!=1 || !numeric_fault || tracking || rejected_beats!=0) $fatal(1,"History clear lost numeric fault");
        rst=1; @(negedge clk); rst=0;
        if(numeric_fault) $fatal(1,"Reset did not clear numeric fault");
        // Abort a healthy division at every continuation, then verify that
        // neither the result nor its fault deltas leak into the next history.
        for(reset_stage=6;reset_stage<=12;reset_stage=reset_stage+1) begin
            triangle_prefix(); accept(100,1000<<TF); wait_cycles=0;
            while(!(dut.divider.phase==dut.divider.ITERATE && dut.division_resume==reset_stage)) begin
                @(negedge clk); wait_cycles=wait_cycles+1;
                if(wait_cycles>BEAT_LATENCY_BOUND) $fatal(1,"Division stage reset coverage timeout");
            end
            repeat(9) @(negedge clk);
            rst=1; @(negedge clk); rst=0;
            repeat(60) begin
                @(negedge clk);
                if(out_valid || beat_valid || tracking || numeric_fault || !in_ready)
                    $fatal(1,"Aborted beat division leaked stage=%0d",reset_stage);
            end
        end
        // Abort guarded product work, synchronous RAM reads, and the first
        // half of a two-write restart. Stale RAM contents must remain fenced.
        reset_targets[0]=dut.MUL_REQUEST;reset_targets[1]=dut.MUL_WAIT;
        reset_targets[2]=dut.CROSS_PRODUCT;reset_targets[3]=dut.PERIOD_PRODUCT;
        reset_targets[4]=dut.PERIOD_SCALE;reset_targets[5]=dut.RISE_PRODUCT;
        reset_targets[6]=dut.NORM_PRODUCT;reset_targets[7]=dut.WIDTH_PRODUCT;
        reset_targets[8]=dut.AREA_PRODUCT;reset_targets[9]=dut.AMP_PRODUCT;
        reset_targets[10]=dut.SCAN_EVAL;reset_targets[11]=dut.NORM_PREP;
        reset_targets[12]=dut.RESTART_SAMPLE;
        for(i=0;i<13;i=i+1)begin
            triangle_prefix();accept(100,1000<<TF);wait_cycles=0;
            while(dut.phase!=reset_targets[i])begin
                @(negedge clk);wait_cycles=wait_cycles+1;
                if(wait_cycles>BEAT_LATENCY_BOUND)$fatal(1,"Product/RAM reset target not reached");
            end
            rst=1;@(negedge clk);rst=0;
            repeat(60)begin
                @(negedge clk);
                if(out_valid || beat_valid || tracking || numeric_fault || !in_ready)
                    $fatal(1,"Aborted product/RAM work leaked target=%0d",reset_targets[i]);
            end
        end
        // Fill all 304 permitted samples and close into the extra 305th slot.
        // A rectangular positive/negative wave has hand-derived raw-code
        // features, independent of the implementation's iteration schedule.
        accept(0,0); drain();
        for(i=1;i<304;i=i+1) begin accept(i<152?100:-100,(i*4)<<TF); drain(); end
        accept(100,1216<<TF); wait_cycles=0;
        while(!out_valid) begin
            @(negedge clk); wait_cycles=wait_cycles+1;
            if(wait_cycles>BEAT_LATENCY_BOUND) $fatal(1,"Maximum-capacity beat timeout");
        end
        expected_period=(1214*SCALE+500)/1000;
        expected_rise=(4*SCALE+607)/1214;
        expected_width=(1208*SCALE+1214)/2428;
        if(!beat_valid || beat_time!=(1214<<TF) || dut.complete_count!=305 ||
            $signed(features[0])!=expected_period || $signed(features[1])!=expected_rise ||
            $signed(features[2])!=expected_width || $signed(features[3])!=expected_width ||
            $signed(features[4])!=(SCALE+25)/50 || numeric_fault || dut.cycle_count!=2)
            $fatal(1,"Maximum-capacity feature/counter/buffer mismatch");
        $display("RTL_BEAT_CAPACITY_PASSED profile=%0d completed_slots=%0d latency=%0d",PROFILE,dut.complete_count,wait_cycles);
        drain();
        $display("RTL_BEAT_FLOW_PASSED profile=%0d reset_division_stages=7 reset_product_ram_stages=13",PROFILE); $finish;
    end
    initial begin #10000000; $fatal(1,"Flow watchdog"); end
endmodule
`default_nettype wire
