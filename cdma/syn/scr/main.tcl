sh date

echo "----------------------------------------------"
echo "--- Welcome to Boring, Smart and Stupid DC ---"
echo "--- I'm so smart than you can image, and I'm -"
echo "--- also more stupid than your can dream. ----"
echo "--- Keep this in mind, then you can success. -"
echo "----------------------------------------------"

echo "-------------------------------------------------"
echo "--- Begin read in all the RTL code             --"
echo "-------------------------------------------------"

set top             "cdma"
set SCANSYN         0
set en_clk_gating   0
set stage           pre

source ./scr/syn_parameter.tcl
source ./scr/lib_tsmc130.tcl

source ./scr/tsmc_rule_apply.tcl

#------------------------------#
#---- read in all RTL code     #
#------------------------------#
source ./scr/read_design.tcl
source ./scr/initial_pre.tcl

#------------------------------#
#---- desing parameter seting -#
#------------------------------#

current_design $top

set  	en_auto_wire_model_sel  0
##set  	fixed_wire_load_model  	"tsmc13_wl10"
##set  	fixed_wire_load_model  	"tsmc13_wl20"
set  	fixed_wire_load_model  	"ForQA"
set     wire_load_lib           slow

if {$en_auto_wire_model_sel == 0} {
    set auto_wire_load_selection false
}

#------------------------------#
#---- constrain the design  ---#
#------------------------------#

set    stage         p0

echo "-------------------------------------------------"
echo "--- Run stage: $stage on design: $top . ---"
echo "-------------------------------------------------"

current_design   $top
source ./scr/clocks.tcl

##---- insert clock gating
if {$en_clk_gating == 1} {
 	source ./scr/clk_gating_exclude.tcl > ./log/clk_gating_exclude.log
	source ./scr/power.tcl
}

source ./scr/core_const.tcl
source ./scr/initial_chk.tcl

#------------------------------#
#---- compile the design  -----#
#------------------------------#
set stage       p1
## if this's the last pass of bottom-up synthesis strategy, don't touch already synthesised sub-modules
set dont_touch_cells    ""
foreach sig_cell $dont_touch_cells {
    set_dont_touch  [get_designs $dont_touch_cells] true
}

echo "-------------------------------------------------"
echo "--- Run stage: $stage on design: $top . ---"
echo "-------------------------------------------------"

if {$SCANSYN == 1} {
    source ./scr/scan_cfg.tcl
}

source ./scr/compile_pass1.tcl

if {$SCANSYN == 1} {
    create_test_protocol -infer_asynch -infer_clock  \
    -capture_procedure single_clock

    insert_dft
    dft_drc     -verbose  -coverage_estimate  > ./rpt/dft_drc.rpt
}


foreach sig_cell $dont_touch_cells {
    set_dont_touch  [get_designs $dont_touch_cells] false
}

##change_names -verbose -hierarchy -rule TSMC_VERILOG_RULE
source ./scr/write_result.tcl
source ./scr/report.tcl

#normal mode second compile to save area and do boundary optimization of bottom-up strategy
set stage p2
current_design $top

echo "-------------------------------------------------"
echo "--- Run stage: $stage on design: $top . ---"
echo "-------------------------------------------------"

source ./scr/compile_pass2.tcl


##change_names -verbose -hierarchy -rule TSMC_VERILOG_RULE
source ./scr/write_result.tcl


set stage p2_naming
change_names -verbose -hierarchy -rule TSMC_VERILOG_RULE
source ./scr/write_result_all.tcl
source ./scr/report.tcl


echo "-------------------------------------------------"
echo "--- Congratulations, My Lord. All you commands --"
echo "--- have been done. But I don't sure whether   --"
echo "--- there's any eror and whether the results   --"
echo "--- match your requirement or not. Because I'm --"
echo "--- stupid.                                    --"
echo "--- If not, Pleae wait for next DC version and --"
echo "--- don't forget to prepare for enough \$.     --"
echo "-------------------------------------------------"

echo "-------------------------------------------------"
echo "--- Please keep your manner and keep tring,    --"
echo "--- because I'm stupid. Thanks. ^_^ ^_^        --"
echo "-------------------------------------------------"
sh date

#quit
  
