# Read-only checkpoint inspection; all reports go to a fresh directory.
if {[llength $argv]!=2} {error "Expected checkpoint and fresh report directory"}
lassign $argv checkpoint output
set_param general.maxThreads 1
set checkpoint [file normalize $checkpoint]
set output [file normalize $output]
if {[file exists $output]} {error "Report directory already exists"}
file mkdir $output
open_checkpoint $checkpoint
set f [open [file join $output design_properties.tsv] w]
puts $f "property\tvalue"
# Deliberately exclude unrelated properties, including encryption material.
foreach p {PART TOP IS_BLOCK HD.OVERRIDE_PERSIST HD.RECONFIGURABLE HD.PARTITION HD.ISOLATED CFGBVS CONFIG_VOLTAGE CONFIG_MODE SPEED_LEVEL} {
    if {$p in [list_property [current_design]]} {
        set value [string map [list "\n" {\n} "\r" {} "\t" {\t}] [get_property $p [current_design]]]
        puts $f "$p\t$value"
    }
}
close $f
set f [open [file join $output context.tsv] w]
puts $f "metric\tvalue"
puts $f "pblocks\t[llength [get_pblocks -quiet]]"
puts $f "waivers\t[llength [get_waivers -quiet]]"
puts $f "prohibited_sites\t[llength [get_sites -quiet -filter {PROHIBIT == 1}]]"
puts $f "prohibited_bels\t[llength [get_bels -quiet -filter {PROHIBIT == 1}]]"
puts $f "fully_routed\t[report_route_status -boolean_check ROUTED_FULLY]"
puts $f "route_errors\t[report_route_status -boolean_check ERRORS_IN_ROUTES]"
close $f
write_xdc [file join $output active_constraints.xdc]
report_exceptions -file [file join $output exceptions.rpt]
report_timing_summary -delay_type min_max -report_unconstrained -max_paths 10 -file [file join $output timing.rpt]
report_drc -file [file join $output drc.rpt]
set f [open [file join $output drc.tsv] w]
puts $f "violation\tseverity"
foreach v [get_drc_violations -quiet] {puts $f "$v\t[get_property SEVERITY $v]"}
close $f
report_methodology -file [file join $output methodology.rpt]
set f [open [file join $output methodology.tsv] w]
puts $f "violation\tseverity"
foreach v [get_methodology_violations -quiet] {puts $f "$v\t[get_property SEVERITY $v]"}
close $f
# No synthesis, placement, routing, checkpoint write, waiver or constraint edit.
puts "BPPE_CHECKPOINT_INSPECTION_COMPLETED"
exit
