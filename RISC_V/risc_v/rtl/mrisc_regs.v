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
// 1: 32 x 32bit internal regs.
//----------------------------------------------------------------------------//

module mrisc_regs(
    //read
    reg_rsa1        ,
    reg_rs1         ,
    reg_rsa2        ,
    reg_rs2         ,

    //write
    reg_wr          ,
    reg_wdata       ,
    reg_waddr       ,    
    
    clk             ,
    rstn             
);

parameter   REGS_NUM = 32;

input   wire            clk, rstn       ;

input   wire    [4:0]   reg_rsa1        ;   //regs read addr1
output  wire    [31:0]  reg_rs1         ;   //regs read data1, comb
input   wire    [4:0]   reg_rsa2        ;   //regs read addr2
output  wire    [31:0]  reg_rs2         ;   //regs read data2, comb

input   wire            reg_wr          ;
input   wire    [31:0]  reg_wdata       ;
input   wire    [4:0]   reg_waddr       ;

wire    [31:0]  regs    [0:REGS_NUM-1]  ;
reg     [31:0]  regs_r  [1:REGS_NUM-1]  ;

assign  reg_rs1 = regs[reg_rsa1];
assign  reg_rs2 = regs[reg_rsa2];


generate 
genvar      i;

for(i=1; i<REGS_NUM; i=i+1) begin : gen_regs_r
    always @(posedge clk or negedge rstn)
    if(~rstn) begin
        regs_r[i] <= 32'h0;       
    end else if(reg_wr && (reg_waddr == i)) begin
        regs_r[i] <= reg_wdata;
    end
end

endgenerate


assign  regs[0] = 32'h0;

generate
genvar      j;
for(j=1; j<REGS_NUM; j=j+1) begin : gen_regs
    assign  regs[j] = regs_r[j];
end
endgenerate

//--- debug purpose
//rename regs to the name of common ABI usage
wire    [31:0]  ra, sp, gp, tp;
wire    [31:0]  t0, t1, t2;
wire    [31:0]  s0;
wire    [31:0]  s1;
wire    [31:0]  a0, a1, a2, a3, a4, a5, a6, a7;
wire    [31:0]  s2, s3, s4, s5, s6, s7, s8, s9, s10, s11;
wire    [31:0]  t3, t4, t5, t6;

assign  ra = regs[1];
assign  sp = regs[2];
assign  gp = regs[3];
assign  tp = regs[4];
assign  t0 = regs[5];
assign  t1 = regs[6];
assign  t2 = regs[7];
assign  s0 = regs[8];
assign  s1 = regs[9];
assign  a0 = regs[10];
assign  a1 = regs[11];
assign  a2 = regs[12];
assign  a3 = regs[13];
assign  a4 = regs[14];
assign  a5 = regs[15];
assign  a6 = regs[16];
assign  a7 = regs[17];
assign  s2 = regs[18];
assign  s3 = regs[19];
assign  s4 = regs[20];
assign  s5 = regs[21];
assign  s6 = regs[22];
assign  s7 = regs[23];
assign  s8 = regs[24];
assign  s9 = regs[25];
assign  s10= regs[26];
assign  s11= regs[27];
assign  t3 = regs[28];
assign  t4 = regs[29];
assign  t5 = regs[30];
assign  t6 = regs[31];

endmodule

