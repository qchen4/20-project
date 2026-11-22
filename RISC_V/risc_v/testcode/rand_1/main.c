
#include 	<stdint.h>
#include	"mrisc_common.h"
#include	"csr.c"

extern void asm_sub_program();


int main()
{
    initial_chk();
    set_bits_csr(0x300, (0<<3));				//set mie bits in mstatus to 1'b0
	set_bits_csr(0x304, ((1<<11) | (0<<3)));	//set meie=1/msie=0 bits in mie
    asm_sub_program();

	ok_exit();
	    
  return(0);
}

