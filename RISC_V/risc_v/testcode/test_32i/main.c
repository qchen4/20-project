
#include 	<stdint.h>
#include  "mrisc_common.h"

//typedef  	uint32_t		var_type;
//typedef  	int32_t			var_type;
//typedef  	uint16_t		var_type;
//typedef  	int16_t			var_type;
//typedef  	uint8_t			var_type;
typedef  	int8_t			var_type;

#define		user_dbase  (0x20000000+28*1024)
#define		sf_imme			4
#define		imme_12			0x123
#define		imme_20			0x54321

int main()
{
	uint32_t	*p_end;
	var_type	*p;
  	var_type	data [17] = {0,1,2,3,4,5,6,7,8,-7,-6,-5,-4,-3,-2,-1,-8};
  	var_type	res[16];

	//test shift/arithmetic/logic/cmp instructions
	p = (var_type *) user_dbase;
	initial_chk();
	
	for(int j=0; j<16; j++) {
		for(int i=0; i<16; i++) {
			switch(j) {
			case 0:	//sll
				res[i] = data[i] << data[i+1];
				break;
			case 1: //slli
				res[i] = data[i] << sf_imme;
				break;
			case 2: //srl/sra
				res[i] = data[i] >> data[i+1];
				break;
			case 3: //srli/srai
				res[i] = data[i] >> sf_imme;
				break;
				
			case 4: //add
				res[i] = data[i] + data[i+1];
				break;
			case 5:	//addi
				res[i] = data[i] + imme_12;
				break;
			case 6:	//sub
				res[i] = data[i] - data[i+1];
				break;
			
			case 7:	//xor
				res[i] = data[i] ^ data[i+1];
				break;
			case 8:	//xori
				res[i] = data[i] ^ imme_12;
				break;
			case 9: //or
				res[i] = data[i] | data[i+1];
				break;
			case 10://ori
				res[i] = data[i] | imme_12;
				break;
			case 11://and
				res[i] = data[i] & data[i+1];
				break;
			case 12://andi
				res[i] = data[i] & imme_12;
				break;
				
			case 13://slt/sltu
				res[i] = (data[i] < data[i+1])? 1 : 0;
				break;
			case 14://slti/sltiu
				res[i] = (data[i] < imme_12)? 1 : 0;
				break;
				
			default:
				break;
			}	//switch(j)
		}	//for(int i=0; i<16; i++)
		
		//store res[16]
		for(int i=0; i<16; i++) {
			*p++ = res[i];
		}
		
	}	//for(int j=0; j<32; j++)



	//sim stop, write 0x73746f70 (stop) to 0xFFFFFFFC
  	p_end = (uint32_t *)0xFFFFFFFC;
  	*p_end = 0x73746f70;
    
  	while(1){
  	};
    
  	return(0);
}

