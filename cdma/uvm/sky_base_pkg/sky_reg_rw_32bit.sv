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


class reg_rw_32bit extends uvm_reg;

    `uvm_object_utils(reg_rw_32bit)

    rand uvm_reg_field  reg_32bit   ;

    function new(input string name="reg_rw_32bit");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        reg_32bit = uvm_reg_field::type_id::create("reg_rw_32bit");
        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        reg_32bit.configure(this,   32,   0,   "RW",   0,        32'h00,    1,         1,       1);
    endfunction : build

endclass : reg_rw_32bit


class reg_reserved_32bit extends uvm_reg;
    `uvm_object_utils(reg_reserved_32bit)

    rand uvm_reg_field  reg_32bit   ;

    function new(input string name="reg_reserved_32bit");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction : new

    virtual function void build();
        reg_32bit = uvm_reg_field::type_id::create("reg_reserved_32bit");
        //configure field:parent, size, lsb, access, volatile, reset val, has_reset, is_rand, self_accessible
        reg_32bit.configure(this,   32,   0,   "RO",   0,        32'h00,    1,         0,       1);
    endfunction : build


endclass : reg_reserved_32bit



