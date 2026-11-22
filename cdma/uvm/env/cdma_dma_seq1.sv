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

class cdma_dma_seq1 extends cdma_cmd_base_sequence;

    `uvm_object_utils(cdma_dma_seq1)

    function new(string name = "cdma_dma_seq1");
		super.new(name);
	endfunction

    virtual task body();
        dma_cmd_group       cmd     ;
        dma_cmd_resp        resp    ;
        int                 cmd_cnt=0;

        if(cdma_rm == null) begin
            `uvm_fatal(get_name(), $sformatf("cdma_rm is null. Must pass in before use."));
        end

        if(env_ctl == null) begin
            `uvm_fatal(get_name(), $sformatf("env_ctl is null. Must pass in before use."));
        end
        
        //send 1 DMA command
        `uvm_info(get_name(), "begin DMA cmd sequence.", UVM_LOW)
        `uvm_create(cmd)
        cmd.env_ctl = env_ctl;
        `uvm_rand_send_with(cmd, {cmd_num == 1;})
        `uvm_info(get_name(), "send a DMA cmd.", UVM_LOW)
        get_response(resp);

        cmd_cnt ++;


        //--- report
        `uvm_info(get_name(), $sformatf("Sequence send %0d 2D DMA command groups.", cmd_cnt), UVM_LOW)

    endtask : body
    

endclass : cdma_dma_seq1

