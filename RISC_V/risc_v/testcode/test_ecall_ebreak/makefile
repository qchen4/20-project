
TOOL_PREFIX			= riscv64
DEPS_LIST       	= makefile
CORE_ARCH			= -march=rv32im_zicsr -mabi=ilp32

##-Wl,--no-relax: disable the use of "__global_pointer$" when link
GCC_COMPILE_OPTIONS = $(CORE_ARCH) -nostdlib -O -Wl,--no-relax
GCC_LINK_OPTIONS    = $(CORE_ARCH) -lgcc -O -Wl,--no-relax
INC_DIR				= -I ./ -I ../common
C_DEFINE			=


all: main $(DEPS_LIST)
 
asm_sub_program.o: ./asm_sub_program.s ./gen_instr.s $(DEPS_LIST)
	$(TOOL_PREFIX)-unknown-elf-gcc $(GCC_COMPILE_OPTIONS) -o $@ -c $<

vector.o: ../common/vector.s $(DEPS_LIST)
	$(TOOL_PREFIX)-unknown-elf-gcc $(GCC_COMPILE_OPTIONS) -o $@ -c $<

start.o: ../common/start.s $(DEPS_LIST)
	$(TOOL_PREFIX)-unknown-elf-gcc $(GCC_COMPILE_OPTIONS) -o $@ -c $<

mrisc_common.o: ../common/mrisc_common.c $(DEPS_LIST)
	$(TOOL_PREFIX)-unknown-elf-gcc $(GCC_COMPILE_OPTIONS) $(INC_DIR) -o $@ -c $<
	
%.o: %.c $(DEPS_LIST)
	$(TOOL_PREFIX)-unknown-elf-gcc $(GCC_COMPILE_OPTIONS) $(INC_DIR) -o $@ -c $<
 
main: vector.o start.o mrisc_common.o intrs.o main.o asm_sub_program.o
	$(TOOL_PREFIX)-unknown-elf-gcc -T ../mrisc.ld --entry=_start $(GCC_LINK_OPTIONS) -o ${@}.elf $^
	$(TOOL_PREFIX)-unknown-elf-objdump -D main.elf > main.txt
	$(TOOL_PREFIX)-unknown-elf-objcopy -O binary --only-section .text main.elf main_code.bin
	$(TOOL_PREFIX)-unknown-elf-objcopy -O binary --remove-section .text main.elf main_data.bin
 
clean:
	rm -f main.elf *.o main.txt main_code.bin main_data.bin

