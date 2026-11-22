
#include <stdint.h>

#include  "csr.c"
#include  "mrisc_common.h"

__attribute__((noinline)) void err_exit()
{
	uint32_t	*p_end;
	
	//sim stop, write 0x00657272 (err) to 0xFFFFFFFC
  p_end = (uint32_t *)END_WRITE_BASE;
  *p_end = 0x00657272;
}


__attribute__((noinline)) void ok_exit()
{
	uint32_t	*p_end;
	//sim stop, write 0x73746f70 (stop) to 0xFFFFFFFC
  p_end = (uint32_t *)END_WRITE_BASE;
  *p_end = 0x73746f70;
}


//for c code debug info print
__attribute__((noinline)) void mrisc_dbg(uint32_t	dbg_num){
	

	uint32_t	*dbg = (uint32_t *)DBG_WRITE_BASE;
	
	*dbg = dbg_num;

}

//for performance evaluate(cyc_num print in rtl sim) print
__attribute__((noinline)) void mrisc_pdbg(uint32_t	p_num){
	
	uint32_t	*dbg = (uint32_t *)PDBG_WRITE_BASE;
	
	*dbg = p_num;
}


__attribute__((noinline)) void initial_chk() {
	
	volatile  uint32_t	csr;
	uint32_t	*p;

	//read misa
	csr = read_csr(0x301);
	if(csr != 0x40001100UL)	//RV32IM
		err_exit();
	
	//read mstatus
	csr = read_csr(0x300);
	if(csr != 0x00001800)	//machine mode
		err_exit();	
	
	write_csr(0x305, (0x40 | 0x01));	//mtvec, vectored mode
}


/*
int32_t	my_strcmp(const char *s1, const char *s2)
{
	uint8_t		c1, c2;
	uint32_t	i	= 0;
	
	do {
		c1 = s1[i];
		c2 = s2[i++];
		
		if(c1 < c2)
			return(-1);
		else if(c1 > c2)
			return(1);
	}while(c1 != '\0');
	
	return(0);
}
*/

