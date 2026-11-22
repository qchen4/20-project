
ENTRY( _core_start )

__stack_size = 2048;

PROVIDE( _stack_size = __stack_size );

MEMORY
{
	FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 4096K
	RAM   (rw) : ORIGIN = 0x20000000, LENGTH = 4096K  /*4MB total*/
}

SECTIONS
{
	.text :
	{
		/* vector.o(.text.vector); */
    . = ALIGN(64);
    /*
	  start.o(.text.startup);
	  intrs.o(.text*);
    */
	  
	  . = ALIGN(2048);
		*(.text*)
		*(.rodata*)
		. = ALIGN(4);	
	} >FLASH 

	.data :
	{
		. = ALIGN(4);
    *(.data*)
        . = ALIGN(4);
		PROVIDE( _edata = .);	 /* data段结束地址 */
        PROVIDE( __global_pointer$ = .);    /*global pointer */
	} >RAM

	.bss :
	{
		. = ALIGN(4);
		PROVIDE( _sbss = .);		/* bss段起始地址 */
        PROVIDE( __bss_start = .);
		*(.bss*)
  	*(.sbss*)
		*(COMMON*)
		. = ALIGN(4);
		PROVIDE( _ebss = .);		/* bss段结束地址 */
	} >RAM

	PROVIDE( _end = _ebss);
	PROVIDE( end = . );				/* 定义heap起始位置 */

  .stack ORIGIN(RAM) + LENGTH(RAM) - __stack_size :
    {
        PROVIDE( _heap_end = . );	/* 定义heap结束位置，默认到栈底结束 */
        . = ALIGN(4);
        PROVIDE(_susrstack = . );	/* 定义stack栈低地址*/
        . = . + __stack_size - 4;
        PROVIDE( _eusrstack = .);	/* 定义stack栈顶地址*/
    } >RAM
}

