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
logic	[AW-1:0]								instr_addr_reg				; 
logic	[DW-1:0]								instr_reg							;	

logic [4:0]  									rd_rs1_addr						;
logic	[4:0]  									rd_rs2_addr						;
logic	[DW-1:0]								rd_rs1_data						; 
logic	[DW-1:0]	 							rd_rs2_data						; 
logic [DW-1:0]								op1_out								;
logic [DW-1:0]								op2_out								;

logic		        							wr_reg_en 						;
logic	[4:0]  									wr_reg_addr						;	
logic	[DW-1:0]  							wr_reg_data						;


assign	jump_en								= 1'b0								;
assign	jump_addr							=	'h0									; 
assign	wr_reg_en           	= 1'b1								;
assign	wr_reg_data           = op2_out							;
                                                  	
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

if2id #(
	.AW													(AW										),	
	.DW													(DW										)	
	)u_if2id_inst( 
	.clk												(clk									),
	.rst_n											(rst_n								),
	.instr_addr_in							(pc_pointer						), 
	.instr_in										(instruction					),
	.instr_addr_out							(instr_addr_reg				),
	.instr_out			   					(instr_reg						)	  
);  

decode #(
	.DW													(DW										)		
	)u_decode_inst( 
  .instr_in										(instr_reg						),
  .rd_rs1_addr								(rd_rs1_addr					),
  .rd_rs2_addr								(rd_rs2_addr					),
  .wr_reg_addr                (wr_reg_addr         	),
  .rd_rs1_data								(rd_rs1_data					), 
  .rd_rs2_data								(rd_rs2_data					), 
  .op1_out										(op1_out							),
  .op2_out										(op2_out							)
);  

register #(
	.DW													(DW										)		
	)u_register_inst( 
	.clk												(clk									), 
	.rst_n											(rst_n								), 
	.rd_rs1_addr								(rd_rs1_addr					),
	.rd_rs2_addr								(rd_rs2_addr					),	
	.rd_rs1_data								(rd_rs1_data					), 
	.rd_rs2_data								(rd_rs2_data					),
	.wr_reg_en 	      					(wr_reg_en						), 
	.wr_reg_addr								(wr_reg_addr					),	
	.wr_reg_data								(wr_reg_data					)	
	
);  
   
endmodule
