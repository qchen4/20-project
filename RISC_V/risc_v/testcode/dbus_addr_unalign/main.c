
#include 	<stdint.h>
#include	"mrisc_common.h"
#include	"csr.c"

extern void asm_sub_program();


int main()
{
    initial_chk();
    set_bits_csr(0x300, (1<<3));				//set mie bits in mstatus to 1'b1
	set_bits_csr(0x304, ((1<<11) | (1<<3)));	//set meie/msie bits in mie to 1'b1
    asm_sub_program();

	ok_exit();
	    
  return(0);
}

