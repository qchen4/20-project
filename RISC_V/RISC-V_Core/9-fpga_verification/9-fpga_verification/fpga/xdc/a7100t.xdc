################################################################
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

##################### clock define##############################
set_property PACKAGE_PIN R4 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]
create_clock -period 5.000 -name sys_clk_p -waveform {0.000 2.500} [get_ports sys_clk_p]

##################### key define ###############################
set_property PACKAGE_PIN J21 [get_ports sys_rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports sys_rst_n]

set_property PACKAGE_PIN E13 [get_ports key_in]
set_property IOSTANDARD LVCMOS33 [get_ports key_in]

#################### led define ################################
set_property PACKAGE_PIN B13 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]

set_property PACKAGE_PIN C13 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]

set_property PACKAGE_PIN D14 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]

set_property PACKAGE_PIN D15 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]


