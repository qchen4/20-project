
#include "intr.h"


void chk_to_set_ext_irq(rv_core_td* rv_core, uint8_t chk_mode)
{
	uint32_t		i;
	ext_irq_cfg_t	cfg;

	for (i = 0; i < rv_core->ext_irq_cfg_num; i++) {
		cfg = rv_core->ext_irq_cfg[i];
		if (chk_mode == cfg.mode) {
			switch (cfg.mode) {
			case 0:	//wait cycle number
				if (rv_core->curr_cycle == cfg.val) {
					rv_core->ext_irq_pending = 1;
					rv_core->irq_wait_cyc = cfg.wait_cyc;
				}
				break;

			case 1:	//wait PC value
				if (rv_core->cur_pc == cfg.val) {
					rv_core->ext_irq_pending = 1;
					rv_core->irq_wait_cyc = cfg.wait_cyc;
				}
				break;

			case 2: //wait opcode value
				if (rv_core->instruction == cfg.val) {
					rv_core->ext_irq_pending = 1;
					rv_core->irq_wait_cyc = cfg.wait_cyc;
				}
			}
		}
	}
}


void set_ext_irq(rv_core_td* rv_core)
{
	if (rv_core->ext_irq_pending) {
		if (rv_core->irq_wait_cyc == 0) {
			rv_core->csr_regs[0x344].value |= (1 << 11);	//set MEIP in mip
			rv_core->ext_irq_pending = 0;
		} else {
			rv_core->irq_wait_cyc--;
		}
	}
}


void	chk_pending_intr(rv_core_td *rv_core)
{
	rv_uint_xlen	mstatus = rv_core->csr_regs[CSR_ADDR_MSTATUS].value;
	rv_uint_xlen	mie	= rv_core->csr_regs[CSR_ADDR_MIE].value;
	rv_uint_xlen	mip = rv_core->csr_regs[CSR_ADDR_MIP].value;
	
	rv_uint_xlen	intrs = mie & mip;
	rv_uint_xlen	mtvec = rv_core->csr_regs[CSR_ADDR_MTVEC].value;
	rv_uint_xlen	mcause, tmp;

	//1: find pending exception or interrupt
	//synchronous exception has higher priority than interrupt
	if (rv_core->sync_trap_pending) {
		mcause = rv_core->sync_trap_cause;
		rv_core->csr_regs[CSR_ADDR_MEPC].value = rv_core->cur_pc;	//update mepc
		rv_core->sync_trap_pending = 0;
	} else if ((intrs != 0) && ((mstatus & 0x08) != 0)) {	//mie bit in mstatus is enabled and there is pending intrs(not exception)		
		rv_core->csr_regs[CSR_ADDR_MEPC].value = rv_core->pc;		//update mepc
		rv_core->wfi_sleep = 0;

		if ((mip & (1 << 7)) != 0) {		//timer intr
			mcause = (1 << 31) | 7;
			//rv_core->csr_regs[0x344].value &= ~(1 << 7);	//clear MTIP in MIP; change to isr to clear
		} else if ((mip & (1 << 11)) != 0) {	//external intr
			mcause = (1 << 31) | 11;
			rv_core->csr_regs[CSR_ADDR_MIP].value &= ~(1 << 11);	//clear MEIP in MIP; in HW, MEIP is self cleared when ext_irq=0.
		} else if ((mip & (1 << 3)) != 0) {	//sw intr
			mcause = (1 << 31) | 3;
			//rv_core->csr_regs[0x344].value &= ~(1 << 3);	//clear MSIP in MIP; change to isr to clear
		} else {							//can't happen now
			mcause = 0;
			return;
		}
	} else {								//no pending exception or interrupt
		return;
	}

	//update mie/mpie bits in mstatus
	tmp = (mstatus & (1 << 3)) >> 3;	//get mie bit
	mstatus &=  (~(1<<3));		//clear mie bits to 0
	mstatus &=  (~(1<<7));		//clear mpie bits to 0
	mstatus |=  (tmp <<7);		//set mpie bits to mie
	mstatus |=  (3<<11);		//set mpp bits to 3(machine mode)
	rv_core->csr_regs[CSR_ADDR_MSTATUS].value = mstatus;
	rv_core->csr_regs[CSR_ADDR_MCAUSE].value = mcause;		//update mcause

	if((mcause == 0x04) || (mcause == 0x05) || (mcause == 0x06) || (mcause == 0x07))	//HW only update mtval when D-bus error, D-bus addr unalign exception.
		rv_core->csr_regs[CSR_ADDR_MTVAL].value = rv_core->sync_trap_tval;

	//update PC
	if (mcause >> 31) {	//interrupt
		if ((mtvec & 0x01) != 0) {	//vectored mode			
			rv_core->pc = (mtvec & (~0x03)) + ((mcause & 0xffff) << 2);
		}
		else {
			rv_core->pc = (mtvec & (~0x03));
		}
	} else {			//sync exception
		rv_core->pc = (mtvec & (~0x03));
	}
	rv_core->in_trap = 1;
}


void	mret_proc(rv_core_td *rv_core) {
	rv_uint_xlen	tmp	;
	uint8_t			flag;
	
	//restore mie bits in mstatus and set mpie to 1
	tmp 	= rv_core->csr_regs[CSR_ADDR_MSTATUS].value;
	flag 	= (tmp >> 7) & 0x01;	//get mpie bit
	tmp		&= (~(1 << 3));			//clear mie bits to 0
	tmp		= tmp | (flag << 3) | (1 << 7);	//restore mie to mpie and set mpie to 1
	rv_core->csr_regs[CSR_ADDR_MSTATUS].value = tmp;
	
	//restore PC before go in trap
	rv_core->next_pc = rv_core->csr_regs[CSR_ADDR_MEPC].value;	//pc=mepc
}

