
current_design  $top  

#------ add multiport fix -----#
set_fix_multiple_port_nets -all -buffer_constants

set  check_design_file  [format "%s%s%s%s%s"  $report_name  _  $stage _  check_design.rpt]

redirect $check_design_file {check_design}
    
