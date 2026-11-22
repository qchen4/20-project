#-------save design --------#
puts "#--------------------------------#"
puts "  save design result of $stage.   "
puts "#--------------------------------#" 

current_design  $top

write  -hierarchy  -format  verilog  -output \
    [format "%s%s%s%s" $result_name _ $stage .vnet]
write  -hierarchy  -format  ddc       -output \
    [format "%s%s%s%s" $db_name _ $stage .ddc]

