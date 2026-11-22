if [file exists "work"] {vdel -all}
vlib work
vmap work work
vlog -f filelist.f
vsim -voptargs=+acc tb_riscv_top
add wave tb_riscv_top/u_riscv_inst/* 
add wave tb_riscv_top/u_riscv_inst/u_register_inst/regs 
set NoQuitOnFinish 1
onbreak {resume}
#log /* -r
#do wave.do
run 5us



