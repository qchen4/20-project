// 文件说明 test.sv
// UVM 启动 program，将顶层三个接口句柄注入 uvm_config_db。
// mas_vif 对应 CPU 侧，slv_vif 对应存储器侧，misc_vif 用于使能驱动与状态观察。
// 调用 run_test，由命令行 UVM_TESTNAME 选择具体测试类。

program automatic test (yuu_ahb_master_interface    m_ahb, 
                        yuu_ahb_slave_interface     s_ahb,
                        i_cache_misc_interface      dut_misc);

  initial begin
    $display("Simulation begin.");
    $display("");

    //test env configure
    uvm_config_db#(yuv_ahb_mas_vif)::set(null, "uvm_test_top", "mas_vif", m_ahb);
    //uvm_config_db#(yuv_ahb_mas_vif)::set(null, "*", "mas_vif", m_ahb);
    uvm_config_db#(yuv_ahb_slv_vif)::set(null, "uvm_test_top", "slv_vif", s_ahb);

    uvm_config_db#(i_cache_misc_vif)::set(null, "*", "misc_vif", dut_misc);

    run_test();
  end

endprogram : test


