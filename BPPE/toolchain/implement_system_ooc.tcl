# Internal implementation only: no board pins, external delay contract or bitstream.
if {[llength $argv]!=4} {error "Expected fresh output, part, clock period and threads"}
lassign $argv output part period threads
if {$threads ni {1 2}} {error "Use one or two implementation threads"}
if {![string is double -strict $period] || $period<=0} {error "Positive period required"}
set_param general.maxThreads $threads
set output [file normalize $output]
if {[file exists $output]} {error "Use a fresh implementation directory"}
if {[llength [get_parts -quiet $part]]!=1} {error "Selected part unavailable"}
file mkdir $output
set here [file dirname [file normalize [info script]]]
foreach source {bppe_guarded_multiplier.sv bppe_preprocess_core.sv bppe_beat_core.sv bppe_channel_core.sv bppe_frame_dispatch.sv bppe_acquisition_channels.sv bppe_window_store.sv bppe_rounded_divider.sv bppe_measurement_core.sv bppe_multichannel_prototype.sv bppe_ooc_clocked_top.sv} {
    read_verilog -sv [file normalize [file join $here .. rtl $source]]
}
synth_design -top bppe_ooc_clocked_top -part $part -mode out_of_context
# Same synthesis options as EXP-021; implementation sees the confirmed clock.
create_clock -name prototype_analysis_clk -period $period [get_ports clk]
if {[llength [get_cells -hier -filter {REF_NAME =~ BUFG*}]]!=1} {error "Expected one internal clock buffer"}
write_checkpoint -force [file join $output synthesized.dcp]
opt_design
report_drc -file [file join $output preplace_drc.rpt]
foreach violation [get_drc_violations -quiet] {
    if {[get_property SEVERITY $violation] in {Error {Critical Warning}}} {
        error "Pre-place DRC failure: $violation; inspect preplace_drc.rpt"
    }
}
place_design
phys_opt_design
route_design
report_utilization -file [file join $output utilization.rpt]
report_utilization -hierarchical -file [file join $output utilization_hierarchical.rpt]
report_timing_summary -delay_type min_max -report_unconstrained -max_paths 20 -file [file join $output timing_routed.rpt]
report_timing -delay_type max -max_paths 20 -file [file join $output critical_setup.rpt]
report_timing -delay_type min -max_paths 20 -file [file join $output critical_hold.rpt]
report_route_status -file [file join $output route_status.rpt]
report_clock_utilization -file [file join $output clock_utilization.rpt]
report_clocks -file [file join $output clocks.rpt]
report_drc -file [file join $output drc.rpt]
set fh [open [file join $output route_metrics.tsv] w]
puts $fh "metric\tvalue"
foreach flag {PLACED_FULLY PARTIALLY_ROUTED ROUTED_FULLY ERRORS_IN_ROUTES} {
    puts $fh "$flag\t[report_route_status -boolean_check $flag]"
}
foreach kind {UNROUTED PARTIAL GAPS CONFLICTS HIERPORT} {
    puts $fh "$kind\t[llength [report_route_status -return_nets -route_type $kind]]"
}
close $fh
set fh [open [file join $output drc_metrics.tsv] w]
puts $fh "violation\tseverity"
foreach violation [get_drc_violations -quiet] {
    puts $fh "$violation\t[get_property SEVERITY $violation]"
}
close $fh
set fh [open [file join $output clock_buffers.tsv] w]
puts $fh "cell\tprimitive\tlocation"
foreach cell [get_cells -hier -filter {REF_NAME =~ BUFG*}] {
    puts $fh "$cell\t[get_property REF_NAME $cell]\t[get_property LOC $cell]"
    report_route_status -of_objects [get_nets -of_objects [get_pins $cell/O]] -file [file join $output internal_clock_route.rpt]
}
close $fh
write_checkpoint -force [file join $output routed.dcp]
puts "BPPE_INTERNAL_OOC_IMPLEMENTATION_COMPLETED part=$part period_ns=$period external_interface_signoff=0 board_signoff=0"
exit
