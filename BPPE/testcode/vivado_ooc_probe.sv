`timescale 1ns/1ps
`default_nettype none
// Standalone tool diagnostic. This is not a BPPE or board interface.
module vivado_ooc_probe #(parameter integer WITH_BUFG=1)(
    input wire clk, reset, enable,
    output reg [15:0] count
);
    wire core_clk;
    generate if(WITH_BUFG)begin:buffered
        BUFG clock_buffer(.I(clk),.O(core_clk));
    end else begin:unbuffered
        assign core_clk=clk;
    end endgenerate
    always @(posedge core_clk)begin
        if(reset)count<=0;
        else if(enable)count<=count+1'b1;
    end
endmodule
`default_nettype wire
