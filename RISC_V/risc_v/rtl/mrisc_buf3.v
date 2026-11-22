// ---------------------------------------------------------------------------//
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from SiliconThink.
//
//      (C) COPYRIGHT SiliconThink Limited or its affiliates
//                   ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from SiliconThink or its affiliates.
// ---------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// File name    : .v
// Author       : sky@siliconthink.cn
// E-mail       : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  :
// 1: 3-depth buffer.
//----------------------------------------------------------------------------//

module mrisc_buf3(
    buf_wr      ,
    buf_din     ,
    buf_rd      ,
    buf_dout    ,

    buf_flush   ,
    buf_empty   ,
    buf_full    ,

    clk         ,
    rstn         
);

parameter   DW = 32;


input   wire            clk, rstn       ;
input   wire            buf_wr          ;
input   wire    [DW-1:0]buf_din         ;
input   wire            buf_rd          ;
output  reg     [DW-1:0]buf_dout        ;

input   wire            buf_flush       ;
output  reg             buf_empty       ;
output  reg             buf_full        ;


reg     [DW-1:0]    mem [0:2]   ;
reg     [2:0]       wptr, rptr  ;
reg     [2:0]       wptr_nxt    ;
reg     [2:0]       rptr_nxt    ;

always @(*) begin
    if(buf_flush)
        wptr_nxt = 'd0;
    else if(buf_wr) begin
        if(wptr[1:0] == 'd2)
            wptr_nxt= {~wptr[2], 2'b00};
        else
            wptr_nxt= wptr + 'd1;
    end else begin
        wptr_nxt = wptr;
    end
end

always @(*) begin
    if(buf_flush)
        rptr_nxt = 'd0;
    else if(buf_rd) begin
        if(rptr[1:0] == 'd2)
            rptr_nxt= {~rptr[2], 2'b00};
        else
            rptr_nxt= rptr + 'd1;
    end else begin
        rptr_nxt = rptr;
    end
end


always @(posedge clk or negedge rstn)
if(~rstn)
    wptr    <= 'd0;
else if(buf_flush || buf_wr)
    wptr    <= wptr_nxt;

always @(posedge clk or negedge rstn)
if(~rstn)
    rptr    <= 'd0;
else if(buf_flush || buf_rd)
    rptr    <= rptr_nxt;

always @(posedge clk or negedge rstn)
if(~rstn)
    buf_empty   <= 1'b1;
else if(buf_flush || buf_rd || buf_wr) begin
    if(rptr_nxt == wptr_nxt)
        buf_empty   <= 1'b1;
    else
        buf_empty   <= 1'b0;
end

always @(posedge clk or negedge rstn)
if(~rstn)
    buf_full    <= 1'b0;
else if(buf_flush || buf_rd || buf_wr) begin
    if((rptr_nxt[2] != wptr_nxt[2]) && (rptr_nxt[1:0] == wptr_nxt[1:0]))
        buf_full    <= 1'b1;
    else
        buf_full    <= 1'b0;
end


always @(posedge clk) begin   // or negedge rstn)
if(buf_wr && (wptr[1:0] == 'd0))
   mem[0]   <=  buf_din;

if(buf_wr && (wptr[1:0] == 'd1))
   mem[1]   <=  buf_din;

if(buf_wr && (wptr[1:0] == 'd2))
   mem[2]   <=  buf_din;
end


always @(*) begin
    case(rptr[1:0])
    'd0:    buf_dout = mem[0];
    'd1:    buf_dout = mem[1];
    default:buf_dout = mem[2];
    endcase
end

endmodule

