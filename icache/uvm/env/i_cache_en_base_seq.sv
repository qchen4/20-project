// 文件说明 i_cache_en_base_seq.sv
// 基础使能序列，启动后短暂等待并把初始关闭状态翻转为开启。
// 随后持续等待不再发送翻转事务，供不需要随机开关的测试复用。

class i_cache_en_base_seq extends uvm_sequence;

    //DUT internal and IO signals
    i_cache_misc_vif    misc_vif;

    `uvm_object_utils(i_cache_en_base_seq)
    function new(string name="i_cache_en_base_seq");
        super.new(name);
    endfunction

    virtual task pre_body();
        if(!uvm_config_db#(i_cache_misc_vif)::get(null, get_full_name(), "misc_vif", misc_vif)) begin
            `uvm_error(get_name(), "uvm_config_db::get DUT monitor virtual interface fail.")
        end    
    endtask : pre_body

    virtual task body();
        i_cache_en_item     item;

        //just 1 item to change icache_en from 0 --> 1
        `uvm_do_with(item, {item.wait_type == 0; item.head_wait < 16; tail_wait < 16;})

        //never end
        forever begin
            #100ms;
        end
    endtask : body

endclass

