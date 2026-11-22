// 文件说明 i_cache_env.sv
// 组装 I-Cache UVM 环境并连接激励与检查通路。
// 包含上游 Master Agent、下游 Slave Agent、使能 Agent、虚拟 Sequencer、Monitor 和 Scoreboard。
// 两侧总线事务与内部状态送往 Scoreboard，分类结果再送往可选功能覆盖组件。
`include "sim_define.v"

// Class: i_cache_env
// AHB environment class, a container of masters and slaves
class i_cache_env extends uvm_env;
  // Variable: master
  // AHB master agent instances.
  yuu_ahb_master_agent  master  ;

  // Variable: slave
  // AHB slave agent instances.
  yuu_ahb_slave_agent   slave   ;

  i_cache_en_agent      en_agt  ;


  // Variable: vsequencer
  // AHB virtual sequencer handle.
  i_cache_virtual_sequencer vsequencer;

  //i-cache internal status monitor
  i_cache_dut_monitor   dut_monitor;

  //i-cache reference model
  i_cache_scb           scb     ;

  //function coverage
  i_cache_coverage      cov     ;

  `uvm_component_utils(i_cache_env)

  extern function      new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass

// Function: new
// Constructor of object.
function i_cache_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

// Function: build_phase
// UVM built-in method.
function void i_cache_env::build_phase(uvm_phase phase);
  super.build_phase(phase);
  scb       = i_cache_scb::type_id::create("scb", this);
  vsequencer= i_cache_virtual_sequencer::type_id::create("vsequencer", this);
  master    = yuu_ahb_master_agent::type_id::create("master", this);
  slave     = yuu_ahb_slave_agent::type_id::create("slave", this);
  en_agt    = i_cache_en_agent::type_id::create("en_agt", this);
  dut_monitor= i_cache_dut_monitor::type_id::create("dut_monitor", this);
  `ifdef SIM_EN_FUNC_COVERAGE
  cov       = i_cache_coverage::type_id::create("cov", this);
  `endif
endfunction

// Function: connect_phase
// UVM built-in method.
function void i_cache_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  vsequencer.master_sequencer = master.sequencer;
  vsequencer.slave_sequencer  = slave.sequencer;
  vsequencer.en_sequencer     = en_agt.sqr;

  //connect master/slave analisys port to scb
// 按观察源送入三个独立入口，避免把 CPU 侧请求与存储器侧实际访问混为一类。
  master.out_monitor_port.connect(scb.mas2scb);
  slave.out_monitor_port.connect(scb.slv2scb);
  dut_monitor.dut_monitor_port.connect(scb.dutsta2scb);
  `ifdef SIM_EN_FUNC_COVERAGE
  scb.scb2cov.connect(cov.scb2cov);
  `endif
endfunction

