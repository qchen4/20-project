# Full numerical prototype OOC synthesis; not implementation/timing signoff.
if {[llength $argv]!=4} {error "Expected fresh output directory, part, analysis clock period (ns), thread count"}
lassign $argv output part period threads
if {$threads ni {1 2}} {error "Use one or two synthesis processes"}
set_param general.maxThreads $threads
set output [file normalize $output]
if {[file exists $output]} {error "Use a fresh synthesis output directory"}
if {![string is double -strict $period] || $period<=0} {error "Positive analysis clock period required"}
if {[llength [get_parts -quiet $part]]!=1} {error "Selected part is unavailable"}
file mkdir $output
set here [file dirname [file normalize [info script]]]
foreach source {bppe_guarded_multiplier.sv bppe_preprocess_core.sv bppe_beat_core.sv bppe_channel_core.sv bppe_frame_dispatch.sv bppe_acquisition_channels.sv bppe_window_store.sv bppe_rounded_divider.sv bppe_measurement_core.sv bppe_multichannel_prototype.sv} {
    read_verilog -sv [file normalize [file join $here .. rtl $source]]
}
synth_design -top bppe_multichannel_prototype -part $part -mode out_of_context
# Deliberately match previous experiments: no timing-driven synthesis. Apply
# a clock AFTER synthesis only for exploratory netlist timing estimates.
create_clock -name prototype_analysis_clk -period $period [get_ports clk]
report_utilization -file [file join $output utilization.rpt]
report_utilization -hierarchical -file [file join $output utilization_hierarchical.rpt]
report_timing_summary -delay_type max -report_unconstrained -max_paths 20 -file [file join $output timing_synthesis_estimate.rpt]
report_timing -delay_type max -max_paths 20 -file [file join $output critical_paths.rpt]
report_clocks -file [file join $output clocks.rpt]
write_checkpoint -force [file join $output synthesized.dcp]
puts "BPPE_SYSTEM_OOC_SYNTHESIS_PASSED part=$part clock_assumption_ns=$period top=bppe_multichannel_prototype"
exit
