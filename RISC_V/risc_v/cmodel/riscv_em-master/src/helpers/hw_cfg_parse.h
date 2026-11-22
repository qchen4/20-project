#ifndef HW_CFG_PARSE_H
#define HW_CFG_PARSE_H

#include <stdint.h>
#include "core.h"

void idbus_err_cfg_parse(rv_core_td* rv_core, char* cfg_file);
void ext_irq_cfg_parse(rv_core_td *rv_core, char *cfg_file);

#endif