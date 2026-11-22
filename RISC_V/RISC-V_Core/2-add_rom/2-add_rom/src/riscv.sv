`timescale 1ns / 1ps                                                                                     
/****************************************Copyright (c)************************************************** 
**----------------------------------------File Info----------------------------------------------------- 
** File name					:	riscv                                                                 
** Last modified Date	:	2025-11-01                                                                       
** Last Version				:	1.0                                                                              
** Descriptions       :	riscv                                                                 
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
module riscv#(
	parameter	FILE              = "rv32ui-p-addi.txt"	,
	parameter	AW								=	32									,
	parameter	DW								=	32	
	)( 
	input	logic      						clk										,
  input	logic        					rst_n								   	  
);  

                                                  	
logic													jump_en								;
logic	[AW-1:0]								jump_addr							;
logic	[AW-1:0]								pc_pointer						;
logic	[DW-1:0]								instruction						;	

assign	jump_en								= 1'b0								;
assign	jump_addr							=	'h0									;
                                                  	
pc_counter #(                                     	
	.AW													(AW										)
	)u_pc_counter_inst(                         			
	.clk												(clk									),
  .rst_n											(rst_n								),
  .jump_en										(jump_en							),
  .jump_addr									(jump_addr						),
  .pc_pointer			  					(pc_pointer						)
);  

rom #(
	.FILE												(FILE									),
	.AW													(AW										),	
	.DW													(DW										)
	)u_rom_inst(                                    	
	.clk												(clk									),
	.rst_n											(rst_n								),
	.instr_addr									(pc_pointer						),
  .instr_out				  				(instruction					)	 	  
);    
endmodule
