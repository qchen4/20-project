
#include <stdint.h>

int main()
{
    int     a,b,c;
    int     *p = (int *)0x20000000;
    int			data [16] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
	int			sum = 0;
	uint32_t	*p_end;
		
	//write out
    p = (int *)0x20000200;
    for(int i=0; i<16; i++) {
    	*p = data[i];
    	p++;
    }

    //read back and sum
    p = (int *)0x20000200;
    for(int i=0; i<16; i++) {
    	a = *p;
    	sum += a;
    	p++;
    }    
    *p = sum;
    
	//copy to another location    
    p = (int *)0x20000100;
    for(int i=0; i<16; i++) {
    	*p = data[i];
    	p++;
    }
    
    
	//sim stop, write 0x73746f70 (stop) to 0xFFFFFFFC
  	p_end = (uint32_t *)0xFFFFFFFC;
  	*p_end = 0x73746f70;
    
    while(1){
    };
    
    return(0);
}

