`timescale 1ns / 1ps                                                                                       
/****************************************Copyright (c)**************************************************   
**----------------------------------------File Info-----------------------------------------------------   
** File name					:	crc8_coder                                                                   
** Last modified Date	:	2025-09-02                                                                         
** Last Version				:	1.0                                                                                
** Descriptions:				Compute and append CRC8:
//             					polynomial: x^8 + x^2 + x^1 + 1
//              				CRC8 computing with 8-bit entry
//              				initial value: 0x00                                                              
**------------------------------------------------------------------------------------------------------   
** Created by					: FPGACoreCG                                                                         
** Created date				:	2025-09-02                                                                         
** Version						: 1.0                                                                                
** Descriptions				:	The original version                                                               
**------------------------------------------------------------------------------------------------------   
** Modified by				:				                                                                             
** Modified date			:			                                                                               
** Version						:					                                                                           
** Descriptions				:		                                                                                 
**------------------------------------------------------------------------------------------------------   
********************************************************************************************************/  

module crc8_coder (
	input  logic [7:0]  				din					,
	input  logic [7:0]  				crc_in			,
	output logic [7:0]  				crc_out
);


logic [7:0]   d	= din;
logic [7:0]   c	= crc_in;

assign crc_out[0] = d[7] ^ d[6] ^ d[0] ^ c[0] ^ c[6] ^ c[7];                
assign crc_out[1] = d[6] ^ d[1] ^ d[0] ^ c[0] ^ c[1] ^ c[6];                
assign crc_out[2] = d[6] ^ d[2] ^ d[1] ^ d[0] ^ c[0] ^ c[1] ^ c[2] ^ c[6];  
assign crc_out[3] = d[7] ^ d[3] ^ d[2] ^ d[1] ^ c[1] ^ c[2] ^ c[3] ^ c[7];  
assign crc_out[4] = d[4] ^ d[3] ^ d[2] ^ c[2] ^ c[3] ^ c[4];                
assign crc_out[5] = d[5] ^ d[4] ^ d[3] ^ c[3] ^ c[4] ^ c[5];                
assign crc_out[6] = d[6] ^ d[5] ^ d[4] ^ c[4] ^ c[5] ^ c[6];                
assign crc_out[7] = d[7] ^ d[6] ^ d[5] ^ c[5] ^ c[6] ^ c[7];                

endmodule

