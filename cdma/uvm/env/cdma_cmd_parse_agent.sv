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
// 1: pa
//----------------------------------------------------------------------------//


class cdma_cmd_sequencer extends uvm_sequencer #(.REQ(dma_cmd_group), .RSP(dma_cmd_resp));
    `uvm_component_utils(cdma_cmd_sequencer)

    function new(string name = "cdma_cmd_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction
endclass


class cdma_cmd_parse_agent extends uvm_agent;

    cdma_cmd_driver     driver      ;
    cdma_cmd_sequencer  sequencer   ;
    //uvm_analysis_export#(dma_cmd_group) cmd_group_export;

    `uvm_component_utils(cdma_cmd_parse_agent)
    function new(string name = "inst", uvm_component parent=null);
        super.new(name, parent);
        //cmd_group_export = new("cmd_group_export", this);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        driver   = cdma_cmd_driver::type_id::create("driver", this);
        sequencer= cdma_cmd_sequencer::type_id::create("sequencer", this);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
        //driver.cmd_group_port.connect(cmd_group_export);
    endfunction : connect_phase


endclass : cdma_cmd_parse_agent

