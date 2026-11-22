`timescale 1ns/1ps
`default_nettype none
module tb_bppe_guarded_multiplier;
    logic clk=0;always #5 clk=~clk;
    logic rst=1,in_valid=0,out_ready=0;
    wire in_ready,out_valid,out_precision;
    logic signed [63:0] in_x=0,in_y=0;
    wire signed [63:0] out_product;
    bppe_guarded_multiplier dut(.*);
    logic [63:0] x,y,product,flag;
    logic [64:0] held;
    string filename;
    integer fd,got,rows=0,latency,max_latency=0,k;
    task automatic reset_all;
        begin @(negedge clk);rst=1;in_valid=0;out_ready=0;repeat(2)@(negedge clk);rst=0;
            if(out_valid || out_precision)$fatal(1,"Multiplier reset failed");end
    endtask
    task automatic request(input logic signed [63:0] a,b);
        begin @(negedge clk);in_x=a;in_y=b;in_valid=1;#1;
            if(!in_ready)$fatal(1,"Expected idle multiplier");
            @(posedge clk);#1;@(negedge clk);in_valid=0;in_x='1;in_y=0;end
    endtask
    initial begin
        if(!$value$plusargs("VECTORS=%s",filename))$fatal(1,"Missing multiplier vectors");
        fd=$fopen(filename,"r");if(!fd)$fatal(1,"Cannot open multiplier vectors");
        reset_all();
        while(!$feof(fd))begin
            got=$fscanf(fd,"%h %h %h %h",x,y,product,flag);
            if(got<=0 && $feof(fd))break;
            if(got!=4)$fatal(1,"Truncated multiplier row");
            request($signed(x),$signed(y));latency=0;
            while(!out_valid)begin @(negedge clk);latency=latency+1;if(latency>2 || in_ready)$fatal(1,"Multiplier latency/ready fault");end
            if(out_product!==product || out_precision!==flag[0])$fatal(1,"Multiplier mismatch row=%0d",rows);
            if(latency>max_latency)max_latency=latency;
            held={out_product,out_precision};in_valid=1;
            repeat(3)begin @(negedge clk);if(!out_valid || in_ready || {out_product,out_precision}!==held)$fatal(1,"Held product changed");end
            in_valid=0;out_ready=1;@(posedge clk);#1;@(negedge clk);out_ready=0;
            if(out_valid)$fatal(1,"Duplicated product");
            rows=rows+1;
        end
        $fclose(fd);
        for(k=0;k<2;k=k+1)begin
            request(12345,6789);repeat(k)@(negedge clk);rst=1;
            @(negedge clk);rst=0;repeat(5)@(negedge clk);
            if(out_valid || !in_ready || out_precision)$fatal(1,"Aborted product leaked");
        end
        request(5,2);while(!out_valid)@(negedge clk);
        in_x=64'sd9007199254740992;in_y=0;in_valid=1;out_ready=1;
        @(posedge clk);#1;@(negedge clk);out_ready=0;in_valid=0;
        while(!out_valid)@(negedge clk);
        if(!out_precision || out_product!=0)$fatal(1,"Simultaneous transfer/accept lost asymmetric zero fault");
        reset_all();if(rows!=14481)$fatal(1,"Incomplete multiplier coverage");
        $display("RTL_MULTIPLIER_PASSED rows=%0d max_latency=%0d",rows,max_latency);$finish;
    end
    initial begin #100000000;$fatal(1,"Multiplier global timeout");end
endmodule
`default_nettype wire
