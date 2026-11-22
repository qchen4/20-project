`ifndef TVIP_AXI_CONFIGURATION_SVH
`define TVIP_AXI_CONFIGURATION_SVH
class tvip_axi_configuration extends tue_configuration;
        tvip_axi_mas_vif          mas_vif;
        tvip_axi_slv_vif          slv_vif;
        uvm_event_pool            events;                       //event pool used for this agent
        string                    name;                         //name of this master/slave agent, must be unique in the whole UVM env
  rand  tvip_axi_protocol         protocol;
  rand  int                       id_width;
  rand  int                       address_width;
  rand  int                       max_burst_length;
  rand  int                       data_width;
  rand  int                       strobe_width;
  rand  int                       qos_range[2];
  rand  int                       max_outstanding_num;          //maximal cmd outstanding number
  rand  tvip_axi_ordering_mode    response_ordering;            //0:in order resp; 1: out of order resp
  rand  int                       outstanding_responses;        //maximal outstanding cmd number
  rand  bit                       enable_response_interleaving; //0:disable read data interleave; 1: enable
  rand  int                       min_interleave_size;          //miminal beat length when interleave
  rand  int                       max_interleave_size;          //maximal beat length when interleave
  rand  int                       response_weight_okay;
  rand  int                       response_weight_exokay;
  rand  int                       response_weight_slave_error;
  rand  int                       response_weight_decode_error;
  rand  tvip_delay_configuration  rd_cmd_delay;                 //delay cycle randomize contrl for read cmd vld/ready
  rand  tvip_delay_configuration  read_data_delay;              //delay cycle randomize contrl for read data vld/ready
  rand  tvip_delay_configuration  wr_cmd_delay;                 //delay cycle randomize contrl for write cmd vld/ready
  rand  tvip_delay_configuration  write_data_delay;             //delay cycle randomize contrl for write data vld/ready
  rand  tvip_delay_configuration  response_delay;               //delay cycle randomize contrl for write response vld/ready

  rand  bit                       reset_by_agent;
  rand  bit                       has_coverage;
  rand  bit                       is_active;


  constraint c_default_protocol {
    protocol == TVIP_AXI4;
  }

  constraint c_coverage {
    soft has_coverage == 0;
  }

  constraint c_active {
    soft is_active == 1;
  }

  constraint c_valid_id_width {
    //id_width inside {[0:`TVIP_AXI_MAX_ID_WIDTH]};
    id_width == `TVIP_AXI_MAX_ID_WIDTH;
  }

  constraint c_valid_address_width {
    //address_width inside {[1:`TVIP_AXI_MAX_ADDRESS_WIDTH]};
    address_width == `TVIP_AXI_MAX_ADDRESS_WIDTH;
  }

  constraint c_valid_max_burst_length {
    //max_burst_length inside {[1:256]};
    max_burst_length == `TVIP_MAX_BURST_LENGTH;
  }

  constraint c_valid_data_width {
    data_width == `TVIP_AXI_MAX_DATA_WIDTH;
  }

  constraint c_valid_strobe_width {
    solve data_width before strobe_width;
    strobe_width == (data_width / 8);
  }

  constraint c_valid_qos_range {
    qos_range[0] <= qos_range[1];
    foreach (qos_range[i]) {
      qos_range[i] inside {-1, [0:15]};
    }
  }

  constraint c_default_qos_range {
    foreach (qos_range[i]) {
      soft qos_range[i] == -1;
    }
  }

  constraint c_max_outstanding_num {
    max_outstanding_num == `TVIP_MAX_OUTSTANDING;
  }

  constraint c_valid_response_ordering {
    if(`TVIP_AXI_RESP_ORDER_EN)
      response_ordering == TVIP_AXI_OUT_OF_ORDER;
    else
      response_ordering == TVIP_AXI_IN_ORDER;
  }

  constraint c_valid_outstanding_responses {
    outstanding_responses == `TVIP_MAX_OUTSTANDING;
  }

  constraint c_default_enable_response_interleaving {
    enable_response_interleaving == `TVIP_RDATA_INTERLEAVE_EN;
  }

  constraint c_valid_interleave_size {
    solve max_burst_length before max_interleave_size, min_interleave_size;

    if(`TVIP_RDATA_INTERLEAVE_EN == 0) {
      min_interleave_size == 0; //no rdata interleave
      max_interleave_size == 0;
    } else {
      max_interleave_size >= min_interleave_size;
      min_interleave_size inside {[1 : (max_burst_length >> 1)]};
      max_interleave_size inside {[1 : max_burst_length]};
    }
  }

  constraint c_valid_response_weight {
    response_weight_okay         >= -1;
    response_weight_exokay       >= -1;
    response_weight_slave_error  >= -1;
    response_weight_decode_error >= -1;
  }

  constraint c_default_response_weight {
    soft response_weight_okay         == -1;
    soft response_weight_exokay       == -1;
    soft response_weight_slave_error  == -1;
    soft response_weight_decode_error == -1;
  }

  constraint c_default_reset_by_agent {
    soft reset_by_agent == 1;
  }

  function new(string name = "tvip_axi_configuration");
    super.new(name);
    rd_cmd_delay        = tvip_delay_configuration::type_id::create("rd_cmd_delay");
    read_data_delay     = tvip_delay_configuration::type_id::create("read_data_delay");
    wr_cmd_delay        = tvip_delay_configuration::type_id::create("wr_cmd_delay");
    write_data_delay    = tvip_delay_configuration::type_id::create("write_data_delay");
    response_delay      = tvip_delay_configuration::type_id::create("response_delay");
  endfunction

  function void post_randomize();
    super.post_randomize();
    qos_range[0]                  = (qos_range[0]                 >= 0) ? qos_range[0]                 : 0;
    qos_range[1]                  = (qos_range[1]                 >= 0) ? qos_range[1]                 : 0;
    response_weight_okay          = (response_weight_okay         >= 0) ? response_weight_okay         : 1; //default okay resp only
    response_weight_exokay        = (response_weight_exokay       >= 0) ? response_weight_exokay       : 0;
    response_weight_slave_error   = (response_weight_slave_error  >= 0) ? response_weight_slave_error  : 0;
    response_weight_decode_error  = (response_weight_decode_error >= 0) ? response_weight_decode_error : 0;
  endfunction

  `uvm_object_utils_begin(tvip_axi_configuration)
    `uvm_field_string(name, UVM_DEFAULT)
    `uvm_field_enum(tvip_axi_protocol, protocol, UVM_DEFAULT)
    `uvm_field_int(id_width, UVM_DEFAULT | UVM_DEC)
    `uvm_field_int(address_width, UVM_DEFAULT | UVM_DEC)
    `uvm_field_int(max_burst_length, UVM_DEFAULT | UVM_DEC)
    `uvm_field_int(data_width, UVM_DEFAULT | UVM_DEC)
    `uvm_field_int(strobe_width, UVM_DEFAULT | UVM_DEC)
    `uvm_field_sarray_int(qos_range, UVM_DEFAULT | UVM_DEC)
    `uvm_field_int(max_outstanding_num, UVM_DEFAULT | UVM_DEC)
    `uvm_field_enum(tvip_axi_ordering_mode, response_ordering, UVM_DEFAULT)
    `uvm_field_int(outstanding_responses, UVM_DEFAULT | UVM_DEC)
    `uvm_field_int(enable_response_interleaving, UVM_DEFAULT | UVM_BIN)
    `uvm_field_int(min_interleave_size, UVM_DEFAULT | UVM_DEC)
    `uvm_field_int(max_interleave_size, UVM_DEFAULT | UVM_DEC)
    `uvm_field_int(response_weight_okay, UVM_DEFAULT | UVM_DEC)
    `uvm_field_int(response_weight_exokay, UVM_DEFAULT | UVM_DEC)
    `uvm_field_int(response_weight_slave_error, UVM_DEFAULT | UVM_DEC)
    `uvm_field_int(response_weight_decode_error, UVM_DEFAULT | UVM_DEC)
    `uvm_field_object(rd_cmd_delay, UVM_DEFAULT)
    `uvm_field_object(read_data_delay, UVM_DEFAULT)
    `uvm_field_object(wr_cmd_delay, UVM_DEFAULT)
    `uvm_field_object(write_data_delay, UVM_DEFAULT)
    `uvm_field_object(response_delay, UVM_DEFAULT)
    `uvm_field_int(reset_by_agent, UVM_DEFAULT | UVM_BIN)
    `uvm_field_int(has_coverage, UVM_DEFAULT | UVM_BIN)
    `uvm_field_int(is_active, UVM_DEFAULT | UVM_BIN)
  `uvm_object_utils_end
endclass
`endif
