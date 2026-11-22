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
// 文件说明 sky_base_macros.sv
// 提供按位取值覆盖宏，把 8 位或 32 位数据展开成多个 coverpoint。
// 调用者传入名称、数据表达式和采样条件；这些点覆盖各位取值，不是显式的边沿转换 bins。
// 宏的续行反斜杠与 token 拼接是语法组成部分，修改注释时需避开宏展开行。

//----------------------------------------------------------------------------//
// File name    : .sv
// Author       : sky@siliconthink.cn
// E-mail       : 
// Project      : 
// Created      : 
// Copyright    : 
// Description  : 
//----------------------------------------------------------------------------//

`ifndef _SKY_BASE_PKG_BASE_MACROS_
`define _SKY_BASE_PKG_BASE_MACROS_



//--------------------------------------------------
//Coverage specific macros
//--------------------------------------------------

//coverpoint to check there is 0/1 value of each bits of a 8bits data
`define cover_val_8_bits(name,byte_pos,data,condition) \
cov_bit_``name``_``byte_pos``_0_c : coverpoint data``[8*byte_pos+0:8*byte_pos+0] ``condition ; \
cov_bit_``name``_``byte_pos``_1_c : coverpoint data``[8*byte_pos+1:8*byte_pos+1]``condition; \
cov_bit_``name``_``byte_pos``_2_c : coverpoint data``[8*byte_pos+2:8*byte_pos+2]``condition; \
cov_bit_``name``_``byte_pos``_3_c : coverpoint data``[8*byte_pos+3:8*byte_pos+3]``condition; \
cov_bit_``name``_``byte_pos``_4_c : coverpoint data``[8*byte_pos+4:8*byte_pos+4]``condition; \
cov_bit_``name``_``byte_pos``_5_c : coverpoint data``[8*byte_pos+5:8*byte_pos+5]``condition; \
cov_bit_``name``_``byte_pos``_6_c : coverpoint data``[8*byte_pos+6:8*byte_pos+6]``condition; \
cov_bit_``name``_``byte_pos``_7_c : coverpoint data``[8*byte_pos+7:8*byte_pos+7]``condition;


//coverpoint to check there is 0/1 value of each bits of a 32bits data
`define cover_val_32_bits(name,data,condition) \
`cover_val_8_bits(``name``,0,``data``, ``condition``) \
`cover_val_8_bits(``name``,1,``data``, ``condition``) \
`cover_val_8_bits(``name``,2,``data``, ``condition``) \
`cover_val_8_bits(``name``,3,``data``, ``condition``)


`endif

