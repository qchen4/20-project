#ifndef RISCV_CONFIG_H
#define RISCV_CONFIG_H

#define CSR_SUPPORT /* This is currently mandatory, because of the qemu reset-vector */
//#define ATOMIC_SUPPORT
#define MULTIPLY_SUPPORT
//#define PMP_SUPPORT

#define MROM_BASE_ADDR  0x0000UL
#define MROM_SIZE_BYTES 0x400000UL      //4MB

#define RAM_BASE_ADDR  0x20000000UL
#define RAM_SIZE_BYTES 0x400000UL       //4MB

//self write test code
//#define PC_START       0x0040UL
//riscv-test and riscv-dv
#define PC_START       0x0000UL

#define MAIN_START	   0x800UL

#define RV_EXTENSION_TO_MISA(extension) (1 << (extension - 'A'))
#define RV_SUPPORTED_EXTENSIONS ( RV_EXTENSION_TO_MISA('I') )
/*
#define RV_SUPPORTED_EXTENSIONS ( RV_EXTENSION_TO_MISA('I') | \
                                  RV_EXTENSION_TO_MISA('M') | \
                                  RV_EXTENSION_TO_MISA('A') | \
                                  RV_EXTENSION_TO_MISA('S') | \
                                  RV_EXTENSION_TO_MISA('U') )
*/

#define MRISC_END_BASE_ADDR  0xfffffffcUL
#define MRISC_END_BASE_ADDR2 0x20000000UL
#define MRISC_DBG_BASE_ADDR  0xfffffff8UL
#define MRISC_PDBG_BASE_ADDR 0xfffffff4UL
#define MRISC_EXT_IRQ_CLR_ADDR 0xfffffff0UL

#define CLINT_BASE_ADDR 0x2000000UL
#define CLINT_SIZE_BYTES 0x10000UL

#define SIMPLE_UART_TX_REG_ADDR 0x3000000UL
#define SIMPLE_UART_SIZE_BYTES 0x2

#define PLIC_BASE_ADDR 0x0C000000UL
#define PLIC_SIZE_BYTES 0x3FFF004UL

#define UART8250_TX_REG_ADDR 0x10000000UL


#endif /* RISCV_CONFIG_H */

