// 文件说明 i_cache_virtual_sequence.sv
// 并发启动 CPU 请求、存储器响应和 Cache 使能三条序列。
// 使用 join_any，在任一子序列返回后结束 body；通常由有限的上游请求序列触发。
// 下游响应与使能序列可持续运行，测试收尾由 Base Test 的 objection 控制。


class i_cache_virtual_sequence extends uvm_sequence;
  `uvm_object_utils(i_cache_virtual_sequence)
  `uvm_declare_p_sequencer(i_cache_virtual_sequencer)

  i_cache_mas_base_seq      mas_seq;
  i_cache_slv_base_seq      slv_seq; 
  i_cache_en_base_seq       en_seq;

// Function: new
// Constructor of object.
  function new(string name="i_cache_virtual_sequence");
    super.new(name);
  endfunction

  task body();
// 三条序列并行执行；join_any 只等待其中一条返回，不会在这里自动终止其余线程。
    fork
      mas_seq.start(p_sequencer.master_sequencer);
      slv_seq.start(p_sequencer.slave_sequencer);
      en_seq.start(p_sequencer.en_sequencer);
    join_any
  endtask

endclass

