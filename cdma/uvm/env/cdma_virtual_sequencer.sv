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

class cdma_virtual_sequencer extends uvm_virtual_sequencer;

    `uvm_component_utils(cdma_virtual_sequencer)

    
    sky_axi_slave_virtual_sequencer axi_slv_vsqr;   //before sequence start, must pass in the handle pointer
    //amiq_apb_master_sequencer       apb_mas_sqr ;
    cdma_cmd_sequencer              cmd_sqr;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
        if(axi_slv_vsqr == null) begin
            `uvm_fatal(get_name(), $sformatf("axi_slv_vsqr is null, must pass in the handle pointer."))
        end

        //if(apb_mas_sqr == null) begin
        //    `uvm_fatal(get_name(), $sformatf("apb_mas_sqr is null, must pass in the handle pointer."))
        //end

        if(cmd_sqr == null) begin
            `uvm_fatal(get_name(), $sformatf("cmd_sqr is null, must pass in the handle pointer."))
        end
    endtask

endclass : cdma_virtual_sequencer

