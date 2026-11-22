`timescale 1ns / 1ps                                                                                     
/****************************************Copyright (c)************************************************** 
**----------------------------------------File Info----------------------------------------------------- 
** File name					:	execute                                                                            
** Last modified Date	:	2025-11-01                                                                       
** Last Version				:	1.0                                                                              
** Descriptions       :	execute                                                                            
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


module execute #(
	parameter	AW								= 32								,
	parameter	DW								=	32	
	)(
	input  	logic [AW-1:0]			instr_addr					, 
	input		logic	[DW-1:0]			instr								,
	input   logic [DW-1:0]			op1									,
	input   logic [DW-1:0]			op2									,
	output 	logic          			wr_reg_en						, 
	output 	logic [4:0]					wr_reg_addr					,
	output 	logic [DW-1:0]			wr_reg_data
);  


logic	[6:0]										opcode							;
logic [4:0] 									rd									;
logic [2:0]  									func3								;
logic [ 6:0]  								func7   						;
logic [11:0]  								imm									;

assign	opcode								= instr[6:0]				;
assign  rd										= instr[11:7]				;
assign  func3									= instr[14:12]			;
assign  func7   							= instr[31:25]			;
assign  imm										= instr[31:20]			;	


always_comb	begin
	if((opcode == 7'b0010011) && (func3 == 3'b000)) begin
		wr_reg_en  	 = 1'b1	 								;
		wr_reg_addr  = rd							    	;
		wr_reg_data	 = op1 + op2						;
	end
	else begin
		wr_reg_en  	 = 1'b0	 								;
		wr_reg_addr  = 5'h0							    ;
		wr_reg_data	 = 'h0									;
	end
end
		
endmodule
