# Minimal diagnostic on the BPPE target; no board constraints or bitstream.
if {[llength $argv] ni {2 3}} {error "Expected buffer flag, fresh report directory, optional ooc/full mode"}
lassign $argv buffered output mode
if {$mode eq ""} {set mode ooc}
if {$mode ni {ooc full}} {error "Mode must be ooc or full"}
if {$buffered ni {0 1}} {error "Buffer flag must be 0 or 1"}
set_param general.maxThreads 1
set output [file normalize $output]
if {[file exists $output]} {error "Output already exists"}
file mkdir $output
read_verilog [file join [file dirname [file normalize [info script]]] .. testcode vivado_ooc_probe.sv]
set options [list -top vivado_ooc_probe -part xc7a200tfbg484-2 -generic WITH_BUFG=$buffered]
if {$mode eq "ooc"} {lappend options -mode out_of_context}
# Full mode lets the tool insert/place I/O buffers; it is still not a board design.
synth_design {*}$options
create_clock -name probe_clk -period 33.333 [get_ports clk]
opt_design
place_design
route_design
report_utilization -file [file join $output utilization.rpt]
report_route_status -file [file join $output route_status.rpt]
report_drc -file [file join $output drc.rpt]
set f [open [file join $output metrics.tsv] w]
puts $f "metric\tvalue"
puts $f "buffered\t$buffered"
puts $f "is_block\t[get_property IS_BLOCK [current_design]]"
puts $f "iobuf_cells\t[llength [get_cells -hier -filter {REF_NAME =~ IBUF* || REF_NAME =~ OBUF*}]]"
puts $f "fully_routed\t[report_route_status -boolean_check ROUTED_FULLY]"
puts $f "route_errors\t[report_route_status -boolean_check ERRORS_IN_ROUTES]"
puts $f "prohibited_sites_before_save\t[llength [get_sites -quiet -filter {PROHIBIT == 1}]]"
write_checkpoint [file join $output routed.dcp]
close_design
open_checkpoint [file join $output routed.dcp]
puts $f "prohibited_sites_after_reopen\t[llength [get_sites -quiet -filter {PROHIBIT == 1}]]"
puts $f "reopened_fully_routed\t[report_route_status -boolean_check ROUTED_FULLY]"
puts $f "reopened_route_errors\t[report_route_status -boolean_check ERRORS_IN_ROUTES]"
close $f
puts "BPPE_TOOL_PROBE_COMPLETED buffered=$buffered mode=$mode"
exit
