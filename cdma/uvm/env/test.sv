
function void uvm_env_glb_setting();
    //chang to print all element in the array
    uvm_default_printer.knobs.begin_elements = -1;

endfunction : uvm_env_glb_setting


program automatic test (amiq_apb_if     apb_inf, 
                        tvip_axi_slv_if axi_inf,
                        cdma_misc_if    cdma_misc_if
);

  initial begin
    $display("Simulation begin.");
    $display("");

    uvm_env_glb_setting();

    //test env configure
    uvm_config_db#(amiq_apb_vif_t)::set(null, "*", "apb_vif", apb_inf);
    uvm_config_db#(tvip_axi_slv_vif)::set(null, "*", "axi_vif", axi_inf);
    uvm_config_db#(cdma_misc_vif)::set(null, "*", "cdma_vif", cdma_misc_if);

    run_test();
  end

endprogram : test


