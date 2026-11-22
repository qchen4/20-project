`timescale 1ns / 1ps                                                                                     
/****************************************Copyright (c)************************************************** 
**----------------------------------------File Info----------------------------------------------------- 
** File name					:	tb_riscv_top                                                                 
** Last modified Date	:	2025-11-01                                                                       
** Last Version				:	1.0                                                                              
** Descriptions       :	tb_riscv_top                                                                 
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

`include "./../src/define.sv"

module tb_riscv_top;

localparam	FILE      	= "../test_data/rv32ui-p-addi.dat";

logic       				clk												;
logic       				rst_n											;
logic	[31:0]				tmp												;
logic [31:0]			 	test_case  								;
logic [31:0]				reg_s10  									;
logic [31:0]				reg_s11  									;
 
riscv #(
	.FILE							(FILE											),
	.AW								(`AW											),	
	.DW								(`DW											)
	) u_riscv_inst(                                			
	.clk							(clk											),
  .rst_n						(rst_n										),
  .test_case				(test_case								),
	.reg_s10					(reg_s10									),
	.reg_s11	 				(reg_s11									)
);     
	
	
always #5 clk = ~clk;	
initial begin
	clk     					= 1'b0;
	rst_n   					= 1'b0;
	tmp								=	32'h0; 
	#1000;          	
	rst_n   					= 1'b1;
end


initial  begin
	forever begin
		tmp = test_case;
		@(posedge clk);
		if(tmp != test_case)
			$display("test[%d]",test_case);
		if(reg_s10 == 32'h1) begin
			repeat(10) @(posedge clk);
			if(reg_s11 == 32'h1) begin
				repeat(3) $display("**************************************************");
				$display("\n");
				$display("%s",FILE," test passed !!!!! ");
				$display("\n");
				repeat(3) $display("**************************************************");
//				for(int i=0;i<32;i++) begin
//					$display("%d register value is %d",i,tb_riscv_top.u_riscv_inst.u_register_inst.regs[i]);
//				end
				$finish;
			end
			else begin
				repeat(3) $display("**************************************************");
				$display("\n");
				$display("%s",FILE,"  test failed !!!!! ");
				$display("\n");
				repeat(3) $display("**************************************************");
				$display("Tht failed test case is test[%d]",test_case);
				for(int i=0;i<32;i++) begin
					$display("%d register value is %d",i,tb_riscv_top.u_riscv_inst.u_register_inst.regs[i]);
				end
				$finish;
			end
		end
	end
end
     
endmodule

