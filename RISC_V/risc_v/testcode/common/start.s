
.section .text.startup
.global _core_start

_core_start:
		la		sp, _eusrstack	#set stack top
		call	zero_bss				#set bss section to zero
		jal		main						#go to main function


# clear bss section
zero_bss:
    la t1, _sbss     			# 加载BSS段的起始地址到t1
    la t2, _ebss     			# 加载BSS段的结束地址到t2
 
zero_bss_loop:
    beq 	t1, t2, end_zero_bss 	# 如果t1等于t2则跳转到end_zero_bss
    sw 		x0, 0(t1)           	# 否则存储0到当前t1指向的地址，并将t1增加4
    addi 	t1, t1, 4           	# t1增加4，指向下一个要清零的地址
    j 		zero_bss_loop         # 循环
 
end_zero_bss:
    ret                      		# 返回
