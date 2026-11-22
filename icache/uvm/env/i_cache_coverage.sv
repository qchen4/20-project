// 文件说明 i_cache_coverage.sv
// 事务级功能覆盖组件，对 Scoreboard 发送的 i_cache_coverage_item 采样。
// 覆盖总线属性、访问大小、地址与数据、命中/缺失、填充交叠和组索引组合。
// write 回调直接触发 covergroup；ignore_bins 排除的组合须与设计需求一致。
// 功能覆盖表示场景被采样，正确性仍由检查器和断言判定。

`include "sim_define.v"

class i_cache_coverage extends uvm_component;

    `uvm_component_utils(i_cache_coverage)    
    uvm_analysis_imp #(i_cache_coverage_item, i_cache_coverage) scb2cov;

	//Cover the current item and cache status
	covergroup cover_item with function sample(i_cache_coverage_item item);
		option.per_instance = 1;

        cache_status : coverpoint item.s_ahb_cache_en {
            type_option.comment = "Cache initial or working status.";
            bins cache_bypass  = {0};
            bins cache_enable  = {1};
        }

        //---1: m-ahb trans coverage
		ahb_rw : coverpoint item.ahb_item.direction {
			type_option.comment = "m-ahb read/write access.";
		}
        
		ahb_rw_trans : coverpoint item.ahb_item.direction {
			type_option.comment = "m-ahb read/write access change.";
            bins ahb_rw_trans[] = (READ, WRITE => READ, WRITE);
		}

        //R/W addr toggle
        //                   name                data                       condition
        `cover_val_32_bits(raddr_toggle, item.ahb_item.start_address, iff(item.ahb_item.direction == READ))
        `cover_val_32_bits(waddr_toggle, item.ahb_item.start_address, iff(item.ahb_item.direction == WRITE))

        ahb_addr_max_min : coverpoint item.ahb_item.start_address {
			type_option.comment = "m-ahb max/min haddr.";
            bins min_haddr = {32'h0};
            bins max_haddr = {32'hffff_ffff};
		}

        ahb_prot0 : coverpoint item.ahb_item.prot0 {
            type_option.comment = "m-ahb instruction or data trans.";
        }

        ahb_prot3 : coverpoint item.ahb_item.prot3 {
            type_option.comment = "m-ahb non-cacheable or cacheable trans.";
        }

        ahb_hsize : coverpoint item.ahb_item.size {
            type_option.comment = "m-ahb hsize.";
            bins hsize[] = {SIZE8, SIZE16, SIZE32};
        }

        ahb_hburst: coverpoint item.ahb_item.burst {
            type_option.comment = "m-ahb hburst.";
            bins single = {SINGLE};
        }

        ahb_addr_offset : coverpoint item.ahb_item.address[0][1:0] {
            type_option.comment = "m-ahb address byte offset.";
            bins haddr_offset[] = {0, 1, 2, 3};
        }

        ahb_trans_cache : cross cache_status, ahb_prot0, ahb_rw, ahb_prot3, ahb_hsize {
            ignore_bins no_write_on_inst = binsof(ahb_prot0) intersect {OPCODE_FETCH} && binsof(ahb_rw) intersect {WRITE};
        }

        ahb_trans_all : cross cache_status, ahb_rw, ahb_hsize, ahb_addr_offset {
            ignore_bins hsize_32b_ignore = binsof(ahb_hsize) intersect {SIZE32} && binsof(ahb_addr_offset) intersect {1,2,3};
            ignore_bins hsize_16b_ignore = binsof(ahb_hsize) intersect {SIZE16} && binsof(ahb_addr_offset) intersect {1,3};
        }

        //R/W data_toggle
        //                   name                data                       condition
        `cover_val_32_bits(wdata_toggle, item.ahb_item.data[0], iff(item.ahb_item.direction == WRITE))
        `cover_val_32_bits(rdata_toggle, item.ahb_item.data[0], iff(item.ahb_item.direction == READ))

        ahb_hprot : coverpoint {item.ahb_item.prot3, item.ahb_item.prot2, item.ahb_item.prot1, item.ahb_item.prot0} {
            type_option.comment = "m-ahb hprot.";
        }

        ahb_hresp : coverpoint item.ahb_item.response[0] {
            type_option.comment = "m-ahb hresp.";
            bins okay_resp = {OKAY};
            bins error_resp= {ERROR};
        }

// 当前覆盖排除了已启用可缓存指令的错误响应组合，对应填充错误不传播的现有行为。
// 若修改错误处理需求，应同步评审此 ignore_bins，避免把新需求排除出覆盖目标。
        ahb_hresp_all: cross cache_status, ahb_rw, ahb_hresp, ahb_prot0, ahb_prot3 {
            ignore_bins no_write_on_inst = binsof(ahb_prot0) intersect {OPCODE_FETCH} && binsof(ahb_rw) intersect {WRITE};
            ignore_bins no_err_resp_on_cache_inst_when_cache_enabled = binsof(cache_status.cache_enable) && binsof(ahb_hresp.error_resp) &&
                        binsof(ahb_prot0) intersect {OPCODE_FETCH} && binsof(ahb_prot3) intersect {CACHEABLE};
        }

        ahb_hmastlock : coverpoint item.ahb_item.lock {
            type_option.comment = "m-ahb hmastlock.";
        }

        ahb_hmastlock_all: cross cache_status, ahb_rw, ahb_hmastlock, ahb_prot0, ahb_prot3 {
            ignore_bins no_write_on_inst = binsof(ahb_prot0) intersect {OPCODE_FETCH} && binsof(ahb_rw) intersect {WRITE};
        }

        idle_between_burst: coverpoint item.ahb_item.idle_delay {
            bins idle_cycles[] = {[0:7]};
        }

        //---2: cache status coverage
        cache_miss : coverpoint item.miss iff(item.i_cacheable_read){
            type_option.comment = "cache miss.";
        }
        
        cache_tag_hit : coverpoint item.tag_hit iff(item.i_cacheable_read){
            type_option.comment = "cache tag_hit[3:0] of all ways.";
            bins tag_hit[] = {4'b0000, 4'b0001, 4'b0010, 4'b0100, 4'b1000}; //one-hot encoding
        }

        cache_tag_hit_flag : coverpoint item.tag_hit_flag iff(item.i_cacheable_read){
            type_option.comment = "cache tag_hit_flag.";
        }

        cache_multi_hit : coverpoint item.tag_hit_flag iff(item.i_cacheable_read){
            type_option.comment = "cache tag hit multiple times.";
            bins hit2 = (1 => 1);
            bins hit3 = (1 => 1[*2]);
            bins hit4 = (1 => 1[*3]);
            bins hit5 = (1 => 1[*4]);
        }

        cache_hit_fill_line : coverpoint item.fill_hit iff(item.i_cacheable_read){
            type_option.comment = "cache hit filling line.";
        }

        cache_miss_then_tag_hit : coverpoint {item.tag_hit_flag, item.miss, item.m_wrap_dphase, item.cache_line_wr} iff(item.i_cacheable_read){
            type_option.comment = "cache miss followed by tag hit.";
            bins miss_then_tag_hit = (4'b0100 => 4'b1010);
        }

        cache_miss_then_tag_hit_multi : coverpoint {item.tag_hit_flag, item.miss, item.m_wrap_dphase, item.cache_line_wr} iff(item.i_cacheable_read){
            type_option.comment = "cache miss followed by tag hit multiple times.";
            bins miss_then_tag_hit_2 = (4'b0100 => 4'b1010[*2]);
            bins miss_then_tag_hit_3 = (4'b0100 => 4'b1010[*3]);
        }

        cache_trans_when_filling : coverpoint {item.ahb_item.prot0, item.ahb_item.prot3, item.ahb_item.direction} iff(item.s_ahb_cache_en && (item.m_wrap_dphase) && (!item.cache_line_wr)){
            type_option.comment = "m-ahb trans when reading missing cache line.";
            bins data_read = {3'b110, 3'b100};
            bins data_write= {3'b111, 3'b101};
            bins cacheable_i_read = {3'b010};
            bins noncacheable_i_read = {3'b000};
        }

        cache_trans_when_write_dmem : coverpoint {item.ahb_item.prot0, item.ahb_item.prot3, item.ahb_item.direction} iff(item.s_ahb_cache_en && (item.m_wrap_dphase) && (item.cache_line_wr)){
            type_option.comment = "m-ahb trans when write missing cache line to data mem.";
            bins data_read = {3'b110, 3'b100};
            bins data_write= {3'b111, 3'b101};
            bins cacheable_i_read = {3'b010};
            bins noncacheable_i_read = {3'b000};
        }

        cache_miss_then_miss : coverpoint {item.miss, item.m_wrap_dphase, item.cache_line_wr} iff(item.i_cacheable_read){
            type_option.comment = "cache miss followed by cache miss.";
            bins miss_then_miss = (3'b100 => 3'b110);
        }

        cache_hit_fill_index : coverpoint (item.hit_fill_index) iff((item.tag_hit != 0) && item.i_cacheable_read){
            type_option.comment = "cache tag hit, hit index == index of current filling line.";
        }

        cache_index : coverpoint item.a_index iff(item.i_cacheable_read){
            type_option.comment = "cache index.";
            bins cache_index[] = {[0:((1<<`INDEX_BITS)-1)]};
        }

        cache_hit_miss_all_index : cross cache_tag_hit, cache_index;
    endgroup


    function new(string name = "inst", uvm_component parent = null);
        super.new(name, parent);
        cover_item = new();
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scb2cov = new("scb2cov", this);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

    //save coverage item to queue
    extern virtual function void write (i_cache_coverage_item item);

    //uvm build in task
    extern task run_phase (uvm_phase phase);

    //display item member variables
    extern virtual function void icache_status_print(i_cache_coverage_item item);
    extern virtual function void icache_item_print(yuu_ahb_item item);

endclass : i_cache_coverage

// analysis 回调每收到一个分类项就采样；这里不驱动激励，也不进行数据正确性比较。
function void i_cache_coverage::write (i_cache_coverage_item item);
    cover_item.sample(item);
endfunction : write

task i_cache_coverage::run_phase(uvm_phase phase);

endtask : run_phase

function void i_cache_coverage::icache_status_print(i_cache_coverage_item item);
    $display("At time %0t, print icache_status values:", $time);
    $display("s_ahb_cache_en: %0h", item.s_ahb_cache_en);
    $display("m_wrap_dphase: %0h", item.m_wrap_dphase);
    $display("cache_line_wr: %0h", item.cache_line_wr);
    $display("i_trans: %0h", item.i_trans);
    $display("tag_hit: %0h", item.tag_hit);
    $display("tag_hit_flag: %0h", item.tag_hit_flag);
    $display("miss: %0h", item.miss);
    $display("replace_way: %0h", item.replace_way);
    $display("a_index: %0h", item.a_index);
    $display("hit_fill_index: %0h", item.hit_fill_index);
endfunction

function void i_cache_coverage::icache_item_print(yuu_ahb_item item);
    $display("At time %0t, print ahb trans item values:", $time);
    $display("addr : %0h", item.address[0]);
    $display("direction : %0h", item.direction);
    $display("hsize : %0h", item.size);
    $display("prot0: %0h", item.prot0);
    $display("prot3: %0h", item.prot3);
endfunction

