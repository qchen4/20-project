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

class cdma_reg_test_seq extends cdma_cmd_base_sequence;

    `uvm_object_utils(cdma_reg_test_seq)

    uvm_reg_hw_reset_seq        rm_reset_chk;
    uvm_reg_access_seq          rm_rw_chk;
    uvm_reg_bit_bash_seq        rm_rw_bash_chk;


    function new(string name = "cdma_reg_test_seq");
		super.new(name);
	endfunction

    virtual task body();
        dma_cmd_group       cmd     ;
        dma_cmd_resp        resp    ;

        if(cdma_rm == null) begin
            `uvm_fatal(get_name(), $sformatf("cdma_rm is null. Must pass in before use."));
        end

        if(env_ctl == null) begin
            `uvm_fatal(get_name(), $sformatf("env_ctl is null. Must pass in before use."));
        end
 
        rm_reset_chk= uvm_reg_hw_reset_seq::type_id::create("rm_reset_chk");
        rm_rw_chk   = uvm_reg_access_seq::type_id::create("rm_rw_chk");
        rm_rw_bash_chk = uvm_reg_bit_bash_seq::type_id::create("rm_rw_bash_chk");

        rm_reset_chk.model= cdma_rm;
        rm_rw_chk.model = cdma_rm;
        rm_rw_bash_chk.model = cdma_rm;

        `uvm_info(get_name(), "Begin RegModel reset value check.", UVM_MEDIUM)
        rm_reset_chk.start(null);

        #100ns;
        `uvm_info(get_name(), "Begin RegModel R/W check.", UVM_MEDIUM)
        rm_rw_chk.start(null);

        #100ns;
        `uvm_info(get_name(), "Begin RegModel bash R/W check.", UVM_MEDIUM)
        rm_rw_bash_chk.start(null);

    endtask : body
    

endclass : cdma_reg_test_seq

