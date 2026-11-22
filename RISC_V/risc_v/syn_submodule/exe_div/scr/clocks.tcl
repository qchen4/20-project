#-------- create clocks ------------//


#---- this design just has 2 sync clk
#set_clock_groups -asynchronous  -name core_clk_grps \
#	-group  [get_clocks [list clk]]		            \
#	-group	[get_clocks [list clk0 clk1]	        \
#	-group	[get_clocks [list clk2 clk3]]

