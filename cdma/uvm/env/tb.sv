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
// File name    : top.sv
// Author       : sky@SiliconThink
// Email        : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  : 
//----------------------------------------------------------------------------//

`timescale 1ns/100ps

`include "sim_define.v"

module tb;

  logic         rstn, clk   ;
  wire  [31:0]  prdata      ;
  wire          pready      ;

  sky_sys_mem#(.A_WIDTH(32))    sys_mem;


  always #(10/2.0) begin
    clk = ~clk;
  end

  // System Clock and Reset
  initial begin

    if ($test$plusargs("DUMP_FSDB")) begin
        $display("Sim with fsdb wave dump.");
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0, tb);
    end else begin
        $display("Sim without fsdb wave dump.");
    end

    rstn = 0; clk = 0;

    //--- first reset
    repeat(3) @(posedge clk);
    #1; rstn = 1;
    
  end

    //interface instance
    wire    [2:0]   awsize      ;
    wire    [1:0]   awburst     ;
    wire    [2:0]   arsize      ;
    wire    [1:0]   arburst     ;


    cdma_misc_if cdma_misc_inf(.clk(clk));
    amiq_apb_if #(.ready_low_max_time(100)) apb_inf(.clk(clk), .reset_n(rstn));
    tvip_axi_slv_if axi_inf(.aclk(clk), .areset_n(rstn));
    //the axi master interface here has no use. Just used to fix questasim error on vsim. I don't know why there is an error, as 
    //sky_axi_master_agent isn't used in this test enviroment.
    //# ** Fatal: (vsim-8451) ../axi4_uvm_vip/src/sky_axi_monitor.svh(47): Virtual interface resolution cannot find a matching instance for 'virtual tvip_axi_mas_if'.
    //#    Time: 0 ns  Iteration: 0  Region: /tvip_sky_axi_pkg::sky_axi_monitor #(virtual tvip_axi_mas_if) File: ../axi4_uvm_vip/src/sky_axi_monitor.svh
    //Possiable soluton (anyone is ok):
    //1: comment sky_axi_master related class define(driver, sqr, agent, sqc).
    //2: add one dummy tvip_axi_mas_if instance here, actually not used
    tvip_axi_mas_if axi_mas_inf(.aclk(clk), .areset_n(rstn));


    //DUT instance
    cdma     u_cdma(
	//--- APB configure inf
	.psel			(apb_inf.sel[0]		    ),
	.penable		(apb_inf.enable		    ),
	.paddr			(apb_inf.addr[7:0]      ),
	.pwrite			(apb_inf.write			),
	.pwdata			(apb_inf.wdata			),
	.pready			(pready                 ),
	.prdata			(prdata                 ),

    //--- AXI inf
	.arid          	(axi_inf.arid           ),
	.araddr        	(axi_inf.araddr         ),
	.arlen         	(axi_inf.arlen[3:0]     ),
	.arsize        	(arsize        	        ),
	.arburst       	(arburst       	        ),
	.arlock        	(   ),
	.arcache       	(axi_inf.arcache        ),
	.arprot        	(axi_inf.arprot         ),
	.arvalid       	(axi_inf.arvalid        ),
	.arready       	(axi_inf.arready        ),
	                                          
	.rid           	(axi_inf.rid            ),
	.rdata         	(axi_inf.rdata          ),
	.rresp         	(axi_inf.rresp          ),
	.rlast         	(axi_inf.rlast          ),
	.rvalid        	(axi_inf.rvalid         ),
	.rready        	(axi_inf.rready         ),
                                    
	.awid			(axi_inf.awid           ),
	.awaddr        	(axi_inf.awaddr         ),
	.awlen         	(axi_inf.awlen[3:0]     ),
	.awsize        	(awsize        	        ),
	.awburst       	(awburst       	        ),
	.awlock        	(   ),
	.awcache       	(axi_inf.awcache        ),
	.awprot        	(axi_inf.awprot         ),
	.awvalid       	(axi_inf.awvalid        ),
	.awready       	(axi_inf.awready        ),
                                              
	.wid           	(   ),
	.wdata         	(axi_inf.wdata          ),
	.wstrb         	(axi_inf.wstrb          ),
	.wlast         	(axi_inf.wlast          ),
	.wvalid        	(axi_inf.wvalid         ),
	.wready        	(axi_inf.wready         ),
	.bid           	(axi_inf.bid            ),
	.bresp         	(axi_inf.bresp          ),
	.bvalid        	(axi_inf.bvalid         ),
	.bready        	(axi_inf.bready         ),
                                    
    .intr           (cdma_misc_inf.intr     ),
                                            
    .clk            (clk                    ),
    .rstn           (rstn                   ) 
    );


    //apb master vip doesn't use clocking inteface. User add delay to
    //make signal doesn't toggle at clock rising edge.
    assign  #1 apb_inf.ready	= pready;
    assign  #1 apb_inf.rdata	= prdata;

    //apb constant signals
    assign  apb_inf.slverr      = 1'b0;
    assign  apb_inf.prot        = 'd0;
    //assign  apb_inf.sel[15:1]   = '0;

    //axi constant signals
    assign  axi_inf.arlen[7:4]  = 'd0;
    assign  axi_inf.arqos       = 'd0;

    assign  axi_inf.awlen[7:4]  = 'd0;
    assign  axi_inf.awqos       = 'd0;


    //axi inf type cast signals
    assign  axi_inf.arburst     = tvip_axi_burst_type'(arburst);
    assign  axi_inf.arsize      = tvip_axi_burst_size'(arsize);
    assign  axi_inf.awburst     = tvip_axi_burst_type'(awburst);
    assign  axi_inf.awsize      = tvip_axi_burst_size'(awsize);


    //test program
    test u_test(.apb_inf(apb_inf), .axi_inf(axi_inf), .cdma_misc_if(cdma_misc_inf));


    //pass sys_mem handle to axi interface
    initial begin
        sys_mem = new();
        axi_inf.sys_mem = sys_mem;
    end


    //--- func/sequence cover of AXI interface
    `ifdef SIM_EN_FUNC_COVERAGE

    //1: axi signal toggle coverage
    covergroup axi_toggle_coverage;
        option.per_instance = 1;

        //cover araddr
        `cover_val_8_bits(araddr_31_24, 3, axi_inf.araddr, iff(axi_inf.arvalid && axi_inf.arready))
        `cover_val_8_bits(araddr_23_16, 2, axi_inf.araddr, iff(axi_inf.arvalid && axi_inf.arready))
        `cover_val_8_bits(araddr_15_8,  1, axi_inf.araddr, iff(axi_inf.arvalid && axi_inf.arready))
        araddr_bit7: coverpoint axi_inf.araddr[7] iff(axi_inf.arvalid && axi_inf.arready);
        araddr_bit6: coverpoint axi_inf.araddr[6] iff(axi_inf.arvalid && axi_inf.arready);
        araddr_bit5: coverpoint axi_inf.araddr[5] iff(axi_inf.arvalid && axi_inf.arready);
        araddr_bit4: coverpoint axi_inf.araddr[4] iff(axi_inf.arvalid && axi_inf.arready);
        araddr_bit3: coverpoint axi_inf.araddr[3] iff(axi_inf.arvalid && axi_inf.arready);
        araddr_bit2: coverpoint axi_inf.araddr[2] iff(axi_inf.arvalid && axi_inf.arready);

        //cover awaddr
        `cover_val_8_bits(awaddr_31_24, 3, axi_inf.awaddr, iff(axi_inf.awvalid && axi_inf.awready))
        `cover_val_8_bits(awaddr_23_16, 2, axi_inf.awaddr, iff(axi_inf.awvalid && axi_inf.awready))
        `cover_val_8_bits(awaddr_15_8,  1, axi_inf.awaddr, iff(axi_inf.awvalid && axi_inf.awready))
        awaddr_bit7: coverpoint axi_inf.awaddr[7] iff(axi_inf.awvalid && axi_inf.awready);
        awaddr_bit6: coverpoint axi_inf.awaddr[6] iff(axi_inf.awvalid && axi_inf.awready);
        awaddr_bit5: coverpoint axi_inf.awaddr[5] iff(axi_inf.awvalid && axi_inf.awready);
        awaddr_bit4: coverpoint axi_inf.awaddr[4] iff(axi_inf.awvalid && axi_inf.awready);
        awaddr_bit3: coverpoint axi_inf.awaddr[3] iff(axi_inf.awvalid && axi_inf.awready);
        awaddr_bit2: coverpoint axi_inf.awaddr[2] iff(axi_inf.awvalid && axi_inf.awready);

        //cover rdata
        `cover_val_32_bits(rdata, axi_inf.rdata, iff(axi_inf.rvalid && axi_inf.rready))

        //cover wdata
        `cover_val_32_bits(wdata, axi_inf.wdata, iff(axi_inf.wvalid && axi_inf.wready))

    endgroup

    axi_toggle_coverage  axi_cov;
    
    initial begin
        axi_cov = new();
    end

    always @(posedge axi_inf.aclk or negedge axi_inf.areset_n)
    if(axi_inf.areset_n == 1) begin
        axi_cov.sample();
    end



    //2: axi sequence coverage
    property a_before_b(a, b);
        a && (!b) |=> a throughout (a&&b)[->1];
    endproperty

    property a_b_same_rise(a, b);
        $rose(a) && $rose(b);
    endproperty

    sequence ab_hs_start(a, b);
        $rose(a) or (a&&b) ##1 a;
    endsequence

    property a_0T_b(a, b);
        ab_hs_start(a, b) |-> a&&b;
    endproperty

    property a_1T_b(a, b);
        ab_hs_start(a, b) |-> (a && (!b)) ##1 (a&&b);
    endproperty

    property a_2T_b(a, b);
        ab_hs_start(a,b) |-> (a && (!b))[*2] ##1 (a&&b);
    endproperty

    property a_0T_bc(a, b, c);
        ab_hs_start(a, b) |-> a&&b&&c;
    endproperty

    property a_1T_bc(a, b, c);
        ab_hs_start(a, b) |-> (a && (!(b&&c))) ##1 a&&b&&c;
    endproperty

    property a_2T_bc(a, b, c);
        ab_hs_start(a, b) |-> (a && (!(b&&c)))[*2] ##1 a&&b&&c;
    endproperty

    //read cmd channnel valid/ready handshake waveforms
    c_arvalid_before:   cover property(@(posedge axi_inf.aclk) a_before_b(axi_inf.arvalid, axi_inf.arready));
    c_arready_before:   cover property(@(posedge axi_inf.aclk) a_before_b(axi_inf.arready, axi_inf.arvalid));
    c_ar_same:          cover property(@(posedge axi_inf.aclk) a_b_same_rise(axi_inf.arready, axi_inf.arvalid));

    c_0T_araddr: cover property(@(posedge axi_inf.aclk) a_0T_b(axi_inf.arvalid, axi_inf.arready));
    c_1T_araddr: cover property(@(posedge axi_inf.aclk) a_1T_b(axi_inf.arvalid, axi_inf.arready));
    c_2T_araddr: cover property(@(posedge axi_inf.aclk) a_2T_b(axi_inf.arvalid, axi_inf.arready));

    //read data channel valid/ready handshake waveforms
    c_rvalid_before:    cover property(@(posedge axi_inf.aclk) a_before_b(axi_inf.rvalid, axi_inf.rready));
    c_rready_before:    cover property(@(posedge axi_inf.aclk) a_before_b(axi_inf.rready, axi_inf.rvalid));
    c_r_same:           cover property(@(posedge axi_inf.aclk) a_b_same_rise(axi_inf.rready, axi_inf.rvalid));

    //rdata wait cycle (not last beat)
    c_0T_rdata: cover property(@(posedge axi_inf.aclk) a_0T_b(axi_inf.rready, (axi_inf.rvalid & (~axi_inf.rlast))) );
    c_1T_rdata: cover property(@(posedge axi_inf.aclk) a_1T_b(axi_inf.rready, (axi_inf.rvalid & (~axi_inf.rlast))) );
    c_2T_rdata: cover property(@(posedge axi_inf.aclk) a_2T_b(axi_inf.rready, (axi_inf.rvalid & (~axi_inf.rlast))) );

    //rdata wait cycle (last beat)
    c_0T_rdata_last: cover property(@(posedge axi_inf.aclk) a_0T_bc(axi_inf.rready, axi_inf.rvalid, axi_inf.rlast) );
    c_1T_rdata_last: cover property(@(posedge axi_inf.aclk) a_1T_bc(axi_inf.rready, axi_inf.rvalid, axi_inf.rlast) );
    c_2T_rdata_last: cover property(@(posedge axi_inf.aclk) a_2T_bc(axi_inf.rready, axi_inf.rvalid, axi_inf.rlast) );

    //write cmd channel valid/ready handshake waveforms
    c_awvalid_before:   cover property(@(posedge axi_inf.aclk) a_before_b(axi_inf.awvalid, axi_inf.awready));
    c_awready_before:   cover property(@(posedge axi_inf.aclk) a_before_b(axi_inf.awready, axi_inf.awvalid));
    c_aw_same:          cover property(@(posedge axi_inf.aclk) a_b_same_rise(axi_inf.awready, axi_inf.awvalid));

    c_0T_awaddr: cover property(@(posedge axi_inf.aclk) a_0T_b(axi_inf.awvalid, axi_inf.awready));
    c_1T_awaddr: cover property(@(posedge axi_inf.aclk) a_1T_b(axi_inf.awvalid, axi_inf.awready));
    c_2T_awaddr: cover property(@(posedge axi_inf.aclk) a_2T_b(axi_inf.awvalid, axi_inf.awready));

    //write data channel valid/ready handshake waveforms
    c_wvalid_before:    cover property(@(posedge axi_inf.aclk) a_before_b(axi_inf.wvalid, axi_inf.wready));
    c_wready_before:    cover property(@(posedge axi_inf.aclk) a_before_b(axi_inf.wready, axi_inf.wvalid));
    c_w_same:           cover property(@(posedge axi_inf.aclk) a_b_same_rise(axi_inf.wready, axi_inf.wvalid));

    //wdata wait cycle (not last beat)
    c_0T_wdata: cover property(@(posedge axi_inf.aclk) a_0T_b(axi_inf.wvalid & (~axi_inf.wlast), axi_inf.wready));
    c_1T_wdata: cover property(@(posedge axi_inf.aclk) a_1T_b(axi_inf.wvalid & (~axi_inf.wlast), axi_inf.wready));
    c_2T_wdata: cover property(@(posedge axi_inf.aclk) a_2T_b(axi_inf.wvalid & (~axi_inf.wlast), axi_inf.wready));

    //wdata wait cycle (last beat)
    c_0T_wdata_last: cover property(@(posedge axi_inf.aclk) a_0T_b(axi_inf.wvalid & axi_inf.wlast, axi_inf.wready));
    c_1T_wdata_last: cover property(@(posedge axi_inf.aclk) a_1T_b(axi_inf.wvalid & axi_inf.wlast, axi_inf.wready));
    c_2T_wdata_last: cover property(@(posedge axi_inf.aclk) a_2T_b(axi_inf.wvalid & axi_inf.wlast, axi_inf.wready));

    `endif  //`ifdef SIM_EN_FUNC_COVERAGE


    //3: assertion for axi read/write address channel constant output signals
    sequence axi_read_cmd_hs;
        axi_inf.arvalid && axi_inf.arready;
    endsequence

    a_arsize_2: assert property(@(posedge axi_inf.aclk) axi_read_cmd_hs |-> (axi_inf.arsize == 2))  ;
    a_arburst_1:assert property(@(posedge axi_inf.aclk) axi_read_cmd_hs |-> (axi_inf.arburst == 1)) ;
    //a_arlock_0: assert property(@(posedge axi_inf.aclk) axi_read_cmd_hs |-> (axi_inf.arlock == 0))  ;
    a_arprot_0: assert property(@(posedge axi_inf.aclk) axi_read_cmd_hs |-> (axi_inf.arprot == 0))  ;

    sequence axi_write_cmd_hs;
        axi_inf.awvalid && axi_inf.awready;
    endsequence

    a_awsize_2: assert property(@(posedge axi_inf.aclk) axi_write_cmd_hs |-> (axi_inf.awsize == 2))  ;
    a_awburst_1:assert property(@(posedge axi_inf.aclk) axi_write_cmd_hs |-> (axi_inf.awburst == 1)) ;
    //a_awlock_0: assert property(@(posedge axi_inf.aclk) axi_write_cmd_hs |-> (axi_inf.awlock == 0))  ;
    a_awprot_0: assert property(@(posedge axi_inf.aclk) axi_write_cmd_hs |-> (axi_inf.awprot == 0))  ;

endmodule : tb

