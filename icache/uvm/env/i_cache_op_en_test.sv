// 文件说明 i_cache_op_en_test.sv
// 将定向操作序列与随机使能翻转组合，测试访问期间的开关时序。
// 提供普通随机等待和 slv_0_wait 零等待两个版本，下游正常返回 OKAY。

//use this sequence to create a testcase
//ahb-lite slave with random wait cycles
class i_cache_op_en_test extends i_cache_base_test;
  
  `uvm_component_utils(i_cache_op_en_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    slv_seq = i_cache_slv_base_seq::type_id::create("slave_seq");
    en_seq  = i_cache_en_rand_seq::type_id::create("en_seq");
    mas_seq = op_test_seq::type_id::create("master_seq");
    set_report_verbosity_level_hier(UVM_LOW);
  endfunction
endclass

//ahb-lite slave with 0 wait cycle
class i_cache_op_en_test_slv_0_wait extends i_cache_base_test;
  
  `uvm_component_utils(i_cache_op_en_test_slv_0_wait)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    slv_seq = i_cache_slv_0_wait_seq::type_id::create("slave_seq");
    en_seq  = i_cache_en_rand_seq::type_id::create("en_seq");
    mas_seq = op_test_seq::type_id::create("master_seq");
    set_report_verbosity_level_hier(UVM_LOW);
  endfunction
endclass




