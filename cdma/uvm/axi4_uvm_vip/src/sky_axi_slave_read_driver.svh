`ifndef SKY_AXI_SLAVE_READ_DRIVER_SVH
`define SKY_AXI_SLAVE_READ_DRIVER_SVH

class sky_axi_slave_read_driver extends tue_driver #(
  .CONFIGURATION (tvip_axi_configuration),
  .STATUS        (tvip_axi_status       ),
  .REQ           (tvip_axi_slave_item   ),
  .RSP           (tvip_axi_slave_item   )
);

  uvm_event_pool                  events            ;
  uvm_event                       rd_cmd_end_event  ;
  uvm_event                       rd_data_end_event ;
  sky_addr_maps                   maps              ;   //handle only, connect in salve agent

  protected tvip_axi_slv_vif      vif             ;
  protected tvip_axi_slave_item   cur_item        ; //item from sqr then fill addr info
  protected tvip_axi_slave_item   item_with_resp  ; //item filled with read data&resp

  //internal status variables
  protected int                   outstanding_num ; //outstanding cmd number
            mailbox_slv           drv2mem         ; //item send to axi_slave_mem model for rdata fill
            mailbox_slv           mem2drv         ; //item filled with rdata
  protected tvip_axi_slave_item   resp_queue[tvip_axi_id][$]; //queues of hash-array for out-of-order resp
  protected tvip_axi_slave_item   resp_item       ;
  protected int                   resp_channel    ; //in order: always 0; out-of-order: == bid

  `uvm_component_utils(sky_axi_slave_read_driver)
  `tue_component_default_constructor(sky_axi_slave_read_driver)


  //`protect128

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif = configuration.slv_vif;  //var configuration defined in class tue_component_base
    events  = configuration.events;
    if(events == null)
        `uvm_fatal(get_name(), "uvm event pool is null.")

    rd_cmd_end_event = events.get($sformatf("%s_%s", configuration.name, "rd_cmd_end_event"));
    rd_data_end_event= events.get($sformatf("%s_%s", configuration.name, "rd_data_end_event"));    
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      do_reset();
      fork
        main();
        @(negedge vif.areset_n);
      join_any
      disable fork;
    end
  endtask


  protected task do_reset();
    outstanding_num = 0;
    while(mem2drv.num() != 0) begin //clear item in mailbox
      mem2drv.get(item_with_resp);
    end

    resp_queue.delete();            //clear resp queue

    reset_if();
    @(posedge vif.areset_n);
  endtask

  protected virtual task reset_if();
    vif.slave_cb.arready  <= '0;
    vif.slave_cb.rvalid   <= '0;
    vif.slave_cb.rid      <= '0;
    vif.slave_cb.rresp    <= tvip_axi_response'(0);
    vif.slave_cb.rdata    <= '0;
    vif.slave_cb.rlast    <= '0;
  endtask

  protected task main();
    fork
      cmd_thread();
      read_data_recv_thread();
      response_thread();
    join
  endtask

  protected task consume_delay(int n);
    repeat(n) @(vif.slave_cb);
  endtask


  //func: get trans item from sequencer and fill axi read cmd info
  protected task cmd_thread();
    forever begin
      wait(outstanding_num < `TVIP_MAX_OUTSTANDING);
      seq_item_port.get_next_item(cur_item);
      cur_item.maps = maps;

      assert(cur_item.is_read());         //must be read item

      //arready=1 must wait until arvalid=1
      if(`TVIP_READY_WAIT_VALID == 1) begin
        do begin
            @(vif.slave_cb);
        end while(vif.slave_cb.arvalid == 0);
      end

      //read address channel handshake
      //`uvm_info(get_name(), $sformatf("read cmd delay of this item is: %0d", cur_item.start_delay), UVM_LOW)
      consume_delay(cur_item.start_delay);
      vif.slave_cb.arready <= 1'b1;
      cur_item.address_begin_cyc = vif.cyc_cnt;
      @(vif.slave_cb);
      while(vif.slave_cb.arvalid == 0) begin
        @(vif.slave_cb);
      end

      //arready && arvalid
      rd_cmd_end_event.trigger();
      cur_item.address_end_cyc = vif.cyc_cnt;
      cur_item.access_type= TVIP_AXI_READ_ACCESS;
      cur_item.address    = tvip_axi_address'(vif.slave_cb.araddr);
      cur_item.id         = tvip_axi_id'(vif.slave_cb.arid);
      cur_item.set_packed_burst_length(tvip_axi_burst_length'(vif.slave_cb.arlen));
      cur_item.set_packed_burst_size(tvip_axi_burst_size'(vif.slave_cb.arsize));
      cur_item.burst_type = tvip_axi_burst_type'(vif.slave_cb.arburst);
      cur_item.put_cache(tvip_axi_cache'(vif.slave_cb.arcache));
      cur_item.protection = tvip_axi_protection'(vif.slave_cb.arprot);
      cur_item.qos        = tvip_axi_qos'(vif.slave_cb.arqos);
      
      cur_item.addr_strobe_cal();       //cal addr/strobe of each burst beat

      //addr map check
      cur_item.addr_dec_err = new[cur_item.burst_length];
      for(int i=0; i<cur_item.burst_length; i++)
        cur_item.addr_dec_err[i] = ~maps.is_contain(cur_item.addr_beat[i]);

      drv2mem.put(cur_item);            //fill rdata by axi_slave_mem
      outstanding_num++;
      vif.slave_cb.arready <= 1'b0;
      seq_item_port.item_done();
    end
  endtask


  //func: get item with rdata from axi_slave_mem, and put in resp_queue based on arid
  protected task read_data_recv_thread();
    tvip_axi_id   put_id;
    forever begin
      mem2drv.get(item_with_resp);
      if(configuration.response_ordering == TVIP_AXI_IN_ORDER)  //always put in id=0
        put_id = 0;
      else
        put_id = item_with_resp.id;                             //based on arid

      resp_queue[put_id].push_back(item_with_resp);  
    end
  endtask : read_data_recv_thread


  //func: for out-of-order resp, random choose a begin id to search for valid resp item
  protected function tvip_axi_id resp_start_id();
    tvip_axi_id id;
    id = $urandom_range(0, ((1<<configuration.id_width) -1));
    return id;
  endfunction

  //func: start from a random search id, search for the first valid resp item
  protected task get_resp_item();
    if(configuration.response_ordering == TVIP_AXI_IN_ORDER) begin  //in-order response, all resp in id=0
      wait(resp_queue.exists(0));       //queue for id=0 is exists
      wait(resp_queue[0].size() != 0);  //queue for id=0 is not empty
      resp_item = resp_queue[0][0];     //choose first item
      resp_channel = 0;
    end else begin                                                  //out-of-order response
      bit   id_find;

      while(1) begin
        tvip_axi_id id = resp_start_id();
        id_find = 0;

        //$display("At time %0t, axi_slave_read try to find valid response item from id=%h.", $time, id);
        //$display("configuration.id_width=%0h.", configuration.id_width);

        //find a id in resp_queue
        for(int i=0; i<(1 << configuration.id_width); i++) begin
          //if(id == 'h35) begin
          //  $display("search for channel %h.", id);  
          //end

          if(resp_queue.exists(id) && (resp_queue[id].size() != 0)) begin
            id_find = 1;
            break;    //break for loop
          end

          //id for next loop
          if(id == '1)
            id = 0;
          else
            id++;
        end

        if(id_find) begin
            resp_item = resp_queue[id][0];    //first item of a queue of a id

            //$display("At time %0t, axi_slave_read will drive axi data channel of item: %0h.", $time, resp_item.get_inst_id());
            //resp_item.print();

            resp_channel = id;
            break;              //break while(1) loop
        end else begin
            consume_delay(1);   //delay 1T, while loop again
        end
      end //while(1)
    end
  endtask : get_resp_item


  //cal resp beat for this item, to support rdata interleave. 
  protected function int get_resp_beat();
    int   min_beat = configuration.min_interleave_size, max_beat = configuration.max_interleave_size;
    int   remain_beat;

    if(configuration.response_ordering == TVIP_AXI_IN_ORDER)
      return resp_item.burst_length;    //resp all data beat
    else if(configuration.max_interleave_size == 0) //disable read data interleave
      return resp_item.burst_length;    //resp all data beat
    else begin
      remain_beat = resp_item.burst_length - resp_item.beat_cnt;

      if(remain_beat < min_beat)
        min_beat = remain_beat;

      if(remain_beat < max_beat)
        max_beat = remain_beat;

      return $urandom_range(min_beat, max_beat);
    end
  endfunction : get_resp_beat


  //func: axi slave read data channel response
  protected task drv_resp_item();
    int   resp_beat = get_resp_beat();
    
    for(int i=0; i<resp_beat; i++) begin
      int   cur_beat  = resp_item.beat_cnt;
    
      if(`TVIP_DATA_DELAY_ONLY_FIRST_BEAT) begin
        //only first data beat has delay related to the acception of this read burst cmd
        if(cur_beat == 0) begin
            uint64  cur_delay = vif.cyc_cnt - resp_item.address_end_cyc;
            if(cur_delay < resp_item.response_delay[0])
                consume_delay(resp_item.response_delay[0] - cur_delay);
        end
      end else begin
        //every data beat has cycle delay before rvalid=1
        consume_delay(resp_item.response_delay[cur_beat]);
      end

      if(cur_beat == 0)
        resp_item.response_begin_cyc = vif.cyc_cnt;

      vif.slave_cb.rvalid <= 1'b1;
      vif.slave_cb.rid    <= resp_item.id;
      vif.slave_cb.rdata  <= resp_item.data[cur_beat];
      vif.slave_cb.rresp  <= resp_item.response[cur_beat];

      if((cur_beat+1) == resp_item.burst_length)
        vif.slave_cb.rlast <= 1'b1;
      else
        vif.slave_cb.rlast <= 1'b0;

      do begin
        consume_delay(1);
      end while(vif.slave_cb.rready == 1'b0);
      vif.slave_cb.rvalid <= 1'b0;

      if((cur_beat+1) == resp_item.burst_length) begin
        resp_item.response_end_cyc = vif.cyc_cnt;
        rd_data_end_event.trigger();
      end

      resp_item.beat_cnt++;
    end
  endtask : drv_resp_item


  //func: if needed, send resp to sequencer; delete the resp_item from queue
  protected task post_resp_item();
    if(resp_item.beat_cnt == resp_item.burst_length) begin  //read response beats of this burst are done
      if(resp_item.need_response)
        seq_item_port.put_response(resp_item);      //send back response

      void'(resp_queue[resp_channel].pop_front());  //delete this item in resp_queue
      outstanding_num--;
    end
  endtask : post_resp_item

  protected task response_thread();
    forever begin
      get_resp_item();
      drv_resp_item();
      post_resp_item();
    end
  endtask : response_thread


  //`endprotect128
endclass : sky_axi_slave_read_driver

`endif
