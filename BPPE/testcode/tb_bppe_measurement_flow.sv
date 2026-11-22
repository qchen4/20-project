`timescale 1ns/1ps
`default_nettype none
module tb_bppe_measurement_flow;
`include "measurement_tb_ports.svh"
    localparam signed [63:0] ONE=64'sd1<<FF;
    integer i,j,k,wait_cycles,reset_stage;
    logic [1023:0] saved_packet;
    task automatic nominal;
        begin
            in_channels=1;in_primary=0;in_beats_required=4;
            in_min_amplitude=0;in_max_amplitude=ONE;in_max_cv=ONE/4;in_sqi_threshold=150;
            in_configured=1;in_calibrated=1;in_demo_only=1;in_allow_demo=1;in_min_enabled=0;in_max_enabled=0;
            in_saturations=0;in_divzero=0;in_precision=0;
            for(i=0;i<3;i=i+1) begin
                in_counts[i]=(i==0)?4:0;in_rejected[i]=0;
                for(j=0;j<64;j=j+1) begin
                    in_beats[i][j][0]=(4*ONE+2)/5;in_beats[i][j][1]=ONE/4;
                    in_beats[i][j][2]=ONE/4;in_beats[i][j][3]=ONE/4;in_beats[i][j][4]=ONE/16;
                end
            end
            for(i=0;i<5;i=i+1) begin in_center[i]=0;in_scale[i]=ONE;in_feature_min[i]=0;in_feature_max[i]=0;end
            for(i=0;i<6;i=i+1) for(j=0;j<2;j=j+1) in_beta[i][j]=0;
            in_beta[0][0]=120*ONE;in_beta[0][1]=80*ONE;
            in_bp_min[0]=40*ONE;in_bp_min[1]=20*ONE;in_bp_max[0]=260*ONE;in_bp_max[1]=180*ONE;
        end
    endtask
    task automatic start(input logic [31:0] tag);
        begin
            @(negedge clk);in_tag=tag;in_valid=1;
            do @(posedge clk);while(!in_ready);
            @(negedge clk);in_valid=0;
        end
    endtask
    task automatic await_output;
        begin
            wait_cycles=0;
            while(!out_valid) begin @(negedge clk);wait_cycles=wait_cycles+1;if(wait_cycles>MEASUREMENT_LATENCY_BOUND) $fatal(1,"Flow timeout");end
        end
    endtask
    task automatic consume;
        begin out_ready=1;@(negedge clk);out_ready=0;if(out_valid) $fatal(1,"Duplicate flow result");end
    endtask
    initial begin
        nominal();repeat(2) @(negedge clk);rst=0;
        // Reset in-flight long scans, including the iterative integer square root.
        in_channels=3;in_beats_required=64;
        for(i=0;i<3;i=i+1) begin
            in_counts[i]=64;
            for(j=0;j<64;j=j+1) in_beats[i][j][0]=(4*ONE+2)/5+((j%2)?ONE/100:0);
        end
        start(11);repeat(8) @(negedge clk);
        if(in_ready || out_valid) $fatal(1,"Expected busy measurement");
        wait_cycles=0;
        while(dut.phase!=5) begin @(negedge clk);wait_cycles=wait_cycles+1;if(wait_cycles>MEASUREMENT_LATENCY_BOUND) $fatal(1,"Square-root phase not reached");end
        rst=1;@(negedge clk);rst=0;
        if(out_valid || saturation_count!=0 || divzero_count!=0 || precision_count!=0) $fatal(1,"In-flight reset failed");
        nominal();start(12);wait_cycles=0;
        while(dut.divider.phase!=1)begin @(negedge clk);wait_cycles=wait_cycles+1;if(wait_cycles>100)$fatal(1,"Divider iteration not reached");end
        rst=1;@(negedge clk);rst=0;repeat(60)@(negedge clk);
        if(out_valid || !in_ready || divzero_count!=0 || precision_count!=0)$fatal(1,"Reset leaked shared-divider work");
        // Abort every new multiplier continuation, including sqrt request/use.
        for(reset_stage=27;reset_stage<=37;reset_stage=reset_stage+1)begin
            nominal();
            for(j=0;j<4;j=j+1)in_beats[0][j][0]=(4*ONE+2)/5+((j%2)?ONE/100:0);
            start(100+reset_stage);wait_cycles=0;
            while(dut.phase!=reset_stage)begin
                @(negedge clk);wait_cycles=wait_cycles+1;
                if(wait_cycles>MEASUREMENT_LATENCY_BOUND)$fatal(1,"Product reset phase not reached %0d",reset_stage);
            end
            rst=1;@(negedge clk);rst=0;repeat(60)@(negedge clk);
            if(out_valid || !in_ready || saturation_count!=0 || divzero_count!=0 || precision_count!=0)
                $fatal(1,"Reset leaked measurement product stage %0d",reset_stage);
        end
        nominal();start(22);await_output();
        if(out_tag!=22 || !result_valid || reason_flags!=0 || sqi!=255 || !has_features ||
            pressure_codes[0]!=15360 || pressure_codes[1]!=10240 || pressure_raw[0]!=120*ONE || pressure_raw[1]!=80*ONE)
            $fatal(1,"Constant demo hand-computed result mismatch");
        saved_packet=packet();repeat(7) begin @(negedge clk);if(!out_valid || in_ready || packet()!==saved_packet) $fatal(1,"Blocked result changed");end
        // A synchronous reset also aborts an unconsumed result.
        rst=1;@(negedge clk);rst=0;
        if(out_valid || result_valid) $fatal(1,"Blocked-output reset failed");
        nominal();in_rejected[0]=12;start(33);await_output();
        if(out_tag!=33 || result_valid || reason_flags!=1 || sqi!=64 || pressure_codes[0]!=0 || pressure_codes[1]!=0)
            $fatal(1,"Rejected-beat SQI hand computation mismatch");
        consume();
        nominal();in_scale[0]=0;start(44);await_output();
        if(result_valid || reason_flags!=192 || divzero_count!=1 || pressure_codes[0]!=0 || pressure_codes[1]!=0)
            $fatal(1,"Numeric fault did not invalidate plausible pressure");
        consume();
        nominal();in_divzero=1;start(55);await_output();
        if(result_valid || reason_flags!=192 || divzero_count!=1) $fatal(1,"Caller-owned fault carry lost");
        consume();
        rst=1;@(negedge clk);rst=0;
        nominal();start(66);await_output();
        if(!result_valid || reason_flags!=0 || out_tag!=66) $fatal(1,"Clean reset recovery failed");
        // Consume one result and capture the next complete snapshot at one edge.
        nominal();in_tag=67;in_valid=1;out_ready=1;
        @(posedge clk);if(!in_ready)$fatal(1,"Expected simultaneous measurement transfer");
        @(negedge clk);in_valid=0;out_ready=0;
        if(out_valid)$fatal(1,"Previous result leaked into replacement snapshot");
        in_tag='1;in_channels=0;in_counts[0]=0;in_scale[0]=0;
        await_output();
        if(!result_valid || out_tag!=67 || reason_flags!=0 || pressure_codes[0]!=15360 || pressure_codes[1]!=10240)
            $fatal(1,"Simultaneous measurement snapshot corrupted");
        consume();
        nominal();in_channels=3;in_primary=2;in_beats_required=64;
        for(i=0;i<3;i=i+1) in_counts[i]=64;
        start(77);await_output();
        if(!result_valid || sqi!=255 || reason_flags!=0 || pressure_codes[0]!=15360 || pressure_codes[1]!=10240 ||
            channel_sqi[0]!=255 || channel_sqi[1]!=255 || channel_sqi[2]!=255) $fatal(1,"Three-channel 64-beat bound failed");
        $display("RTL_MEASUREMENT_CAPACITY_PASSED profile=%0d channels=3 beats=64 latency=%0d",PROFILE,wait_cycles);
        consume();
        // Full windows with nonzero variance exercise the longest sqrt range.
        // Symmetric periods have exact mean p and variance (ONE/4)^2; CV
        // exceeds max_cv, hence SQI zero and only the low-quality reason.
        nominal();in_channels=3;in_primary=2;in_beats_required=64;
        for(i=0;i<3;i=i+1)begin
            in_counts[i]=64;
            for(j=0;j<64;j=j+1)in_beats[i][j][0]=(4*ONE+2)/5+((j%2)?ONE/4:-ONE/4);
        end
        start(88);await_output();
        if(result_valid || !has_features || sqi!=0 || reason_flags!=1 ||
            saturation_count!=0 || divzero_count!=0 || precision_count!=0 ||
            pressure_codes[0]!=0 || pressure_codes[1]!=0 ||
            $signed(features[0])!=(4*ONE+2)/5 || channel_sqi[0]!=0 || channel_sqi[1]!=0 || channel_sqi[2]!=0)
            $fatal(1,"Full-window variance hand computation mismatch");
        $display("RTL_MEASUREMENT_VARIANCE_CAPACITY_PASSED profile=%0d channels=3 beats=64 latency=%0d",PROFILE,wait_cycles);
        consume();
        $display("RTL_MEASUREMENT_FLOW_PASSED profile=%0d reset_product_stages=11",PROFILE);$finish;
    end
    initial begin #10000000;$fatal(1,"Measurement flow watchdog");end
endmodule
`default_nettype wire
