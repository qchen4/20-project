`timescale 1ns / 1ps                                                                                     
/****************************************Copyright (c)************************************************** 
**----------------------------------------File Info----------------------------------------------------- 
** File name					:	if2id                                                                 
** Last modified Date	:	2025-11-01                                                                       
** Last Version				:	1.0                                                                              
** Descriptions       :	if2id                                                                 
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

module if2id#(
	parameter	AW								= 32								,
	parameter	DW								=	32	
	)( 
	input  	logic      					clk									,
	input		logic      					rst_n								,
	input		logic	[AW-1:0]  		instr_addr_in				, 
	input	 	logic	[DW-1:0]			instr_in						,
	output 	logic [DW-1:0]  		instr_addr_out			,
	output 	logic [AW-1:0]  		instr_out			   			  
);  

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n)
		instr_addr_out <= 'h0;
	else
		instr_addr_out <= instr_addr_in;

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n)
		instr_out <= `INST_NOP;
	else
		instr_out <= instr_in;


		
endmodule
