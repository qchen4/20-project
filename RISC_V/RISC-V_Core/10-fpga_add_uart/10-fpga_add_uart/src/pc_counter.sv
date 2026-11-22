`timescale 1ns / 1ps                                                                                     
/****************************************Copyright (c)************************************************** 
**----------------------------------------File Info----------------------------------------------------- 
** File name					:	pc_counter                                                                 
** Last modified Date	:	2025-11-01                                                                       
** Last Version				:	1.0                                                                              
** Descriptions       :	pc_counter                                                                 
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
module pc_counter #(
	parameter	AW								=	32	
	)( 
	input 	logic       				clk							,
  input 	logic       				rst_n						,
  input		logic								jump_en					,
  input		logic	[AW-1:0]			jump_addr				,
  output  logic	[AW-1:0]   		pc_pointer			
);  

logic	[AW-1:0]								current_addr		;		

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n)
		pc_pointer <= 'h0;
	else if(jump_en)
		pc_pointer <= jump_addr;
	else
		pc_pointer <= pc_pointer + 'h4;

always_ff @(posedge clk or negedge rst_n)
	if(!rst_n)
		current_addr <= 'h0;
	else if(jump_en)
		current_addr <= pc_pointer;
		
endmodule
