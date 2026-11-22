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


class xx_comp extends uvm_component;

    `uvm_component_utils(xx_comp);

    function new(string name = "xx_comp", uvm_component parent);
		super.new(name, parent);
	endfunction


endclass : xx_comp


class xx_seq extends uvm_sequence #(.REQ(), .RSP());
    
    `uvm_object_utils(xx_seq)

    function new(string name = "xx_seq");
		super.new(name);
	endfunction

endclass : xx_seq


class xx_item extends uvm_sequence_item;
    
    `uvm_object_utils(xx_item)

    function new(string name = "xx_item");
		super.new(name);
	endfunction

endclass : xx_item

