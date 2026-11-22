`ifndef SKY_AXI_SLAVE_WRITE_DRIVER_SVH
`define SKY_AXI_SLAVE_WRITE_DRIVER_SVH

class sky_axi_slave_write_driver extends tue_driver #(
  .CONFIGURATION (tvip_axi_configuration),
  .STATUS        (tvip_axi_status       ),
  .REQ           (tvip_axi_slave_item   ),
  .RSP           (tvip_axi_slave_item   )
);

  uvm_event_pool                  events            ;
  uvm_event                       wr_cmd_end_event  ;
  uvm_event                       wr_data_end_event ;
  uvm_event                       wr_resp_end_event ;
  sky_addr_maps                   maps              ;   //handle only, connect in salve agent

  protected tvip_axi_slv_vif      vif             ;
  protected tvip_axi_slave_item   cmd_queue[$]    ; //store addr/wdata info
  protected tvip_axi_slave_item   item_with_resp  ;
  protected int                   outstanding_num ; //outstanding cmd number
            mailbox_slv           drv2mem         ;
            mailbox_slv           mem2drv         ;
  protected tvip_axi_slave_item   resp_queue[tvip_axi_id][$];
  protected tvip_axi_slave_item   resp_item       ;
  protected int                   resp_channel    ;

  `uvm_component_utils(sky_axi_slave_write_driver)
  `tue_component_default_constructor(sky_axi_slave_write_driver)


  //`protect128

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif = configuration.slv_vif;
    events  = configuration.events;
    if(events == null)
        `uvm_fatal(get_name(), "uvm event pool is null.")

    wr_cmd_end_event = events.get($sformatf("%s_%s", configuration.name, "wr_cmd_end_event"));
    wr_data_end_event= events.get($sformatf("%s_%s", configuration.name, "wr_data_end_event"));
    wr_resp_end_event= events.get($sformatf("%s_%s", configuration.name, "wr_resp_end_event"));    
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
    while(mem2drv.num() != 0) begin
      mem2drv.get(item_with_resp);
    end

    cmd_queue.delete();
    resp_queue.delete();

    reset_if();
    @(posedge vif.areset_n);
  endtask

  protected virtual task reset_if();
    vif.slave_cb.awready  <= '0;
    vif.slave_cb.wready   <= '0;
    vif.slave_cb.bid      <= '0;
    vif.slave_cb.bresp    <= tvip_axi_response'(0);
    vif.slave_cb.bvalid   <= '0;
  endtask

  protected task main();
    fork
      get_item_thread();
      cmd_thread();
      wdata_thread();
      merge_thread();
      fill_resp_thread();
      resp_thread();
    join
  endtask

  protected task consume_delay(int n);
    repeat(n) @(vif.slave_cb);
  endtask


  //func: get cmd item from sequencer
  protected task get_item_thread();
    tvip_axi_slave_item   item;
    forever begin
      wait(outstanding_num < `TVIP_MAX_OUTSTANDING);
      seq_item_port.get_next_item(item);
      item.maps = maps;
      assert(item.is_write());

      cmd_queue.push_back(item);
      outstanding_num++;
      seq_item_port.item_done();
    end
  endtask


  //func: axi cmd channel handshake
  protected task cmd_thread();
    tvip_axi_slave_item item;
    bit                 find;

    forever begin
      find = 0;

      //find first item with addr channel info not filled
      for(int i=0; i<cmd_queue.size(); i++) begin
        item = cmd_queue[i];
        if(item.address_begin_event.is_off()) begin
          find = 1;
          break;      //break for loop
        end
      end

      if(find) begin
        //$display("At time %0t, axi_slave_write's cmd_thread will work on item: %h.", $time, item.get_inst_id());

        //axi addr channel handshake and fill addr info
        item.address_begin_event.trigger();   //mark event
      
        //awready=1 must wait until awvalid=1
        if(`TVIP_READY_WAIT_VALID == 1) begin
            do begin
                @(vif.slave_cb);
            end while(vif.slave_cb.awvalid == 0);
        end

        consume_delay(item.start_delay);
        vif.slave_cb.awready  <= 1'b1;
        item.address_begin_cyc = vif.cyc_cnt;

        do begin
          consume_delay(1);  //delay 1T
        end while(vif.slave_cb.awvalid == 0);

        item.address_end_cyc = vif.cyc_cnt;
        wr_cmd_end_event.trigger();
        item.access_type= TVIP_AXI_WRITE_ACCESS;
        item.address    = tvip_axi_address'(vif.slave_cb.awaddr);
        item.id         = tvip_axi_id'(vif.slave_cb.awid);
        item.set_packed_burst_length(tvip_axi_burst_length'(vif.slave_cb.awlen));
        item.set_packed_burst_size(tvip_axi_burst_size'(vif.slave_cb.awsize));
        item.burst_type = tvip_axi_burst_type'(vif.slave_cb.awburst);
        item.put_cache(tvip_axi_cache'(vif.slave_cb.awcache));
        item.protection = tvip_axi_protection'(vif.slave_cb.awprot);
        item.qos        = tvip_axi_qos'(vif.slave_cb.awqos);

        item.addr_strobe_cal();             //cal addr/strobe(may valid data bytes) of each burst beat

        //addr map check
        item.addr_dec_err = new[item.burst_length];
        for(int i=0; i<item.burst_length; i++)
            item.addr_dec_err[i] = ~maps.is_contain(item.addr_beat[i]);
        
        item.address_end_event.trigger();
        vif.slave_cb.awready  <= 1'b0;
      end else begin
        consume_delay(1);  //delay 1T and forver loop again
      end
    end
  endtask : cmd_thread


  //func: axi write data channel handshake
  protected task  wdata_thread();
    tvip_axi_slave_item item;
    bit                 find;

    forever begin
      find = 0;

      //find first item with wdata channel not fill
      for(int i=0; i<cmd_queue.size(); i++) begin
        item = cmd_queue[i];
        if(`TVIP_WDATA_WAIT_CMD) begin
            if(item.write_data_begin_event.is_off() && item.address_end_event.is_on()) begin
              find = 1;
              break;
            end            
        end else begin
            if(item.write_data_begin_event.is_off()) begin
              find = 1;
              break;
            end
        end
      end    

      if(find) begin
        bit     wdata_end = 0 ;
        int     beat = 0      ;

        //$display("At time %0t, axi_slave_write's wdata_thread will work on item: %h.", $time, item.get_inst_id());
        item.write_data_begin_event.trigger();

        //all write data beats handshake for this burst
        do begin
          if(`TVIP_DATA_DELAY_ONLY_FIRST_BEAT) begin
            //only first data beat has cycle delay
            if(beat == 0)
                consume_delay(item.write_data_delay[beat]);
          end else begin
            //all data beat has cycle delay
            consume_delay(item.write_data_delay[beat]);
          end

          vif.slave_cb.wready <= 1'b1;
          if(beat == 0)
            item.write_data_begin_cyc = vif.cyc_cnt;

          do begin
            consume_delay(1);
          end while(vif.slave_cb.wvalid == 1'b0);

          //capture a wdata beat
          item.data[beat]   = tvip_axi_data'(vif.slave_cb.wdata);
          item.strobe[beat] = tvip_axi_strobe'(vif.slave_cb.wstrb);
          if(vif.slave_cb.wlast == 1) begin
            //$display("Write data ended at %0t, beat=%0h, wdata=%h.", $time, beat, vif.slave_cb.wdata);
            wdata_end = 1;
            item.write_data_end_event.trigger();
          end
          vif.slave_cb.wready <= 1'b0;
          
          beat++;
        end while(wdata_end == 0);
        item.write_data_end_cyc = vif.cyc_cnt;
        wr_data_end_event.trigger();
      end else begin
        consume_delay(1);
      end

    end //forever
  endtask : wdata_thread


  //func: wait both address_end_event and write_data_end_event has been triggered
  protected task  merge_thread();
    tvip_axi_slave_item item;
    
    forever begin
      wait(cmd_queue.size() != 0);
      item = cmd_queue[0];      //cmd/wdata handshke end must be the same order
      //$display("At time %0t, axi_slave_write's merge_thread will work on item: %h.", $time, item.get_inst_id());

      //wait(item.address_end_event.is_on());
      while(!item.address_end_event.is_on()) begin
        consume_delay(1);
      end

      //wait(item.write_data_end_event.is_on());
      while(!item.write_data_end_event.is_on()) begin
        consume_delay(1);
      end

      //item.print();
      drv2mem.put(item);        //send item to axi_slave_mem for wdata fill to sys_mem
      void'(cmd_queue.pop_front()); //delete this item
    end
  endtask : merge_thread

  //func: store resp item to resp_queue: in order(id==0) or out-of-order(awid based)
  protected task  fill_resp_thread();
    tvip_axi_slave_item item;
    tvip_axi_id         put_id;
    
    forever begin
      mem2drv.get(item);

      if(configuration.response_ordering == TVIP_AXI_IN_ORDER)
        put_id = 0;
      else
        put_id = item.id;

      resp_queue[put_id].push_back(item);
    end
  endtask : fill_resp_thread

  //func: random choose a id to start the search of valid resp item 
  protected function tvip_axi_id resp_start_id();
    tvip_axi_id id;
    id = $urandom_range(0, ((1<<configuration.id_width) -1));
    return id;
  endfunction


  //func: find the first valid resp item from a rand start id
  protected task get_resp_item();
    if(configuration.response_ordering == TVIP_AXI_IN_ORDER) begin  //in-order response
      wait(resp_queue.exists(0));       //queue for id=0 is exists
      wait(resp_queue[0].size() != 0);  //queue for id=0 is not empty
      resp_item = resp_queue[0][0];
      resp_channel = 0;
    end else begin                                                  //out-of-order response
      bit   id_find;

      while(1) begin
        tvip_axi_id id = resp_start_id();
        id_find = 0;

        //find a id in resp_queue
        for(int i=0; i<(1 << configuration.id_width); i++) begin
          if(resp_queue.exists(id) && (resp_queue[id].size() != 0)) begin
            id_find = 1;
            break;    //break for loop
          end

          //id for next loop
          if(id == '1)
            id = 0;
          else
            id++;
        end //for(int i=0; i<(1 << configuration.id_width); i++)

        if(id_find) begin
            resp_item = resp_queue[id][0];
            resp_channel = id;
            break;              //break while(1) loop
        end else begin
            consume_delay(1);   //delay 1T, while loop again
        end
      end //while(1)
    end
  endtask : get_resp_item


  //func: axi bresp channel handshake
  protected task  resp_thread();
    forever begin
      get_resp_item();

      //write response channel handshake
      //`uvm_info(get_name(), $sformatf("write resp delay of this item is: %0d", resp_item.response_delay[0]), UVM_LOW)
      consume_delay(resp_item.response_delay[0]);

      resp_item.response_begin_cyc = vif.cyc_cnt;
      vif.slave_cb.bvalid <= 1'b1;
      vif.slave_cb.bid    <= resp_item.id;
      vif.slave_cb.bresp  <= resp_item.response[0];

      do begin
        consume_delay(1);
      end while(vif.slave_cb.bready == 1'b0);

      vif.slave_cb.bvalid <= 1'b0;
      resp_item.response_end_cyc = vif.cyc_cnt;
      wr_resp_end_event.trigger();
      if(resp_item.need_response)
        seq_item_port.put_response(resp_item);      //send back response

      void'(resp_queue[resp_channel].pop_front());  //delete this item in resp_queue
      outstanding_num--;
    end
  endtask : resp_thread

  //`endprotect128

endclass : sky_axi_slave_write_driver

`endif
