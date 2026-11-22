`timescale 1ns/1ps
`default_nettype none
// Integration fixture: ordered acquisition events drive three independent
// channel histories. It serializes numerical completion before the next event
// and drains all older work before a rejection's history clear.
module tb_bppe_frames;
    `include "numeric_latency_bounds.svh"
    parameter integer PROFILE=1;
    localparam integer SF=PROFILE==0?0:(PROFILE==1?8:10),TF=SF,
        CF=PROFILE==0?8:18,FF=PROFILE==0?8:(PROFILE==1?16:18),SW=26+SF,FW=4+FF;
    logic clk=0;always #5 clk=~clk;
    logic rst=1;
    logic [1:0] cfg_channels;
    logic [31:0] cfg_min_delta,cfg_max_delta,cfg_max_abs_skew;
    logic in_valid=0,in_config_error=0;
    wire in_ready,out_valid,out_ready,out_reject,out_history_reset,out_first,out_last,idle;
    logic [71:0] in_adc;
    logic [95:0] in_timestamp;
    logic [2:0] in_channel_valid,in_channel_saturated;
    logic in_gain_transition;
    logic [7:0] in_gain,in_optical;
    logic [15:0] in_sequence;
    logic [31:0] in_tag;
    wire [15:0] out_reason,out_frame_faults,frame_faults,out_sequence;
    wire [1:0] out_channel;
    wire [23:0] out_adc;
    wire [31:0] out_timestamp,out_tag;
    wire signed [63:0] out_ticks;
    bppe_frame_dispatch dut(.*);
    logic enable_consumer=0,clear_channels=0;
    logic [2:0] take_output=0;
    wire [2:0] core_ready,core_valid,core_idle,beat_valid,tracking,numeric_fault;
    wire signed [SW-1:0] dc[0:2],filtered[0:2];
    wire signed [47:0] sample_time[0:2],beat_time[0:2];
    wire signed [FW-1:0] features[0:2][0:4];
    wire [63:0] rejected_beats[0:2],sat[0:2],divzero[0:2],precision[0:2];
    logic [CF-1:0] dc_coefficient,lowpass_coefficient;
    logic [29:0] tick_period_ns;
    logic signed [FW-1:0] min_period,max_period;
    logic signed [47:0] max_period_ticks;
    logic [63:0] warmup_ticks;
    assign out_ready=enable_consumer && (out_reject?(&core_idle):core_ready[out_channel]);
    for(genvar g=0;g<3;g=g+1)begin:channels
        bppe_channel_core #(.SIGNAL_F(SF),.COEFFICIENT_F(CF),.TIME_F(TF),.FEATURE_F(FF)) core(
            .clk(clk),.rst(rst),.clear_history(clear_channels),
            .in_valid(out_valid && !out_reject && out_channel==g && enable_consumer),.in_ready(core_ready[g]),
            .in_adc(out_adc),.in_ticks(out_ticks),.in_tag(out_tag),.in_warmup($signed(out_ticks)<$signed(warmup_ticks)),
            .dc_coefficient(dc_coefficient),.lowpass_coefficient(lowpass_coefficient),
            .tick_period_ns(tick_period_ns),.min_period(min_period),.max_period(max_period),.max_period_ticks(max_period_ticks),
            .out_valid(core_valid[g]),.out_ready(take_output[g]),.out_tag(),.out_warmup(),
            .out_dc(dc[g]),.out_filtered(filtered[g]),.out_time(sample_time[g]),.out_beat_valid(beat_valid[g]),
            .beat_time(beat_time[g]),.features(features[g]),.tracking(tracking[g]),.rejected_beats(rejected_beats[g]),
            .out_saturation_count(sat[g]),.out_divzero_count(divzero[g]),.out_precision_count(precision[g]),
            .out_numeric_fault(),.numeric_fault(numeric_fault[g]),.idle(core_idle[g]));
    end
    logic [63:0] w[0:73];
    integer fd,got,i,c,j,watchdog,current_case=0,cases=0,rows=0,accepted=0,rejections=0,events=0,beats=0;
    integer last_accept_cycle[0:2],cycle=0,max_latency=0,start_cycle,frame_start,max_frame_cycles=0;
    string filename;
    logic [511:0] held;
    function automatic [511:0] packet;
        packet={out_reject,out_history_reset,out_first,out_last,out_reason,out_frame_faults,
            out_channel,out_adc,out_timestamp,out_tag,out_sequence,out_ticks};
    endfunction
    always @(posedge clk)begin
        cycle=cycle+1;
        if(!rst && out_valid && out_ready && !out_reject)begin
            if(cycle-last_accept_cycle[out_channel]<11)$fatal(1,"Numerical acceptance interval below staged-core bound");
            last_accept_cycle[out_channel]=cycle;
        end
    end
    task automatic reset_all;
        begin
            @(negedge clk);rst=1;in_valid=0;enable_consumer=0;take_output=0;clear_channels=0;
            repeat(2)@(negedge clk);
            if(out_valid || in_ready || core_valid!=0 || core_idle!=3'b111 || frame_faults!=0)
                $fatal(1,"Combined reset failed");
            rst=0;for(integer x=0;x<3;x=x+1)last_accept_cycle[x]=-100;
        end
    endtask
    task automatic drive_frame;
        begin
            in_config_error=w[14][0];in_sequence=w[15][15:0];in_gain=w[16][7:0];in_optical=w[17][7:0];
            in_gain_transition=w[18][0];in_channel_valid=w[19][2:0];in_channel_saturated=w[20][2:0];in_tag=w[21][31:0];
            for(integer x=0;x<3;x=x+1)begin in_adc[x*24+:24]=w[22+x][23:0];in_timestamp[x*32+:32]=w[25+x][31:0];end
        end
    endtask
    task automatic compare_history(input integer x);
        begin
            if($signed(dc[x])!=$signed(w[35+x]) || $signed(filtered[x])!=$signed(w[38+x]) ||
                $signed(sample_time[x])!=$signed(w[41+x]) || tracking[x]!==w[44+x][0] || rejected_beats[x]!=w[47+x])
                $fatal(1,"Channel history mismatch case=%0d row=%0d channel=%0d",w[0],w[1],x);
        end
    endtask
    initial begin
        if(!$value$plusargs("VECTORS=%s",filename))$fatal(1,"Missing vectors");
        fd=$fopen(filename,"r");if(!fd)$fatal(1,"Cannot open vectors");
        while(!$feof(fd))begin
            got=0;for(i=0;i<74;i=i+1)got=got+$fscanf(fd,"%h",w[i]);
            if(got<=0 && $feof(fd))break;
            if(got!=74)$fatal(1,"Malformed frame vector row");
            if(w[2]!=PROFILE)continue;
            cfg_channels=w[3][1:0];cfg_min_delta=w[4][31:0];cfg_max_delta=w[5][31:0];cfg_max_abs_skew=w[6][31:0];
            tick_period_ns=w[7][29:0];dc_coefficient=w[8][CF-1:0];lowpass_coefficient=w[9][CF-1:0];
            min_period=w[10][FW-1:0];max_period=w[11][FW-1:0];max_period_ticks=w[12][47:0];warmup_ticks=w[13];
            if(current_case!=w[0])begin reset_all();current_case=w[0];cases=cases+1;end
            @(negedge clk);drive_frame();in_valid=1;watchdog=0;
            while(!in_ready)begin @(negedge clk);watchdog=watchdog+1;if(watchdog>100)$fatal(1,"Ingress stalled");end
            @(posedge clk);#1;frame_start=cycle;@(negedge clk);in_valid=0;in_adc='1;in_timestamp='1;in_config_error=~in_config_error;
            watchdog=0;
            while(!out_valid)begin @(negedge clk);watchdog=watchdog+1;if(watchdog>10)$fatal(1,"Validation stalled");end
            if(out_frame_faults!=w[30] || out_reason!=w[29] || out_reject!==!w[28][0])
                $fatal(1,"Frame decision mismatch case=%0d row=%0d expected=%0d actual=%0d",w[0],w[1],w[29],out_reason);
            for(c=0;c<(w[28]?cfg_channels:1);c=c+1)begin
                if(!out_valid || out_tag!=w[21] || out_sequence!=w[15] || out_first!==(c==0) || out_last!==(!w[28] || c==cfg_channels-1))
                    $fatal(1,"Event ordering/tag mismatch");
                if(w[28] && (out_channel!=c || out_adc!=w[22+c] || out_timestamp!=w[25+c] || $signed(out_ticks)!=$signed(w[32+c])))
                    $fatal(1,"Accepted channel metadata mismatch");
                held=packet();in_valid=1; // Poisoned next frame must not enter a busy adapter.
                repeat(3)begin @(posedge clk);#1;if(packet()!==held || !out_valid || in_ready)$fatal(1,"Held event changed");end
                @(negedge clk);in_valid=0;
                if(!w[28])begin
                    if(out_history_reset!==(w[29]!=1024))$fatal(1,"Wrong history-clear policy");
                    if(core_idle!=3'b111)$fatal(1,"Rejection overtook numerical work");
                    clear_channels=out_history_reset;enable_consumer=1;
                    @(posedge clk);#1;@(negedge clk);enable_consumer=0;clear_channels=0;
                end else begin
                    enable_consumer=1;watchdog=0;start_cycle=cycle;#1;
                    while(!out_ready)begin @(negedge clk);#1;watchdog=watchdog+1;if(watchdog>100)$fatal(1,"Channel not ready");end
                    @(posedge clk);#1;@(negedge clk);enable_consumer=0;watchdog=0;
                    while(!core_valid[c])begin @(negedge clk);watchdog=watchdog+1;if(watchdog>CHANNEL_LATENCY_BOUND)$fatal(1,"Channel processing stalled");end
                    if(cycle-start_cycle>max_latency)max_latency=cycle-start_cycle;
                    compare_history(c);
                    if(beat_valid[c]!==w[50+c][0])$fatal(1,"Beat-valid mismatch");
                    if(beat_valid[c])begin
                        beats=beats+1;
                        for(j=0;j<5;j=j+1)if($signed(features[c][j])!=$signed(w[53+c*5+j]))$fatal(1,"Beat feature mismatch");
                        if($signed(beat_time[c])!=$signed(w[68+c]))$fatal(1,"Beat time mismatch");
                    end
                    repeat(2)begin @(negedge clk);compare_history(c);if(!core_valid[c])$fatal(1,"Lost blocked numerical output");end
                    take_output[c]=1;@(posedge clk);#1;@(negedge clk);take_output=0;
                end
                events=events+1;
            end
            for(c=0;c<cfg_channels;c=c+1)compare_history(c);
            if((sat[0]+sat[1]+sat[2])!=w[71] || (divzero[0]+divzero[1]+divzero[2])!=w[72] ||
                (precision[0]+precision[1]+precision[2])!=w[73] || numeric_fault!=0)$fatal(1,"Unexpected numerical fault");
            if(!idle || core_idle!=3'b111)$fatal(1,"Frame did not drain");
            if(cycle-frame_start>max_frame_cycles)max_frame_cycles=cycle-frame_start;
            rows=rows+1;if(w[28])accepted=accepted+1;else rejections=rejections+1;
        end
        $fclose(fd);
        if(cases!=21 || rows!=5952 || beats==0 || rejections==0)$fatal(1,"Incomplete frame coverage");
        // Coordinated reset aborts a partial frame and active preprocessing.
        reset_all();@(negedge clk);drive_frame();in_config_error=0;in_gain_transition=0;in_channel_valid=3'b111;in_channel_saturated=0;
        in_valid=1;@(posedge clk);#1;@(negedge clk);in_valid=0;
        while(!out_valid)@(negedge clk);
        enable_consumer=1;@(posedge clk);#1;@(negedge clk);enable_consumer=0;
        if(core_idle[0])$fatal(1,"Expected active numerical operation before reset");
        reset_all();repeat(20)@(negedge clk);
        if(out_valid || core_valid!=0 || core_idle!=3'b111)$fatal(1,"Aborted partial frame leaked");
        $display("RTL_FRAMES_PASSED profile=%0d cases=%0d rows=%0d accepted=%0d rejected=%0d events=%0d beats=%0d max_latency=%0d max_frame_cycles=%0d",PROFILE,cases,rows,accepted,rejections,events,beats,max_latency,max_frame_cycles);
        $finish;
    end
    initial begin #2000000000;$fatal(1,"Frame suite timeout");end
endmodule
`default_nettype wire
