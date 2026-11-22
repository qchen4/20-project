// 文件说明 i_cache_en_agent.sv
// 定义使能 Driver、Sequencer 和 Agent，独立控制 Cache 开关。
// Driver 初始关闭 Cache，按事务指定条件等待，再翻转 icache_en 并等待 tail_wait。
// 通过 clocking block 驱动，使用 get_next_item/item_done 与 Sequencer 完成握手。


class i_cache_en_driver extends uvm_driver #(.REQ(i_cache_en_item));

    //DUT internal and IO signals
    i_cache_misc_vif    misc_vif;

    `uvm_component_utils(i_cache_en_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new


    virtual function void connect_phase(uvm_phase phase);
        if(!uvm_config_db#(i_cache_misc_vif)::get(null, get_full_name(), "misc_vif", misc_vif)) begin
            `uvm_error(get_name(), "uvm_config_db::get DUT monitor virtual interface fail.")
        end
    endfunction : connect_phase


    virtual task run_phase(uvm_phase phase);
        i_cache_en_item     item;

        misc_vif.drv_cb.icache_en <= 1'b0;

        forever begin
            seq_item_port.get_next_item(item);

// 等待的是指定事件，再翻转一次使能；不是持续把 icache_en 驱动成某个事务字段值。
            case(item.wait_type)
            //after head_wait cycles
            'd0:    begin
                repeat(item.head_wait) @(misc_vif.mon_cb);
            end

            //after ahb idle trans
            'd1:    begin
                do begin
                    @(misc_vif.mon_cb);
                end while(!misc_vif.mon_cb.s_idle_cmd);
            end

            //after ahb nonseq trans
            'd2:    begin
                do begin
                    @(misc_vif.mon_cb);
                end while(!misc_vif.mon_cb.s_vld_cmd);
            end

            //after a cacheable instruction read trans
            'd3:    begin
                do begin
                    @(misc_vif.mon_cb);
                end while(!misc_vif.mon_cb.s_cacheable_inst);
            end

            endcase

            misc_vif.drv_cb.icache_en <= !misc_vif.icache_en;
            repeat(item.tail_wait) @(misc_vif.drv_cb);

            seq_item_port.item_done();
        end //forever loop

    endtask : run_phase
endclass : i_cache_en_driver


class i_cache_en_sequencer extends uvm_sequencer #(.REQ(i_cache_en_item));
    
    `uvm_component_utils(i_cache_en_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : i_cache_en_sequencer


class i_cache_en_agent extends uvm_agent;

    `uvm_component_utils(i_cache_en_agent)
    
    i_cache_en_sequencer        sqr ;
    i_cache_en_driver           drv ;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sqr     = i_cache_en_sequencer::type_id::create("sqr", this);
        drv     = i_cache_en_driver::type_id::create("drv", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction

endclass : i_cache_en_agent


