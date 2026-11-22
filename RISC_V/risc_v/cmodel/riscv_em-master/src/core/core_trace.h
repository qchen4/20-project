#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include <riscv_types.h>
#include <riscv_instr.h>

#include <core.h>


void trc_salc_exe(rv_core_td *rv_core);
void trc_reg_wb(rv_core_td *rv_core);
void trc_la_exe(rv_core_td *rv_core);
void trc_jal_exe(rv_core_td *rv_core);
void trc_reg_pc_wb(rv_core_td *rv_core);
void trc_salc_i_exe(rv_core_td *rv_core);
void trc_salc_ui_exe(rv_core_td *rv_core);
uint32_t	csr_map(uint32_t	csr_addr);
