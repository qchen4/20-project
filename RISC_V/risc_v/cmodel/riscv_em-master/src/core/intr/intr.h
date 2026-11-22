
#ifndef RISCV_INTR_H
#define RISCV_INTR_H

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "riscv_types.h"
#include "riscv_helper.h"
#include "riscv_instr.h"
#include "core.h"

void chk_pending_intr(rv_core_td *rv_core);
void mret_proc(rv_core_td *rv_core);
void chk_to_set_ext_irq(rv_core_td* rv_core, uint8_t chk_mode);
void set_ext_irq(rv_core_td* rv_core);

#endif
