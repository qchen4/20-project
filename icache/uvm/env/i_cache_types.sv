// 文件说明 i_cache_types.sv
// 定义项目激励控制项、参考缓存状态、内部观察项及覆盖率采样项。
// m_ahb_ctl 约束访问属性、地址区域、对齐、间隔和锁定；s_ahb_ctl 约束响应等待。
// icache_ctl_t 保存模型四路数据和标签，i_cache_coverage_item 汇合事务与缓存分类。
// 随机权重受其他约束共同影响，不能直接等同于最终事务比例。

`include "sim_define.v"

import uvm_pkg::*;
`include "uvm_macros.svh"

import yuu_common_pkg::*;
import yuu_amba_pkg::*;
import yuu_ahb_pkg::*;

class m_ahb_ctl extends uvm_sequence_item;
    rand logic  [31:0]  addr    ;   //rw addr
    rand logic  [31:0]  wdata   ;   //write data
    rand logic          rw      ;   //0:read; 1:write
    rand logic  [1:0]   hsize   ;   //0:byte; 1:16bit; 2:32bit
    rand logic  [3:0]   hprot   ;   //[0]: op/data, [1]: user/privileged, [2]: non-bufferable/bufferable [3]: non-cacheable/cacheable
    rand logic  [7:0]   delay   ;   //wait cycle between each burst
    rand bit            lock    ;   //hmastlock; lock==1 only for data r/w access

    `uvm_object_utils(m_ahb_ctl)

    function new(string name="m_ahb_ctl");
        super.new(name);
    endfunction

    constraint  c_hsize {
        hsize inside {0,1,2};
    }

    constraint  c_rw_rate {
        rw  dist {0:=80, 1:=20};
    }

    constraint  c_hprot {
        hprot[0] dist {0:=70, 1:=30};
        hprot[3] dist {0:=30, 1:=70};
    }
    
    constraint  c_delay {
        delay inside {[0:20]};
        delay dist {0:/90, [1:3]:/5, [4:20]:/5};
    }

    //0~15KB: inst cacheable; 15~16KB: inst non-cacheable;
    //16~32KB: data
// 地址区域用于构造测试流量；DUT 是否缓存由总线属性判断，并非由这些软件区间硬编码判断。
    constraint  c_addr {
        solve hprot before addr;
        addr inside {[`SIM_SYS_MEM_BEG : `SIM_SYS_MEM_END]};
        if(hprot[0] == 0) { //op code
            rw == 0;    //read
            if(hprot[3] == 1) {
                addr inside {[`SIM_SYS_MEM_BEG : `SIM_SYS_MEM_BEG+ (15*1024-1)]};
            } else {
                addr inside {[`SIM_SYS_MEM_BEG + (15*1024) : `SIM_SYS_MEM_BEG + (16*1024-1)]};
            }
        } else {            //data
            addr inside {[`SIM_SYS_MEM_BEG + (16*1024) : `SIM_SYS_MEM_END]};
        }

        //haddr normalization
        if(hsize == 1) {
            addr[0] == 1'b0;
        } else if(hsize == 2) {
            addr[1:0] == 2'b0;
        }
    }

    constraint c_lock {
        lock dist {0 := 90, 1 := 10};
    }

endclass : m_ahb_ctl


class s_ahb_ctl extends uvm_sequence_item;
    rand logic  [7:0]   delay   ;   //response wait cycle
    `uvm_object_utils(s_ahb_ctl)

    function new(string name="s_ahb_ctl");
        super.new(name);
    endfunction

    constraint  c_delay {
        delay inside {[0:12]};
        delay dist {0:/90, [1:3]:/5, [4:128]:/5};
    }
endclass : s_ahb_ctl


typedef struct {
bit [(1<<(`OFFSET_BITS+3)) -1 : 0]  way0    [0 : ((1<<`INDEX_BITS) - 1)];   //data mem of each way
bit [(1<<(`OFFSET_BITS+3)) -1 : 0]  way1    [0 : ((1<<`INDEX_BITS) - 1)];
bit [(1<<(`OFFSET_BITS+3)) -1 : 0]  way2    [0 : ((1<<`INDEX_BITS) - 1)];
bit [(1<<(`OFFSET_BITS+3)) -1 : 0]  way3    [0 : ((1<<`INDEX_BITS) - 1)];

bit [`TAG_MEM_WIDTH -1 : 0] tag_mem [0 : `TAG_MEM_DEPTH - 1];               //tag mem
bit                     last_miss       ;   //last m-ahb trans is miss
bit [`INDEX_BITS-1 : 0] last_miss_index ;
bit [`TAG_BITS-1 : 0]   last_miss_tag   ;
bit [1:0]               last_replace_way;
} icache_ctl_t;


typedef struct {
bit [`INDEX_BITS-1 : 0]     index;
bit [`TAG_MEM_WIDTH -1 : 0] tags;
} icache_tag_update_t;


//DUT status, used to control the behavior of ref model
class i_cache_dut_status extends uvm_sequence_item;
    logic   s_ahb_cache_en  ;
    logic   m_wrap_dphase   ;
    logic   cache_line_wr   ;

    `uvm_object_utils_begin(i_cache_dut_status)
        `uvm_field_int(s_ahb_cache_en,  UVM_ALL_ON)
        `uvm_field_int(m_wrap_dphase,   UVM_ALL_ON)
        `uvm_field_int(cache_line_wr,   UVM_ALL_ON)
    `uvm_object_utils_end    

    function new(string name="i_cache_dut_status");
        super.new(name);
    endfunction
endclass : i_cache_dut_status


//DUT internal signals only, used to do internal signal compare with ref model
class i_cache_dut_mon_item extends uvm_sequence_item;
    logic   [`TAG_MEM_WIDTH-1 :0]   tag_info_used   ;
    logic   [31:0]  chk_haddr_d     ;
    logic           w0_hit, w1_hit, w2_hit, w3_hit  ;
    logic           fill_hit        ;
    logic           cache_miss      ;    

    `uvm_object_utils_begin(i_cache_dut_mon_item)
        `uvm_field_int(tag_info_used,   UVM_ALL_ON)
        `uvm_field_int(chk_haddr_d,     UVM_ALL_ON)
        `uvm_field_int(w0_hit,          UVM_ALL_ON)
        `uvm_field_int(w1_hit,          UVM_ALL_ON)
        `uvm_field_int(w2_hit,          UVM_ALL_ON)
        `uvm_field_int(w3_hit,          UVM_ALL_ON)
        `uvm_field_int(fill_hit,        UVM_ALL_ON)
        `uvm_field_int(cache_miss,      UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name="i_cache_dut_mon_item");
        super.new(name);
    endfunction

endclass : i_cache_dut_mon_item


class i_cache_coverage_item extends uvm_sequence_item;
    `uvm_object_utils(i_cache_coverage_item)

    yuu_ahb_master_item ahb_item;

    //status from DUT
    bit         s_ahb_cache_en  ;   //DUT status
    bit         m_wrap_dphase   ;
    bit         cache_line_wr   ;
    
    //status from ref model
    bit         i_trans         ;
    bit         i_cacheable_read;   //cachebale instruction read trans from master port
    bit [3:0]   tag_hit         ;
    bit         fill_hit        ;
    bit         tag_hit_flag    ;
    bit         miss            ;
    byte        replace_way     ;
    bit [`INDEX_BITS-1 : 0] a_index;//current trans cache hit or miss index
    bit         hit_fill_index  ;   //same index as current read cache line, but not hit fill line

    function new(string name="i_cache_coverage_item");
        super.new(name);
        ahb_item = yuu_ahb_master_item::type_id::create("ahb_item");
    endfunction

endclass : i_cache_coverage_item

