
.section .text
.globl  asm_sub_program

asm_sub_program:
	add		sp,sp,-16
	sw		ra,4(sp)
	
	li		a5, 0x800       #(1<<11)
    nop
    nop
    ecall
    
	lw		ra,4(sp)
    add		sp,sp,16
    jalr 	0(ra)
