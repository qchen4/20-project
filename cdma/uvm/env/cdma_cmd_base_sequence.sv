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

class cdma_cmd_base_sequence extends uvm_sequence#(.REQ(dma_cmd_group), .RSP(dma_cmd_resp));

    typedef logic [31:0]    reg_type;
    cdma_reg_model      cdma_rm ;   //pointer only, must pass in handle before use.
    dma_env_ctl         env_ctl ;   //pointer only

    `uvm_object_utils(cdma_cmd_base_sequence)
    `uvm_declare_p_sequencer(cdma_cmd_sequencer)

    function new(string name = "cdma_cmd_base_sequence");
		super.new(name);
	endfunction

    virtual task body();
        $display("body of cdma_cmd_base_sequence.");
        if(cdma_rm == null) begin
            `uvm_fatal(get_name(), $sformatf("cdma_rm is null. Must pass in before use."));
        end

        //for each testcase, write your test sequence here
        // ...
        // ...
    endtask : body
    

    extern virtual task reg_read(uint32 addr, output reg_type rdata);
    extern virtual task reg_write(uint32 addr, reg_type wdata);

endclass : cdma_cmd_base_sequence


task cdma_cmd_base_sequence::reg_read(uint32 addr, output reg_type rdata);
    uvm_reg         rw_reg  ;
    uvm_status_e    status  ;


    rw_reg = cdma_rm.default_map.get_reg_by_offset((addr & 32'hff));
    if(rw_reg == null)
        `uvm_fatal(get_name(), $sformatf("Get reg in aes_rm at addr 0x%0h failed.", addr))
    else begin
        rw_reg.read(status, rdata, UVM_FRONTDOOR);
    end
endtask : reg_read

task cdma_cmd_base_sequence::reg_write(uint32 addr, reg_type wdata);
    uvm_reg         rw_reg  ;
    uvm_status_e    status  ;

    rw_reg = cdma_rm.default_map.get_reg_by_offset((addr & 32'hff));
    if(rw_reg == null)
        `uvm_fatal(get_name(), $sformatf("Get reg in aes_rm at addr 0x%0h failed.", addr))
    else begin
        rw_reg.write(status, wdata, UVM_FRONTDOOR);
    end  

endtask: reg_write

