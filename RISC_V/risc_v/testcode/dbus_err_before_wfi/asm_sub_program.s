
.section .text
.globl  asm_sub_program

asm_sub_program:
	add		sp,sp,-16
	sw		ra,4(sp)
	
	li		a5, 0x20000000 	#Data segment base addr
	li		a6, 0x08
    sw		a6, 0(a5)		#get d-bus error response
    wfi
    nop

	lw		ra,4(sp)
    add		sp,sp,16
    jalr 	0(ra)

