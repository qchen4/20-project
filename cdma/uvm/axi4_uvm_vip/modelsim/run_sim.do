
set UVM_src      C:/eda_tools/qsim10.6c/verilog_src/uvm-1.1d/src

## set test_name "sky_axi_master_slave_sample_test"
## set test_name "sky_axi_mas_slv_0_delay_test"
set test_name "sky_axi_mas_slv_small_delay_test"
## set test_name "sky_axi_mas_slv_big_delay_test"

##--- dump waveform and debug mode ---##
vlog -sv12compat -mfcu +incdir+$UVM_src -L mtiUvm -f flist.f

vsim -c +UVM_TESTNAME=${test_name} +nowarnTSCALE -voptargs=+acc -classdebug -L ./work -l load.log tb
radix hex
add log -r /tb/*
do ./wave.do
run -all


