`timescale 1ns/1ps
`default_nettype none
module tb_bppe_window_store;
`include "measurement_tb_ports.svh"
    localparam signed [63:0] ONE=64'sd1<<FF;
    logic history_clear=0,window_clear=0,event_valid=0,event_beat=0;
    wire event_ready;
    logic [1:0] event_channel=0;
    logic [6:0] window_limit=4;
    logic signed [FW-1:0] event_features[0:4];
    logic [63:0] event_rejected=0;
    integer i,j,k,watchdog;
    bppe_window_store #(.FEATURE_F(FF)) store(
        .clk(clk),.rst(rst),.clear_history(history_clear),.clear_window(window_clear),
        .in_valid(event_valid),.in_ready(event_ready),.in_channel(event_channel),.beats_required(window_limit),
        .in_beat_valid(event_beat),.in_features(event_features),.in_rejected_total(event_rejected),
        .out_counts(in_counts),.out_beats(in_beats),.out_rejected(in_rejected)
    );
    task automatic event_send(input logic [1:0] ch,input logic beat,input logic [63:0] rejected,input logic signed [63:0] base,input logic nominal);
        begin
            @(negedge clk);event_channel=ch;event_beat=beat;event_rejected=rejected;
            for(integer f=0;f<5;f=f+1) event_features[f]=base+f;
            if(nominal) begin
                event_features[0]=(4*ONE+2)/5;event_features[1]=ONE/4;event_features[2]=ONE/4;
                event_features[3]=ONE/4;event_features[4]=base;
            end
            event_valid=1;do @(posedge clk);while(!event_ready);
            @(negedge clk);event_valid=0;
        end
    endtask
    task automatic reset_history;
        begin @(negedge clk);history_clear=1;@(negedge clk);history_clear=0;end
    endtask
    task automatic snapshot(input logic [31:0] tag);
        begin
            @(negedge clk);in_tag=tag;in_valid=1;window_clear=1;
            do @(posedge clk);while(!in_ready);
            @(negedge clk);in_valid=0;window_clear=0;
            for(integer ch=0;ch<3;ch=ch+1) if(in_counts[ch]!=0 || in_rejected[ch]!=0) $fatal(1,"Atomic snapshot/window clear failed");
        end
    endtask
    task automatic await_output;
        begin watchdog=0;while(!out_valid) begin @(negedge clk);watchdog=watchdog+1;if(watchdog>MEASUREMENT_LATENCY_BOUND) $fatal(1,"Window evaluator timeout");end end
    endtask
    task automatic consume;
        begin out_ready=1;@(negedge clk);out_ready=0;if(out_valid) $fatal(1,"Duplicate window result");end
    endtask
    initial begin
        // Evaluator configuration; matrices/counts/rejections are driven by store.
        in_channels=3;in_primary=1;in_beats_required=4;
        in_min_amplitude=1;in_max_amplitude=ONE;in_max_cv=ONE/4;in_sqi_threshold=150;
        in_configured=1;in_calibrated=1;in_demo_only=1;in_allow_demo=1;in_min_enabled=0;in_max_enabled=0;
        for(i=0;i<5;i=i+1) begin in_center[i]=0;in_scale[i]=ONE;in_feature_min[i]=0;in_feature_max[i]=0;end
        for(i=0;i<6;i=i+1) for(j=0;j<2;j=j+1) in_beta[i][j]=0;
        in_beta[0][0]=120*ONE;in_beta[0][1]=80*ONE;
        in_bp_min[0]=40*ONE;in_bp_min[1]=20*ONE;in_bp_max[0]=260*ONE;in_bp_max[1]=180*ONE;
        repeat(2) @(negedge clk);rst=0;
        for(k=1;k<=6;k=k+1) event_send(0,1,k/2,k*10,0);
        if(in_counts[0]!=4 || in_counts[1]!=0 || in_counts[2]!=0 || in_rejected[0]!=3) $fatal(1,"Rolling window/count mismatch");
        for(i=0;i<4;i=i+1) for(j=0;j<5;j=j+1)
            if($signed(in_beats[0][i][j])!=(i+3)*10+j) $fatal(1,"Rolling window ordering mismatch");
        event_send(1,0,2,0,0);
        if(in_counts[1]!=0 || in_rejected[1]!=2 || in_counts[0]!=4) $fatal(1,"Nonbeat/channel isolation mismatch");
        // Hold an event across window clear; it belongs exactly once to next window.
        @(negedge clk);window_clear=1;event_valid=1;event_beat=1;event_channel=0;event_rejected=4;
        for(i=0;i<5;i=i+1) event_features[i]=99+i;
        #1;if(event_ready) $fatal(1,"Window clear accepted event");
        @(negedge clk);window_clear=0;
        @(negedge clk);event_valid=0;
        if(in_counts[0]!=1 || in_rejected[0]!=1 || in_counts[1]!=0 || in_rejected[1]!=0 || in_beats[0][0][0]!=99)
            $fatal(1,"Window clear baseline or held event mismatch");
        reset_history();
        for(i=0;i<3;i=i+1) for(k=0;k<4;k=k+1) event_send(2'(i),1,0,ONE/16,1);
        snapshot(101);
        // New bad window is collected while the old snapshot is being evaluated.
        for(i=0;i<3;i=i+1) for(k=0;k<4;k=k+1) event_send(2'(i),1,0,0,1);
        await_output();
        if(out_tag!=101 || !result_valid || sqi!=255 || reason_flags!=0 || pressure_codes[0]!=15360 || pressure_codes[1]!=10240)
            $fatal(1,"New window contaminated in-flight good snapshot");
        consume();snapshot(202);await_output();
        if(out_tag!=202 || result_valid || sqi!=0 || reason_flags!=1 || pressure_codes[0]!=0 || pressure_codes[1]!=0)
            $fatal(1,"Bad next window not evaluated independently");
        consume();reset_history();window_limit=64;
        for(k=1;k<=66;k=k+1) event_send(2,1,7,k,0);
        if(in_counts[2]!=64 || in_rejected[2]!=7) $fatal(1,"Maximum capacity count mismatch");
        for(i=0;i<64;i=i+1) for(j=0;j<5;j=j+1)
            if($signed(in_beats[2][i][j])!=i+3+j) $fatal(1,"Maximum capacity ordering mismatch");
        @(negedge clk);window_clear=1;@(negedge clk);window_clear=0;
        event_send(2,0,9,0,0);
        if(in_counts[2]!=0 || in_rejected[2]!=2) $fatal(1,"Maximum window rejection baseline mismatch");
        $display("RTL_WINDOW_STORE_PASSED profile=%0d",PROFILE);$finish;
    end
    initial begin #1000000;$fatal(1,"Window store watchdog");end
endmodule
`default_nettype wire
