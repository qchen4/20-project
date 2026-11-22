// 文件说明 sim_define.v
// 项目仿真公共配置，供 DUT 参数、激励、模型和覆盖率共同使用。
// 定义测试内存地址范围、Cache 容量及派生 Tag/Index 位宽，并启用功能覆盖宏。
// 调整容量时须同时考虑 RTL 固定四路和 16B 行的限制；此处内存区域是验证配置。
`ifndef I_CACHE_SIM_DEF
    `define I_CACHE_SIM_DEF

    `define _RTL_SIM_
    `define SIM_EN_FUNC_COVERAGE
    //`define SIM_ENV_DETAIL_PRINT
    
    
    //change the following three defines to cover each bit toggle of addr,
    //in the range of 32'h0 ~ 32'hffff_ffff
    `define SIM_SYS_MEM_SIZE    32*1024             //must >= 32KB
    `define SIM_SYS_MEM_BEG     32'h0F00_0000
    `define SIM_SYS_MEM_END     (`SIM_SYS_MEM_BEG + `SIM_SYS_MEM_SIZE - 1)

    `define I_CACHE_SIZE        4*1024
    `define INDEX_BITS          (($clog2(`I_CACHE_SIZE/4))-4)
    `define OFFSET_BITS         4
    `define TAG_BITS            (32-`INDEX_BITS-`OFFSET_BITS)
    `define TAG_MEM_DEPTH       (1<<`INDEX_BITS)
    `define TAG_MEM_WIDTH       (4*`TAG_BITS+4+3)

`endif
