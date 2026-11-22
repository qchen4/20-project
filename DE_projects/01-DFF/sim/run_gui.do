# QuestaSim/ModelSim GUI simulation script
# Run from project root:
#   vsim -do sim/run_gui.do

if {![file exists work]} {
    vlib work
}
vmap work work

vlog rtl/c_seq.v sim/tb.v
vsim -onfinish stop -voptargs=+acc work.tb

view wave
add wave -divider "tb signals"
add wave sim:/tb/clk sim:/tb/rstn sim:/tb/d sim:/tb/q0 sim:/tb/q1 sim:/tb/q2
add wave -divider "dut internals"
add wave sim:/tb/u_c_seq/*
run -all
wave zoom full
