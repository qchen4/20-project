// 文件说明 i_cache_mas_base_seq.sv
// CPU 侧请求序列抽象基类，提供统一的 send_fixed_item 发送任务。
// 将地址、数据、大小、保护属性、空闲间隔和锁定转换为 VIP SINGLE 事务。
// pre_body 获取 misc_vif；派生序列必须重写 body 来定义访问顺序。


virtual class i_cache_mas_base_seq extends yuu_ahb_master_sequence_base;

  //`uvm_object_utils(i_cache_mas_base_seq)

  //DUT internal and IO signals
  i_cache_misc_vif    misc_vif;

  // Function: new
  // Constructor of object.
  function new(string name="i_cache_mas_base_seq");
    super.new(name);
  endfunction

  //addr:   byte addr, must align with hsize;
  //rw:     0: read, 1: write;
  //hsize:  same as ahb-lite define
  //hprot:  [0]: op/data, [1]: user/privileged, [2]: non-bufferable/bufferable [3]: non-cacheable/cacheable
  //delay_burst: idle cycle before this burst;
  //lock    :hmastlock
  virtual task send_fixed_item(input int addr, int wdata, byte rw, byte hsize, byte hprot, int delay_burst,
                                     bit lock=0);
    yuu_ahb_master_item     req;
    `uvm_create(req);
    req.cfg = this.cfg;
    if(!req.randomize() with {
        len         == 0;       //only single burst
        burst       == SINGLE;
        direction   == yuu_ahb_direction_e'(rw);
        start_address== yuu_ahb_addr_t'(addr);
        burst_size  == yuu_ahb_burst_size_e'(hsize);
        idle_delay  == delay_burst;
        prot0       == yuu_ahb_prot0_e'(hprot[0]);
        prot1       == yuu_ahb_prot1_e'(hprot[1]);
        prot2       == yuu_ahb_prot2_e'(hprot[2]);
        prot3       == yuu_ahb_prot3_e'(hprot[3]);
        lock        == local::lock;
    }) begin
        `uvm_fatal("i_cache_mas_base_seq", "Transaction randomize error.")
    end

    if(req.direction == WRITE)
        req.data[0] = yuu_ahb_data_t'(wdata);

    //req.print();
    `uvm_send(req);
  endtask

  virtual task pre_body();
    if(!uvm_config_db#(i_cache_misc_vif)::get(null, get_full_name(), "misc_vif", misc_vif)) begin
        `uvm_error(get_name(), "uvm_config_db::get DUT monitor virtual interface fail.")
    end    
  endtask : pre_body

  // Task: body
  // UVM built-in method.
  virtual task body();
    `uvm_fatal("i_cache_mas_base_seq", "The body task should be OVERRIDED by derived class.")
  endtask
endclass

