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
// 文件说明 icache_ahb.v
// I-Cache 顶层与 AHB-Lite 桥接控制。
// 上游 s_ahb 接收 CPU 单次请求，下游 m_ahb 执行旁路 SINGLE 或缺失 WRAP4。
// 默认 4KB、64 组、4 路、16B 行；仅缓存可缓存且非锁定的指令读。
// 协调标签查询、数据选择、单行填充、读写冲突重查和关闭前事务收尾。
// 标签实现由 icache_tag.vp 提供；填充错误不向上游传播，旁路错误直接传递。

//----------------------------------------------------------------------------//
// File name    : icache_ahb.v
// Author       : sky@siliconthink.cn
// E-mail       : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  : 
// 1: slave ahb inf only support single rw/idle trans; this's true if onnected to cortex m0/m3 MCU.
// 2: cache cacheable read trans only (I-cache).
// 
//----------------------------------------------------------------------------//

module icache_ahb (
    //--- contrl signal
    icache_en,

    //--- upstream ahb-lite slave interface
    s_hsel,
    s_haddr,
    s_hburst,
    s_htrans,
    s_hsize,
    s_hprot,
    s_hwrite,
    s_hwdata,
    s_hmastlock,
    s_hready,
    s_hreadyout,
    s_hrdata,
    s_hresp,

    //--- downstream ahb-master interface
    m_hsel,
    m_haddr,
    m_hburst,
    m_htrans,
    m_hsize,
    m_hprot,
    m_hwrite,
    m_hwdata,
    m_hmastlock,
    m_hready,
    m_hrdata,
    m_hresp,

    clk,
    rstn
);

  //changeable parameter
  parameter index_bits = 6;  //4KB 4-way set associated icache(each way is 1KB)

  //fixed parameter
  parameter offset_bits = 4;  //128bit(16B) cache line size
  parameter tag_bits = 32 - offset_bits - index_bits;
  //                              tag addr  vld rlu
  parameter tag_mem_width = (4 * tag_bits) + 4 + 3;

  parameter IDLE_TRANS = 2'b00, BUSY_TRANS = 2'b01;

  input wire clk, rstn;

  input wire icache_en;  //0:disable; 1:enable

  input wire s_hsel;
  input wire [31:0] s_haddr;
  input wire [2:0] s_hburst;
  input wire [1:0] s_htrans;
  input wire [2:0] s_hsize;
  input wire [3:0] s_hprot;
  input wire s_hwrite;
  input wire [31:0] s_hwdata;
  input wire s_hmastlock;
  input wire s_hready;

  output wire s_hreadyout;
  output  reg [31:0] s_hrdata;
  output reg s_hresp;


  output wire m_hsel;
  output  reg [31:0] m_haddr;
  output  reg [2:0] m_hburst;
  output  reg [1:0] m_htrans;
  output  reg [2:0] m_hsize;
  output  reg [3:0] m_hprot;
  output reg m_hwrite;
  output wire [31:0] m_hwdata;
  output reg m_hmastlock;

  input wire m_hready;
  input wire [31:0] m_hrdata;
  input wire m_hresp;

  //--- 0: global signals
  wire cache_init;  //1: cache tag mem in reset initial stage
  wire hit_chk_point;  //1T delay of tag_mem_chk
  wire tag_hit;  //1: cache tag mem check get hit, valid when hit_chk_point=1
  wire            fill_hit            ;   //1: hit data that is cache line filling, high level active when&after hit_chk_point=1
  wire cache_miss;  //1: miss in both tag mem check and fill line check
  wire [3:0] hit_way;  //0~3 way id
  wire    [offset_bits-1-2 : 0]   hit_offset      ;   //32bit offset within a cache line, for both tag hit and fill hit
  wire cache_hit_rd_vld;  //read data from cache(mem and filling line)
  wire [31:0] cache_hit_rdata;
  wire [1:0] replace_way;  //whem miss, way ID to store new data
  wire [index_bits-1 : 0] replace_addr;  //index of way to store new data

  wire            cache_miss_fill_w   ;   //1: cache tag mem check get miss again when cache line filling(in m-ahb data phase)
  reg cache_miss_fill;
  wire cache_line_wr;  //cache line write after missing line has been read back
  wire cache_line_rw_conflict;  //when cache line write, there is a cachable read trans on s_ahb
  reg cache_line_rw_conflict_d;  //valid same cycle as tag_mem_wr_miss

  reg [1:0] m_sta;  //FSM for m_ahb
  parameter [1:0] s_idle_nonseq = 2'd0, s_wait_single = 2'd1, s_wait_wrap = 2'd2, s_wrap = 2'd3;


  reg m_wrap_dphase;  //master ahb in wrap burst read data phase
  reg m_single_dphase;  //master ahb in single rw(bypass) data phase
  wire m_wrap_nonseq;  //cache line fill burst nonseq addr send
  wire m_single_nonseq;  //bypass burst nonseq addr send
  wire [offset_bits-2-1 : 0] m_wrap_beg_addr;  //32bit addr   
  wire [1:0] m_rdata_cnt;  //0~3 data phase cnt of a wrap4


  //--- 0: cache enable/disable flow control ---//
  reg [1:0] s_cache_sta;
  reg             s_ahb_with_en_pending;  //1: s_ahb has vld ahb trans (including bypass trans) with pending hready_out, the
                                          //trans is received when s_ahb_cache_en = 1;
  wire disable_clr_tag;  //clear tag info when cache status change from enable to disable
  wire s_ahb_cache_en;

  parameter [1:0] s_disable = 'd0, s_enable = 'd1, s_wait_en_pending = 'd2;

  // 关闭分两步：先排空已接收请求及下游填充，再通知标签模块失效旧内容。
  // 仅地址 FSM 空闲还不够，必须同时确认最后一个数据阶段已经结束。
  assign  disable_clr_tag = (s_cache_sta == s_wait_en_pending) & ((!s_ahb_with_en_pending) & (m_sta == s_idle_nonseq) & (!m_wrap_dphase));
  assign s_ahb_cache_en = (s_cache_sta == s_enable) & icache_en;

  always @(posedge clk or negedge rstn)
    if (!rstn) s_cache_sta <= s_disable;
    else begin
      case (s_cache_sta)
        s_disable: begin
          if (icache_en && (!cache_init)) s_cache_sta <= s_enable;
        end

        s_enable: begin
          //always goto s_wait_en_pending state to make sure all the data beat at m_ahb has finished. 
          //The m_ahb trans is caused by s_ahb trans receiveed when s_ahb_cache_en = 1;
          if (!icache_en) s_cache_sta <= s_wait_en_pending;
        end

        //when s_cache_sta == s_wait_en_pending:
        //1: s_ahb may receive at most one vld ahb trans;
        //2: and this trans will be bypassed on m_ahb when m_sta == s_idle_nonseq;
        s_wait_en_pending: begin
          //make sure data phase of all vld trans received when s_ahb_cache_en=1 has ended, including all data phase of wrap4. 
          //Then goto s_disable state to set tag mem to all '0;
          if ((!s_ahb_with_en_pending) && (m_sta == s_idle_nonseq) && (!m_wrap_dphase))
            s_cache_sta <= s_disable;
        end

      endcase
    end


  //--- 1: receive ahb slave inf trans and latch ---//
  wire        ahb_idle_busy_trans;
  wire        ahb_vld_trans;
  reg         s_idle_busy_rdy;  //hreadyout=1 for idle/busy trans
  reg         s_trans_rdy;  //hreadyout=1 for nonseq/seq trans
  wire        s_cacheable_rd;  //cacheable read trans, ahb addr phase
  reg  [31:0] s_haddr_latch;  //latch ahb trans info for later use
  reg  [ 2:0] s_hburst_latch;
  reg  [ 1:0] s_htrans_latch;
  reg  [ 2:0] s_hsize_latch;
  reg  [ 3:0] s_hprot_latch;
  reg         s_hwrite_latch;
  reg         s_hmastlock_latch;

  // AHB 地址阶段只有在 HREADY 为高时才能被接收。
  // 缓存条件还要求指令属性、可缓存属性、非写和非锁定；其余有效访问转旁路。
  assign s_hreadyout = s_idle_busy_rdy | s_trans_rdy;
  assign ahb_idle_busy_trans = s_hsel & s_hready & (!s_htrans[1]);
  assign ahb_vld_trans = s_hsel & s_hready & s_htrans[1];
  assign  s_cacheable_rd      = ahb_vld_trans & (!s_hwrite) & s_hprot[3] &
                              (!s_hprot[0]) & (!s_hmastlock) & s_ahb_cache_en; //bypass all locked trans

  always @(posedge clk or negedge rstn)
    if (~rstn) s_idle_busy_rdy <= 1'b1;
    else if (ahb_idle_busy_trans) s_idle_busy_rdy <= 1'b1;
    else s_idle_busy_rdy <= 1'b0;

  always @(posedge clk or negedge rstn)
    if (!rstn) s_haddr_latch <= 32'h0;
    else if (ahb_vld_trans) s_haddr_latch <= s_haddr;

  always @(posedge clk or negedge rstn)
    if (!rstn) s_ahb_with_en_pending <= 1'b0;
    else if (ahb_vld_trans && s_ahb_cache_en) s_ahb_with_en_pending <= 1'b1;
    else if (s_hreadyout) s_ahb_with_en_pending <= 1'b0;

  always @(posedge clk)  // or negedge rstn)
    if (ahb_vld_trans) begin
      s_hburst_latch <= s_hburst;
      s_htrans_latch <= s_htrans;
      s_hsize_latch <= s_hsize;
      s_hprot_latch <= s_hprot;
      s_hwrite_latch <= s_hwrite;
      s_hmastlock_latch <= s_hmastlock;
    end

  //--- 2: cache tag mem(two-port sram) and data mem(singal-port sram) ctrl
  wire        tag_mem_chk;  //tag mem lookup
  wire [31:0] tag_chk_haddr;  //haddr to look in tag
  reg         tag_mem_wr_miss;  //write in tag info after that cache line has been read back

  // 单端口数据 RAM 的整行写入优先于同拍新查询。
  // 冲突查询下一拍使用锁存地址重发；填充中再次 miss 则等标签提交后重新查询。
  assign cache_line_rw_conflict = cache_line_wr & s_cacheable_rd;
  assign cache_miss_fill_w = cache_miss & hit_chk_point & m_wrap_dphase;
  assign  tag_mem_chk     = (s_cacheable_rd & (!cache_line_wr)) | cache_line_rw_conflict_d | (cache_miss_fill & tag_mem_wr_miss);
  assign  tag_chk_haddr   = (cache_line_rw_conflict_d || (cache_miss_fill && tag_mem_wr_miss))? s_haddr_latch : s_haddr;

  always @(posedge clk or negedge rstn)
    if (~rstn) cache_line_rw_conflict_d <= 1'b0;
    else cache_line_rw_conflict_d <= cache_line_rw_conflict;

  always @(posedge clk or negedge rstn)
    if (~rstn) tag_mem_wr_miss <= 1'b0;
    else tag_mem_wr_miss <= cache_line_wr;

  always @(posedge clk or negedge rstn)
    if (~rstn) cache_miss_fill <= 1'b0;
    else if (cache_miss_fill_w) cache_miss_fill <= 1'b1;
    else if (tag_mem_wr_miss)  //tag mem lookup again must happen at this cycle
      cache_miss_fill <= 1'b0;


  //--- tag & data mem rw signal

  wire                       tag_sram_rd;
  wire [   index_bits-1 : 0] tag_sram_raddr;
  wire [tag_mem_width-1 : 0] tag_sram_dout;
  wire [tag_mem_width-1 : 0] tag_sram_wdata;
  wire                       tag_sram_wr;
  wire [   index_bits-1 : 0] tag_sram_waddr;

  wire                       dmem_rd;  //read dmem of all ways
  wire                       dmem0_wr;
  wire                       dmem1_wr;
  wire                       dmem2_wr;
  wire                       dmem3_wr;

  wire [   index_bits-1 : 0] dmem_rw_addr;
  wire [              127:0] dmem_wdata;
  wire [              127:0] dmem0_dout;
  wire [              127:0] dmem1_dout;
  wire [              127:0] dmem2_dout;
  wire [              127:0] dmem3_dout;
  wire                       dmem0_ce;
  wire                       dmem1_ce;
  wire                       dmem2_ce;
  wire                       dmem3_ce;


  icache_tag #(
      .index_bits(index_bits)
  ) u_icache_tag (
      .disable_clr_tag(disable_clr_tag),
      //tag mem ctrl
      .tag_mem_chk    (tag_mem_chk),
      .chk_haddr      (tag_chk_haddr),
      .tag_mem_wr_miss(tag_mem_wr_miss),
      .cache_init     (cache_init),
      .hit_chk_point  (hit_chk_point),
      .tag_hit        (tag_hit),
      .fill_hit       (fill_hit),
      .cache_miss     (cache_miss),
      .hit_way        (hit_way),
      .hit_offset     (hit_offset),
      .m_wrap_dphase  (m_wrap_dphase),

      //cache data mem replace
      .replace_way (replace_way),
      .replace_addr(replace_addr),

      //tag two-port sram io
      .tag_sram_rd   (tag_sram_rd),
      .tag_sram_raddr(tag_sram_raddr),
      .tag_sram_dout (tag_sram_dout),
      .tag_sram_wdata(tag_sram_wdata),
      .tag_sram_wr   (tag_sram_wr),
      .tag_sram_waddr(tag_sram_waddr),

      .clk (clk),
      .rstn(rstn)
  );

  //--- dmem ctrl
  icache_dmem #(
      .index_bits(index_bits)
  ) u_icache_dmem (
      //m-ahb read back status
      .m_hready       (m_hready),
      .m_hrdata       (m_hrdata),
      .m_wrap_nonseq  (m_wrap_nonseq),
      .m_wrap_beg_addr(m_wrap_beg_addr),
      .m_rdata_cnt    (m_rdata_cnt),
      .m_rdata_offset (),
      .m_wrap_dphase  (m_wrap_dphase),

      //s-ahb rdata and valid
      .cache_hit_rd_vld(cache_hit_rd_vld),
      .cache_hit_rdata (cache_hit_rdata),

      //tag check state
      .tag_mem_chk  (tag_mem_chk),
      .tag_chk_haddr(tag_chk_haddr),
      .cache_line_wr(cache_line_wr),
      .replace_way  (replace_way),
      .replace_addr (replace_addr),
      .hit_chk_point(hit_chk_point),
      .tag_hit      (tag_hit),
      .fill_hit     (fill_hit),
      .hit_way      (hit_way),
      .hit_offset   (hit_offset),

      //cache mem rw  
      .dmem_rd (dmem_rd),
      .dmem0_wr(dmem0_wr),
      .dmem1_wr(dmem1_wr),
      .dmem2_wr(dmem2_wr),
      .dmem3_wr(dmem3_wr),

      .dmem_rw_addr(dmem_rw_addr),
      .dmem_wdata  (dmem_wdata),
      .dmem0_dout  (dmem0_dout),
      .dmem1_dout  (dmem1_dout),
      .dmem2_dout  (dmem2_dout),
      .dmem3_dout  (dmem3_dout),

      .clk (clk),
      .rstn(rstn)
  );

  assign dmem0_ce = dmem_rd | dmem0_wr;
  assign dmem1_ce = dmem_rd | dmem1_wr;
  assign dmem2_ce = dmem_rd | dmem2_wr;
  assign dmem3_ce = dmem_rd | dmem3_wr;

  //--- tag and data mems

  dpram_generic #(
      .ADDR_BITS  (index_bits),
      .ADDR_AMOUNT((1 << index_bits)),
      .DATA_BITS  (tag_mem_width)
  ) u_tag_mem (
      .clka (clk),
      .ena  (tag_sram_wr),
      .wea  (tag_sram_wr),
      .dina (tag_sram_wdata),
      .addra(tag_sram_waddr),
      .clkb (clk),
      .enb  (tag_sram_rd),
      .addrb(tag_sram_raddr),
      .doutb(tag_sram_dout)
  );

  spram_generic #(
      .ADDR_BITS  (index_bits),
      .ADDR_AMOUNT((1 << index_bits)),
      .DATA_BITS  (128)
  ) u_dmem_w0 (
      .clk (clk),
      .en  (dmem0_ce),
      .we  (dmem0_wr),
      .addr(dmem_rw_addr),
      .din (dmem_wdata),

      .dout(dmem0_dout)
  );

  spram_generic #(
      .ADDR_BITS  (index_bits),
      .ADDR_AMOUNT((1 << index_bits)),
      .DATA_BITS  (128)
  ) u_dmem_w1 (
      .clk (clk),
      .en  (dmem1_ce),
      .we  (dmem1_wr),
      .addr(dmem_rw_addr),
      .din (dmem_wdata),

      .dout(dmem1_dout)
  );

  spram_generic #(
      .ADDR_BITS  (index_bits),
      .ADDR_AMOUNT((1 << index_bits)),
      .DATA_BITS  (128)
  ) u_dmem_w2 (
      .clk (clk),
      .en  (dmem2_ce),
      .we  (dmem2_wr),
      .addr(dmem_rw_addr),
      .din (dmem_wdata),

      .dout(dmem2_dout)
  );

  spram_generic #(
      .ADDR_BITS  (index_bits),
      .ADDR_AMOUNT((1 << index_bits)),
      .DATA_BITS  (128)
  ) u_dmem_w3 (
      .clk (clk),
      .en  (dmem3_ce),
      .we  (dmem3_wr),
      .addr(dmem_rw_addr),
      .din (dmem_wdata),

      .dout(dmem3_dout)
  );

  //--- 3: master ahb-lite inf
  //Note: all write, non-cacheable read burst(single, wrap, incr) on s-ahb are converted to single burst on m-ahb
  reg [1:0] m_trans_cnt;  //cnt for addr phase
  reg [32-offset_bits-1 : 0] m_wrap_addr_h;  //high bits of haddr of wrap burst
  reg [offset_bits-2-1 : 0] m_wrap_addr_w;  //low bits(32bit) haddr of wrap burst
  reg [3:0] m_hprot_wrap;

  wire req_bypass;  //bypass req directly from s_ahb to m_ahb;
  reg req_bypass_latch;  //bypass req has been latched, the bypass trans on s_ahb can't be pass
                         //to m_ahb at the same cycle;
  wire req_wrap_miss;  //cache line fill for cache miss when m_ahb idle
  wire req_wrap_miss_fill;  //no use now, will generate tag_mem_chk again and miss again,
                            //then cause req_wrap_miss = 1

  // 同一时刻只维护一条填充上下文。当前填充未完成时的新 miss 不直接启动第二次突发。
  assign req_bypass = ahb_vld_trans & (!s_cacheable_rd);
  assign req_wrap_miss = cache_miss & hit_chk_point & (!m_wrap_dphase);
  assign req_wrap_miss_fill = 1'b0;  //will generate tag_mem_chk again
  assign m_wrap_nonseq = m_hready & (m_htrans == 2'b10) & (m_hburst == 3'b010);
  assign m_single_nonseq = m_hready & (m_htrans == 2'b10) & (m_hburst == 3'b000);
  // 按有效数据拍计数：第四拍握手成功时才能提交整行，等待周期不能算作返回数据。
  assign  cache_line_wr       = m_wrap_dphase & m_hready & (m_rdata_cnt == 'd3);  //always wrap4 burst for 128bit cache line size

  always @(posedge clk or negedge rstn)
    if (~rstn) begin
      m_sta       <= s_idle_nonseq;
      m_trans_cnt <= 'd0;
    end else begin
      case (m_sta)
        s_idle_nonseq: begin
          if (req_bypass || req_bypass_latch) begin
            if (m_hready) m_sta <= s_idle_nonseq;
            else m_sta <= s_wait_single;
          end else if (req_wrap_miss || req_wrap_miss_fill) begin
            if (m_hready) begin
              m_sta       <= s_wrap;
              m_trans_cnt <= m_trans_cnt + 'd1;
            end else begin
              m_sta       <= s_wait_wrap;
              m_trans_cnt <= m_trans_cnt;
            end
          end
        end

        s_wait_single: begin
          if (m_hready) m_sta <= s_idle_nonseq;
        end

        //note: seems never go to this state
        s_wait_wrap: begin
          if (m_hready) begin
            m_sta <= s_wrap;
            m_trans_cnt <= m_trans_cnt + 'd1;
          end
        end

        s_wrap: begin
          if (m_hready) begin
            m_trans_cnt <= m_trans_cnt + 'd1;

            if (m_trans_cnt == 'd3) begin
              m_sta <= s_idle_nonseq;
            end
          end
        end
      endcase
    end

  always @(posedge clk or negedge rstn)
    if (~rstn) req_bypass_latch <= 1'b0;
    else if (ahb_vld_trans && (!s_cacheable_rd) && (m_sta != s_idle_nonseq))
      req_bypass_latch <= 1'b1;
    else if (m_sta == s_idle_nonseq) req_bypass_latch <= 1'b0;

  // WRAP4 保留行地址高位，只让行内字偏移递增并自然回绕。
  // 从请求字开始读取，因此地址发送计数与行内偏移不是同一个概念。
  always @(posedge clk)  // or negedge rstn)
    if ((req_wrap_miss || req_wrap_miss_fill) && (m_sta == s_idle_nonseq)) begin
      m_wrap_addr_h <= s_haddr_latch[31 : offset_bits];
      m_hprot_wrap  <= s_hprot_latch;
    end

  always @(posedge clk)  // or negedge rstn)
    if ((req_wrap_miss || req_wrap_miss_fill) && (m_sta == s_idle_nonseq)) begin
      if (m_hready) m_wrap_addr_w <= s_haddr_latch[offset_bits-1 : 2] + 'd1;
      else m_wrap_addr_w <= s_haddr_latch[offset_bits-1 : 2];
    end else if (m_hready && ((m_sta == s_wrap) || (m_sta == s_wait_wrap))) begin
      m_wrap_addr_w <= m_wrap_addr_w + 'd1;
    end

  always @(posedge clk or negedge rstn)
    if (~rstn) m_single_dphase <= 1'b0;
    else if (m_single_nonseq) m_single_dphase <= 1'b1;
    else if (m_hready) m_single_dphase <= 1'b0;

  always @(posedge clk or negedge rstn)
    if (~rstn) m_wrap_dphase <= 1'b0;
    else if (m_wrap_nonseq) m_wrap_dphase <= 1'b1;
    else if (cache_line_wr) m_wrap_dphase <= 1'b0;

  // AHB 写数据属于数据阶段；上游在等待期间需保持该阶段数据，旁路直接连接 HWDATA。
  assign m_hsel          = 1'b1;
  assign m_hwdata        = s_hwdata;
  assign m_wrap_beg_addr = m_haddr[offset_bits-1 : 2];

  always @(*) begin
    case (m_sta)
      s_idle_nonseq: begin
        if (req_bypass) begin
          m_haddr     = s_haddr;
          m_hburst    = 3'b000;  //change to single burst
          m_htrans    = 2'b10;  //nonseq
          m_hsize     = s_hsize;
          m_hprot     = s_hprot;
          m_hwrite    = s_hwrite;
          m_hmastlock = s_hmastlock;
        end else if (req_bypass_latch) begin
          m_haddr     = s_haddr_latch;
          m_hburst    = 3'b000;  //change to single burst
          m_htrans    = 2'b10;  //nonseq
          m_hsize     = s_hsize_latch;
          m_hprot     = s_hprot_latch;
          m_hwrite    = s_hwrite_latch;
          m_hmastlock = s_hmastlock_latch;
        end else if (req_wrap_miss || req_wrap_miss_fill) begin
          m_haddr     = {s_haddr_latch[31:2], 2'b0};
          m_hburst    = 3'b010;  //change to wrap4 burst
          m_htrans    = 2'b10;  //nonseq
          m_hsize     = 3'b010;  //32bit trans
          m_hprot     = s_hprot_latch;
          m_hwrite    = 1'b0;
          m_hmastlock = 1'b0;
        end else begin  //send idle trans on m_ahb
          m_haddr     = {s_haddr_latch[31:2], 2'b0};  //no use
          m_hburst    = 3'b010;  //no use
          m_htrans    = 2'b00;  //idle
          m_hsize     = 3'b010;  //no use
          m_hprot     = s_hprot_latch;  //no use
          m_hwrite    = 1'b0;  //no use
          m_hmastlock = 1'b0;  //no use
        end
      end

      s_wait_single: begin
        m_haddr     = s_haddr_latch;
        m_hburst    = 3'b000;  //change to single burst
        m_htrans    = 2'b10;  //nonseq
        m_hsize     = s_hsize_latch;
        m_hprot     = s_hprot_latch;
        m_hwrite    = s_hwrite_latch;
        m_hmastlock = s_hmastlock_latch;
      end

      s_wait_wrap: begin
        m_haddr     = {m_wrap_addr_h, m_wrap_addr_w, 2'b00};
        m_hburst    = 3'b010;  //change to wrap4 burst
        m_htrans    = 2'b10;  //nonseq
        m_hsize     = 3'b010;  //32bit trans
        m_hprot     = m_hprot_wrap;
        m_hwrite    = 1'b0;
        m_hmastlock = 1'b0;
      end

      s_wrap: begin
        m_haddr     = {m_wrap_addr_h, m_wrap_addr_w, 2'b00};
        m_hburst    = 3'b010;  //change to wrap4 burst
        m_htrans    = 2'b11;  //seq
        m_hsize     = 3'b010;  //32bit trans
        m_hprot     = m_hprot_wrap;
        m_hwrite    = 1'b0;
        m_hmastlock = 1'b0;
      end
    endcase
  end

  // 返回通路按事务类型选择：旁路传递下游 ready/data/resp；缓存返回由本地有效信号完成。
  // 现有实现对填充数据返回成功响应，不检测下游填充错误。
  //--- 4: s_ahb vld trans hreadyout and hrdata

  always @(*) begin
    s_trans_rdy = 1'b0;
    s_hrdata    = 32'h0;
    s_hresp     = 1'b0;

    if (m_single_dphase) begin
      s_trans_rdy = m_hready;
      s_hrdata    = m_hrdata;
      s_hresp     = m_hresp;
    end else if (cache_hit_rd_vld) begin
      s_trans_rdy = 1'b1;
      s_hrdata    = cache_hit_rdata;
      s_hresp     = 1'b0;  //doesn't detect cache line fill read error response
    end else begin
      s_trans_rdy = 1'b0;
      s_hrdata    = cache_hit_rdata;  //no use
      s_hresp     = 1'b0;
    end
  end


endmodule

