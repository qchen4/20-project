// 文件说明 i_cache_dut_monitor.sv
// 在上游有效命令采样点记录 DUT 状态并发送给 Scoreboard。
// 采集内部缓存使能、填充数据阶段和整行写入状态，用于参考模型的事务对齐。
// 通过 misc_vif 的 mon_cb 观察信号，不驱动 DUT，也不直接比较读数据。

class i_cache_dut_monitor extends uvm_monitor;

    //only DUT internal and IO signals
    i_cache_misc_vif misc_vif;
    uvm_analysis_port #(i_cache_dut_status) dut_monitor_port;

    `uvm_component_utils(i_cache_dut_monitor)

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        dut_monitor_port = new("dut_monitor_port", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        if(!uvm_config_db#(i_cache_misc_vif)::get(null, get_full_name(), "misc_vif", misc_vif)) begin
            `uvm_error(get_name(), "uvm_config_db::get DUT monitor virtual interface fail.")
        end
    endfunction

    task run_phase(uvm_phase phase);
    i_cache_dut_status      dut_status  ;

    forever begin
        do begin
            @(misc_vif.mon_cb);
        end while (!misc_vif.mon_cb.s_vld_cmd);
        
        //monitor DUT status signals when receive a valid ahb trans, and sent it to scb
        dut_status  = i_cache_dut_status::type_id::create("dut_status");
        dut_status.s_ahb_cache_en   = misc_vif.mon_cb.s_ahb_cache_en;
        dut_status.m_wrap_dphase    = misc_vif.mon_cb.m_wrap_dphase;
        dut_status.cache_line_wr    = misc_vif.mon_cb.cache_line_wr;
        dut_monitor_port.write(dut_status);
    end
    endtask : run_phase

endclass : i_cache_dut_monitor

