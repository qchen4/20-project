
set UVM_src      C:/eda_tools/questasim64_10.6c/verilog_src/uvm-1.1d/src

## en_coverage = 0: disable coverage to save sim time;
## en_coverage = 1: enable coverage and save coverage data;
set en_coverage  0

##----- Part A: select uvm testcase ---------##
set test_name "i_cache_init_test_8b"
## set test_name "i_cache_init_test_16b"
## set test_name "i_cache_init_test_32b"
## set test_name "i_cache_op_test_slv_0_wait"
## set test_name "i_cache_op_test"
## set test_name "i_cache_op_en_test_slv_0_wait"
## set test_name "i_cache_op_en_test"
## set test_name "i_cache_op_en_err_test"
## set test_name "i_cache_rand_test"


set cov_save_name ${test_name}


##----- Part B: compile and run sim ---------##
##compile DUT and env
if {${en_coverage} == 0} {
    vlog -sv12compat -mfcu -work ./cache_dut -f flist_dut.f
    vlog -sv12compat -vopt -mfcu +incdir+$UVM_src -L mtiUvm -f flist_env.f
} else {
    vlog -sv12compat -mfcu +cover=sbcetf -work ./cache_dut -f flist_dut.f
    vlog -sv12compat -vopt -mfcu +incdir+$UVM_src -L mtiUvm +define+SIM_EN_COVERAGE -f flist_env.f
}


set current_time [clock seconds]
set seed $current_time

if {${en_coverage} == 0} {
    ##--don't save coverage data
    vsim -c -sv_seed $seed +UVM_TESTNAME=${test_name} +nowarnTSCALE -vopt -voptargs=+acc -classdebug  \
        -L ./cache_dut -L ./work -l load.log tb
} else {
    ##--save coverage of each testcase
    vsim -c -sv_seed $seed +UVM_TESTNAME=${test_name} -coverage -coverstore ./coverage -testname ${cov_save_name} +nowarnTSCALE  \
      -vopt -voptargs=+acc -L ./cache_dut -L ./work -l load.log tb
}

radix hex
add log -r /tb/*
do ./wave.do
run -all


