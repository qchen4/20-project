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
//----------------------------------------------------------------------------//

module mrisc_exe_addsub(
    dec_opd0_use_pc ,
    dec_opd1_use_offset,
    dec_op_sign     ,
    dec_add_sub     ,
    dec_opd0        ,
    dec_opd1        ,
    dec_opd2        ,
    dec_pc          ,
    
    add_sub33    
);


input   wire            dec_opd0_use_pc ;
input   wire            dec_opd1_use_offset;
input   wire            dec_op_sign     ;
input   wire            dec_add_sub     ;
input   wire    [31:0]  dec_opd0        ;
input   wire    [31:0]  dec_opd1        ;
input   wire    [31:0]  dec_opd2        ;
input   wire    [31:0]  dec_pc          ;
    
output  wire    [32:0]  add_sub33       ;


wire    [31:0]  opd0_mux    ;
wire    [31:0]  opd1_mux    ;
wire    [32:0]  opd0, opd1  ;   //sign extension
wire    [32:0]  opd1_sub    ;

assign  opd0_mux= (dec_opd0_use_pc)?    dec_pc : dec_opd0;
assign  opd1_mux= (dec_opd1_use_offset)?dec_opd2 : dec_opd1;
assign  opd0    = (dec_op_sign)? {opd0_mux[31], opd0_mux} : {1'b0, opd0_mux};
assign  opd1    = (dec_op_sign)? {opd1_mux[31], opd1_mux} : {1'b0, opd1_mux};
assign  opd1_sub= (dec_add_sub)? ((~{opd1}) + 1'b1) : opd1;
assign  add_sub33= opd0 + opd1_sub;

endmodule

