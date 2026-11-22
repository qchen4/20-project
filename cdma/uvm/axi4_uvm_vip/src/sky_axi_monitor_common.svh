
  virtual task run_phase(uvm_phase phase);
    if(vif == null)
        `uvm_fatal(get_name(), "vif is null")
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
    axi_read.delete();
    axi_waddr.delete();
    axi_wdata.delete();

    wd_in_a_burst = 0;
    @(posedge vif.areset_n);
  endtask


  protected task main();
    fork
      //read threads
      rd_cmd_thread();
      rdata_resp_thread();

      //write threads
      wr_cmd_thread();
      wdata_thread();
      wr_resp_thread();
    join
  endtask


  protected task consume_delay(int n);
    repeat(n) @(vif.monitor_cb);
  endtask


  protected function tvip_axi_item create_new_item(int beat);
    tvip_axi_item   item  ;
    item = tvip_axi_item::type_id::create("item");
    item.set_configuration(this.configuration);

    item.data               =new[beat];                 
    item.strobe             =new[beat];               
    item.response           =new[beat];             
    item.write_data_delay   =new[beat];     
    item.response_delay     =new[beat];       
    item.addr_beat          =new[beat];  

    item.beat_cnt = 0;
    return(item);
  endfunction : create_new_item


  protected task rd_cmd_thread();
    tvip_axi_item     rd_item ;

    forever begin
      while(!(vif.monitor_cb.arvalid && vif.monitor_cb.arready)) begin
        consume_delay(1);
      end
    
      //create a new item and fill read address info
      rd_item = create_new_item(tvip_axi_burst_length'(vif.monitor_cb.arlen) + 1);

      rd_item.address_end_cyc = vif.cyc_cnt;
      rd_item.access_type= TVIP_AXI_READ_ACCESS;
      //rd_item.address    = tvip_axi_address'(vif.monitor_cb.araddr);
      //rd_item.id         = tvip_axi_id'(vif.monitor_cb.arid);
      //rd_item.set_packed_burst_length(tvip_axi_burst_length'(vif.monitor_cb.arlen));
      //rd_item.set_packed_burst_size(tvip_axi_burst_size'(vif.monitor_cb.arsize));
      //rd_item.burst_type = tvip_axi_burst_type'(vif.monitor_cb.arburst);
      //rd_item.put_cache(tvip_axi_cache'(vif.monitor_cb.arcache));
      //rd_item.protection = tvip_axi_protection'(vif.monitor_cb.arprot);
      //rd_item.qos        = tvip_axi_qos'(vif.monitor_cb.arqos);      

      rd_item.address    = vif.monitor_cb.araddr;
      rd_item.id         = vif.monitor_cb.arid;
      rd_item.set_packed_burst_length(vif.monitor_cb.arlen);
      rd_item.set_packed_burst_size(vif.monitor_cb.arsize);
      rd_item.burst_type = vif.monitor_cb.arburst;
      rd_item.put_cache(vif.monitor_cb.arcache);
      rd_item.protection = vif.monitor_cb.arprot;
      rd_item.qos        = vif.monitor_cb.arqos;

      rd_item.cache      = vif.monitor_cb.arcache;
      rd_item.addr_strobe_cal();

      //store item to hash-array of queue
      axi_read[rd_item.id].push_back(rd_item);

      //check for 4KB boundary
      if(chk_cross_4kb(rd_item)) begin
        `uvm_fatal("sky_axi_monitor", $sformatf("AXI read burst cross 4KB boundary."))
      end

      consume_delay(1);
    end
  endtask : rd_cmd_thread


  protected task rdata_resp_thread();
    tvip_axi_item   item  ;
    tvip_axi_id     id    ;

    forever begin
      while(!(vif.monitor_cb.rvalid && vif.monitor_cb.rready)) begin
        consume_delay(1);
      end

      id = vif.monitor_cb.rid;

      //check for valid addr queue
      if((axi_read.exists(id) == 0) || (axi_read[id].size() == 0)) begin
        `uvm_fatal("sky_axi_monitor", $sformatf("read address queue for id: %0x is empty.", id))
      end

      item = axi_read[id][0];
      item.data[item.beat_cnt] = tvip_axi_data'(vif.monitor_cb.rdata);
      item.response[item.beat_cnt]= vif.monitor_cb.rresp;
      `ifdef TVIP_DATA_CYC_LOG
      item.data_beat_cyc[item.beat_cnt] = vif.cyc_cnt;
      `endif
      item.beat_cnt ++;

      if((item.beat_cnt == item.burst_length)) begin
        item.response_end_cyc = vif.cyc_cnt;
        //check for rlast
        if(!vif.monitor_cb.rlast) begin
          `uvm_fatal("sky_axi_monitor", $sformatf("rlast = 0 for the last data beat of a read burst."))
        end

        //write out item
        out_monitor_port.write(item);
        void'(axi_read[id].pop_front());
      end

      consume_delay(1);
    end
  endtask : rdata_resp_thread


  protected task wr_cmd_thread();
    tvip_axi_item   item;

    forever begin


      while(!(vif.monitor_cb.awvalid && vif.monitor_cb.awready)) begin
        consume_delay(1);
      end
    
      //create a new item and fill read address info
      item = create_new_item(tvip_axi_burst_length'(vif.monitor_cb.awlen) + 1);
      item.address_end_cyc = vif.cyc_cnt;
      item.access_type= TVIP_AXI_WRITE_ACCESS;
      item.address    = tvip_axi_address'(vif.monitor_cb.awaddr);
      item.id         = tvip_axi_id'(vif.monitor_cb.awid);
      item.set_packed_burst_length(tvip_axi_burst_length'(vif.monitor_cb.awlen));
      item.set_packed_burst_size(tvip_axi_burst_size'(vif.monitor_cb.awsize));
      item.burst_type = tvip_axi_burst_type'(vif.monitor_cb.awburst);
      item.put_cache(tvip_axi_cache'(vif.monitor_cb.awcache));
      item.cache      = vif.monitor_cb.awcache;
      item.protection = tvip_axi_protection'(vif.monitor_cb.awprot);
      item.qos        = tvip_axi_qos'(vif.monitor_cb.awqos);    

      item.addr_strobe_cal();
      //store item to hash-array of queue
      axi_waddr.push_back(item);

      //check for 4KB boundary
      if(chk_cross_4kb(item)) begin
        `uvm_fatal("sky_axi_monitor", $sformatf("AXI write burst cross 4KB boundary."))
      end

      consume_delay(1);
    end
  endtask : wr_cmd_thread


  protected task wdata_thread();
    tvip_axi_item   item  ;

    forever begin

      while(!(vif.monitor_cb.wvalid && vif.monitor_cb.wready)) begin
        consume_delay(1);
      end
    
      if(!wd_in_a_burst) begin
        item = create_new_item(`TVIP_MAX_BURST_LENGTH);
        wd_in_a_burst = 1;
      end
      `ifdef TVIP_DATA_CYC_LOG
      item.data_beat_cyc[item.beat_cnt] = vif.cyc_cnt;
      `endif
      item.data[item.beat_cnt]    = vif.monitor_cb.wdata;
      item.strobe[item.beat_cnt]  = vif.monitor_cb.wstrb;
      item.beat_cnt++;

      if(vif.monitor_cb.wlast) begin
        wd_in_a_burst = 0;
        item.write_data_end_cyc = vif.cyc_cnt;
        axi_wdata.push_back(item);
      end

      //check wdata beat exceed max burst length
      if((item.beat_cnt == `TVIP_MAX_BURST_LENGTH) && (!vif.monitor_cb.wlast)) begin
          `uvm_fatal("sky_axi_monitor", $sformatf("wdata beat has exceed the maximal burst length."))
      end

      consume_delay(1);
    end
  endtask : wdata_thread


  protected task wr_resp_thread();
    tvip_axi_item   item  ;
    tvip_axi_id     id    ;
    int             index ;
    bit             find=0;
    
    forever begin
      while(!(vif.monitor_cb.bvalid && vif.monitor_cb.bready)) begin
        consume_delay(1);
      end

      id = vif.monitor_cb.bid;
      find=0;

      //search for the write addr item associate whit this resp
      for(int i=0; i<axi_waddr.size(); i++) begin
        if(axi_waddr[i].id == id) begin
          find = 1;
          index= i;
          break;
        end
      end

      //check waddr info find or not
      if(!find) begin
        `uvm_fatal("sky_axi_monitor", $sformatf("write address queue for id: %0x is empty.", id))
      end
    
      //check wdata info find or not
      if((axi_wdata.size() < index)) begin
        `uvm_fatal("sky_axi_monitor", $sformatf("write data queue for id: %0x is empty.", id))
      end

      //check waddr burst size and wdata size
      if(axi_wdata[index].beat_cnt != axi_waddr[index].burst_length) begin
        `uvm_fatal("sky_axi_monitor", $sformatf("write address/data burst beat mismatch, write burst length is: %0x, wdata size is: %0x.", 
                                                 axi_waddr[index].burst_length, axi_wdata[index].beat_cnt))
      end

      //store write response
      item = axi_waddr[index];
      item.response[0] = vif.monitor_cb.bresp;
      item.response_end_cyc = vif.cyc_cnt;

      //merge wdata to waddr item
      for(int i=0; i<item.burst_length; i++) begin
        item.data[i]  = axi_wdata[index].data[i];
        item.strobe[i]= axi_wdata[index].strobe[i];
        `ifdef TVIP_DATA_CYC_LOG
        item.data_beat_cyc[i] = axi_wdata[index].data_beat_cyc[i];
        `endif
      end
      item.write_data_end_cyc = axi_wdata[index].write_data_end_cyc;

      //write out
      out_monitor_port.write(item);
      axi_waddr.delete(index);
      axi_wdata.delete(index);

      consume_delay(1);
    end
  endtask : wr_resp_thread


  protected function bit chk_cross_4kb(tvip_axi_item item);
  
  bit                   flag = 0            ;   //0:not cross 4KB, 1:cross 4KB
  tvip_axi_burst_size   burst_size          ;   //log2(byte_num)
  tvip_axi_address      addr_size_aligned   ;
  tvip_axi_address      low_end_addr        ;

  
  if(item.burst_type == TVIP_AXI_INCREMENTING_BURST) begin
    addr_size_aligned = item.address;
    case(item.burst_size)
      'd1: ;
      'd2: addr_size_aligned[0]     = '0;
      'd4: addr_size_aligned[1:0]   = '0;
      'd8: addr_size_aligned[2:0]   = '0;
      'd16: addr_size_aligned[3:0]  = '0;
      'd32: addr_size_aligned[4:0]  = '0;
      'd64: addr_size_aligned[5:0]  = '0;
      'd128:addr_size_aligned[6:0]  = '0;
    endcase

    low_end_addr = int'({1'b0, addr_size_aligned[11:0]}) + item.burst_size * item.burst_length;

    if(low_end_addr > 4096)
        flag = 1;
  end

  return(flag);

  endfunction : chk_cross_4kb

