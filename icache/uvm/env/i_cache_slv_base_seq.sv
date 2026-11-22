// 文件说明 i_cache_slv_base_seq.sv
// 下游存储器响应基础序列，持续产生 OKAY 与随机等待配置。
// 等待分布来自 s_ahb_ctl；实际总线响应及内存数据由 Slave Driver 处理。


class i_cache_slv_base_seq extends yuu_ahb_slave_sequence_base;

  `uvm_object_utils(i_cache_slv_base_seq)

  // Function: new
  // Constructor of object.
  function new(string name="i_cache_slv_base_seq");
    super.new(name);
  endfunction

  // Task: body
  // UVM built-in method.
  virtual task body();
    s_ahb_ctl  ctl;
    ctl = s_ahb_ctl::type_id::create("ctl");

    forever begin
      if(!ctl.randomize()) begin
        `uvm_fatal("i_cache_slv_base_seq", "s_ahb_ctl randomize error.")
      end else begin
        `uvm_create(req)
        req.cfg = cfg;
        if(!req.randomize() with {
            len == 0;
            //response[0] dist {ERROR:=1, OKAY:=1};
            response[0] == OKAY;
            wait_delay == ctl.delay;
            }
        ) begin
            `uvm_fatal("i_cache_slv_base_seq", "Transaction randomize error.")
        end else begin
            start_item(req);
            finish_item(req);
        end
      end //if(!ctl.randomize())
    end //forever
  endtask
endclass

