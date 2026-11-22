`ifndef SKY_AXI_SLAVE_RW_SEQUENCE_LIB_SVH
`define SKY_AXI_SLAVE_RW_SEQUENCE_LIB_SVH

//func: send axi read trans only
class sky_axi_slave_r_base_sequence extends sky_axi_slave_default_sequence;

  `uvm_object_utils(sky_axi_slave_r_base_sequence)

  // Function: new
  // Constructor of object.
  function new(string name="sky_axi_slave_r_base_sequence");
    super.new(name);
    rw = TVIP_AXI_READ_ACCESS;
  endfunction

endclass : sky_axi_slave_r_base_sequence


//func: send axi write trans only
class sky_axi_slave_w_base_sequence extends sky_axi_slave_default_sequence;

  `uvm_object_utils(sky_axi_slave_w_base_sequence)

  // Function: new
  // Constructor of object.
  function new(string name="sky_axi_slave_w_base_sequence");
    super.new(name);
    rw = TVIP_AXI_WRITE_ACCESS;
  endfunction

endclass : sky_axi_slave_w_base_sequence

`endif
