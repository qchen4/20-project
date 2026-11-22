
set top_design jls_enc
new_project $top_design -force

##Data Import Section
read_file -type verilog [list       \
../rtl/jls_enc.v                \
../rtl/jls_recv_pixel.v         \
../rtl/jls_pipe_s1_s8.v         \
../rtl/jls_syntax_to_stream.v   \
../rtl/spram_generic.v          \
../rtl/dpram_generic.v          \
../rtl/sync_fifo.v              \
]

read_file -type awl  ./scr/message_waive.awl

#--- write SDC for spyglass
read_file -type sgdc ./scr/design.sgdc

##Common Options Section
set_option language_mode mixed
set_option designread_enable_synthesis no
set_option designread_disable_flatten no
# set_option incdir {../rtl/include}

#set_option define {_SHA_STAND_ALGORITHM_}

set_option mthresh  [expr 64*1024*1024]
set_option top $top_design

