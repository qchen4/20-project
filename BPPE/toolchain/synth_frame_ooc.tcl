# Exploratory synthesized-netlist analysis, not implementation/STA signoff.
set_param general.maxThreads 2
if {[llength $argv]!=3} {error "Expected fresh output directory, part, analysis clock period (ns)"}
lassign $argv output part period
set output [file normalize $output]
if {[file exists $output]} {error "Use a fresh synthesis output directory"}
if {![string is double -strict $period] || $period<=0} {error "Positive analysis clock period required"}
if {[llength [get_parts -quiet $part]]!=1} {error "Selected part is unavailable"}
file mkdir $output
set here [file dirname [file normalize [info script]]]
read_verilog -sv [file normalize [file join $here .. rtl bppe_frame_dispatch.sv]]
synth_design -top bppe_frame_dispatch -part $part -mode out_of_context
# Clock is applied after synthesis for analysis only; synthesis is unconstrained.
create_clock -name prototype_analysis_clk -period $period [get_ports clk]
report_utilization -file [file join $output utilization.rpt]
report_timing_summary -delay_type max -report_unconstrained -max_paths 10 -file [file join $output timing_synthesis_estimate.rpt]
report_clocks -file [file join $output clocks.rpt]
write_checkpoint -force [file join $output synthesized.dcp]
puts "BPPE_OOC_SYNTHESIS_PASSED part=$part clock_assumption_ns=$period top=bppe_frame_dispatch"
exit
