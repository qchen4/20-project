`timescale 1ns/1ps
`default_nettype none
module tb_bppe_beat;
    `include "numeric_latency_bounds.svh"
    parameter integer PROFILE=1;
    localparam integer SF=(PROFILE==0)?0:((PROFILE==1)?8:10);
    localparam integer TF=SF;
    localparam integer FF=(PROFILE==0)?8:((PROFILE==1)?16:18);
    localparam integer SW=26+SF,FW=4+FF,CAPACITY=304;
    logic clk=0; always #5 clk=~clk;
    logic rst=1,clear_history=0,in_valid=0,out_ready=0,in_warmup;
    wire in_ready,out_valid,beat_valid,tracking,numeric_fault;
    logic signed [SW-1:0] in_filtered,in_dc;
    logic signed [47:0] in_time,max_period_ticks;
    logic [29:0] tick_period_ns;
    logic signed [FW-1:0] min_period,max_period;
    wire signed [47:0] beat_time;
    wire signed [FW-1:0] features[0:4];
    wire [63:0] rejected_beats,saturation_count,divzero_count,precision_count;
    bppe_beat_core #(.SIGNAL_F(SF),.TIME_F(TF),.FEATURE_F(FF),.CYCLE_CAPACITY(CAPACITY)) dut(.*);
    string filename;
    integer fd,got,k,j,n,rows=0,cases=0,beats=0,stalls=0,watchdog,max_latency=0;
    logic [63:0] words[0:29],expected_t[0:CAPACITY],expected_y[0:CAPACITY];
    logic [63:0] current_case=0,expected_beat_time;

    task automatic compare_state;
        begin
            if (out_valid!==1'b1 || dut.previous_y!==words[15] || dut.previous_t!==words[16] ||
                tracking!==words[17][0] || rejected_beats!==words[18] || dut.cycle_count!=words[19] ||
                beat_valid!==words[20][0] || saturation_count!==words[26] || divzero_count!==words[27] ||
                precision_count!==words[28] || numeric_fault!==((words[26]|words[27]|words[28])!=0))
                $fatal(1,"beat state/fault mismatch profile=%0d case=%0d frame=%0d row=%0d",PROFILE,words[0],words[1],rows+1);
            for (j=0;j<5;j=j+1) if ($signed(features[j])!=$signed(words[21+j]))
                $fatal(1,"feature mismatch case=%0d frame=%0d feature=%0d got=%0d expected=%0d area_sum=%0d area_feature=%0d width=%0d period=%0d",words[0],words[1],j,$signed(features[j]),$signed(words[21+j]),dut.area_sum,dut.area_feature,dut.width_sum,dut.period);
            for (j=0;j<n;j=j+1) if (dut.cycle_t[j]!==expected_t[j] || dut.cycle_y[j]!==expected_y[j])
                $fatal(1,"cycle buffer mismatch case=%0d frame=%0d index=%0d",words[0],words[1],j);
            if (beat_valid && $signed(beat_time)!=$signed(expected_beat_time))
                $fatal(1,"beat time mismatch");
        end
    endtask

    initial begin
        if (!$value$plusargs("VECTORS=%s",filename)) $fatal(1,"Missing beat vectors");
        fd=$fopen(filename,"r"); if (fd==0) $fatal(1,"Cannot open beat vectors");
        repeat(2) @(negedge clk); rst=0;
        while (!$feof(fd)) begin
            got=$fscanf(fd,"%h",words[0]);
            if (got==1) begin
                for (k=1;k<30;k=k+1) begin
                    got=$fscanf(fd,"%h",words[k]); if(got!=1) $fatal(1,"Truncated beat record");
                end
                if (words[19]>CAPACITY) $fatal(1,"Invalid expected buffer length");
                n=integer'(words[19]);
                for (k=0;k<n;k=k+1) begin
                    got=$fscanf(fd,"%h %h",expected_t[k],expected_y[k]);
                    if (got!=2) $fatal(1,"Truncated beat buffer");
                end
                if (words[3]==SF && words[4]==TF && words[5]==FF) begin
                    if (words[0]!=current_case || words[2]!=0) begin
                        @(negedge clk); rst=(words[0]!=current_case || words[2]==2);
                        clear_history=(words[0]==current_case && words[2]==1);
                        @(negedge clk); rst=0; clear_history=0;
                        if (words[0]!=current_case) begin current_case=words[0]; cases=cases+1; end
                    end
                    in_filtered=words[11][SW-1:0]; in_dc=words[12][SW-1:0]; in_time=words[13][47:0];
                    in_warmup=words[14][0]; tick_period_ns=words[6][29:0]; min_period=words[7][FW-1:0];
                    max_period=words[8][FW-1:0]; max_period_ticks=words[9][47:0];
                    if (words[10]!=CAPACITY) $fatal(1,"Capacity/config mismatch");
                    in_valid=1; out_ready=0;
                    watchdog=0;
                    do begin
                        @(posedge clk); watchdog=watchdog+1;
                        if (watchdog>BEAT_LATENCY_BOUND) $fatal(1,"Beat input ready timeout");
                    end while (!in_ready);
                    @(negedge clk); in_valid=0;
                    watchdog=0;
                    while (!out_valid) begin
                        @(negedge clk); watchdog=watchdog+1;
                        if (watchdog>BEAT_LATENCY_BOUND) $fatal(1,"Beat processing timeout");
                    end
                    if(watchdog>max_latency)max_latency=watchdog;
                    expected_beat_time=words[29];
                    compare_state();
                    if (rows%7==0) begin
                        // Adversarial valid input cannot be consumed under backpressure.
                        in_valid=1; in_filtered='1; in_dc='1; in_time='1;
                        repeat(3) begin
                            @(negedge clk); if(in_ready) $fatal(1,"Input accepted under blocked output");
                            compare_state();
                        end
                        in_valid=0; stalls=stalls+1;
                    end
                    out_ready=1; @(negedge clk); out_ready=0;
                    rows=rows+1; if(words[20]!=0) beats=beats+1;
                end
            end else if (!$feof(fd)) $fatal(1,"Malformed beat vectors");
        end
        $fclose(fd);
        if(rows!=13040 || cases!=14 || beats==0 || stalls==0) $fatal(1,"Incomplete beat suite");
        $display("RTL_BEAT_PASSED profile=%0d rows=%0d cases=%0d beats=%0d stalls=%0d max_latency=%0d",PROFILE,rows,cases,beats,stalls,max_latency);
        $finish;
    end
    initial begin #100000000; $fatal(1,"Global beat watchdog"); end
endmodule
`default_nettype wire
