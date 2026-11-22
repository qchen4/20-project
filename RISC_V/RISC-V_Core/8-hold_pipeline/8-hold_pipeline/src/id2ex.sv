`timescale 1ns / 1ps                                                                                     


/****************************************Copyright (c)************************************************** 
**----------------------------------------File Info----------------------------------------------------- 
** File name					:	id2ex                                                                     
** Last modified Date	:	2025-11-01                                                                       
** Last Version				:	1.0                                                                              
** Descriptions       :	id2ex                                                                     
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

`include "define.sv"

module id2ex #(
	parameter	AW								= 32								,
	parameter	DW								=	32	
	)( 
  input		logic        				clk									,
  input   logic     					rst_n								,
  input		logic								instr_hold					,
  input   logic [AW-1:0]			instr_addr_in				,
  input   logic	[DW-1:0]			instr_in						,
  input   logic [DW-1:0]			op1_in							,
  input   logic [DW-1:0]			op2_in							,
  //to execute
  output 	logic [AW-1:0]			instr_addr_out			,
  output 	logic [DW-1:0]			instr_out						,
  output 	logic [DW-1:0]			op1_out							,
  output 	logic [DW-1:0]			op2_out								
);  


always_ff @(posedge clk or negedge rst_n)
	if(!rst_n) begin
		instr_addr_out		<= 'h0;
		instr_out					<= `INST_NOP;
		op1_out						<= 'h0;
		op2_out						<= 'h0;
	end 
	else if(instr_hold) begin
		instr_addr_out		<= 'h0;
		instr_out					<= `INST_NOP;
		op1_out						<= 'h0;
		op2_out						<= 'h0;
	end  
	else begin
		instr_addr_out		<= instr_addr_in;
		instr_out					<= instr_in			;
		op1_out						<= op1_in				;
		op2_out						<= op2_in				;
	end
		
endmodule
