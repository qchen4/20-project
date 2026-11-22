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
// 1: axi interface function coverage by cover property;
// 2: axi interface protocal assertions;
//----------------------------------------------------------------------------//

//1: function coverage by cover property
//1.1 all response type
sequence w_resp_end;
    bvalid && bready;
endsequence

w_resp_0: cover property (@(posedge aclk) w_resp_end |-> (bresp == 0));
w_resp_1: cover property (@(posedge aclk) w_resp_end |-> (bresp == 1));
w_resp_2: cover property (@(posedge aclk) w_resp_end |-> (bresp == 2));
w_resp_3: cover property (@(posedge aclk) w_resp_end |-> (bresp == 3));

sequence rd_resp_end;
    rvalid && rready;
endsequence

rd_resp_0: cover property (@(posedge aclk) rd_resp_end |-> (rresp == 0));
rd_resp_1: cover property (@(posedge aclk) rd_resp_end |-> (rresp == 1));
rd_resp_2: cover property (@(posedge aclk) rd_resp_end |-> (rresp == 2));
rd_resp_3: cover property (@(posedge aclk) rd_resp_end |-> (rresp == 3));

//2: assertion to check axi protocal
//TBD...

