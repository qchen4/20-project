// 文件说明 i_cache_op_en_err_test.sv
// 组合定向操作、随机使能翻转和下游错误响应。
// 实际 Slave 序列为 i_cache_slv_err_resp_seq，其等待固定为零；上游仍使用 op_test_seq。

//use this sequence to create a testcase
//ahb-lite slave with random wait cycles
class i_cache_op_en_err_test extends i_cache_base_test;
  
  `uvm_component_utils(i_cache_op_en_err_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    slv_seq = i_cache_slv_err_resp_seq::type_id::create("slave_seq");
    en_seq  = i_cache_en_rand_seq::type_id::create("en_seq");
    mas_seq = op_test_seq::type_id::create("master_seq");
    set_report_verbosity_level_hier(UVM_LOW);
  endfunction
endclass


