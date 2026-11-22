`timescale 1ns/1ps
`default_nettype none
module tb_bppe_channel;
    `include "numeric_latency_bounds.svh"
    parameter integer PROFILE=1;
    localparam integer SF=(PROFILE==0)?0:((PROFILE==1)?8:10),TF=SF;
    localparam integer CF=(PROFILE==0)?8:18,FF=(PROFILE==0)?8:((PROFILE==1)?16:18);
    localparam integer SW=26+SF,FW=4+FF,CAPACITY=304;
    logic clk=0; always #5 clk=~clk;
    logic rst=1,clear_history=0,in_valid=0,out_ready=0,in_warmup;
    wire in_ready,out_valid,out_beat_valid,tracking,out_numeric_fault,numeric_fault,idle;
    logic [23:0] in_adc;
    logic signed [63:0] in_ticks;
    logic [31:0] in_tag;
    logic [CF-1:0] dc_coefficient,lowpass_coefficient;
    logic [29:0] tick_period_ns;
    logic signed [FW-1:0] min_period,max_period;
    logic signed [47:0] max_period_ticks;
    wire [31:0] out_tag;
    wire out_warmup;
    wire signed [SW-1:0] out_dc,out_filtered;
    wire signed [47:0] out_time,beat_time;
    wire signed [FW-1:0] features[0:4];
    wire [63:0] rejected_beats,out_saturation_count,out_divzero_count,out_precision_count;
    bppe_channel_core #(.SIGNAL_F(SF),.COEFFICIENT_F(CF),.TIME_F(TF),.FEATURE_F(FF)) dut(.*);
    string filename;
    integer fd,got,k,n,slot,watchdog,current_case=0,cases=0;
    integer queued=0,consumed=0,accepted=0,emitted=0,blocked=0,simultaneous=0,clock_count=0,max_occupancy=0;
    logic [63:0] words[0:33],buffer_t[0:CAPACITY],buffer_y[0:CAPACITY];
    logic [63:0] expected[0:3][0:33],expected_t[0:3][0:CAPACITY],expected_y[0:3][0:CAPACITY];
    logic was_blocked=0;
    logic [1023:0] held_packet;
    function automatic [1023:0] packet;
        packet={out_tag,out_warmup,out_dc,out_filtered,out_time,out_beat_valid,beat_time,
            features[0],features[1],features[2],features[3],features[4],tracking,rejected_beats,
            out_saturation_count,out_divzero_count,out_precision_count,out_numeric_fault};
    endfunction
    always @(negedge clk) begin
        clock_count=clock_count+1;
        out_ready=!rst && (clock_count%13>=4);
    end
    always @(posedge clk) begin : scoreboard
        integer s,j,length;
        logic [31:0] tag;
        if (rst || clear_history) was_blocked=0;
        else begin
            if (was_blocked && (!out_valid || packet()!==held_packet)) $fatal(1,"Blocked pipeline output changed");
            was_blocked=out_valid && !out_ready;
            if (was_blocked) begin held_packet=packet(); blocked=blocked+1; end
            if (dut.in_flight>max_occupancy) max_occupancy=dut.in_flight;
            if (in_valid && in_ready) accepted=accepted+1;
            if (in_valid && in_ready && out_valid && out_ready) simultaneous=simultaneous+1;
            if (out_valid && out_ready) begin
                if(consumed>=queued) $fatal(1,"Unexpected/duplicate pipeline output");
                s=consumed%4; tag=32'(expected[s][0]*65536+expected[s][1]);
                if (out_tag!==tag || out_warmup!==expected[s][15][0] || $signed(out_dc)!=$signed(expected[s][16]) ||
                    $signed(out_filtered)!=$signed(expected[s][17]) || $signed(out_time)!=$signed(expected[s][18]) ||
                    dut.beat.previous_y!==expected[s][19] || dut.beat.previous_t!==expected[s][20] ||
                    tracking!==expected[s][21][0] || rejected_beats!==expected[s][22] ||
                    dut.beat.cycle_count!=expected[s][23] || out_beat_valid!==expected[s][24][0] ||
                    $signed(beat_time)!=$signed(expected[s][30]) || out_saturation_count!==expected[s][31] ||
                    out_divzero_count!==expected[s][32] || out_precision_count!==expected[s][33] ||
                    out_numeric_fault!==((expected[s][31]|expected[s][32]|expected[s][33])!=0))
                    $fatal(1,"Pipeline state/metadata/fault mismatch profile=%0d case=%0d frame=%0d output=%0d",PROFILE,expected[s][0],expected[s][1],consumed+1);
                for(j=0;j<5;j=j+1) if($signed(features[j])!=$signed(expected[s][25+j]))
                    $fatal(1,"Pipeline feature mismatch case=%0d frame=%0d feature=%0d",expected[s][0],expected[s][1],j);
                length=integer'(expected[s][23]);
                for(j=0;j<length;j=j+1) if(dut.beat.cycle_t[j]!==expected_t[s][j] || dut.beat.cycle_y[j]!==expected_y[s][j])
                    $fatal(1,"Pipeline cycle buffer mismatch case=%0d frame=%0d index=%0d",expected[s][0],expected[s][1],j);
                if(out_beat_valid) emitted=emitted+1;
                consumed=consumed+1;
            end
        end
    end
    task automatic drain;
        begin
            watchdog=0;
            while(consumed!=queued || !idle) begin
                @(negedge clk); watchdog=watchdog+1;
                if(watchdog>2*CHANNEL_LATENCY_BOUND+32) $fatal(1,"Pipeline drain timeout");
            end
        end
    endtask
    initial begin
        if(!$value$plusargs("VECTORS=%s",filename)) $fatal(1,"Missing pipeline vectors");
        fd=$fopen(filename,"r"); if(fd==0) $fatal(1,"Cannot open pipeline vectors");
        repeat(2) @(negedge clk); rst=0;
        while(!$feof(fd)) begin
            got=$fscanf(fd,"%h",words[0]);
            if(got==1) begin
                for(k=1;k<34;k=k+1) begin got=$fscanf(fd,"%h",words[k]); if(got!=1) $fatal(1,"Truncated pipeline vector"); end
                if(words[23]>CAPACITY) $fatal(1,"Invalid pipeline buffer size");
                n=integer'(words[23]);
                for(k=0;k<n;k=k+1) begin got=$fscanf(fd,"%h %h",buffer_t[k],buffer_y[k]); if(got!=2) $fatal(1,"Truncated pipeline buffer"); end
                if(words[3]==SF && words[4]==TF && words[5]==FF) begin
                    if(words[0]!=current_case || words[2]!=0) begin
                        drain(); @(negedge clk);
                        rst=(words[0]!=current_case || words[2]==2);
                        clear_history=(words[0]==current_case && words[2]==1);
                        @(negedge clk); rst=0; clear_history=0;
                        if(words[0]!=current_case) begin current_case=integer'(words[0]); cases=cases+1; end
                    end
                    while(queued-consumed>=4) @(negedge clk);
                    slot=queued%4;
                    for(k=0;k<34;k=k+1) expected[slot][k]=words[k];
                    for(k=0;k<n;k=k+1) begin expected_t[slot][k]=buffer_t[k]; expected_y[slot][k]=buffer_y[k]; end
                    queued=queued+1;
                    repeat(words[1]%3) @(negedge clk);
                    in_adc=words[13][23:0]; in_ticks=$signed(words[14]); in_tag=32'(words[0]*65536+words[1]);
                    in_warmup=words[15][0]; dc_coefficient=words[6][CF-1:0]; lowpass_coefficient=words[7][CF-1:0];
                    tick_period_ns=words[8][29:0]; min_period=words[9][FW-1:0]; max_period=words[10][FW-1:0]; max_period_ticks=words[11][47:0];
                    if(words[12]!=CAPACITY) $fatal(1,"Pipeline capacity mismatch");
                    in_valid=1; watchdog=0;
                    do begin @(posedge clk); watchdog=watchdog+1; if(watchdog>2*CHANNEL_LATENCY_BOUND+32) $fatal(1,"Pipeline ready timeout"); end while(!in_ready);
                    @(negedge clk); in_valid=0;
                end
            end else if(!$feof(fd)) $fatal(1,"Malformed pipeline vectors");
        end
        $fclose(fd); drain();
        if(accepted!=6508 || consumed!=accepted || queued!=accepted || cases!=10 || emitted==0 || blocked==0 || simultaneous==0 || max_occupancy!=2)
            $fatal(1,"Incomplete pipeline suite accepted=%0d consumed=%0d cases=%0d beats=%0d simultaneous=%0d occupancy=%0d",accepted,consumed,cases,emitted,simultaneous,max_occupancy);
        $display("RTL_CHANNEL_PASSED profile=%0d rows=%0d cases=%0d beats=%0d blocked=%0d simultaneous=%0d occupancy=%0d",PROFILE,consumed,cases,emitted,blocked,simultaneous,max_occupancy);
        $finish;
    end
    initial begin #100000000; $fatal(1,"Pipeline global watchdog"); end
endmodule
`default_nettype wire
