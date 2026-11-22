`ifndef SKY_AXI_SLAVE_VIRTUAL_SEQUENCE_SVH
`define SKY_AXI_SLAVE_VIRTUAL_SEQUENCE_SVH

class sky_axi_slave_virtual_sequence extends uvm_sequence;
  `uvm_object_utils(sky_axi_slave_virtual_sequence)
  `uvm_declare_p_sequencer(sky_axi_slave_virtual_sequencer)

  sky_axi_slave_r_base_sequence     read_seq;   //no instance here, pass in by top component
  sky_axi_slave_w_base_sequence     write_seq; 

// Function: new
// Constructor of object.
  function new(string name="sky_axi_slave_virtual_sequence");
    super.new(name);
  endfunction

  task body();
    if(read_seq == null) begin
        `uvm_fatal(get_name(), $sformatf("read_seq is null. Must pass in before use."))
    end
    
    if(write_seq == null) begin
        `uvm_fatal(get_name(), $sformatf("write_seq is null. Must pass in before use."))
    end

    fork
      read_seq.start(p_sequencer.read_sqr);
      write_seq.start(p_sequencer.write_sqr);
    join_any
  endtask

endclass

`endif
