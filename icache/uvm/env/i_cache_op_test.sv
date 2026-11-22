// 文件说明 i_cache_op_test.sv
// 定向 Cache 操作序列，以及随机等待和零等待两个测试组合。
// 覆盖旁路、命中、缺失、三种填充命中来源、回绕、填充交叠访问和连续缺失。
// 遍历大小与合法字节偏移，再用顺序和随机地址增加命中及替换压力。

//test sequence
class op_test_seq extends i_cache_mas_base_seq;

  `uvm_object_utils(op_test_seq)
  byte          hsize   =0  ;
  byte          byte_offset ;
  byte          byte_inc    ;
  int           hsize_base, byte_offset_base;
  int           addr        ;
  int           data        ;

  m_ahb_ctl     ctl;

  // Function: new
  // Constructor of object.
  function new(string name="op_test_seq");
    super.new(name);
  endfunction

  virtual function int addr_normal(int addr, byte hsize);
    if(hsize == 1)      addr[0] = 1'b0;
    else if(hsize == 2) addr[1:0] = 2'b00;
    
    return  addr;
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
    bit [7:0]   lock_rand;

    ctl = m_ahb_ctl::type_id::create("ctl");

    //0: send out 64 non-cacheable trans to full fill the cache initial cycles
    for(int i=0; i<64; i++) begin
        if(!ctl.randomize() with {hprot[3] == 1'b0;}) begin
            `uvm_fatal("body", "m_ahb_ctl randomize error.")
        end else begin
            send_fixed_item(ctl.addr, ctl.wdata, ctl.rw, ctl.hsize, ctl.hprot, ctl.delay);
        end
    end


    wait(misc_vif.mon_cb.s_ahb_cache_en==1);

    //1: send out cache operation test sequence
    for(hsize=0; hsize <=2; hsize++) begin
        `uvm_info("cache_op_test", $sformatf("test with hsize = %0d.", hsize), UVM_LOW)
        byte_inc    = 1 << hsize;
        hsize_base  = `SIM_SYS_MEM_BEG + 1024 * hsize;

        for(byte_offset=0; byte_offset<4; byte_offset+=byte_inc) begin
            `uvm_info("cache_op_test", $sformatf("test with byte_offset = %0d.", byte_offset), UVM_LOW)
            byte_offset_base = byte_offset * 256;

            //--- 1.1: non-cacheable data write
            addr = $urandom_range(`SIM_SYS_MEM_BEG + 16*1024, `SIM_SYS_MEM_END);
            addr = addr_normal(addr, hsize);
            data = $urandom();
            send_fixed_item(addr, data, 1'b1, hsize, 4'b0101, 0);

            //--- 1.2 non-cacheable data read
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b0101, 0);

            //--- 1.3 non-cacheable instruction read
            addr = $urandom_range(`SIM_SYS_MEM_BEG + 15*1024, `SIM_SYS_MEM_BEG + (16*1024-1));
            addr = addr_normal(addr, hsize);
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b0100, 0);
    
            //--- 1.4 cacheable data write
            addr = $urandom_range(`SIM_SYS_MEM_BEG + 16*1024, `SIM_SYS_MEM_END);
            addr = addr_normal(addr, hsize);
            data = $urandom();
            send_fixed_item(addr, data, 1'b1, hsize, 4'b1001, 0);

            //--- 1.5 cacheable data read
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1001, 0);

            //--- 1.6 cacheable instr read with miss
            addr = hsize_base + byte_offset_base + 32'h0000 + byte_offset;
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 0);
            
            //--- 1.7 cacheable instr read with miss
            addr = hsize_base + byte_offset_base + 32'h0010 + byte_offset;
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 16);

            //--- 1.8 cacheable instr read with hit
            addr = hsize_base + byte_offset_base + 32'h0004 + byte_offset;
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 16);

            //--- 1.9 cacheable instr read with 8 hits
            addr = hsize_base + byte_offset_base + 32'h0000 + byte_offset;
            for(int i=0; i<8; i++) begin
                send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 0);
                addr += 4;
            end

            //--- 1.10 cacheable instr read miss, followed by fill line with current read back data
            addr = hsize_base + byte_offset_base + 32'h0020 + byte_offset;
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 0);
            send_fixed_item((addr+4), 32'h0, 1'b0, hsize, 4'b1000, 0);

            //--- 1.11 cacheable instr read miss, followed by fill line with already read back data
            addr = hsize_base + byte_offset_base + 32'h0030 + byte_offset;
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 0);
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 2);
            send_fixed_item(addr+4, 32'h0, 1'b0, hsize, 4'b1000, 0);
        
            //--- 1.12 cacheable instr read miss, followed by fill line with will read back data
            addr = hsize_base + byte_offset_base + 32'h0040 + byte_offset;
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 0);
            send_fixed_item(addr+8, 32'h0, 1'b0, hsize, 4'b1000, 0);

            //--- 1.13 cacheable instr read miss, followed by tag hit
            addr = hsize_base + byte_offset_base + 32'h0050 + byte_offset;
            send_fixed_item(addr+4, 32'h0, 1'b0, hsize, 4'b1000, 64);    //wrap test
            addr = hsize_base + byte_offset_base + 32'h0010 + byte_offset;
            send_fixed_item(addr+4, 32'h0, 1'b0, hsize, 4'b1000, 0);

            //--- 1.14 cacheable instr read miss, followed by multiple tag hit
            addr = hsize_base + byte_offset_base + 32'h0060 + byte_offset;
            send_fixed_item(addr+8, 32'h0, 1'b0, hsize, 4'b1000, 64);    //wrap test

            addr = hsize_base + byte_offset_base + 32'h0020 + byte_offset;
            for(int i=0; i<8; i++) begin
                send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 0);
                addr += 4;
            end
             
            //--- 1.15 cacheable instr read miss, followed by non-cacheable instr read
            addr = hsize_base + byte_offset_base + 32'h0070 + byte_offset;
            send_fixed_item(addr+12, 32'h0, 1'b0, hsize, 4'b1000, 0);   //wrap test

            for(int i=0; i<4; i++) begin
                addr = $urandom_range(`SIM_SYS_MEM_BEG + 15*1024, `SIM_SYS_MEM_BEG + (16*1024-1));
                addr = addr_normal(addr, hsize);
                send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b0100, 0);
            end
            
            //--- 1.16.1 cacheable instr read miss, followed by data write
            addr = hsize_base + byte_offset_base + 32'h0080 + byte_offset;
            send_fixed_item(addr+12, 32'h0, 1'b0, hsize, 4'b1000, 0);   //wrap test

            for(int i=0; i<4; i++) begin
                addr = $urandom_range(`SIM_SYS_MEM_BEG + 16*1024, `SIM_SYS_MEM_END);
                addr = addr_normal(addr, hsize);
                send_fixed_item(addr, 32'h0, 1'b1, hsize, 4'b0101, 0);
            end

            //--- 1.16.2 cacheable instr read miss, followed by data read
            addr = hsize_base + byte_offset_base + 32'h0090 + byte_offset;
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 0);

            for(int i=0; i<4; i++) begin
                addr = $urandom_range(`SIM_SYS_MEM_BEG + 16*1024, `SIM_SYS_MEM_END);
                addr = addr_normal(addr, hsize);
                send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b0101, 0);
            end

            //--- 1.17 cacheable instr read miss, followed by cacheable instr read with miss
            addr = hsize_base + byte_offset_base + 32'h00a0 + byte_offset;
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 0);

            addr = hsize_base + byte_offset_base + 32'h00b0 + byte_offset;
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 0);
        end //for(byte_offset=0; byte_offset<4; byte_offset+=byte_inc)
    end //for(hsize=0; hsize <=2; hsize++)

    //2: send out cache miss/hit test seq
    //--- 2.1 8bit cacheable read 11~12KB
    hsize = 0;
    `uvm_info("cache_op_test", $sformatf("cache miss/hit test with hsize = %0d.", hsize), UVM_LOW)

    for(addr=11*1024; addr<12*1024; addr+=1) begin
        send_fixed_item((`SIM_SYS_MEM_BEG + addr), 32'h0, 1'b0, hsize, 4'b1000, 0);
    end

    //--- 2.2 16bit cacheable read 12~13KB
    hsize = 1;
    `uvm_info("cache_op_test", $sformatf("cache miss/hit test with hsize = %0d.", hsize), UVM_LOW)
    for(addr=12*1024; addr<13*1024; addr+=2) begin
        send_fixed_item((`SIM_SYS_MEM_BEG + addr), 32'h0, 1'b0, hsize, 4'b1000, 0);
    end

    //--- 2.3 32bit cacheable read 13~15KB
    hsize = 2;
    `uvm_info("cache_op_test", $sformatf("cache miss/hit test with hsize = %0d.", hsize), UVM_LOW)
    for(addr=13*1024; addr<15*1024; addr+=4) begin
        send_fixed_item((`SIM_SYS_MEM_BEG + addr), 32'h0, 1'b0, hsize, 4'b1000, 0);
    end

    //--- 2.4 random addr/hsize cacheable read 11~15KB
    `uvm_info("cache_op_test", $sformatf("cache miss/hit test with rand hszie and addr in 11~15KB."), UVM_LOW)
    for(int i=0; i<4096; i++) begin
        hsize = $urandom_range(0, 2);
        addr = $urandom_range(`SIM_SYS_MEM_BEG + 11*1024, `SIM_SYS_MEM_BEG + (15*1024-1));
        addr = addr_normal(addr, hsize);

        lock_rand = $urandom_range(0,9);

        if(lock_rand >= 2)
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 0, 0);   //hmastlock=0;
        else
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 0, 1);   //hmastlock=1;
    end

    //--- 2.5 random addr/hsize cacheable read 7~15KB
    `uvm_info("cache_op_test", $sformatf("cache miss/hit test with rand hszie and addr in 7~15KB."), UVM_LOW)
    for(int i=0; i<(8192*4); i++) begin
        
        hsize = $urandom_range(0, 2);
        addr = $urandom_range(`SIM_SYS_MEM_BEG + 7*1024, `SIM_SYS_MEM_BEG + (15*1024-1));
        addr = addr_normal(addr, hsize);
        lock_rand = $urandom_range(0,9);

        if(lock_rand >= 2)
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 0, 0);   //hmastlock=0;
        else
            send_fixed_item(addr, 32'h0, 1'b0, hsize, 4'b1000, 0, 1);   //hmastlock=1;        
    end

  endtask
endclass

//use this sequence to create a testcase
//ahb-lite slave with random wait cycles
class i_cache_op_test extends i_cache_base_test;
  
  `uvm_component_utils(i_cache_op_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    slv_seq = i_cache_slv_base_seq::type_id::create("slave_seq");
    en_seq  = i_cache_en_base_seq::type_id::create("en_seq");
    mas_seq = op_test_seq::type_id::create("master_seq");
    set_report_verbosity_level_hier(UVM_LOW);
  endfunction
endclass

//ahb-lite slave with 0 wait cycle
class i_cache_op_test_slv_0_wait extends i_cache_base_test;
  
  `uvm_component_utils(i_cache_op_test_slv_0_wait)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    slv_seq = i_cache_slv_0_wait_seq::type_id::create("slave_seq");
    en_seq  = i_cache_en_base_seq::type_id::create("en_seq");
    mas_seq = op_test_seq::type_id::create("master_seq");
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    set_report_verbosity_level_hier(UVM_LOW);
    //env.scb.set_report_verbosity_level(UVM_DEBUG);
  endfunction  
endclass




