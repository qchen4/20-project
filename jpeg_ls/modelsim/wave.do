onerror {resume}
quietly virtual function -install /tb/u_jls_enc/u_jls_pipe_s1_s8 -env /tb/u_jls_enc/u_jls_pipe_s1_s8 { &{/tb/u_jls_enc/u_jls_pipe_s1_s8/s2_enc_mode, /tb/u_jls_enc/u_jls_pipe_s1_s8/s2_run_hit }} run_end
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider pipe_s0
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/clk
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/rstn
add wave -noupdate -radix hexadecimal /tb/u_jls_enc/u_jls_recv_pixel/xsize
add wave -noupdate -radix hexadecimal /tb/u_jls_enc/u_jls_recv_pixel/ysize
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/sof
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/pixel_vld
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/pixel
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/pixel_ack
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/recv_pixel
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/in_x
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/in_y
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/top_mem_ce
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/top_mem_we
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/top_mem_addr
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/top_mem_wdata
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/top_mem_rdata
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/s0_vld
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/s0_ack
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/s0_x
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/s0_y
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/s0_pixel
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/s0_xend
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/s0_xbeg
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/s0_a
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/s0_b
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/s0_c
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/s0_d
add wave -noupdate /tb/u_jls_enc/u_jls_recv_pixel/s1_pixel
add wave -noupdate -divider initial
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/rstn
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/ini_cnt
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/ini_flag
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/scan_header
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/scan_header_time
add wave -noupdate -divider pipe_s1
add wave -noupdate -divider pipe_s2
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s2_vld
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s2_ack
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s2_x
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s2_y
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/run_end
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s2_enc_mode
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s2_run_hit
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s2_pred
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s2_q_idx
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/j_idx
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/runcnt
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/runcnt_add
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/run_rg
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/enc_runcnt
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/abcn_mem_rd
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/abcn_mem_raddr
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/abcn_mem_rdata
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/abcn_mem_wr
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/abcn_mem_waddr
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/abcn_mem_wdata
add wave -noupdate -divider pipe_s3
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s3_vld
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s3_ack
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s3_x
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s3_y
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s3_q_idx
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s3_q_sign
add wave -noupdate -divider pipe_s4
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_vld
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_ack
add wave -noupdate -color Pink /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_halt
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_x
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_y
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_pixel
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_enc_mode
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_run_hit
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_pred
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_q_idx
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_q_sign
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_abcn
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_a
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_b
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_c
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s4_n
add wave -noupdate -divider pipe_s5
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s5_vld
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s5_ack
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s5_x
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s5_y
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s5_enc_mode
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s5_run_hit
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s5_sign
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s5_ritype
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s5_err
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s5_aq_for_k_cal
add wave -noupdate -divider pipe_s7
add wave -noupdate /tb/u_jls_image_file_parse/clk
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s7_vld
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s7_ack
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s7_x
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s7_y
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s7_enc_mode
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s7_run_hit
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s7_q_idx
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s7_k
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s7_err_map
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s7_abcn
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s7_run_syntax_len
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s7_run_syntax
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s7_run_glimit
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/func_abcn_update/a_add
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/func_abcn_update/b_add
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/func_abcn_update/a_reset
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/func_abcn_update/b_reset
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/func_abcn_update/n_reset
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/func_abcn_update/b_add_n_reset
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/func_abcn_update/b_add_2n_reset
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/func_abcn_update/b_sub_n_reset
add wave -noupdate /tb/u_jls_sim_trace/s7_a
add wave -noupdate /tb/u_jls_sim_trace/s7_b
add wave -noupdate /tb/u_jls_sim_trace/s7_c
add wave -noupdate /tb/u_jls_sim_trace/s7_n
add wave -noupdate -divider pipe-s8
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s8_vld
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s8_ack
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s8_syntax0_vld
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s8_syntax0_len
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s8_syntax0
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s8_syntax1_vld
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s8_syntax1_len
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s8_syntax1
add wave -noupdate /tb/u_jls_enc/u_jls_pipe_s1_s8/s8_eof
add wave -noupdate -divider syntax_2_stream
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/sof
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/sta
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/fifo_ful
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/fifo_push
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/fifo_wdata
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/fifo_empty
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/fifo_pop
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/fifo_rdata
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/fifo_flush
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/add0_flag
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/sf_bits
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/sf_reg
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/bits_cnt
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/s0_vld
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/s0_ack
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/sf_sta
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/bits_cnt
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/stream_vld
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/stream_bytes
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/stream_ack
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/stream
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/stream_eof
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/stream_len
add wave -noupdate -divider general_dbg
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/sf_sta
add wave -noupdate /tb/u_jls_enc/u_jls_syntax_to_stream/back_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {179073000 ps} 0} {{Cursor 2} {27463653900 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 395
configure wave -valuecolwidth 100
configure wave -justifyvalue right
configure wave -signalnamewidth 2
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {15192896300 ps}
