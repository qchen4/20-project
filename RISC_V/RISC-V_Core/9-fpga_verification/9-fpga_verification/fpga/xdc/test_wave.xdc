


create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 8192 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list u_clk_pll_inst/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {u_riscv_inst/execute_instr[0]} {u_riscv_inst/execute_instr[1]} {u_riscv_inst/execute_instr[2]} {u_riscv_inst/execute_instr[3]} {u_riscv_inst/execute_instr[4]} {u_riscv_inst/execute_instr[5]} {u_riscv_inst/execute_instr[6]} {u_riscv_inst/execute_instr[7]} {u_riscv_inst/execute_instr[8]} {u_riscv_inst/execute_instr[9]} {u_riscv_inst/execute_instr[10]} {u_riscv_inst/execute_instr[11]} {u_riscv_inst/execute_instr[12]} {u_riscv_inst/execute_instr[13]} {u_riscv_inst/execute_instr[14]} {u_riscv_inst/execute_instr[15]} {u_riscv_inst/execute_instr[16]} {u_riscv_inst/execute_instr[17]} {u_riscv_inst/execute_instr[18]} {u_riscv_inst/execute_instr[19]} {u_riscv_inst/execute_instr[20]} {u_riscv_inst/execute_instr[21]} {u_riscv_inst/execute_instr[22]} {u_riscv_inst/execute_instr[23]} {u_riscv_inst/execute_instr[24]} {u_riscv_inst/execute_instr[25]} {u_riscv_inst/execute_instr[26]} {u_riscv_inst/execute_instr[27]} {u_riscv_inst/execute_instr[28]} {u_riscv_inst/execute_instr[29]} {u_riscv_inst/execute_instr[30]} {u_riscv_inst/execute_instr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {u_riscv_inst/execute_instr_addr[0]} {u_riscv_inst/execute_instr_addr[1]} {u_riscv_inst/execute_instr_addr[2]} {u_riscv_inst/execute_instr_addr[3]} {u_riscv_inst/execute_instr_addr[4]} {u_riscv_inst/execute_instr_addr[5]} {u_riscv_inst/execute_instr_addr[6]} {u_riscv_inst/execute_instr_addr[7]} {u_riscv_inst/execute_instr_addr[8]} {u_riscv_inst/execute_instr_addr[9]} {u_riscv_inst/execute_instr_addr[10]} {u_riscv_inst/execute_instr_addr[11]} {u_riscv_inst/execute_instr_addr[12]} {u_riscv_inst/execute_instr_addr[13]} {u_riscv_inst/execute_instr_addr[14]} {u_riscv_inst/execute_instr_addr[15]} {u_riscv_inst/execute_instr_addr[16]} {u_riscv_inst/execute_instr_addr[17]} {u_riscv_inst/execute_instr_addr[18]} {u_riscv_inst/execute_instr_addr[19]} {u_riscv_inst/execute_instr_addr[20]} {u_riscv_inst/execute_instr_addr[21]} {u_riscv_inst/execute_instr_addr[22]} {u_riscv_inst/execute_instr_addr[23]} {u_riscv_inst/execute_instr_addr[24]} {u_riscv_inst/execute_instr_addr[25]} {u_riscv_inst/execute_instr_addr[26]} {u_riscv_inst/execute_instr_addr[27]} {u_riscv_inst/execute_instr_addr[28]} {u_riscv_inst/execute_instr_addr[29]} {u_riscv_inst/execute_instr_addr[30]} {u_riscv_inst/execute_instr_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 32 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {u_riscv_inst/execute_op1[0]} {u_riscv_inst/execute_op1[1]} {u_riscv_inst/execute_op1[2]} {u_riscv_inst/execute_op1[3]} {u_riscv_inst/execute_op1[4]} {u_riscv_inst/execute_op1[5]} {u_riscv_inst/execute_op1[6]} {u_riscv_inst/execute_op1[7]} {u_riscv_inst/execute_op1[8]} {u_riscv_inst/execute_op1[9]} {u_riscv_inst/execute_op1[10]} {u_riscv_inst/execute_op1[11]} {u_riscv_inst/execute_op1[12]} {u_riscv_inst/execute_op1[13]} {u_riscv_inst/execute_op1[14]} {u_riscv_inst/execute_op1[15]} {u_riscv_inst/execute_op1[16]} {u_riscv_inst/execute_op1[17]} {u_riscv_inst/execute_op1[18]} {u_riscv_inst/execute_op1[19]} {u_riscv_inst/execute_op1[20]} {u_riscv_inst/execute_op1[21]} {u_riscv_inst/execute_op1[22]} {u_riscv_inst/execute_op1[23]} {u_riscv_inst/execute_op1[24]} {u_riscv_inst/execute_op1[25]} {u_riscv_inst/execute_op1[26]} {u_riscv_inst/execute_op1[27]} {u_riscv_inst/execute_op1[28]} {u_riscv_inst/execute_op1[29]} {u_riscv_inst/execute_op1[30]} {u_riscv_inst/execute_op1[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {u_riscv_inst/execute_op2[0]} {u_riscv_inst/execute_op2[1]} {u_riscv_inst/execute_op2[2]} {u_riscv_inst/execute_op2[3]} {u_riscv_inst/execute_op2[4]} {u_riscv_inst/execute_op2[5]} {u_riscv_inst/execute_op2[6]} {u_riscv_inst/execute_op2[7]} {u_riscv_inst/execute_op2[8]} {u_riscv_inst/execute_op2[9]} {u_riscv_inst/execute_op2[10]} {u_riscv_inst/execute_op2[11]} {u_riscv_inst/execute_op2[12]} {u_riscv_inst/execute_op2[13]} {u_riscv_inst/execute_op2[14]} {u_riscv_inst/execute_op2[15]} {u_riscv_inst/execute_op2[16]} {u_riscv_inst/execute_op2[17]} {u_riscv_inst/execute_op2[18]} {u_riscv_inst/execute_op2[19]} {u_riscv_inst/execute_op2[20]} {u_riscv_inst/execute_op2[21]} {u_riscv_inst/execute_op2[22]} {u_riscv_inst/execute_op2[23]} {u_riscv_inst/execute_op2[24]} {u_riscv_inst/execute_op2[25]} {u_riscv_inst/execute_op2[26]} {u_riscv_inst/execute_op2[27]} {u_riscv_inst/execute_op2[28]} {u_riscv_inst/execute_op2[29]} {u_riscv_inst/execute_op2[30]} {u_riscv_inst/execute_op2[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {reg_s10[0]} {reg_s10[1]} {reg_s10[2]} {reg_s10[3]} {reg_s10[4]} {reg_s10[5]} {reg_s10[6]} {reg_s10[7]} {reg_s10[8]} {reg_s10[9]} {reg_s10[10]} {reg_s10[11]} {reg_s10[12]} {reg_s10[13]} {reg_s10[14]} {reg_s10[15]} {reg_s10[16]} {reg_s10[17]} {reg_s10[18]} {reg_s10[19]} {reg_s10[20]} {reg_s10[21]} {reg_s10[22]} {reg_s10[23]} {reg_s10[24]} {reg_s10[25]} {reg_s10[26]} {reg_s10[27]} {reg_s10[28]} {reg_s10[29]} {reg_s10[30]} {reg_s10[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {test_case[0]} {test_case[1]} {test_case[2]} {test_case[3]} {test_case[4]} {test_case[5]} {test_case[6]} {test_case[7]} {test_case[8]} {test_case[9]} {test_case[10]} {test_case[11]} {test_case[12]} {test_case[13]} {test_case[14]} {test_case[15]} {test_case[16]} {test_case[17]} {test_case[18]} {test_case[19]} {test_case[20]} {test_case[21]} {test_case[22]} {test_case[23]} {test_case[24]} {test_case[25]} {test_case[26]} {test_case[27]} {test_case[28]} {test_case[29]} {test_case[30]} {test_case[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {u_riscv_inst/jump_addr[0]} {u_riscv_inst/jump_addr[1]} {u_riscv_inst/jump_addr[2]} {u_riscv_inst/jump_addr[3]} {u_riscv_inst/jump_addr[4]} {u_riscv_inst/jump_addr[5]} {u_riscv_inst/jump_addr[6]} {u_riscv_inst/jump_addr[7]} {u_riscv_inst/jump_addr[8]} {u_riscv_inst/jump_addr[9]} {u_riscv_inst/jump_addr[10]} {u_riscv_inst/jump_addr[11]} {u_riscv_inst/jump_addr[12]} {u_riscv_inst/jump_addr[13]} {u_riscv_inst/jump_addr[14]} {u_riscv_inst/jump_addr[15]} {u_riscv_inst/jump_addr[16]} {u_riscv_inst/jump_addr[17]} {u_riscv_inst/jump_addr[18]} {u_riscv_inst/jump_addr[19]} {u_riscv_inst/jump_addr[20]} {u_riscv_inst/jump_addr[21]} {u_riscv_inst/jump_addr[22]} {u_riscv_inst/jump_addr[23]} {u_riscv_inst/jump_addr[24]} {u_riscv_inst/jump_addr[25]} {u_riscv_inst/jump_addr[26]} {u_riscv_inst/jump_addr[27]} {u_riscv_inst/jump_addr[28]} {u_riscv_inst/jump_addr[29]} {u_riscv_inst/jump_addr[30]} {u_riscv_inst/jump_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {u_riscv_inst/wr_reg_data[0]} {u_riscv_inst/wr_reg_data[1]} {u_riscv_inst/wr_reg_data[2]} {u_riscv_inst/wr_reg_data[3]} {u_riscv_inst/wr_reg_data[4]} {u_riscv_inst/wr_reg_data[5]} {u_riscv_inst/wr_reg_data[6]} {u_riscv_inst/wr_reg_data[7]} {u_riscv_inst/wr_reg_data[8]} {u_riscv_inst/wr_reg_data[9]} {u_riscv_inst/wr_reg_data[10]} {u_riscv_inst/wr_reg_data[11]} {u_riscv_inst/wr_reg_data[12]} {u_riscv_inst/wr_reg_data[13]} {u_riscv_inst/wr_reg_data[14]} {u_riscv_inst/wr_reg_data[15]} {u_riscv_inst/wr_reg_data[16]} {u_riscv_inst/wr_reg_data[17]} {u_riscv_inst/wr_reg_data[18]} {u_riscv_inst/wr_reg_data[19]} {u_riscv_inst/wr_reg_data[20]} {u_riscv_inst/wr_reg_data[21]} {u_riscv_inst/wr_reg_data[22]} {u_riscv_inst/wr_reg_data[23]} {u_riscv_inst/wr_reg_data[24]} {u_riscv_inst/wr_reg_data[25]} {u_riscv_inst/wr_reg_data[26]} {u_riscv_inst/wr_reg_data[27]} {u_riscv_inst/wr_reg_data[28]} {u_riscv_inst/wr_reg_data[29]} {u_riscv_inst/wr_reg_data[30]} {u_riscv_inst/wr_reg_data[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 5 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {u_riscv_inst/wr_reg_addr[0]} {u_riscv_inst/wr_reg_addr[1]} {u_riscv_inst/wr_reg_addr[2]} {u_riscv_inst/wr_reg_addr[3]} {u_riscv_inst/wr_reg_addr[4]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 32 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {reg_s11[0]} {reg_s11[1]} {reg_s11[2]} {reg_s11[3]} {reg_s11[4]} {reg_s11[5]} {reg_s11[6]} {reg_s11[7]} {reg_s11[8]} {reg_s11[9]} {reg_s11[10]} {reg_s11[11]} {reg_s11[12]} {reg_s11[13]} {reg_s11[14]} {reg_s11[15]} {reg_s11[16]} {reg_s11[17]} {reg_s11[18]} {reg_s11[19]} {reg_s11[20]} {reg_s11[21]} {reg_s11[22]} {reg_s11[23]} {reg_s11[24]} {reg_s11[25]} {reg_s11[26]} {reg_s11[27]} {reg_s11[28]} {reg_s11[29]} {reg_s11[30]} {reg_s11[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list u_riscv_inst/jump_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list key_out]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list u_riscv_inst/wr_reg_en]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets sys_clk]
