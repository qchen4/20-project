`timescale 1ns / 1ps                                                                                     
/****************************************Copyright (c)************************************************** 
**----------------------------------------File Info----------------------------------------------------- 
** File name					:	rom                                                                 
** Last modified Date	:	2025-11-01                                                                       
** Last Version				:	1.0                                                                              
** Descriptions       :	rom                                                                 
**------------------------------------------------------------------------------------------------------ 
** Created by					: FPGACoreCG                                                                       
** Created date				: 2025-11-01                                                                        
** Version						: 1.0                                                                              
** Descriptions				:	The original version                                                             
**------------------------------------------------------------------------------------------------------ 
** Modified by:				                                                                                   
** Modified date:			                                                                                   
** Version:					                                                                                     
** Descriptions:		                                                                                     
**                                                                                                       
**------------------------------------------------------------------------------------------------------ 
*******************************************************************************************************/ 
module rom #(
	parameter	FILE              = "rv32ui-p-addi.txt"	,
	parameter	AW								=	32									,
	parameter	DW								=	32	
	)( 
	input		logic								clk										,
	input		logic								rst_n									,
	input		logic	[AW-1:0]   		instr_addr						,
  output	logic	[DW-1:0]			instr_out				   	  
);  

static 	string 		path				= "../test_data/"			;
static	string	  full_path		=	{path,FILE}					;
initial begin
	//$readmemh("../test_data/rv32ui-p-addi.txt",rom_mem);
	$readmemh(full_path,rom_mem); 
	
end  

logic [DW-1:0] 								rom_mem[0:4095]			;

//always_ff @(posedge clk or negedge rst_n)
//	if(!rst_n)
//		inst_out <=	'h0;
//	else
//		inst_out <=	rom_mem[instr_addr[AW-1:2]];

always_comb begin
	instr_out = rom_mem[instr_addr[AW-1:2]];
end
		
endmodule
