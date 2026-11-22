// 文件说明 i_cache_base_test.sv
// 所有 I-Cache 测试共用的抽象基类，完成环境配置和运行生命周期管理。
// 派生类必须提供 mas_seq、slv_seq、en_seq；本类绑定接口、配置 Agent 并启动虚拟序列。
// 运行前用相同随机数据初始化下游内存和参考内存，保证比较基准一致。
// 序列结束后固定等待 1000 周期收尾；最终比较与残留队列检查由 Scoreboard 完成。

import uvm_pkg::*;
`include "uvm_macros.svh"

import yuu_common_pkg::*;
import yuu_ahb_pkg::*;

//This class can't be instanced, must give instance pointer to mas_seq, slv_seq
virtual class i_cache_base_test extends uvm_test;
  yuv_ahb_mas_vif       mas_vif ;
  yuv_ahb_slv_vif       slv_vif ;
  yuu_ahb_master_config mas_cfg ;
  yuu_ahb_slave_config  slv_cfg ;

  uvm_event_pool    events;

  i_cache_env       env;
  i_cache_mas_base_seq      mas_seq;    //pointer only, no instance here
  i_cache_slv_base_seq      slv_seq;    //pointer only, no instance here
  i_cache_en_base_seq       en_seq;     //pointer only, no instance here
  i_cache_virtual_sequence  seq;

  uvm_root                  root;

  //`uvm_component_utils(i_cache_base_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    root = uvm_root::get();
  endfunction : new

  function void uvm_env_glb_setting();
    //chang to print all element in the array
    uvm_default_printer.knobs.begin_elements = -1;  

    root.set_report_severity_id_verbosity_hier(UVM_INFO, "CFGDB/GET", UVM_NONE);
  endfunction : uvm_env_glb_setting

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //simulation finish when occured 4 UVM_ERROR
    set_report_max_quit_count(4);
    
    events  = new("events");
    env     = i_cache_env::type_id::create("env", this);
    seq     = i_cache_virtual_sequence::type_id::create("seq");

    mas_cfg = yuu_ahb_master_config::type_id::create("mas_cfg");
    slv_cfg = yuu_ahb_slave_config::type_id::create("slv_cfg");

    if(!uvm_config_db#(yuv_ahb_mas_vif)::get(null, get_full_name(), "mas_vif", mas_vif)) begin
        `uvm_error("i_cache_base_test", "uvm_config_db::get mas_vif fail.")
    end

    if(!uvm_config_db#(yuv_ahb_slv_vif)::get(null, get_full_name(), "slv_vif", slv_vif)) begin
        `uvm_error("i_cache_base_test", "uvm_config_db::get slv_vif fail.")
    end
    
    mas_cfg.events = events;
    mas_cfg.vif    = mas_vif;

    slv_cfg.events = events;
    slv_cfg.vif    = slv_vif;
    
    config_master(mas_cfg);
    config_slave(slv_cfg);

    //set var to master/slave agent
    uvm_config_db#(yuu_ahb_master_config)::set(this, "env.master", "cfg", mas_cfg);
    uvm_config_db#(yuu_ahb_master_config)::set(this, "*", "cfg", mas_cfg);    //set for master trans item

    uvm_config_db#(yuu_ahb_slave_config)::set(this, "env.slave", "cfg", slv_cfg);
    uvm_config_db#(yuu_ahb_slave_config)::set(this, "*", "cfg", slv_cfg);     //set for slave trans item
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    seq.mas_seq = mas_seq;
    seq.slv_seq = slv_seq;
    seq.en_seq  = en_seq;

    uvm_env_glb_setting();
    root.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    int unsigned    data    ;
// objection 保持运行阶段，避免序列尚未结束仿真就提前退出。
    phase.raise_objection(this);
    #10;        //wait ahb-slave agent initial m_mem finish
    //initial mem in scb and ahb-slave agent with same data
// 同一随机字同时写入 Slave 内存和参考字节数组，建立一致的初始数据基准。
    for(uint64 i=`SIM_SYS_MEM_BEG; i<=`SIM_SYS_MEM_END; i=i+4) begin
        data = $urandom();
        //data = i;     //incremental data, debug only
        env.slave.driver.m_mem_32b_write(i, data);

        env.scb.mem[i+0] = data[0*8 +: 8];
        env.scb.mem[i+1] = data[1*8 +: 8];
        env.scb.mem[i+2] = data[2*8 +: 8];
        env.scb.mem[i+3] = data[3*8 +: 8];
    end

    seq.start(env.vsequencer);
// 这是固定收尾等待，不等于所有请求自动完成；结果还需结合 Scoreboard 残留队列检查。
    repeat(1000) mas_vif.wait_cycle();
    phase.drop_objection(this);
  endtask : run_phase


  virtual function void config_master(ref yuu_ahb_master_config cfg);
    cfg.index = 0;
    cfg.addr_width = 32;
    cfg.data_width = 32;    
    cfg.idle_enable = True;
    cfg.busy_enable = True;
    cfg.use_response = False;
    cfg.coverage_enable = False;
    cfg.is_active  = UVM_ACTIVE;
    cfg.use_protection_transfers = True;
    cfg.use_extended_memory_types= False;
    cfg.use_locked_transfers = True;
    cfg.use_secure_transfers = False;
    cfg.use_exclusive_transfers = False;
  endfunction
  
  virtual function void config_slave(ref yuu_ahb_slave_config cfg);
    cfg.index = 0;
    cfg.addr_width = 32;
    cfg.data_width = 32; 
    cfg.set_map(`SIM_SYS_MEM_BEG, `SIM_SYS_MEM_END);
    cfg.mem_init_pattern = PATTERN_RANDOM;
    cfg.wait_enable= True;
    cfg.is_active  = UVM_ACTIVE;
    cfg.coverage_enable = False;
  endfunction
endclass

