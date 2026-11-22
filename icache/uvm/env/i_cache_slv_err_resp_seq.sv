// 文件说明 i_cache_slv_err_resp_seq.sv
// 下游错误注入序列，对响应随机选择 ERROR 或 OKAY，权重为 1 比 3。
// 当前 wait_delay 固定为 0；虽创建并随机化 ctl，但未把其 delay 用于响应。
// 用于检查旁路错误传播及填充阶段既定响应行为，不代表覆盖错误加随机等待组合。


class i_cache_slv_err_resp_seq extends i_cache_slv_base_seq;

  `uvm_object_utils(i_cache_slv_err_resp_seq)

  // Function: new
  // Constructor of object.
  function new(string name="i_cache_slv_err_resp_seq");
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
            //response[0] == OKAY;
            foreach(response[i]) {
                response[i] dist {ERROR:=1, OKAY:=3};
            }

            wait_delay == 0;
            }
        ) begin
            `uvm_fatal("i_cache_slv_err_resp_seq", "Transaction randomize error.")
        end else begin
            start_item(req);
            finish_item(req);
        end
      end //if(!ctl.randomize())
    end //forever
  endtask
endclass

