#ifndef RISCV_CORE_H
#define RISCV_CORE_H

#include "riscv_types.h"

#include "csr.h"
#include "pmp.h"
#include "trap.h"
#include "clint.h"
#include "riscv_config.h"

#define NR_RVI_REGS 32

typedef struct rv_core_struct rv_core_td;

#include "mmu.h"

typedef struct rv_core_struct
{
    /* Registers */
    rv_uint_xlen x[NR_RVI_REGS];
    rv_uint_xlen pc;
    rv_uint_xlen next_pc;
    rv_uint_xlen cur_pc;

    uint32_t instruction;
    uint8_t opcode;
    uint8_t rd;
    uint8_t rs1;
    uint8_t rs2;
    uint8_t func3;
    uint8_t func7;
    uint8_t func6;
    uint8_t func5;
    uint16_t func12;
    rv_uint_xlen immediate;
    rv_uint_xlen jump_offset;

    uint8_t sync_trap_pending;
    rv_uint_xlen sync_trap_cause;
    rv_uint_xlen sync_trap_tval;

    /* points to the next instruction */
    void (*execute_cb)(rv_core_td *rv_core);

    /* externally hooked */
    void *priv;
    bus_access_func bus_access;
    // bus_read_mem read_mem;
    // bus_write_mem write_mem;

    csr_reg_td csr_regs[CSR_ADDR_MAX+1];
    pmp_td pmp;
    trap_td trap;
    mmu_td mmu;

    int lr_valid;
    rv_uint_xlen lr_address;

    //add by yyx
    uint8_t  in_trap;   //0: main code; 1: in exception/interrupt handle code
    uint8_t  wfi_sleep;
    privilege_level curr_priv_mode;
    uint64_t curr_cycle;
    uint8_t  ext_irq_pending;
    uint8_t  irq_wait_cyc;

    id_bus_err_cfg_t idbus_err_map[128];    //maximal load 128 configurations
    uint32_t idbus_err_num;
    ext_irq_cfg_t ext_irq_cfg[128];         //maximal load 128 configurations
    uint32_t ext_irq_cfg_num;
} rv_core_td;

void rv_core_run(rv_core_td *rv_core);
void rv_core_process_interrupts(rv_core_td *rv_core, uint8_t mei, uint8_t mti, uint8_t msi);
void rv_core_reg_dump(rv_core_td *rv_core);
void rv_core_reg_dump_more_regs(rv_core_td *rv_core);
void rv_core_init(rv_core_td *rv_core,
                  void *priv,
                  bus_access_func bus_access,
                  char* idbus_cfg_file_name,
                  char* ext_irq_cfg_file_name
                  );

typedef struct instruction_hook_struct
{
    void (*preparation_cb)(rv_core_td *rv_core, int32_t *next_subcode);
    void (*execution_cb)(rv_core_td *rv_core_data);
    struct instruction_desc_struct *next;

} instruction_hook_td;

typedef struct instruction_desc_struct
{
    unsigned int instruction_hook_list_size;
    instruction_hook_td *instruction_hook_list;

} instruction_desc_td;
#define INIT_INSTRUCTION_LIST_DESC(_instruction_list) \
    static instruction_desc_td  _instruction_list##_desc = \
    { sizeof(_instruction_list)/sizeof(_instruction_list[0]), _instruction_list }

#endif /* RISCV_CORE_H */
