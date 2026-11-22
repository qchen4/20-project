
.section .text
.globl  asm_sub_program

asm_sub_program:
	add		sp,sp,-16
	sw		ra,4(sp)
	
	li		a5, 0x800       #(1<<11)
    nop
    csrc	mie,a5          #clear mie.meie to 0
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    csrs    mie,a5          #set mie.meie to 1
	
	lw		ra,4(sp)
    add		sp,sp,16
    jalr 	0(ra)

