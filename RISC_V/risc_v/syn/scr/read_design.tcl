##------------------------------##
#       read in designs          #
##------------------------------##


analyze -format verilog -define $syn_define_list -vcs "-f ./flist.f"

##--- read in synthesised sub modules
read_verilog -netlist ../syn_submodule/exe_addsub/result/mrisc_exe_addsub_p2_naming.vnet
read_verilog -netlist ../syn_submodule/exe_mul/result/mrisc_exe_mul_p2_naming.vnet
read_verilog -netlist ../syn_submodule/exe_div/result/mrisc_exe_div_p2_naming.vnet
read_verilog -netlist ../syn_submodule/ifetch/result/mrisc_ifetch_p2_naming.vnet

elaborate $top

current_design   $top
link
uniquify

