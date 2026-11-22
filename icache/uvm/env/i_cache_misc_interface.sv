// 文件说明 i_cache_misc_interface.sv
// 汇集总线与内部状态的验证接口，并承载时序覆盖和断言。
// drv_cb 驱动 icache_en，mon_cb 统一采样；接口重建 WRAP4 数据阶段和末拍事件。
// 提供标签 RAM 层次读取函数，包含使能状态转换、两拍 ERROR 响应等检查。
// 部分状态由 tb 层次连接，部分由总线推导；修改层次或时序时需同步检查采样关系。

`include "sim_define.v"

interface i_cache_misc_interface(
    input logic         clk         , 
    input logic         rstn        ,

	//--- upstream ahb-lite slave interface
    input logic 		s_hsel		,
    input logic [31:0]	s_haddr		,
    input logic [2:0]	s_hburst	,
    input logic [1:0]	s_htrans	,
    input logic [2:0]	s_hsize		,
    input logic [3:0]	s_hprot		,
    input logic 		s_hwrite	,
    input logic [31:0]	s_hwdata	,
    input logic         s_hmastlock ,
    input logic 		s_hready	,
    input logic [31:0]	s_hrdata	,
    input logic         s_hresp		,

    //--- downstream ahb-master interface
    input logic		    m_hsel		,
    input logic [31:0]	m_haddr		,
    input logic [2:0]	m_hburst	,
    input logic [1:0]	m_htrans	,
    input logic [2:0]	m_hsize		,
    input logic [3:0]	m_hprot		,
    input logic 	    m_hwrite	,
    input logic [31:0]	m_hwdata	,
    input logic         m_hmastlock ,
    input logic 		m_hready    ,
    input logic [31:0]	m_hrdata	,
    input logic         m_hresp		
);


    //--- contrl signal, drive by agent
    logic           icache_en       ;

    //monitor DUT internal signals
    //signals used to control the behavior of ref model
    logic           s_ahb_cache_en  ;
    //signals used to do data compare only
    logic           hit_chk_point   ;   //monitor info latch point
    logic   [`TAG_MEM_WIDTH-1 :0]   tag_info_used   ;
    logic   [31:0]  chk_haddr_d     ;
    logic           w0_hit, w1_hit, w2_hit, w3_hit  ;
    logic           fill_hit        ;
    logic           cache_miss      ;
    logic   [1:0]   s_cache_sta     ;

    //signals generate in this interface to help ref model and data compare
    logic           s_vld_cmd       ;
    logic           s_idle_cmd      ;
    logic           s_cacheable_inst;
    logic           m_wrap_dphase   ;
    logic           cache_line_wr   ;
    logic   [1:0]   m_wrap_dph_beat_cnt;

// 时钟块约定驱动与采样偏移，避免测试平台和 DUT 在同一仿真时刻竞争。
  clocking drv_cb @(posedge clk);
    default input #1 output #1;
    output      icache_en   ;
  endclocking : drv_cb


  clocking mon_cb @(posedge clk);
    default input #1 output #1;

    input   icache_en   ;
    
	//--- upstream ahb-lite slave interface
    input   s_hsel		;
    input   s_haddr		;
    input   s_hburst	;
    input   s_htrans	;
    input   s_hsize		;
    input   s_hprot		;
    input   s_hwrite	;
    input   s_hwdata	;
    input   s_hmastlock ;
    input   s_hready	;
    input   s_hrdata	;
    input   s_hresp		;

    //--- downstream ahb-master interface
    input   m_hsel		;
    input   m_haddr		;
    input   m_hburst	;
    input   m_htrans	;
    input   m_hsize		;
    input   m_hprot		;
    input   m_hwrite	;
    input   m_hwdata	;
    input   m_hmastlock ;
    input   m_hready    ;
    input   m_hrdata	;
    input   m_hresp		;

    input   hit_chk_point   ;   //monitor info latch point
    input   tag_info_used   ;
    input   chk_haddr_d     ;
    input   w0_hit, w1_hit, w2_hit, w3_hit  ;
    input   fill_hit        ;
    input   cache_miss      ;
    input   s_cache_sta     ;

    input   s_ahb_cache_en  ;
    input   s_vld_cmd       ;
    input   s_idle_cmd      ;
    input   s_cacheable_inst;   //may also be bypassed if s_ahb_cache_en=0
    input   m_wrap_dphase   ;
    input   cache_line_wr   ;
  endclocking


  //--- 1: signal to help ref model and data compare
  parameter [2:0] ahb_single = 'd0, ahb_wrap4 = 'd2;
  parameter [1:0] ahb_idle   = 'd0, ahb_busy  = 'd1, ahb_nonseq = 'd2, ahb_seq = 'd3;

  logic     m_ahb_wrap4_cmd         ;
  logic     m_ahb_wrap4_last_beat   ;


  assign    s_vld_cmd       = s_hsel & s_hready & (s_htrans == ahb_nonseq) & rstn;
  assign    s_idle_cmd      = s_hsel & s_hready & (s_htrans == ahb_idle) & rstn;
  assign    s_cacheable_inst= s_hsel & s_hready & (s_htrans == ahb_nonseq) & rstn & (!s_hwrite) &
                              (!s_hprot[0]) & s_hprot[3] & (!s_hmastlock);
  assign    m_ahb_wrap4_cmd = m_hsel & m_hready & (m_htrans == ahb_nonseq)
                              & (m_hburst == ahb_wrap4) & rstn;
  assign    m_ahb_wrap4_last_beat = m_wrap_dphase & m_hready & (m_wrap_dph_beat_cnt == 'd3) & rstn;
  assign    cache_line_wr   = m_ahb_wrap4_last_beat;

  always @(posedge clk or negedge rstn)
  if(!rstn) 
    m_wrap_dphase   <= 1'b0;
  else if(m_ahb_wrap4_cmd)
    m_wrap_dphase   <= 1'b1;
  else if(m_ahb_wrap4_last_beat)
    m_wrap_dphase   <= 1'b0;
  
  always @(posedge clk or negedge rstn)
  if(!rstn) 
    m_wrap_dph_beat_cnt <= 'd0;
  else if(m_ahb_wrap4_last_beat)
    m_wrap_dph_beat_cnt <= 'd0;
  else if(m_wrap_dphase && m_hready)
    m_wrap_dph_beat_cnt <= m_wrap_dph_beat_cnt + 'd1;


  //use interface to r/w signal in DUT
// 通过层次路径观察实际标签 RAM，便于诊断；该路径与 tb 的实例命名绑定。
  function logic [`TAG_MEM_WIDTH-1:0] tag_mem_rd(int index);
    logic [`TAG_MEM_WIDTH-1:0]   tags;
    tags = tb.u_icache_ahb.u_tag_mem.mem[index];
    return tags;
  endfunction



  //--- 2: assertions to cover some test points
  parameter   [1:0]   s_disable = 'd0, s_enable = 'd1, s_wait_en_pending = 'd2;
  default disable iff(!rstn);

  //--- 2.1: icache_en 0->1 test points
  property icache_en_rise_at_disable_sta;
    $rose(icache_en) && ($past(s_cache_sta, 1) == s_disable);
  endproperty
  c_icache_en_rise_at_disable_sta: cover property (@(posedge clk) icache_en_rise_at_disable_sta);

  property icache_en_rise_at_wait_en_pending_sta;
    $rose(icache_en) && ($past(s_cache_sta, 1) == s_wait_en_pending);
  endproperty
  c_icache_en_rise_at_wait_en_pending_sta: cover property (@(posedge clk) icache_en_rise_at_wait_en_pending_sta);

  property icache_en_rise_at_idle_trans;
    $rose(icache_en) && $past(s_idle_cmd, 1);
  endproperty
  c_icache_en_rise_at_idle_trans: cover property (@(posedge clk) icache_en_rise_at_idle_trans);
    
  property icache_en_rise_at_nonseq_trans;
    $rose(icache_en) && $past(s_vld_cmd, 1);
  endproperty
  c_icache_en_rise_at_nonseq_trans: cover property (@(posedge clk) icache_en_rise_at_nonseq_trans);
    

  //--- 2.2: icache_en 1->0 test points
  property icache_en_fell_at_disable_sta;
    $fell(icache_en) && ($past(s_cache_sta, 1) == s_disable);
  endproperty
  c_icache_en_fell_at_disable_sta: cover property (@(posedge clk) icache_en_fell_at_disable_sta);

  property icache_en_fell_at_enable_sta;
    $fell(icache_en) && ($past(s_cache_sta, 1) == s_enable);
  endproperty
  c_icache_en_fell_at_enable_sta: cover property (@(posedge clk) icache_en_fell_at_enable_sta);

  property icache_en_fell_at_wait_en_pending_sta;
    $fell(icache_en) && ($past(s_cache_sta, 1) == s_wait_en_pending);
  endproperty
  c_icache_en_fell_at_wait_en_pending_sta: cover property (@(posedge clk) icache_en_fell_at_wait_en_pending_sta);

  property icache_en_fell_at_idle_trans;
    $fell(icache_en) && $past(s_idle_cmd, 1);
  endproperty
  c_icache_en_fell_at_idle_trans: cover property (@(posedge clk) icache_en_fell_at_idle_trans);
  

  sequence s_icache_en_fell_at_nonseq_trans;
    $fell(icache_en) && $past(s_vld_cmd, 1);
  endsequence

  sequence s_last_bypass_trans;
    $past((s_vld_cmd && (!s_cacheable_inst)), 1);
  endsequence

  sequence s_last_cacheable_trans;
    $past((s_vld_cmd && s_cacheable_inst && (s_cache_sta == s_enable) && icache_en), 1);
  endsequence

  sequence s_cacheable_hit;
    (!cache_miss);
  endsequence

  sequence s_cacheable_first_miss;
    cache_miss && (!m_wrap_dphase);
  endsequence

  sequence s_cacheable_miss_again;
    cache_miss && m_wrap_dphase;
  endsequence

  c_icache_en_fell_at_nonseq_trans: cover property (@(posedge clk) s_icache_en_fell_at_nonseq_trans);
  c_icache_en_fell_at_bypass_trans: cover property (@(posedge clk) s_icache_en_fell_at_nonseq_trans |-> s_last_bypass_trans);
  c_icache_en_fell_at_cacheable_hit: cover property (@(posedge clk) s_icache_en_fell_at_nonseq_trans |-> s_last_cacheable_trans ##0 s_cacheable_hit);
  c_icache_en_fell_at_cacheable_miss: cover property (@(posedge clk) s_icache_en_fell_at_nonseq_trans |-> s_last_cacheable_trans ##0 s_cacheable_first_miss);
  c_icache_en_fell_at_cacheable_miss_again: cover property (@(posedge clk) s_icache_en_fell_at_nonseq_trans |-> s_last_cacheable_trans ##0 s_cacheable_miss_again);


  //--- 2.3: m_ahb m_haddr[3:2] offset for wrap4 burst
  sequence s_m_ahb_wrap4_nonseq_beat;
    m_hsel && m_hready && (m_hburst == ahb_wrap4) && (m_htrans == ahb_nonseq) && (!m_hwrite) && (!m_hprot[0]) && m_hprot[3];
  endsequence

  c_m_ahb_wrap4_addr_offset0: cover property (@(posedge clk) s_m_ahb_wrap4_nonseq_beat |-> (m_haddr[3:0] == 'h0));
  c_m_ahb_wrap4_addr_offset4: cover property (@(posedge clk) s_m_ahb_wrap4_nonseq_beat |-> (m_haddr[3:0] == 'h4));
  c_m_ahb_wrap4_addr_offset8: cover property (@(posedge clk) s_m_ahb_wrap4_nonseq_beat |-> (m_haddr[3:0] == 'h8));
  c_m_ahb_wrap4_addr_offsetc: cover property (@(posedge clk) s_m_ahb_wrap4_nonseq_beat |-> (m_haddr[3:0] == 'hc));

  //--- 3: assertion to check state transiton of s_cache_sta, as ref model use s_ahb_cache_en to control its behavior;
  //--- 3.1 when icache_en=0, s_ahb_cache_en must be 0
// 参考模型会使用内部使能状态，因而同时断言状态控制，减少错误状态被模型照单采用的风险。
  a_icache_en_0_ahb_cache_en_0: assert property (@(posedge clk) (!icache_en) |-> (!s_ahb_cache_en))
  else
    `uvm_error("i_cache_misc_interface", "Assertion a_icache_en_0_ahb_cache_en_0 failed.")
  
  //--- 3.2 s_ahb_cache_en = 1, only at s_enable state
  a_ahb_cache_en_1_must_enable_state: assert property (@(posedge clk) s_ahb_cache_en |-> (s_cache_sta == s_enable))
  else
    `uvm_error("i_cache_misc_interface", "Assertion a_ahb_cache_en_1_must_enable_state failed.")

  //--- 3.3 after rstn release or enter s_disabe from s_wait_en_pending, must stay at s_disable state for at least 65T
  sequence s_enter_disable;
    $rose(rstn) or (s_cache_sta == s_wait_en_pending) ##1 (s_cache_sta == s_disable);
  endsequence

  a_stay_at_disable_for_at_least_65T: assert property (@(posedge clk) s_enter_disable |-> (s_cache_sta == s_disable)[*(`TAG_MEM_DEPTH + 1)])
  else
    `uvm_error("i_cache_misc_interface", "Assertion a_stay_at_disable_for_at_least_65T failed.")

  //--- 3.4 when s_cache_sta == s_disable for 64T and icache_en=1, must change to s_enable state
  sequence s_disable_tag_clear_end;
    (s_cache_sta == s_disable)[*`TAG_MEM_DEPTH] ##1 ((s_cache_sta == s_disable) && (!icache_en))[*0:$];
  endsequence
  a_goto_enable_after_64T_and_icache_en: assert property (@(posedge clk)  s_disable_tag_clear_end ##1 icache_en |=> (s_cache_sta == s_enable) )
  else
    `uvm_error("i_cache_misc_interface", "Assertion a_goto_enable_after_64T_and_icache_en failed.")

  //--- 3.5 when s_cache_sta == s_enable and icache_en=0, must change to s_wait_en_pending state
  a_goto_wait_en_pending: assert property (@(posedge clk) (s_cache_sta == s_enable) && (!icache_en) |=> (s_cache_sta == s_wait_en_pending) )
  else
    `uvm_error("i_cache_misc_interface", "Assertion a_goto_wait_en_pending failed.")

  //--- 3.6 when s_cache_sta == s_wait_en_pending, after finish the pending cmd(including all data beat of wrap4), it must go to s_disable state
  //--- note: this assertion is not cycle accurate, DUT may go to s_disable state eariler than this assertion
  sequence s_goto_wait_en_pending;
    (s_cache_sta == s_enable) ##1 (s_cache_sta == s_wait_en_pending);
  endsequence

  sequence s_goto_disable;
    (s_cache_sta == s_wait_en_pending) ##1 (s_cache_sta == s_disable) within 1'b1 ##0 s_hready[->1] ##0 (m_hready && ((m_htrans == ahb_idle) || (m_htrans == ahb_nonseq)))[->1] ##2 1'b1;
  endsequence

  a_goto_disable_after_wait_en_pending: assert property (@(posedge clk) s_goto_wait_en_pending |-> s_goto_disable)
  else
    `uvm_error("i_cache_misc_interface", "Assertion a_goto_disable_after_wait_en_pending failed.")

  //--- 4: assertion to check 2T error response on s_ahb/m_ahb
  property s_ahb_2T_err_resp;
    (s_hresp && s_hready) |-> $past((s_hresp && (!s_hready)), 1);
  endproperty

  a_s_ahb_2T_err_resp: assert property (@(posedge clk) s_ahb_2T_err_resp)
  else
    `uvm_error("i_cache_misc_interface", "Assertion a_s_ahb_2T_err_resp failed.")

  property m_ahb_2T_err_resp;
    (m_hresp && m_hready) |-> $past((m_hresp && (!m_hready)), 1);
  endproperty

  a_m_ahb_2T_err_resp: assert property (@(posedge clk) m_ahb_2T_err_resp)
  else
    `uvm_error("i_cache_misc_interface", "Assertion a_m_ahb_2T_err_resp failed.")
  
  //--- 5: assertion to check s_hresp
  //--- 5.1 s_hresp=0 for all wrap4 trans on m_ahb
  a_okay_resp_for_wrap4: assert property (@(posedge clk) m_wrap_dphase |-> (!s_hresp))
  else
    `uvm_error("i_cache_misc_interface", "Assertion a_okay_resp_for_wrap4 failed.")

  //--- 5.2: s_hresp == m_hresp for all bypass trans. 
  //case for (!m_wrap_dphase):
  //1: s_ahb bypass trans to m_ahb;
  //2: s_ahb cacheable instr read and hit (must be okay reps), m_ahb idle trans with okay resp;
  a_same_resp_for_none_wrap4: assert property (@(posedge clk) (!m_wrap_dphase |-> (s_hresp == m_hresp)))
  else
    `uvm_error("i_cache_misc_interface", "Assertion a_same_resp_for_none_wrap4 failed.")

endinterface

typedef virtual i_cache_misc_interface  i_cache_misc_vif;

