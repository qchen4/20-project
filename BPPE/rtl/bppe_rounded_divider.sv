`timescale 1ns/1ps
`default_nettype none
// Shared integer-math divider. Guard full signed-64 inputs before narrowing
// healthy magnitudes to the existing exactly representable 53-bit domain.
// Zero divisor has priority over precision fault; nearest ties go away from 0.
module bppe_rounded_divider (
    input wire clk,rst,in_valid,
    output wire in_ready,
    input wire signed [63:0] in_numerator,in_denominator,
    output logic out_valid,
    input wire out_ready,
    output logic signed [63:0] out_quotient,
    output logic out_divzero,out_precision
);
    typedef enum logic [1:0] {IDLE,ITERATE,ROUND} phase_t;
    phase_t phase;
    logic [52:0] quotient,remainder,denominator;
    logic [5:0] remaining;
    logic negative;
    wire [63:0] magnitude_x=in_numerator[63]?(~$unsigned(in_numerator)+64'd1):$unsigned(in_numerator);
    wire [63:0] magnitude_y=in_denominator[63]?(~$unsigned(in_denominator)+64'd1):$unsigned(in_denominator);
    wire [53:0] shifted={remainder,quotient[52]};
    wire subtract=shifted>={1'b0,denominator};
    wire [53:0] reduced=subtract?(shifted-{1'b0,denominator}):shifted;
    wire [52:0] next_quotient={quotient[51:0],subtract};
    wire [53:0] rounded={1'b0,quotient}+(({remainder,1'b0}>={1'b0,denominator})?54'd1:54'd0);
    wire signed [63:0] signed_magnitude=$signed({10'd0,rounded});
    assign in_ready=!rst && phase==IDLE && (!out_valid || out_ready);
    always @(posedge clk)begin
        if(rst)begin
            phase<=IDLE;out_valid<=0;out_quotient<=0;out_divzero<=0;out_precision<=0;
            quotient<=0;remainder<=0;denominator<=0;remaining<=0;negative<=0;
        end else begin
            if(out_valid && out_ready)out_valid<=0;
            case(phase)
                IDLE:if(in_valid && in_ready)begin
                    out_divzero<=0;out_precision<=0;
                    if(in_denominator==0)begin out_quotient<=0;out_divzero<=1;out_valid<=1;end
                    else if(magnitude_x>64'd9007199254740991 || magnitude_y>64'd9007199254740991)begin
                        out_quotient<=0;out_precision<=1;out_valid<=1;
                    end else begin
                        quotient<=magnitude_x[52:0];denominator<=magnitude_y[52:0];remainder<=0;
                        negative<=in_numerator[63]^in_denominator[63];remaining<=53;phase<=ITERATE;
                    end
                end
                ITERATE:begin
                    quotient<=next_quotient;remainder<=reduced[52:0];remaining<=remaining-1'b1;
                    if(remaining==1)phase<=ROUND;
                end
                ROUND:begin out_quotient<=negative?-signed_magnitude:signed_magnitude;out_valid<=1;phase<=IDLE;end
                default:phase<=IDLE;
            endcase
        end
    end
endmodule
`default_nettype wire
