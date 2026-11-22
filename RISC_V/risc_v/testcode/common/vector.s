.section .text.vector
_intr_vec:
	jal		x0, sync_exp_isr
	jal		x0, _intr_vec+4		#jump to self
	jal		x0, _intr_vec+8		#jump to self
	jal		x0, sw_intr_isr
	jal		x0, _intr_vec+0x10  #jump to self
	jal		x0, _intr_vec+0x14	#jump to self
	jal		x0, _intr_vec+0x18	#jump to self
	jal		x0, timer_intr_isr
	jal		x0, _intr_vec+0x20	#jump to self
	jal		x0, _intr_vec+0x24	#jump to self
	jal		x0, _intr_vec+0x28	#jump to self
	jal		x0, ext_intr_isr

