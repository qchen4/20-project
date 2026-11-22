`ifndef SKY_AXI_MASTER_WR_SEQUENCE_SVH
`define SKY_AXI_MASTER_WR_SEQUENCE_SVH

class sky_axi_master_wr_sequence extends uvm_sequence #(
  .REQ    (tvip_axi_master_item  ), 
  .RSP    (tvip_axi_master_item  )
);

  `uvm_object_utils(sky_axi_master_wr_sequence)
  `uvm_declare_p_sequencer(sky_axi_master_sequencer)

  tvip_axi_configuration    cfg ;

  // Function: new
  // Constructor of object.
  function new(string name="sky_axi_master_wr_sequence");
    super.new(name);
  endfunction

  // Task: pre_start
  // UVM built-in method.
  virtual task pre_start();
    void'($cast(cfg, p_sequencer.get_configuration()));
  endtask  

  //func: check the read resp rdata match a write trans wdata or not
  extern function bit rd_resp_check(tvip_axi_master_item resp, ref tvip_axi_master_item cmd_queue[$]);

  virtual task body();
    int   test_loop = 10;   //test loop number
    int   pack_len  = 16;   //trans item number of a test loop

    tvip_axi_master_item  w_req, r_req;
    tvip_axi_master_item  cmd_queue[$];   //buffer all the write item of a test loop

    tvip_axi_master_item  resp;

    this.set_response_queue_depth(pack_len);  //set the response_queue size in uvm_sequence_base

    for(int j=0; j<test_loop; j++) begin
      $display("At time %0t, sky_axi_master_wr_sequence begin test loop=%0h.", $time, j);
      cmd_queue.delete();

      for(int i=0; i<pack_len; i++) begin
        $display("At time %0t, sky_axi_master_wr_sequence begin write trans item: %0h.", $time, i);

        //send out write burst
        `uvm_create(w_req);
        w_req.set_configuration(cfg);

        if(!w_req.randomize() with {
                access_type == TVIP_AXI_WRITE_ACCESS;
                need_response == 1;
                id inside {[0:3]};
                address >= 0;
                address <  1*1024*1024;
              }
          ) begin
          `uvm_fatal("body", "axi master item randomize error.")
        end else begin
          w_req.set_transaction_id(i);    //set trans_id for this trans, easy the search process to find the read resp item related to this write item
          `uvm_send(w_req);
          cmd_queue.push_back(w_req);
        end
      end //for(int i=0; i<pack_len; i++)


      //recieve all response of write burst
      foreach(cmd_queue[i]) begin
        if(cmd_queue[i].need_response) begin
          get_response(resp);
          $display("At time %0t, sky_axi_master_wr_sequence get write response for iterm: %0h.", $time, i);
        end
      end


      //read burst with same cmd info and trans_id
      foreach(cmd_queue[i]) begin
        $display("At time %0t, sky_axi_master_wr_sequence begin read trans item: %0h.", $time, i);
        `uvm_create(r_req);
        r_req.copy(cmd_queue[i]);
        r_req.access_type = TVIP_AXI_READ_ACCESS;
        r_req.set_transaction_id(cmd_queue[i].get_transaction_id());
        `uvm_send(r_req);
      end

      //recieve all response of read burst
      foreach(cmd_queue[i]) begin
        if(cmd_queue[i].need_response) begin
          get_response(resp);
          $display("At time %0t, sky_axi_master_wr_sequence get read response for iterm: %0h.", $time, i);

          if(!rd_resp_check(resp, cmd_queue)) begin
            `uvm_error("sky_axi_master_wr_sequence", "axi read back data check fail.")
          end
        end
      end //foreach(cmd_queue[i])
    end //for(int j=0; j<test_loop; j++)
  endtask : body

endclass : sky_axi_master_wr_sequence

function bit sky_axi_master_wr_sequence::rd_resp_check(tvip_axi_master_item resp, ref tvip_axi_master_item cmd_queue[$]);
  tvip_axi_master_item  w_req ;
  bit                   find  ;

  int   id = resp.get_transaction_id();

  //find the write trans in cmd_queue with the same trans_id
  foreach(cmd_queue[i]) begin
    if(id == cmd_queue[i].get_transaction_id()) begin
      w_req = cmd_queue[i];
      w_req.set_transaction_id(-1);   //mark the matched item to used status
      find = 1;
      break;
    end
  end

  if(find) begin
    //compare data, just compare data byte with wstrb == 1'b1
    for(int i=0; i<w_req.burst_length; i++) begin
      if(w_req.burst_type == TVIP_AXI_FIXED_BURST)  //just check last beat for fixed addr burst
        i = w_req.burst_length - 1;

      for(int j=0; j<cfg.strobe_width; j++) begin
        if(w_req.strobe[i][j]) begin
          if(w_req.data[i][j*8 +: 8] !== resp.data[i][j*8 +: 8]) begin
            `uvm_fatal("rd_resp_check", $sformatf("Data mismatch for transaction_id=%0h, data_beat=%0h, byte %0d; write data is %h, read data is %h.", 
                                                                                    id,          i,        j,       w_req.data[i], resp.data[i]))
            return 0;
          end
        end
      end
    end

    return 1;
  end else begin
    `uvm_fatal("rd_resp_check", $sformatf("read response transaction_id=%h doesn't find in write cmd_queue.", id))
    return 0;     //check fail
  end

endfunction

`endif
