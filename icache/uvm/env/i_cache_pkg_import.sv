// 文件说明 i_cache_pkg_import.sv
// 导入 UVM、AHB VIP、AMBA 和 sky 基础包及公共宏。
// 位于项目类文件之前编译，使后续验证源码可以引用共享事务、接口类型与工具。

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "sim_define.v"

import yuu_common_pkg::*;
import yuu_amba_pkg::*;
import yuu_ahb_pkg::*;
import sky_base_pkg::*;

