`ifndef SKY_RAND_CTRL_SVH
`define SKY_RAND_CTRL_SVH
class sky_rand_ctrl;

  tvip_delay_configuration  delay_cfg ;
  rand int                  num       ;

  //`tvip_delay_constraint defined in file: tvip_common_macros.svh
  constraint  c_num {
    `tvip_delay_constraint(num, delay_cfg)
  }

  function new();
  endfunction : new


endclass;

`endif

