// 文件说明 spram_generic.v
// 通用同步单端口 RAM 行为模型，用作四路 Cache 数据存储。
// en 为高时在时钟上升沿操作；we 为高执行写入，否则更新读输出。
// 读写共用地址，同拍只能选择一种操作；未使能或写入时读输出保持。
// 模型没有复位清零，缓存有效性由标签有效位控制。
// Description  : 
// Illuminate   : 
// Abbreviation : 
//----------------------------------------------------------------------------//

module spram_generic(
                    clk,
                    en,
                    we,
                    addr,
                    din,
                    
                    dout
                    );    

parameter ADDR_BITS = 7;
parameter ADDR_AMOUNT = 128;
parameter DATA_BITS = 32;

input clk;
input en;
input we;
input [ADDR_BITS-1:0]addr;
input [DATA_BITS-1:0]din;
output [DATA_BITS-1:0]dout;

reg [DATA_BITS-1:0]dout;
reg [DATA_BITS-1:0]mem[0 : ADDR_AMOUNT-1];

always@(posedge clk)
begin
	if(en) begin
        if(we==1'b1)
   	    	mem[addr]<=din; 
	    else
        	dout<=mem[addr]; 
    end     
end


endmodule

