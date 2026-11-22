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

module mrisc_exe_div(
    a           ,
    b           ,
    b_zero      ,
    quotient    ,
    remainder   
);


input   wire    [32:0]  a, b    ;
input   wire            b_zero  ;
output  reg     [32:0]  quotient;
output  wire    [32:0]  remainder;

wire    [32:0]  quotient_t, remainder_t;


DW_div #(.a_width(33), .b_width(33), .tc_mode(1), .rem_mode(1)) u_div(
    .a          (a          ), 
    .b          (b          ),
    .quotient   (quotient_t ), 
    .remainder  (remainder_t), 
    .divide_by_0()
);


always @(*)begin
    if(b_zero)
        quotient = {1'b0, 32'hffff_ffff};
    //else if(a[32] && b[32] && quotient_t == 33'h8000_0000)
    //    quotient = 33'h8000_0000; //the DW_div output should be this value
    else
        quotient = quotient_t;
end

assign  remainder= (b_zero)? {1'b0, a[31:0]} : remainder_t;

endmodule

