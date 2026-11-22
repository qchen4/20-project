
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

	//test illegal instructions
  asm volatile (
     //illegal instryction: 0x12345678
     ".4byte 0x12345678\n\t"
     ".4byte 0x87654321\n\t"
     :
     :
     : "memory"
  );


	//sim stop, write 0x73746f70 (stop) to 0xFFFFFFFC
  p_end = (uint32_t *)0xFFFFFFFC;
  *p_end = 0x73746f70;
    
  while(1){
  };
    
  return(0);
}

