`timescale 1ns / 1ps                                                                                     
/****************************************Copyright (c)************************************************** 
**----------------------------------------File Info----------------------------------------------------- 
** File name					:	decode                                                                 
** Last modified Date	:	2025-11-01                                                                       
** Last Version				:	1.0                                                                              
** Descriptions       :	decode                                                                 
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
module decode	#(
	parameter	DW								=	32	
	)( 
  input		logic	[DW-1:0]			instr_in						,
  //to register
  output	logic [4:0]  				rd_rs1_addr					,
  output 	logic	[4:0]  				rd_rs2_addr					,
  //from register	
  input		logic	[DW-1:0]			rd_rs1_data					, 
  input		logic	[DW-1:0]	 		rd_rs2_data					, 
  //to instr execute
  output 	logic [DW-1:0]			op1_out							,
  output 	logic [DW-1:0]			op2_out							
);  

logic	[6:0]										opcode							;
logic [4:0]  									rd									;
logic [2:0]  									func3								;
logic [4:0]  									rs1									;
logic [4:0]  									rs2									;
logic [6:0]  									func7   						;
logic [11:0]  								imm									;

assign	opcode								= instr_in[6:0]			;
assign  rd										= instr_in[11:7]		;
assign  func3									= instr_in[14:12]		;
assign  rs1										= instr_in[19:15]		;
assign  rs2     							= instr_in[24:20]		;
assign  func7   							= instr_in[31:25]		;
assign  imm										= instr_in[31:20]		;

always_comb	begin
	if((opcode == 7'b0010011) && (func3 == 3'b000)) begin
		rd_rs1_addr  = rs1	 								;
		rd_rs2_addr  = 5'h0							    ;
		op1_out			 = rd_rs1_data					;
		op2_out			 = {{20{imm[11]}},imm}	;
	end
	else begin
		rd_rs1_addr  = 'h0	 								;
		rd_rs2_addr  = 'h0						    	;
		op1_out			 = 'h0									;
		op2_out			 = 'h0									;
	end
end

		
endmodule
