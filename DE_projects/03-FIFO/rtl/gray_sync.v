`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Two-flop synchronizer for a Gray-coded pointer (single-bit change per step).
////////////////////////////////////////////////////////////////////////////////
module gray_sync #(
    parameter WIDTH = 5
) (
    input  wire             dst_clk,
    input  wire             dst_rst_n,
    input  wire [WIDTH-1:0] src_gray,
    output reg  [WIDTH-1:0] dst_gray
);

    reg [WIDTH-1:0] gray_meta;

    always @(posedge dst_clk or negedge dst_rst_n) begin
        if (!dst_rst_n) begin
            gray_meta <= {WIDTH{1'b0}};
            dst_gray  <= {WIDTH{1'b0}};
        end else begin
            gray_meta <= src_gray;
            dst_gray  <= gray_meta;
        end
    end

endmodule
