#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include <riscv_types.h>
#include <riscv_helper.h>
#include <riscv_instr.h>

#include <core.h>

extern  FILE    *fp_main_exe, *fp_main_wb, *fp_other_exe, *fp_other_wb;


//trace for shift, arithmetic, logic, cmp operation before exe, rs1/rs2 from regs
void trc_salc_exe(rv_core_td *rv_core)
{
	
	FILE	*fp_exe;
	
	if(rv_core->in_trap == 0) {
		fp_exe = fp_main_exe;
	} else {
		fp_exe = fp_other_exe;
	}
		
	fprintf(fp_exe, "rd=r%0d, rs1=%08x, rs2=%08x, ", rv_core->rd, rv_core->x[rv_core->rs1], rv_core->x[rv_core->rs2]);	
}

//trace for shift, arithmetic, logic, cmp operation before exe, rs1 from regs, rs2 from sign_extend(imme)
void trc_salc_i_exe(rv_core_td *rv_core)
{
	
	FILE	*fp_exe;
	rv_int_xlen signed_immediate = SIGNEX_BIT_11(rv_core->immediate);
	
	if(rv_core->in_trap == 0) {
		fp_exe = fp_main_exe;
	} else {
		fp_exe = fp_other_exe;
	}
		
	fprintf(fp_exe, "rd=r%0d, rs1=%08x, rs2=%08x, ", rv_core->rd, rv_core->x[rv_core->rs1], signed_immediate);	
}


//trace for shift, arithmetic, logic, cmp operation before exe, rs1 from regs, rs2 from imme
void trc_salc_ui_exe(rv_core_td *rv_core)
{
	FILE	*fp_exe;
	
	if(rv_core->in_trap == 0) {
		fp_exe = fp_main_exe;
	} else {
		fp_exe = fp_other_exe;
	}
		
	fprintf(fp_exe, "rd=r%0d, rs1=%08x, rs2=%08x, ", rv_core->rd, rv_core->x[rv_core->rs1], rv_core->immediate);	
}


//trace for operations that will just update regs
void trc_reg_wb(rv_core_td *rv_core)
{
	
	FILE	*fp_exe, *fp_wb;
	
	if(rv_core->in_trap == 0) {
		fp_exe = fp_main_exe;
		fp_wb  = fp_main_wb;
	} else {
		fp_exe = fp_other_exe;
		fp_wb  = fp_other_wb;
	}
		
  fprintf(fp_exe, "res_reg=%08x\n", rv_core->x[rv_core->rd]);
  fprintf(fp_wb, "pc=%08x. write: r%0d=%08x;\n", rv_core->pc, rv_core->rd, rv_core->x[rv_core->rd]);
}


//trace for LUI/AUIPC operation before exe
void trc_la_exe(rv_core_td *rv_core)
{
	
	FILE	*fp_exe;
	
	if(rv_core->in_trap == 0) {
		fp_exe = fp_main_exe;
	} else {
		fp_exe = fp_other_exe;
	}
		
	fprintf(fp_exe, "rd=r%0d, imm=%08x, ", rv_core->rd, (rv_core->immediate << 12));	
}


//trace for JAL/JALR operation before exe
void trc_jal_exe(rv_core_td *rv_core)
{
	
	FILE	*fp_exe;
	
	if(rv_core->in_trap == 0) {
		fp_exe = fp_main_exe;
	} else {
		fp_exe = fp_other_exe;
	}
	
	if(rv_core->opcode == 0x6f)	//jal
		fprintf(fp_exe, "rd=r%0d, rs1=%08x, rs2=%08x, ", rv_core->rd, rv_core->pc, rv_core->jump_offset);	
	else												//jalr
		fprintf(fp_exe, "rd=r%0d, rs1=%08x, rs2=%08x, ", rv_core->rd, rv_core->x[rv_core->rs1], rv_core->jump_offset);	
}

//trace for operations that will update regs and pc
void trc_reg_pc_wb(rv_core_td *rv_core)
{
	
	FILE	*fp_exe, *fp_wb;
	
	if(rv_core->in_trap == 0) {
		fp_exe = fp_main_exe;
		fp_wb  = fp_main_wb;
	} else {
		fp_exe = fp_other_exe;
		fp_wb  = fp_other_wb;
	}
		
	fprintf(fp_exe, "res_reg=%08x, new_pc=%08x\n", rv_core->x[rv_core->rd], rv_core->next_pc);
	fprintf(fp_wb, "pc=%08x. write: r%0d=%08x;\n", rv_core->pc, rv_core->rd, rv_core->x[rv_core->rd]);
}

//trace for i-bus error response
void trc_ibus_err(rv_core_td* rv_core)
{

	FILE* fp_exe;

	if (rv_core->in_trap == 0) {
		fp_exe = fp_main_exe;
		//fp_wb = fp_main_wb;
	}
	else {
		fp_exe = fp_other_exe;
		//fp_wb = fp_other_wb;
	}

	fprintf(fp_exe, "pc=%08x. i-bus error resp.\n", rv_core->pc);
}




//map csr_addr(defined in risc-v stander) to mrisc cpu core self defined addr
uint32_t	csr_map(uint32_t	csr_addr)
{
	uint32_t	addr	;
	
	switch(csr_addr) {
		case 0x300:	addr = 1; break;	//mstatus
		case 0x304: addr = 2; break;	//mie
		case 0x344: addr = 3; break;	//mip
		case 0x305: addr = 4; break;	//mtvec
		case 0x341: addr = 5; break;	//mepc
		case 0x342: addr = 6; break;	//mcause
		case 0x343: addr = 7; break;	//mtval
		case 0x301: addr = 15;break;	//misa
		default: 	addr = 0; break;	//mrisc return 0x0000		
	}
	return(addr);
}
