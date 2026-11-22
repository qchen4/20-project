#-------- create clocks ------------//
create_clock  -name       clk                               \
              -period     $clk_sys_cyc                      \
              -waveform   [list 0 [expr ($clk_sys_cyc)/2]]  \
              [get_port   [list clk]]

set_clock_latency      1.0                          [get_clocks [list clk]]
set_clock_transition   $clk_transiton               [get_clocks [list clk]]
set_clock_uncertainty  $clk_uncertain_setup -setup  [get_clocks [list clk]] 
set_clock_uncertainty  $clk_uncertain_hold  -hold   [get_clocks [list clk]]

set_ideal_network   [get_port   [list clk]]



#-------------------------------
#clk_awo is sync with clk(same period, same latency)
create_clock  -name       clk_awo                           \
              -period     $clk_sys_cyc                      \
              -waveform   [list 0 [expr ($clk_sys_cyc)/2]]  \
              [get_port   [list clk_awo]]

set_clock_latency      1.0                          [get_clocks [list clk_awo]]
set_clock_transition   $clk_transiton               [get_clocks [list clk_awo]]
set_clock_uncertainty  $clk_uncertain_setup -setup  [get_clocks [list clk_awo]] 
set_clock_uncertainty  $clk_uncertain_hold  -hold   [get_clocks [list clk_awo]]

set_ideal_network   [get_port   [list clk_awo]]


#---- this design just has 2 sync clk
#set_clock_groups -asynchronous  -name core_clk_grps \
#	-group  [get_clocks [list clk]]		            \
#	-group	[get_clocks [list clk0 clk1]	        \
#	-group	[get_clocks [list clk2 clk3]]

