// 文件说明 tb.sv
// I-Cache 仿真顶层，连接 DUT、AHB VIP 接口和 UVM 测试入口。
// 产生时钟与低有效复位，按 DUMP_FSDB 开关记录波形，导出内部信号供检查。
// 此处 m_ahb 是上游 Master Agent 接口，连接 DUT 的 s_ahb；s_ahb 连接 DUT 的 m_ahb。
// DUT 组索引位宽来自 sim_define.v；标签内部观察路径依赖 icache_tag.vp 的层次名称。
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

`timescale 1ns/1ns

`include "sim_define.v"

module tb;

  logic         rstn, clk   ;
  logic         m_hreadyout ;
  logic         m_hresp     ;
  logic         s_hresp     ;

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
    #1; rstn = 0;
    repeat(3) @(posedge clk);
    #1; rstn = 1;
    
    /*
    repeat(40) @(posedge clk);
   
    //--- second reset
    #1; rstn = 0;
    repeat(3) @(posedge clk);
    #1; rstn = 1;
    */
  end

    //interface instance
    yuu_ahb_master_interface  m_ahb();
    yuu_ahb_slave_interface   s_ahb();

    //DUT internal signal monitor infterface
    i_cache_misc_interface    dut_misc(
        .clk            (clk            ), 
        .rstn           (rstn           ),
	    //--- upstream ahb-lite slave interface
	    .s_hsel			(1'b1           ),
	    .s_haddr		(m_ahb.haddr	),
	    .s_hburst		(m_ahb.hburst	),
	    .s_htrans		(m_ahb.htrans	),
	    .s_hsize		(m_ahb.hsize	),
	    .s_hprot		(m_ahb.hprot	),
	    .s_hwrite		(m_ahb.hwrite	),
	    .s_hwdata		(m_ahb.hwdata	),
        .s_hmastlock    (m_ahb.hmastlock),
	    .s_hready		(m_ahb.hready_i ),
	    .s_hrdata		(m_ahb.hrdata	),
	    .s_hresp		(m_hresp	    ),

        //--- downstream ahb-master interface
	    .m_hsel			(s_ahb.hsel     ),
	    .m_haddr		(s_ahb.haddr	),
	    .m_hburst		(s_ahb.hburst	),
	    .m_htrans		(s_ahb.htrans	),
	    .m_hsize		(s_ahb.hsize	),
	    .m_hprot		(s_ahb.hprot	),
	    .m_hwrite		(s_ahb.hwrite	),
	    .m_hwdata		(s_ahb.hwdata	),
        .m_hmastlock    (s_ahb.hmastlock),
	    .m_hready		(s_ahb.hready_i ),
	    .m_hrdata		(s_ahb.hrdata   ),
	    .m_hresp		(s_hresp        )
    );

    //m-ahb/s-ahb interface signal connection
    assign  m_ahb.hclk      = clk;
    assign  m_ahb.hreset_n  = rstn;
    assign  m_ahb.hexokay   = 1'b0; 
    assign  #1 m_ahb.hready_i= m_hreadyout;
    assign  #1 m_ahb.hresp  = {1'b0, m_hresp};

    assign  s_ahb.hclk      = clk;
    assign  s_ahb.hreset_n  = rstn;
    assign  #1 s_ahb.hready_i = s_ahb.hready_o;
    assign  #1 s_hresp      = s_ahb.hresp[0];
    assign  s_ahb.hmaster   = 'd0;
    assign  s_ahb.hprot_emt = 'd0;
    assign  s_ahb.hnonsec   = 1'b0;
    assign  s_ahb.excl_write_enable = 1'b0;

    //DUT monitor signals
    assign  dut_misc.s_ahb_cache_en = tb.u_icache_ahb.s_ahb_cache_en;
    assign  dut_misc.s_cache_sta    = tb.u_icache_ahb.s_cache_sta;
    assign  dut_misc.hit_chk_point= tb.u_icache_ahb.u_icache_tag.hit_chk_point;
    assign  dut_misc.tag_info_used= tb.u_icache_ahb.u_icache_tag.tag_info_used;
    assign  dut_misc.chk_haddr_d  = tb.u_icache_ahb.u_icache_tag.chk_haddr_d;
    assign  dut_misc.w0_hit       = tb.u_icache_ahb.u_icache_tag.w0_hit;
    assign  dut_misc.w1_hit       = tb.u_icache_ahb.u_icache_tag.w1_hit;
    assign  dut_misc.w2_hit       = tb.u_icache_ahb.u_icache_tag.w2_hit;
    assign  dut_misc.w3_hit       = tb.u_icache_ahb.u_icache_tag.w3_hit;
    assign  dut_misc.fill_hit     = tb.u_icache_ahb.u_icache_tag.fill_hit;
    assign  dut_misc.cache_miss   = tb.u_icache_ahb.u_icache_tag.cache_miss;


    //DUT instance
    icache_ahb #(.index_bits(`INDEX_BITS) ) u_icache_ahb(  //4KB i-cache
    .icache_en      (dut_misc.icache_en),
	//--- upstream ahb-lite slave interface
	.s_hsel			(1'b1           ),
	.s_haddr		(m_ahb.haddr	),
	.s_hburst		(m_ahb.hburst	),
	.s_htrans		(m_ahb.htrans	),
	.s_hsize		(m_ahb.hsize	),
	.s_hprot		(m_ahb.hprot	),
	.s_hwrite		(m_ahb.hwrite	),
	.s_hwdata		(m_ahb.hwdata	),
    .s_hmastlock    (m_ahb.hmastlock),
	.s_hready		(m_ahb.hready_i ),
	.s_hreadyout	(m_hreadyout    ),
	.s_hrdata		(m_ahb.hrdata	),
	.s_hresp		(m_hresp	    ),

    //--- downstream ahb-master interface
	.m_hsel			(s_ahb.hsel     ),
	.m_haddr		(s_ahb.haddr	),
	.m_hburst		(s_ahb.hburst	),
	.m_htrans		(s_ahb.htrans	),
	.m_hsize		(s_ahb.hsize	),
	.m_hprot		(s_ahb.hprot	),
	.m_hwrite		(s_ahb.hwrite	),
	.m_hwdata		(s_ahb.hwdata	),
    .m_hmastlock    (s_ahb.hmastlock),
	.m_hready		(s_ahb.hready_i ),
	.m_hrdata		(s_ahb.hrdata   ),
	.m_hresp		(s_hresp        ),

    .clk            (clk            ),
    .rstn           (rstn           )  
    );

    //test program
    test u_test(.m_ahb(m_ahb), .s_ahb(s_ahb), .dut_misc(dut_misc));

    m_ahb_cyc_coverage m_cyc_coverage(.ahb_io(m_ahb));

endmodule : tb

