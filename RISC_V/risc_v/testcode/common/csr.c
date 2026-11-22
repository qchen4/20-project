
#ifndef _MRISCV_CSR_RW_FUNCS_
#define _MRISCV_CSR_RW_FUNCS_

#include <stdint.h>

//read csr value
static inline uint32_t read_csr(uint32_t csr_addr) {
    uint32_t value;
    asm volatile ("csrr %0, %1" : "=r"(value) : "i"(csr_addr));
    //asm volatile ("csrrs %0, %1, x0" : "=r"(value) : "i"(csr_addr));
    return(value);
}

//write all bits of csr
static inline void write_csr(uint32_t csr_addr, uint32_t new_value) {
    asm volatile ("csrw %0, %1" : : "i"(csr_addr), "r"(new_value));
}

//set some bits of csr
static inline void set_bits_csr(uint32_t csr_addr, uint32_t set_bits) {
    asm volatile ("csrs %0, %1" : : "i"(csr_addr), "r"(set_bits));
}

//clear some bits of csr
static inline void clr_bits_csr(uint32_t csr_addr, uint32_t clr_bits) {
    asm volatile ("csrc %0, %1" : : "i"(csr_addr), "r"(clr_bits));
}

#endif
