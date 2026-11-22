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
// 1: basic CSR;
// 2: interrupt (intr and exception) control;
//----------------------------------------------------------------------------//

module mrisc_csr_intr(
    //csr read/write
    csr_rsa         ,
    csr_rs          ,
    csr_wr          ,
    csr_wdata       ,
    csr_waddr       ,
    
    //external irq
    ext_irq         ,
    clk_req         ,

    //wb to intr_ctrl(comb)
    wb_wfi          ,
    wb_mret         ,

    //write back to intr_ctrl
    wb_exp_vld      ,
    wb_exp_cause    ,
    wb_pc           ,
    wb_dbus_addr    ,

    //CSR and interrupt req inf
    irq_wait_trap   ,
    trap_req        ,
    trap_ack        ,
    i_go_trap       ,
    cpu_idle        ,
    csr_mtvec       ,
    csr_mcause      ,
    csr_mepc        ,
    pc              ,

    clk             ,
    clk_awo         ,
    rstn         
);


input   wire            clk, rstn       ;   //when clk_req=0, clk can be gated off
input   wire            clk_awo         ;   //always on clk, sync with clk, can't be clock gated

//csr read/write
input   wire    [3:0]   csr_rsa         ;
output  reg     [31:0]  csr_rs          ;   //combination output
input   wire            csr_wr          ;
input   wire    [31:0]  csr_wdata       ;
input   wire    [3:0]   csr_waddr       ;

//external irq
input   wire            ext_irq         ;   //high level active
output  reg             clk_req         ;   //1: need clk running; 0: clk can be gated off

//exe to intr_ctrl(comb)
input   wire            wb_wfi          ;
input   wire            wb_mret         ;

//write back to intr_ctrl
input   wire            wb_exp_vld      ;   //level active
input   wire    [3:0]   wb_exp_cause    ;
input   wire    [31:0]  wb_pc           ;   //pc addr that cause exception
input   wire    [31:0]  wb_dbus_addr    ;   //d-bus load/store addr

//CSR and intr inf
output  wire            irq_wait_trap   ;   //level active, async intr is pending
output  reg             trap_req        ;   //irq req, high level active; must keep 1'b1 until trap_ack=1
input   wire            trap_ack        ;   //irq ack, trap_ack == i_go_trap
input   wire            i_go_trap       ;   //1T pulse, pc change to trap begin point
input   wire            cpu_idle        ;   //from ifetch to write back stage and I/D-bus are all idle
output  reg     [31:0]  csr_mtvec       ;   //trap begin point
output  reg     [31:0]  csr_mcause      ;   //{intr, cause}
output  reg     [31:0]  csr_mepc        ;   //trap return point. When enter trap isr:
                                            //if intr: point to next instr that will fetch.
                                            //if exception: point to the instr that cause the exception.
input   wire    [31:0]  pc              ;   //for async interrupt, point to instr that will fetch after mret instr.

//--- 0: CSR addr encode
//0:always return 0, 1:mstatus
//2:mie, 3:mip, 4:mtvec, 5:mepc, 6:mcause
//7:mtval, 15:misa

//mstatus bits
reg             mie, mpie           ;   //m-mode intr global enable and previous enable
wire    [31:0]  csr_mstatus         ;

reg             mtie, meie, msie    ;   //m-mode intr source enable
wire    [31:0]  csr_mie             ;

wire            mtip                ;   //m-mode intr pending
reg             meip, msip          ;
wire    [31:0]  csr_mip             ;
wire            async_intr_pend     ;   //1: this is some async interrupt pending now, level active

reg     [31:0]  csr_mtval           ;   //tval of current trap_req
wire    [31:0]  csr_misa            ;

//bits in mstatus
always @(posedge clk or negedge rstn)
if(~rstn)
    mie <= 1'b0;
else if(csr_wr && (csr_waddr == 'd1))
    mie <= csr_wdata[3];
else if(trap_req && trap_ack)
    mie <= 1'b0;
else if(wb_mret)
    mie <= mpie;

always @(posedge clk or negedge rstn)
if(~rstn)
    mpie    <= 1'b0;
else if(csr_wr && (csr_waddr == 'd1))
    mpie    <= csr_wdata[7];
else if(trap_req && trap_ack)
    mpie    <= mie;
else if(wb_mret)
    mpie    <= 1'b1;


//bits in MIE 
always @(posedge clk or negedge rstn)
if(~rstn) begin
    msie    <= 1'b0;
    mtie    <= 1'b0;
    meie    <= 1'b0;
end else if(csr_wr && (csr_waddr == 'd2)) begin
    msie    <= csr_wdata[3];
    mtie    <= csr_wdata[7];
    meie    <= csr_wdata[11];
end

//bits in mip
always @(posedge clk or negedge rstn)
if(~rstn)
    msip    <= 1'b0;
else if(csr_wr && (csr_waddr == 'd3))
    msip    <= csr_wdata[3];

assign  mtip    = 1'b0;

always @(posedge clk_awo or negedge rstn)
if(~rstn)
    meip    <= 1'b0;
else
    meip    <= ext_irq;


always @(posedge clk or negedge rstn)
if(~rstn)
    csr_mtvec   <= 32'h0;
else if(csr_wr && (csr_waddr == 'd4))
    csr_mtvec   <= {csr_wdata[31:2], 1'b0, csr_wdata[0]};
    //csr_mtvec   <= {31'h0, csr_wdata[0]};   //fix interrupt/exception vector start addr to 0x0000


//trap generate
wire    trap_sel_point  ;

//bug when there is an exception between async_intr_pend=1 and i_go_trap. This exception is lost.
//assign  trap_sel_point = (!trap_req) & (async_intr_pend | wb_exp_vld);
assign  trap_sel_point = (!trap_req) & (async_intr_pend | wb_exp_vld) & cpu_idle;

always @(posedge clk or negedge rstn)
if(~rstn)
    trap_req <= 1'b0;
else if(trap_req && trap_ack)
    trap_req <= 1'b0;
else if(trap_sel_point)   //mie just mask out intrs, not exceptions
    trap_req <= 1'b1;

always @(posedge clk or negedge rstn)
if(!rstn)
    csr_mcause  <= 'd0;
else if(trap_sel_point) begin
    if(wb_exp_vld)
        csr_mcause  <= {1'b0, 27'h0, wb_exp_cause};
    else if(mie) begin
        if(meie & meip)
            csr_mcause  <= {1'b1, 31'd11};
        else if(msie & msip)
            csr_mcause  <= {1'b1, 31'd3};
        else if(mtie & mtip)
            csr_mcause  <= {1'b1, 31'd7};
    end
end

always @(posedge clk or negedge rstn)
if(~rstn)
    csr_mepc    <= 32'h0;
else if(trap_sel_point) begin
    if(wb_exp_vld)
        csr_mepc    <= {wb_pc[31:2], 2'h0}; //PC that cause this exception
    else
        csr_mepc    <= {pc[31:2], 2'h0};    //PC will fetch after async interrupt isr
end else if(csr_wr && (csr_waddr == 'd5))
    csr_mepc   <= {csr_wdata[31:2], 2'h0};

always @(posedge clk or negedge rstn)
if(!rstn)
    csr_mtval   <= 'd0;
else if(trap_sel_point) begin
    if(wb_exp_vld && (wb_exp_cause[3:2] == 2'b01))  //wb_exp_cause=4,5,6,7
        csr_mtval   <= wb_dbus_addr;                //used only for d-bus error, d-bus addr unalign exception
end

//                             MPP
assign  csr_mstatus = {19'h0, 2'b11, 2'b0, 1'b0, mpie, 3'h0, mie, 3'h0};
assign  csr_mie     = {16'h0, 4'h0, meie, 3'h0, mtie, 3'h0, msie, 3'h0};
assign  csr_mip     = {16'h0, 4'h0, meip, 3'h0, mtip, 3'h0, msip, 3'h0};
assign  csr_misa    = {2'b01, 14'h0, 
                      3'h0, 1'b1, 3'h0, 1'b1, 8'h0};    //RV32IM

assign  async_intr_pend= (|(csr_mip & csr_mie)) & mie;
assign  irq_wait_trap  = async_intr_pend;

always @(*) begin
    if(csr_rsa[3] == 1'b0) begin
        case(csr_rsa[2:0])
        'd0:    csr_rs  = 'd0;
        'd1:    csr_rs  = csr_mstatus;
        'd2:    csr_rs  = csr_mie;
        'd3:    csr_rs  = csr_mip;
        'd4:    csr_rs  = csr_mtvec;
        'd5:    csr_rs  = csr_mepc;
        'd6:    csr_rs  = csr_mcause;
        'd7:    csr_rs  = csr_mtval;
        endcase
    end else begin
        case(csr_rsa[2:0])
        'd7:    csr_rs  = csr_misa;
        default:csr_rs  = 'd0;
        endcase
    end
end


//--- wfi clk gating control
reg         wb_wfi_reg     ;

always @(posedge clk_awo or negedge rstn)
if(!rstn)
    wb_wfi_reg <= 1'b0;
else if(async_intr_pend)  //when async intr comes, doesn't gate clk
    wb_wfi_reg <= 1'b0;
else if(wb_wfi)
    wb_wfi_reg <= 1'b1;

always @(posedge clk_awo or negedge rstn)
if(!rstn)
    clk_req <= 1'b1;
else if(async_intr_pend)        //when intr comes, doesn't gate clk;
    clk_req <= 1'b1;
else if(wb_wfi_reg && cpu_idle) //when clk gating off, all cpu pipe stage and I/D bus are idle.
    clk_req <= 1'b0;            //cpu_idle make sure pipe stages and i-bus are idle; 
                                //wb_wfi make sure d-bus is idle.
endmodule

