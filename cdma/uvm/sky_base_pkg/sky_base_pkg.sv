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

`ifndef _SKY_BASE_PKG_
`define _SKY_BASE_PKG_

package sky_base_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh" 

`include "sky_base_macros.sv"
`include "sky_base_types.sv"
`include "sky_sys_mem.sv"
`include "sky_addr_map.sv"
`include "sky_reg_rw_32bit.sv"
//`include "sky_reg_model.sv"

endpackage : sky_base_pkg

`endif

