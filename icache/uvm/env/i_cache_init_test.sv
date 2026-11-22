// 文件说明 i_cache_init_test.sv
// 定义初始化阶段访问序列及 8/16/32 位三个测试类。
// 每个测试发送 64 个指定大小的随机 SINGLE 请求，配合随机等待和基础使能序列。
// 这里的 64 是请求数量，不能直接当作已经精确等待 64 个时钟周期。

//test sequence
class init_test_seq extends i_cache_mas_base_seq;

  `uvm_object_utils(init_test_seq)
  byte          hsize   =0;
  m_ahb_ctl     ctl;

  // Function: new
  // Constructor of object.
  function new(string name="init_test_seq");
    super.new(name);
  endfunction

  //send_fixed_item defined in class i_cache_mas_base_seq
  //virtual task send_fixed_item(input int addr, int wdata, byte rw, byte hsize, byte hprot, int delay_burst);
  //rw:     0: read, 1: write;
  //hsize:  same as ahb-lite define
  //hprot:  [0]: op/data, [1]: user/privileged, [2]: non-bufferable/bufferable [3]: non-cacheable/cacheable
  //delay_burst: wait cycle between each burst
  // Task: body
  // UVM built-in method.
  virtual task body();
    ctl = m_ahb_ctl::type_id::create("ctl");

    for(int i=0; i<64; i++) begin
        if(!ctl.randomize() with {hsize == local::hsize;}) begin
            `uvm_fatal("body", "m_ahb_ctl randomize error.")
        end else begin
            send_fixed_item(ctl.addr, ctl.wdata, ctl.rw, ctl.hsize, ctl.hprot, ctl.delay, ctl.lock);
        end
    end
  endtask
endclass

//use this sequence to create a testcase
//initial test with hsize = 0
class i_cache_init_test_8b extends i_cache_base_test;

  init_test_seq         master_seq;
  `uvm_component_utils(i_cache_init_test_8b)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    slv_seq = i_cache_slv_base_seq::type_id::create("slave_seq");
    en_seq  = i_cache_en_base_seq::type_id::create("en_seq");


    master_seq =init_test_seq::type_id::create("master_seq");
    master_seq.hsize = 0;   //byte trans
    mas_seq = master_seq;

    `uvm_info(get_name(), $sformatf("Set master_seq.hsize = 0 in test i_cache_init_test_8b"), UVM_LOW)
  endfunction

endclass


//initial test with hsize = 1
class i_cache_init_test_16b extends i_cache_base_test;
  
  init_test_seq         master_seq;

  `uvm_component_utils(i_cache_init_test_16b)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    slv_seq = i_cache_slv_base_seq::type_id::create("slave_seq");
    en_seq  = i_cache_en_base_seq::type_id::create("en_seq");

    master_seq=init_test_seq::type_id::create("master_seq");
    master_seq.hsize = 1;   //16bit trans
    mas_seq   = master_seq;
  endfunction

endclass


//initial test with hsize = 2
class i_cache_init_test_32b extends i_cache_base_test;
  
  init_test_seq         master_seq;

  `uvm_component_utils(i_cache_init_test_32b)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    slv_seq = i_cache_slv_base_seq::type_id::create("slave_seq");
    en_seq  = i_cache_en_base_seq::type_id::create("en_seq");

    master_seq=init_test_seq::type_id::create("master_seq");
    master_seq.hsize = 2;   //32bit trans
    mas_seq   = master_seq;
  endfunction

endclass

