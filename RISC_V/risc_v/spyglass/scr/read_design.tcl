
set top_design mrisc_core
new_project $top_design -force

##Data Import Section
## read_file -type verilog [list       \
##    ../rtl/dpram_generic.v           \
##    ../rtl/async_fifo_generic.v      \
## ]

read_file -type sourcelist ./scr/flist.f

#--- write SDC for spyglass
read_file -type sgdc ./scr/chk.sgdc

read_file -type awl  ./scr/message_waive.awl

##Common Options Section
set_option dw yes
set_option language_mode mixed
set_option designread_enable_synthesis no
set_option designread_disable_flatten no
# set_option incdir {../rtl/include}
# set_option define {MBXY_WIDTH=6}

# maximal mem bit size
set_option mthresh [expr 2048*128]

set_option top $top_design

