#pragma warning(disable:4996)

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
//#include <unistd.h>


#include <riscv_helper.h>
#include <riscv_types.h>
#include <core.h>


//__declspec(align(4)) uint8_t  soc_from[FROM_SIZE_BYTES] = { 0 };
__declspec(align(4)) uint8_t  soc_mrom[MROM_SIZE_BYTES] = { 0 };
__declspec(align(4)) uint8_t  soc_ram[RAM_SIZE_BYTES] = { 0 };


FILE    *fp_main_exe, *fp_main_wb, *fp_other_exe, *fp_other_wb, *fp_dbus;
int     dbus_rw_cnt=0;

static void parse_options(int argc, 
                          char** argv, 
                          char** ini_file_path, 
                          rv_uint_xlen *success_pc, 
                          uint64_t *num_cycles)
{
    int c;
    char *arg_ini_file_path = NULL;
    char *arg_success_pc = NULL;
    char *arg_num_cycles = NULL;

		for(int i=1; i<argc; i++) {
			if(strcmp(argv[i], "-s") == 0) {
				i++;
				arg_success_pc = argv[i];
				*success_pc = strtol(arg_success_pc, NULL, 16);				
				continue;
			}
			
			if(strcmp(argv[i], "-ini_file_path") == 0) {
				i++;
                arg_ini_file_path = argv[i];
				continue;
			}
			
			if(strcmp(argv[i], "-n") == 0) {
				i++;
				arg_num_cycles = argv[i];
				*num_cycles = strtol(arg_num_cycles, NULL, 10);
				continue;
			}	
		}

    if(arg_ini_file_path == NULL)
    {
        printf("Please specify initial file path for this emulation!\n");
        exit(1);
    }

    printf("Initial file path: %s\n", arg_ini_file_path);
    printf("Success PC: " PRINTF_FMT "\n", *success_pc);
    printf("Num Cycles: %ld\n", *num_cycles);

    *ini_file_path = arg_ini_file_path;
}


static rv_ret rv_soc_bus_access(void *priv, privilege_level priv_level, bus_access_type access_type, rv_uint_xlen address, void *value, uint8_t len)
{

}


void rv_core_emu(rv_core_td *rv_core, char *fw_file_name, char *dtb_file_name, rv_uint_xlen success_pc, uint64_t num_cycles)
{
    uint8_t mei = 0, msi = 0, mti = 0;
            
    //initial ROM and RAM
    FILE* fp;
    uint32_t size;
    uint8_t  flag;

    flag=fopen_s(&fp, fw_file_name, "rb");
    if (flag != 0) {
        printf("Open file %s for read failed.\n", fw_file_name);
        return;
    }
    else {
        fseek(fp, 0, SEEK_END);
        size = ftell(fp);
        fseek(fp, 0, SEEK_SET);
        fread(soc_mrom, sizeof(uint8_t), size, fp);
        fclose(fp);
    }

    flag = fopen_s(&fp, dtb_file_name, "rb");
    if (flag != 0) {
        printf("Open file %s for read failed.\n", dtb_file_name);
        return;
    }
    else {
        fseek(fp, 0, SEEK_END);
        size = ftell(fp);
        fseek(fp, 0, SEEK_SET);
        fread(soc_ram, sizeof(uint8_t), size, fp);
        fclose(fp);
    }

    
    rv_core_reg_dump(rv_core);

    while(1)
    {
        rv_core_run(rv_core);

        set_ext_irq(rv_core);

        if (rv_core->in_trap == 0) {
            //check pending intrs
            chk_pending_intr(rv_core);
        }
				
        // /* update interrupt controllers */
        // plic_update_pending(&rv_soc->plic, 10, uart_irq_pending);
        // mei = plic_update(&rv_soc->plic);
        // 
        // /* Feed clint and update internall states */    
        // clint_update(&rv_soc->clint, &msi, &mti);
        // 
        // /* update CSRs for actual interrupt processing */
        // rv_core_process_interrupts(&rv_soc->rv_core0, mei, mti, msi);
        // 
        
        rv_core_reg_dump(rv_core);
				
        if(rv_core->pc == success_pc)
            break;

        if((num_cycles != 0) && (rv_core->curr_cycle >= num_cycles))
            break;
    }
}


int main(int argc, char *argv[])
{
    char *ini_file_path = NULL;
    char code_fname[256];
    char data_fname[256];
    char idbus_cfg_fname[256];
    char ext_irq_cfg_fname[256];
    rv_uint_xlen success_pc = 0xfffffffc;   //never hit PC value
    uint64_t num_cycles = 0;

    parse_options(argc, argv, &ini_file_path, &success_pc, &num_cycles);

    sprintf(code_fname, "%s%s", ini_file_path, "/main_code.bin");
    sprintf(data_fname, "%s%s", ini_file_path, "/main_data.bin");
    sprintf(idbus_cfg_fname, "%s%s", ini_file_path, "/idbus_err_resp.cfg");
    sprintf(ext_irq_cfg_fname, "%s%s", ini_file_path, "/ext_irq.cfg");

	rv_core_td	rv_core;
	void *no_top = NULL;

    //open RTL trace files
    if ( (fp_main_exe = fopen("./trc/trc_main_exe.txt", "w")) == NULL )
        return -1;
    
    if ( (fp_other_exe = fopen("./trc/trc_other_exe.txt", "w")) == NULL )
        return -1;
    
    if ( (fp_main_wb = fopen("./trc/trc_main_wb.txt", "w")) == NULL )
        return -1;
    
    if ( (fp_other_wb = fopen("./trc/trc_other_wb.txt", "w")) == NULL )
        return -1;

    if ( (fp_dbus = fopen("./trc/trc_dbus.txt", "w")) == NULL)
        return -1;

	rv_core_init(&rv_core, no_top, rv_soc_bus_access, idbus_cfg_fname, ext_irq_cfg_fname);


    printf("Now starting RV32I core, loaded program file will now be started...\n\n\n");

    rv_core_emu(&rv_core, code_fname, data_fname, success_pc, num_cycles);
    
}
