
#include 	<stdio.h>
#include 	<stdint.h>
#include 	"mrisc_common.h"
#include	"csr.c"


void illegal_intr_isr();
void ibus_err_isr();
void ebreak_intr_isr();
void ecall_intr_isr();
void dbus_addr_misalign_isr();
void dbus_err_isr();

uint32_t	sync_exp_cnt = 0;
uint32_t	sw_intr_cnt = 0;
uint32_t	timer_intr_cnt = 0;
uint32_t	ext_intr_cnt = 0;

// 中断服务例程 (ISR)
void __attribute__((interrupt)) sync_exp_isr(void)
{
	uint32_t	tmp	;
	
	sync_exp_cnt++;
	tmp = read_csr(0x342);	//read mcause
	if(tmp == 1)
		ibus_err_isr();
	else if(tmp == 2)
		illegal_intr_isr();
	else if(tmp == 3)
		ebreak_intr_isr();
	else if(tmp == 11)
		ecall_intr_isr();		
	else if((tmp == 4) || (tmp == 6))
		dbus_addr_misalign_isr();
	else if((tmp == 5) || (tmp == 7))
		dbus_err_isr();
}

void __attribute__((interrupt)) sw_intr_isr(void)
{	
	clr_bits_csr(0x344, (1<<3));	//clear msip bit in mip
	sw_intr_cnt++;
}

void __attribute__((interrupt)) timer_intr_isr(void)
{
	timer_intr_cnt++;
}

void __attribute__((interrupt)) ext_intr_isr(void)
{
	uint32_t	*p;
	
  	p = (uint32_t *)EXT_IRQ_CLR_ADDR;	
  	*p= 0x00;						//clear ext_irq interrupt
	ext_intr_cnt++;
}


void illegal_intr_isr()
{
	uint32_t	tmp	;
	tmp = read_csr(0x341);	//read mepc
	tmp += 4;				//change PC to next instr
	write_csr(0x341, tmp);
}

void ibus_err_isr()
{
	uint32_t	tmp	;
	tmp = read_csr(0x341);	//read mepc
	tmp += 4;				//change PC to next instr
	write_csr(0x341, tmp);	
}

void ebreak_intr_isr()
{
	uint32_t	tmp	;
	tmp = read_csr(0x341);	//read mepc
	tmp += 4;	
	write_csr(0x341, tmp);	//change to next PC
}

void ecall_intr_isr()
{
	uint32_t	tmp	;
	tmp = read_csr(0x341);	//read mepc
	tmp += 4;	
	write_csr(0x341, tmp);	//change to next PC
}

void dbus_addr_misalign_isr()
{
	uint32_t	tmp;
	//__asm__ __volatile__("nop");
	
	tmp = read_csr(0x343);	//read mtval, bus addr
	tmp = read_csr(0x341);	//read mepc
	tmp += 4;				//change PC to next instr
	write_csr(0x341, tmp);
}

void dbus_err_isr()
{
	uint32_t	tmp	;
	
	tmp = read_csr(0x343);	//read mtval, bus addr
	tmp = read_csr(0x341);	//read mepc
	tmp += 4;				//change PC to next instr
	write_csr(0x341, tmp);
}
