// 文件说明 i_cache_virtual_sequencer.sv
// 保存上游、下游和使能三个 Sequencer 的句柄，作为跨接口协调入口。
// 句柄由 i_cache_env.connect_phase 连接；自身不直接驱动总线。

`include "sim_define.v"

class i_cache_virtual_sequencer extends uvm_virtual_sequencer;

  // Variable: master_sequencer
  yuu_ahb_master_sequencer  master_sequencer;

  // Variable: slave_sequencer
  yuu_ahb_slave_sequencer   slave_sequencer;

  i_cache_en_sequencer      en_sequencer;

  `uvm_component_utils(i_cache_virtual_sequencer)

  extern function      new(string name, uvm_component parent);
  extern function void connect_phase(uvm_phase phase);
endclass

// Function: new
// Constructor of object.
function i_cache_virtual_sequencer::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

// Function: connect_phase
// UVM built-in method.
function void i_cache_virtual_sequencer::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction


