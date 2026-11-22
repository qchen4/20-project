// 文件说明 i_cache_en_rand_seq.sv
// 随机使能序列，先开启 Cache，再等待首次标签查询检查点。
// 之后持续发送随机翻转事务，覆盖访问和填充期间的关闭与重新开启。

class i_cache_en_rand_seq extends i_cache_en_base_seq;

    `uvm_object_utils(i_cache_en_rand_seq)
    function new(string name="i_cache_en_rand_seq");
        super.new(name);
    endfunction

    virtual task body();
        i_cache_en_item     item;

        //just 1 item to change icache_en from 0 --> 1
        `uvm_do_with(item, {item.wait_type == 0; item.head_wait < 16; tail_wait < 16;})

        //wait ahb-lite master send out a cacheable trans
        wait(misc_vif.mon_cb.hit_chk_point==1);

        //never end
        forever begin
            `uvm_do(item)
        end
    endtask : body

endclass

