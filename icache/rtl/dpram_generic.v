// 文件说明 dpram_generic.v
// 通用独立读写端口 RAM 行为模型，用作 Cache 标签存储。
// A 端口在 clka 上升沿按 ena 与 wea 写入；B 端口在 clkb 上升沿按 enb 读取。
// 无复位清零，初始化由标签控制逻辑完成；同地址读写的硬件语义须与目标 SRAM 核对。
// Description  : 
// Illuminate   : 
// Abbreviation : 
//----------------------------------------------------------------------------//

module dpram_generic(
                    clka,
                    ena,
                    wea,
                    dina,
                    addra,         
                    clkb,
                    enb,
                    addrb,
                    doutb 
                    );    

parameter ADDR_BITS = 7;
parameter ADDR_AMOUNT = 128;
parameter DATA_BITS = 32;

//-- write port
input clka;
input ena;
input wea;
input [DATA_BITS-1:0]dina;
input [ADDR_BITS-1:0]addra;                    
//-- read port
input clkb;                         
input enb;
input [ADDR_BITS-1:0]addrb;
output [DATA_BITS-1:0]doutb;

reg [DATA_BITS-1:0]doutb;
reg [DATA_BITS-1:0]mem[0 : ADDR_AMOUNT-1];


always@(posedge clkb)                //-- read 
begin
   if(enb==1'b1)
      doutb<=mem[addrb];
end

always@(posedge clka)                //-- write
begin
   if(ena==1'b1) 
      begin
         if(wea==1'b1)
            mem[addra]<=dina;
      end 
end

endmodule

