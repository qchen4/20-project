##------------------------------##
# setup the library for compile  #
##------------------------------##

set designer          "sky"
set company           "study"

set search_path       [list		\
                /mnt/new_proj/test/TSMC_013/synopsys               \
                /usr/synopsys/dc-L-2016.03-SP1/libraries/syn       \
                /usr/synopsys/dc-L-2016.03-SP1/dw/sim_ver          \
			]

set worst_lib           [list slow.db]
set tech_lib_name       [list slow]

set synthetic_library   [list dw_foundation.sldb]
set link_library        [list "*" $worst_lib $synthetic_library]
set target_library      $worst_lib

##set this if you want to enable the using of different PVT libraries for setup/hold timing check.
##While at synthesis stage, we just foucus on setup timing check.
##set_min_library	slow.db	-min_version fast.db
#---- List all the Hard Macros used ----#


#don't use the cells for scan insertion if scan insertion if not enabled
set_dont_use          slow/SEDFF*
set_dont_use          slow/SDFF*

#don't use latch if clock gating is disabled
set_dont_use          slow/TLAT*
#don't use regfile in lib
set_dont_use          slow/RF2R*
set_dont_use          slow/RF1R1*
#don't use low driven strength cells
set_dont_use          slow/*XL
#don't use cells with a lot of  pins
set_dont_use          slow/MDFF*
set_dont_use          slow/SMDFF*

set dont_use_cell     [list slow/TBUF* slow/DLY* slow/*DF*SR*]
set_dont_use $dont_use_cell

#use these tie high and tie low cell for better ESD
set_attribute [get_lib_cells slow/TIELO] "dont_touch" 	"false"
set_attribute [get_lib_cells slow/TIELO] "dont_use" 	"false"

set_attribute [get_lib_cells slow/TIEHI] "dont_touch" 	"false"
set_attribute [get_lib_cells slow/TIEHI] "dont_use" 	"false"
     
