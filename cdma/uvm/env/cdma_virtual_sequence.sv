// ---------------------------------------------------------------------------//
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from SiliconThink.
//
//      (C) COPYRIGHT SiliconThink Limited or its affiliates
//                   ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from SiliconThink or its affiliates.
// ---------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// File name    : .sv
// Author       : sky@siliconthink.cn
// E-mail       : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  : 
//----------------------------------------------------------------------------//


class cdma_virtual_sequence extends uvm_sequence;
  `uvm_object_utils(cdma_virtual_sequence)
  `uvm_declare_p_sequencer(cdma_virtual_sequencer)

  
  sky_axi_slave_virtual_sequence    axi_slv_vsqc;   
  cdma_cmd_base_sequence            cdma_sqc;       //no instance here, pass in by top component

  function new(string name="cdma_virtual_sequence");
    super.new(name);
    axi_slv_vsqc = sky_axi_slave_virtual_sequence::type_id::create("axi_slv_vsqc");
  endfunction

  task body();
    if(cdma_sqc == null) begin
        `uvm_fatal(get_name(), $sformatf("cdma_sqc is null. Must pass in before use."))
    end

    fork
        axi_slv_vsqc.start(p_sequencer.axi_slv_vsqr);
        begin
            $display("start cdma sequence.");
            cdma_sqc.start(p_sequencer.cmd_sqr);
        end
    join_any
  endtask : body

endclass

