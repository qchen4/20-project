-timescale=1ns/100ps
//-------------------------------------
// C Define 
//-------------------------------------

//-------------------------------------
// C Include 
//-------------------------------------

//-------------------------------------
// C Filelist
//-------------------------------------

//-------------------------------------
// SV Define
//-------------------------------------
+define+YUU_UVM
+define+YUU_AHB_MAX_MASTER_NUM=1
+define+YUU_AHB_MAX_SLAVE_NUM=1
+define+YUU_AHB_MAX_ADDR_WIDTH=32
+define+YUU_AHB_MAX_DATA_WIDTH=32

//-------------------------------------
// SV Include
//-------------------------------------
+incdir+../yuu_ahb/pkg/yuu_common/include
+incdir+../yuu_ahb/pkg/yuu_common/src/sv
+incdir+../yuu_ahb/pkg/yuu_amba/include
+incdir+../yuu_ahb/pkg/yuu_amba/src/sv
+incdir+../yuu_ahb/include
+incdir+../yuu_ahb/src/sv
+incdir+../yuu_ahb/test
+incdir+../sky_base_pkg
+incdir+../env

//-------------------------------------
// SV Filelist
//-------------------------------------
../yuu_ahb/pkg/yuu_common/include/yuu_common_pkg.sv
../yuu_ahb/pkg/yuu_amba/include/yuu_amba_pkg.sv
../yuu_ahb/include/yuu_ahb_pkg.sv
../sky_base_pkg/sky_base_pkg.sv

../env/i_cache_pkg_import.sv

../env/i_cache_types.sv
../env/i_cache_misc_interface.sv
../env/i_cache_en_item.sv
../env/i_cache_en_agent.sv
../env/i_cache_en_base_seq.sv
../env/i_cache_en_rand_seq.sv
../env/i_cache_virtual_sequencer.sv
../env/i_cache_dut_monitor.sv
../env/i_cache_scb.svp
../env/i_cache_coverage.sv
../env/m_ahb_cyc_coverage.sv
../env/i_cache_env.sv
../env/i_cache_mas_base_seq.sv
../env/i_cache_slv_base_seq.sv
../env/i_cache_slv_0_wait_seq.sv
../env/i_cache_slv_err_resp_seq.sv
../env/i_cache_virtual_sequence.sv
../env/i_cache_base_test.sv

//-------------------------------------
// Case List
//-------------------------------------
../env/i_cache_init_test.sv
../env/i_cache_op_test.sv
../env/i_cache_op_en_test.sv
../env/i_cache_op_en_err_test.sv
../env/i_cache_rand_test.sv

//-------------------------------------
// Sim top module
//-------------------------------------
../env/test.sv
../env/tb.sv

