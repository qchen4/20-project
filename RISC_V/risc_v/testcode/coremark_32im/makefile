
TOOL_PREFIX			= riscv64
DEPS_LIST       	= makefile
CORE_ARCH			= -march=rv32im_zicsr -mabi=ilp32

##-Wl,--no-relax: disable the use of "__global_pointer$" when link
GCC_COMPILE_OPTIONS = $(CORE_ARCH) -nostdlib -O3 -Wl,--no-relax
GCC_LINK_OPTIONS    = $(CORE_ARCH) -lgcc -O3 -Wl,--no-relax
INC_DIR				= -I ./ -I ./simple -I ../common
C_DEFINE			= -DITERATIONS=1


all: main $(DEPS_LIST)
 
vector.o: ../common/vector.s $(DEPS_LIST)
	$(TOOL_PREFIX)-unknown-elf-gcc $(GCC_COMPILE_OPTIONS) -o $@ -c $<

start.o: ../common/start.s $(DEPS_LIST)
	$(TOOL_PREFIX)-unknown-elf-gcc $(GCC_COMPILE_OPTIONS) -o $@ -c $<

mrisc_common.o: ../common/mrisc_common.c $(DEPS_LIST)
	$(TOOL_PREFIX)-unknown-elf-gcc $(GCC_COMPILE_OPTIONS) $(INC_DIR) -o $@ -c $<

core_base.o: ./simple/core_base.c $(DEPS_LIST)
	$(TOOL_PREFIX)-unknown-elf-gcc $(GCC_COMPILE_OPTIONS) $(INC_DIR) $(C_DEFINE) -o $@ -c $<

core_portme.o: ./simple/core_portme.c $(DEPS_LIST)
	$(TOOL_PREFIX)-unknown-elf-gcc $(GCC_COMPILE_OPTIONS) $(INC_DIR) $(C_DEFINE) -o $@ -c $<

%.o: %.c $(DEPS_LIST)
	$(TOOL_PREFIX)-unknown-elf-gcc $(GCC_COMPILE_OPTIONS) $(INC_DIR) $(C_DEFINE) -o $@ -c $<
 
main: vector.o start.o intrs.o mrisc_common.o core_base.o core_portme.o core_list_join.o core_matrix.o core_state.o core_util.o core_main.o
	$(TOOL_PREFIX)-unknown-elf-gcc -T ../mrisc.ld --entry=_core_start $(GCC_LINK_OPTIONS) -o ${@}.elf $^
	$(TOOL_PREFIX)-unknown-elf-objdump -D main.elf > main.txt
	$(TOOL_PREFIX)-unknown-elf-objcopy -O binary --only-section   .text main.elf main_code.bin
	$(TOOL_PREFIX)-unknown-elf-objcopy -O binary --remove-section .text main.elf main_data.bin
 
clean:
	rm -f main.elf *.o main.txt main_*.bin

