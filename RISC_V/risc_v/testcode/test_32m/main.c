
#include 	<stdint.h>
#include  "mrisc_common.h"

//typedef  	uint32_t		var_type;
//typedef  	int32_t			var_type;
//typedef  	uint16_t		var_type;
typedef  	int16_t			var_type;
//typedef  	uint8_t			var_type;
//typedef  	int8_t			var_type;

#define		user_dbase  (0x20000000+28*1024)
#define		sf_imme			4

int main()
{
	uint32_t	*p_end;
	var_type	*p;
  	var_type	data [17] = {0,125,200,3,412,55,6,79,8,-255,-128,-32,-16,-8,-4,-1,-8};
  	var_type	res[16];

	//test shift/arithmetic/logic/cmp instructions
	p = (var_type *) user_dbase;
	initial_chk();
	
	for(int j=0; j<3; j++) {
		for(int i=0; i<16; i++) {
			switch(j) {
			case 0:	//mul
				res[i] = data[i] * data[i+1];
				break;
			case 1: //div
				res[i] = data[i] / data[i+1];
				break;
			case 2: //rem
				res[i] = data[i] % data[i+1];
				break;
				
			default:
				break;
			}	//switch(j)
		}	//for(int i=0; i<16; i++)
		
		//store res[16]
		for(int i=0; i<16; i++) {
			*p++ = res[i];
		}
		
	}	//for(int j=0; j<16; j++)



	//sim stop, write 0x73746f70 (stop) to 0xFFFFFFFC
  	p_end = (uint32_t *)0xFFFFFFFC;
  	*p_end = 0x73746f70;
    
  	while(1){
  	};
    
  	return(0);
}

