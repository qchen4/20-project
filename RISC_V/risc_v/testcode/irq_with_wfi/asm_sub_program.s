
.section .text
.globl  asm_sub_program

asm_sub_program:
	add		sp,sp,-16
	sw		ra,4(sp)
	
	li		a5, 0x8       	#(1<<3)
    nop
    csrs	mip,a5          #set mip.msip to 1 before wfi
    wfi
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
   	nop
    wfi						#ext_irq before wfi
	
	nop
	nop
	nop
	nop
	wfi						#ext_irq with wfi at same cycle
	
	nop
	nop
	nop
	nop
	wfi						#ext_irq after wfi
	
	
	lw		ra,4(sp)
    add		sp,sp,16
    jalr 	0(ra)

