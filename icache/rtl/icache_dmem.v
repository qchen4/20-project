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
// 文件说明 icache_dmem.v
// I-Cache 数据通路与单行填充缓冲控制。
// 并行读取四路同步单端口 SRAM，根据独热 hit_way 和行内 hit_offset 选择 32 位数据。
// WRAP4 返回字按实际行内偏移进入四个缓冲；支持已缓冲字和当前返回字提前响应。
// 第四个有效数据拍到达时拼接 128 位行并写入替换路；单端口冲突由顶层延后查询。

//----------------------------------------------------------------------------//
// File name    : .v
// Author       : sky@siliconthink.cn
// E-mail       : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  : 
// 1: data memory manage module. use single port sram.
//----------------------------------------------------------------------------//

module icache_dmem(
    //m-ahb read back status
    m_hready        ,
    m_hrdata        ,
    m_wrap_nonseq   ,
    m_wrap_beg_addr ,
    m_rdata_cnt     ,
    m_rdata_offset  ,
    m_wrap_dphase   ,

    //s-ahb rdata and valid
    cache_hit_rd_vld,
    cache_hit_rdata ,

    //tag check state
    tag_mem_chk     ,
    tag_chk_haddr   ,
    cache_line_wr   ,
    replace_way     ,
    replace_addr    ,
    hit_chk_point   ,
    tag_hit         ,
    fill_hit        ,
    hit_way         ,
    hit_offset      ,
    
    //cache mem rw  
    dmem_rd         ,
    dmem0_wr        ,
    dmem1_wr        ,
    dmem2_wr        ,
    dmem3_wr        ,

    dmem_rw_addr    ,
    dmem_wdata      ,
    dmem0_dout      ,
    dmem1_dout      ,
    dmem2_dout      ,
    dmem3_dout      ,

    clk             ,
    rstn             
);

//changeable parameter
parameter   index_bits  = 6;    //4KB 4-way set associated icache(each way is 1KB)

//fixed parameter
parameter   offset_bits = 4;    //128bit(16B) cache line size
parameter   tag_bits    = 32-offset_bits-index_bits;
parameter   dmem_depth  = 2**index_bits;

input   wire            clk, rstn       ;

input   wire            m_hready        ;   //master ahb-lite hready
input   wire    [31:0]  m_hrdata        ;
input   wire            m_wrap_nonseq   ;   //cache line fill burst nonseq addr send
input   wire    [offset_bits-2-1 : 0] m_wrap_beg_addr ;   //32bit addr
output  reg     [1:0]   m_rdata_cnt     ;   //0~3 data phase cnt of a wrap4
output  reg     [1:0]   m_rdata_offset  ;   //word offset within a cache line
input   wire            m_wrap_dphase   ;   //1: m-ahb data phase of cache line read

output  wire            cache_hit_rd_vld;   //read data from cache(mem and filling line)
output  wire    [31:0]  cache_hit_rdata ;

input   wire            cache_line_wr   ;   //when miss, write cache line after data read back
input   wire            tag_mem_chk     ;   //read tag info to check hit or not
input   wire    [31:0]  tag_chk_haddr   ;
input   wire    [1:0]   replace_way     ;   //whem miss, way ID to store new data
input   wire    [index_bits-1 :0] replace_addr; //index of way to store new data
input   wire            hit_chk_point   ;   //1T delay of tag_mem_chk
input   wire            tag_hit         ;   //hit data in cache mem, valid 1T after tag_mem_chk
input   wire            fill_hit        ;   //1: hit data that is cache line filling, high level active when&after hit_chk_point=1
input   wire    [3:0]   hit_way         ;   //one-hot way id
input   wire    [offset_bits-1-2 : 0] hit_offset;   //32bit offset within a cache line, for both tag hit and fill hit

output  wire            dmem_rd         ;   //read dmem of all ways
output  wire            dmem0_wr        ;
output  wire            dmem1_wr        ;
output  wire            dmem2_wr        ;
output  wire            dmem3_wr        ;
output  wire    [index_bits-1 : 0]  dmem_rw_addr    ;
output  wire    [127:0] dmem_wdata      ;
input   wire    [127:0] dmem0_dout      ;
input   wire    [127:0] dmem1_dout      ;
input   wire    [127:0] dmem2_dout      ;
input   wire    [127:0] dmem3_dout      ;


//--- 1: dmem read part ---//
//note�� always read from mem. If need save sram read power, need 128x4 bits reg.
//improve: can check is read the same cache line or not. if same cache line, no sram read, add 128bit reg.
wire    [index_bits-1 : 0]  dmem_raddr  ;
reg     [127:0]             hit_line    ;   //hit in dmem(tag_hit)
reg     [31:0]              hit_word    ;   //must valid when icache_tag.hit_chk_point = 1

// 标签和四路数据同步查询。下一拍利用命中路选择整行，再以字偏移选择目标 32 位字。
assign  dmem_raddr  = tag_chk_haddr[offset_bits +: index_bits];
assign  dmem_rd     = tag_mem_chk;

always @(*) begin
    case(1'b1)      //synopsys full_case parallel_case
    hit_way[0]: hit_line = dmem0_dout;
    hit_way[1]: hit_line = dmem1_dout;
    hit_way[2]: hit_line = dmem2_dout;
    hit_way[3]: hit_line = dmem3_dout;
    endcase
end

always @(*) begin
    case(hit_offset)
    'd0:    hit_word = hit_line[0*32 +: 32];
    'd1:    hit_word = hit_line[1*32 +: 32];
    'd2:    hit_word = hit_line[2*32 +: 32];
    'd3:    hit_word = hit_line[3*32 +: 32];
    endcase
end

//--- 2: dmem write part

reg     [31:0]  line_buf0, line_buf1, line_buf2, line_buf3; //word buf of current fill line read back data
reg     [3:0]   word_vld;                                   //fill line read back word valid flag
wire    [31:0]  wr_w0, wr_w1, wr_w2, wr_w3;

reg             fill_hit_dvld   ;
reg     [31:0]  fill_hit_word   ;
reg     [31:0]  buf_mux         ;
wire            fill_vflag      ;

// 两类命中合并为上游可完成条件：已落入 SRAM 的行，或尚在填充的行。
assign  fill_vflag = word_vld[hit_offset];
assign  cache_hit_rd_vld = (tag_hit & hit_chk_point) | fill_hit_dvld;
assign  cache_hit_rdata  = (fill_hit_dvld)? fill_hit_word : hit_word;   


always @(*) begin
    case(hit_offset)
    'd0:    buf_mux = line_buf0;
    'd1:    buf_mux = line_buf1;
    'd2:    buf_mux = line_buf2;
    'd3:    buf_mux = line_buf3;
    endcase
end

// 先检查缓冲有效位，再检查目标字是否正在本拍从下游返回。
// 当前拍必须直接转发 m_hrdata，因为 line_buf 和 word_vld 要到时钟沿后才更新。
// 若目标字尚未返回，保持无效并继续等待对应偏移的数据拍。
always @(*) begin
    if(hit_chk_point && fill_hit) begin
        if(fill_vflag) begin
            fill_hit_word = buf_mux;
            fill_hit_dvld = 1'b1;
        //bug, if comment the following 3 lines    
        end else if(m_hready && (m_rdata_offset == hit_offset) && m_wrap_dphase) begin
            fill_hit_word = m_hrdata;
            fill_hit_dvld = 1'b1;
        end else begin
            fill_hit_word = buf_mux;    //any value is ok
            fill_hit_dvld = 1'b0;
        end
    end else if(m_hready && (m_rdata_offset == hit_offset) && fill_hit && m_wrap_dphase) begin
        fill_hit_word = m_hrdata;
        fill_hit_dvld = 1'b1;
    end else begin
        fill_hit_word = m_hrdata;       //any value is ok
        fill_hit_dvld = 1'b0;        
    end
end

// m_rdata_cnt 统计四拍传输进度；m_rdata_offset 指定数据应写入哪一个行内字。
// 起始偏移可能不是零，必须分别维护这两个量。
always @(posedge clk or negedge rstn)
if(~rstn)
    m_rdata_cnt <= 'd0;
else if(m_wrap_nonseq)
    m_rdata_cnt <= 'd0;
//else if(m_hready)
else if(m_hready && m_wrap_dphase)
    m_rdata_cnt <= m_rdata_cnt + 'd1;

always @(posedge clk or negedge rstn)
if(~rstn)
    m_rdata_offset  <= 'd0;
else if(m_wrap_nonseq)
    m_rdata_offset  <= m_wrap_beg_addr;
else if(m_hready)
    m_rdata_offset  <= m_rdata_offset + 'd1;

always @(posedge clk or negedge rstn)
if(~rstn)
    word_vld    <= 'd0;
else if(m_wrap_nonseq)
    word_vld    <= 'd0;
else if(m_hready) begin
    if(m_rdata_offset == 'd0)
        word_vld[0] <= 1'b1;
    
    if(m_rdata_offset == 'd1)
        word_vld[1] <= 1'b1;
    
    if(m_rdata_offset == 'd2)
        word_vld[2] <= 1'b1;
    
    if(m_rdata_offset == 'd3)
        word_vld[3] <= 1'b1;
end

always @(posedge clk)   // or negedge rstn)
if(m_hready && m_wrap_dphase) begin
    if(m_rdata_offset == 'd0)
        line_buf0   <= m_hrdata;

    if(m_rdata_offset == 'd1)
        line_buf1   <= m_hrdata;

    if(m_rdata_offset == 'd2)
        line_buf2   <= m_hrdata;

    if(m_rdata_offset == 'd3)
        line_buf3   <= m_hrdata;
end

// 末拍写 RAM 时，最后一个字尚未进入缓冲寄存器，因此以当前总线数据覆盖该位置。
// 其他三个位置使用已收集的缓冲数据，按字偏移重排后拼成完整缓存行。
assign  wr_w0   = (m_rdata_offset == 'd0)? m_hrdata : line_buf0;
assign  wr_w1   = (m_rdata_offset == 'd1)? m_hrdata : line_buf1;
assign  wr_w2   = (m_rdata_offset == 'd2)? m_hrdata : line_buf2;
assign  wr_w3   = (m_rdata_offset == 'd3)? m_hrdata : line_buf3;

assign  dmem0_wr= cache_line_wr & (replace_way == 'd0);
assign  dmem1_wr= cache_line_wr & (replace_way == 'd1);
assign  dmem2_wr= cache_line_wr & (replace_way == 'd2);
assign  dmem3_wr= cache_line_wr & (replace_way == 'd3);
assign  dmem_wdata = {wr_w3, wr_w2, wr_w1, wr_w0};

assign  dmem_rw_addr = (cache_line_wr)? replace_addr : dmem_raddr;

endmodule

