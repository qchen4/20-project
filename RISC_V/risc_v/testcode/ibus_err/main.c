
#include 	<stdint.h>
#include	"mrisc_common.h"
#include	"csr.c"

extern void asm_sub_program();


int main()
{
    initial_chk();
    asm_sub_program();

	ok_exit();
	    
  return(0);
}

