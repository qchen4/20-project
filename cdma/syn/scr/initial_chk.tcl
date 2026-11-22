current_design  $top  
set  check_design_file  [format "%s%s%s%s%s"  $report_name  _  $stage _  check_design.rpt]
set  check_timing_file  [format "%s%s%s%s%s"  $report_name  _  $stage _  check_timing.rpt]

redirect $check_design_file {check_design}
redirect $check_timing_file {check_timing}
    
