// 文件说明 i_cache_slv_0_wait_seq.sv
// 下游零等待 OKAY 响应序列，用于压缩相邻事务之间的时序间隔。
// 重点激励当前拍转发、连续命中和末拍写入附近的紧邻事件。


class i_cache_slv_0_wait_seq extends i_cache_slv_base_seq;

  `uvm_object_utils(i_cache_slv_0_wait_seq)

  // Function: new
  // Constructor of object.
  function new(string name="i_cache_slv_0_wait_seq");
    super.new(name);
  endfunction

  // Task: body
  // UVM built-in method.
  virtual task body();

    forever begin
        `uvm_create(req)
        req.cfg = cfg;
        if(!req.randomize() with {
            len == 0;
            //response[0] dist {ERROR:=1, OKAY:=1};
            response[0] == OKAY;
            wait_delay == 0;
            }
        ) begin
            `uvm_fatal("i_cache_slv_0_wait_seq", "Transaction randomize error.")
        end else begin
            start_item(req);
            finish_item(req);
        end
    end    
  endtask
endclass

