
#include 	<stdint.h>
#include  "mrisc_common.h"
#include  "csr.c"


#define		user_dbase  (0x20000000+28*1024)
#define		sf_imme			4
#define		imme_12			0x123
#define		imme_20			0x54321


int main()
{
	uint32_t	*p_end;
	uint32_t	*p;
  uint32_t	data [17] = {0,1,2,3,4,5,6,7,8,-7,-6,-5,-4,-3,-2,-1,-8};
  uint32_t	res[16];
	volatile  uint32_t	csr;
	//uint32_t	csr;
	uint32_t	new_csr;
	
	
	p = (uint32_t *) user_dbase;
	initial_chk();
	
	//set mie bit in mstatus to 1
	set_bits_csr(0x300, (1<<3));
	csr = read_csr(0x300);
	if(csr != 0x00001808)
		err_exit();
	*p++ = csr;

	//r/w MIE csr
	csr = read_csr(0x304);
	if(csr != 0x00000000)
		err_exit();
	*p++ = csr;
		
	new_csr = (1<< 11) | (1<<7) | (1<<3);
	write_csr(0x304, new_csr);
	
	csr = read_csr(0x304);
	if(csr != new_csr)
		err_exit();
	*p++ = csr;

	//read MIP csr	
	csr = read_csr(0x344);
	if(csr != 0x00000000)
		err_exit();
	*p++ = csr;

	//csr access using immediate value
	asm volatile ("csrwi %0, %1" : : "i"(0x304), "i"(0x00));	//set MIE to 0x00
	csr = read_csr(0x304);
	if(csr != 0x00000000)
		err_exit();	
	*p++ = csr;
	
	asm volatile ("csrsi %0, %1" : : "i"(0x304), "i"(0x08));	//set MIE to 0x08
	csr = read_csr(0x304);
	if(csr != 0x00000008)
		err_exit();
	*p++ = csr;
	
	asm volatile ("csrci %0, %1" : : "i"(0x304), "i"(0x08));	//clear MIE to 0x00
	csr = read_csr(0x304);
	if(csr != 0x00000000)
		err_exit();
	*p++ = csr;


	//sim stop, write 0x73746f70 (stop) to 0xFFFFFFFC
  p_end = (uint32_t *)0xFFFFFFFC;
  *p_end = 0x73746f70;
    
  while(1){
  };
    
  return(0);
}

