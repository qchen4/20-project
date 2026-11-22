// 文件说明 i_cache_en_item.sv
// 描述一次 icache_en 翻转的触发条件和前后等待周期。
// wait_type 选择周期等待、空闲命令、有效命令或可缓存指令事件。
// head_wait 仅用于周期等待分支，tail_wait 控制翻转后的间隔；Driver 执行实际翻转。

class i_cache_en_item extends uvm_sequence_item;
    //the condition to toggle the value of icache_en
    //0: after head_wait cycles;
    //1: after ahb idle trans;
    //2: after ahb nonseq trans;
    //3: after a cacheable instruction read trans;
    rand bit [2:0]   wait_type   ;
    rand bit [31:0]  head_wait   ;
    rand bit [31:0]  tail_wait   ;

    `uvm_object_utils_begin(i_cache_en_item)
        `uvm_field_int(wait_type,   UVM_ALL_ON)
        `uvm_field_int(head_wait,   UVM_ALL_ON)
        `uvm_field_int(tail_wait,   UVM_ALL_ON)    
    `uvm_object_utils_end

    function new(string name="i_cache_en_item");
        super.new(name);
    endfunction


    constraint c_type {
        wait_type dist {0:=10, 1:=20, 2:=30, 3:=40};
    }

    constraint  c_head_wait {
        head_wait dist {[1:16]:/10, [17:128]:/20, [129:1024]:/20, [1025:(8*1024)]:/50};
    }

    constraint  c_tail_wait {
        tail_wait dist {[1:16]:/10, [17:128]:/20, [129:1024]:/20, [1025:(8*1024)]:/50};
    }


endclass

