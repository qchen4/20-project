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
// File name    : .v
// Author       : sky@siliconthink.cn
// E-mail       : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  : 
//----------------------------------------------------------------------------//

module mrisc_exe_mul(
    A           ,
    B           ,
    PRODUCT
);


input   wire    [32:0]  A, B    ;
output  wire    [65:0]  PRODUCT ;


DW02_mult #(.A_width(33), .B_width(33)) u_mul(
    .A          (A          ),
    .B          (B          ),
    .TC         (1'b1       ),
    .PRODUCT    (PRODUCT    )
);


endmodule

