
#include 	<stdio.h>
#include 	<stdint.h>
#include 	"mrisc_common.h"
#include	"csr.c"


static inline void illegal_intr_isr();

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
	if(tmp == 2)
		illegal_intr_isr();
}

void __attribute__((interrupt)) sw_intr_isr(void)
{	

	sw_intr_cnt++;
}

void __attribute__((interrupt)) timer_intr_isr(void)
{
	timer_intr_cnt++;
}

void __attribute__((interrupt)) ext_intr_isr(void)
{
	ext_intr_cnt++;
}


static inline void illegal_intr_isr()
{
	uint32_t	tmp	;
	tmp = read_csr(0x341);	//read mepc
	tmp += 4;
	write_csr(0x341, tmp);
}
