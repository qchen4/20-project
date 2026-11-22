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
// 1: address phase of external data rw;
//----------------------------------------------------------------------------//

module mrisc_d_aph(
    //exe pipe output (reged)
    exe_vld         ,
    exe_ack         ,
    exe_fun3        ,
    exe_reg_wr      ,
    exe_reg_wr_load ,
    exe_reg_dsa     ,
    exe_csr_wr      ,
    exe_csr_dsa     ,
    exe_ds_val      ,
    exe_ds_val2     ,
    exe_store       ,
    exe_mret        ,
    exe_wfi         ,
    exe_pc          ,
    exe_exp_vld     ,
    exe_exp_cause   ,

    //flow ctrl signal
    wb_wait_trap    ,

    //d_aph pipe output(reged)
    d_aph_vld       ,
    d_aph_ack       ,
    d_aph_fun3      ,
    d_aph_reg_wr    ,
    d_aph_reg_wr_load,
    d_aph_reg_dsa   ,
    d_aph_csr_wr    ,
    d_aph_csr_dsa   ,
    d_aph_ds_val    ,
    d_aph_ds_val2   ,
    d_aph_store     ,
    d_aph_mret      ,
    d_aph_wfi       ,
    d_aph_pc        ,
    d_aph_exp_vld   ,
    d_aph_exp_cause ,

    //d-bus(ahb-lite) cmd phase singals
	d_haddr			,
	d_hburst		,
	d_htrans		,
	d_hsize			,
	d_hprot			,
	d_hwrite		,
    d_hmastlock     ,
    d_hready        ,

    clk             ,
    rstn             
);


input   wire            clk, rstn       ;
//exe pipe handshake (reged)
input   wire            exe_vld         ;
output  wire            exe_ack         ;
input   wire    [2:0]   exe_fun3        ;
input   wire            exe_reg_wr      ;
input   wire            exe_reg_wr_load ;
input   wire    [4:0]   exe_reg_dsa     ;
input   wire            exe_csr_wr      ;
input   wire    [3:0]   exe_csr_dsa     ;
input   wire    [31:0]  exe_ds_val      ;   //value stored in: regs, ext mem addr
input   wire    [31:0]  exe_ds_val2     ;   //value stored in: csrs, ext mem wdata
input   wire            exe_store       ;
input   wire            exe_mret        ;
input   wire            exe_wfi         ;
input   wire    [31:0]  exe_pc          ;   //pc of this instr
input   wire            exe_exp_vld     ;
input   wire    [3:0]   exe_exp_cause   ;

input   wire            wb_wait_trap    ;

//d_aph pipe handshake (reged)
output  reg             d_aph_vld       ;
input   wire            d_aph_ack       ;
output  reg     [2:0]   d_aph_fun3      ;
output  reg             d_aph_reg_wr    ;
output  reg             d_aph_reg_wr_load;
output  reg     [4:0]   d_aph_reg_dsa   ;
output  reg             d_aph_csr_wr    ;
output  reg     [3:0]   d_aph_csr_dsa   ;
output  reg     [31:0]  d_aph_ds_val    ;   //value stored in: regs, ext mem addr
output  reg     [31:0]  d_aph_ds_val2   ;   //value stored in: csrs, ext mem wdata
output  reg             d_aph_store     ;
output  reg             d_aph_mret      ;
output  reg             d_aph_wfi       ;
output  reg     [31:0]  d_aph_pc        ;   //pc of this operation
output  reg             d_aph_exp_vld   ;
output  reg     [3:0]   d_aph_exp_cause ;

//d-bus(ahb-lite) cmd phase singals
output  wire	[31:0]	d_haddr		;
output  wire	[2:0]	d_hburst	;
output  wire	[1:0]	d_htrans	;
output  wire	[2:0]	d_hsize		;
output  wire	[3:0]	d_hprot		;
output  wire		    d_hwrite	;
output  wire            d_hmastlock ;
input   wire            d_hready    ;   


wire            d_areq  ;

//if load/store with address unaligned exception, don't put this trans on d-bus
assign  d_areq      = exe_vld & (exe_reg_wr_load | exe_store) & (!exe_exp_vld);
assign  d_haddr     = exe_ds_val;
assign  d_hburst    = 3'h0;                     //single
assign  d_htrans    = (d_areq)? 2'b10 : 2'b00;  //nonseq : idle
assign  d_hsize     = exe_fun3[1:0];
assign  d_hprot     = 4'b1111;                  //cacheable, bufferable, privileged, data;
                                                //d_hprot can be controlled more precisely by other module.
assign  d_hwrite    = exe_store;
assign  d_hmastlock = 1'b0;

assign  exe_ack = d_hready;


always @(posedge clk or negedge rstn)
if(~rstn)
    d_aph_vld   <= 1'b0;
else if(wb_wait_trap)
    d_aph_vld   <= 1'b0;
else if(exe_ack && exe_vld)
    d_aph_vld   <= 1'b1;
else if(d_aph_ack)
    d_aph_vld   <= 1'b0;


always @(posedge clk)   // or negedge rstn)
if((exe_ack && exe_vld) && (!wb_wait_trap)) begin   //if flush, don't load new info from exe stage.
    d_aph_fun3      <= exe_fun3     ;               //d_aph_pc need keep stable, it will be used as
    d_aph_reg_wr    <= exe_reg_wr   ;               //mepc for exceptions.
    d_aph_reg_wr_load<=exe_reg_wr_load;             //d_aph_ds_val need keep stable, it will be used
    d_aph_reg_dsa   <= exe_reg_dsa  ;               //as mtval for load/store d-bus error resp exception.
    d_aph_csr_wr    <= exe_csr_wr   ;
    d_aph_csr_dsa   <= exe_csr_dsa  ;
    d_aph_ds_val    <= exe_ds_val   ;
    d_aph_ds_val2   <= exe_ds_val2  ;
    d_aph_store     <= exe_store    ;
    d_aph_mret      <= exe_mret     ;    
    d_aph_wfi       <= exe_wfi      ;
    d_aph_pc        <= exe_pc       ;
    d_aph_exp_vld   <= exe_exp_vld  ;
    d_aph_exp_cause <= exe_exp_cause;
end

endmodule

