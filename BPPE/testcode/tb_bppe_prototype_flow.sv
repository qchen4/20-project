`timescale 1ns/1ps
`default_nettype none
module tb_bppe_prototype_flow;
`include "prototype_tb_ports.svh"
    localparam signed [63:0] ONE=64'sd1<<FF;
    integer i,j,watchdog;
    logic [1023:0] first_snapshot;
    function automatic [1023:0] snapshot_packet;
        snapshot_packet={snapshot_seq,snapshot_tag,snapshot_timestamp,snapshot_reasons,snapshot_sqi,snapshot_result_valid,snapshot_has_features,
            snapshot_features[0],snapshot_features[1],snapshot_features[2],snapshot_features[3],snapshot_features[4],
            snapshot_pressure_raw[0],snapshot_pressure_raw[1],snapshot_codes[0],snapshot_codes[1]};
    endfunction
    task automatic send(input logic [31:0] tag,timestamp,input logic signed [63:0] ticks);
        begin
            @(negedge clk);in_valid=1;in_adc=1000;in_ticks=ticks;in_tag=tag;in_timestamp=timestamp;
            do @(posedge clk);while(!in_ready);
            @(negedge clk);in_valid=0;
        end
    endtask
    task automatic await_sample;
        begin watchdog=0;while(!sample_done) begin @(negedge clk);watchdog=watchdog+1;if(watchdog>SINGLE_LATENCY_BOUND)$fatal(1,"Prototype flow timeout");end end
    endtask
    task automatic do_ack;
        begin @(negedge clk);ack=1;@(negedge clk);ack=0;end
    endtask
    initial begin
        dc_coefficient=0;lowpass_coefficient=0;tick_period_ns=1000000;
        min_period=(35*ONE+50)/100;max_period=3*ONE/2;max_period_ticks=1500<<TF;
        in_beats_required=4;in_min_amplitude=1;in_max_amplitude=ONE;in_max_cv=ONE/4;in_sqi_threshold=150;
        in_configured=1;in_calibrated=1;in_demo_only=1;in_allow_demo=1;in_min_enabled=0;in_max_enabled=0;
        warmup_ticks=0;timeout_ticks=2000;initial_deadline_ticks=2000;
        for(i=0;i<5;i=i+1)begin in_center[i]=0;in_scale[i]=ONE;in_feature_min[i]=0;in_feature_max[i]=0;end
        for(i=0;i<6;i=i+1)for(j=0;j<2;j=j+1)in_beta[i][j]=0;
        in_beta[0][0]=120*ONE;in_beta[0][1]=80*ONE;in_bp_min[0]=40*ONE;in_bp_min[1]=20*ONE;in_bp_max[0]=260*ONE;in_bp_max[1]=180*ONE;
        repeat(2)@(negedge clk);rst=0;
        send(11,111,2000);
        watchdog=0;while(dut.phase!=4)begin @(negedge clk);watchdog=watchdog+1;if(watchdog>1000)$fatal(1,"Measurement request not reached");end
        if($test$plusargs("ACK_COLLISION"))begin
            while(!dut.measure_valid)@(negedge clk);
            ack=1;@(negedge clk);$fatal(1,"ACK collision unexpectedly escaped the guard");
        end
        rst=1;@(negedge clk);rst=0;
        if(pending||candidate_valid||sample_done||result_counter!=0||fault_flags!=0)$fatal(1,"Prototype in-flight reset failed");
        send(1,111,2000);await_sample();
        if(!candidate_valid||!pending||candidate_seq!=1||snapshot_seq!=1||snapshot_timestamp!=111||snapshot_reasons!=17||snapshot_result_valid)
            $fatal(1,"Prototype empty-window publication mismatch");
        first_snapshot=snapshot_packet();
        send(2,222,4000);await_sample();
        if(!candidate_valid||candidate_seq!=2||snapshot_packet()!==first_snapshot||!pending||fault_flags!=512)
            $fatal(1,"Prototype did not preserve first pending snapshot/overflow");
        do_ack();
        if(pending||snapshot_packet()!==first_snapshot||fault_flags!=512)$fatal(1,"ACK altered payload or sticky overflow");
        do_ack();if(pending||fault_flags!=512)$fatal(1,"Empty ACK altered control state");
        send(3,333,6000);await_sample();
        if(!pending||candidate_seq!=3||snapshot_seq!=3||snapshot_timestamp!=333||fault_flags!=512)$fatal(1,"Post-ACK publication mismatch");
        rst=1;@(negedge clk);rst=0;
        if(pending||result_counter!=0||snapshot_seq!=0||fault_flags!=0)$fatal(1,"Pending reset failed");
        initial_divzero=1;rst=1;@(negedge clk);rst=0;
        send(4,444,2000);await_sample();
        if(sample_divzero!=1||fault_flags!=192||snapshot_reasons!=209||snapshot_result_valid)$fatal(1,"Host numeric-fault seed lost");
        do_ack();if(pending||fault_flags!=192||sample_divzero!=1)$fatal(1,"ACK cleared numeric fault");
        @(negedge clk);initial_divzero=0;warmup_ticks=8020;timeout_ticks=10000;initial_deadline_ticks=18020;rst=1;
        @(negedge clk);rst=0;send(5,18019,18019);await_sample();
        if(candidate_valid||pending||result_counter!=0)$fatal(1,"Integer timeout fired early");
        send(6,18020,18020);await_sample();
        if(!candidate_valid||!pending||candidate_timestamp!=18020||result_counter!=1)$fatal(1,"Integer timeout missed exact boundary");
        $display("RTL_PROTOTYPE_FLOW_PASSED profile=%0d",PROFILE);$finish;
    end
    initial begin #1000000;$fatal(1,"Prototype flow watchdog");end
endmodule
`default_nettype wire
