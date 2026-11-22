//----------------------------------------------------------------------------//
// File name    : at_chk.v
// Author       : asic_service 
// Email        : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  : 
//----------------------------------------------------------------------------//

`include "cdma_define.v"

module at_chk(
    enc_addr0_r ,
    rstn        ,
    clk         
);

output          enc_addr0_r     ;
input   wire    clk, rstn       ;


//---- timer to stop the codec ----//
reg             enc_addr0_r     = 1'b0  ;
reg     [7:0]   enc_pre_addr    = 8'h0  ;   //actuall is counter
reg     [31:0]  enc_addr        = 32'h0 ;

wire    enc_addr0   = (enc_pre_addr == 'd200)? 1'b1 : 1'b0;

always @(posedge clk) begin  // or negedge rstn)
    if(enc_addr0)
        enc_pre_addr    <= 'd0;
    else
        enc_pre_addr    <= enc_pre_addr + 'd1;
end

always @(posedge clk) begin
    if(enc_addr0) begin
        if(enc_addr != `H264_TIMER_VALUE)
            enc_addr    <= enc_addr + 'd1;
    end
end

always @(posedge clk) begin
    if(enc_addr0 && (enc_addr == `H264_TIMER_VALUE) && (`H264_TIMER_VALUE != 'd0))
        enc_addr0_r <= 1'b1;
end

endmodule

