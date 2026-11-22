`timescale 1ns/1ps
`default_nettype none
module tb_bppe_rounded_divider;
    logic clk=0;always #5 clk=~clk;
    logic rst=1,in_valid=0,out_ready=0;
    wire in_ready,out_valid,out_divzero,out_precision;
    logic signed [63:0] in_numerator=0,in_denominator=1;
    wire signed [63:0] out_quotient;
    bppe_rounded_divider dut(.*);
    logic [63:0] x,y,q,flags;
    logic [65:0] held;
    string filename;
    integer fd,got,rows=0,latency,max_latency=0;
    task automatic reset_all;
        begin @(negedge clk);rst=1;in_valid=0;out_ready=0;repeat(2)@(negedge clk);rst=0;
            if(out_valid || out_divzero || out_precision)$fatal(1,"Divider reset failed");end
    endtask
    task automatic request(input logic signed [63:0] a,b);
        begin @(negedge clk);in_numerator=a;in_denominator=b;in_valid=1;#1;
            if(!in_ready)$fatal(1,"Expected idle divider");
            @(posedge clk);#1;@(negedge clk);in_valid=0;in_numerator='1;in_denominator=0;end
    endtask
    initial begin
        if(!$value$plusargs("VECTORS=%s",filename))$fatal(1,"Missing divider vectors");
        fd=$fopen(filename,"r");if(!fd)$fatal(1,"Cannot open divider vectors");
        reset_all();
        while(!$feof(fd))begin
            got=$fscanf(fd,"%h %h %h %h",x,y,q,flags);
            if(got<=0 && $feof(fd))break;
            if(got!=4)$fatal(1,"Truncated divider row");
            request($signed(x),$signed(y));latency=0;
            while(!out_valid)begin @(negedge clk);latency=latency+1;if(latency>54 || in_ready)$fatal(1,"Divider stalled or accepted while busy");end
            if(out_quotient!==q || out_divzero!==flags[0] || out_precision!==flags[1])$fatal(1,"Divider mismatch row=%0d",rows);
            if(latency>max_latency)max_latency=latency;
            held={out_quotient,out_divzero,out_precision};in_valid=1;
            repeat(3)begin @(negedge clk);if(!out_valid || in_ready || {out_quotient,out_divzero,out_precision}!==held)$fatal(1,"Held division changed");end
            in_valid=0;out_ready=1;@(posedge clk);#1;@(negedge clk);out_ready=0;
            if(out_valid)$fatal(1,"Duplicated division result");
            rows=rows+1;
        end
        $fclose(fd);
        request(64'sd9007199254740991,3);repeat(7)@(negedge clk);reset_all();repeat(60)@(negedge clk);
        if(out_valid || !in_ready)$fatal(1,"Aborted divider result leaked");
        request(5,2);while(!out_valid)@(negedge clk);
        // Consume and accept on the same edge, including a fast fault result.
        in_numerator=-7;in_denominator=0;in_valid=1;out_ready=1;
        @(posedge clk);#1;@(negedge clk);out_ready=0;in_valid=0;
        if(!out_valid || !out_divzero || out_precision || out_quotient!=0)$fatal(1,"Simultaneous transfer/accept failed");
        reset_all();if(rows!=14481)$fatal(1,"Incomplete divider coverage");
        $display("RTL_DIVIDER_PASSED rows=%0d max_latency=%0d",rows,max_latency);$finish;
    end
    initial begin #100000000;$fatal(1,"Divider global timeout");end
endmodule
`default_nettype wire
