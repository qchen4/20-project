`timescale 1ns/1ps
`default_nettype none
// Exact replacement for the reference mulq guard, including its asymmetric
// zero rule: an out-of-domain first operand faults even when y is zero;
// x=0 and an out-of-domain second operand is a valid zero product.
module bppe_guarded_multiplier (
    input wire clk,rst,in_valid,
    output wire in_ready,
    input wire signed [63:0] in_x,in_y,
    output logic out_valid,
    input wire out_ready,
    output logic signed [63:0] out_product,
    output logic out_precision
);
    typedef enum logic [1:0] {IDLE,MULTIPLY,CHECK} phase_t;
    phase_t phase;
    wire [63:0] abs_x=in_x[63]?(~$unsigned(in_x)+64'd1):$unsigned(in_x);
    wire [63:0] abs_y=in_y[63]?(~$unsigned(in_y)+64'd1):$unsigned(in_y);
    logic [52:0] x,y;
    logic [105:0] product;
    logic negative,invalid_operand;
    wire signed [63:0] magnitude=$signed({11'd0,product[52:0]});
    assign in_ready=!rst && phase==IDLE && (!out_valid || out_ready);
    always @(posedge clk) begin
        if(rst) begin
            phase<=IDLE;out_valid<=0;out_product<=0;out_precision<=0;
            x<=0;y<=0;product<=0;negative<=0;invalid_operand<=0;
        end else begin
            if(out_valid && out_ready)out_valid<=0;
            case(phase)
                IDLE:if(in_valid && in_ready)begin
                    x<=abs_x[52:0];y<=abs_y[52:0];negative<=in_x[63]^in_y[63];
                    invalid_operand<=(abs_x>64'd9007199254740991) ||
                        ((abs_y>64'd9007199254740991) && abs_x!=0);
                    phase<=MULTIPLY;
                end
                MULTIPLY:begin product<=x*y;phase<=CHECK;end
                CHECK:begin
                    out_precision<=invalid_operand || (|product[105:53]);
                    out_product<=(invalid_operand || (|product[105:53]))?64'sd0:(negative?-magnitude:magnitude);
                    out_valid<=1;phase<=IDLE;
                end
                default:phase<=IDLE;
            endcase
        end
    end
endmodule
`default_nettype wire
