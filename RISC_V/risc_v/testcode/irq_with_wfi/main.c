
#include 	<stdint.h>
#include	"mrisc_common.h"
#include	"csr.c"

extern void asm_sub_program();


int main()
{
	uint32_t	val	;
	uint32_t*	ptr	;
	
    initial_chk();
    
    /*
    val = 1 << 11;
    ptr = (uint32_t *)0x20000000;
    *ptr= val;
    */
    set_bits_csr(0x300, (1<<3));				//set mie bits in mstatus to 1'b1
	set_bits_csr(0x304, ((1<<11) | (1<<3)));	//set meie/msie bits in mie to 1'b1
	
	asm_sub_program();
	/*
	__asm__ __volatile__("nop");
	clr_bits_csr(0x304, val);		//clear meie bits in mie to 1'b0
	*/

	ok_exit();
	    
  return(0);
}

