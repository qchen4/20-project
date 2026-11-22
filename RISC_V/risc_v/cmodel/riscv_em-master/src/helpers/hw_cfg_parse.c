
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "hw_cfg_parse.h"


void idbus_err_cfg_parse(rv_core_td *rv_core, char *cfg_file)
{
	uint8_t		flag	;
	FILE*		fp		;

	char line[64];
	char hex_str[16];
	char string_part[3];
	uint32_t	idx=0;
	
	flag=fopen_s(&fp, cfg_file, "r");
	
	if (flag != 0) {
		printf("Warning: No idbus error response configration file. All bus access will get OKAY response.\n");
		rv_core->idbus_err_num = 0;
		return;
	} else {
		
		//get a line from a text file
		while(fgets(line, sizeof(line), fp)) {
        	//delete the return char at the end of a line
        	line[strcspn(line, "\n")] = 0;
        
        	//use sscanf_s to parse the 2 parts of a line
        	//format: 0x12ab RW
        	if (sscanf_s(line, "0x%15s %2s", hex_str, sizeof(hex_str), string_part, sizeof(string_part)) == 2) {
        	    //change hex string to integer number
        	    uint32_t hex_value = (uint32_t)strtol(hex_str, NULL, 16);
        	    
        	    printf("Hex string: 0x%s, Hex value: 0x%x\n", hex_str, hex_value);
        	    printf("srting part: %s\n", string_part);
        	    printf("---\n");
        	
        		if(strcmp(string_part, "RW") == 0) {
					rv_core->idbus_err_map[idx].rw = 3;
					rv_core->idbus_err_map[idx].addr = hex_value;
					idx++;
				} else if(strcmp(string_part, "R") == 0) {
					rv_core->idbus_err_map[idx].rw = 1;
					rv_core->idbus_err_map[idx].addr = hex_value;
					idx++;
				} else if(strcmp(string_part, "W") == 0) {
					rv_core->idbus_err_map[idx].rw = 2;
					rv_core->idbus_err_map[idx].addr = hex_value;
					idx++;
				}
						
				if(idx == 128) {
					printf("Warning: Only parse first 128 ID bus error configuration. The others are not used.\n");
					break;
				}
        	}
		}		
		
		rv_core->idbus_err_num = idx;
		fclose(fp);
	}
	
}


void ext_irq_cfg_parse(rv_core_td *rv_core, char *cfg_file)
{
	uint8_t		flag	;
	FILE*		fp		;

	char line[64];
	char val_str[16], wait_str[16];
	uint32_t	mode, val, wait_cyc;
	uint32_t	idx=0;
	
	flag=fopen_s(&fp, cfg_file, "r");
	
	if (flag != 0) {
		printf("Warning: No external interrupt configration file. No external interrupt for this testcase.\n");
		rv_core->ext_irq_cfg_num = 0;
		return;
	} else {
		
		printf("External interrupt configure is:\n");

		//get a line from a text file
		while(fgets(line, sizeof(line), fp)) {
        	//delete the return char at the end of a line
        	line[strcspn(line, "\n")] = 0;
        	
        	//use sscanf_s to parse the 2 parts of a line
        	//format: 
        	if (sscanf_s(line, "%d 0x%x 0x%x", &mode, &val, &wait_cyc) == 3) {        	    
        	    printf("mode: %0d, hex value: 0x%x, wait cycle: 0x%x\n", mode, val, wait_cyc);
        	
				rv_core->ext_irq_cfg[idx].mode = mode;
        		rv_core->ext_irq_cfg[idx].val  = val;
        		rv_core->ext_irq_cfg[idx].wait_cyc = wait_cyc;
        	
				idx++;
													
				if(idx == 128) {
					printf("Warning: Only parse first 128 external interrupt configuration. The others are not used.\n");
					break;
				}
        	}
		}		
		
		rv_core->ext_irq_cfg_num = idx;
		fclose(fp);
	}
	
}

