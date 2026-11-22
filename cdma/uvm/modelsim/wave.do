onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider apb_cfg
add wave -noupdate /tb/u_cdma/clk
add wave -noupdate /tb/u_cdma/rstn
add wave -noupdate /tb/u_cdma/psel
add wave -noupdate /tb/u_cdma/penable
add wave -noupdate /tb/u_cdma/paddr
add wave -noupdate /tb/u_cdma/pwrite
add wave -noupdate /tb/u_cdma/pwdata
add wave -noupdate /tb/u_cdma/pready
add wave -noupdate /tb/u_cdma/prdata
add wave -noupdate -radix hexadecimal /tb/u_cdma/u_cdma_cfg/cfg_sar
add wave -noupdate -radix hexadecimal /tb/u_cdma/u_cdma_cfg/cfg_dar
add wave -noupdate -radix hexadecimal /tb/u_cdma/u_cdma_cfg/cfg_trans_xsize
add wave -noupdate -radix hexadecimal /tb/u_cdma/u_cdma_cfg/cfg_trans_ysize
add wave -noupdate -radix hexadecimal /tb/u_cdma/u_cdma_cfg/cfg_sa_ystep
add wave -noupdate -radix hexadecimal /tb/u_cdma/u_cdma_cfg/cfg_da_ystep
add wave -noupdate -radix hexadecimal /tb/u_cdma/u_cdma_cfg/cfg_llr
add wave -noupdate /tb/u_cdma/u_cdma_cfg/cfg_dma_halt
add wave -noupdate /tb/u_cdma/u_cdma_cfg/cfg_arcache
add wave -noupdate /tb/u_cdma/u_cdma_cfg/cfg_awcache
add wave -noupdate /tb/u_cdma/u_cdma_cfg/buf_err
add wave -noupdate /tb/u_cdma/intr
add wave -noupdate -radix unsigned /tb/u_cdma/u_cdma_cfg/cmd_num
add wave -noupdate -divider {axi RW}
add wave -noupdate /tb/u_cdma/clk
add wave -noupdate /tb/u_cdma/arvalid
add wave -noupdate /tb/u_cdma/arready
add wave -noupdate /tb/u_cdma/arid
add wave -noupdate /tb/u_cdma/araddr
add wave -noupdate /tb/u_cdma/arlen
add wave -noupdate /tb/u_cdma/arsize
add wave -noupdate /tb/u_cdma/arburst
add wave -noupdate /tb/u_cdma/arlock
add wave -noupdate /tb/u_cdma/arcache
add wave -noupdate /tb/u_cdma/arprot
add wave -noupdate /tb/u_cdma/rid
add wave -noupdate /tb/u_cdma/rdata
add wave -noupdate /tb/u_cdma/rresp
add wave -noupdate /tb/u_cdma/rlast
add wave -noupdate /tb/u_cdma/rvalid
add wave -noupdate /tb/u_cdma/rready
add wave -noupdate /tb/u_cdma/clk
add wave -noupdate /tb/u_cdma/awvalid
add wave -noupdate /tb/u_cdma/awready
add wave -noupdate /tb/u_cdma/awid
add wave -noupdate /tb/u_cdma/awaddr
add wave -noupdate /tb/u_cdma/awlen
add wave -noupdate /tb/u_cdma/awsize
add wave -noupdate /tb/u_cdma/awburst
add wave -noupdate /tb/u_cdma/awlock
add wave -noupdate /tb/u_cdma/awcache
add wave -noupdate /tb/u_cdma/awprot
add wave -noupdate /tb/u_cdma/wid
add wave -noupdate /tb/u_cdma/wdata
add wave -noupdate /tb/u_cdma/wstrb
add wave -noupdate /tb/u_cdma/wlast
add wave -noupdate /tb/u_cdma/wvalid
add wave -noupdate /tb/u_cdma/wready
add wave -noupdate /tb/u_cdma/bid
add wave -noupdate /tb/u_cdma/bresp
add wave -noupdate /tb/u_cdma/bvalid
add wave -noupdate /tb/u_cdma/bready
add wave -noupdate /tb/u_cdma/intr
add wave -noupdate /tb/u_cdma/u_cdma_cfg/dma_cmd_end
add wave -noupdate /tb/u_cdma/u_cdma_cfg/cmd_num
add wave -noupdate /tb/u_cdma/u_cdma_cfg/dma_busy
add wave -noupdate /tb/axi_inf/slave_cb/wstrb
add wave -noupdate /tb/axi_inf/wstrb
add wave -noupdate /tb/axi_inf/aclk
add wave -noupdate /tb/axi_inf/areset_n
add wave -noupdate /tb/u_cdma/arvalid
add wave -noupdate /tb/axi_inf/arvalid
add wave -noupdate /tb/axi_inf/arready
add wave -noupdate /tb/axi_inf/slave_cb/arready
add wave -noupdate /tb/axi_inf/slave_cb/arvalid
add wave -noupdate /tb/axi_inf/monitor_cb/arcache
add wave -noupdate /tb/axi_inf/monitor_cb/awcache
add wave -noupdate /tb/u_cdma/buf_empty
add wave -noupdate /tb/u_cdma/buf_buf_word
add wave -noupdate /tb/u_cdma/u_cdma_cfg/dma_end_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2355000 ps} 0} {{Cursor 3} {71900 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 309
configure wave -valuecolwidth 98
configure wave -justifyvalue right
configure wave -signalnamewidth 3
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {5727800 ps}
