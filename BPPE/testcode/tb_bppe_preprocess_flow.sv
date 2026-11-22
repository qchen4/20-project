`timescale 1ns/1ps
`default_nettype none
module tb_bppe_preprocess_flow;
    parameter integer PROFILE=1;
    localparam integer F=PROFILE==0?0:(PROFILE==1?8:10),CF=PROFILE==0?8:18,W=26+F;
    localparam logic [CF-1:0] HALF=(1<<(CF-1));
    logic clk=0;always #5 clk=~clk;
    logic rst=1,clear_history=0,in_valid=0,out_ready=0;
    logic [23:0] adc=0;
    logic signed [63:0] ticks=0;
    logic [CF-1:0] a=HALF,b=HALF;
    wire in_ready,out_valid,initialized,numeric_fault;
    wire signed [W-1:0] dc,filtered;
    wire signed [47:0] sample_time;
    wire [63:0] saturations,precision_faults;
    integer latency;
    bppe_preprocess_core #(.SIGNAL_F(F),.COEFFICIENT_F(CF),.TIME_F(F)) dut(
        .clk(clk),.rst(rst),.clear_history(clear_history),.in_valid(in_valid),.in_ready(in_ready),
        .in_adc(adc),.in_ticks(ticks),.dc_coefficient(a),.lowpass_coefficient(b),.out_valid(out_valid),.out_ready(out_ready),
        .initialized(initialized),.out_dc(dc),.out_filtered(filtered),.out_time(sample_time),
        .saturation_count(saturations),.precision_count(precision_faults),.numeric_fault(numeric_fault)
    );
    function automatic signed [63:0] code(input integer value);code=value*(64'sd1<<F);endfunction
    task automatic expect_state(input integer expected_dc,expected_filtered);
        if(!out_valid || !initialized || $signed(dc)!==code(expected_dc) || $signed(filtered)!==code(expected_filtered))$fatal(1,"flow state mismatch profile=%0d",PROFILE);
    endtask
    task automatic wait_output;
        begin
            latency=0;
            while(!out_valid)begin @(negedge clk);latency=latency+1;if(latency>32)$fatal(1,"Preprocess timeout");end
        end
    endtask
    task automatic request(input integer value,input logic signed [63:0] time_ticks);
        begin
            @(negedge clk);in_valid=1;out_ready=1;adc=24'(value);ticks=time_ticks;a=HALF;b=HALF;
            do @(posedge clk);while(!in_ready);
            @(negedge clk);in_valid=0;out_ready=0;adc='1;ticks=-1;a=0;b=0;
        end
    endtask
    task automatic reset_all;
        begin
            @(negedge clk);rst=1;in_valid=1;out_ready=0;#1;if(in_ready!==0)$fatal(1,"ready during reset");
            @(posedge clk);#1;if(out_valid!==0 || initialized!==0 || numeric_fault!==0)$fatal(1,"reset state mismatch");
            @(negedge clk);rst=0;in_valid=0;
        end
    endtask
    initial begin
        reset_all();request(8,0);wait_output();expect_state(8,0);
        // An output can be consumed on the same edge that the next sample is accepted.
        request(12,10);wait_output();expect_state(10,1);
        request(4,20);wait_output();expect_state(7,-1);
        @(negedge clk);in_valid=1;out_ready=0;adc='1;ticks=64'sd9007199254740992;
        repeat(3)begin @(posedge clk);#1;expect_state(7,-1);if(in_ready || numeric_fault)$fatal(1,"Blocked input changed state");end
        reset_all();request(100,64'sd9007199254740992);wait_output();expect_state(100,0);
        if(precision_faults!=1 || saturations!=0 || sample_time!=0 || !numeric_fault)$fatal(1,"Precision guard mismatch");
        @(negedge clk);out_ready=1;@(negedge clk);out_ready=0;clear_history=1;
        @(negedge clk);clear_history=0;
        if(out_valid || initialized || precision_faults!=1)$fatal(1,"History clear lost fault");
        request(200,0);wait_output();expect_state(200,0);if(precision_faults!=1)$fatal(1,"Numeric fault not retained");
        // Full reset aborts an accepted sample before its arithmetic commits.
        reset_all();request(300,64'sd9007199254740992);
        repeat(2)@(negedge clk);if(out_valid || in_ready)$fatal(1,"Expected active staged arithmetic");
        reset_all();repeat(14)@(negedge clk);
        if(out_valid || initialized || numeric_fault)$fatal(1,"Aborted work appeared after reset");
        request(300,0);wait_output();expect_state(300,0);if(numeric_fault)$fatal(1,"Reset retained fault");
        $display("RTL_FLOW_PASSED profile=%0d",PROFILE);$finish;
    end
    initial begin #100000;$fatal(1,"flow watchdog");end
endmodule
`default_nettype wire
