
#include 	<stdint.h>
#include  "mrisc_common.h"
#include  "csr.c"

#define		user_dbase  (0x20000000+28*1024)
#define		sf_imme			4
#define		imme_12			0x123
#define		imme_20			0x54321


extern void asm_sub_program();

int main()
{

	initial_chk();
    asm_sub_program();

	ok_exit();

  	return(0);
}

