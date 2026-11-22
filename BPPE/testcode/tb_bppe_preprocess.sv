`timescale 1ns/1ps
`default_nettype none
module tb_bppe_preprocess;
    parameter integer PROFILE = 1;
    localparam integer SIGNAL_F = PROFILE==0 ? 0 : (PROFILE==1 ? 8 : 10);
    localparam integer COEFFICIENT_F = PROFILE==0 ? 8 : 18;
    localparam integer TIME_F = SIGNAL_F;
    localparam integer SIGNAL_W = 26+SIGNAL_F;
    logic clk=1'b0;
    always #5 clk=~clk; // Simulation clock only; no FPGA timing target implied.
    logic rst=1'b1, clear_history=1'b0;
    logic [2:0] in_valid='0, out_ready='0;
    wire [2:0] in_ready, out_valid, initialized, numeric_fault;
    logic [23:0] adc [0:2];
    logic signed [63:0] ticks [0:2];
    logic [COEFFICIENT_F-1:0] a='0,b='0;
    wire signed [SIGNAL_W-1:0] dc [0:2], filtered [0:2];
    wire signed [47:0] sample_time [0:2];
    wire [63:0] saturations [0:2], precision_faults [0:2];
    logic [63:0] row [0:18];
    logic [4095:0] header;
    string vector_path;
    integer fd, scanned, channel_index, stall, rows_checked=0, cases_checked=0;
    logic [63:0] current_case=0,expected_frame=1,expected_channel=1;
    genvar g;
    generate for (g=0;g<3;g=g+1) begin: channels
        bppe_preprocess_core #(.SIGNAL_F(SIGNAL_F),.COEFFICIENT_F(COEFFICIENT_F),.TIME_F(TIME_F)) dut (
            .clk(clk),.rst(rst),.clear_history(clear_history),
            .in_valid(in_valid[g]),.in_ready(in_ready[g]),.in_adc(adc[g]),.in_ticks(ticks[g]),
            .dc_coefficient(a),.lowpass_coefficient(b),.out_valid(out_valid[g]),.out_ready(out_ready[g]),
            .initialized(initialized[g]),.out_dc(dc[g]),.out_filtered(filtered[g]),.out_time(sample_time[g]),
            .saturation_count(saturations[g]),.precision_count(precision_faults[g]),.numeric_fault(numeric_fault[g])
        );
    end endgenerate

    task automatic control(input bit full_reset);
        @(negedge clk);
        in_valid='0; out_ready='0;
        rst=full_reset; clear_history=!full_reset;
        @(posedge clk); #1;
        if (out_valid!==3'b000 || initialized!==3'b000) $fatal(1,"control did not clear history");
        if (full_reset && ((saturations[0]|saturations[1]|saturations[2]|precision_faults[0]|precision_faults[1]|precision_faults[2])!==64'd0))
            $fatal(1,"full reset did not clear arithmetic faults");
        @(negedge clk); rst=1'b0; clear_history=1'b0;
    endtask

    task automatic check_current(input integer index);
        logic [63:0] total_saturation,total_precision;
        begin
            total_saturation=saturations[0]+saturations[1]+saturations[2];
            total_precision=precision_faults[0]+precision_faults[1]+precision_faults[2];
            if (out_valid!==(3'b001 << index) || initialized[index]!==row[12][0] ||
                $signed(dc[index])!==$signed(row[13]) || $signed(filtered[index])!==$signed(row[14]) ||
                $signed(sample_time[index])!==$signed(row[15]) || total_saturation!==row[16] ||
                row[17]!==64'd0 || total_precision!==row[18] ||
                (|numeric_fault)!==((row[16]!=0)||(row[18]!=0)))
                $fatal(1,"raw-state mismatch profile=%0d case=%0d frame=%0d channel=%0d",PROFILE,row[0],row[1],row[3]);
        end
    endtask

    initial begin
        for (integer k=0;k<3;k=k+1) begin adc[k]='0; ticks[k]='0; end
        if (PROFILE<0 || PROFILE>2) $fatal(1,"bad profile");
        if (!$value$plusargs("VECTORS=%s",vector_path)) $fatal(1,"missing VECTORS argument");
        fd=$fopen(vector_path,"r");
        if (fd==0) $fatal(1,"cannot open raw vectors");
        scanned=$fgets(header,fd);
        if (scanned==0) $fatal(1,"missing vector header");
        control(1'b1);
        while (!$feof(fd)) begin
            scanned=$fscanf(fd,"%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\n",
                row[0],row[1],row[2],row[3],row[4],row[5],row[6],row[7],row[8],row[9],
                row[10],row[11],row[12],row[13],row[14],row[15],row[16],row[17],row[18]);
            if (scanned!=19) begin
                if (!$feof(fd)) $fatal(1,"malformed raw vector");
            end else if (row[5]==SIGNAL_F) begin
                if (row[6]!=COEFFICIENT_F || row[7]!=TIME_F || row[4]<1 || row[4]>3 || row[12]!=1)
                    $fatal(1,"invalid profile/channel metadata");
                if (row[0]!=current_case) begin
                    if (expected_channel!=1) $fatal(1,"incomplete frame at case boundary");
                    control(1'b1); current_case=row[0]; cases_checked=cases_checked+1;
                    expected_frame=1; expected_channel=1;
                    a=row[8][COEFFICIENT_F-1:0]; b=row[9][COEFFICIENT_F-1:0];
                end
                if (row[1]!=expected_frame || row[3]!=expected_channel || row[8]!==a || row[9]!==b)
                    $fatal(1,"frame order or coefficient changed");
                if (row[2]!=0) begin
                    if (row[3]!=1 || row[2]>2) $fatal(1,"invalid control boundary");
                    control(row[2]==2);
                end
                channel_index=row[3]-1;
                @(negedge clk);
                in_valid='0; out_ready='0;
                adc[channel_index]=row[10][23:0]; ticks[channel_index]=$signed(row[11]);
                in_valid[channel_index]=1'b1;
                if (!in_ready[channel_index]) $fatal(1,"idle core not ready");
                @(posedge clk); #1;
                begin
                    integer latency;latency=0;
                    while(!out_valid[channel_index])begin
                        @(posedge clk);#1;latency=latency+1;
                        if(latency>32 || in_ready[channel_index])$fatal(1,"Preprocess progress/ready failure");
                    end
                end
                check_current(channel_index);
                // Attempt duplicate traffic while the one-entry output is stalled.
                for (stall=0;stall<(rows_checked%3);stall=stall+1) begin
                    @(negedge clk); adc[channel_index]=24'd0;
                    if (in_ready[channel_index]!==1'b0) $fatal(1,"accepted while output stalled");
                    @(posedge clk); #1; check_current(channel_index);
                end
                @(negedge clk); in_valid='0; out_ready[channel_index]=1'b1;
                @(posedge clk); #1;
                if (out_valid!==3'b000) $fatal(1,"output not consumed exactly once");
                @(negedge clk); out_ready='0;
                rows_checked=rows_checked+1; expected_channel=expected_channel+1;
                if (expected_channel>row[4]) begin expected_channel=1; expected_frame=expected_frame+1; end
            end
        end
        $fclose(fd);
        if (rows_checked!=3308 || cases_checked!=8 || expected_channel!=1) $fatal(1,"incomplete profile vectors");
        $display("RTL_PREPROCESS_PASSED profile=%0d rows=%0d cases=%0d",PROFILE,rows_checked,cases_checked);
        $finish;
    end
    initial begin #20000000; $fatal(1,"watchdog expired"); end
endmodule
`default_nettype wire
