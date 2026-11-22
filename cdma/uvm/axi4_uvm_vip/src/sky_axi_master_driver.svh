`ifndef SKY_AXI_MASTER_DRIVER_SVH
`define SKY_AXI_MASTER_DRIVER_SVH

class sky_axi_master_driver extends tue_driver #(
  .CONFIGURATION (tvip_axi_configuration),
  .STATUS        (tvip_axi_status       ),
  .REQ           (tvip_axi_master_item  ),
  .RSP           (tvip_axi_master_item  )
);

  uvm_event_pool                  events            ;
  uvm_event                       rd_cmd_end_event  ;
  uvm_event                       rd_data_end_event ;
  uvm_event                       wr_cmd_end_event  ;
  uvm_event                       wr_data_end_event ;
  uvm_event                       wr_resp_end_event ;

  protected tvip_axi_mas_vif      vif             ;
  protected tvip_axi_master_item  rd_cmd_queue[$] ;               //queue
  protected tvip_axi_master_item  rd_resp_queue[tvip_axi_id][$];  //hash-array, each element is a queue
  protected tvip_axi_master_item  wr_cmd_queue[$] ;
  protected tvip_axi_master_item  wr_data_queue[$];
  protected tvip_axi_master_item  wr_resp_queue[tvip_axi_id][$];

  protected sky_rand_ctrl         rd_resp_delay ;
  protected sky_rand_ctrl         wr_resp_delay ;

  protected int     outstanding   ;
  protected int     rd_outstanding;
  protected int     wr_outstanding;

  `uvm_component_utils(sky_axi_master_driver)
  `tue_component_default_constructor(sky_axi_master_driver)


  //`protect128

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rd_resp_delay = new();
    rd_resp_delay.delay_cfg = this.configuration.read_data_delay;  //pass in rand contrl info

    wr_resp_delay = new();
    wr_resp_delay.delay_cfg = this.configuration.response_delay;
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif     = configuration.mas_vif;
    events  = configuration.events;
    if(events == null)
        `uvm_fatal(get_name(), "uvm event pool is null.")

    rd_cmd_end_event = events.get($sformatf("%s_%s", configuration.name, "rd_cmd_end_event"));
    rd_data_end_event= events.get($sformatf("%s_%s", configuration.name, "rd_data_end_event"));
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
    rd_cmd_queue.delete();      //clear all the queue(buffered item)
    rd_resp_queue.delete();
    wr_cmd_queue.delete();
    wr_data_queue.delete();
    wr_resp_queue.delete();

    rd_cmd_end_event.reset(); 
    rd_data_end_event.reset();
    wr_cmd_end_event.reset(); 
    wr_data_end_event.reset();
    wr_resp_end_event.reset();

    reset_if();
    outstanding = 0;
    rd_outstanding = 0;
    wr_outstanding = 0;
    @(posedge vif.areset_n);
  endtask

  protected virtual task reset_if();
    vif.master_cb.awvalid <= '0;
    vif.master_cb.awid    <= '0;
    vif.master_cb.awaddr  <= '0;
    vif.master_cb.awlen   <= '0;
    vif.master_cb.awsize  <= tvip_axi_burst_size'(0);
    vif.master_cb.awburst <= tvip_axi_burst_type'(0);
    vif.master_cb.awcache <= tvip_axi_write_cache'(0);
    vif.master_cb.awprot  <= '0;
    vif.master_cb.awqos   <= '0;
    vif.master_cb.wvalid  <= '0;
    vif.master_cb.wdata   <= '0;
    vif.master_cb.wstrb   <= '0;
    vif.master_cb.wlast   <= '0;
    vif.master_cb.bready  <= '0;

    vif.master_cb.arvalid <= '0;
    vif.master_cb.arid    <= '0;
    vif.master_cb.araddr  <= '0;
    vif.master_cb.arlen   <= '0;
    vif.master_cb.arsize  <= tvip_axi_burst_size'(0);
    vif.master_cb.arburst <= tvip_axi_burst_type'(0);
    vif.master_cb.arcache <= tvip_axi_read_cache'(0);
    vif.master_cb.arprot  <= '0;
    vif.master_cb.arqos   <= '0;
    vif.master_cb.rready  <= '0;
  endtask

  protected task main();
    fork
      item_thread();
      read_cmd_thread();
      read_resp_thread();
      write_cmd_thread();
      write_data_thread();
      write_resp_thread();
    join
  endtask

  protected task consume_delay(int n);
    repeat(n) @(vif.master_cb);
  endtask


  //func: get item from sequencer and store to read/write queue
  protected task item_thread();
    tvip_axi_master_item  item;

    forever begin
      wait(outstanding <= 99);        //can maximal outstanding 99 r/w cmds
      seq_item_port.get_next_item(item);
      
      if(item.access_type == TVIP_AXI_READ_ACCESS) begin
        //`uvm_info(get_name(), $sformatf("AXI master get a read item with cmd delay %0d.", item.start_delay), UVM_LOW)
        rd_cmd_queue.push_back(item);
      end else begin
        //`uvm_info(get_name(), $sformatf("AXI master get a write item with cmd delay %0d.", item.start_delay), UVM_LOW)
        wr_cmd_queue.push_back(item); //same item pointer send to both queue
        wr_data_queue.push_back(item);
      end

      outstanding++;
      seq_item_port.item_done();
    end
  endtask


  //func: axi read cmd channel handshake
  protected task read_cmd_thread();
    tvip_axi_master_item  item;
    tvip_axi_id           id  ;
    forever begin
      wait(rd_outstanding < configuration.max_outstanding_num);

      wait(rd_cmd_queue.size() != 0);
      item  = rd_cmd_queue.pop_front();
      id    = item.id;
      //`uvm_info(get_name(), $sformatf("read cmd delay of this item is: %0d", item.start_delay), UVM_LOW)
      consume_delay(item.start_delay);

      //axi master read cmd channel handshake
      item.address_begin_cyc = vif.cyc_cnt;
      vif.master_cb.arvalid <= 1'b1;
      vif.master_cb.araddr  <= item.address;
      vif.master_cb.arid    <= item.id;
      vif.master_cb.arlen   <= item.get_packed_burst_length();
      vif.master_cb.arsize  <= item.get_packed_burst_size();
      vif.master_cb.arburst <= item.burst_type;
      vif.master_cb.arcache <= item.get_cache();
      vif.master_cb.arprot  <= item.protection;
      vif.master_cb.arqos   <= item.qos;

      do begin
        consume_delay(1);
      end while(vif.master_cb.arready == 1'b0);
      item.address_end_cyc = vif.cyc_cnt;
      rd_cmd_end_event.trigger();

      rd_outstanding++;

      vif.master_cb.arvalid <= 1'b0;

      rd_resp_queue[id].push_back(item);
    end
  endtask

  
  //func: axi read data channel handshake
  protected task read_resp_thread();
      int       delay ;

      tvip_axi_id           id    ;
      tvip_axi_master_item  item  ;

    forever begin
      //each loop receive a data beat
      //as we don't know the value of vif.master_cb.rid, then don't know use the 
      //delay info of which item. So, just random a delay here.
      if(`TVIP_EN_RDATA_DELAY) begin
        void'(rd_resp_delay.randomize());
        delay = rd_resp_delay.num;
      end else begin
        delay = 0;
      end

      consume_delay(delay);

      //axi read data channel handshake of a data beat
      vif.master_cb.rready <= 1'b1;

      do begin
        consume_delay(1);
      end while(vif.master_cb.rvalid == 1'b0);
    
      id  = vif.master_cb.rid;

      if(rd_resp_queue.exists(id) == 0) begin
        `uvm_fatal("axi master driver", "read response queue is empty.")
      end

      if(rd_resp_queue[id].size() == 0) begin
        `uvm_fatal("axi master driver", "read response queue is empty.")
      end

      item = rd_resp_queue[id][0];    //for the same id, rdata must be send back in order
      item.data[item.beat_cnt]      = vif.master_cb.rdata;
      item.response[item.beat_cnt]  = vif.master_cb.rresp;

      //response_begin_cyc for read isn't accurate(not from first cycle of rready=1), as master
      //doesn't know value of rid before the handshake of this data beat.
      if(item.beat_cnt == 0)
        item.response_begin_cyc = vif.cyc_cnt;

      item.beat_cnt++;

      if(vif.master_cb.rlast) begin
        item.response_end_cyc = vif.cyc_cnt;
        rd_data_end_event.trigger();
        if(item.burst_length != item.beat_cnt) begin
          `uvm_fatal("axi master driver", "read response length error.")
        end

        if(item.need_response)
          seq_item_port.put_response(item);

        void'(rd_resp_queue[id].pop_front());
        outstanding--;
        rd_outstanding--;
      end

      vif.master_cb.rready <= 1'b0;
    end
  endtask


  //func: axi write cmd channel handshake
  protected task write_cmd_thread();
    tvip_axi_id           id    ;
    tvip_axi_master_item  item  ;

    forever begin
      wait(wr_outstanding < configuration.max_outstanding_num);

      wait(wr_cmd_queue.size() != 0);
      item  = wr_cmd_queue.pop_front();
      id    = item.id;
      //`uvm_info(get_name(), $sformatf("write cmd delay of this item is: %0d", item.start_delay), UVM_LOW)
      consume_delay(item.start_delay);

      //axi write cmd channel handshake
      item.address_begin_cyc = vif.cyc_cnt;
      vif.master_cb.awvalid <= 1'b1;
      vif.master_cb.awaddr  <= item.address;
      vif.master_cb.awid    <= item.id;
      vif.master_cb.awlen   <= item.get_packed_burst_length();
      vif.master_cb.awsize  <= item.get_packed_burst_size();
      vif.master_cb.awburst <= item.burst_type;
      vif.master_cb.awcache <= item.get_cache();
      vif.master_cb.awprot  <= item.protection;
      vif.master_cb.awqos   <= item.qos;

      do begin
        consume_delay(1);
      end while(vif.master_cb.awready == 1'b0);

      item.address_end_cyc = vif.cyc_cnt;
      wr_cmd_end_event.trigger();
      wr_outstanding++;
      vif.master_cb.awvalid <= 1'b0;

      wr_resp_queue[id].push_back(item);
    end
  endtask


  //func: axi write data channel handshake
  protected task write_data_thread();
    tvip_axi_id           id    ;
    tvip_axi_master_item  item  ;
    
    forever begin
      wait(wr_data_queue.size() != 0);
      item  = wr_data_queue.pop_front();
      id    = item.id;

      //all data beat handshake of this item(no wdata interleave in AXI4)
      for(int i=0; i<item.burst_length; i++) begin
        if(`TVIP_DATA_DELAY_ONLY_FIRST_BEAT) begin
            //only first data beat has delay
            if(i==0)
                consume_delay(item.write_data_delay[i]);
        end else begin
            //all data beat has delay
            consume_delay(item.write_data_delay[i]);
        end

        if(i == 0)
            item.write_data_begin_cyc = vif.cyc_cnt;

        vif.master_cb.wvalid  <= 1'b1;
        vif.master_cb.wdata   <= item.data[i];
        vif.master_cb.wstrb   <= item.strobe[i];

        if((i+1) == item.burst_length)
          vif.master_cb.wlast <= 1'b1;
        else
          vif.master_cb.wlast <= 1'b0;

        do begin
          consume_delay(1);
        end while(vif.master_cb.wready == 1'b0);

        
        if((i+1) == item.burst_length) begin
            item.write_data_end_cyc = vif.cyc_cnt;
            wr_data_end_event.trigger();
        end

        vif.master_cb.wvalid  <= 1'b0;
      end
    end
  endtask


  //func: axi bresp channel handshake
  protected task write_resp_thread();
    tvip_axi_id           id    ;
    tvip_axi_master_item  item  ;

    int     delay   ;


    forever begin
      //as we don't know the value of vif.master_cb.bid, then don't know use the 
      //delay info of which item. So, just random a delay here.
      if(`TVIP_EN_RESP_DELAY) begin
        void'(wr_resp_delay.randomize());
        delay = wr_resp_delay.num;
      end else begin
        delay = 0;
      end

      consume_delay(delay);

      //axi write response channel handshake
      vif.master_cb.bready <= 1'b1;
      
      do begin
        consume_delay(1);
      end while(vif.master_cb.bvalid == 1'b0);

      id  = vif.master_cb.bid;

      if(wr_resp_queue.exists(id) == 0) begin
        `uvm_fatal("axi master driver", "write response channel is empty.")
      end

      if(wr_resp_queue[id].size() == 0) begin
        `uvm_fatal("axi master driver", "write response channel is empty.")
      end

      item = wr_resp_queue[id].pop_front();   //for a id, bresp must be in order
      item.response[0] = vif.master_cb.bresp;

      //response_begin_cyc is not accurate(not the first cycle of bready=1), as amster doesn't 
      //know the bid before the end of write response channel handshake
      item.response_begin_cyc = vif.cyc_cnt;    
      item.response_end_cyc   = vif.cyc_cnt;
      wr_resp_end_event.trigger();

      if(item.need_response)
        seq_item_port.put_response(item);

      vif.master_cb.bready <= 1'b0;
      outstanding--;
      wr_outstanding--;
    end
  endtask

  //`endprotect128

endclass : sky_axi_master_driver


`endif
