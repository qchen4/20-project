
#include 	<stdint.h>
#include	"mrisc_common.h"
#include	"csr.c"


#define		user_dbase  (0x20000000+28*1024)
#define		sf_imme			4
#define		imme_12			0x123
#define		imme_20			0x54321


int main()
{
	uint32_t	*p_end;
	uint32_t	*p;
	uint32_t	a, sum;
	uint32_t	data [16] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
  	volatile  uint32_t	csr;

  	initial_chk();
	set_bits_csr(0x300, (1<<3));	//set mie bits in mstatus to 1'b1
	set_bits_csr(0x304, (1<<3));	//set msie bits in mie to 1'b1
	
	for(int i=0; i<10; i++) {
		p = (uint32_t *)user_dbase;
		sum = 0;
		
    	for(int j=0; j<16; j++) {
    		a = data[j];
    	
    		if(j == 2)
    			set_bits_csr(0x344, (1<<3));	//trigger sw interrupt
    	
    		sum += a;
    	}    
    	
    	*p = sum;		
	
		if(sum != 120)
			err_exit();
	}


	//sim stop, write 0x73746f70 (stop) to 0xFFFFFFFC
  	p_end = (uint32_t *)0xFFFFFFFC;
  	*p_end = 0x73746f70;
    
  	while(1){
  	};
    
  return(0);
}

