// 文件说明 i_cache_rand_test.sv
// 约束随机访问序列与完整测试组合。
// 先在四个局部地址窗口各发 10K 次请求，再在完整测试区域发 64K 次请求。
// 当前测试选择错误响应 Slave 序列和随机使能序列，兼顾访问随机性与状态扰动。

//test sequence
class rand_test_seq extends i_cache_mas_base_seq;

  `uvm_object_utils(rand_test_seq)
  m_ahb_ctl     ctl;

  // Function: new
  // Constructor of object.
  function new(string name="rand_test_seq");
    super.new(name);
  endfunction

  //send_fixed_item defined in class i_cache_mas_base_seq
  //virtual task send_fixed_item(input int addr, int wdata, byte rw, byte hsize, byte hprot, int delay_burst);
  //rw:     0: read, 1: write;
  //hsize:  same as ahb-lite define
  //hprot:  [0]: op/data, [1]: user/privileged, [2]: non-bufferable/bufferable [3]: non-cacheable/cacheable
  //delay_burst: wait cycle between each burst
  //lock    :hmastlock
  // Task: body
  // UVM built-in method.
  virtual task body();
    uint32  beg_addr, end_addr;

    ctl = m_ahb_ctl::type_id::create("ctl");

    //1: send out trans within an address range
    for(int seg=0; seg<4; seg=seg+1) begin
        `uvm_info(get_name(), $sformatf("Do rand test in segment %0d.", seg), UVM_LOW)
        beg_addr = `SIM_SYS_MEM_BEG + seg*4*1024;
        end_addr = beg_addr + 5*1024 - 1;
        
        for(int i=0; i<10*1024; i++) begin
            if( !(ctl.randomize() with {addr inside {[beg_addr : end_addr]}; }) ) begin
                `uvm_fatal("body", "m_ahb_ctl randomize error.")
            end else begin
                send_fixed_item(ctl.addr, ctl.wdata, ctl.rw, ctl.hsize, ctl.hprot, ctl.delay, ctl.lock);
            end
        end
    end

    //2: send out trans within full address range
    `uvm_info(get_name(), $sformatf("Do full address range rand test."), UVM_LOW)
    for(int i=0; i<64*1024; i++) begin
        if(i == 16*1024)
            `uvm_info(get_name(), $sformatf("Full address range test finish 25 percent."), UVM_LOW)
        else if(i == 32*1024)
            `uvm_info(get_name(), $sformatf("Full address range test finish 50 percent."), UVM_LOW)
        else if(i == 48*1024)
            `uvm_info(get_name(), $sformatf("Full address range test finish 75 percent."), UVM_LOW)


        if( !(ctl.randomize())) begin
            `uvm_fatal("body", "m_ahb_ctl randomize error.")
        end else begin
            send_fixed_item(ctl.addr, ctl.wdata, ctl.rw, ctl.hsize, ctl.hprot, ctl.delay, ctl.lock);
        end
    end

  endtask
endclass

//use this sequence to create a testcase
//ahb-lite slave with random wait cycles
class i_cache_rand_test extends i_cache_base_test;
  
  `uvm_component_utils(i_cache_rand_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mas_seq = rand_test_seq::type_id::create("master_seq");
    //slv_seq = i_cache_slv_base_seq::type_id::create("slave_seq");
    slv_seq = i_cache_slv_err_resp_seq::type_id::create("slave_seq");
    en_seq  = i_cache_en_rand_seq::type_id::create("en_seq");

    set_report_verbosity_level_hier(UVM_LOW);
  endfunction
endclass


