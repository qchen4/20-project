//--- sim tb include path
+incdir+../env

//--- used package include path
+incdir+../sky_base_pkg

//apb VIP
+incdir+../amiq_apb/sv

//AXI VIP
+incdir+../axi4_uvm_vip/tue/src
+incdir+../axi4_uvm_vip/tvip-common/src
+incdir+../axi4_uvm_vip/src


//defines needed by APB VIP
+define+AMIQ_APB_ADDR_BITS=7

//--- used packages
../sky_base_pkg/sky_base_pkg.sv

//APB VIP
../amiq_apb/sv/amiq_apb_pkg.sv

//AXI VIP
../axi4_uvm_vip/tue/src/tue_pkg.sv
../axi4_uvm_vip/tvip-common/src/tvip_common_pkg.sv
../axi4_uvm_vip/src/tvip_sky_axi_pkg.sv

//--- DUT test enviroment
../env/cdma_env_pkg_import.sv
//--- VIP usage sample code
../amiq_apb/user/amiq_apb_user_coverage.sv
../axi4_uvm_vip/env/tvip_axi_sample_configuration.svh

../env/cdma_cmd_types.sv
../env/cdma_misc_if.sv
../env/cdma_cmd_driver.sv
../env/cdma_cmd_parse_agent.sv
../env/cdma_reg_model.sv
../env/amiq_apb2rm_adapter.sv
../env/cdma_virtual_sequencer.sv
../env/cdma_scoreboard.sv
../env/cdma_cmd_coverage.sv
../env/cdma_axi_coverage.sv
../env/cdma_env.sv


//--- DUT test sequence and testcase
../env/cdma_cmd_base_sequence.sv
../env/cdma_virtual_sequence.sv
../env/cdma_reg_test_seq.sv
../env/cdma_dma_seq1.sv
../env/cdma_dma_byte_offset_seq.sv

../env/cdma_base_test.sv
../env/cdma_reg_test.sv
../env/cdma_dma_test1.sv
../env/cdma_dma_byte_offset_test.sv
../env/cdma_dma_addr_high_test.sv
../env/cdma_dma_rand_test.sv
../env/cdma_performance_test.sv


//--- TB top
../env/test.sv
../env/tb.sv

