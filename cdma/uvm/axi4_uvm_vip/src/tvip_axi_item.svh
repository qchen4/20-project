`ifndef TVIP_AXI_ITEM_SVH
`define TVIP_AXI_ITEM_SVH
class tvip_axi_item extends tue_sequence_item #(
  .CONFIGURATION  (tvip_axi_configuration ),
  .STATUS         (tvip_axi_status        )
);
  rand  tvip_axi_access_type  access_type;            //r/w type
  rand  tvip_axi_id           id;                     //axi id
  rand  tvip_axi_address      address;                //burst begin address, can unalign with burst_size
  rand  int                   burst_length;           //burst length, cnt from 1
  rand  int                   burst_size;             //valid byte number of each data beat: 1 << axsize
  rand  tvip_axi_burst_type   burst_type;             //axi burst type: axburst
  rand  tvip_axi_memory_type  memory_type;            //user defined addr space type
  rand  tvip_axi_protection   protection;             //user defined protection type
  rand  tvip_axi_qos          qos;
  rand  tvip_axi_data         data[];                 //r/w data of each beat
  rand  tvip_axi_strobe       strobe[];               //valid bytes of each data beat in both r/w trans
  rand  tvip_axi_response     response[];             //write: 1 resp; read: same as burst_length
        tvip_axi_cache        cache;                  //read: arcache; write: awcache

  rand  int                   start_delay;            //master: axvlid delay; slave: axready delay;
  rand  int                   write_data_delay[];     //master: wvalid delay; slave: wready delay;
  rand  int                   response_delay[];       //master: bready delay for write, rready delay for read;
                                                      //slave : bvalid delay for write, rvalid delay for read;
        tvip_axi_address      addr_beat[];            //burst addr of each beat
        int                   beat_cnt;               //current beat cnt of rw data, cnt from 0
        uvm_event             address_begin_event;    //for future use, event for r/w address channel
        uint64                address_begin_cyc;
        uvm_event             address_end_event;
        uint64                address_end_cyc;
        uvm_event             write_data_begin_event; //for future use, event for write data channel
        uint64                write_data_begin_cyc;
        uvm_event             write_data_end_event;
        uint64                write_data_end_cyc;
        uvm_event             response_begin_event;   //if write, mark for write response channel,
        uint64                response_begin_cyc;     //if read, mask for read data channel;
        uvm_event             response_end_event;
        uint64                response_end_cyc;
  `ifdef TVIP_DATA_CYC_LOG
        uint64                data_beat_cyc[];
  `endif

  rand  bit                   need_response;

  function new(string name = "tvip_axi_item");
    super.new(name);
    //address_begin_event     = get_event("address_begin");   //function defined in tue_sequence_item_base
    //address_end_event       = get_event("address_end");
    //write_data_begin_event  = get_event("write_data_begin");
    //write_data_end_event    = get_event("write_data_end");
    //response_begin_event    = get_event("response_begin");
    //response_end_event      = get_event("response_end");
    address_begin_event     = new("address_begin");
    address_end_event       = new("address_end");
    write_data_begin_event  = new("write_data_begin");
    write_data_end_event    = new("write_data_end");
    response_begin_event    = new("response_begin");
    response_end_event      = new("response_end");
  endfunction

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    tvip_axi_item rhs_item;
    $cast(rhs_item, rhs);
    return
      super.do_compare(rhs, comparer) &&
      compare_memory_type(memory_type, rhs_item.memory_type, is_read());
  endfunction

  function bit is_write();
    return (access_type == TVIP_AXI_WRITE_ACCESS) ? '1 : '0;
  endfunction

  function bit is_read();
    return (access_type == TVIP_AXI_READ_ACCESS) ? '1 : '0;
  endfunction

  function int get_burst_length();
    if ((configuration != null) && (configuration.protocol == TVIP_AXI4LITE)) begin
      return 1;
    end
    else begin
      return burst_length;
    end
  endfunction

  function tvip_axi_burst_length get_packed_burst_length(); 
    return pack_burst_length(get_burst_length()); //return cnt from 0 burst_length, func defined in tvip_axi_types_pkg.sv
  endfunction

  function void set_packed_burst_length(tvip_axi_burst_length packed_burst_length);
    if ((configuration != null) && (configuration.protocol == TVIP_AXI4LITE)) begin
      burst_length  = 1;
    end
    else begin
      burst_length  = unpack_burst_length(packed_burst_length); //cnt from 1 burst_length
    end
  endfunction

  function int get_burst_size();  //byte number trans in a beat
    if ((configuration != null) && (configuration.protocol == TVIP_AXI4LITE)) begin
      return configuration.data_width / 8;
    end
    else begin
      return burst_size;
    end
  endfunction

  function tvip_axi_burst_size get_packed_burst_size();
    return pack_burst_size(get_burst_size()); //return log2(burst_size)
  endfunction

  function void set_packed_burst_size(tvip_axi_burst_size packed_burst_size);
    if ((configuration != null) && (configuration.protocol == TVIP_AXI4LITE)) begin
      burst_size  = configuration.data_width / 8;
    end
    else begin
      burst_size  = unpack_burst_size(packed_burst_size);
    end
  endfunction

  function tvip_axi_cache get_cache();
    if ((configuration != null) && (configuration.protocol == TVIP_AXI4LITE)) begin
      return '0;
    end
    else begin
      return encode_memory_type(memory_type, is_read());
    end
  endfunction

  function void put_cache(tvip_axi_cache cache);
    if ((configuration != null) && (configuration.protocol == TVIP_AXI4LITE)) begin
      memory_type = TVIP_AXI_DEVICE_NON_BUFFERABLE;
    end
    else begin
      memory_type = decode_memory_type(cache, is_read());
    end
  endfunction

  function void put_data(const ref tvip_axi_data data[$]);
    this.data = new[data.size()];
    foreach (data[i]) begin
      this.data[i]  = data[i];
    end
  endfunction

  function tvip_axi_data get_data(int index);
    if (index < data.size()) begin
      return data[index];
    end
    else begin
      return '0;
    end
  endfunction

  function void put_strobe(const ref tvip_axi_strobe strobe[$]);
    this.strobe = new[strobe.size()];
    foreach (strobe[i]) begin
      this.strobe[i]  = strobe[i];
    end
  endfunction

  function tvip_axi_strobe get_strobe(int index);
    if (index < strobe.size()) begin
      return strobe[index];
    end
    else begin
      return '0;
    end
  endfunction

  function void put_response(const ref tvip_axi_response response[$]);
    this.response = new[response.size()];
    foreach (response[i]) begin
      this.response[i]  = response[i];
    end
  endfunction

  function tvip_axi_response get_response(int index);
    if (index < response.size()) begin
      return response[index];
    end
    else begin
      return TVIP_AXI_OKAY;
    end
  endfunction

/*
  `define tvip_axi_declare_begin_end_event_api(EVENT_TYPE) \
  function void begin_``EVENT_TYPE``(time begin_time = 0); \
    if (``EVENT_TYPE``_begin_event.is_off()) begin \
      ``EVENT_TYPE``_begin_cyc = (begin_time <= 0) ? $time : begin_time; \
      ``EVENT_TYPE``_begin_event.trigger(); \
    end \
  endfunction \
  function void end_``EVENT_TYPE``(time end_time = 0); \
    if (``EVENT_TYPE``_end_event.is_off()) begin \
      ``EVENT_TYPE``_end_cyc = (end_time <= 0) ? $time : end_time; \
      ``EVENT_TYPE``_end_event.trigger(); \
    end \
  endfunction \
  function bit ``EVENT_TYPE``_began(); \
    return ``EVENT_TYPE``_begin_event.is_on(); \
  endfunction \
  function bit ``EVENT_TYPE``_ended(); \
    return ``EVENT_TYPE``_end_event.is_on(); \
  endfunction

  `tvip_axi_declare_begin_end_event_api(address   )
  `tvip_axi_declare_begin_end_event_api(write_data)
  `tvip_axi_declare_begin_end_event_api(response  )

  `undef  tvip_axi_declare_begin_end_event_api

  function bit request_began();
    return address_began();
  endfunction

  function bit request_ended();
    if (is_write()) begin
      return (address_ended() && write_data_ended()) ? 1 : 0;
    end
    else begin
      return address_ended();
    end
  endfunction

  task wait_for_done();
    response_end_event.wait_on();
  endtask

  task wait_for_request_done();
    address_end_event.wait_on();
    if (is_write()) begin
      write_data_end_event.wait_on();
    end
  endtask
*/

//--------------------------------------------------------------
//  Random constraints for request
//--------------------------------------------------------------
  constraint c_valid_id {
    (id >> this.configuration.id_width) == 0;
  }

  constraint c_valid_address {
    solve burst_size, burst_type before address;

    (address >> this.configuration.address_width) == 0;

    if(burst_type == TVIP_AXI_WRAPPING_BURST) {
      burst_size == 'd2   -> address[0]   == 1'd0;
      burst_size == 'd4   -> address[1:0] == 2'd0;
      burst_size == 'd8   -> address[2:0] == 3'd0;
      burst_size == 'd16  -> address[3:0] == 4'd0;
      burst_size == 'd32  -> address[4:0] == 5'd0;
      burst_size == 'd64  -> address[5:0] == 6'd0;
      burst_size == 'd128 -> address[6:0] == 7'd0;
    }
  }

  constraint c_valid_burst_length {
    solve burst_type before burst_length;

    if (this.configuration.protocol == TVIP_AXI4) {
      if(burst_type == TVIP_AXI_WRAPPING_BURST) {
        burst_length inside {2,4,8,16};
      } else {
        burst_length inside {[1:this.configuration.max_burst_length]};
      }
    }
    else {
      burst_length == 1;
    }
  }

  constraint c_valid_burst_size {
    if (this.configuration.protocol == TVIP_AXI4) {
      burst_size inside {1, 2, 4, 8, 16, 32, 64, 128};
      (8 * burst_size) <= this.configuration.data_width;
    }
    else {
      (8 * burst_size) == this.configuration.data_width;
    }
  }

  constraint c_4kb_boundary {
    if(burst_type == TVIP_AXI_INCREMENTING_BURST) {
      (
        (address & `tvip_axi_4kb_boundary_mask(burst_size)) +
        (burst_length * burst_size)
      ) <= 4096;
    }
  }

  constraint c_valid_memory_type {
    if (this.configuration.protocol == TVIP_AXI4LITE) {
      memory_type == TVIP_AXI_DEVICE_NON_BUFFERABLE;
    }
  }

  constraint c_valid_qos {
    qos inside {[
      this.configuration.qos_range[0]:
      this.configuration.qos_range[1]
    ]};
  }

  constraint c_valid_data {
    solve burst_length before data;

    data.size() == burst_length;

    foreach (data[i]) {
      (data[i] >> this.configuration.data_width) == 0;
    }
  }

  constraint c_valid_strobe {
    solve burst_length before strobe;

    strobe.size() == burst_length;

    foreach (strobe[i]) {
      (strobe[i] >> this.configuration.strobe_width) == 0;
      soft strobe[i] == '1;
    }
  }

  //`tvip_delay_constraint defined in file: tvip_common_macros.svh
  constraint c_address_start_delay {
    solve access_type before start_delay;
    if(access_type == TVIP_AXI_READ_ACCESS) {
        `tvip_delay_constraint(start_delay, this.configuration.rd_cmd_delay)
    } else {
        `tvip_delay_constraint(start_delay, this.configuration.wr_cmd_delay)
    }
  }

  constraint c_write_data_delay {
    solve access_type, burst_length  before write_data_delay;

    if (access_type == TVIP_AXI_WRITE_ACCESS) {
      write_data_delay.size() == burst_length;
    }
    else {
      write_data_delay.size() == 0;
    }

    foreach (write_data_delay[i]) {
      `tvip_delay_constraint(write_data_delay[i], this.configuration.write_data_delay)
    }
  }

//--------------------------------------------------------------
//  Random constraints for response
//--------------------------------------------------------------
  constraint c_valid_response {
    solve access_type before response;
    (access_type == TVIP_AXI_WRITE_ACCESS) -> response.size() == 1;
    (access_type == TVIP_AXI_READ_ACCESS ) -> response.size() == burst_length;
    foreach (response[i]) {
      response[i] dist {
        TVIP_AXI_OKAY         := this.configuration.response_weight_okay,
        TVIP_AXI_EXOKAY       := this.configuration.response_weight_exokay,
        TVIP_AXI_SLAVE_ERROR  := this.configuration.response_weight_slave_error,
        TVIP_AXI_DECODE_ERROR := this.configuration.response_weight_decode_error
      };
    }
  }

  constraint c_response_delay {
    solve access_type before response_delay;
    if (access_type == TVIP_AXI_WRITE_ACCESS) {
      response_delay.size() == 1;
    }
    else {
      response_delay.size() == burst_length;
    }

    foreach (response_delay[i]) {
      if(access_type == TVIP_AXI_READ_ACCESS) {
        `tvip_delay_constraint(response_delay[i], this.configuration.read_data_delay)
      } else {
        `tvip_delay_constraint(response_delay[i], this.configuration.response_delay)
      }
    }
  }

//--------------------------------------------------------------
//  post_randomize() to generate addr/strobe of each beat
//--------------------------------------------------------------
  function void post_randomize();
    addr_beat    = new[burst_length];
    data_beat_cyc= new[burst_length];
    addr_strobe_cal();
  endfunction : post_randomize

  function void addr_strobe_cal();
    tvip_axi_address  addr_align_burst_size;    //addr align to burst size
    tvip_axi_address  addr_align_data_bus_byte; //addr align to bus data width
    tvip_axi_address  addr;
    tvip_axi_address  lower_wrap_boundary, upper_wrap_boundary;
    tvip_axi_strobe   strobe_mask;
  
    int       data_bus_byte;                    //data bus byte size
    int       dtsize;                           //data transfer byte size of a burst
    bit       aligned_burst_size;
    int       lower_byte_lane, upper_byte_lane; //cnt from 0


    addr = this.address;
    dtsize = this.burst_size * this.burst_length;
    data_bus_byte = this.configuration.data_width / 8;

    //cal wrap burst addr range
    if(burst_type == TVIP_AXI_WRAPPING_BURST) begin
      lower_wrap_boundary = (addr/dtsize) * dtsize;
      upper_wrap_boundary = lower_wrap_boundary + dtsize;
    end

    for(int i=0; i<burst_length; i++) begin
      addr_align_burst_size = (addr/burst_size) * burst_size;
      addr_align_data_bus_byte = (addr/data_bus_byte) * data_bus_byte;
      aligned_burst_size = (addr == addr_align_burst_size)? 1'b1 : 1'b0;
  
      lower_byte_lane = addr - addr_align_data_bus_byte;
      upper_byte_lane = addr_align_burst_size - addr_align_data_bus_byte + burst_size - 1;

      //fill strobe_mask[upper_byte_lane : lower_byte_lane] = '1
      strobe_mask = ((1 << (upper_byte_lane+1)) - 1) - ((1<<lower_byte_lane) - 1);
      
      if(is_read())
        strobe[i] = strobe_mask;
      else
        strobe[i] &= strobe_mask;

      addr_beat[i] = addr;

      //cal next beat addr
      if(burst_type != TVIP_AXI_FIXED_BURST) begin
        addr = addr_align_burst_size + burst_size;

        if(burst_type == TVIP_AXI_WRAPPING_BURST) begin
          if(addr >= upper_wrap_boundary)
            addr = lower_wrap_boundary;
        end
      end
    end
  endfunction : addr_strobe_cal

  `uvm_object_utils_begin(tvip_axi_item)
    `uvm_field_enum(tvip_axi_access_type, access_type, UVM_DEFAULT)
    `uvm_field_int(id, UVM_DEFAULT | UVM_HEX)
    `uvm_field_int(address, UVM_DEFAULT | UVM_HEX)
    `uvm_field_int(burst_length, UVM_DEFAULT | UVM_DEC)
    `uvm_field_int(burst_size, UVM_DEFAULT | UVM_DEC)
    `uvm_field_enum(tvip_axi_burst_type, burst_type, UVM_DEFAULT)
    `uvm_field_enum(tvip_axi_memory_type, memory_type, UVM_DEFAULT | UVM_NOCOMPARE)
    `uvm_field_int(protection, UVM_DEFAULT | UVM_BIN)
    `uvm_field_int(qos, UVM_DEFAULT | UVM_DEC)
    `uvm_field_array_int(data, UVM_DEFAULT | UVM_HEX)
    `uvm_field_array_int(strobe, UVM_DEFAULT | UVM_HEX)
    `uvm_field_array_enum(tvip_axi_response, response, UVM_DEFAULT)
    `uvm_field_int(cache, UVM_DEFAULT)
    `uvm_field_int(start_delay, UVM_DEFAULT | UVM_DEC | UVM_NOCOMPARE)
    `uvm_field_array_int(write_data_delay, UVM_DEFAULT | UVM_DEC | UVM_NOCOMPARE)
    `uvm_field_array_int(response_delay, UVM_DEFAULT | UVM_DEC | UVM_NOCOMPARE)
    `uvm_field_array_int(addr_beat, UVM_DEFAULT | UVM_HEX)
    `uvm_field_int(address_begin_cyc, UVM_DEFAULT | UVM_TIME | UVM_NOCOMPARE)
    `uvm_field_int(address_end_cyc, UVM_DEFAULT | UVM_TIME | UVM_NOCOMPARE)
    `uvm_field_int(write_data_begin_cyc, UVM_DEFAULT | UVM_TIME | UVM_NOCOMPARE)
    `uvm_field_int(write_data_end_cyc, UVM_DEFAULT | UVM_TIME | UVM_NOCOMPARE)
    `uvm_field_int(response_begin_cyc, UVM_DEFAULT | UVM_TIME | UVM_NOCOMPARE)
    `uvm_field_int(response_end_cyc, UVM_DEFAULT | UVM_TIME | UVM_NOCOMPARE)
    `uvm_field_int(need_response, UVM_DEFAULT | UVM_NOCOMPARE | UVM_NOPRINT)
    `ifdef TVIP_DATA_CYC_LOG
    `uvm_field_array_int(data_beat_cyc, UVM_DEFAULT | UVM_HEX)
    `endif
  `uvm_object_utils_end
endclass

class tvip_axi_master_item extends tvip_axi_item;
  constraint c_default_need_response {
    soft need_response == 1;
  }

  function void pre_randomize();
    super.pre_randomize();
  endfunction

  `tue_object_default_constructor(tvip_axi_master_item)
  `uvm_object_utils(tvip_axi_master_item)
endclass

class tvip_axi_slave_item extends tvip_axi_item;
  bit           addr_dec_err    [];
  sky_addr_maps maps              ;   //handle only, connect in salve driver

  constraint c_default_need_response {
    soft need_response == 0;
  }

  function void pre_randomize();
    //just randomize delay value and response
    super.pre_randomize();
    id.rand_mode(0);
    address.rand_mode(0);
    burst_size.rand_mode(0);
    //burst_type.rand_mode(0);  //no need to rand burst_type for slave item. while vcs will fail at randomize()
    memory_type.rand_mode(0);
    protection.rand_mode(0);
    qos.rand_mode(0);
    
    c_valid_id.constraint_mode(0);
    c_valid_address.constraint_mode(0);
    c_valid_burst_length.constraint_mode(0);
    c_valid_burst_size.constraint_mode(0);
    c_4kb_boundary.constraint_mode(0);
    c_valid_memory_type.constraint_mode(0);
    c_valid_qos.constraint_mode(0);
  endfunction

  function void post_randomize();
    super.post_randomize();

    //set all strobe value to '1 for slave
    foreach(strobe[i])
      strobe[i] = '1;
  endfunction

  `tue_object_default_constructor(tvip_axi_slave_item)
  `uvm_object_utils_begin(tvip_axi_slave_item)
    `uvm_field_array_int(addr_dec_err, UVM_DEFAULT)
    `uvm_field_object   (maps, UVM_DEFAULT)
  `uvm_object_utils_end
endclass


typedef mailbox #(tvip_axi_slave_item)  mailbox_slv;
typedef mailbox #(tvip_axi_master_item) mailbox_mas;

`endif
