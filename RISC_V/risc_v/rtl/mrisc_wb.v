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
// 1: write back stage(write to regs or csr);
// 2: data phase of external mem rw;
//----------------------------------------------------------------------------//

module mrisc_wb (
    //d_aph pipe output(reged)
    d_aph_vld,
    d_aph_ack,
    d_aph_fun3,
    d_aph_reg_wr,
    d_aph_reg_wr_load,
    d_aph_reg_dsa,
    d_aph_csr_wr,
    d_aph_csr_dsa,
    d_aph_ds_val,
    d_aph_ds_val2,
    d_aph_store,
    d_aph_mret,
    d_aph_wfi,
    d_aph_pc,
    d_aph_exp_vld,
    d_aph_exp_cause,

    //d-bus(ahb-lite) data phase signals
    d_hwdata,
    d_hwbe,
    d_hready,
    d_hrdata,
    d_hresp,

    //load OP data forward
    d_dph_ext_rdata,

    //regs/csr write back
    reg_wr,
    reg_wdata,
    reg_waddr,
    csr_wr,
    csr_wdata,
    csr_waddr,

    //wb output ctrl signal
    wb_wfi,
    wb_mret,

    //exception detected
    wb_wait_trap,
    wb_exp_vld,
    wb_exp_cause,
    wb_pc,
    wb_dbus_addr,
    i_go_trap,

    clk,
    rstn
);


  input wire clk, rstn;

  //d_aph pipe handshake (reged)
  input wire d_aph_vld;
  output wire d_aph_ack;
  input wire [2:0] d_aph_fun3;
  input wire d_aph_reg_wr;
  input wire d_aph_reg_wr_load;
  input wire [4:0] d_aph_reg_dsa;
  input wire d_aph_csr_wr;
  input wire [3:0] d_aph_csr_dsa;
  input wire [31:0] d_aph_ds_val;  //value stored in: regs, ext mem addr
  input wire [31:0] d_aph_ds_val2;  //value stored in: csrs, ext mem wdata
  input wire d_aph_store;
  input wire d_aph_mret;
  input wire d_aph_wfi;
  input wire [31:0] d_aph_pc;  //pc of this instr
  input wire d_aph_exp_vld;
  input wire [3:0] d_aph_exp_cause;

  //d-bus(ahb-lite) data phase signals
  output  reg [31:0] d_hwdata;
  output  reg [3:0] d_hwbe;  //write byte enable, high active
  input wire d_hready;  //ahb-lite hready input
  input wire [31:0] d_hrdata;
  input wire d_hresp;

  output  reg [31:0] d_dph_ext_rdata;  //comb output, hrdata after shift

  //regs/csr write
  output wire reg_wr;  //1: this instr write regs
  output wire [31:0] reg_wdata;
  output wire [4:0] reg_waddr;
  output wire csr_wr;  //1: this instr write csrs
  output wire [31:0] csr_wdata;
  output wire [3:0] csr_waddr;

  //wb output ctrl signals
  output wire wb_wfi;  //wfi pass wb stage
  output wire wb_mret;  //mret pass wb stage

  //mret and data error resp intr req
  output wire wb_wait_trap;  //1: d-bus error resp detected
  output reg wb_exp_vld;  //level active, merged exceptions of this instr
  output  reg [3:0] wb_exp_cause;  //mcause of this instr
  output wire [31:0] wb_pc;  //pc addr that cause exception 
  output wire [31:0] wb_dbus_addr;  //d-bus load/store addr
  input wire i_go_trap;

  //--- 1: shift write data to proper byte location
  always @(*) begin
    case (d_aph_fun3[1:0])
      'd0: begin  //8bit write
        case (d_aph_ds_val[1:0])
          'd0: begin
            d_hwdata = d_aph_ds_val2;
            d_hwbe   = 4'b0001;
          end

          'd1: begin
            d_hwdata = {d_aph_ds_val2[31:16], d_aph_ds_val2[7:0], d_aph_ds_val2[7:0]};
            d_hwbe   = 4'b0010;
          end

          'd2: begin
            d_hwdata = {d_aph_ds_val2[31:24], d_aph_ds_val2[7:0], d_aph_ds_val2[15:0]};
            d_hwbe   = 4'b010;
          end

          'd3: begin
            d_hwdata = {d_aph_ds_val2[7:0], d_aph_ds_val2[23:0]};
            d_hwbe   = 4'b1000;
          end
        endcase
      end

      'd1: begin  //16b write
        if (d_aph_ds_val[1] == 1'b0) begin
          d_hwdata = d_aph_ds_val2;
          d_hwbe   = 4'b0011;
        end else begin
          d_hwdata = {d_aph_ds_val2[15:0], d_aph_ds_val[15:0]};
          d_hwbe   = 4'b1100;
        end
      end

      default: begin  //32b write
        d_hwdata = d_aph_ds_val2;
        d_hwbe   = 4'b1111;
      end
    endcase
  end


  //--- 2: shift hrdata to proper 32bit value that can write to regs
  reg [ 7:0] rdata_8bit;
  reg [15:0] rdata_16bit;

  always @(*) begin
    case (d_aph_ds_val[1:0])
      'd0: rdata_8bit = d_hrdata[7:0];
      'd1: rdata_8bit = d_hrdata[15:8];
      'd2: rdata_8bit = d_hrdata[23:16];
      'd3: rdata_8bit = d_hrdata[31:24];
    endcase
  end

  always @(*) begin
    if (d_aph_ds_val[1] == 1'b0) rdata_16bit = d_hrdata[15:0];
    else rdata_16bit = d_hrdata[31:16];
  end

  always @(*) begin
    case (d_aph_fun3[2:0])
      'd0:      d_dph_ext_rdata = {{24{rdata_8bit[7]}}, rdata_8bit};  //i8
      'd1:      d_dph_ext_rdata = {{16{rdata_16bit[15]}}, rdata_16bit};  //i16
      'd2, 'd3: d_dph_ext_rdata = d_hrdata;  //i32
      'd4:      d_dph_ext_rdata = {24'h0, rdata_8bit};  //u8
      'd5:      d_dph_ext_rdata = {16'h0, rdata_16bit};  //u16
      'd6, 'd7: d_dph_ext_rdata = d_hrdata;  //u32
    endcase
  end

  //--- 3: pipe handshake and regs/csr write

  assign d_aph_ack = d_hready;  //if not load/store instr, d_hready must be 1 when this instr 
                                //come to wb stage.
  assign wb_wait_trap = (!d_hready) & d_hresp;  //first T of ahb error response

  //if d-bus error response, d_aph_vld will be cleared at first T of ahb error response,
  //then will not update regs/csrs.
  assign  csr_wr      = d_aph_vld & d_aph_csr_wr & (!d_aph_mret) & (!d_aph_exp_vld); //must be 1T okay response
  assign csr_wdata = d_aph_ds_val2;
  assign csr_waddr = d_aph_csr_dsa;

  assign reg_wr = d_aph_vld & d_aph_ack & (d_aph_reg_wr | d_aph_reg_wr_load) & (!d_aph_exp_vld);
  assign reg_wdata = (d_aph_reg_wr_load) ? d_dph_ext_rdata : d_aph_ds_val;
  assign reg_waddr = d_aph_reg_dsa;

  //--- 4: pipe ctrl and exception handle
  assign wb_wfi = d_aph_vld & d_aph_wfi;  //must be 1T okay ack
  assign wb_mret = d_aph_vld & d_aph_mret;  //must be 1T okay ack
  assign wb_pc = d_aph_pc;  //if go trap, d_aph_pc and d_aph_ds_val will keep stable before
  assign wb_dbus_addr = d_aph_ds_val;  //enter trap isr

  always @(posedge clk or negedge rstn)
    if (!rstn) wb_exp_vld <= 1'b0;
    else if(wb_wait_trap || (d_aph_vld && d_aph_exp_vld))   //when (d_aph_vld && d_aph_exp_vld), must be 1T okay ack
      wb_exp_vld <= 1'b1;
    else if (i_go_trap) wb_exp_vld <= 1'b0;

  always @(posedge clk or negedge rstn)
    if (!rstn) begin
      wb_exp_cause <= 'd0;
    end else if (wb_wait_trap) begin  //wb_wait_trap and (d_aph_vld && d_aph_exp_vld) can't
      wb_exp_cause <= (d_aph_store) ? 'd7 : 'd5;  //valid at same cycle.
    end else if (d_aph_vld && d_aph_exp_vld) begin
      wb_exp_cause <= d_aph_exp_cause;
    end

endmodule

