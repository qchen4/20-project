
#ifndef _MRISC_COMMON_H_
#define _MRISC_COMMON_H_

#include <stdint.h>


#define	PDBG_WRITE_BASE  0xfffffff4
#define	DBG_WRITE_BASE 	 0xfffffff8
#define END_WRITE_BASE 	 0xfffffffc
#define EXT_IRQ_CLR_ADDR 0xfffffff0

void err_exit();
void ok_exit();

void mrisc_dbg(uint32_t	dbg_num);
void mrisc_pdbg(uint32_t	p_num);
void initial_chk();

//int32_t	my_strcmp(const char *s1, const char *s2);

#endif
