`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Binary pointer + Gray-code pointer. Increment when inc is asserted.
////////////////////////////////////////////////////////////////////////////////
module fifo_ptr_gen #(
    parameter PTR_WIDTH = 5
) (
    input  wire                 clk,
    input  wire                 rst_n,
    input  wire                 inc,
    output reg  [PTR_WIDTH-1:0] ptr_bin,
    output reg  [PTR_WIDTH-1:0] ptr_gray
);

    wire [PTR_WIDTH-1:0] bin_next  = ptr_bin + inc;
    wire [PTR_WIDTH-1:0] gray_next = (bin_next >> 1) ^ bin_next;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ptr_bin  <= {PTR_WIDTH{1'b0}};
            ptr_gray <= {PTR_WIDTH{1'b0}};
        end else begin
            ptr_bin  <= bin_next;
            ptr_gray <= gray_next;
        end
    end

endmodule
