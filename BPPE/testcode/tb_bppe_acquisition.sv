`timescale 1ns/1ps
`default_nettype none
module tb_bppe_acquisition;
    `include "numeric_latency_bounds.svh"
    parameter integer PROFILE=1;
    localparam integer SF=PROFILE==0?0:(PROFILE==1?8:10),TF=SF,
        CF=PROFILE==0?8:18,FF=PROFILE==0?8:(PROFILE==1?16:18),SW=26+SF,FW=4+FF;
    logic clk=0;always #5 clk=~clk;
    logic rst=1,in_valid=0,in_config_error=0,allow_output=1;
    logic [1:0] cfg_channels;
    logic [31:0] cfg_min_delta,cfg_max_delta,cfg_max_abs_skew;
    logic [CF-1:0] dc_coefficient,lowpass_coefficient;
    logic [29:0] tick_period_ns;
    logic signed [FW-1:0] min_period,max_period;
    logic signed [47:0] max_period_ticks;
    logic signed [63:0] warmup_ticks;
    wire in_ready,out_valid,out_ready,out_reject,out_history_reset,out_first,out_last;
    logic [71:0] in_adc;
    logic [95:0] in_timestamp;
    logic [2:0] in_channel_valid,in_channel_saturated;
    logic in_gain_transition;
    logic [7:0] in_gain,in_optical;
    logic [15:0] in_sequence;
    logic [31:0] in_tag;
    wire [15:0] out_reason,out_frame_faults,out_sequence,live_frame_faults;
    wire [1:0] out_channel;
    wire [23:0] out_adc;
    wire [31:0] out_timestamp,out_tag;
    wire signed [63:0] out_ticks;
    wire signed [SW-1:0] out_dc,out_filtered;
    wire signed [47:0] out_time,beat_time;
    wire out_beat_valid,tracking,numeric_fault,idle;
    wire signed [FW-1:0] features[0:4];
    wire [63:0] rejected_beats,saturation_count,divzero_count,precision_count;
    bppe_acquisition_channels #(.SIGNAL_F(SF),.COEFFICIENT_F(CF),.TIME_F(TF),.FEATURE_F(FF)) dut(.*);
    logic [63:0] w[0:73],expected[0:7][0:73];
    integer fd,got,i,j,c=0,current_case=0,cases=0,write_count=0,read_count=0;
    integer events=0,beats=0,rejections=0,watchdog,cycle=0,blocked=0,ahead_fault=0,fenced=0;
    integer accepted_cycle[0:2];
    integer frame_cycle[0:7],max_frame_latency=0;
    logic checking=1,was_blocked=0;
    logic [1023:0] held;
    string filename;
    assign out_ready=!rst && allow_output && cycle%19>=7;
    function automatic [1023:0] packet;
        packet={out_reject,out_history_reset,out_first,out_last,out_reason,out_frame_faults,out_channel,out_adc,
            out_timestamp,out_tag,out_sequence,out_ticks,out_dc,out_filtered,out_time,beat_time,out_beat_valid,
            tracking,features[0],features[1],features[2],features[3],features[4],rejected_beats,
            saturation_count,divzero_count,precision_count,numeric_fault};
    endfunction
    always @(posedge clk)begin:scoreboard
        integer s,x;
        cycle=cycle+1;
        if(rst)begin was_blocked=0;for(x=0;x<3;x=x+1)accepted_cycle[x]=-100;end
        else begin
            if(dut.ev_valid && dut.ev_ready && !dut.ev_reject)begin
                if(cycle-accepted_cycle[dut.ev_channel]<11)$fatal(1,"Core initiation interval violated");
                accepted_cycle[dut.ev_channel]=cycle;
            end
            if(was_blocked && (!out_valid || packet()!==held))$fatal(1,"Acquisition output changed under stall");
            was_blocked=out_valid && !out_ready;held=packet();
            if(was_blocked)blocked=blocked+1;
            if(out_valid && live_frame_faults!=out_frame_faults)ahead_fault=ahead_fault+1;
            if(dut.ev_valid && dut.ev_reject && !dut.ev_ready)fenced=fenced+1;
            if(checking && out_valid && out_ready)begin
                if(read_count>=write_count)$fatal(1,"Unexpected acquisition output");
                s=read_count%8;
                if(out_tag!=expected[s][21] || out_sequence!=expected[s][15] || out_reason!=expected[s][29] ||
                    out_frame_faults!=expected[s][30] || out_reject!==!expected[s][28][0] ||
                    out_history_reset!==(!expected[s][28] && expected[s][29]!=1024) || out_first!==(c==0) ||
                    out_last!==(!expected[s][28] || c==expected[s][3]-1))
                    $fatal(1,"Acquisition metadata mismatch case=%0d row=%0d",expected[s][0],expected[s][1]);
                if(!out_reject)begin
                    if(out_channel!=c || out_adc!=expected[s][22+c] || out_timestamp!=expected[s][25+c] ||
                        $signed(out_ticks)!=$signed(expected[s][32+c]) || $signed(out_dc)!=$signed(expected[s][35+c]) ||
                        $signed(out_filtered)!=$signed(expected[s][38+c]) || $signed(out_time)!=$signed(expected[s][41+c]) ||
                        tracking!==expected[s][44+c][0] || rejected_beats!=expected[s][47+c] || out_beat_valid!==expected[s][50+c][0])
                        $fatal(1,"Acquisition numerical mismatch case=%0d row=%0d channel=%0d",expected[s][0],expected[s][1],c);
                    if(out_beat_valid)begin
                        beats=beats+1;
                        for(x=0;x<5;x=x+1)if($signed(features[x])!=$signed(expected[s][53+c*5+x]))$fatal(1,"Acquisition features mismatch");
                        if($signed(beat_time)!=$signed(expected[s][68+c]))$fatal(1,"Acquisition beat time mismatch");
                    end
                end else rejections=rejections+1;
                if(out_last)begin
                    if(saturation_count!=expected[s][71] || divzero_count!=expected[s][72] || precision_count!=expected[s][73] || numeric_fault)
                        $fatal(1,"Acquisition numeric counters mismatch");
                    if(cycle-frame_cycle[s]>max_frame_latency)max_frame_latency=cycle-frame_cycle[s];
                    read_count=read_count+1;c=0;
                end else c=c+1;
                events=events+1;
            end
        end
    end
    task automatic reset_all;
        begin
            @(negedge clk);rst=1;in_valid=0;repeat(2)@(negedge clk);rst=0;
            if(out_valid || !idle || live_frame_faults!=0 || numeric_fault)$fatal(1,"Acquisition reset failed");
        end
    endtask
    task automatic drive_frame;
        begin
            in_config_error=w[14][0];in_sequence=w[15][15:0];in_gain=w[16][7:0];in_optical=w[17][7:0];
            in_gain_transition=w[18][0];in_channel_valid=w[19][2:0];in_channel_saturated=w[20][2:0];in_tag=w[21][31:0];
            for(integer x=0;x<3;x=x+1)begin in_adc[x*24+:24]=w[22+x][23:0];in_timestamp[x*32+:32]=w[25+x][31:0];end
        end
    endtask
    initial begin
        if(!$value$plusargs("VECTORS=%s",filename))$fatal(1,"Missing vectors");
        fd=$fopen(filename,"r");if(!fd)$fatal(1,"Cannot open vectors");
        while(!$feof(fd))begin
            got=0;for(i=0;i<74;i=i+1)got=got+$fscanf(fd,"%h",w[i]);
            if(got<=0 && $feof(fd))break;
            if(got!=74)$fatal(1,"Malformed acquisition record");
            if(w[2]!=PROFILE)continue;
            if(current_case!=w[0])begin
                while(read_count!=write_count || !idle)@(negedge clk);
                cfg_channels=w[3][1:0];cfg_min_delta=w[4][31:0];cfg_max_delta=w[5][31:0];cfg_max_abs_skew=w[6][31:0];
                tick_period_ns=w[7][29:0];dc_coefficient=w[8][CF-1:0];lowpass_coefficient=w[9][CF-1:0];
                min_period=w[10][FW-1:0];max_period=w[11][FW-1:0];max_period_ticks=w[12][47:0];warmup_ticks=$signed(w[13]);
                reset_all();current_case=w[0];cases=cases+1;
            end
            @(negedge clk);drive_frame();in_valid=1;watchdog=0;#1;
            while(!in_ready)begin @(negedge clk);#1;watchdog=watchdog+1;if(watchdog>3*CHANNEL_LATENCY_BOUND+128)$fatal(1,"Acquisition ingress timeout");end
            if(write_count-read_count>=8)$fatal(1,"Expected queue overflow");
            for(j=0;j<74;j=j+1)expected[write_count%8][j]=w[j];
            @(posedge clk);#1;frame_cycle[write_count%8]=cycle;write_count=write_count+1;
            @(negedge clk);in_valid=0;in_adc='1;in_timestamp='1;in_config_error=~in_config_error;
        end
        $fclose(fd);
        while(read_count!=write_count || !idle)@(negedge clk);
        if(cases!=21 || read_count!=5952 || events!=11805 || beats!=96 || rejections!=98 || blocked==0 || ahead_fault==0 || fenced==0)
            $fatal(1,"Incomplete acquisition coverage cases=%0d rows=%0d events=%0d beats=%0d rejected=%0d blocked=%0d ahead=%0d fenced=%0d",cases,read_count,events,beats,rejections,blocked,ahead_fault,fenced);
        checking=0;allow_output=0;
        // Reset during numerical work, then during a held numerical output.
        for(i=0;i<2;i=i+1)begin
            reset_all();@(negedge clk);drive_frame();in_config_error=0;in_gain_transition=0;in_channel_valid=7;in_channel_saturated=0;
            in_valid=1;@(posedge clk);#1;@(negedge clk);in_valid=0;
            if(i==0)begin while(dut.phase!=1)@(negedge clk);end
            else begin while(!out_valid)@(negedge clk);end
            reset_all();repeat(30)@(negedge clk);
            if(out_valid || !idle)$fatal(1,"Aborted acquisition work leaked");
        end
        $display("RTL_ACQUISITION_PASSED profile=%0d cases=%0d rows=%0d events=%0d beats=%0d rejected=%0d blocked=%0d ahead_fault=%0d fenced=%0d max_frame_latency=%0d",PROFILE,cases,read_count,events,beats,rejections,blocked,ahead_fault,fenced,max_frame_latency);
        $finish;
    end
    initial begin #2000000000;$fatal(1,"Acquisition suite timeout");end
endmodule
`default_nettype wire
