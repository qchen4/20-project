
h0_start:
init:             
                  li x0, 0x8b77dc3d
                  li x1, 0x80000000
                  li x3, 0xf126dac8
                  li x4, 0xfe9bd372
                  li x5, 0x0
                  li x6, 0x2
                  li x7, 0xf6311e60
                  li x8, 0xf7d881fb
                  li x9, 0x80000000
                  li x10, 0xbe0e8e5b
                  li x11, 0xe
                  li x12, 0x0
                  li x14, 0x4
                  li x15, 0x80000000
                  li x16, 0xf0cd86e0
                  li x17, 0x80000000
                  li x18, 0xf7fc4a3b
                  li x19, 0x9fabfaa1
                  li x20, 0x9
                  li x21, 0x2
                  li x22, 0x0
                  li x23, 0x0
                  li x24, 0x0
                  li x25, 0x645413b0
                  li x26, 0x1
                  li x27, 0x0
                  li x28, 0x80cc9e78
                  li x29, 0x80000000
                  li x30, 0x8
                  li x31, 0x80000000
                  la x2, user_stack_end
                  csrr x12, 0x300
                  csrr x16, 0x304
                  csrw 0x300, x12
                  csrw 0x304, x16
main:             jal          t4, 1f
0:                jal          t1, 3f
1:                jal          ra, 10f
2:                jal          t1, 6f
3:                jal          gp, 7f
4:                jal          tp, 9f
5:                jal          ra, 0b
6:                jal          t1, 13f
7:                jal          t1, 2b
8:                jal          t1, 12f
9:                jal          ra, 8b
10:               jal          tp, 11f
11:               jal          ra, 4b
12:               jal          ra, 5b
13:               csrrw        t0, 0x304, s11
                  la           t3, region_0+117 #start load_store_instr_stream_1
                  sb           s8, 38(t3)
                  la           t5, region_1+57616 #start load_store_instr_stream_0
                  lbu          tp, -45(t3)
                  lb           a2, 7(t3)
                  lb           ra, 1(t5)
                  lb           a4, -3(t5)
                  lb           a6, 34(t3)
                  lh           s3, 53(t3)
                  lhu          s2, 8(t5)
                  lhu          s9, 7(t3)
                  lhu          s8, -21(t3)
                  lb           s1, 5(t5)
                  lh           t1, 47(t3)
                  lbu          t4, -56(t3) #end load_store_instr_stream_1
                  sb           s5, 11(t5)
                  sw           zero, 8(t5) #end load_store_instr_stream_0
                  la           t3, region_1+47484 #start riscv_load_store_rand_instr_stream_17
                  lbu          t2, 59(t3)
                  auipc        s10, 926149
                  csrrsi       tp, 0x343, 27
                  sb           t6, -43(t3)
                  csrrsi       t2, 0x342, 0
                  or           t6, t4, s9
                  or           t6, a7, a4
                  sltiu        a4, a6, 1256
                  lw           s0, 8(t3)
                  lbu          a5, -13(t3)
                  csrrc        t6, 0x304, a2
                  lh           ra, -2(t3)
                  mulhu        s6, t6, sp
                  lb           a6, -43(t3)
                  andi         t0, s11, 251
                  add          s6, a4, t6
                  lbu          a6, 3(t3)
                  lb           t2, 16(t3)
                  mul          a1, a1, a5
                  lbu          a1, -43(t3)
                  sb           a1, -35(t3)
                  sh           a3, 26(t3)
                  lb           s5, 7(t3)
                  srai         t4, a6, 16
                  lhu          t6, 48(t3)
                  lb           t5, 1(t3)
                  slti         s8, t1, -922
                  sra          t0, zero, a5
                  lbu          a0, 6(t3)
                  sb           t5, 5(t3)
                  auipc        s8, 53461
                  sh           s7, -22(t3)
                  or           tp, s9, a7
                  mul          s11, a4, s7
                  lb           a2, -21(t3)
                  lh           s8, 22(t3)
                  or           t1, t3, s8
                  ori          t4, a6, -1594
                  lbu          a7, -35(t3)
                  sb           a3, -19(t3)
                  mul          zero, s7, gp
                  sh           s7, -8(t3)
                  lw           t6, -64(t3)
                  lb           a7, 11(t3)
                  nop
                  lhu          a4, -20(t3)
                  sra          s5, s9, s11
                  csrrwi       s6, 0x344, 18
                  csrrs        t4, 0x300, zero
                  lbu          t5, 22(t3)
                  lbu          a1, 21(t3)
                  lb           a4, -55(t3) #end riscv_load_store_rand_instr_stream_17
                  li           a1, 0xbf79a035 #start riscv_int_numeric_corner_stream_33
                  li           s0, 0x80000000
                  li           t0, 0x80000000
                  li           s3, 0xc0cea990
                  li           s2, 0x0
                  li           a4, 0xe838af30
                  li           t2, 0x0
                  li           s4, 0x0
                  li           a6, 0x2c94fc28
                  li           tp, 0xffffffff
                  nop
                  lui          tp, 196859
                  mulh         a6, tp, a6
                  auipc        s0, 785772
                  mulhsu       s2, a4, t0
                  div          s0, tp, s3
                  divu         t2, a1, tp
                  mulh         s4, tp, tp
                  mulhu        t2, t0, s2
                  rem          t2, t0, a1
                  mulhu        t0, s3, t2
                  rem          t0, s4, a6
                  auipc        a4, 402539
                  rem          t2, a1, a1
                  nop
                  div          s2, t2, s3
                  mulh         s3, s0, s4
                  div          s3, s3, s0
                  nop
                  divu         a4, s3, a1
                  addi         s4, t0, 1645
                  lui          tp, 932795
                  remu         a4, a6, t0
                  remu         tp, a6, t2
                  add          a1, s4, s3
                  nop
                  remu         s2, a4, t0
                  rem          a1, s3, a4
                  mulhu        s4, s4, t0
                  divu         a4, t0, a6 #end riscv_int_numeric_corner_stream_33
                  la           a0, region_0+1554 #start riscv_load_store_hazard_instr_stream_35
                  lb           t4, -29(a0)
                  lbu          s5, -29(a0)
                  lbu          t2, -29(a0)
                  lbu          t1, -29(a0)
                  sra          s3, s9, a4
                  sb           s10, -29(a0)
                  lbu          a4, -29(a0)
                  sb           t3, -29(a0)
                  lb           s2, -29(a0)
                  sb           s11, -29(a0)
                  srli         t2, gp, 22
                  lb           tp, -13(a0)
                  lb           s4, -13(a0)
                  lbu          a2, -13(a0)
                  sb           gp, -13(a0)
                  sb           t3, -13(a0)
                  lbu          t3, -13(a0)
                  sb           a2, -13(a0)
                  sb           ra, -13(a0) #end riscv_load_store_hazard_instr_stream_35
                  la           t0, region_0+1309 #start load_store_instr_stream_1
                  la           s0, region_1+55849 #start load_store_instr_stream_0
                  sh           t0, 77(s0)
                  sh           t5, 41(t0)
                  lw           zero, -13(s0)
                  lh           a2, -133(s0)
                  sh           s8, -35(t0)
                  lbu          s1, -157(s0)
                  lbu          tp, -120(s0)
                  sb           t3, -4(t0)
                  lbu          a4, -37(t0)
                  sb           zero, 43(t0)
                  sh           s1, 29(t0)
                  sb           ra, -48(t0)
                  sw           s10, 167(s0)
                  lh           a1, -141(s0)
                  sb           t2, -38(t0) #end load_store_instr_stream_1
                  sh           s4, -201(s0) #end load_store_instr_stream_0
                  la           ra, region_0+1498 #start load_store_instr_stream_1
                  lb           t5, 15(ra)
                  la           t0, region_0+1844 #start load_store_instr_stream_0
                  lb           s11, 28(t0)
                  lb           s10, 16(t0)
                  lhu          s0, -14(ra)
                  lh           s2, 42(t0)
                  sh           s5, -58(t0)
                  sb           sp, -13(ra)
                  lbu          t3, -21(t0)
                  lbu          s3, -3(ra)
                  sb           t0, 21(t0)
                  lbu          s4, 4(ra)
                  sb           s4, 7(ra)
                  lbu          s4, 14(ra) #end load_store_instr_stream_1
                  lhu          s10, 10(t0) #end load_store_instr_stream_0
main_118:         jal          t4, 8f
0:                jal          ra, 9f
1:                jal          ra, 13f
2:                jal          ra, 0b
3:                jal          ra, 10f
4:                jal          t1, 5f
5:                jal          ra, 3b
6:                jal          ra, 4b
7:                jal          s0, 1b
8:                jal          ra, 6b
9:                jal          ra, 11f
10:               jal          ra, 2b
11:               jal          ra, 12f
12:               jal          tp, 7b
13:               divu         a5, t5, s5
                  la           s0, region_0+2369 #start load_store_instr_stream_1
                  la           t3, region_1+51143 #start load_store_instr_stream_0
                  lbu          a5, -12(t3)
                  lbu          s2, 42(t3)
                  lbu          s8, -6(t3)
                  sb           s10, 45(s0)
                  lb           s2, -60(s0)
                  lbu          s9, -49(t3)
                  lh           t4, 49(s0)
                  lw           a1, -49(s0)
                  lb           a2, -51(t3)
                  lw           s5, -37(s0)
                  lb           t1, 7(t3)
                  sb           s10, 20(s0) #end load_store_instr_stream_1
                  lb           s9, -14(t3) #end load_store_instr_stream_0
                  la           a2, region_1+12367 #start riscv_load_store_hazard_instr_stream_11
                  lb           s9, -62(a2)
                  lb           t0, -62(a2)
                  sb           s3, -62(a2)
                  sb           sp, -62(a2)
                  andi         a6, t2, -615
                  lb           t2, -62(a2)
                  csrrs        s4, 0x301, zero
                  addi         zero, s0, -1089
                  sb           s2, -62(a2)
                  lbu          ra, -62(a2)
                  lbu          s3, -62(a2)
                  lb           s9, -4(a2)
                  sb           a7, -4(a2)
                  lb           t4, -4(a2) #end riscv_load_store_hazard_instr_stream_11
                  la           s3, region_1+20915 #start riscv_load_store_rand_instr_stream_10
                  lb           s9, 60(s3)
                  sb           s7, 7(s3)
                  nop
                  csrrc        ra, 0x305, zero
                  csrrsi       s9, 0x300, 0
                  lbu          s0, -62(s3)
                  srai         ra, s7, 19
                  remu         s10, zero, t5
                  srli         t4, a0, 22
                  csrrci       s2, 0x342, 22
                  lb           t2, 32(s3)
                  sh           a2, -13(s3)
                  sltiu        a7, t2, 1049
                  lb           t3, -38(s3)
                  lb           a2, 32(s3)
                  lhu          t2, 15(s3)
                  or           s4, a5, gp
                  srl          ra, s8, a6
                  csrrc        t6, 0x343, gp
                  csrrsi       a1, 0x304, 0
                  slti         s9, s0, -22
                  xor          s2, t4, s5
                  lhu          t0, -59(s3)
                  srl          zero, t2, s9
                  sb           t5, -24(s3)
                  slli         a1, s5, 26
                  sb           s7, 11(s3)
                  auipc        a4, 527334
                  lbu          ra, 34(s3) #end riscv_load_store_rand_instr_stream_10
                  la           s2, region_1+5650 #start riscv_load_store_rand_instr_stream_25
                  add          t4, a6, s4
                  lbu          s8, -1269(s2)
                  xori         a6, s10, 714
                  lbu          s9, -353(s2)
                  lh           s0, -368(s2)
                  mulh         a6, s2, a5
                  lhu          s1, 416(s2)
                  lb           s11, 1913(s2)
                  slli         a2, s0, 4
                  sb           s11, -1483(s2)
                  slt          s5, s10, a2
                  lh           a5, -876(s2)
                  lbu          t1, -1969(s2)
                  lh           gp, 1344(s2)
                  andi         t5, s3, 953
                  addi         a6, t1, 39
                  lbu          s10, 684(s2)
                  lb           a4, -1720(s2)
                  sb           t5, 1297(s2)
                  sb           s4, -971(s2)
                  sb           s9, 168(s2)
                  sh           s5, 728(s2)
                  lb           s9, 1215(s2)
                  csrrsi       t6, 0x342, 18
                  lbu          t5, 1931(s2)
                  lb           s5, -403(s2)
                  lb           zero, 453(s2)
                  lb           a7, -1829(s2)
                  lb           s5, -962(s2)
                  lbu          s3, -733(s2)
                  lb           a6, 1479(s2)
                  ori          t0, zero, -2028
                  addi         s11, s0, -1895
                  sub          a7, s7, s11
                  sh           s10, 18(s2)
                  sb           s6, 1591(s2)
                  lb           t1, 741(s2) #end riscv_load_store_rand_instr_stream_25
                  la           s4, region_0+3574 #start riscv_hazard_instr_stream_37
                  csrrwi       t5, 0x304, 2
                  csrrw        s9, 0x342, s9
                  srl          s9, t4, s0
                  sb           s9, -169(s4)
                  sll          t4, t4, a4
                  ori          s0, t5, -2004
                  sb           s0, 181(s4)
                  lbu          s9, -251(s4)
                  lh           s0, 10(s4)
                  sltiu        t4, a1, -768
                  sb           a1, -101(s4)
                  remu         a1, a4, t5
                  lhu          a1, 204(s4)
                  sltu         t4, t5, s0
                  sh           s9, -162(s4)
                  sh           s9, -94(s4)
                  mulhsu       t4, s9, s0
                  lbu          s0, -237(s4)
                  lb           s9, 203(s4)
                  sltiu        a4, a4, -129
                  sb           s0, -119(s4)
                  csrrs        a4, 0x301, a1
                  xori         s0, s9, -937
                  and          s9, s9, a4
                  sb           a4, 189(s4)
                  lbu          t4, -154(s4)
                  lh           t5, -14(s4)
                  lbu          a4, 45(s4)
                  ori          a4, a4, 824
                  lh           s9, 210(s4)
                  xori         a4, s0, 1607
                  lhu          t5, 132(s4)
                  sh           a4, 176(s4)
                  lbu          s9, 206(s4)
                  add          a4, a4, t5
                  div          t5, s9, t5
                  lb           s0, 213(s4)
                  sltiu        t4, s9, -2016
                  csrrs        s9, 0x301, a1
                  or           s0, s0, a4
                  csrrci       t4, 0x300, 0
                  sltu         s9, a1, a4
                  xori         a4, t4, 1016
                  lbu          t5, 247(s4)
                  sb           a1, 95(s4)
                  sb           t4, 7(s4)
                  xor          a4, a1, t5
                  add          t5, s9, a1
                  sltiu        s0, a4, 1066
                  csrrsi       s0, 0x342, 10
                  sw           a4, -154(s4)
                  sub          s0, a1, s9
                  lh           t5, -28(s4)
                  lbu          s9, 97(s4)
                  lbu          s0, 77(s4)
                  lbu          s9, -229(s4)
                  lhu          t5, -150(s4) #end riscv_hazard_instr_stream_37
                  la           s1, region_0+1236 #start riscv_hazard_instr_stream_24
                  sb           a5, -821(s1)
                  lb           ra, 359(s1)
                  mulhu        ra, a5, t5
                  sh           ra, 1398(s1)
                  sub          s10, ra, s10
                  sh           a5, -362(s1)
                  nop
                  lb           a2, -565(s1)
                  lb           ra, 335(s1)
                  lhu          s10, 1930(s1)
                  sb           ra, 1575(s1)
                  csrrwi       s10, 0x343, 14
                  rem          a5, t5, s10
                  lbu          a1, -555(s1)
                  lb           ra, -733(s1)
                  srl          a2, a1, a5
                  lb           ra, 945(s1)
                  xor          s10, t5, ra
                  csrrw        a2, 0x304, a1
                  csrrc        a1, 0x343, ra
                  sb           a1, -881(s1)
                  sb           ra, 173(s1)
                  remu         t5, a1, ra
                  sh           ra, 258(s1)
                  remu         s10, ra, a1
                  sltu         s10, a5, a1
                  lbu          a1, 1101(s1)
                  lbu          a2, 645(s1)
                  lb           s10, -562(s1)
                  div          a2, s10, ra
                  csrrs        a1, 0x301, t5
                  sh           s10, -838(s1)
                  lb           s10, 1412(s1)
                  sb           a5, 1407(s1)
                  lb           a5, 292(s1)
                  lb           s10, -763(s1)
                  sw           a2, 1168(s1) #end riscv_hazard_instr_stream_24
                  la           s3, region_0+1242 #start riscv_load_store_hazard_instr_stream_1
                  lbu          t1, -175(s3)
                  sb           t6, -87(s3)
                  lb           a5, 149(s3)
                  lh           a2, -136(s3)
                  lb           t1, 124(s3)
                  lbu          a5, 113(s3)
                  lb           s6, 113(s3)
                  lw           zero, -126(s3)
                  lbu          a2, 228(s3)
                  remu         t4, t6, a2
                  lbu          a7, 228(s3)
                  sb           a1, 19(s3)
                  lbu          t6, 13(s3)
                  sb           zero, 13(s3)
                  sb           s9, -16(s3)
                  lh           s6, -2(s3)
                  lb           t2, 195(s3)
                  lbu          a6, 212(s3)
                  sb           t1, -91(s3)
                  lbu          t6, -31(s3)
                  addi         s4, s0, -1205
                  sb           a4, -31(s3) #end riscv_load_store_hazard_instr_stream_1
                  la           t3, region_1+42521 #start riscv_hazard_instr_stream_34
                  srl          a2, tp, s5
                  lb           s5, 10(t3)
                  sub          tp, s11, a5
                  sh           a5, 57(t3)
                  lb           a2, -134(t3)
                  sh           a2, 41(t3)
                  lbu          a2, -80(t3)
                  lb           s0, 176(t3)
                  sb           tp, -255(t3)
                  lui          a5, 981686
                  mulhu        tp, a5, s0
                  sll          a2, s11, a5
                  lbu          s0, -39(t3)
                  lhu          s0, -53(t3)
                  lb           s5, -114(t3)
                  lui          s11, 331297
                  lw           a2, -81(t3)
                  slti         s11, s11, 958
                  srai         a2, a2, 16
                  slli         s0, s11, 30
                  sb           a5, 128(t3)
                  auipc        s0, 244182
                  csrrci       tp, 0x301, 3
                  addi         a2, a2, -1651
                  rem          s0, s5, s5
                  lui          s0, 814061
                  lb           tp, 34(t3)
                  mul          s0, a2, a5
                  auipc        s5, 441010
                  sltiu        s11, a5, 1480
                  lui          a2, 355758
                  sh           a2, -213(t3)
                  sb           a2, -87(t3)
                  sb           s11, 210(t3)
                  lbu          s5, 93(t3)
                  div          tp, a2, s11
                  xori         s0, s11, 1980
                  remu         a2, tp, a2
                  rem          tp, a2, tp
                  srli         a5, a5, 18
                  xor          a5, s0, tp
                  sb           a2, 109(t3)
                  lbu          a2, 216(t3)
                  lb           s5, -2(t3)
                  lb           s5, -59(t3) #end riscv_hazard_instr_stream_34
                  la           gp, region_1+42852 #start riscv_hazard_instr_stream_29
                  sh           s2, 430(gp)
                  slt          t5, s2, ra
                  sb           t5, 1503(gp)
                  lbu          s4, -1010(gp)
                  lb           s4, 421(gp)
                  lb           s4, 808(gp)
                  sw           t5, 1724(gp)
                  slli         s1, s4, 10
                  srl          s2, t5, s1
                  mul          s2, tp, ra
                  sb           s2, 199(gp)
                  lbu          s1, -1405(gp)
                  slli         tp, s2, 18
                  lh           t5, -1372(gp)
                  or           tp, s1, s4
                  addi         ra, s2, -112
                  sb           s4, 131(gp)
                  lbu          s2, -1386(gp)
                  csrrc        s1, 0x342, t5
                  sh           ra, -1198(gp)
                  csrrc        t5, 0x343, s2
                  lbu          ra, -1418(gp)
                  mulhsu       s1, tp, t5
                  sh           tp, 394(gp)
                  csrrci       s1, 0x300, 0
                  lbu          t5, 1657(gp)
                  mulhsu       t5, s4, s2
                  div          t5, tp, tp
                  lbu          tp, 1603(gp)
                  srli         ra, s2, 0
                  sltiu        t5, tp, 1391
                  auipc        tp, 757621
                  div          tp, tp, ra
                  sh           t5, -546(gp)
                  lb           t5, -803(gp)
                  lb           s4, 1851(gp)
                  csrrwi       t5, 0x304, 9
                  and          ra, t5, tp
                  csrrw        s1, 0x343, s1
                  sb           s1, 1871(gp)
                  and          t5, t5, ra
                  lb           tp, 1086(gp)
                  srl          ra, ra, ra
                  nop
                  sh           s2, 640(gp)
                  csrrwi       s4, 0x342, 22
                  add          s2, t5, s4
                  csrrwi       ra, 0x301, 29
                  srl          tp, ra, ra
                  sh           s2, 1562(gp)
                  sb           tp, -1086(gp) #end riscv_hazard_instr_stream_29
                  la           a6, region_1+51038 #start load_store_instr_stream_0
                  la           a5, region_0+2691 #start load_store_instr_stream_1
                  sb           a2, -13(a6)
                  lb           gp, 2(a6)
                  sb           a4, 3(a6)
                  sh           t2, -89(a5)
                  lb           a4, -288(a5)
                  lhu          t5, -6(a6)
                  lb           t4, 0(a6)
                  sb           s10, -1146(a5)
                  lbu          s1, 15(a6)
                  lbu          s5, -105(a5)
                  lhu          s8, 2(a6)
                  sw           s10, -10(a6)
                  lbu          gp, 15(a6)
                  lbu          zero, 789(a5)
                  sh           t2, 485(a5) #end load_store_instr_stream_1
                  lbu          s9, 14(a6) #end load_store_instr_stream_0
                  addi         s2, zero, 10 #init loop 1 counter
                  andi         s3, a6, -2045
                  and          s5, a1, sp
                  sltu         s3, s9, a3
                  csrrsi       t3, 0x344, 0
                  addi         t5, zero, 7 #init loop 1 limit
main_236_1_t:     slti         s1, s9, 1399
                  addi         s2, s2, -4 #update loop 1 counter
                  addi         a6, zero, 5 #init loop 0 counter
                  sll          s1, s8, s1
                  rem          t2, t2, t4
                  addi         tp, zero, 5 #init loop 0 limit
                  div          s4, s0, sp
                  sub          t0, a4, s1
main_236_0_t:     mulhu        s4, s8, s7
                  addi         a6, a6, -3 #update loop 0 counter
                  divu         zero, a6, s11
                  bgeu         a6, tp, main_236_0_t #branch for loop 0
                  and          a7, s4, a6
                  csrrwi       s9, 0x301, 28
                  bgeu         s2, t5, main_236_1_t #branch for loop 1
                  sll          s0, s0, s4
                  addi         a6, zero, -10 #init loop 0 counter
                  addi         s8, gp, -944
                  and          t0, s9, s0
                  addi         t1, zero, 1 #init loop 0 limit
                  nop
                  add          t3, s10, a6
                  nop
main_205_0_t:     sltu         a2, t4, t2
                  addi         a6, a6, 9 #update loop 0 counter
                  mulhsu       s10, t6, tp
                  ori          s0, a2, 1481
                  csrrsi       s11, 0x343, 19
                  andi         t0, a4, -1860
                  ori          t0, t3, -1538
                  add          s9, s3, a2
                  blt          a6, t1, main_205_0_t #branch for loop 0
                  slti         s0, a0, -851
                  la           s11, region_1+62172 #start riscv_load_store_rand_instr_stream_5
                  mul          a7, t5, s2
                  srli         s2, s4, 26
                  csrrsi       t1, 0x343, 5
                  div          s2, s9, s9
                  sb           t1, 37(s11)
                  lhu          a0, -38(s11)
                  xor          a6, s4, a5
                  csrrsi       a0, 0x344, 29
                  lbu          t4, -177(s11)
                  xor          s2, a0, zero
                  lb           s5, 81(s11)
                  nop
                  sh           t5, -170(s11)
                  sh           tp, -90(s11)
                  sra          t3, a7, s4
                  sb           t5, 115(s11)
                  lbu          s9, -121(s11)
                  lbu          t6, -94(s11)
                  sw           ra, 40(s11)
                  addi         a0, a5, 1824
                  and          s10, a6, a5
                  lhu          a2, -194(s11)
                  sb           a5, -53(s11)
                  lw           s1, -104(s11)
                  mulhsu       s2, a5, a3
                  csrrwi       tp, 0x343, 24
                  sltiu        a1, t6, 561
                  lbu          t5, 110(s11)
                  lb           t4, 114(s11)
                  srl          s1, a0, s0
                  sh           s2, -40(s11)
                  sra          a2, t2, a4
                  lui          a2, 808397
                  lh           s1, -130(s11)
                  csrrw        s2, 0x304, a5
                  lbu          t5, 239(s11)
                  lh           ra, -158(s11)
                  sb           t1, -217(s11)
                  lb           s2, -59(s11)
                  lbu          s3, 250(s11)
                  or           s10, a2, a5
                  lb           t3, 136(s11)
                  lb           a0, 96(s11)
                  or           a0, a0, a5
                  lbu          ra, -255(s11)
                  nop
                  sb           zero, -69(s11)
                  and          s10, s8, gp
                  remu         s2, ra, s8
                  lb           a2, 228(s11)
                  and          s3, s3, s8
                  lui          s5, 485787
                  lh           t1, 16(s11)
                  add          s4, s2, t2
                  sub          s0, t4, s7
                  lb           s1, 103(s11)
                  lbu          s0, 113(s11) #end riscv_load_store_rand_instr_stream_5
                  addi         s8, zero, 10 #init loop 0 counter
                  csrrsi       s9, 0x301, 0
                  slli         t0, gp, 29
                  addi         a2, zero, 10 #init loop 0 limit
                  and          zero, s3, ra
                  csrrc        t1, 0x300, zero
main_238_0_t:     divu         gp, t3, t6
                  sra          tp, s10, t4
                  lui          s10, 141960
                  rem          s2, gp, s7
                  csrrw        a6, 0x301, s0
                  lui          s11, 458798
                  and          s6, a5, s7
                  sra          a1, s10, s5
                  or           a5, t0, s3
                  csrrc        s1, 0x344, s0
                  addi         s8, s8, -7 #update loop 0 counter
                  sltu         s3, s0, a2
                  csrrc        s3, 0x305, zero
                  sub          tp, s0, t2
                  mulhu        a5, s7, s11
                  sll          t3, a4, s9
                  mulhsu       s4, a3, gp
                  andi         s2, t4, -1154
                  lui          tp, 1046787
                  bgeu         s8, a2, main_238_0_t #branch for loop 0
                  srli         gp, t6, 7
                  addi         tp, zero, 9 #init loop 0 counter
                  mulhsu       t0, a0, tp
                  mul          ra, t6, s11
                  srai         s5, a0, 12
                  lui          s3, 371045
                  addi         a0, zero, 13 #init loop 0 limit
                  ori          a7, t4, -1764
                  ori          s2, a0, -574
main_228_0_t:     remu         s11, s10, t5
                  mulhsu       t0, t2, tp
                  sltiu        s0, s0, -1232
                  csrrci       zero, 0x344, 3
                  remu         s11, sp, s7
                  csrrc        s8, 0x300, zero
                  add          t5, tp, t5
                  sltiu        t2, t0, 271
                  csrrsi       t6, 0x301, 0
                  csrrc        t2, 0x342, zero
                  addi         tp, tp, 4 #update loop 0 counter
                  divu         s9, t5, t3
                  ori          s0, s4, 1035
                  lui          a5, 800150
                  auipc        s8, 550261
                  slti         s11, t5, -200
                  csrrci       t1, 0x304, 0
                  csrrsi       s9, 0x301, 25
                  sra          s5, s4, s0
                  divu         t1, s8, a1
                  beq          tp, a0, main_228_0_t #branch for loop 0
                  mulhu        ra, s7, t3
                  la           tp, region_1+37372 #start riscv_load_store_hazard_instr_stream_0
                  lb           zero, 292(tp)
                  sw           t4, 292(tp)
                  sh           t1, 1620(tp)
                  lw           s1, 1620(tp)
                  lb           a1, 1620(tp)
                  lh           t1, 1620(tp)
                  sb           s7, 1620(tp)
                  lw           a2, 1620(tp)
                  or           a7, t5, a3
                  mulh         s6, tp, ra
                  sw           s11, 1620(tp)
                  lhu          s5, 1620(tp)
                  sh           s7, 1620(tp)
                  sb           s7, 1620(tp)
                  addi         s4, s6, 765
                  lbu          s0, 1620(tp) #end riscv_load_store_hazard_instr_stream_0
                  la           a1, region_1+38982 #start riscv_load_store_rand_instr_stream_16
                  sb           s5, 170(a1)
                  lb           a7, 201(a1)
                  lbu          a2, 213(a1)
                  lh           s9, 106(a1)
                  sb           s1, -142(a1)
                  lbu          t0, -137(a1)
                  rem          s5, s8, a0
                  lbu          s6, 231(a1)
                  srl          s5, s3, s3
                  srl          gp, s9, a3
                  sb           a1, 243(a1)
                  lbu          t0, -97(a1)
                  lh           s6, 142(a1)
                  sb           s4, 234(a1)
                  mul          s9, t2, tp
                  divu         a5, a7, s5
                  xori         s10, a5, 740
                  sw           t3, -118(a1)
                  sb           sp, -90(a1)
                  lbu          s4, 42(a1)
                  srl          s9, ra, sp
                  mulhsu       ra, t4, s4
                  sb           s10, -35(a1)
                  lb           t0, -82(a1)
                  lb           a2, -189(a1)
                  add          t1, a0, a4
                  lbu          s9, 6(a1)
                  sh           s9, 22(a1)
                  sb           s3, -72(a1)
                  lui          ra, 652489
                  divu         s4, t6, t4
                  csrrw        a6, 0x343, a3
                  sh           gp, 132(a1)
                  auipc        t4, 963064
                  rem          a4, s0, a6
                  div          t6, s5, t6
                  csrrs        a5, 0x344, zero
                  sub          t1, sp, s7
                  sub          t4, a1, ra
                  sh           s5, -118(a1)
                  sltu         tp, a2, a2
                  mul          t2, a5, s9
                  sb           t0, -75(a1)
                  lw           t4, 102(a1)
                  slli         s3, s11, 22
                  slli         s11, t0, 3
                  mulhu        s2, s9, t6
                  sltiu        s3, tp, 1005
                  lbu          ra, -48(a1)
                  sh           a1, -80(a1)
                  ori          s2, a2, -731
                  sh           s3, 234(a1) #end riscv_load_store_rand_instr_stream_16
                  addi         s10, zero, 1 #init loop 0 counter
                  csrrwi       s8, 0x343, 9
                  csrrc        t5, 0x342, zero
                  sub          a7, a1, t3
                  div          a0, s11, t5
                  srai         a1, a1, 0
                  addi         s9, zero, -9 #init loop 0 limit
                  auipc        tp, 592703
                  srli         gp, t4, 8
                  srli         s1, s5, 11
                  div          a0, s2, t4
main_227_0_t:     nop
                  sltu         t3, s10, t4
                  addi         s10, s10, -2 #update loop 0 counter
                  csrrw        t5, 0x304, t2
                  sltiu        gp, tp, 1459
                  sra          a5, t1, s5
                  beq          s10, s9, main_227_0_t #branch for loop 0
                  srl          t1, tp, t0
main_94:          jal          t4, 17f
0:                jal          ra, 2f
1:                jal          t1, 21f
2:                jal          t4, 19f
3:                jal          gp, 1b
4:                jal          ra, 5f
5:                jal          ra, 18f
6:                jal          t0, 3b
7:                jal          t1, 15f
8:                jal          s6, 14f
9:                jal          ra, 10f
10:               jal          t2, 20f
11:               jal          ra, 9b
12:               jal          ra, 11b
13:               jal          ra, 6b
14:               jal          ra, 7b
15:               jal          ra, 0b
16:               jal          ra, 8b
17:               jal          ra, 4b
18:               jal          ra, 12b
19:               jal          tp, 13b
20:               jal          t1, 16b
21:               csrrc        s0, 0x300, zero
                  la           s5, region_0+1072 #start load_store_instr_stream_1
                  la           a2, region_0+3914 #start load_store_instr_stream_2
                  sb           ra, -49(s5)
                  la           t4, region_0+3570 #start load_store_instr_stream_3
                  lh           s1, -892(a2)
                  la           tp, region_0+3267 #start load_store_instr_stream_0
                  lb           s3, -52(tp)
                  sb           a2, 5(s5)
                  lbu          s3, -54(s5)
                  lw           t2, -2(t4)
                  lh           s9, 15(tp)
                  sb           t1, 19(s5)
                  lhu          s0, -25(tp)
                  lbu          a7, 10(s5)
                  sb           t4, 51(a2)
                  lh           s8, 61(tp)
                  lbu          s1, -4(t4)
                  lbu          ra, -27(s5)
                  lbu          s3, -929(a2)
                  sb           s0, 26(tp)
                  sw           ra, 48(s5)
                  lh           t2, 54(s5)
                  lbu          a0, -1069(a2)
                  lhu          a7, 53(tp)
                  lb           a6, -9(t4)
                  lhu          t1, 41(tp)
                  lb           s6, -5(t4)
                  sb           a4, -243(a2)
                  lb           a7, 49(s5)
                  sh           a6, -1896(a2)
                  sb           a0, 56(tp)
                  sb           t2, -855(a2)
                  lbu          ra, 3(t4)
                  sb           s8, 5(t4)
                  lbu          s4, 55(s5) #end load_store_instr_stream_1
                  sb           t1, -10(tp)
                  sh           gp, -14(t4)
                  lh           s3, -8(t4)
                  lbu          t3, -1545(a2)
                  lhu          a0, 102(a2) #end load_store_instr_stream_2
                  sb           tp, -6(t4) #end load_store_instr_stream_3
                  lhu          s8, 39(tp) #end load_store_instr_stream_0
                  la           s8, region_1+43000 #start riscv_hazard_instr_stream_1
                  rem          s0, t4, t6
                  sb           t4, -1579(s8)
                  addi         a0, s0, -388
                  sb           t6, -1976(s8)
                  mulh         t5, a0, a0
                  remu         t4, a0, t4
                  lbu          ra, 347(s8)
                  slti         t5, t6, 157
                  sltu         t6, s0, s0
                  sltiu        a0, a0, 130
                  csrrc        ra, 0x301, a0
                  lb           t5, 1804(s8)
                  sltiu        t4, s0, 1362
                  andi         s0, t4, 1059
                  lh           t5, 1822(s8)
                  ori          s0, t5, -335
                  lhu          t4, -110(s8)
                  mulhu        a0, a0, ra
                  lb           t6, -461(s8)
                  div          t5, t4, t4
                  lui          t5, 812031
                  slti         t6, t5, -1218
                  csrrw        a0, 0x342, s0
                  sb           ra, -282(s8)
                  lw           t4, -944(s8)
                  lbu          ra, -1691(s8)
                  slt          t4, s0, a0
                  slt          t6, t5, s0
                  lbu          a0, 913(s8)
                  nop
                  sub          s0, s0, t6
                  sb           a0, 835(s8) #end riscv_hazard_instr_stream_1
                  addi         a5, zero, -8 #init loop 0 counter
                  addi         s2, s5, -1049
                  lui          t4, 898843
                  sltiu        s1, t1, -1700
                  addi         t0, zero, -16 #init loop 0 limit
main_206_0_t:     lui          a1, 5244
                  or           s6, s3, s6
                  addi         a5, a5, -1 #update loop 0 counter
                  auipc        s1, 217286
                  and          ra, t3, t3
                  bge          a5, t0, main_206_0_t #branch for loop 0
                  csrrw        a0, 0x301, s0
                  li           s6, 0x0 #start riscv_int_numeric_corner_stream_9
                  li           a6, 0xffffffff
                  li           t0, 0x80000000
                  li           ra, 0x80000000
                  li           t5, 0xffffffff
                  li           s10, 0x2c48e501
                  li           tp, 0x0
                  li           s8, 0x80000000
                  li           t3, 0x80000000
                  li           s4, 0x0
                  div          ra, a6, tp
                  divu         s10, t0, s4
                  lui          tp, 1002302
                  mulhsu       ra, t5, ra
                  auipc        a6, 759721
                  div          s6, s6, ra
                  auipc        s6, 990250
                  div          s8, s10, s6
                  remu         tp, s10, t0
                  mulhsu       ra, t5, a6
                  mulhu        t5, s8, t0
                  lui          s10, 135484
                  mulh         ra, s4, ra
                  add          t0, ra, tp
                  nop
                  lui          s10, 185650
                  addi         s6, t3, 685
                  auipc        ra, 825867
                  remu         s6, t5, t3
                  lui          s10, 843364 #end riscv_int_numeric_corner_stream_9
                  la           a1, region_0+4011 #start load_store_instr_stream_1
                  sw           sp, 17(a1)
                  la           s0, region_1+54522 #start load_store_instr_stream_0
                  sb           s10, 25(s0)
                  lbu          a7, 36(s0)
                  sb           a7, 27(a1)
                  lbu          t2, 104(s0)
                  sb           tp, 36(a1)
                  lb           s6, 176(s0)
                  lbu          ra, -30(a1)
                  lh           gp, -1(a1)
                  lbu          zero, 2(a1)
                  lbu          zero, 4(a1)
                  lh           s4, 52(s0)
                  sh           ra, -17(a1) #end load_store_instr_stream_1
                  lbu          s1, -158(s0) #end load_store_instr_stream_0
                  la           s5, region_0+2012 #start load_store_instr_stream_2
                  la           a5, region_0+2554 #start load_store_instr_stream_1
                  la           tp, region_0+4081 #start load_store_instr_stream_0
                  lhu          t0, 86(s5)
                  lb           s11, 35(a5)
                  lbu          t1, -223(s5)
                  lb           t0, -6(tp)
                  lbu          s10, -144(s5)
                  lbu          ra, -79(s5)
                  lb           s2, 2(tp)
                  lbu          s1, -5(tp)
                  lb           s11, 136(s5)
                  lhu          zero, -64(a5)
                  lw           zero, 7(tp)
                  lbu          s2, 13(a5)
                  lb           s10, 1(tp)
                  lbu          s10, -63(a5)
                  lh           a6, -164(s5)
                  sh           tp, 56(a5)
                  lb           t1, 10(tp)
                  lhu          s0, 14(a5)
                  sb           ra, -4(tp)
                  lbu          s3, 25(a5)
                  lbu          zero, -176(s5) #end load_store_instr_stream_2
                  lw           s10, 7(tp)
                  sb           a5, -41(a5)
                  lb           t6, 15(a5) #end load_store_instr_stream_1
                  lb           a4, -12(tp) #end load_store_instr_stream_0
                  la           t6, region_0+3821 #start riscv_load_store_hazard_instr_stream_12
                  csrrsi       a2, 0x300, 0
                  lb           t1, -148(t6)
                  lbu          t3, -148(t6)
                  lhu          t0, -621(t6)
                  lbu          s5, -324(t6)
                  lhu          tp, -805(t6)
                  lb           s8, -1513(t6)
                  div          a5, ra, ra
                  lb           s8, -271(t6)
                  lb           a4, -398(t6)
                  lbu          a1, -398(t6)
                  csrrc        t1, 0x344, a0
                  lbu          gp, -398(t6)
                  lh           tp, -43(t6)
                  lb           gp, -214(t6)
                  sh           s5, 103(t6)
                  lhu          s6, -1835(t6) #end riscv_load_store_hazard_instr_stream_12
                  la           s2, region_0+305 #start riscv_load_store_rand_instr_stream_26
                  lh           s11, -41(s2)
                  lh           t5, 113(s2)
                  lb           t6, -228(s2)
                  sb           a4, 201(s2)
                  sb           s3, 59(s2)
                  sb           gp, 125(s2)
                  lb           t5, 176(s2)
                  lb           gp, -74(s2)
                  mulhsu       t3, t2, t1
                  sll          s11, a2, a7
                  lbu          t2, -196(s2)
                  lbu          t0, -242(s2)
                  sh           a6, 175(s2)
                  csrrwi       s8, 0x344, 9
                  lh           s1, -75(s2)
                  lhu          a6, 27(s2)
                  sh           a5, 211(s2)
                  mul          ra, s10, s9
                  div          s6, s9, s0
                  mul          t1, a0, s2
                  sh           zero, 173(s2)
                  mul          t6, sp, gp
                  sb           s11, -247(s2)
                  xor          s5, t2, s6
                  lb           zero, 240(s2)
                  lbu          s1, 176(s2)
                  add          a5, a4, s2
                  sb           t2, 126(s2)
                  lbu          t0, 5(s2)
                  sb           t2, -170(s2)
                  sltiu        s3, t1, -1096
                  sh           s3, 37(s2)
                  sh           ra, -127(s2)
                  sra          t4, a1, a7
                  lb           t1, 214(s2) #end riscv_load_store_rand_instr_stream_26
                  la           tp, region_0+2609 #start load_store_instr_stream_0
                  sb           s6, -216(tp)
                  la           s9, region_1+27919 #start load_store_instr_stream_1
                  lb           ra, 48(tp)
                  lb           gp, 6(s9)
                  sh           t3, -35(s9)
                  lb           s8, -4(tp)
                  sb           s6, -251(tp)
                  sb           a4, -48(s9)
                  sb           a4, 47(s9)
                  lbu          a6, -37(s9)
                  sb           sp, 240(tp)
                  sb           t4, 18(tp)
                  lh           a5, 7(s9) #end load_store_instr_stream_1
                  lb           s6, -190(tp) #end load_store_instr_stream_0
                  addi         s10, zero, 8 #init loop 0 counter
                  rem          tp, s3, s1
                  addi         s4, t1, 1071
                  addi         a4, zero, 19 #init loop 0 limit
                  xori         ra, a6, 170
main_217_0_t:     add          a0, t2, a0
                  and          t5, a6, zero
                  addi         s10, s10, 7 #update loop 0 counter
                  slti         s3, s5, -936
                  rem          ra, t1, s0
                  bltu         s10, a4, main_217_0_t #branch for loop 0
                  remu         t5, s6, t5
                  la           t3, region_0+2453 #start load_store_instr_stream_0
                  lbu          s0, -1780(t3)
                  la           t0, region_0+3486 #start load_store_instr_stream_1
                  lbu          a4, -969(t3)
                  lbu          s4, 1099(t3)
                  la           a5, region_0+674 #start load_store_instr_stream_2
                  sb           t6, 10(t0)
                  lb           gp, -1878(t3)
                  lb           a0, 0(t0)
                  lb           s0, -9(a5)
                  sw           a2, -10(t0)
                  lbu          s4, -11(a5)
                  sw           s5, -773(t3)
                  lb           a1, -13(t0)
                  lb           s0, 4(t0)
                  sh           a5, 4(a5)
                  sb           a6, -1410(t3)
                  lbu          a2, 13(a5)
                  lb           s2, -5(a5)
                  lbu          tp, -1(t0)
                  lb           s3, -1(t0)
                  lbu          s4, 0(t0) #end load_store_instr_stream_1
                  lb           s5, 1281(t3)
                  sb           t3, 14(a5) #end load_store_instr_stream_2
                  sb           sp, -1152(t3)
                  lb           s9, 495(t3) #end load_store_instr_stream_0
                  la           t0, region_1+36210 #start load_store_instr_stream_1
                  lbu          a1, 9(t0)
                  la           s8, region_0+656 #start load_store_instr_stream_0
                  sh           s10, -8(s8)
                  sb           s0, 150(s8)
                  lbu          s4, 5(t0)
                  lhu          t6, -26(s8)
                  lb           a7, 2(t0)
                  sb           a2, 57(s8)
                  sb           gp, 1(t0)
                  lw           s11, -2(t0)
                  sw           ra, -56(s8)
                  lbu          s3, -13(t0)
                  lb           a6, 31(s8)
                  lbu          s10, 5(t0) #end load_store_instr_stream_1
                  sb           t2, 179(s8)
                  lbu          zero, 9(s8) #end load_store_instr_stream_0
                  li           t6, 0x0 #start riscv_int_numeric_corner_stream_3
                  li           a2, 0xffffffff
                  li           gp, 0x21343e04
                  li           a5, 0x1a1d7eee
                  li           a7, 0xffffffff
                  li           s9, 0xffffffff
                  li           s5, 0x0
                  li           a4, 0x80000000
                  li           t2, 0xffffffff
                  li           s4, 0xfb74e1b0
                  remu         gp, t2, a7
                  mul          a4, a5, t2
                  mulhsu       a7, t6, gp
                  mulhsu       a2, a5, s9
                  mul          a5, t6, a2
                  mulhu        a2, s5, s9
                  auipc        t2, 779356
                  addi         a5, a2, -228
                  rem          t6, a2, s5
                  remu         s5, a5, s4
                  mulhsu       a5, s9, t2
                  remu         s4, a2, a4
                  auipc        s5, 806311
                  sub          gp, a7, s5
                  addi         s4, a4, 967
                  auipc        t6, 1014240 #end riscv_int_numeric_corner_stream_3
                  li           s6, 0x6b00e60c #start riscv_int_numeric_corner_stream_4
                  li           ra, 0x80000000
                  li           s9, 0xba3c35eb
                  li           s2, 0x80000000
                  li           a0, 0xc624a37a
                  li           t6, 0x80000000
                  li           t0, 0x1e8ac6dd
                  li           a4, 0x80000000
                  li           a5, 0x594281f6
                  li           gp, 0xffffffff
                  sub          s9, ra, gp
                  sub          t0, a4, s2
                  lui          s9, 776018
                  mul          s2, gp, a5
                  mulhu        gp, a0, s6
                  div          s9, t6, s9
                  sub          a4, a4, gp
                  mul          gp, s9, a0
                  mulhsu       s6, a5, s9
                  rem          s6, t6, s9
                  mulhu        a0, a0, s2
                  mulhsu       t6, a5, a4
                  lui          a4, 554635
                  div          t6, s2, a4
                  div          ra, a5, t0
                  divu         s6, t6, gp #end riscv_int_numeric_corner_stream_4
main_105:         jal          t4, 6f
0:                jal          ra, 5f
1:                jal          ra, 3f
2:                jal          t1, 9f
3:                jal          t0, 7f
4:                jal          t1, 10f
5:                jal          gp, 1b
6:                jal          t1, 8f
7:                jal          t1, 4b
8:                jal          t1, 2b
9:                jal          ra, 0b
10:               jal          t0, 11f
11:               sub          t5, a3, a6
                  la           tp, region_0+1885 #start riscv_load_store_hazard_instr_stream_22
                  lhu          s0, -55(tp)
                  slli         gp, a2, 2
                  ori          s8, s7, 540
                  lh           t1, -55(tp)
                  lb           s2, -55(tp)
                  sb           t4, -55(tp)
                  sb           gp, -55(tp)
                  lh           t2, -55(tp)
                  div          a0, a3, a6
                  lb           a0, -55(tp)
                  sh           gp, -55(tp)
                  lhu          gp, -55(tp)
                  lh           a2, 191(tp) #end riscv_load_store_hazard_instr_stream_22
                  la           s3, region_1+40063 #start riscv_load_store_hazard_instr_stream_33
                  csrrci       s10, 0x301, 16
                  mulh         a4, a2, t1
                  sb           a3, 530(s3)
                  lbu          s1, 530(s3)
                  lb           a4, 530(s3)
                  sb           t1, 362(s3)
                  lb           t1, 362(s3)
                  ori          s1, t4, -1620
                  sb           gp, 362(s3)
                  lhu          s6, -281(s3)
                  lh           s6, -281(s3)
                  lb           s9, 498(s3)
                  remu         zero, s3, s8
                  csrrs        tp, 0x305, zero
                  lb           t5, 498(s3)
                  sb           a2, -1181(s3)
                  sb           ra, -1900(s3)
                  lbu          s0, -1900(s3)
                  lh           a7, 187(s3)
                  lb           s6, 187(s3)
                  lb           s0, 187(s3) #end riscv_load_store_hazard_instr_stream_33
                  la           tp, region_0+2802 #start riscv_hazard_instr_stream_33
                  rem          t1, t4, t1
                  slt          t2, a4, s2
                  lbu          t1, 31(tp)
                  lb           t2, -51(tp)
                  addi         t1, s2, 1731
                  csrrc        t5, 0x344, t5
                  nop
                  sh           a4, -36(tp)
                  slti         s2, t5, 1124
                  lbu          t5, 43(tp)
                  xori         t4, a4, -135
                  sll          s2, a4, t5
                  mulhsu       t2, t5, a4
                  lhu          a4, 28(tp)
                  csrrw        t1, 0x304, t5
                  ori          t1, t1, -1981
                  nop
                  sb           t2, 38(tp)
                  auipc        t2, 462845
                  or           a4, t2, a4
                  sub          t5, t2, t1
                  lbu          t1, 24(tp)
                  lui          a4, 870955
                  csrrci       s2, 0x342, 19
                  or           s2, a4, s2
                  sltu         t4, t1, t4
                  lh           t5, 4(tp)
                  nop
                  lb           t4, 62(tp)
                  sub          t5, t2, t5
                  divu         t4, t5, t2
                  mulh         t2, t2, s2
                  remu         a4, t4, t1
                  mulh         t4, t1, t1
                  csrrwi       s2, 0x304, 2
                  sra          s2, a4, t4
                  xor          t4, s2, t2
                  sh           t5, 32(tp)
                  add          t2, a4, t5
                  lb           t5, -31(tp)
                  lh           t1, 36(tp)
                  lbu          t2, 54(tp)
                  remu         s2, s2, s2
                  sb           a4, -3(tp)
                  sb           t4, 19(tp) #end riscv_hazard_instr_stream_33
                  la           a1, region_1+21918 #start riscv_load_store_hazard_instr_stream_34
                  lh           s10, 56(a1)
                  remu         ra, a4, t4
                  lhu          ra, 56(a1)
                  lb           s3, 56(a1)
                  lb           a2, 25(a1)
                  lbu          t4, 51(a1)
                  sb           t3, -58(a1)
                  sh           s11, -58(a1)
                  lh           s10, 38(a1)
                  lw           s2, 38(a1)
                  lb           s5, -12(a1)
                  lb           zero, -12(a1)
                  sb           s2, -47(a1)
                  lb           s5, 61(a1) #end riscv_load_store_hazard_instr_stream_34
                  la           a1, region_0+404 #start riscv_hazard_instr_stream_18
                  sub          s5, s0, s10
                  ori          s9, s5, 1008
                  mulhsu       a2, s9, s10
                  lb           s0, 74(a1)
                  and          t4, s9, s0
                  addi         a2, s9, 446
                  mulhu        a2, s9, s0
                  lb           s0, 144(a1)
                  csrrci       s10, 0x343, 15
                  addi         s10, s0, -1934
                  sh           s0, -112(a1)
                  slti         s0, s5, -1500
                  sh           a2, -92(a1)
                  csrrwi       s0, 0x342, 18
                  ori          s5, t4, 1308
                  xor          s10, s10, a2
                  lh           t4, 152(a1)
                  lb           s9, 85(a1)
                  sub          t4, s10, s5
                  or           t4, s10, a2
                  mulh         t4, s5, s5
                  remu         a2, a2, t4
                  remu         t4, s5, s5
                  csrrw        s10, 0x304, s0
                  csrrwi       s9, 0x301, 18
                  sltu         t4, s0, a2
                  lbu          s5, -46(a1)
                  lb           s0, -146(a1)
                  lui          t4, 211846
                  lbu          a2, -213(a1)
                  add          s10, s10, s0
                  lui          s0, 31098
                  srl          t4, s9, s5
                  lb           s5, 65(a1)
                  lb           a2, 130(a1)
                  sh           s9, -50(a1)
                  auipc        s5, 1003039
                  slli         s9, s10, 29
                  sltiu        s0, s5, -1791
                  add          s9, s10, s5
                  addi         s9, t4, 373
                  sb           s10, 136(a1) #end riscv_hazard_instr_stream_18
main_100:         jal          t4, 4f
0:                jal          ra, 18f
1:                jal          ra, 2f
2:                jal          ra, 3f
3:                jal          ra, 14f
4:                jal          s10, 11f
5:                jal          s3, 7f
6:                jal          ra, 15f
7:                jal          t1, 16f
8:                jal          a5, 10f
9:                jal          ra, 6b
10:               jal          t1, 17f
11:               jal          ra, 12f
12:               jal          ra, 8b
13:               jal          a6, 5b
14:               jal          ra, 0b
15:               jal          ra, 13b
16:               jal          s3, 1b
17:               jal          ra, 9b
18:               divu         a7, s1, s3
                  li           t3, 0x0 #start riscv_int_numeric_corner_stream_31
                  li           t2, 0xffffffff
                  li           a0, 0xffffffff
                  li           tp, 0x768ca92f
                  li           a2, 0x0
                  li           s10, 0xffffffff
                  li           a4, 0x80000000
                  li           s2, 0x80000000
                  li           a1, 0x80000000
                  li           s6, 0x80000000
                  sub          s2, t2, a4
                  nop
                  remu         a4, s10, s2
                  mulh         s10, a2, s2
                  lui          s2, 357808
                  divu         s2, s6, a4
                  divu         a4, tp, a0
                  divu         t3, s6, s2
                  add          a2, s10, a2
                  addi         a4, a2, 1758
                  add          a4, s10, a0
                  nop
                  mulh         a1, a2, s6
                  sub          t3, s6, a2
                  sub          a0, t3, a4
                  sub          a4, s6, s2
                  mulh         a2, a1, t2 #end riscv_int_numeric_corner_stream_31
                  la           s3, region_1+65024 #start riscv_hazard_instr_stream_39
                  sb           s0, -1755(s3)
                  csrrsi       s0, 0x300, 0
                  div          s10, s0, s10
                  srl          s1, a5, s1
                  andi         a5, s1, -1487
                  sw           a5, -968(s3)
                  lbu          gp, -2009(s3)
                  mulhu        a6, s0, s10
                  auipc        gp, 324645
                  sltiu        a6, s10, 1981
                  csrrwi       a5, 0x304, 3
                  lh           s1, -1700(s3)
                  sb           s1, 285(s3)
                  xori         s1, gp, 1832
                  lb           s0, -1253(s3)
                  lh           s0, -386(s3)
                  lui          gp, 144564
                  lb           s10, -1421(s3)
                  sub          a5, s0, gp
                  lb           s1, -381(s3)
                  lhu          a5, -450(s3)
                  mulhsu       a5, a6, s0
                  csrrw        gp, 0x344, gp
                  csrrs        s0, 0x301, gp
                  lb           a5, -401(s3)
                  sb           a6, -415(s3)
                  sw           a6, -380(s3)
                  srl          s10, s0, s10
                  srl          a6, gp, a5
                  lbu          s0, -1601(s3)
                  sb           s10, -1185(s3)
                  lh           a5, -354(s3)
                  slti         a6, a6, 470
                  lui          s1, 137019
                  csrrs        gp, 0x343, s10
                  srai         a5, gp, 5
                  sb           a6, -32(s3)
                  csrrw        a5, 0x304, s0
                  slti         s0, s1, 1235
                  slli         s0, s1, 6
                  slt          a5, a5, s1
                  remu         s10, s0, a6
                  lb           a6, -1383(s3) #end riscv_hazard_instr_stream_39
                  la           s10, region_1+54112 #start riscv_load_store_rand_instr_stream_27
                  sltiu        a1, a5, -300
                  sb           a6, -5(s10)
                  sub          a1, gp, t1
                  csrrs        zero, 0x304, zero
                  sltu         gp, a0, t5
                  add          t6, a0, s11
                  lbu          t2, 6(s10)
                  lbu          t5, 1(s10)
                  lbu          s9, 7(s10)
                  mulhu        s9, s1, t3
                  csrrci       t2, 0x342, 15
                  divu         t1, t2, s0
                  sb           a0, -11(s10)
                  addi         a1, s4, 681
                  sub          a4, s1, t0
                  sltiu        s0, s7, -401
                  lb           tp, 15(s10)
                  lh           s3, -16(s10)
                  lhu          a6, -6(s10)
                  lh           t4, -12(s10)
                  lb           t0, -10(s10)
                  addi         a0, a1, -633
                  csrrwi       s5, 0x342, 12
                  remu         s5, a6, ra
                  lh           a4, -10(s10)
                  rem          t6, t6, a6
                  sb           s4, -12(s10)
                  csrrw        s6, 0x304, t6
                  sb           a6, 5(s10)
                  add          zero, a3, s8
                  sb           s0, -10(s10)
                  nop
                  lbu          t6, 5(s10)
                  lbu          t6, -11(s10)
                  lb           s0, -5(s10)
                  lbu          s8, 7(s10)
                  srl          a1, t3, ra
                  lbu          s2, -9(s10)
                  csrrs        a0, 0x301, s2
                  ori          s0, s10, -448
                  auipc        ra, 200508
                  sb           s10, 1(s10)
                  csrrc        a5, 0x300, zero
                  lb           zero, 3(s10)
                  lhu          a5, 6(s10)
                  sb           s5, 14(s10) #end riscv_load_store_rand_instr_stream_27
                  addi         t6, zero, -10 #init loop 0 counter
                  addi         s9, zero, -12 #init loop 0 limit
main_231_0_t:     ori          s8, s0, -686
                  div          zero, t2, a0
                  addi         t6, t6, -3 #update loop 0 counter
                  bge          t6, s9, main_231_0_t #branch for loop 0
                  add          s2, a7, s3
                  la           a5, region_0+3903 #start riscv_load_store_hazard_instr_stream_38
                  csrrs        s3, 0x305, zero
                  slli         a6, s5, 8
                  lbu          s0, -1654(a5)
                  sb           t6, -1654(a5)
                  lb           s6, -1654(a5)
                  sb           gp, -1654(a5)
                  sub          s11, t0, tp
                  lbu          s9, -1654(a5)
                  lbu          s10, -1618(a5)
                  lbu          s1, -1618(a5)
                  srli         s2, s6, 24
                  mulhsu       s5, a0, s11
                  lb           s6, -2028(a5)
                  lbu          ra, -650(a5)
                  lbu          a6, -650(a5)
                  lb           s0, -650(a5)
                  sb           t3, -650(a5)
                  sltu         a2, ra, zero
                  lb           s8, -650(a5)
                  lbu          s11, -650(a5)
                  lbu          s6, -370(a5) #end riscv_load_store_hazard_instr_stream_38
                  la           s10, region_1+5229 #start riscv_hazard_instr_stream_13
                  lh           a2, 61(s10)
                  lh           a2, -9(s10)
                  sltu         a1, s3, a1
                  lb           s0, -17(s10)
                  csrrc        s3, 0x304, s0
                  lbu          a2, -17(s10)
                  csrrc        a2, 0x304, a7
                  sb           s3, -19(s10)
                  srl          a1, a1, a7
                  rem          a1, a7, s3
                  nop
                  lbu          a7, -40(s10)
                  sb           a2, -20(s10)
                  lui          a4, 756787
                  xori         a4, a7, 194
                  csrrs        a4, 0x343, a2
                  sh           a7, -55(s10)
                  and          a1, a4, a7
                  mulhsu       a1, s3, a4
                  nop
                  lb           a2, 59(s10)
                  lbu          a2, -4(s10)
                  lw           s3, 63(s10)
                  sll          s0, a1, a7
                  csrrsi       a4, 0x343, 2
                  lw           s3, -5(s10)
                  lbu          s0, -5(s10)
                  mulhu        s3, a4, s3
                  nop
                  lh           a1, 23(s10)
                  mulhu        s0, a1, s0
                  srl          a4, s3, s0
                  sb           s0, -27(s10)
                  sltu         a2, a7, s0
                  sb           a2, -9(s10)
                  sh           a4, 33(s10)
                  add          s3, s0, s3
                  or           a4, s3, s3
                  mulh         s0, a2, a7
                  sw           a1, -45(s10) #end riscv_hazard_instr_stream_13
main_110:         jal          t4, 4f
0:                jal          ra, 10f
1:                jal          t1, 7f
2:                jal          ra, 5f
3:                jal          ra, 2b
4:                jal          ra, 6f
5:                jal          ra, 8f
6:                jal          s10, 9f
7:                jal          a2, 0b
8:                jal          s1, 1b
9:                jal          ra, 3b
10:               andi         t5, a7, -368
                  li           s10, 0x80000000 #start riscv_int_numeric_corner_stream_10
                  li           t0, 0x80000000
                  li           tp, 0x0
                  li           s0, 0xffffffff
                  li           s3, 0x80000000
                  li           s1, 0xffffffff
                  li           s11, 0x59853677
                  li           s2, 0x80000000
                  li           a6, 0x7a3f73e
                  li           t1, 0xf0593def
                  mul          s3, s10, s11
                  mulhsu       tp, s0, s10
                  mulh         s2, s0, s2
                  auipc        s2, 462081
                  mulhsu       s10, a6, t0
                  mulhu        s1, s2, tp
                  div          t0, s1, s0
                  nop
                  mul          s0, a6, a6
                  mulhsu       t1, s11, s11
                  mulhsu       tp, s10, s0
                  lui          t0, 13307
                  add          s3, s0, t0
                  addi         s1, tp, 1205
                  auipc        s11, 650307
                  mulhsu       s1, tp, s0 #end riscv_int_numeric_corner_stream_10
                  la           s5, region_0+833 #start load_store_instr_stream_1
                  sb           t1, 165(s5)
                  la           s1, region_0+21 #start load_store_instr_stream_4
                  sh           s2, 57(s1)
                  la           s9, region_0+690 #start load_store_instr_stream_2
                  la           a6, region_0+2650 #start load_store_instr_stream_0
                  sb           zero, -2(s1)
                  la           a1, region_0+244 #start load_store_instr_stream_3
                  sb           tp, 60(s9)
                  sb           s10, -6(s1)
                  lbu          s0, 3(a6)
                  sb           s0, -63(s9)
                  sb           gp, 151(s5)
                  sh           zero, 29(s1)
                  lb           s2, -41(a1)
                  sb           t3, -158(s5)
                  lbu          t1, 119(s5)
                  lbu          t4, 41(s9)
                  lb           tp, 58(s1)
                  lb           a5, -45(a1)
                  lhu          s11, 25(s1)
                  lbu          s3, 41(a1)
                  sb           t2, 51(a1)
                  sb           a2, -5(a6)
                  sb           t0, 202(s9)
                  lbu          tp, -187(s9)
                  lb           a0, 0(a1)
                  sb           s10, -1(a6)
                  sb           a6, -242(s5)
                  sb           s9, 11(a6)
                  lb           gp, -44(a1)
                  lh           a5, 56(s9)
                  sh           a0, 40(a1)
                  sw           s10, -2(a6)
                  sh           s1, -1(s1)
                  lbu          a0, 9(a1)
                  sh           t6, -6(s9)
                  lbu          a5, -194(s5)
                  sb           t4, 236(s9)
                  sb           s3, 1(a6)
                  lb           t0, 24(s1) #end load_store_instr_stream_4
                  lb           s4, -37(s9)
                  lb           ra, 3(a6)
                  sb           t0, 63(a1) #end load_store_instr_stream_3
                  lbu          a5, 98(s9) #end load_store_instr_stream_2
                  sb           s8, -242(s5) #end load_store_instr_stream_1
                  sb           a2, -5(a6) #end load_store_instr_stream_0
                  addi         s8, zero, -9 #init loop 0 counter
                  addi         a7, zero, 18 #init loop 0 limit
                  nop
main_215_0_t:     sltu         gp, s3, t0
                  addi         s8, s8, 3 #update loop 0 counter
                  bne          s8, a7, main_215_0_t #branch for loop 0
                  srli         s5, t0, 14
                  la           a4, region_0+3755 #start riscv_hazard_instr_stream_22
                  xori         ra, s1, 450
                  sb           s3, -8(a4)
                  lb           t0, -14(a4)
                  lh           s1, 15(a4)
                  sb           a1, 14(a4)
                  lb           t0, 12(a4)
                  mulh         s3, t0, a1
                  mulhsu       a1, s6, ra
                  remu         a1, a1, s1
                  lhu          t0, -3(a4)
                  lb           s1, 0(a4)
                  lb           s1, 12(a4)
                  sh           s3, -9(a4)
                  lb           s6, 0(a4)
                  lw           t0, 5(a4)
                  lb           t0, -4(a4)
                  sh           s1, 11(a4)
                  csrrw        s6, 0x343, s3
                  sb           s1, 0(a4)
                  lb           ra, 0(a4)
                  sb           a1, 2(a4)
                  sb           a1, -16(a4)
                  lh           s3, 1(a4)
                  lb           a1, 9(a4)
                  mulhu        s1, ra, s6
                  lbu          s3, 9(a4)
                  mul          a1, s6, a1
                  sb           s1, -16(a4)
                  sra          ra, s3, s3
                  slti         a1, s6, 470
                  lb           s3, -8(a4)
                  or           s3, s1, ra
                  sw           a1, 1(a4) #end riscv_hazard_instr_stream_22
                  la           t2, region_1+17960 #start load_store_instr_stream_0
                  la           s0, region_1+29107 #start load_store_instr_stream_1
                  lhu          t1, 9(s0)
                  lbu          a0, -13(t2)
                  lbu          tp, 1195(t2)
                  sb           a6, -2(s0)
                  lbu          t4, -15(s0)
                  lb           gp, 4(s0)
                  sw           s10, -1192(t2)
                  lb           t4, 117(t2)
                  lh           a4, -5(s0)
                  sb           t5, -6(s0)
                  lb           tp, -9(s0)
                  sb           t0, 935(t2)
                  lbu          gp, -16(s0)
                  sb           a5, -2(s0) #end load_store_instr_stream_1
                  lbu          a2, -496(t2)
                  lb           t3, -1464(t2) #end load_store_instr_stream_0
                  la           t2, region_0+879 #start load_store_instr_stream_4
                  la           s6, region_0+573 #start load_store_instr_stream_3
                  la           s11, region_0+1414 #start load_store_instr_stream_1
                  la           t6, region_0+1485 #start load_store_instr_stream_2
                  sb           s11, 1731(s11)
                  la           t4, region_0+3269 #start load_store_instr_stream_0
                  lbu          t1, -1203(s11)
                  sh           t6, -133(s6)
                  sw           t1, 203(s6)
                  lb           s8, 14(t6)
                  sh           s2, 589(t4)
                  lb           a1, -195(t6)
                  lbu          t0, -9(s11)
                  lhu          s9, 215(t6)
                  lb           a0, 27(t6)
                  lh           s8, -1783(t4)
                  lbu          t0, 8(t2)
                  lb           s0, -1012(s11)
                  sh           s11, 227(s6)
                  lbu          s8, 32(t2)
                  sh           zero, -7(t2)
                  sh           sp, -7(t2)
                  sb           zero, 114(t6)
                  lb           a6, 1112(s11)
                  lbu          t1, -56(t6)
                  lbu          a1, -1790(t4)
                  lbu          a7, 70(s6)
                  lh           a2, 21(t6)
                  sb           t2, -1032(s11)
                  lbu          s9, 654(t4)
                  lb           t5, 60(t2)
                  sb           a6, 1751(s11)
                  lb           t1, 657(t4)
                  sw           a5, -173(t6)
                  lhu          s3, 59(t2) #end load_store_instr_stream_4
                  lbu          t5, 27(t6) #end load_store_instr_stream_2
                  lbu          s1, -250(s6)
                  lbu          t3, -190(s6) #end load_store_instr_stream_3
                  sb           t1, -921(s11) #end load_store_instr_stream_1
                  lb           zero, -1847(t4) #end load_store_instr_stream_0
                  la           a0, region_0+2896 #start riscv_load_store_hazard_instr_stream_30
                  lbu          a1, 523(a0)
                  lbu          a6, 523(a0)
                  lbu          a4, 523(a0)
                  lbu          t4, 523(a0)
                  sb           s8, 523(a0)
                  lbu          s0, 523(a0)
                  lbu          a7, 523(a0)
                  lb           a4, 523(a0)
                  csrrci       s3, 0x300, 0
                  lbu          t3, 523(a0)
                  sb           s11, 523(a0)
                  auipc        s9, 934683
                  sb           t2, 523(a0)
                  sh           a5, -718(a0)
                  sh           a5, -718(a0)
                  srl          t1, s7, a0
                  lb           s3, -718(a0)
                  sb           s0, -718(a0)
                  lb           zero, -718(a0)
                  sh           s9, -718(a0)
                  lhu          s8, -718(a0)
                  sh           s8, -718(a0)
                  sltu         s0, tp, s4
                  csrrw        s2, 0x342, t6
                  lhu          s9, -718(a0) #end riscv_load_store_hazard_instr_stream_30
                  la           s1, region_1+1815 #start riscv_load_store_hazard_instr_stream_16
                  lbu          ra, 550(s1)
                  lbu          s3, 550(s1)
                  sb           a1, 550(s1)
                  lb           t5, 550(s1)
                  lbu          s8, 550(s1)
                  lb           t6, 550(s1)
                  sh           s1, -1677(s1)
                  lh           s6, -1677(s1)
                  sh           zero, -1677(s1)
                  sh           s5, -1739(s1)
                  lb           t4, -1739(s1)
                  lbu          t3, -1739(s1)
                  lhu          s11, -1607(s1)
                  sll          t4, t4, s8
                  lhu          a2, -1607(s1)
                  lb           s3, 632(s1)
                  lbu          zero, -689(s1)
                  sb           s3, -689(s1) #end riscv_load_store_hazard_instr_stream_16
                  la           a5, region_0+3861 #start load_store_instr_stream_1
                  la           a6, region_1+56516 #start load_store_instr_stream_0
                  lhu          t5, -8(a6)
                  lb           a2, -2(a6)
                  lw           t4, -61(a5)
                  sb           t1, -9(a6)
                  lbu          s9, 39(a5)
                  sb           t1, 13(a5)
                  lbu          s2, 11(a6)
                  lh           s10, 6(a6)
                  lbu          s0, 33(a5)
                  lh           zero, 4(a6)
                  lbu          s9, -42(a5)
                  lbu          zero, 22(a5)
                  sw           a3, 4(a6)
                  lh           s11, -61(a5)
                  lbu          t1, 40(a5)
                  sh           t2, -8(a6)
                  lbu          s0, -11(a5)
                  lb           s11, -9(a6)
                  lbu          s2, 20(a5) #end load_store_instr_stream_1
                  sb           s1, -11(a6) #end load_store_instr_stream_0
main_114:         jal          t4, 28f
0:                jal          ra, 1f
1:                jal          t1, 10f
2:                jal          s3, 7f
3:                jal          ra, 18f
4:                jal          s6, 13f
5:                jal          ra, 12f
6:                jal          ra, 11f
7:                jal          t1, 30f
8:                jal          a4, 24f
9:                jal          ra, 27f
10:               jal          ra, 25f
11:               jal          t1, 9b
12:               jal          t1, 23f
13:               jal          a6, 0b
14:               jal          a1, 4b
15:               jal          s1, 3b
16:               jal          ra, 5b
17:               jal          ra, 29f
18:               jal          gp, 17b
19:               jal          ra, 20f
20:               jal          ra, 21f
21:               jal          gp, 14b
22:               jal          tp, 19b
23:               jal          ra, 15b
24:               jal          s0, 2b
25:               jal          a2, 26f
26:               jal          ra, 16b
27:               jal          ra, 8b
28:               jal          t1, 22b
29:               jal          gp, 6b
30:               and          a0, sp, s10
                  la           gp, region_1+8089 #start riscv_hazard_instr_stream_7
                  lbu          t5, -29(gp)
                  srai         s11, s9, 25
                  slt          s9, s9, t6
                  lb           t6, -52(gp)
                  lbu          ra, -23(gp)
                  slt          s11, a1, s9
                  div          t5, s9, a1
                  lb           t6, -32(gp)
                  csrrw        t6, 0x301, a1
                  lbu          s11, -58(gp)
                  lb           t5, -27(gp)
                  sub          t6, t6, s11
                  lh           s11, 33(gp)
                  lbu          t6, 56(gp)
                  sb           s9, 50(gp)
                  remu         s9, s9, s9
                  csrrw        s9, 0x343, ra
                  divu         t6, ra, s11
                  slli         a1, a1, 27
                  lbu          s11, 1(gp)
                  nop
                  div          a1, t6, t6
                  and          ra, a1, ra
                  srli         t6, s11, 6
                  sb           t5, 34(gp)
                  lbu          t6, -26(gp)
                  mulh         t5, t5, s9
                  sb           ra, -3(gp)
                  mulhsu       t5, s11, s11
                  lb           s11, -27(gp) #end riscv_hazard_instr_stream_7
                  la           s5, region_0+1151 #start load_store_instr_stream_1
                  la           s2, region_0+3199 #start load_store_instr_stream_0
                  sb           t3, -82(s5)
                  lbu          a5, 572(s2)
                  sh           t1, -947(s5)
                  lb           a7, -1002(s5)
                  lbu          a4, -1759(s2)
                  lb           t0, 220(s2)
                  sb           t1, 252(s2)
                  sb           a0, 1192(s5)
                  sb           s4, 40(s2)
                  sb           tp, 315(s2)
                  sb           s5, -1289(s2)
                  lbu          s0, 1056(s5) #end load_store_instr_stream_1
                  lb           s1, -1084(s2) #end load_store_instr_stream_0
                  la           a6, region_0+424 #start load_store_instr_stream_2
                  la           s0, region_0+3991 #start load_store_instr_stream_1
                  la           s9, region_0+2835 #start load_store_instr_stream_0
                  sh           t2, -1841(s0)
                  lb           t5, 11(s9)
                  lbu          t1, -1046(s0)
                  lb           t4, 14(a6)
                  lbu          a1, -992(s0)
                  lb           t3, -3(a6)
                  lb           ra, 13(s9)
                  sb           a0, 6(a6)
                  lw           s2, 5(s9)
                  sw           ra, 13(s9)
                  lbu          t4, -904(s0)
                  lb           s5, 16(s0)
                  sb           a3, 5(a6)
                  sb           gp, -8(s9)
                  sh           a2, 15(s9)
                  lbu          a5, -5(a6)
                  lhu          s8, -557(s0) #end load_store_instr_stream_1
                  sb           s2, 1(a6)
                  lbu          s3, 2(s9)
                  lb           a5, -15(a6)
                  sw           a0, 16(a6) #end load_store_instr_stream_2
                  lb           a5, 12(s9)
                  lb           a2, 8(s9) #end load_store_instr_stream_0
                  la           a6, region_1+40280 #start load_store_instr_stream_1
                  sw           tp, 68(a6)
                  la           s4, region_0+1814 #start load_store_instr_stream_0
                  lb           a1, -87(a6)
                  sb           s9, -1098(s4)
                  lb           t6, -150(a6)
                  lhu          t2, -944(s4)
                  lb           s8, -7(a6)
                  lhu          s2, 594(s4)
                  sb           t2, -135(a6)
                  sh           a7, -210(a6)
                  lb           t0, 1684(s4)
                  lb           a5, 449(s4)
                  sw           a6, 252(a6)
                  lhu          ra, 1014(s4)
                  sb           t3, 7(a6) #end load_store_instr_stream_1
                  sb           s0, -1488(s4) #end load_store_instr_stream_0
main_97:          jal          t4, 9f
0:                jal          s4, 11f
1:                jal          ra, 10f
2:                jal          ra, 13f
3:                jal          ra, 2b
4:                jal          s8, 3b
5:                jal          a2, 0b
6:                jal          t3, 12f
7:                jal          ra, 4b
8:                jal          a0, 1b
9:                jal          t1, 5b
10:               jal          ra, 7b
11:               jal          ra, 6b
12:               jal          ra, 8b
13:               csrrs        t3, 0x344, zero
main_101:         jal          t4, 11f
0:                jal          ra, 12f
1:                jal          ra, 8f
2:                jal          ra, 15f
3:                jal          t1, 14f
4:                jal          a5, 16f
5:                jal          ra, 0b
6:                jal          a6, 4b
7:                jal          ra, 5b
8:                jal          ra, 3b
9:                jal          s10, 2b
10:               jal          t1, 13f
11:               jal          ra, 1b
12:               jal          t1, 9b
13:               jal          t6, 6b
14:               jal          a5, 7b
15:               jal          ra, 10b
16:               sll          a4, t2, t3
                  la           s9, region_1+3397 #start riscv_load_store_hazard_instr_stream_13
                  lb           s0, 4(s9)
                  sb           ra, 4(s9)
                  div          a2, s10, s10
                  lb           gp, 4(s9)
                  lb           s3, 0(s9)
                  csrrsi       t5, 0x342, 1
                  lbu          a2, 0(s9)
                  sb           t0, 14(s9)
                  lb           t0, -10(s9)
                  sb           a0, 7(s9)
                  lh           ra, 7(s9)
                  remu         t1, a7, s2
                  sw           a1, 7(s9)
                  lb           a6, -4(s9)
                  lbu          t1, -4(s9)
                  lbu          t1, -4(s9)
                  lhu          s10, -15(s9)
                  sltiu        a2, t1, 1239
                  sb           s1, 1(s9)
                  sw           zero, -9(s9)
                  lb           a0, 15(s9)
                  lbu          s1, -14(s9)
                  rem          s5, t5, s3
                  lb           a5, -14(s9) #end riscv_load_store_hazard_instr_stream_13
                  li           s0, 0x0 #start riscv_int_numeric_corner_stream_22
                  li           a4, 0x80000000
                  li           gp, 0x80000000
                  li           t0, 0x7a094c1e
                  li           ra, 0xffffffff
                  li           s10, 0xffffffff
                  li           s4, 0xffffffff
                  li           a0, 0xffffffff
                  li           s5, 0xe9d9fd00
                  li           a7, 0x0
                  mulh         s5, s10, gp
                  rem          gp, gp, a7
                  div          s0, t0, t0
                  lui          s0, 864314
                  rem          t0, s5, s10
                  nop
                  lui          a4, 62875
                  auipc        t0, 926749
                  remu         a4, gp, a7
                  divu         s10, a0, a7
                  sub          s5, t0, s10
                  addi         a7, s5, 634
                  nop
                  mulhsu       s4, a0, gp
                  rem          a7, gp, a0 #end riscv_int_numeric_corner_stream_22
                  li           a5, 0x0 #start riscv_int_numeric_corner_stream_5
                  li           s4, 0xbab6712a
                  li           t3, 0x0
                  li           s11, 0x848dde01
                  li           t4, 0x0
                  li           t1, 0x27219840
                  li           a0, 0xffffffff
                  li           a4, 0x2595d739
                  li           s3, 0x0
                  li           t2, 0x6bd95a33
                  rem          t4, a4, a5
                  nop
                  rem          s11, a4, s11
                  mulh         a0, a4, s11
                  divu         t4, a5, s3
                  mul          t4, a0, t4
                  mulhu        t1, s3, s11
                  nop
                  remu         s4, t3, a5
                  nop
                  sub          t3, t4, s4
                  lui          t3, 607264
                  mulhsu       t2, t1, t2
                  div          a5, t1, t2
                  nop
                  divu         t1, a4, s11
                  addi         t2, a5, 2024
                  lui          s11, 478682 #end riscv_int_numeric_corner_stream_5
                  la           s0, region_0+2548 #start riscv_hazard_instr_stream_20
                  lbu          s6, -11(s0)
                  csrrw        a0, 0x301, a7
                  lb           t2, -5(s0)
                  csrrs        t2, 0x342, t2
                  sll          a0, a0, a6
                  lb           a4, 5(s0)
                  and          a4, a6, a0
                  xori         t2, a4, 699
                  addi         t2, s6, 1661
                  slti         a7, t2, 728
                  mulhu        a4, s6, a4
                  lhu          a4, 16(s0)
                  sra          a6, a6, a6
                  lb           t2, 13(s0)
                  andi         a7, a0, 1011
                  lb           a0, -7(s0)
                  rem          a4, a4, a6
                  lb           a0, -9(s0)
                  xor          a6, a7, a4
                  xori         a4, a7, 687
                  srl          a4, a6, a0
                  sltiu        a0, a7, -1406
                  and          a7, a7, s6
                  sltiu        a0, a6, 1201
                  lbu          a7, -8(s0)
                  lhu          a6, 10(s0)
                  slt          s6, a0, t2
                  lb           s6, -3(s0)
                  sub          s6, a4, t2
                  lbu          a0, 11(s0)
                  csrrsi       a7, 0x344, 0
                  sb           a4, 11(s0)
                  sll          a7, a7, a6
                  slti         s6, a7, 1235
                  csrrs        t2, 0x343, s6
                  csrrc        a6, 0x344, s6
                  remu         a6, a0, t2
                  lbu          a7, 8(s0)
                  sw           a6, -4(s0)
                  lw           a0, -12(s0)
                  sb           t2, -7(s0)
                  sb           a0, -16(s0)
                  sb           a0, -14(s0)
                  lb           a6, 13(s0)
                  sh           s6, -16(s0)
                  or           t2, a4, s6
                  sh           a0, 0(s0)
                  sh           a7, 0(s0)
                  srl          a6, a4, a7
                  lb           t2, 2(s0)
                  lb           t2, 6(s0)
                  lhu          s6, 12(s0) #end riscv_hazard_instr_stream_20
                  la           tp, region_1+124 #start load_store_instr_stream_4
                  la           s2, region_1+1026 #start load_store_instr_stream_1
                  la           ra, region_1+18340 #start load_store_instr_stream_0
                  la           a6, region_1+36845 #start load_store_instr_stream_3
                  la           s5, region_1+54522 #start load_store_instr_stream_2
                  sb           s7, 1359(ra)
                  lbu          t4, 128(tp)
                  lb           s0, 132(a6)
                  sb           t5, 196(a6)
                  lb           a2, -910(ra)
                  lhu          a4, -122(tp)
                  lb           s9, -8(a6)
                  lhu          t5, -98(tp)
                  lbu          a2, 15(s2)
                  lb           t4, 1891(ra)
                  lh           a4, -31(a6)
                  sb           s10, -61(s2)
                  lh           s6, 224(tp)
                  lb           t6, -14(s5)
                  sb           t2, -62(tp)
                  lbu          s8, -29(s2)
                  lb           s4, 802(ra)
                  sw           a3, 540(ra)
                  sb           a3, 11(s5)
                  sb           s1, 1267(ra)
                  lb           s0, 35(tp)
                  sh           a1, -528(ra)
                  lbu          a5, -4(s2)
                  lb           a4, 13(s5)
                  sb           a3, 1765(ra)
                  lbu          s8, -21(s2) #end load_store_instr_stream_1
                  lbu          s3, 53(tp) #end load_store_instr_stream_4
                  sh           a6, 6(s5)
                  sb           s11, -3(s5) #end load_store_instr_stream_2
                  lbu          t3, -146(a6) #end load_store_instr_stream_3
                  sb           gp, 763(ra) #end load_store_instr_stream_0
                  li           a0, 0x0 #start riscv_int_numeric_corner_stream_15
                  li           ra, 0x80000000
                  li           t4, 0x0
                  li           a7, 0xffffffff
                  li           a1, 0x0
                  li           s6, 0xffffffff
                  li           t1, 0xffffffff
                  li           s10, 0x80000000
                  li           t3, 0x2ec0e716
                  li           s5, 0x1824d0cf
                  mulhu        s5, a7, ra
                  add          t4, t1, t3
                  mulhu        t4, s10, t4
                  mulhu        t3, t4, ra
                  lui          a0, 176613
                  addi         s6, a7, -313
                  nop
                  addi         t3, a1, -818
                  mulhsu       ra, a7, a7
                  divu         t4, s6, s6
                  rem          t3, ra, a1
                  add          t3, s10, t1
                  divu         s6, t4, ra
                  mulhsu       t3, a0, a0
                  mulhsu       s6, a0, s10
                  remu         s6, t3, s5
                  div          ra, t1, s5
                  add          s6, t1, s6
                  div          t4, t3, s5
                  divu         a7, a0, a1 #end riscv_int_numeric_corner_stream_15
                  la           a0, region_0+661 #start riscv_load_store_rand_instr_stream_4
                  auipc        s4, 598840
                  andi         a2, gp, 162
                  sra          s3, tp, a3
                  srli         gp, gp, 28
                  srli         a4, ra, 11
                  lbu          t6, 0(a0)
                  sb           s5, 3(a0)
                  lhu          s9, 13(a0)
                  and          s3, s5, gp
                  lui          a6, 263753
                  addi         s0, s8, 1547
                  slti         s9, a3, 988
                  divu         s11, s4, a7
                  divu         s6, s4, t5
                  rem          zero, s7, s5
                  sll          a6, s6, s2
                  lhu          a2, 15(a0)
                  sh           a1, 7(a0)
                  lbu          s9, 11(a0)
                  sra          s4, gp, s5
                  sb           s6, -6(a0)
                  sw           a0, 7(a0)
                  lb           zero, -6(a0)
                  sb           t4, 9(a0)
                  sltu         t5, a6, t6
                  lbu          t6, 6(a0)
                  remu         t2, s7, a5
                  sb           gp, 16(a0)
                  lbu          a1, 4(a0)
                  sb           a2, 11(a0)
                  lb           t5, 10(a0)
                  csrrwi       t0, 0x344, 3
                  csrrc        s4, 0x301, t6
                  add          a7, a0, s10
                  lw           s3, -1(a0)
                  csrrc        t4, 0x342, s6
                  lhu          s11, -7(a0)
                  sb           s0, 6(a0) #end riscv_load_store_rand_instr_stream_4
                  la           s10, region_1+5140 #start riscv_load_store_rand_instr_stream_7
                  lbu          a1, 153(s10)
                  sh           s6, 160(s10)
                  or           s1, s6, s0
                  srai         a0, s10, 23
                  lb           s6, 64(s10)
                  sb           s10, -245(s10)
                  lb           s1, 241(s10)
                  and          a7, s6, t0
                  csrrw        t3, 0x304, t1
                  sub          s0, t5, a5
                  and          s3, t1, s11
                  sra          a6, a5, a7
                  lbu          s1, -215(s10)
                  mulhsu       t6, s4, t5
                  sra          a6, a0, s5
                  lb           a0, -197(s10)
                  sltiu        s9, s1, 350
                  remu         a2, a6, a3
                  lw           s11, 204(s10)
                  sb           a2, 185(s10)
                  sh           s3, -74(s10)
                  sb           a0, -244(s10)
                  sb           a4, -138(s10)
                  lbu          t0, 114(s10)
                  lbu          ra, -57(s10)
                  sb           a6, 73(s10)
                  slt          a4, a2, s10
                  addi         s8, t0, 17
                  sll          a2, a0, t6
                  slt          gp, gp, s10
                  sh           s3, 140(s10)
                  remu         s0, s11, s1
                  srai         s6, t5, 27
                  sb           sp, -234(s10)
                  sb           ra, -139(s10)
                  and          t3, a0, s3
                  lhu          s5, -240(s10)
                  sb           s0, 233(s10)
                  lbu          ra, 247(s10)
                  div          t4, sp, sp
                  lb           s0, 161(s10)
                  lbu          s3, -197(s10)
                  sw           a1, 56(s10) #end riscv_load_store_rand_instr_stream_7
                  li           s10, 0x80000000 #start riscv_int_numeric_corner_stream_38
                  li           a1, 0x80000000
                  li           s0, 0xffffffff
                  li           t4, 0x0
                  li           tp, 0x80000000
                  li           t6, 0xffffffff
                  li           t3, 0xffffffff
                  li           t5, 0xc25b1ab4
                  li           s4, 0x80000000
                  li           s3, 0xe9699b9f
                  nop
                  addi         s4, s3, -325
                  mulhsu       s3, t3, t5
                  auipc        t3, 1043184
                  mul          s3, t5, s10
                  mulhu        s4, s0, t4
                  lui          tp, 658143
                  add          t3, tp, tp
                  nop
                  sub          s10, s10, t5
                  rem          t3, tp, t5
                  divu         t6, t6, t5
                  auipc        tp, 374200
                  mulh         t3, s10, s0
                  lui          s10, 736939
                  div          a1, tp, s10
                  divu         s4, s0, t3
                  auipc        tp, 552611
                  mul          t6, s10, a1
                  auipc        t3, 220294
                  rem          t4, t3, a1 #end riscv_int_numeric_corner_stream_38
main_93:          jal          t4, 6f
0:                jal          ra, 17f
1:                jal          s8, 9f
2:                jal          ra, 11f
3:                jal          ra, 10f
4:                jal          ra, 15f
5:                jal          ra, 21f
6:                jal          ra, 20f
7:                jal          ra, 14f
8:                jal          ra, 7b
9:                jal          t0, 19f
10:               jal          ra, 1b
11:               jal          ra, 3b
12:               jal          a1, 0b
13:               jal          s8, 8b
14:               jal          tp, 2b
15:               jal          t1, 25f
16:               jal          ra, 4b
17:               jal          ra, 5b
18:               jal          ra, 27f
19:               jal          ra, 12b
20:               jal          s8, 24f
21:               jal          t1, 18b
22:               jal          t4, 16b
23:               jal          s11, 28f
24:               jal          t1, 22b
25:               jal          ra, 13b
26:               jal          ra, 23b
27:               jal          t1, 26b
28:               jal          ra, 29f
29:               auipc        a1, 71865
                  la           t3, region_1+40562 #start riscv_load_store_rand_instr_stream_3
                  lh           t5, -248(t3)
                  csrrsi       t1, 0x344, 0
                  lb           s11, 104(t3)
                  mulhsu       s4, s10, a7
                  andi         t1, a7, 646
                  sb           s8, -158(t3)
                  lh           a6, -238(t3)
                  lb           s1, -5(t3)
                  nop
                  mulhsu       t6, t1, sp
                  lhu          a0, 164(t3)
                  lb           t6, -205(t3)
                  add          s2, s4, s11
                  sll          s1, a3, t3
                  nop
                  srl          t6, a0, s2
                  sb           t4, -13(t3)
                  sh           zero, -190(t3)
                  nop
                  lh           gp, -92(t3)
                  sh           s4, 244(t3)
                  csrrsi       s5, 0x342, 0
                  or           s4, t0, s5
                  andi         t4, t6, 536
                  lb           a4, -98(t3)
                  sltu         s10, gp, a5
                  sb           a1, -106(t3)
                  or           s11, zero, a5
                  lb           t0, 120(t3)
                  xori         a1, a1, 1558
                  lhu          s3, 98(t3)
                  sltu         ra, a3, s4
                  divu         s1, s9, sp
                  lb           s5, 134(t3)
                  ori          a4, a1, -998
                  sb           t6, 13(t3)
                  sb           s8, -121(t3) #end riscv_load_store_rand_instr_stream_3
                  addi         s2, zero, 3 #init loop 0 counter
                  xor          a1, s10, a1
                  addi         s11, zero, 17 #init loop 0 limit
                  rem          ra, t4, s10
                  mulhsu       ra, t3, a5
main_219_0_t:     mulhsu       s0, s0, t3
                  addi         s2, s2, 7 #update loop 0 counter
                  sra          s8, a7, t3
                  auipc        s8, 1032972
                  andi         t3, t3, -1529
                  divu         a2, s10, a2
                  bne          s2, s11, main_219_0_t #branch for loop 0
                  rem          t6, a3, gp
                  la           t0, region_1+51786 #start riscv_load_store_rand_instr_stream_14
                  lh           s9, 198(t0)
                  auipc        zero, 630402
                  xor          a7, a4, ra
                  lb           t2, -1717(t0)
                  xor          s8, ra, a0
                  add          t5, a2, s1
                  divu         s0, t1, t4
                  lbu          s8, 1031(t0)
                  lbu          s1, 539(t0)
                  and          t4, zero, t1
                  sb           s7, -1695(t0)
                  auipc        t1, 96265
                  mul          s4, s1, s0
                  sltu         t6, a4, s5
                  auipc        s4, 528766
                  and          t1, a3, t5
                  slti         s6, a6, 441
                  sh           t0, 718(t0)
                  sh           t5, -1058(t0)
                  slti         s3, s9, -1254
                  sll          s9, t1, a1
                  add          ra, a1, s0
                  csrrc        s3, 0x343, a0
                  divu         a2, t1, a7
                  lui          t5, 588342
                  lb           a2, -1139(t0)
                  sb           ra, -1555(t0)
                  lb           a4, 1523(t0)
                  lb           s1, -1009(t0)
                  sra          a5, a3, s5
                  ori          s0, s1, -1223
                  slli         s11, t4, 29
                  csrrci       s5, 0x305, 0
                  sltu         t3, s11, s4
                  ori          t3, a7, 1465
                  lbu          a1, 1914(t0)
                  sb           s1, -1673(t0) #end riscv_load_store_rand_instr_stream_14
                  li           s11, 0x6bd29102 #start riscv_int_numeric_corner_stream_37
                  li           gp, 0x80000000
                  li           s0, 0x0
                  li           t5, 0xe6a1e3a4
                  li           a7, 0x80000000
                  li           a6, 0x80000000
                  li           ra, 0xffffffff
                  li           s3, 0xa4902cc3
                  li           s6, 0x80000000
                  li           a2, 0x0
                  nop
                  mulhsu       a2, a6, a2
                  divu         ra, gp, s0
                  add          gp, a6, ra
                  rem          t5, a2, a6
                  rem          s3, a7, s6
                  mulhsu       ra, ra, s3
                  mul          a6, s11, a7
                  rem          s3, ra, a7
                  auipc        s3, 1015979
                  addi         a2, s6, -133
                  mulhsu       s0, a2, s11
                  lui          s0, 235084
                  mulhu        a6, s0, a7
                  sub          a6, s6, gp
                  mulhu        a2, ra, s6
                  addi         gp, s6, -1952
                  mulhsu       s0, s11, t5
                  mul          a7, a2, s6
                  mul          s0, s6, a6
                  divu         t5, s3, s3
                  addi         s3, ra, 1609 #end riscv_int_numeric_corner_stream_37
                  la           s6, region_0+376 #start riscv_hazard_instr_stream_21
                  csrrsi       s4, 0x342, 0
                  sb           s0, 483(s6)
                  lb           a4, 460(s6)
                  addi         s4, a4, 302
                  mulhu        a4, a4, a4
                  lui          zero, 897747
                  lbu          s11, 1553(s6)
                  lh           s0, 1430(s6)
                  lhu          zero, 50(s6)
                  sb           s11, 470(s6)
                  and          s4, t6, t6
                  csrrwi       zero, 0x342, 17
                  lbu          s4, 897(s6)
                  lhu          s11, 1580(s6)
                  sh           a4, -178(s6)
                  sb           s11, 1225(s6)
                  lw           s0, 172(s6)
                  lb           s4, 1279(s6)
                  lui          zero, 498733
                  csrrw        s11, 0x342, a4
                  lhu          s11, 1756(s6)
                  sll          a4, t6, s0
                  lbu          s4, 42(s6)
                  lbu          s0, 571(s6)
                  csrrc        zero, 0x305, zero
                  mulhu        s4, s11, t6
                  rem          s0, a4, a4
                  sub          t6, s11, t6
                  sltiu        zero, t6, -1572
                  sb           t6, 1166(s6) #end riscv_hazard_instr_stream_21
                  la           t2, region_1+4144 #start riscv_load_store_rand_instr_stream_24
                  mulhu        ra, a0, sp
                  remu         t5, tp, s6
                  sb           s10, -1469(t2)
                  sh           zero, 10(t2)
                  nop
                  lhu          s11, -944(t2)
                  sb           sp, 621(t2)
                  lhu          t5, -662(t2)
                  lhu          t1, -1316(t2)
                  sb           zero, -1927(t2)
                  remu         ra, a0, t3
                  div          ra, s10, sp
                  lb           ra, 407(t2)
                  auipc        zero, 166556
                  nop
                  mulh         a4, t4, a1
                  sb           s0, -1404(t2)
                  sb           t2, 13(t2)
                  add          ra, s5, a0
                  mulhu        a6, a3, a6
                  sb           s4, 73(t2)
                  sb           a4, 1782(t2)
                  lbu          s2, -1603(t2)
                  sb           t2, -2(t2)
                  divu         s1, t3, t2
                  sb           a4, -1329(t2) #end riscv_load_store_rand_instr_stream_24
                  la           s10, region_0+484 #start load_store_instr_stream_1
                  sb           s7, -157(s10)
                  la           tp, region_1+197 #start load_store_instr_stream_0
                  lbu          t0, 177(s10)
                  lh           s5, 5(tp)
                  lb           ra, 171(s10)
                  sb           t0, 247(s10)
                  sb           tp, 0(tp)
                  lb           ra, 55(s10)
                  lb           s8, 5(tp)
                  lb           t2, -6(tp)
                  lbu          s9, 15(tp)
                  lbu          s1, 3(s10)
                  sb           t6, -90(s10)
                  sb           a7, -59(s10)
                  lbu          s4, -2(tp)
                  lhu          s9, 196(s10)
                  lh           s5, -11(tp)
                  lh           s6, -15(tp)
                  lbu          a7, 190(s10) #end load_store_instr_stream_1
                  lbu          a7, 14(tp) #end load_store_instr_stream_0
                  la           t1, region_0+2263 #start load_store_instr_stream_1
                  lbu          t0, -368(t1)
                  la           s11, region_0+3583 #start load_store_instr_stream_0
                  lbu          gp, -618(t1)
                  lb           a1, -16(s11)
                  lw           t5, 1(s11)
                  la           s3, region_0+297 #start load_store_instr_stream_2
                  lh           gp, 1541(t1)
                  lw           a1, 9(s11)
                  lbu          a0, -4(s3)
                  sh           tp, 1007(t1)
                  lbu          s10, -64(s3)
                  sb           a1, 1632(t1)
                  lbu          s8, 2(s11)
                  lbu          ra, -38(s3)
                  lbu          a6, 475(t1)
                  sb           sp, 16(s3)
                  sh           s4, -13(s3)
                  lbu          s0, -31(s3)
                  sb           s7, 106(t1)
                  lbu          a2, 2(s11)
                  lh           t3, 1389(t1)
                  sb           t6, -1227(t1)
                  lb           zero, 0(s11)
                  lw           s9, -619(t1) #end load_store_instr_stream_1
                  sb           zero, -54(s3)
                  lh           t3, 59(s3) #end load_store_instr_stream_2
                  sb           ra, 9(s11) #end load_store_instr_stream_0
                  addi         s4, zero, 8 #init loop 1 counter
                  mulhu        s10, s2, a0
                  mulh         zero, s3, t3
                  sltu         t2, a5, a0
                  xori         t2, s3, -48
                  csrrc        a2, 0x304, zero
                  addi         s8, zero, 14 #init loop 1 limit
                  div          s1, s1, a2
main_230_1_t:     divu         zero, t4, sp
                  divu         t5, s5, s9
                  mulhu        s0, a4, zero
                  add          s3, s7, s0
                  addi         s4, s4, 6 #update loop 1 counter
                  slli         s2, s5, 11
                  addi         t1, zero, 0 #init loop 0 counter
                  mul          gp, a0, s8
                  csrrci       s0, 0x304, 2
                  divu         s3, s4, s5
                  addi         s11, zero, -15 #init loop 0 limit
main_230_0_t:     slti         s5, s0, 620
                  div          a0, s3, a5
                  slli         a5, gp, 20
                  divu         a0, s1, s9
                  addi         t1, t1, -3 #update loop 0 counter
                  mulh         a0, a6, a5
                  mulhu        a0, a5, s11
                  beq          t1, s11, main_230_0_t #branch for loop 0
                  mul          zero, s4, s1
                  beq          s4, s8, main_230_1_t #branch for loop 1
                  sll          s0, s6, t2
                  addi         s1, zero, 4 #init loop 0 counter
                  mulhu        s0, s3, s7
                  addi         a6, zero, 19 #init loop 0 limit
                  xori         a2, ra, 108
main_218_0_t:     xor          s8, gp, ra
                  mulhu        t1, s10, t0
                  addi         s1, s1, 1 #update loop 0 counter
                  csrrci       s3, 0x343, 0
                  div          t2, s10, a7
                  blt          s1, a6, main_218_0_t #branch for loop 0
                  remu         gp, t0, s11
                  la           t5, region_0+2961 #start riscv_hazard_instr_stream_5
                  lui          t2, 234628
                  lbu          a1, 662(t5)
                  sb           s11, 1110(t5)
                  auipc        a1, 833385
                  sb           a5, -1680(t5)
                  lb           t2, -1303(t5)
                  srl          t2, a2, a5
                  csrrs        s11, 0x301, a2
                  sb           a2, 176(t5)
                  srai         a1, t2, 15
                  lb           s11, 116(t5)
                  sll          a2, t2, a1
                  sb           t2, -1698(t5)
                  nop
                  sb           a1, -2014(t5)
                  xor          t2, a2, a2
                  xori         t4, s11, -370
                  rem          t2, a2, a1
                  or           t2, t4, t2
                  lb           t2, 97(t5)
                  mulh         t2, s11, a5
                  addi         a2, a1, -1491
                  csrrw        t2, 0x301, a5
                  addi         a2, t2, -1099
                  sltiu        t4, a2, -1507
                  lb           a1, 144(t5)
                  sb           t4, -550(t5)
                  lhu          a1, -1229(t5)
                  sll          t4, t4, a5
                  sb           a2, -680(t5)
                  lbu          t2, -46(t5) #end riscv_hazard_instr_stream_5
                  la           a7, region_1+1905 #start riscv_load_store_rand_instr_stream_23
                  mulhu        s9, zero, s1
                  lb           gp, 1261(a7)
                  add          s8, s9, gp
                  sll          t6, t1, s7
                  sb           t4, 1875(a7)
                  addi         t6, t0, 731
                  lbu          a6, 530(a7)
                  lbu          a4, -192(a7)
                  sb           t1, 670(a7)
                  divu         a4, a1, tp
                  lb           a4, 884(a7)
                  sb           t1, -917(a7)
                  sb           s9, -1678(a7)
                  lw           t1, 1311(a7)
                  andi         t6, s0, -1566
                  auipc        a5, 566334
                  lbu          t0, 1554(a7)
                  csrrc        s2, 0x304, tp
                  lb           s0, 848(a7)
                  lb           s4, -1823(a7)
                  lb           a4, -1190(a7)
                  andi         tp, zero, 964
                  nop
                  div          s10, s6, t6
                  sb           a3, 1806(a7)
                  srai         a5, a4, 5
                  slti         s4, s4, 887
                  sltu         s6, a5, s5
                  sw           t4, 435(a7)
                  auipc        a5, 765871
                  div          s6, s6, t1
                  sltu         ra, s9, s10
                  nop
                  csrrs        a5, 0x344, zero
                  lh           gp, -755(a7)
                  srli         t2, a6, 0
                  sb           t4, 1034(a7) #end riscv_load_store_rand_instr_stream_23
                  li           a6, 0xffffffff #start riscv_int_numeric_corner_stream_36
                  li           a4, 0xffffffff
                  li           s10, 0xaa9a03fd
                  li           s11, 0xffffffff
                  li           s6, 0xffffffff
                  li           t4, 0x80000000
                  li           t0, 0x0
                  li           s1, 0x0
                  li           s4, 0xffffffff
                  li           a7, 0xffffffff
                  mul          s10, a6, s4
                  sub          s11, a7, s6
                  sub          s6, t0, t0
                  auipc        s10, 52462
                  mulhsu       t4, t0, s1
                  sub          t0, s11, a4
                  mul          s10, t4, s11
                  mul          t4, s1, s11
                  div          a6, t0, a7
                  mulh         a4, s1, s1
                  mulhu        s11, s11, t4
                  add          s1, a4, s1
                  addi         a6, a7, -1201
                  add          a6, s4, a6
                  remu         s6, a6, t0
                  lui          s4, 467701
                  nop
                  remu         a7, s11, s1
                  div          a6, s10, s4
                  nop
                  lui          a4, 199671
                  div          s10, t0, s10
                  mul          s6, t0, a7
                  remu         s6, a7, a7
                  addi         s1, s6, 851
                  nop
                  div          a6, t4, a7
                  add          a7, s1, s11
                  rem          t4, s6, a7 #end riscv_int_numeric_corner_stream_36
                  addi         a7, zero, 7 #init loop 0 counter
                  csrrsi       s9, 0x304, 31
                  srl          tp, s2, a3
                  add          a6, gp, tp
                  csrrs        t1, 0x301, zero
                  addi         s2, zero, 7 #init loop 0 limit
                  mulhsu       t5, a0, a7
main_208_0_t:     sltiu        zero, t4, 1276
                  csrrw        s4, 0x304, gp
                  addi         a7, a7, -6 #update loop 0 counter
                  srli         a6, t5, 7
                  auipc        t3, 865061
                  slt          a6, a2, sp
                  sltiu        s8, t6, -2044
                  csrrs        s11, 0x305, zero
                  bgeu         a7, s2, main_208_0_t #branch for loop 0
                  remu         t2, tp, t2
                  la           a1, region_0+2641 #start riscv_hazard_instr_stream_6
                  sub          a7, t3, t3
                  srl          s11, s11, a7
                  div          a7, s11, s6
                  sh           s6, 9(a1)
                  addi         t3, s6, 384
                  slli         s6, a7, 5
                  mulhsu       a7, s6, t3
                  mul          t6, s6, t6
                  ori          s0, a7, -354
                  xor          a7, t3, s0
                  slt          s0, s11, a7
                  lbu          s0, 13(a1)
                  mulh         s0, t3, s0
                  mul          t3, s0, s0
                  divu         s0, s11, s0
                  lbu          t3, -16(a1)
                  lb           t3, -5(a1)
                  mul          t3, a7, t6
                  sb           t3, 2(a1)
                  lbu          t3, -16(a1)
                  mul          t6, t6, t3
                  remu         t6, a7, s6
                  lbu          s0, -11(a1)
                  lbu          s11, -2(a1)
                  lb           s0, -8(a1)
                  sw           s6, 11(a1)
                  sb           s6, 5(a1)
                  lb           a7, -4(a1)
                  csrrc        t3, 0x301, s11
                  nop
                  addi         t3, t3, -1779
                  sb           s11, 10(a1)
                  lbu          t6, 3(a1)
                  sltu         t3, s6, s11
                  sra          s11, s0, t3
                  lb           s6, 12(a1)
                  nop
                  csrrs        s0, 0x301, t3
                  lhu          t6, -15(a1) #end riscv_hazard_instr_stream_6
                  la           a1, region_0+1095 #start riscv_load_store_hazard_instr_stream_27
                  lbu          t3, -249(a1)
                  lb           a6, -134(a1)
                  sb           t4, -53(a1)
                  sub          t0, a6, s11
                  sb           s0, -53(a1)
                  sltiu        s1, s3, -1681
                  sb           t5, -19(a1)
                  lh           ra, -19(a1)
                  lw           a0, -19(a1)
                  sb           s1, -19(a1)
                  lb           s10, -127(a1)
                  sh           s0, -127(a1)
                  lb           s0, 74(a1)
                  csrrs        t5, 0x343, zero
                  sltiu        s2, a4, 2034
                  lb           t1, 74(a1)
                  csrrs        tp, 0x344, s6
                  lbu          s8, 74(a1) #end riscv_load_store_hazard_instr_stream_27
                  la           gp, region_0+2028 #start riscv_hazard_instr_stream_4
                  lb           ra, -87(gp)
                  srli         a5, a4, 9
                  csrrs        a5, 0x343, ra
                  lb           a4, -84(gp)
                  lb           a4, 103(gp)
                  lb           s5, -36(gp)
                  lh           ra, 254(gp)
                  sw           a4, 184(gp)
                  sw           a4, 220(gp)
                  lb           s9, -53(gp)
                  sltiu        ra, ra, -319
                  lhu          ra, -44(gp)
                  sb           ra, 139(gp)
                  remu         a4, a4, ra
                  xori         a5, s9, 1347
                  lb           s9, -53(gp)
                  sltiu        a5, s9, -187
                  lhu          a4, -12(gp)
                  sb           a1, -145(gp)
                  lbu          s5, -217(gp)
                  sb           ra, -31(gp)
                  lb           s9, -220(gp)
                  sh           s9, 208(gp)
                  lhu          ra, -150(gp)
                  lb           a1, -12(gp)
                  lb           s5, 62(gp)
                  lh           a5, 150(gp)
                  lbu          a5, 170(gp)
                  lb           a4, -59(gp)
                  sh           a4, -112(gp)
                  lw           a1, -112(gp)
                  nop
                  srai         ra, a1, 18
                  ori          s5, s9, -521
                  lbu          a5, -11(gp)
                  mul          a5, s9, a1
                  remu         a4, ra, a4
                  lui          a4, 245931
                  lw           s9, -100(gp)
                  lh           s9, 234(gp) #end riscv_hazard_instr_stream_4
                  la           t0, region_0+304 #start load_store_instr_stream_0
                  la           s11, region_0+1840 #start load_store_instr_stream_4
                  la           s6, region_0+225 #start load_store_instr_stream_1
                  la           s10, region_0+3498 #start load_store_instr_stream_3
                  sb           ra, 1(s11)
                  la           s8, region_0+2995 #start load_store_instr_stream_2
                  sb           a4, -8(s6)
                  lw           gp, 212(t0)
                  lbu          a7, 2(s11)
                  sb           s3, 13(s10)
                  sb           a7, -15(t0)
                  lw           t5, -54(s10)
                  sb           s9, 0(s11)
                  lbu          a1, -90(s8)
                  lb           a5, 39(s10)
                  lb           t3, 8(s11)
                  lhu          t3, 60(s10)
                  sb           s0, -198(s8)
                  lbu          t1, 9(s11)
                  sb           s5, 13(s6)
                  lb           a0, 205(t0)
                  lb           tp, 14(s6)
                  lbu          s2, 1(s11)
                  lbu          t2, 63(s10)
                  sb           gp, 11(s11)
                  lbu          a4, -7(s6)
                  lhu          a5, 215(s8)
                  lbu          tp, -6(s6)
                  lbu          tp, 2(s11)
                  lb           a4, 1791(t0)
                  sh           s5, 10(s10)
                  lhu          t5, 452(t0)
                  lbu          a1, 776(t0)
                  sb           s5, 45(s10) #end load_store_instr_stream_3
                  lbu          t6, 12(s11) #end load_store_instr_stream_4
                  lh           a4, 147(s8)
                  lb           t6, 537(t0)
                  lb           s4, 1187(t0)
                  lhu          a7, -5(s6) #end load_store_instr_stream_1
                  sh           t2, -51(s8) #end load_store_instr_stream_2
                  sb           s11, 1985(t0) #end load_store_instr_stream_0
main_111:         jal          t4, 2f
0:                jal          ra, 7f
1:                jal          gp, 12f
2:                jal          ra, 8f
3:                jal          ra, 24f
4:                jal          ra, 20f
5:                jal          ra, 22f
6:                jal          ra, 13f
7:                jal          t1, 21f
8:                jal          ra, 19f
9:                jal          a5, 6b
10:               jal          ra, 4b
11:               jal          gp, 27f
12:               jal          ra, 17f
13:               jal          ra, 18f
14:               jal          t0, 26f
15:               jal          ra, 11b
16:               jal          ra, 10b
17:               jal          t1, 25f
18:               jal          tp, 5b
19:               jal          s10, 23f
20:               jal          t1, 9b
21:               jal          t1, 15b
22:               jal          s6, 0b
23:               jal          ra, 3b
24:               jal          ra, 14b
25:               jal          ra, 16b
26:               jal          ra, 1b
27:               auipc        a0, 401796
                  la           t5, region_0+2961 #start riscv_hazard_instr_stream_30
                  lhu          a1, 3(t5)
                  srl          a2, a1, gp
                  lh           gp, 49(t5)
                  sb           a2, 57(t5)
                  lbu          a2, 20(t5)
                  lbu          a1, -10(t5)
                  lui          a1, 122262
                  mulhu        a2, a6, s11
                  lb           a4, -16(t5)
                  csrrc        a6, 0x344, a4
                  lhu          a1, 51(t5)
                  sw           a4, 55(t5)
                  auipc        a2, 382802
                  sw           gp, -57(t5)
                  lh           gp, 19(t5)
                  lbu          gp, 45(t5)
                  sb           s11, 8(t5)
                  lb           a6, 21(t5)
                  sb           a4, 18(t5)
                  mul          gp, a2, gp
                  andi         a6, s11, -1624
                  sltu         gp, a6, a1
                  lui          gp, 479933
                  or           a4, a4, gp
                  sb           a6, -24(t5)
                  mul          a4, a6, a1
                  addi         s11, a6, -1258
                  csrrwi       a4, 0x344, 7
                  sra          a6, a4, a6
                  lh           a1, 51(t5)
                  lb           s11, -62(t5)
                  csrrci       a6, 0x304, 26
                  lh           a1, 33(t5)
                  mulhu        a2, gp, a6
                  sb           a6, -32(t5)
                  lb           s11, -8(t5)
                  remu         a4, gp, a4
                  lbu          a2, 21(t5)
                  lw           a2, -9(t5)
                  csrrci       gp, 0x344, 0
                  sb           a6, -28(t5)
                  csrrci       a4, 0x300, 0
                  lw           a2, -5(t5)
                  slt          a4, a2, a1
                  lh           a6, -1(t5)
                  sltu         a2, s11, a1
                  sra          a1, gp, a4
                  addi         a4, a1, 195
                  lb           a2, 22(t5)
                  sll          a1, gp, gp
                  lbu          a6, -40(t5)
                  mulh         gp, a6, a2
                  lb           a1, -42(t5) #end riscv_hazard_instr_stream_30
                  la           t2, region_0+1456 #start load_store_instr_stream_1
                  la           t1, region_1+13711 #start load_store_instr_stream_0
                  lb           zero, -11(t2)
                  lb           s9, 7(t2)
                  lhu          s1, -4(t2)
                  lb           s11, 13(t1)
                  sw           t0, -16(t2)
                  lb           a7, 10(t1)
                  lh           tp, 13(t1)
                  lhu          a6, 9(t1)
                  lbu          s4, 5(t2) #end load_store_instr_stream_1
                  sb           t3, 2(t1) #end load_store_instr_stream_0
                  la           t3, region_1+62262 #start riscv_load_store_rand_instr_stream_30
                  lbu          zero, -204(t3)
                  addi         t4, s1, 339
                  lh           ra, -154(t3)
                  sra          a7, a1, s1
                  mulhu        a0, s0, s4
                  auipc        a7, 72578
                  sub          s2, s5, s3
                  add          s9, zero, zero
                  lbu          t2, -142(t3)
                  lb           zero, -51(t3)
                  lb           s11, -121(t3)
                  slli         t2, s10, 10
                  lb           a7, -181(t3)
                  csrrwi       a7, 0x301, 4
                  sw           a2, 22(t3)
                  lb           t4, 59(t3)
                  sra          t4, a7, t0
                  rem          s2, ra, a4
                  csrrc        s0, 0x342, s0
                  lbu          t6, -229(t3)
                  sh           a0, 76(t3)
                  lh           s11, -240(t3)
                  lh           t2, -120(t3)
                  csrrci       t6, 0x304, 11
                  lw           s5, -238(t3)
                  mulh         ra, s1, t3
                  lb           t0, 244(t3)
                  lbu          zero, -19(t3)
                  csrrwi       s1, 0x343, 20
                  rem          zero, a5, t1
                  sb           a5, -15(t3)
                  andi         s2, a5, -815
                  sb           a6, -178(t3)
                  lui          s4, 409906
                  mulh         s0, s2, s9
                  srai         t5, s2, 28
                  sh           a0, 224(t3)
                  lhu          a0, -236(t3)
                  lw           t6, -218(t3)
                  xor          t5, sp, ra
                  csrrci       s0, 0x342, 27
                  remu         a7, a1, s8
                  div          t6, s0, t2
                  lb           t2, -126(t3)
                  auipc        t1, 84265
                  lui          t6, 253452
                  csrrc        s2, 0x301, zero
                  sh           a2, -122(t3)
                  lbu          s1, 188(t3)
                  div          a1, s2, a4
                  lw           a0, -218(t3)
                  srli         s11, a1, 31
                  sra          a2, s8, a6
                  xori         t6, ra, 1328
                  lb           s8, 153(t3) #end riscv_load_store_rand_instr_stream_30
                  la           t0, region_0+1700 #start riscv_hazard_instr_stream_17
                  slt          t1, a1, t1
                  sh           s0, -1436(t0)
                  sb           t1, -1463(t0)
                  ori          t5, s0, -862
                  csrrw        t1, 0x304, s0
                  sb           t1, -1405(t0)
                  lb           a1, 433(t0)
                  csrrsi       a0, 0x300, 0
                  remu         t5, a0, s0
                  ori          t1, a4, -234
                  sh           a0, -840(t0)
                  xori         t5, t1, 513
                  lbu          s0, 711(t0)
                  srl          t5, a1, a0
                  lb           t5, -562(t0)
                  slt          a1, a1, s0
                  sb           s0, 1409(t0)
                  nop
                  lbu          a0, -1327(t0)
                  sra          a1, s0, a4
                  mul          a1, a0, a1
                  slti         a1, a0, -1036
                  lbu          a4, 215(t0)
                  lb           s0, -746(t0)
                  sh           a4, 1094(t0)
                  nop
                  sra          a4, a0, a1
                  lb           t5, -785(t0)
                  mulhu        t5, a4, a4
                  sb           t1, 1253(t0)
                  lbu          t1, -999(t0)
                  mul          a4, a1, t1
                  lbu          t1, -405(t0)
                  sb           s0, 1308(t0)
                  sra          a1, a4, a4
                  lb           t1, 205(t0)
                  or           t1, a1, a0
                  lb           s0, -655(t0)
                  sh           s0, 1222(t0)
                  add          a1, a1, a0
                  sb           t1, -1294(t0)
                  slli         s0, a4, 3
                  slt          s0, s0, t1
                  lb           s0, 1037(t0)
                  lb           a0, 27(t0)
                  lb           a4, -61(t0)
                  divu         a1, a4, s0
                  lh           a4, -1444(t0)
                  andi         a0, a0, -1982
                  lbu          a0, -311(t0)
                  sw           t5, 1388(t0)
                  sll          s0, a0, a1
                  divu         a4, s0, s0
                  and          s0, a1, s0
                  lbu          s0, -181(t0)
                  div          a0, s0, a4
                  lhu          a0, -612(t0)
                  sltu         t1, t1, t1
                  sb           t1, 30(t0) #end riscv_hazard_instr_stream_17
                  li           a7, 0x0 #start riscv_int_numeric_corner_stream_1
                  li           s6, 0x80000000
                  li           s5, 0x0
                  li           t1, 0x0
                  li           s8, 0x80000000
                  li           a5, 0x0
                  li           a1, 0xffffffff
                  li           s0, 0x0
                  li           t2, 0xffffffff
                  li           tp, 0x80000000
                  addi         t2, s6, -1081
                  sub          s5, s8, a5
                  divu         s6, s6, a7
                  add          s5, s8, s0
                  add          s5, s8, s0
                  divu         s5, a1, tp
                  auipc        s8, 845529
                  divu         tp, tp, s5
                  auipc        tp, 983062
                  mulh         a7, t1, a7
                  rem          a5, t2, s6
                  rem          t1, a1, tp
                  add          s6, a1, tp
                  rem          a5, s8, s8
                  mul          t1, t2, a5
                  add          s8, s8, s8
                  sub          t1, t1, a1
                  remu         s6, t2, tp
                  divu         t2, s8, t1 #end riscv_int_numeric_corner_stream_1
                  addi         a1, zero, 4 #init loop 0 counter
                  mulhu        t4, a2, a0
                  addi         ra, zero, 17 #init loop 0 limit
main_234_0_t:     div          s5, t4, s8
                  addi         a1, a1, 9 #update loop 0 counter
                  xor          a0, s5, a5
                  andi         s6, gp, -808
                  xor          a4, s8, a2
                  srl          zero, t0, s10
                  blt          a1, ra, main_234_0_t #branch for loop 0
                  srli         a7, a4, 14
                  addi         s1, zero, -4 #init loop 1 counter
                  sltu         t0, gp, t6
                  sltu         t0, t1, t1
                  srl          s10, a6, s2
                  addi         a1, zero, -16 #init loop 1 limit
                  andi         zero, s7, 1174
                  slt          a0, t1, s11
main_224_1_t:     rem          s9, s9, t6
                  slt          a4, t5, t1
                  and          a0, a4, sp
                  addi         s1, s1, -6 #update loop 1 counter
                  rem          s10, a7, a3
                  addi         a7, zero, 1 #init loop 0 counter
                  addi         s6, zero, 7 #init loop 0 limit
                  xori         t4, s9, -1368
main_224_0_t:     mulhu        a4, a0, s3
                  csrrsi       s4, 0x305, 0
                  srai         s10, t2, 23
                  auipc        t2, 1027537
                  csrrsi       a2, 0x305, 0
                  sll          a0, s0, a4
                  or           s2, s9, a5
                  csrrwi       t3, 0x304, 5
                  xor          s8, t1, a7
                  addi         a7, a7, 6 #update loop 0 counter
                  or           s0, s9, s3
                  bne          a7, s6, main_224_0_t #branch for loop 0
                  divu         t6, s8, gp
                  add          zero, ra, s4
                  divu         t3, ra, a5
                  bne          s1, a1, main_224_1_t #branch for loop 1
                  csrrs        s0, 0x305, zero
                  li           a4, 0x80000000 #start riscv_int_numeric_corner_stream_30
                  li           a0, 0x80000000
                  li           t6, 0xffffffff
                  li           s4, 0xffffffff
                  li           a5, 0x80000000
                  li           a2, 0x80000000
                  li           a1, 0xffffffff
                  li           t1, 0x80286b11
                  li           s10, 0x80000000
                  li           s11, 0x86b6efee
                  add          s4, a0, s10
                  nop
                  mulhsu       a5, t1, a1
                  rem          a4, s11, t6
                  div          a2, a4, a5
                  lui          s10, 187176
                  addi         a5, a2, 784
                  rem          t6, s4, s11
                  addi         a5, s4, -1892
                  div          a2, s4, t1
                  mul          t6, a5, a5
                  divu         s11, a5, t1
                  mulhsu       a4, a4, a1
                  add          s4, a4, t1
                  auipc        s4, 376691
                  mulh         s4, t6, t1
                  nop
                  div          a4, t1, s11
                  div          a2, s4, a4
                  nop
                  sub          a5, t6, t6
                  add          a4, s10, a2
                  mul          a0, a0, s10
                  mulh         a5, a0, a1
                  lui          t1, 131516
                  divu         a0, t1, t1
                  div          s4, a1, a0 #end riscv_int_numeric_corner_stream_30
                  la           t2, region_1+26464 #start riscv_hazard_instr_stream_28
                  sll          a7, a7, a7
                  sltiu        s9, s9, -1220
                  lb           t4, 1281(t2)
                  divu         t4, t4, s9
                  nop
                  lb           t4, -403(t2)
                  mulhsu       a6, a7, a4
                  csrrc        t4, 0x301, s1
                  csrrw        s9, 0x301, s1
                  srai         s1, t4, 7
                  csrrs        a4, 0x301, s1
                  lbu          s9, 529(t2)
                  lb           s9, -1807(t2)
                  lb           s1, -936(t2)
                  lbu          s1, 1983(t2)
                  lbu          s9, 986(t2)
                  lb           a7, -1675(t2)
                  lb           s1, 569(t2)
                  slti         a4, t4, -2006
                  csrrci       a6, 0x343, 6
                  lb           s9, -551(t2)
                  sra          t4, a7, a6
                  lh           t4, 1368(t2)
                  xori         t4, a6, 251
                  remu         t4, s1, a6
                  remu         t4, t4, t4
                  mul          t4, a7, s9
                  lb           a6, 2005(t2)
                  lbu          t4, 1060(t2)
                  lhu          s9, -720(t2)
                  sh           s9, -70(t2)
                  srl          a7, a6, a6
                  mul          t4, t4, a7
                  sll          s1, s1, a7
                  sra          s1, a7, a6
                  sll          a6, a4, s9
                  lh           s9, 2034(t2) #end riscv_hazard_instr_stream_28
main_91:          jal          t4, 5f
0:                jal          a0, 25f
1:                jal          t1, 3f
2:                jal          t0, 15f
3:                jal          ra, 18f
4:                jal          tp, 27f
5:                jal          ra, 8f
6:                jal          ra, 19f
7:                jal          gp, 1b
8:                jal          ra, 10f
9:                jal          s0, 14f
10:               jal          t6, 20f
11:               jal          ra, 4b
12:               jal          s4, 26f
13:               jal          t1, 21f
14:               jal          ra, 16f
15:               jal          ra, 6b
16:               jal          ra, 17f
17:               jal          t1, 22f
18:               jal          a2, 11b
19:               jal          gp, 12b
20:               jal          ra, 0b
21:               jal          ra, 9b
22:               jal          t1, 24f
23:               jal          ra, 7b
24:               jal          t0, 23b
25:               jal          ra, 2b
26:               jal          s6, 13b
27:               divu         ra, s2, a6
                  li           a5, 0x0 #start riscv_int_numeric_corner_stream_29
                  li           t3, 0x80000000
                  li           t0, 0x0
                  li           ra, 0x80000000
                  li           t6, 0x80000000
                  li           a1, 0x0
                  li           s10, 0x0
                  li           s2, 0x0
                  li           t1, 0xb8a0b8de
                  li           s8, 0xcfad89a8
                  mulhu        t0, a5, t1
                  mulhsu       s10, s2, a1
                  rem          t1, a5, t1
                  addi         a1, t1, 1993
                  mulh         s10, t6, a1
                  sub          t3, s10, t6
                  divu         s2, a1, ra
                  auipc        a1, 422599
                  mulhu        s2, s10, t0
                  sub          s2, t6, t6
                  div          a5, t3, s2
                  lui          a1, 847049
                  rem          s8, s2, t0
                  mul          s2, a1, t3
                  div          a1, t0, ra
                  add          t3, a5, ra
                  div          t1, a1, s10
                  sub          t1, t6, a5
                  div          t1, t1, s10
                  lui          s10, 689843
                  add          t6, ra, t6
                  addi         t6, a1, -1431
                  mulhsu       t1, ra, s8
                  rem          s8, a1, a5
                  auipc        a1, 459158
                  add          t1, t6, s8
                  mulhsu       a1, s8, a1
                  mulhsu       t6, a1, t0
                  div          a5, s8, t1
                  rem          a1, s8, t6 #end riscv_int_numeric_corner_stream_29
                  addi         s5, zero, -5 #init loop 1 counter
                  addi         s3, zero, 15 #init loop 1 limit
main_214_1_t:     sltiu        a1, s1, 1119
                  addi         s5, s5, 5 #update loop 1 counter
                  addi         a5, zero, -6 #init loop 0 counter
                  addi         t2, zero, -11 #init loop 0 limit
main_214_0_t:     sltiu        s1, tp, 1402
                  addi         a5, a5, -1 #update loop 0 counter
                  bne          a5, t2, main_214_0_t #branch for loop 0
                  bne          s5, s3, main_214_1_t #branch for loop 1
                  ori          zero, s1, -1129
                  la           a1, region_1+61703 #start riscv_load_store_hazard_instr_stream_25
                  lbu          s0, -14(a1)
                  sb           a6, 10(a1)
                  mulh         a5, a4, t2
                  nop
                  sra          s9, a6, s11
                  divu         s4, s6, s5
                  sb           s0, 10(a1)
                  sb           a0, 10(a1)
                  lb           tp, -10(a1)
                  sb           tp, -10(a1)
                  lbu          s1, -1(a1)
                  lh           s2, -5(a1)
                  lbu          s5, -14(a1)
                  slli         s6, a3, 17
                  lbu          a0, -14(a1)
                  lbu          s3, -14(a1)
                  sll          t5, s11, s3
                  or           t6, s9, ra
                  lbu          s1, 8(a1)
                  lbu          a5, 8(a1)
                  lb           t2, 8(a1) #end riscv_load_store_hazard_instr_stream_25
                  la           s8, region_0+3694 #start riscv_load_store_rand_instr_stream_28
                  sub          zero, a1, t2
                  slti         tp, t1, 839
                  lb           a1, 67(s8)
                  sub          s11, t3, t6
                  slti         a4, gp, 182
                  mulhsu       tp, a6, a2
                  lb           zero, 67(s8)
                  lbu          a1, 141(s8)
                  mul          a6, s0, t0
                  lui          t6, 140995
                  slt          s9, sp, s0
                  lbu          a2, 134(s8)
                  lb           t1, -135(s8)
                  lh           t2, 4(s8)
                  auipc        s3, 424762
                  lb           a5, 203(s8)
                  mulhu        a2, s4, s11
                  csrrc        s11, 0x343, zero
                  lb           t5, -232(s8)
                  mulh         s5, tp, a4
                  lui          s0, 109622
                  divu         s11, tp, a6
                  lbu          t4, -240(s8)
                  and          zero, s7, s11
                  mul          a2, s7, a6
                  sb           s2, -125(s8)
                  lbu          zero, -100(s8)
                  csrrwi       a5, 0x342, 23
                  lbu          a0, 135(s8)
                  srli         t4, s8, 26
                  sb           a0, -205(s8)
                  lbu          t4, -113(s8)
                  sb           s9, 231(s8)
                  sb           zero, 75(s8)
                  xor          s11, a2, t3
                  sb           a5, 244(s8) #end riscv_load_store_rand_instr_stream_28
                  la           s10, region_1+5621 #start riscv_load_store_rand_instr_stream_39
                  sb           t3, -31(s10)
                  mulh         a5, a7, a1
                  lb           a6, -12(s10)
                  lbu          s1, 113(s10)
                  andi         a2, ra, 1613
                  mulh         t0, t4, s7
                  sra          t6, sp, s10
                  sra          s8, t3, a3
                  sll          t5, s10, a0
                  lhu          s3, -201(s10)
                  sb           zero, -83(s10)
                  lb           a0, 121(s10)
                  and          gp, s10, a0
                  csrrw        a5, 0x343, sp
                  andi         t6, tp, 1300
                  sll          s11, s8, a4
                  lbu          a7, 46(s10)
                  lh           a0, 153(s10)
                  slt          s11, s0, t6
                  sb           s7, -115(s10)
                  lb           s2, -136(s10)
                  sb           s8, 38(s10)
                  or           s1, s1, t1
                  sltiu        t4, a2, 1460
                  lw           t0, -169(s10)
                  or           s4, a4, sp
                  srli         tp, a2, 4
                  xori         s9, tp, -488
                  sll          a6, s1, t6
                  sb           s11, 62(s10) #end riscv_load_store_rand_instr_stream_39
                  li           a0, 0x80000000 #start riscv_int_numeric_corner_stream_39
                  li           t0, 0xfa915598
                  li           tp, 0xffffffff
                  li           s2, 0x80000000
                  li           a6, 0x0
                  li           t1, 0x80000000
                  li           s8, 0x0
                  li           a1, 0x0
                  li           s10, 0x0
                  li           ra, 0x80000000
                  remu         t1, a0, s8
                  remu         s2, a0, t1
                  mulhsu       s8, s10, s2
                  mulhsu       t1, s10, ra
                  divu         tp, t1, s2
                  nop
                  sub          s8, a6, a0
                  rem          a1, s2, ra
                  auipc        a0, 555622
                  add          a0, tp, a6
                  divu         t1, ra, s8
                  sub          a0, t1, s8
                  lui          s2, 647332
                  mulhsu       ra, s10, a6
                  add          t0, t0, s10
                  add          t0, s2, tp
                  rem          t1, s2, a1
                  addi         s10, s2, -839
                  addi         tp, a0, -2
                  lui          t1, 1867
                  mulhsu       ra, s10, s2
                  rem          t1, s2, tp #end riscv_int_numeric_corner_stream_39
                  la           s8, region_1+32543 #start riscv_load_store_hazard_instr_stream_18
                  sh           gp, 39(s8)
                  lhu          t5, 39(s8)
                  csrrc        s0, 0x344, a5
                  lbu          s5, 20(s8)
                  lhu          a0, 7(s8)
                  lbu          s9, 8(s8)
                  lbu          a0, 8(s8)
                  sb           a6, 28(s8)
                  sb           s1, 28(s8)
                  ori          t5, t6, -969
                  lbu          t3, 28(s8)
                  sb           s7, 55(s8)
                  auipc        s11, 490899
                  csrrs        t1, 0x305, zero
                  lbu          a1, 12(s8)
                  sb           s10, -52(s8) #end riscv_load_store_hazard_instr_stream_18
                  li           a2, 0xffffffff #start riscv_int_numeric_corner_stream_8
                  li           t2, 0x2a837987
                  li           s6, 0xffffffff
                  li           s1, 0xffffffff
                  li           tp, 0x80000000
                  li           s0, 0x0
                  li           t3, 0x0
                  li           t0, 0xffffffff
                  li           a0, 0xffffffff
                  li           s3, 0xffffffff
                  lui          tp, 382692
                  addi         a0, a0, 697
                  mulh         tp, t2, t0
                  rem          a0, tp, s1
                  mulhsu       a0, a2, s0
                  mul          t0, s6, s0
                  rem          a0, t0, s6
                  rem          t0, t3, t2
                  mulhsu       t0, s0, t0
                  nop
                  add          s3, s3, s1
                  remu         t2, s0, s0
                  remu         s3, s1, s0
                  mulhsu       s6, a2, a2
                  rem          t0, t3, tp
                  auipc        a0, 50205 #end riscv_int_numeric_corner_stream_8
                  la           ra, region_1+14942 #start load_store_instr_stream_1
                  la           t5, region_1+32642 #start load_store_instr_stream_0
                  lb           t6, -504(ra)
                  sb           s2, 22(t5)
                  lb           s11, -25(t5)
                  lhu          t4, -1980(ra)
                  sb           s0, -1401(ra)
                  lh           s8, 4(t5)
                  lbu          t0, -29(t5)
                  lbu          a1, 27(t5)
                  sb           a0, -3(t5)
                  lbu          s9, -157(ra)
                  lhu          a1, 42(t5)
                  lb           t0, 823(ra)
                  sw           ra, -726(ra)
                  sw           s9, -1626(ra)
                  lb           t0, 569(ra)
                  sh           a6, -1060(ra) #end load_store_instr_stream_1
                  sw           tp, 42(t5) #end load_store_instr_stream_0
main_117:         jal          t4, 16f
0:                jal          s11, 17f
1:                jal          s2, 14f
2:                jal          gp, 19f
3:                jal          ra, 1b
4:                jal          ra, 5f
5:                jal          t1, 8f
6:                jal          ra, 9f
7:                jal          ra, 13f
8:                jal          ra, 15f
9:                jal          ra, 4b
10:               jal          ra, 7b
11:               jal          ra, 6b
12:               jal          s3, 18f
13:               jal          a0, 2b
14:               jal          ra, 12b
15:               jal          ra, 0b
16:               jal          ra, 11b
17:               jal          ra, 3b
18:               jal          t1, 10b
19:               srl          s6, s10, s11
                  li           gp, 0xffffffff #start riscv_int_numeric_corner_stream_18
                  li           a4, 0xb960fb54
                  li           a7, 0x0
                  li           s5, 0xc4233304
                  li           a6, 0x80000000
                  li           t2, 0x7b892fad
                  li           a1, 0xc9ff14ba
                  li           s0, 0x714b6734
                  li           t3, 0xffffffff
                  li           a5, 0x0
                  divu         a6, a6, t3
                  auipc        a4, 364358
                  addi         t3, t3, -1016
                  sub          gp, t3, a4
                  nop
                  remu         a5, a5, t3
                  add          gp, a7, a7
                  add          gp, a6, a4
                  nop
                  rem          s0, s5, a6
                  lui          a7, 755729
                  rem          a1, t3, a7
                  mulh         gp, a7, a5
                  sub          t3, a4, a1
                  div          s0, t3, s0
                  sub          t3, a6, a4
                  mulhu        t3, s5, a7
                  add          a1, s0, t2
                  auipc        s5, 579686
                  sub          t2, t2, a4
                  addi         t2, a1, 604
                  divu         a5, a4, t2
                  mulh         s5, s0, t3
                  sub          s5, a5, a1
                  div          a6, a5, a1
                  mulhu        a7, t3, a5 #end riscv_int_numeric_corner_stream_18
                  la           t2, region_1+29065 #start load_store_instr_stream_1
                  la           s11, region_1+25466 #start load_store_instr_stream_2
                  sb           s8, 182(t2)
                  lb           t1, -1(s11)
                  la           a4, region_1+38227 #start load_store_instr_stream_0
                  lw           s4, 14(s11)
                  lb           s8, 1899(a4)
                  lh           s1, 12(s11)
                  lb           gp, 158(t2)
                  sb           tp, -11(s11)
                  lb           gp, -712(a4)
                  lb           t1, -14(s11)
                  lb           a1, 328(a4)
                  sb           s9, 206(t2)
                  sb           t2, 68(t2)
                  lb           t1, 856(a4)
                  lb           s1, -3(s11)
                  sb           a6, 10(s11)
                  lbu          tp, 165(t2)
                  lbu          a7, 1(s11)
                  lb           t5, -726(a4)
                  sh           sp, 219(t2) #end load_store_instr_stream_1
                  lb           t4, -12(s11) #end load_store_instr_stream_2
                  sh           a4, 1375(a4) #end load_store_instr_stream_0
                  la           ra, region_1+58416 #start load_store_instr_stream_0
                  la           s8, region_0+3044 #start load_store_instr_stream_1
                  lb           tp, -60(s8)
                  lb           a2, -9(s8)
                  lbu          s1, 47(s8)
                  sb           s6, 1143(ra)
                  lbu          a6, 14(s8)
                  lb           s11, 28(s8)
                  sh           ra, 242(ra)
                  lw           s5, 12(s8)
                  sh           t5, 116(ra)
                  lb           s6, 21(s8)
                  lb           a5, -9(s8)
                  lbu          a0, 53(s8)
                  lb           t1, -1147(ra)
                  sb           s3, 30(s8) #end load_store_instr_stream_1
                  lhu          t4, -520(ra) #end load_store_instr_stream_0
                  la           t6, region_1+21442 #start load_store_instr_stream_2
                  la           s8, region_1+51682 #start load_store_instr_stream_1
                  lbu          zero, 6(s8)
                  la           t2, region_1+53306 #start load_store_instr_stream_0
                  sb           a6, 1293(t2)
                  la           a0, region_1+53564 #start load_store_instr_stream_3
                  lb           s6, 13(s8)
                  lbu          a6, 1682(t2)
                  sh           t1, 102(t6)
                  lh           s2, -988(t6)
                  sh           s10, -8(s8)
                  lhu          s2, -10(s8)
                  lb           t4, 13(a0)
                  sb           a0, 2015(t6)
                  sb           t3, -1591(t2)
                  sb           t5, 5(s8)
                  lbu          t3, -9(a0)
                  lhu          s2, -1376(t6)
                  lbu          gp, 12(a0)
                  sb           a6, -253(t2)
                  sb           s1, -1288(t6)
                  sb           a0, -911(t6)
                  lb           t5, -13(s8)
                  sb           a0, 155(t6)
                  lhu          s1, -4(a0)
                  sb           zero, -11(a0)
                  lbu          t4, -693(t6)
                  sb           s8, -1402(t2)
                  lb           a7, 3(a0)
                  sb           a7, 1317(t2)
                  lbu          s6, 1215(t6)
                  sb           a0, 9(s8) #end load_store_instr_stream_1
                  lb           gp, 1347(t6) #end load_store_instr_stream_2
                  lb           t3, -11(a0) #end load_store_instr_stream_3
                  lb           s2, -1336(t2) #end load_store_instr_stream_0
                  addi         a0, zero, 2 #init loop 1 counter
                  addi         s8, zero, -8 #init loop 1 limit
                  div          t3, t4, tp
                  sll          s10, t5, a7
main_203_1_t:     mulhsu       a5, t0, s10
                  addi         a0, a0, -6 #update loop 1 counter
                  addi         t4, zero, 3 #init loop 0 counter
                  nop
                  addi         a1, zero, -16 #init loop 0 limit
main_203_0_t:     mulhu        a6, t1, a7
                  div          a6, zero, tp
                  slti         gp, a5, -1041
                  addi         t4, t4, -3 #update loop 0 counter
                  bge          t4, a1, main_203_0_t #branch for loop 0
                  csrrsi       a6, 0x304, 3
                  bge          a0, s8, main_203_1_t #branch for loop 1
                  sll          a5, s2, tp
                  la           a2, region_0+1072 #start riscv_load_store_rand_instr_stream_33
                  and          ra, ra, a3
                  lhu          t0, -222(a2)
                  addi         t5, a3, 1176
                  sh           a4, 28(a2)
                  mulhsu       a6, t2, s0
                  lw           t2, -196(a2)
                  lb           t3, 166(a2)
                  slli         ra, gp, 6
                  lb           s10, -216(a2)
                  andi         t6, s7, -1737
                  csrrwi       t2, 0x343, 28
                  and          zero, s10, a0
                  lh           s4, 214(a2)
                  lbu          t5, 173(a2)
                  or           s0, a0, a0
                  sra          a1, sp, t0
                  lbu          zero, -87(a2)
                  sra          a7, a2, s8
                  sh           s3, 74(a2)
                  mulh         s10, zero, s9
                  lui          s1, 211122
                  auipc        s11, 41795
                  lb           s0, 17(a2)
                  sub          a7, s1, s6
                  csrrwi       s0, 0x343, 15
                  lui          s8, 482757
                  lb           s3, -37(a2)
                  lb           a1, -105(a2)
                  mulh         gp, t5, tp
                  sb           s11, 106(a2)
                  lbu          s3, 113(a2)
                  auipc        s1, 995668
                  divu         gp, s1, t1
                  sb           s8, 241(a2)
                  sltu         a4, a3, a5
                  lbu          s3, -87(a2)
                  lb           t1, -82(a2)
                  xori         t6, a2, -662
                  lb           tp, -168(a2)
                  sb           sp, -225(a2)
                  sub          t1, s6, a7
                  sb           a5, -89(a2)
                  auipc        s5, 658115
                  sll          a1, a6, a5
                  sb           gp, 153(a2)
                  or           s11, s8, s6
                  lh           t3, -156(a2)
                  lh           s3, 130(a2) #end riscv_load_store_rand_instr_stream_33
                  la           s1, region_1+29121 #start load_store_instr_stream_3
                  la           s11, region_1+44772 #start load_store_instr_stream_1
                  la           a1, region_1+45957 #start load_store_instr_stream_2
                  lb           t6, -7(s11)
                  lhu          t6, -2(s11)
                  sh           s4, -1(s1)
                  lw           s2, 1107(a1)
                  lb           s5, -5(s11)
                  lb           s5, 2(s1)
                  la           a6, region_1+27316 #start load_store_instr_stream_0
                  lb           s6, 8(s1)
                  sh           t2, -1167(a1)
                  lb           s8, -5(s1)
                  lb           zero, 1(s11)
                  sb           sp, -780(a1)
                  lhu          t3, 11(s1)
                  sb           s1, -152(a6)
                  lb           s4, 2009(a1)
                  sb           t1, -3(s1)
                  sb           sp, -24(a6)
                  sb           t2, -16(s11)
                  lbu          t2, -3(s1)
                  lw           a4, 523(a1)
                  lh           t5, -9(s1)
                  lbu          t3, -230(a6)
                  lbu          t2, -1836(a1)
                  lbu          t3, -15(s11)
                  lbu          a5, 4(s1) #end load_store_instr_stream_3
                  sb           a6, 99(a6)
                  lb           s2, 11(s11)
                  lbu          s2, -221(a6)
                  lb           a5, -9(s11)
                  sh           s5, -8(s11)
                  lb           s6, 488(a1) #end load_store_instr_stream_2
                  lb           t5, -16(s11) #end load_store_instr_stream_1
                  lhu          t1, 202(a6) #end load_store_instr_stream_0
                  la           ra, region_1+33933 #start riscv_load_store_hazard_instr_stream_26
                  lb           t0, -242(ra)
                  sb           s5, -242(ra)
                  lb           s1, -242(ra)
                  lbu          zero, -242(ra)
                  sb           gp, -242(ra)
                  lbu          s6, -242(ra)
                  lb           a7, -242(ra)
                  lb           a6, -242(ra)
                  sb           t0, -160(ra)
                  lbu          s0, -160(ra)
                  lb           s6, 93(ra)
                  lh           s0, 93(ra)
                  lh           t6, 93(ra)
                  slti         t1, t5, 17
                  sb           t2, 93(ra)
                  csrrw        s0, 0x304, t0
                  srli         gp, s6, 11
                  sb           s5, 93(ra)
                  sltiu        s11, tp, 9
                  lhu          t1, 93(ra)
                  lbu          t1, 93(ra)
                  sh           t1, 93(ra)
                  lhu          a4, 93(ra)
                  lhu          s9, 93(ra) #end riscv_load_store_hazard_instr_stream_26
                  la           s11, region_0+2281 #start riscv_load_store_rand_instr_stream_11
                  lbu          a1, -208(s11)
                  csrrsi       t3, 0x344, 0
                  sh           s2, -83(s11)
                  sll          t3, t6, s5
                  sb           t2, 17(s11)
                  lhu          s3, 33(s11)
                  lb           a6, 62(s11)
                  sw           s7, -81(s11)
                  addi         t6, tp, 1845
                  csrrw        t5, 0x344, t1
                  lh           t0, 67(s11)
                  ori          t3, s10, -525
                  lb           a4, -72(s11)
                  nop
                  lhu          s3, -215(s11)
                  lb           s2, 238(s11)
                  remu         a4, s9, ra
                  sltu         t3, s5, gp
                  lbu          a7, -204(s11)
                  sb           zero, -78(s11)
                  lb           s2, -24(s11)
                  lhu          t2, 227(s11)
                  lhu          ra, 151(s11)
                  sh           s6, -19(s11)
                  csrrsi       tp, 0x343, 0
                  sltu         ra, s5, a6
                  lbu          s6, -251(s11)
                  lw           s0, 191(s11)
                  sb           s10, 240(s11)
                  sll          a5, a7, s7
                  sb           s10, 152(s11)
                  lbu          ra, -100(s11)
                  csrrc        s4, 0x343, s3
                  lbu          t6, 254(s11)
                  lb           s2, 87(s11)
                  csrrw        zero, 0x343, a7
                  sll          t1, s0, t4
                  remu         tp, s4, a5
                  xor          a7, s7, s3
                  csrrci       t3, 0x343, 7
                  lbu          s0, -254(s11)
                  sb           t6, 4(s11)
                  lhu          gp, -107(s11)
                  remu         a5, s6, a1
                  and          gp, gp, s4
                  sh           s3, 229(s11) #end riscv_load_store_rand_instr_stream_11
                  li           s5, 0x80000000 #start riscv_int_numeric_corner_stream_21
                  li           t6, 0x80000000
                  li           a1, 0xffffffff
                  li           t2, 0x0
                  li           a0, 0x0
                  li           t3, 0xffffffff
                  li           a2, 0x80000000
                  li           t0, 0x2c859e22
                  li           tp, 0x60f13352
                  li           s8, 0x0
                  sub          a2, t6, s5
                  div          a1, t2, t2
                  mulhsu       a0, a1, a2
                  rem          a2, a1, t0
                  auipc        a2, 596682
                  mulh         t2, t0, a1
                  nop
                  nop
                  mulhsu       t2, tp, s8
                  mulhu        a1, t2, t0
                  sub          a1, a0, s8
                  mulh         tp, s8, a1
                  lui          s5, 599112
                  add          t6, a0, s5
                  mul          a2, s8, a2
                  divu         a2, s5, a0
                  remu         a0, t3, tp
                  divu         t6, s5, a0
                  mulh         tp, a1, t6
                  rem          a2, a1, t0
                  div          s5, a1, tp #end riscv_int_numeric_corner_stream_21
main_102:         jal          t4, 8f
0:                jal          s0, 2f
1:                jal          ra, 13f
2:                jal          ra, 22f
3:                jal          ra, 5f
4:                jal          ra, 18f
5:                jal          t1, 10f
6:                jal          ra, 14f
7:                jal          t3, 4b
8:                jal          t1, 9f
9:                jal          ra, 6b
10:               jal          t1, 7b
11:               jal          ra, 19f
12:               jal          ra, 20f
13:               jal          ra, 3b
14:               jal          s4, 11b
15:               jal          a0, 12b
16:               jal          s3, 1b
17:               jal          s4, 21f
18:               jal          s11, 0b
19:               jal          ra, 17b
20:               jal          ra, 23f
21:               jal          ra, 16b
22:               jal          ra, 15b
23:               csrrwi       s11, 0x304, 15
                  la           a6, region_0+4059 #start load_store_instr_stream_1
                  la           t6, region_0+221 #start load_store_instr_stream_2
                  lbu          a7, -29(t6)
                  sh           a2, 31(a6)
                  sb           a1, 16(t6)
                  lbu          s8, -3(a6)
                  la           s10, region_0+3446 #start load_store_instr_stream_0
                  lbu          s8, 217(s10)
                  lh           a5, -55(t6)
                  lb           s0, -210(a6)
                  lb           s0, -163(a6)
                  lb           t3, -81(s10)
                  lbu          t2, -26(t6)
                  sb           t5, 22(a6)
                  sb           s2, 17(s10)
                  lbu          s3, -24(t6)
                  lb           s3, 10(t6)
                  sb           s3, -206(a6)
                  lb           t0, 38(t6)
                  lw           t4, 66(s10)
                  sh           gp, -37(t6) #end load_store_instr_stream_2
                  lb           t3, -246(a6) #end load_store_instr_stream_1
                  lb           a0, -121(s10) #end load_store_instr_stream_0
                  li           a0, 0xffffffff #start riscv_int_numeric_corner_stream_6
                  li           t1, 0xffffffff
                  li           ra, 0x982d8017
                  li           a5, 0x80000000
                  li           t4, 0x0
                  li           a4, 0x0
                  li           s1, 0xaf5385d8
                  li           s3, 0x28846382
                  li           a7, 0x0
                  li           t2, 0x0
                  mulh         ra, a4, s1
                  divu         s3, s3, a0
                  div          t1, a0, a4
                  remu         t1, t1, a5
                  nop
                  lui          t2, 13586
                  auipc        t4, 814117
                  div          t1, s1, a0
                  auipc        s3, 430340
                  sub          a5, s1, s1
                  auipc        t1, 739937
                  divu         a4, a4, t4
                  addi         t2, ra, 1885
                  mul          s3, s3, a4
                  mul          ra, a7, s3
                  divu         ra, s1, a4
                  divu         s3, a7, s3
                  divu         a7, ra, t2
                  mulhsu       t4, s1, a4
                  sub          ra, t4, a5
                  remu         a7, ra, a5
                  nop
                  rem          t1, t2, s3
                  div          s1, s3, ra
                  div          ra, ra, s1
                  nop
                  auipc        a5, 242825
                  remu         a7, ra, s1 #end riscv_int_numeric_corner_stream_6
                  la           a0, region_0+402 #start load_store_instr_stream_3
                  la           a2, region_0+799 #start load_store_instr_stream_2
                  la           s6, region_0+50 #start load_store_instr_stream_0
                  lh           s10, -10(a0)
                  lbu          a1, 1896(a2)
                  sb           t4, 3(a0)
                  lh           s1, 208(s6)
                  lhu          zero, 16(a0)
                  la           s0, region_0+2120 #start load_store_instr_stream_1
                  lbu          a5, -32(s0)
                  sb           s1, 1983(s6)
                  sh           a3, 4(a0)
                  lb           t6, -41(s0)
                  lh           t2, 58(s0)
                  sb           a0, 585(s6)
                  lbu          a1, 5(a0)
                  lb           a5, -51(s0)
                  sb           a4, -9(a0)
                  lbu          t6, 1115(s6)
                  sb           s1, 1051(s6)
                  lbu          s8, 948(a2)
                  sw           s1, -6(a0)
                  sw           a4, -36(s0)
                  lbu          t3, -51(s0)
                  lb           a4, 917(s6)
                  lbu          s2, 686(a2)
                  lb           s8, 61(s0)
                  lh           s5, -541(a2)
                  lbu          s2, -63(s0)
                  lb           s1, 1(a0) #end load_store_instr_stream_3
                  sb           a0, 971(a2) #end load_store_instr_stream_2
                  lb           a1, 6(s6)
                  lbu          s5, 630(s6)
                  lbu          s10, 55(s0) #end load_store_instr_stream_1
                  sh           s2, 1792(s6) #end load_store_instr_stream_0
                  la           t2, region_0+3999 #start load_store_instr_stream_1
                  la           t5, region_0+3153 #start load_store_instr_stream_2
                  la           s2, region_0+2912 #start load_store_instr_stream_3
                  sb           a5, 171(s2)
                  la           a5, region_0+3137 #start load_store_instr_stream_0
                  lbu          s4, -42(a5)
                  lbu          gp, 15(s2)
                  lbu          a7, 61(s2)
                  lb           s11, 24(t2)
                  lbu          ra, 41(a5)
                  sb           s2, 46(t2)
                  lh           t3, -35(a5)
                  lbu          a7, 55(t2)
                  sb           s4, 62(a5)
                  sb           s1, -172(s2)
                  lb           a7, -51(t2)
                  sb           s0, 36(t2)
                  lbu          tp, -18(a5)
                  sb           t6, 212(s2)
                  lb           s8, 888(t5)
                  sb           a3, 40(a5)
                  sh           a5, 1(t2)
                  lbu          t1, 78(t5)
                  lbu          s5, 40(a5)
                  lb           gp, -1338(t5)
                  lb           a6, -866(t5)
                  lbu          s9, 45(t2)
                  lhu          a2, 45(a5)
                  sb           a0, -119(s2) #end load_store_instr_stream_3
                  lh           t3, 13(t5)
                  lb           s0, 902(t5)
                  sb           s10, -521(t5)
                  lb           t6, 61(a5)
                  lhu          s3, -1225(t5)
                  lbu          s11, -29(t2) #end load_store_instr_stream_1
                  lbu          s11, 662(t5) #end load_store_instr_stream_2
                  lb           s4, 52(a5) #end load_store_instr_stream_0
                  addi         t2, zero, 2 #init loop 0 counter
                  sll          s9, s8, s11
                  ori          tp, t5, 1323
                  div          t5, s2, t4
                  andi         s8, a2, 379
                  addi         a0, zero, -14 #init loop 0 limit
                  or           t0, t4, s8
                  csrrci       zero, 0x343, 0
main_232_0_t:     or           s11, s2, a7
                  and          s11, a3, zero
                  addi         t2, t2, -8 #update loop 0 counter
                  beq          t2, a0, main_232_0_t #branch for loop 0
                  and          s9, t3, s8
                  la           t6, region_0+1627 #start load_store_instr_stream_1
                  sb           a0, 7(t6)
                  la           gp, region_0+2696 #start load_store_instr_stream_2
                  lh           s5, -5(t6)
                  lbu          a0, 0(t6)
                  la           a5, region_0+2374 #start load_store_instr_stream_3
                  lb           s4, -15(gp)
                  la           s6, region_0+591 #start load_store_instr_stream_0
                  lbu          s8, -3(gp)
                  la           tp, region_0+639 #start load_store_instr_stream_4
                  lb           ra, 1(t6)
                  lhu          t4, -7(tp)
                  lb           s3, -9(gp)
                  lb           t4, -37(a5)
                  sh           s4, 15(s6)
                  lh           s0, -15(tp)
                  lb           t2, -14(t6)
                  lbu          s11, 14(t6)
                  lb           s9, -2(s6)
                  lh           a7, -7(tp)
                  lbu          a6, 61(a5)
                  lbu          s11, -42(a5)
                  sb           gp, 3(s6)
                  lb           ra, 47(a5)
                  lb           a7, 12(s6)
                  sb           a7, -10(s6)
                  lw           a4, 8(gp)
                  sb           a2, -3(s6)
                  lb           a7, 15(tp)
                  lb           t0, -14(gp)
                  lbu          s8, -14(s6)
                  sb           tp, 0(t6)
                  lbu          s3, -8(tp)
                  sw           gp, -11(s6)
                  lb           a7, -11(gp) #end load_store_instr_stream_2
                  lb           s8, -9(t6)
                  sb           t6, 0(t6)
                  lw           t1, 5(s6)
                  lb           t4, 10(tp)
                  sb           t4, 2(tp) #end load_store_instr_stream_4
                  lbu          a1, 9(t6) #end load_store_instr_stream_1
                  sb           a3, -59(a5)
                  lbu          t3, -52(a5) #end load_store_instr_stream_3
                  lbu          a0, -12(s6) #end load_store_instr_stream_0
main_104:         jal          t4, 21f
0:                jal          ra, 14f
1:                jal          ra, 22f
2:                jal          ra, 7f
3:                jal          t1, 20f
4:                jal          ra, 19f
5:                jal          ra, 25f
6:                jal          t1, 15f
7:                jal          ra, 5b
8:                jal          ra, 18f
9:                jal          ra, 26f
10:               jal          ra, 9b
11:               jal          ra, 13f
12:               jal          ra, 2b
13:               jal          s6, 24f
14:               jal          tp, 4b
15:               jal          ra, 0b
16:               jal          ra, 11b
17:               jal          t1, 8b
18:               jal          ra, 3b
19:               jal          ra, 23f
20:               jal          ra, 1b
21:               jal          ra, 6b
22:               jal          ra, 16b
23:               jal          tp, 17b
24:               jal          t1, 12b
25:               jal          ra, 10b
26:               mulhu        t4, t4, a6
                  la           a6, region_0+1154 #start load_store_instr_stream_1
                  la           s10, region_1+32768 #start load_store_instr_stream_0
                  sb           t1, -132(a6)
                  lb           a7, 88(a6)
                  lb           s9, -12(s10)
                  lhu          ra, -16(s10)
                  sb           zero, -229(a6)
                  lbu          t0, 173(a6)
                  lh           s3, 220(a6)
                  lbu          s6, 163(a6)
                  lbu          gp, -13(s10)
                  lb           t3, -78(a6) #end load_store_instr_stream_1
                  sb           s9, -10(s10)
                  lb           gp, 14(s10)
                  lh           s5, 14(s10) #end load_store_instr_stream_0
                  la           s8, region_0+3788 #start riscv_hazard_instr_stream_19
                  lbu          ra, -1717(s8)
                  lbu          ra, 79(s8)
                  rem          t0, s1, t6
                  srl          t0, t0, t6
                  lh           a1, -624(s8)
                  sb           t0, -1241(s8)
                  lb           s1, 71(s8)
                  sh           a1, -58(s8)
                  lbu          s1, -275(s8)
                  lbu          t6, 264(s8)
                  sw           t6, -540(s8)
                  and          t6, t4, s1
                  lbu          t0, -1037(s8)
                  lhu          s1, -1984(s8)
                  csrrc        ra, 0x344, t0
                  lb           ra, 301(s8)
                  csrrc        t4, 0x301, t4
                  sra          ra, s1, t6
                  lbu          t0, -2037(s8)
                  auipc        t4, 660961
                  div          s1, s1, a1
                  lhu          t0, -1686(s8)
                  lb           t0, -1720(s8)
                  lbu          s1, -1424(s8)
                  mulhsu       ra, t6, t4
                  lh           t4, -580(s8)
                  lb           a1, -206(s8)
                  lbu          ra, -795(s8)
                  lbu          s1, -301(s8)
                  ori          t0, ra, 1192
                  and          t6, ra, t0
                  mulhsu       a1, a1, s1
                  sb           a1, -1554(s8)
                  csrrsi       s1, 0x342, 0
                  csrrs        a1, 0x301, a1
                  lb           t4, -1687(s8) #end riscv_hazard_instr_stream_19
                  la           s4, region_0+2134 #start riscv_load_store_hazard_instr_stream_24
                  sh           s9, -6(s4)
                  lb           a4, 15(s4)
                  srai         a1, tp, 5
                  sb           t6, 15(s4)
                  nop
                  sb           s3, 15(s4)
                  sb           gp, 15(s4)
                  sb           t1, 15(s4)
                  sb           t5, 15(s4)
                  lbu          a7, 15(s4)
                  lhu          t1, -16(s4)
                  lb           s5, -16(s4)
                  lbu          s5, -16(s4)
                  sb           s2, -16(s4)
                  sh           a5, -8(s4)
                  sb           s6, -8(s4)
                  lhu          s9, -8(s4)
                  lbu          zero, -11(s4)
                  lb           s6, -11(s4)
                  sb           a6, 1(s4)
                  lbu          a5, 6(s4) #end riscv_load_store_hazard_instr_stream_24
main_103:         jal          t4, 3f
0:                jal          s3, 6f
1:                jal          s11, 9f
2:                jal          s1, 8f
3:                jal          ra, 18f
4:                jal          ra, 11f
5:                jal          ra, 14f
6:                jal          ra, 1b
7:                jal          ra, 0b
8:                jal          ra, 25f
9:                jal          ra, 23f
10:               jal          s4, 7b
11:               jal          t1, 2b
12:               jal          ra, 15f
13:               jal          t1, 10b
14:               jal          t1, 13b
15:               jal          t1, 19f
16:               jal          s9, 22f
17:               jal          ra, 4b
18:               jal          ra, 5b
19:               jal          ra, 16b
20:               jal          ra, 24f
21:               jal          s2, 12b
22:               jal          t1, 20b
23:               jal          a2, 17b
24:               jal          t1, 26f
25:               jal          ra, 21b
26:               sltiu        s11, s0, -1151
main_90:          jal          t4, 9f
0:                jal          ra, 10f
1:                jal          ra, 18f
2:                jal          t1, 4f
3:                jal          ra, 11f
4:                jal          ra, 7f
5:                jal          ra, 1b
6:                jal          t1, 16f
7:                jal          t2, 6b
8:                jal          ra, 20f
9:                jal          ra, 19f
10:               jal          ra, 17f
11:               jal          ra, 13f
12:               jal          t1, 15f
13:               jal          t1, 14f
14:               jal          ra, 0b
15:               jal          ra, 2b
16:               jal          ra, 3b
17:               jal          ra, 8b
18:               jal          ra, 12b
19:               jal          ra, 5b
20:               csrrsi       t3, 0x304, 0
                  la           s5, region_0+3931 #start riscv_load_store_hazard_instr_stream_36
                  slli         t3, t1, 4
                  lbu          a0, 16(s5)
                  sb           t4, -7(s5)
                  lb           t5, -7(s5)
                  srli         s9, a2, 4
                  lh           t2, -7(s5)
                  lw           t0, -47(s5)
                  nop
                  sll          s4, s3, ra
                  lh           s3, -47(s5)
                  sh           a0, 15(s5)
                  lh           t0, 15(s5)
                  lbu          a0, 15(s5)
                  sw           a6, 29(s5) #end riscv_load_store_hazard_instr_stream_36
                  la           ra, region_1+21809 #start load_store_instr_stream_0
                  la           a0, region_1+56150 #start load_store_instr_stream_4
                  la           s11, region_1+831 #start load_store_instr_stream_1
                  lb           a2, 751(a0)
                  lb           a6, 52(ra)
                  lbu          s8, -2(s11)
                  lb           t0, 110(ra)
                  lw           s5, -39(s11)
                  la           a4, region_1+21698 #start load_store_instr_stream_3
                  lb           t6, 205(a0)
                  lhu          s5, 704(a0)
                  lhu          t0, 127(s11)
                  lb           t2, 164(ra)
                  lb           t1, 19(s11)
                  sb           s9, -1161(a0)
                  la           a7, region_1+59059 #start load_store_instr_stream_2
                  lw           gp, -83(s11)
                  lb           s6, 242(a7)
                  lb           t2, -775(a0)
                  lh           zero, -17(ra)
                  lb           s5, -101(a4)
                  lh           a6, 208(a4)
                  lhu          t3, 23(s11)
                  sb           s2, 12(a7)
                  lbu          t0, 142(s11)
                  sb           s4, -186(ra)
                  sb           a4, -141(a4)
                  lb           t5, 28(ra)
                  lbu          s9, 778(a0)
                  lh           t1, -72(a4)
                  lbu          t5, -50(s11) #end load_store_instr_stream_1
                  lhu          s9, 165(ra)
                  sb           t1, -125(a7)
                  sb           gp, -158(a7)
                  lbu          s1, 141(a4)
                  lh           s9, 163(a7) #end load_store_instr_stream_2
                  lb           s10, 1824(a0)
                  lbu          s8, 143(a4) #end load_store_instr_stream_3
                  lb           s0, -246(a0) #end load_store_instr_stream_4
                  lhu          s5, 49(ra) #end load_store_instr_stream_0
                  addi         s8, zero, -3 #init loop 1 counter
                  addi         a6, zero, 15 #init loop 1 limit
main_239_1_t:     lui          t6, 314838
                  addi         s8, s8, 4 #update loop 1 counter
                  addi         ra, zero, 2 #init loop 0 counter
                  mulhsu       t6, ra, t4
                  addi         t0, zero, 10 #init loop 0 limit
main_239_0_t:     rem          s10, a1, a1
                  addi         ra, ra, 8 #update loop 0 counter
                  beq          ra, t0, main_239_0_t #branch for loop 0
                  blt          s8, a6, main_239_1_t #branch for loop 1
                  addi         t4, a4, -520
                  la           t0, region_0+3636 #start riscv_load_store_rand_instr_stream_19
                  lb           t6, -5(t0)
                  mulhu        s3, a6, a1
                  mulhu        a5, a6, s8
                  lbu          s4, 7(t0)
                  lhu          s1, 4(t0)
                  sltiu        s4, ra, -2003
                  div          s1, s3, s8
                  srai         gp, ra, 29
                  csrrsi       s9, 0x343, 11
                  lb           t1, -5(t0)
                  add          a2, tp, zero
                  sb           s0, -7(t0)
                  sb           s3, -1(t0)
                  sb           a3, -7(t0)
                  lbu          t1, -16(t0)
                  lbu          s4, -10(t0)
                  slti         t2, a1, -1362
                  remu         s3, s11, a0
                  srai         tp, s0, 22
                  mulhsu       a5, ra, t0
                  lh           a4, 10(t0)
                  srai         t6, s5, 29
                  lb           a0, -3(t0)
                  sb           s4, 3(t0)
                  lui          s6, 276940
                  lb           t4, -11(t0)
                  lbu          t2, 2(t0) #end riscv_load_store_rand_instr_stream_19
                  li           s3, 0x5b9eeb36 #start riscv_int_numeric_corner_stream_13
                  li           s2, 0xda5b633e
                  li           s5, 0x80000000
                  li           ra, 0x52a3a804
                  li           s8, 0x80000000
                  li           t3, 0x25b1c7a7
                  li           s6, 0x0
                  li           a1, 0x0
                  li           a5, 0x864863a3
                  li           s10, 0x80000000
                  mulhsu       s8, s6, t3
                  lui          s2, 10238
                  sub          s3, s2, t3
                  mulh         s10, s10, s2
                  mul          s3, s8, s10
                  mulhsu       s2, s8, a1
                  auipc        s10, 25275
                  mulhsu       a5, ra, s3
                  rem          ra, s10, t3
                  mulhu        s10, s2, s10
                  rem          s3, s3, a1
                  remu         t3, s5, a5
                  remu         t3, s6, a5
                  divu         s2, s10, ra
                  rem          a1, s3, s8
                  sub          s3, ra, s5
                  mulh         s3, s2, s5
                  mulhsu       s10, s8, s8
                  remu         s10, s8, a5 #end riscv_int_numeric_corner_stream_13
main_116:         jal          t4, 12f
0:                jal          ra, 17f
1:                jal          ra, 16f
2:                jal          t1, 15f
3:                jal          t0, 4f
4:                jal          ra, 8f
5:                jal          ra, 3b
6:                jal          ra, 14f
7:                jal          gp, 0b
8:                jal          ra, 2b
9:                jal          s2, 7b
10:               jal          s4, 9b
11:               jal          tp, 6b
12:               jal          ra, 5b
13:               jal          t1, 11b
14:               jal          t1, 10b
15:               jal          ra, 1b
16:               jal          t1, 13b
17:               csrrw        s10, 0x344, tp
                  la           gp, region_1+52898 #start riscv_load_store_hazard_instr_stream_6
                  lb           s2, 7(gp)
                  sh           a0, -110(gp)
                  lhu          t0, -110(gp)
                  sh           a1, -110(gp)
                  and          zero, tp, t6
                  sb           t3, -110(gp)
                  sb           s5, -110(gp)
                  lbu          a4, 51(gp)
                  slti         s2, s8, 1075
                  sb           s0, 51(gp)
                  mulhsu       s4, a2, s4
                  rem          t5, a0, s8
                  lhu          s10, -246(gp)
                  sh           a5, -246(gp)
                  sw           s2, -246(gp)
                  lbu          t3, -246(gp)
                  lhu          a4, -246(gp)
                  lb           t6, -246(gp) #end riscv_load_store_hazard_instr_stream_6
                  la           t0, region_0+550 #start riscv_load_store_hazard_instr_stream_17
                  sb           s9, 201(t0)
                  lbu          a7, 40(t0)
                  mul          a7, a1, s2
                  lb           a7, 40(t0)
                  lhu          gp, 40(t0)
                  sb           s11, 40(t0)
                  lhu          t4, 10(t0)
                  lw           t5, 10(t0)
                  sb           t2, 10(t0)
                  sb           s2, 229(t0)
                  lbu          s9, -147(t0)
                  lbu          t6, -147(t0)
                  lb           s8, 26(t0) #end riscv_load_store_hazard_instr_stream_17
                  la           t3, region_0+3201 #start riscv_hazard_instr_stream_36
                  mul          a5, a5, a0
                  remu         s3, s1, s1
                  csrrc        a5, 0x344, a4
                  lhu          a4, -7(t3)
                  mulhu        a4, s1, a4
                  xori         s3, a0, -652
                  or           gp, gp, a0
                  csrrw        a0, 0x304, s3
                  auipc        s1, 951928
                  lb           s1, 3(t3)
                  lb           gp, -12(t3)
                  lbu          gp, -11(t3)
                  csrrci       s3, 0x342, 26
                  sll          s1, a0, a4
                  lui          gp, 838515
                  sb           s1, 8(t3)
                  addi         a4, a5, -1862
                  remu         a0, a0, a5
                  mulhu        a4, a5, s1
                  divu         s3, a4, a0
                  slli         a0, s3, 14
                  rem          a0, a4, a0
                  slli         a0, a4, 9
                  lb           a0, -14(t3)
                  lb           s1, 10(t3)
                  div          a5, a4, a5
                  lb           a0, -4(t3)
                  sb           s1, 12(t3)
                  lbu          a5, -10(t3)
                  slli         a4, s1, 8
                  csrrw        a5, 0x344, s1
                  remu         gp, a4, s1
                  sh           s1, 1(t3)
                  sb           s1, -10(t3)
                  lbu          a4, -8(t3)
                  csrrw        a5, 0x344, gp
                  nop
                  lh           a5, -13(t3) #end riscv_hazard_instr_stream_36
                  li           gp, 0xffffffff #start riscv_int_numeric_corner_stream_20
                  li           t0, 0x16058f4c
                  li           t2, 0xffffffff
                  li           s1, 0xffffffff
                  li           s4, 0xfce16b0e
                  li           t3, 0x1e721d6c
                  li           t6, 0x80000000
                  li           a4, 0xffffffff
                  li           t5, 0x80000000
                  li           s5, 0xffffffff
                  auipc        a4, 1019303
                  sub          t2, s5, a4
                  mulhsu       s4, t0, gp
                  sub          t0, t6, a4
                  add          s1, t0, a4
                  auipc        t6, 922474
                  remu         gp, t6, t2
                  mul          gp, a4, t0
                  rem          gp, s5, s5
                  sub          s5, t6, s5
                  mulh         t0, t3, s1
                  remu         s1, s1, t2
                  auipc        gp, 186517
                  auipc        t0, 485231
                  addi         s5, gp, -911
                  nop
                  auipc        t3, 920190
                  nop
                  remu         s4, s1, t2
                  mulhu        s4, s4, s5
                  add          t3, t5, s1
                  sub          t0, s5, t6
                  mul          t2, t6, s5
                  mul          t0, t6, t5
                  mulhu        t2, s5, t3
                  mulhsu       s5, s4, t2
                  mulhu        s4, t6, t6 #end riscv_int_numeric_corner_stream_20
                  la           s5, region_0+2583 #start load_store_instr_stream_1
                  la           a2, region_1+61350 #start load_store_instr_stream_0
                  lhu          a4, 11(s5)
                  lbu          a5, 26(s5)
                  lb           s0, 113(a2)
                  sb           s9, 137(a2)
                  lbu          a6, -105(a2)
                  lb           t5, 48(s5)
                  lb           a6, -120(a2)
                  sw           s7, 5(s5)
                  lbu          a6, -182(a2)
                  lb           s1, 36(a2)
                  lb           zero, 10(s5)
                  lbu          t2, 34(s5)
                  lb           a6, 244(a2)
                  lb           a0, -8(s5) #end load_store_instr_stream_1
                  lw           s1, 230(a2)
                  lb           s1, -63(a2)
                  lbu          gp, 218(a2) #end load_store_instr_stream_0
                  la           s4, region_1+58235 #start riscv_load_store_rand_instr_stream_36
                  srl          s10, a5, a6
                  sra          s1, t5, s6
                  andi         a4, s3, 2014
                  sltu         t3, t0, s4
                  lbu          t2, 1572(s4)
                  srai         gp, s11, 30
                  csrrsi       t0, 0x304, 0
                  csrrs        s2, 0x342, zero
                  lbu          s3, 124(s4)
                  sb           zero, 372(s4)
                  add          t4, tp, t2
                  lbu          t4, -1038(s4)
                  lhu          t5, -1871(s4)
                  sltiu        a2, s4, -371
                  lbu          a2, 734(s4)
                  sw           a4, 1061(s4)
                  sb           sp, -376(s4)
                  sub          t2, tp, s7
                  sb           t3, -524(s4)
                  sb           a0, -1205(s4)
                  sb           a2, -390(s4)
                  lh           s0, 1155(s4)
                  sb           s4, 938(s4)
                  xori         a5, gp, -1099
                  sub          t2, t0, a1
                  csrrs        t5, 0x305, zero
                  lbu          s6, -1324(s4)
                  nop
                  sb           s6, -52(s4)
                  ori          ra, s8, -1824
                  lbu          s3, 1016(s4)
                  csrrwi       a0, 0x342, 28
                  csrrs        t6, 0x304, t6
                  csrrci       s3, 0x342, 0
                  sh           t2, -49(s4)
                  sw           zero, -1363(s4)
                  lbu          zero, 1218(s4)
                  lb           zero, 1740(s4)
                  sh           t1, 263(s4)
                  sltiu        t2, a4, 471
                  lbu          t3, -1072(s4)
                  lhu          s8, -1327(s4)
                  lbu          a2, 2018(s4)
                  or           a6, s6, a6
                  lbu          a4, 1302(s4)
                  srli         s10, s9, 3
                  lb           t3, 550(s4)
                  mulhu        s11, gp, t5
                  csrrsi       t6, 0x300, 0
                  lb           a6, 488(s4)
                  csrrw        ra, 0x304, s0
                  add          a6, t2, t1
                  lb           ra, -1126(s4) #end riscv_load_store_rand_instr_stream_36
                  la           s11, region_1+9335 #start riscv_load_store_hazard_instr_stream_9
                  sb           a7, 122(s11)
                  lbu          s5, 122(s11)
                  lb           s0, 35(s11)
                  remu         s3, t1, t0
                  xori         a6, s9, -464
                  sh           a0, -181(s11)
                  lhu          s3, -133(s11)
                  lh           a0, -133(s11)
                  csrrw        t2, 0x301, s1
                  sltu         t1, t3, t0
                  lhu          a5, 223(s11)
                  csrrsi       s0, 0x300, 0
                  lb           a4, 223(s11)
                  lb           s1, 28(s11)
                  lbu          a7, 28(s11)
                  csrrci       s9, 0x300, 0
                  sb           zero, -190(s11)
                  lbu          zero, 227(s11)
                  srli         t0, sp, 20
                  lh           gp, 227(s11) #end riscv_load_store_hazard_instr_stream_9
main_87:          jal          t4, 23f
0:                jal          ra, 25f
1:                jal          ra, 12f
2:                jal          s11, 1b
3:                jal          ra, 22f
4:                jal          t1, 11f
5:                jal          s11, 6f
6:                jal          gp, 4b
7:                jal          ra, 18f
8:                jal          t1, 15f
9:                jal          gp, 10f
10:               jal          t1, 8b
11:               jal          s4, 24f
12:               jal          t1, 21f
13:               jal          ra, 26f
14:               jal          ra, 9b
15:               jal          ra, 2b
16:               jal          ra, 7b
17:               jal          a5, 19f
18:               jal          tp, 20f
19:               jal          ra, 3b
20:               jal          t1, 14b
21:               jal          s2, 0b
22:               jal          ra, 5b
23:               jal          ra, 17b
24:               jal          ra, 16b
25:               jal          t2, 13b
26:               csrrci       s11, 0x344, 19
                  la           s11, region_1+33093 #start riscv_load_store_hazard_instr_stream_10
                  lhu          t6, -11(s11)
                  sub          t4, a1, t0
                  lbu          a7, -43(s11)
                  sb           a0, -43(s11)
                  lbu          a2, -43(s11)
                  csrrsi       zero, 0x300, 0
                  lb           a1, 50(s11)
                  lb           t6, 26(s11)
                  lbu          t0, -28(s11)
                  lbu          s6, 30(s11)
                  sb           s10, 30(s11)
                  lbu          s3, 30(s11)
                  lh           s2, 11(s11)
                  lhu          t4, -5(s11)
                  sb           a0, 15(s11)
                  sb           s7, -62(s11)
                  csrrsi       s5, 0x343, 0
                  sb           a2, -62(s11)
                  lhu          t3, 33(s11) #end riscv_load_store_hazard_instr_stream_10
                  addi         a7, zero, 9 #init loop 1 counter
                  srl          gp, ra, t0
                  lui          s10, 156787
                  rem          s8, t1, a5
                  addi         t1, zero, 0 #init loop 1 limit
                  csrrw        a4, 0x342, zero
                  sltu         s9, s0, zero
                  auipc        s8, 539953
                  srl          s9, s10, t3
                  sll          s3, a7, t5
                  srl          t2, t0, s9
main_209_1_t:     addi         a5, gp, -552
                  xori         s3, a1, -337
                  addi         a7, a7, -4 #update loop 1 counter
                  addi         s4, a2, 903
                  xori         a4, t1, 235
                  srli         t3, tp, 17
                  addi         s0, zero, 8 #init loop 0 counter
                  csrrc        s8, 0x304, t5
                  addi         s11, zero, 8 #init loop 0 limit
                  sltu         ra, t2, s0
main_209_0_t:     slti         a2, s10, -998
                  addi         s0, s0, -5 #update loop 0 counter
                  bgeu         s0, s11, main_209_0_t #branch for loop 0
                  and          s4, a4, s2
                  andi         t4, s6, 1965
                  csrrc        s9, 0x343, zero
                  bge          a7, t1, main_209_1_t #branch for loop 1
                  slt          t2, t2, s0
                  la           gp, region_1+35135 #start load_store_instr_stream_0
                  sb           a1, 1854(gp)
                  la           s11, region_0+1976 #start load_store_instr_stream_1
                  lbu          s2, 94(s11)
                  lhu          s2, -623(gp)
                  lh           s6, 64(s11)
                  lb           t2, -138(s11)
                  sb           t6, -1294(gp)
                  lbu          s1, -11(s11)
                  lbu          s8, -1700(gp)
                  lhu          s0, 118(s11)
                  lb           a6, 192(s11)
                  lh           zero, -979(gp)
                  lb           s1, -82(s11) #end load_store_instr_stream_1
                  lh           tp, -589(gp)
                  sb           gp, -512(gp) #end load_store_instr_stream_0
                  la           t3, region_0+749 #start load_store_instr_stream_0
                  la           t1, region_0+980 #start load_store_instr_stream_1
                  lb           t2, 12(t3)
                  lbu          s9, 12(t3)
                  lb           t4, -91(t1)
                  sb           s11, -222(t1)
                  lhu          t6, -1(t3)
                  sb           s3, -65(t1)
                  lb           s4, 3(t3)
                  lbu          t6, 227(t1)
                  sb           a4, -253(t1)
                  sb           a5, 99(t1) #end load_store_instr_stream_1
                  lb           ra, -14(t3) #end load_store_instr_stream_0
                  li           gp, 0xb87a1bba #start riscv_int_numeric_corner_stream_35
                  li           a1, 0xffffffff
                  li           a0, 0x0
                  li           s8, 0x0
                  li           a2, 0x80000000
                  li           a5, 0x80000000
                  li           t0, 0xffffffff
                  li           s0, 0xffffffff
                  li           t5, 0xffffffff
                  li           t4, 0x0
                  mulhsu       t5, s8, a2
                  remu         gp, t5, t0
                  auipc        t4, 888662
                  div          gp, a2, t0
                  div          t5, gp, a5
                  rem          s8, a5, t4
                  lui          gp, 380449
                  remu         t5, a5, a1
                  auipc        t5, 444117
                  auipc        t0, 974095
                  divu         s0, t5, s8
                  remu         t0, s0, s8
                  mulhu        a1, a1, t4
                  div          s8, gp, a1
                  mulhsu       s8, t4, s0
                  mulhu        s0, s8, t5
                  mulhsu       s0, a5, a2
                  nop
                  sub          a5, a2, t0
                  mulhsu       s0, a0, a0
                  rem          a1, t5, s0
                  mulhu        a0, a2, t4
                  div          a1, t4, s8
                  rem          t4, a5, t5
                  remu         s8, a1, t5
                  auipc        a1, 580538
                  rem          a2, a0, a0
                  mulh         t5, a0, a0
                  mul          a2, a5, a0 #end riscv_int_numeric_corner_stream_35
                  la           a0, region_1+25456 #start load_store_instr_stream_1
                  la           s11, region_0+913 #start load_store_instr_stream_0
                  lbu          s0, 8(a0)
                  sh           t6, 12(a0)
                  sb           s8, -3(a0)
                  lb           s0, -30(s11)
                  sh           s9, 251(s11)
                  sb           a7, 2(s11)
                  sh           s4, -10(a0)
                  sb           zero, -118(s11)
                  sb           s10, 9(a0) #end load_store_instr_stream_1
                  lbu          s10, -72(s11) #end load_store_instr_stream_0
                  la           s10, region_0+3767 #start load_store_instr_stream_2
                  la           a6, region_0+2254 #start load_store_instr_stream_1
                  lb           a4, -1912(s10)
                  la           a0, region_0+2246 #start load_store_instr_stream_0
                  lhu          s1, -1475(s10)
                  lbu          s4, -618(s10)
                  sh           s2, -4(a0)
                  sb           t6, 5(a0)
                  lb           zero, 13(a6)
                  lbu          s0, -17(a6)
                  sb           tp, 11(a0)
                  lbu          s2, -1590(s10)
                  lb           a1, 27(a6)
                  sb           t1, -5(a0)
                  lbu          t0, -1788(s10)
                  sh           s0, -8(a0)
                  sh           s4, -58(a6)
                  lb           t3, -450(s10)
                  lh           t6, 8(a0)
                  lb           t6, -41(a6)
                  lb           s6, -53(a6)
                  sh           a2, 34(a6)
                  lbu          a2, -172(s10)
                  lb           s0, 29(a6)
                  sh           s7, 207(s10)
                  lhu          t1, 16(a0)
                  lb           t5, 2(a6)
                  lh           gp, -28(a6) #end load_store_instr_stream_1
                  sb           s0, -2004(s10) #end load_store_instr_stream_2
                  lhu          s11, -6(a0)
                  sb           t0, 11(a0) #end load_store_instr_stream_0
main_92:          jal          t4, 11f
0:                jal          a2, 2f
1:                jal          t1, 6f
2:                jal          ra, 8f
3:                jal          t1, 0b
4:                jal          ra, 13f
5:                jal          ra, 18f
6:                jal          a2, 16f
7:                jal          ra, 15f
8:                jal          ra, 14f
9:                jal          t1, 12f
10:               jal          s1, 9b
11:               jal          ra, 19f
12:               jal          ra, 21f
13:               jal          t1, 3b
14:               jal          ra, 1b
15:               jal          gp, 10b
16:               jal          s6, 7b
17:               jal          ra, 5b
18:               jal          ra, 20f
19:               jal          ra, 17b
20:               jal          ra, 4b
21:               and          s8, t2, t1
                  la           s1, region_0+3997 #start riscv_load_store_hazard_instr_stream_7
                  lb           a7, 2(s1)
                  srai         s3, t2, 25
                  addi         t0, t3, -1565
                  lbu          a2, 2(s1)
                  lbu          s5, 2(s1)
                  add          s4, a2, s8
                  csrrc        s10, 0x343, zero
                  lb           t4, 2(s1)
                  sb           s9, 2(s1)
                  addi         gp, s8, -1991
                  lbu          gp, 60(s1)
                  csrrwi       zero, 0x344, 4
                  lb           s3, 60(s1)
                  lb           a7, -20(s1)
                  lbu          s9, 25(s1)
                  auipc        a0, 153192
                  lb           t0, 25(s1)
                  sh           s10, -15(s1)
                  lw           gp, -9(s1)
                  lh           a1, -9(s1)
                  lhu          t1, -9(s1)
                  sb           s3, -9(s1)
                  sw           t4, -9(s1) #end riscv_load_store_hazard_instr_stream_7
                  la           t5, region_1+22693 #start riscv_load_store_hazard_instr_stream_5
                  lb           s6, -48(t5)
                  lb           t1, -48(t5)
                  sub          t1, gp, t3
                  lbu          zero, -48(t5)
                  lbu          s2, -48(t5)
                  lbu          a5, -48(t5)
                  remu         s8, t0, sp
                  sb           a2, -48(t5)
                  sra          zero, t0, s9
                  sltiu        s10, t1, 1492
                  and          a1, a2, sp
                  lh           a1, 45(t5)
                  mulh         s8, s8, s2
                  lb           gp, 45(t5)
                  lbu          s5, -3(t5)
                  slt          gp, ra, a6
                  sh           s3, -3(t5) #end riscv_load_store_hazard_instr_stream_5
                  la           s0, region_1+32704 #start load_store_instr_stream_1
                  sb           s9, -151(s0)
                  lbu          t6, -229(s0)
                  la           ra, region_0+3471 #start load_store_instr_stream_0
                  lbu          a5, -8(ra)
                  sb           t2, 205(s0)
                  lbu          a1, -11(ra)
                  lh           s10, -144(s0)
                  sb           ra, 247(s0)
                  lbu          a2, -2(ra)
                  sh           s6, -66(s0)
                  lw           a0, -100(s0)
                  lw           a5, 13(ra)
                  lb           s2, 255(s0) #end load_store_instr_stream_1
                  lbu          gp, -14(ra) #end load_store_instr_stream_0
                  la           s5, region_0+3550 #start load_store_instr_stream_1
                  lb           s10, -612(s5)
                  la           a2, region_1+8435 #start load_store_instr_stream_0
                  lbu          t2, 36(s5)
                  sw           t4, -966(s5)
                  lbu          s4, 403(s5)
                  lbu          t0, -1556(s5)
                  lb           s9, -60(a2)
                  lbu          s4, 538(s5)
                  lhu          gp, 49(a2)
                  lbu          zero, -797(s5)
                  sb           a4, -840(s5)
                  lb           t2, -308(s5)
                  sb           s6, -5(a2)
                  lbu          s1, -1031(s5) #end load_store_instr_stream_1
                  lbu          t0, 61(a2)
                  sw           a2, 5(a2) #end load_store_instr_stream_0
                  li           a7, 0xffffffff #start riscv_int_numeric_corner_stream_12
                  li           s11, 0xffffffff
                  li           s0, 0xffffffff
                  li           gp, 0x6a874bc9
                  li           a6, 0x80000000
                  li           tp, 0x80000000
                  li           ra, 0x80000000
                  li           t2, 0xf02b7335
                  li           t0, 0x0
                  li           a5, 0xffffffff
                  divu         t0, t0, s11
                  div          tp, s0, s11
                  lui          gp, 435295
                  nop
                  rem          tp, s0, a5
                  div          a5, ra, tp
                  sub          s11, ra, a6
                  nop
                  mulh         s11, a7, gp
                  auipc        t2, 724671
                  mulh         a5, gp, ra
                  rem          gp, gp, s11
                  sub          s0, a5, t0
                  mulhsu       a5, tp, t2
                  add          t0, ra, t2 #end riscv_int_numeric_corner_stream_12
                  li           s3, 0x80000000 #start riscv_int_numeric_corner_stream_2
                  li           s9, 0x80000000
                  li           a5, 0x80000000
                  li           t3, 0x617a1e16
                  li           ra, 0x0
                  li           s8, 0xffffffff
                  li           t2, 0xffffffff
                  li           s5, 0x5cec2471
                  li           a4, 0x0
                  li           s10, 0xb3fa3b6e
                  nop
                  mul          t3, s10, s3
                  divu         t3, s8, t3
                  div          t3, ra, ra
                  divu         t2, s10, ra
                  nop
                  nop
                  lui          ra, 806041
                  auipc        a4, 1016612
                  lui          ra, 734173
                  mulhu        a4, a4, a4
                  auipc        s8, 639568
                  auipc        a5, 771683
                  remu         s3, a4, s10
                  mul          ra, a4, a5
                  nop
                  sub          s9, s10, s8
                  div          s10, ra, t2 #end riscv_int_numeric_corner_stream_2
main_106:         jal          t4, 14f
0:                jal          ra, 15f
1:                jal          t1, 20f
2:                jal          tp, 13f
3:                jal          t1, 7f
4:                jal          ra, 16f
5:                jal          t1, 8f
6:                jal          ra, 17f
7:                jal          s11, 18f
8:                jal          ra, 12f
9:                jal          ra, 0b
10:               jal          a2, 1b
11:               jal          a5, 5b
12:               jal          t1, 6b
13:               jal          ra, 19f
14:               jal          ra, 2b
15:               jal          t1, 4b
16:               jal          ra, 10b
17:               jal          ra, 9b
18:               jal          ra, 11b
19:               jal          tp, 3b
20:               slli         t1, a1, 11
                  la           t6, region_0+2495 #start load_store_instr_stream_0
                  la           s3, region_1+27222 #start load_store_instr_stream_1
                  sh           t3, -1066(s3)
                  lhu          t0, 2016(s3)
                  lbu          a5, -128(t6)
                  sb           a4, 80(t6)
                  lhu          zero, 1572(s3)
                  lbu          s5, -54(t6)
                  lb           t0, -1345(s3)
                  lbu          t0, 180(t6)
                  lbu          ra, -355(s3)
                  sb           ra, -110(t6)
                  lb           a0, -757(s3)
                  lbu          gp, 132(t6)
                  sb           t0, 2033(s3) #end load_store_instr_stream_1
                  sb           s9, 136(t6)
                  lh           s2, -9(t6) #end load_store_instr_stream_0
                  li           a0, 0xffffffff #start riscv_int_numeric_corner_stream_23
                  li           t4, 0x0
                  li           a4, 0x80000000
                  li           s1, 0xffffffff
                  li           t2, 0x0
                  li           a2, 0x0
                  li           s9, 0x0
                  li           ra, 0xffffffff
                  li           a5, 0x0
                  li           gp, 0xe2ca1264
                  nop
                  addi         a0, a5, -1431
                  lui          a4, 108670
                  sub          a5, t4, a2
                  mulh         t2, gp, s1
                  mul          a2, a4, a5
                  lui          a5, 476552
                  mulhu        a4, s1, gp
                  remu         s1, gp, a0
                  remu         a5, a0, gp
                  lui          a2, 599546
                  divu         t4, a2, t4
                  div          t4, s9, s1
                  add          a2, t4, t4
                  mulh         s9, t4, t4
                  mulhsu       a5, t2, a2
                  mulhu        a4, s9, a4
                  mulhu        a5, t2, a0
                  mul          ra, ra, t2
                  remu         a4, t4, a0
                  add          ra, a5, a2
                  nop #end riscv_int_numeric_corner_stream_23
                  li           s3, 0xffffffff #start riscv_int_numeric_corner_stream_16
                  li           s1, 0x9dfcce80
                  li           t4, 0xffffffff
                  li           t3, 0xffffffff
                  li           a5, 0x607b13d6
                  li           tp, 0x0
                  li           a7, 0x0
                  li           s5, 0xffffffff
                  li           t1, 0x80000000
                  li           a1, 0x80000000
                  auipc        s3, 967095
                  remu         a7, t3, a7
                  sub          a5, a1, s3
                  remu         a1, tp, a1
                  sub          s3, s1, t4
                  remu         a1, tp, s5
                  remu         t3, t4, s3
                  mulh         s3, t1, s5
                  mul          t4, a1, s3
                  lui          tp, 952034
                  nop
                  addi         a5, a7, 1920
                  rem          t3, a7, t1
                  div          t3, t4, a5
                  mul          a7, tp, a1
                  nop
                  add          a5, s5, s3
                  mulhsu       tp, s1, s3
                  div          tp, t1, tp
                  sub          t3, s3, t4
                  addi         s5, tp, 761
                  mul          a7, t1, a5
                  addi         s3, t3, -895
                  mulhu        a1, t4, tp
                  addi         a7, tp, -2
                  lui          t4, 99566
                  remu         a1, a7, tp
                  auipc        s3, 432283 #end riscv_int_numeric_corner_stream_16
                  la           s1, region_1+13055 #start load_store_instr_stream_2
                  la           s4, region_1+38007 #start load_store_instr_stream_4
                  la           t6, region_1+34010 #start load_store_instr_stream_1
                  la           t5, region_1+61169 #start load_store_instr_stream_3
                  lb           s2, 1295(t6)
                  lbu          s2, -1(s4)
                  lbu          a6, -16(s4)
                  sb           ra, 232(t5)
                  la           gp, region_1+6524 #start load_store_instr_stream_0
                  sh           s3, 3(s4)
                  lbu          s11, -178(s1)
                  sb           t3, 851(t6)
                  lb           a0, -220(s1)
                  lb           s11, 195(gp)
                  lh           s8, 179(t5)
                  lb           t0, 64(t6)
                  sb           s0, -115(s1)
                  lbu          t2, 193(s1)
                  lh           s5, -193(t5)
                  lbu          s6, 0(s4)
                  sh           s3, 830(t6)
                  lb           s5, -102(s1)
                  lh           s2, -7(s4)
                  sb           s9, 4(s1)
                  lbu          s10, -193(gp)
                  lw           t1, 242(t6)
                  lbu          a5, -272(t6)
                  lb           s6, 6(s4)
                  lh           a1, -3(s4)
                  lh           zero, -239(t5)
                  sb           a4, -75(gp)
                  sb           t1, -226(t5) #end load_store_instr_stream_3
                  lhu          a1, -670(t6)
                  lh           tp, 13(s4)
                  lb           t3, -224(gp)
                  sb           s8, -95(gp)
                  sb           s0, 14(s4)
                  sb           sp, 189(t6)
                  lhu          s3, 90(gp)
                  lb           s10, -14(s4) #end load_store_instr_stream_4
                  sb           s7, -1827(t6) #end load_store_instr_stream_1
                  lh           s11, -115(s1) #end load_store_instr_stream_2
                  lhu          tp, -212(gp) #end load_store_instr_stream_0
main_82:          jal          t4, 6f
0:                jal          t0, 18f
1:                jal          t1, 28f
2:                jal          ra, 20f
3:                jal          t0, 19f
4:                jal          t1, 23f
5:                jal          ra, 16f
6:                jal          ra, 14f
7:                jal          s11, 21f
8:                jal          ra, 7b
9:                jal          ra, 12f
10:               jal          ra, 4b
11:               jal          ra, 30f
12:               jal          t0, 25f
13:               jal          s6, 2b
14:               jal          t1, 26f
15:               jal          t1, 5b
16:               jal          ra, 1b
17:               jal          t4, 15b
18:               jal          s6, 24f
19:               jal          ra, 9b
20:               jal          s3, 10b
21:               jal          t1, 22f
22:               jal          ra, 3b
23:               jal          t1, 29f
24:               jal          a5, 17b
25:               jal          ra, 27f
26:               jal          ra, 0b
27:               jal          ra, 11b
28:               jal          s0, 13b
29:               jal          ra, 8b
30:               csrrs        s0, 0x305, zero
                  la           a7, region_0+2275 #start riscv_hazard_instr_stream_27
                  rem          a5, t6, s0
                  sh           gp, 1639(a7)
                  sll          s10, gp, s10
                  divu         a5, s10, gp
                  lb           t3, -1373(a7)
                  lb           gp, -1326(a7)
                  add          a5, s0, s10
                  lh           s10, 57(a7)
                  lb           t6, -1286(a7)
                  lhu          s0, -1555(a7)
                  slti         gp, s10, 2026
                  nop
                  ori          t3, t3, 1116
                  lb           t3, -344(a7)
                  srl          s10, s0, t6
                  lhu          gp, 907(a7)
                  lh           t6, -1249(a7)
                  or           a5, t3, s10
                  sltiu        gp, s0, -71
                  lbu          t3, 1138(a7)
                  sb           s0, -540(a7)
                  lhu          gp, -531(a7)
                  sb           gp, -808(a7)
                  andi         t6, t6, -744
                  sll          s10, s10, s0
                  sb           s0, -1386(a7)
                  srli         t3, gp, 22
                  lbu          t3, -1931(a7)
                  xor          s0, gp, gp
                  lb           t3, 1399(a7)
                  sb           s10, -1327(a7)
                  lb           gp, 1735(a7)
                  lbu          t6, -440(a7)
                  lbu          t6, 526(a7)
                  lb           t6, -58(a7)
                  lbu          s0, -478(a7)
                  lbu          t3, -1170(a7) #end riscv_hazard_instr_stream_27
                  la           s0, region_1+57160 #start riscv_load_store_hazard_instr_stream_39
                  add          a1, s4, gp
                  lh           t1, 512(s0)
                  sh           t6, -704(s0)
                  lbu          a6, -704(s0)
                  lb           s1, -704(s0)
                  lw           s10, -704(s0)
                  xor          t0, ra, t3
                  sw           a0, -104(s0)
                  lw           t1, -104(s0)
                  lh           tp, -104(s0)
                  lb           gp, -515(s0)
                  lb           s8, -244(s0)
                  sw           s8, -244(s0)
                  lb           gp, -244(s0)
                  lh           s3, -244(s0)
                  sb           s11, 687(s0)
                  nop
                  sra          t2, s10, s8
                  srli         a2, a4, 17
                  lbu          tp, 1153(s0)
                  lbu          a7, 1153(s0) #end riscv_load_store_hazard_instr_stream_39
                  la           s10, region_0+817 #start riscv_load_store_rand_instr_stream_37
                  lhu          t4, -57(s10)
                  lbu          s9, 1784(s10)
                  sh           gp, 423(s10)
                  nop
                  lui          s9, 505808
                  lb           tp, -348(s10)
                  sh           a6, 1607(s10)
                  lb           t6, 309(s10)
                  mul          s1, a6, t1
                  csrrsi       t6, 0x304, 25
                  lbu          a4, 638(s10)
                  lh           tp, 105(s10)
                  csrrw        t4, 0x344, s6
                  lb           s11, 37(s10)
                  srli         s8, s0, 0
                  lhu          tp, 1021(s10)
                  lui          a1, 465719
                  sh           a5, 613(s10)
                  lb           t0, 1006(s10)
                  lb           tp, 1533(s10)
                  addi         ra, t2, 1176
                  slti         a6, s11, -891
                  lb           a6, 194(s10)
                  sra          s1, a7, a7
                  sltiu        zero, s1, -1201
                  csrrc        s3, 0x301, t3
                  lbu          gp, 32(s10)
                  add          ra, ra, s3
                  lbu          s3, 959(s10)
                  lbu          t2, 1360(s10)
                  nop
                  lb           ra, 516(s10)
                  and          a6, a0, s11
                  sh           s0, 29(s10)
                  lbu          t0, 1826(s10)
                  lb           t2, 706(s10)
                  lbu          t2, -16(s10)
                  sh           gp, 1873(s10)
                  xori         s9, gp, 120
                  lb           t4, -698(s10)
                  addi         s6, a6, -616
                  nop
                  sltiu        s2, t3, 2003
                  lb           a6, 1210(s10)
                  nop
                  sw           t0, 671(s10)
                  remu         s9, s6, s9
                  lb           gp, -376(s10)
                  lbu          s0, 1618(s10)
                  sb           a4, 1089(s10)
                  lb           s9, -86(s10) #end riscv_load_store_rand_instr_stream_37
                  la           t1, region_0+3209 #start riscv_load_store_rand_instr_stream_32
                  mulhsu       t0, a2, tp
                  sb           s3, 208(t1)
                  remu         s1, t6, s2
                  add          gp, t5, t0
                  csrrci       a5, 0x343, 0
                  sh           a4, 149(t1)
                  csrrsi       s0, 0x343, 9
                  slti         t0, s1, 591
                  sb           t1, -256(t1)
                  ori          s3, s10, 374
                  sub          a5, s9, t0
                  add          s2, t0, s1
                  add          t2, sp, s3
                  mulhu        t6, t1, ra
                  ori          t2, a5, 120
                  sb           t0, 130(t1)
                  mul          s5, s8, s6
                  sw           s10, 199(t1)
                  mulh         gp, a5, a0
                  ori          gp, s7, 890
                  sb           t2, -34(t1)
                  lb           a7, -48(t1)
                  csrrsi       ra, 0x344, 31
                  sb           ra, 196(t1)
                  lb           a5, -24(t1)
                  lbu          a0, -199(t1)
                  csrrsi       t4, 0x305, 0
                  csrrci       s4, 0x300, 0
                  mulh         s6, s7, a4
                  lb           s1, -72(t1)
                  lh           zero, -95(t1)
                  srai         s5, s6, 17
                  sltu         a5, a2, t0
                  sw           s1, 187(t1)
                  sltiu        ra, a4, -595
                  sb           t3, -86(t1)
                  lui          t4, 134601
                  csrrci       a1, 0x342, 0
                  lui          t0, 177388
                  srli         t0, s1, 11
                  lb           a6, -172(t1)
                  lw           a7, -33(t1)
                  slti         a0, s9, -676
                  addi         t2, s3, 1366
                  lbu          s6, -132(t1) #end riscv_load_store_rand_instr_stream_32
                  la           t1, region_0+325 #start load_store_instr_stream_4
                  la           t2, region_0+1213 #start load_store_instr_stream_2
                  sw           s10, 131(t1)
                  la           s10, region_0+545 #start load_store_instr_stream_3
                  la           s2, region_0+1490 #start load_store_instr_stream_1
                  sw           s7, -1410(s2)
                  lb           ra, -605(s2)
                  la           t0, region_0+2249 #start load_store_instr_stream_0
                  lh           t6, 342(s2)
                  sb           t0, -54(t0)
                  sw           t0, -221(t1)
                  sh           s4, -37(t2)
                  lb           a6, -34(t0)
                  lbu          a4, 9(s10)
                  lbu          s8, 16(t1)
                  sh           s3, -39(t2)
                  sb           a2, 540(s2)
                  lbu          a0, 15(s10)
                  lb           a0, 8(t0)
                  sb           a7, 12(s10)
                  sb           t1, -289(s2) #end load_store_instr_stream_1
                  lbu          t3, 2(s10)
                  sb           t0, 6(s10)
                  lbu          tp, 0(s10) #end load_store_instr_stream_3
                  sb           t6, 243(t1)
                  lb           s6, -46(t2)
                  sh           s3, 147(t1)
                  sb           zero, -26(t2)
                  lh           a1, 163(t1)
                  lbu          s1, -33(t0)
                  lb           a7, -51(t1)
                  lh           gp, 15(t2) #end load_store_instr_stream_2
                  lh           a6, -201(t1) #end load_store_instr_stream_4
                  lw           s9, 23(t0) #end load_store_instr_stream_0
                  addi         s5, zero, 9 #init loop 0 counter
                  sll          a2, sp, t4
                  addi         s1, zero, -19 #init loop 0 limit
                  csrrci       s2, 0x301, 0
main_229_0_t:     xori         t3, zero, 1678
                  addi         s5, s5, -5 #update loop 0 counter
                  addi         a5, s8, -1964
                  divu         s2, t6, a0
                  bge          s5, s1, main_229_0_t #branch for loop 0
                  slt          t1, t2, s10
                  la           s11, region_1+19609 #start riscv_load_store_hazard_instr_stream_37
                  lbu          ra, -26(s11)
                  lb           a1, -26(s11)
                  sb           s3, -26(s11)
                  lbu          gp, -26(s11)
                  csrrs        s3, 0x342, zero
                  lb           t0, 18(s11)
                  lh           s2, 41(s11)
                  lhu          s1, 25(s11)
                  srl          zero, s6, a0
                  lhu          t2, 13(s11)
                  lh           s5, 13(s11)
                  sb           t1, 62(s11)
                  lb           a2, 30(s11)
                  xori         a0, s6, 951
                  lh           ra, -39(s11)
                  sh           s2, -39(s11)
                  mulh         s3, t4, s8
                  lbu          t4, 12(s11)
                  lbu          t4, 14(s11)
                  lbu          a5, -48(s11)
                  rem          s1, t2, tp
                  sb           ra, 33(s11)
                  and          a5, t1, a1
                  sb           a0, 33(s11) #end riscv_load_store_hazard_instr_stream_37
                  la           a7, region_0+1905 #start load_store_instr_stream_2
                  la           ra, region_0+4080 #start load_store_instr_stream_0
                  la           s9, region_0+100 #start load_store_instr_stream_1
                  lbu          s0, 212(a7)
                  sb           t0, -15(ra)
                  sh           a6, 195(a7)
                  sh           tp, -16(s9)
                  lb           s4, 10(a7)
                  lbu          t3, -15(s9)
                  lbu          t5, 3(s9)
                  sb           ra, 15(s9)
                  lb           s2, -3(ra)
                  lh           s8, 83(a7)
                  sb           s10, 8(s9)
                  lbu          s2, 15(ra)
                  lbu          t2, -9(ra)
                  lbu          tp, -16(a7)
                  lb           s1, 15(s9)
                  lb           t5, -133(a7)
                  lb           s6, -13(ra)
                  sb           s3, -245(a7) #end load_store_instr_stream_2
                  lb           a1, 5(ra)
                  lhu          a2, 14(s9) #end load_store_instr_stream_1
                  sh           t2, -6(ra)
                  lb           s0, 7(ra) #end load_store_instr_stream_0
                  addi         t4, zero, -9 #init loop 0 counter
                  slti         a4, s9, 1126
                  csrrwi       s11, 0x301, 10
                  xori         a2, s3, -1587
                  addi         s6, zero, -16 #init loop 0 limit
                  slli         s11, ra, 17
main_201_0_t:     mulh         s5, a0, s3
                  addi         t4, t4, -7 #update loop 0 counter
                  nop
                  bne          t4, s6, main_201_0_t #branch for loop 0
                  div          s2, s7, t5
main_95:          jal          t4, 22f
0:                jal          ra, 16f
1:                jal          s1, 18f
2:                jal          ra, 26f
3:                jal          s10, 10f
4:                jal          t1, 17f
5:                jal          gp, 11f
6:                jal          a2, 1b
7:                jal          a4, 0b
8:                jal          gp, 14f
9:                jal          ra, 19f
10:               jal          ra, 20f
11:               jal          t1, 6b
12:               jal          gp, 21f
13:               jal          t1, 7b
14:               jal          ra, 13b
15:               jal          t1, 12b
16:               jal          t1, 5b
17:               jal          ra, 24f
18:               jal          t1, 2b
19:               jal          ra, 4b
20:               jal          ra, 15b
21:               jal          t1, 8b
22:               jal          ra, 23f
23:               jal          ra, 9b
24:               jal          t1, 25f
25:               jal          t1, 3b
26:               andi         tp, a2, 465
                  la           tp, region_1+40057 #start load_store_instr_stream_1
                  lhu          s9, 15(tp)
                  la           s5, region_1+50081 #start load_store_instr_stream_3
                  lbu          t3, 237(s5)
                  la           s11, region_1+10404 #start load_store_instr_stream_2
                  lhu          s10, -63(tp)
                  sb           t1, 111(s11)
                  lb           t4, -2(s11)
                  lbu          zero, 83(s5)
                  lbu          a0, -199(s5)
                  lb           a7, 26(tp)
                  la           t6, region_1+21271 #start load_store_instr_stream_0
                  lb           s3, 28(tp)
                  sb           a5, 26(s11)
                  sb           a0, -1(t6)
                  sb           s1, -6(t6)
                  lb           s8, 1(tp)
                  sb           ra, -92(t6)
                  sh           s1, 203(s5)
                  lb           t2, 36(s11)
                  lb           s4, 40(tp)
                  sb           a0, -207(s11)
                  sb           sp, -224(s5)
                  sb           a3, 200(t6)
                  lbu          a2, -132(t6)
                  lbu          s10, 146(s11)
                  lb           a1, -138(t6)
                  sb           s10, 31(tp)
                  lbu          s3, -44(t6)
                  sb           a6, 43(s5) #end load_store_instr_stream_3
                  lhu          a5, 192(s11) #end load_store_instr_stream_2
                  lb           t1, 10(tp) #end load_store_instr_stream_1
                  sw           s2, 45(t6)
                  lb           a5, 146(t6) #end load_store_instr_stream_0
                  la           s0, region_1+3674 #start riscv_load_store_hazard_instr_stream_21
                  sb           ra, 55(s0)
                  remu         t3, t3, t1
                  lb           s4, 55(s0)
                  lb           t5, -31(s0)
                  csrrs        a1, 0x300, zero
                  sb           a0, -31(s0)
                  lbu          s5, -31(s0)
                  lbu          a6, -31(s0)
                  lbu          t5, 55(s0)
                  lb           s11, 45(s0)
                  mulh         tp, t4, s7
                  sb           a3, -29(s0)
                  slli         ra, a6, 5
                  slt          s4, t1, s10
                  lb           s6, 61(s0)
                  andi         s8, s6, -180
                  sb           t5, -11(s0)
                  sb           s3, -11(s0)
                  mulhsu       s11, a4, t0
                  lb           s4, -11(s0) #end riscv_load_store_hazard_instr_stream_21
                  la           s6, region_0+1275 #start load_store_instr_stream_1
                  la           a0, region_1+40686 #start load_store_instr_stream_0
                  sb           t2, -4(s6)
                  sb           s6, 103(s6)
                  sh           s0, 2(a0)
                  lw           s11, 34(a0)
                  lb           s0, -105(s6)
                  lb           tp, -59(a0)
                  lb           a1, -108(s6)
                  lb           t2, -2(s6)
                  lb           t4, 187(s6)
                  lhu          s0, 28(a0)
                  lb           s11, 66(s6) #end load_store_instr_stream_1
                  sb           t0, 16(a0) #end load_store_instr_stream_0
                  la           gp, region_0+1253 #start load_store_instr_stream_0
                  la           t3, region_1+57194 #start load_store_instr_stream_1
                  lb           zero, -1776(t3)
                  lb           zero, -7(gp)
                  lb           t2, -1(t3)
                  lw           t2, -1090(t3)
                  lh           t2, 1796(t3)
                  lbu          s0, 1(gp)
                  lb           s11, 393(t3)
                  lbu          t5, -1(gp)
                  sb           s3, 671(t3)
                  lhu          s8, -7(gp)
                  lb           t0, 2027(t3)
                  lb           tp, 436(t3)
                  sh           a7, 1(gp)
                  lb           a5, 355(t3) #end load_store_instr_stream_1
                  lh           t1, 9(gp) #end load_store_instr_stream_0
main_83:          jal          t4, 21f
0:                jal          ra, 29f
1:                jal          ra, 4f
2:                jal          ra, 19f
3:                jal          a0, 23f
4:                jal          t5, 11f
5:                jal          t1, 14f
6:                jal          a4, 24f
7:                jal          s3, 13f
8:                jal          ra, 1b
9:                jal          ra, 22f
10:               jal          ra, 15f
11:               jal          tp, 28f
12:               jal          a7, 26f
13:               jal          ra, 9b
14:               jal          ra, 20f
15:               jal          s2, 30f
16:               jal          t1, 8b
17:               jal          ra, 27f
18:               jal          s1, 3b
19:               jal          ra, 7b
20:               jal          t1, 17b
21:               jal          t1, 6b
22:               jal          ra, 5b
23:               jal          ra, 10b
24:               jal          ra, 16b
25:               jal          ra, 12b
26:               jal          ra, 0b
27:               jal          s4, 18b
28:               jal          ra, 25b
29:               jal          ra, 2b
30:               csrrs        s10, 0x300, zero
                  addi         gp, zero, -7 #init loop 1 counter
                  mulh         a1, s9, t4
                  srai         s0, s0, 22
                  addi         t6, zero, -15 #init loop 1 limit
                  slti         t4, s11, 287
                  andi         s10, a6, 905
                  sll          s1, t3, s0
                  xori         s10, s0, -540
main_202_1_t:     rem          a7, gp, s11
                  sub          s3, a5, t0
                  slt          s2, a2, s11
                  divu         s3, s10, t5
                  sltiu        a2, zero, -2008
                  addi         gp, gp, -1 #update loop 1 counter
                  slti         s0, a2, -1641
                  addi         t0, zero, 9 #init loop 0 counter
                  sltu         t5, a6, t3
                  sra          a6, s11, s4
                  addi         s11, zero, 9 #init loop 0 limit
                  lui          a2, 1044909
                  sltu         a7, s3, t4
                  xor          a1, a4, t2
main_202_0_t:     divu         s2, sp, s7
                  addi         t0, t0, -7 #update loop 0 counter
                  mulh         t1, a6, gp
                  csrrsi       s3, 0x305, 0
                  bgeu         t0, s11, main_202_0_t #branch for loop 0
                  bge          gp, t6, main_202_1_t #branch for loop 1
                  srli         t3, t6, 7
main_115:         jal          t4, 6f
0:                jal          ra, 8f
1:                jal          ra, 4f
2:                jal          ra, 9f
3:                jal          ra, 12f
4:                jal          s1, 5f
5:                jal          ra, 10f
6:                jal          a4, 7f
7:                jal          tp, 13f
8:                jal          ra, 14f
9:                jal          t1, 0b
10:               jal          t1, 3b
11:               jal          t1, 2b
12:               jal          ra, 11b
13:               jal          t1, 1b
14:               mulhsu       s8, a7, ra
                  la           s9, region_0+382 #start load_store_instr_stream_3
                  la           s11, region_0+2385 #start load_store_instr_stream_2
                  la           a1, region_0+318 #start load_store_instr_stream_1
                  sb           a2, -10(a1)
                  la           gp, region_0+1477 #start load_store_instr_stream_0
                  lbu          t4, -12(s9)
                  lbu          a0, -1(s11)
                  lhu          s3, -16(a1)
                  lb           s5, -55(gp)
                  lbu          s0, 2(s9)
                  sb           a5, 10(a1)
                  sh           sp, 1(s11)
                  sb           gp, -147(gp)
                  lbu          s2, -16(s11)
                  lbu          s5, -63(gp)
                  sb           zero, 11(s9)
                  sh           t2, 4(s9)
                  lbu          t5, 13(s9)
                  lb           s10, -6(a1)
                  lhu          t0, -8(a1)
                  sb           a3, -16(a1)
                  sb           s7, -1(s9)
                  lhu          tp, 16(a1)
                  lbu          t6, -98(gp)
                  lbu          s0, 6(s11)
                  lb           ra, 3(a1)
                  lhu          s5, 5(s11)
                  lh           ra, -4(a1)
                  lbu          t6, -110(gp)
                  lhu          s6, -14(s9)
                  lb           s3, -25(gp)
                  lb           t6, -11(s11) #end load_store_instr_stream_2
                  lbu          s4, -4(s9)
                  sb           a7, -15(a1) #end load_store_instr_stream_1
                  lb           s0, 52(gp)
                  lbu          s2, 16(s9) #end load_store_instr_stream_3
                  sb           t0, 244(gp) #end load_store_instr_stream_0
                  addi         t4, zero, -10 #init loop 1 counter
                  addi         s2, zero, 6 #init loop 1 limit
                  slti         s6, t3, 1818
main_221_1_t:     or           s8, s5, gp
                  slli         gp, t2, 11
                  addi         t4, t4, 9 #update loop 1 counter
                  sll          a4, a5, tp
                  nop
                  xor          a1, t4, a0
                  csrrci       s5, 0x342, 22
                  csrrs        a7, 0x344, t6
                  lui          zero, 256594
                  slli         s8, a6, 12
                  addi         s10, zero, 10 #init loop 0 counter
                  sra          t5, t6, s0
                  addi         ra, zero, -16 #init loop 0 limit
                  slli         a4, a3, 14
                  remu         t3, t4, zero
                  or           t1, s7, s5
main_221_0_t:     mul          a6, a1, s3
                  sltiu        a1, sp, 2040
                  nop
                  mulhu        gp, a6, s11
                  addi         s10, s10, -6 #update loop 0 counter
                  andi         a7, t2, -986
                  mul          t5, t6, s8
                  ori          t5, a6, 736
                  bge          s10, ra, main_221_0_t #branch for loop 0
                  sub          s8, a4, a1
                  divu         zero, a1, a7
                  add          tp, a0, s9
                  sra          tp, t2, s10
                  csrrw        s9, 0x343, a0
                  blt          t4, s2, main_221_1_t #branch for loop 1
                  srai         s5, a0, 15
                  la           a6, region_1+6813 #start load_store_instr_stream_1
                  lb           a0, 2(a6)
                  lbu          s4, -9(a6)
                  lh           t0, 1(a6)
                  la           s10, region_0+661 #start load_store_instr_stream_0
                  lbu          s5, 1291(s10)
                  lb           t5, 0(a6)
                  lh           t0, 1655(s10)
                  lh           s9, 1921(s10)
                  sb           ra, 1151(s10)
                  sh           s9, -7(a6)
                  lbu          a5, 554(s10)
                  sh           s9, -3(a6)
                  sb           t4, 1066(s10)
                  lbu          tp, 2(a6)
                  sb           a6, -4(a6) #end load_store_instr_stream_1
                  sb           sp, -446(s10) #end load_store_instr_stream_0
                  la           a0, region_1+6400 #start load_store_instr_stream_0
                  la           t5, region_0+2467 #start load_store_instr_stream_1
                  lbu          tp, 13(a0)
                  sb           s3, -28(t5)
                  lh           a7, -233(t5)
                  lbu          a4, -214(t5)
                  lhu          s1, -16(a0)
                  lbu          gp, -3(a0)
                  lh           s5, 6(a0)
                  lhu          s4, -4(a0)
                  lhu          s10, 253(t5)
                  sb           t5, -242(t5)
                  lbu          s10, 24(t5)
                  sh           t6, -4(a0)
                  lbu          s3, -80(t5) #end load_store_instr_stream_1
                  lw           t0, -8(a0)
                  sb           a5, 3(a0) #end load_store_instr_stream_0
                  addi         a4, zero, -9 #init loop 1 counter
                  addi         a7, zero, -19 #init loop 1 limit
main_204_1_t:     lui          s11, 1007958
                  addi         a4, a4, -2 #update loop 1 counter
                  addi         s2, zero, -6 #init loop 0 counter
                  addi         t2, zero, -19 #init loop 0 limit
main_204_0_t:     lui          s3, 982861
                  and          s10, t6, a1
                  addi         s2, s2, -4 #update loop 0 counter
                  bge          s2, t2, main_204_0_t #branch for loop 0
                  remu         s11, t3, s2
                  slt          t4, s2, s6
                  remu         t0, s5, s6
                  bne          a4, a7, main_204_1_t #branch for loop 1
                  csrrc        zero, 0x344, t2
                  addi         t4, zero, 9 #init loop 1 counter
                  csrrw        t3, 0x344, sp
                  srl          t2, a0, a5
                  addi         t1, zero, 15 #init loop 1 limit
main_235_1_t:     xor          t3, tp, a1
                  addi         t4, t4, 10 #update loop 1 counter
                  addi         a6, zero, 10 #init loop 0 counter
                  or           t3, a5, s8
                  addi         t5, zero, -10 #init loop 0 limit
main_235_0_t:     addi         s1, t3, 1137
                  xori         a4, s1, 92
                  addi         a6, a6, -5 #update loop 0 counter
                  bge          a6, t5, main_235_0_t #branch for loop 0
                  xor          ra, s3, t3
                  slli         s10, a2, 7
                  mulhsu       t3, a6, t3
                  csrrw        gp, 0x304, a7
                  bltu         t4, t1, main_235_1_t #branch for loop 1
                  mulhsu       s3, a2, sp
                  la           a4, region_0+129 #start load_store_instr_stream_1
                  lh           zero, 5(a4)
                  la           s1, region_0+2180 #start load_store_instr_stream_0
                  sw           t4, -28(s1)
                  lh           s6, 50(s1)
                  lhu          s4, -5(a4)
                  lb           s8, -7(a4)
                  lb           t1, -214(s1)
                  lbu          t0, -14(a4)
                  lb           t5, 197(s1)
                  lbu          a0, -7(s1)
                  lb           a0, 7(a4)
                  sb           s4, -225(s1)
                  lb           t2, -12(a4)
                  lbu          a7, 4(a4) #end load_store_instr_stream_1
                  lb           t5, 141(s1)
                  sb           a1, 7(s1) #end load_store_instr_stream_0
main_84:          jal          t4, 10f
0:                jal          ra, 3f
1:                jal          s3, 4f
2:                jal          ra, 1b
3:                jal          s11, 5f
4:                jal          a5, 6f
5:                jal          t1, 2b
6:                jal          ra, 7f
7:                jal          t1, 11f
8:                jal          ra, 12f
9:                jal          ra, 8b
10:               jal          ra, 0b
11:               jal          ra, 9b
12:               nop
                  la           t4, region_0+3687 #start load_store_instr_stream_0
                  la           s1, region_0+1799 #start load_store_instr_stream_4
                  sb           ra, 154(s1)
                  la           t6, region_0+928 #start load_store_instr_stream_3
                  sw           sp, -396(t6)
                  sb           s8, 1225(t6)
                  lb           t0, 238(s1)
                  lh           a5, -772(t6)
                  lb           s5, -11(t4)
                  la           t1, region_0+2133 #start load_store_instr_stream_2
                  lb           a5, 195(s1)
                  lb           s0, 12(t4)
                  la           s10, region_0+3171 #start load_store_instr_stream_1
                  lbu          gp, -5(s10)
                  sb           s9, 88(s1)
                  lw           t3, 580(t6)
                  sb           s0, 104(t6)
                  lbu          s0, -925(t6)
                  lbu          s5, -6(t4)
                  lbu          tp, 529(t1)
                  sb           s3, -431(t1)
                  lh           a0, 9(t4)
                  lbu          tp, 0(t4)
                  lbu          t0, -172(s10)
                  lb           s3, 13(t4)
                  lhu          s6, 149(s1) #end load_store_instr_stream_4
                  lb           a5, 1624(t1)
                  lb           a2, 1010(t1)
                  sb           s11, -1930(t1)
                  sw           s2, -7(t4)
                  lbu          t3, 250(s10)
                  sb           a1, 1074(t1) #end load_store_instr_stream_2
                  lb           ra, -230(s10)
                  lbu          a2, 14(t4)
                  sb           s8, -84(s10)
                  lh           t0, -52(t6) #end load_store_instr_stream_3
                  lbu          t0, 0(t4)
                  lbu          a2, -175(s10) #end load_store_instr_stream_1
                  lhu          s3, -3(t4) #end load_store_instr_stream_0
                  addi         s6, zero, 0 #init loop 1 counter
                  addi         t3, zero, -16 #init loop 1 limit
main_211_1_t:     slti         s8, t0, 1396
                  andi         t6, zero, -890
                  addi         s6, s6, -8 #update loop 1 counter
                  addi         a2, zero, -3 #init loop 0 counter
                  addi         a1, zero, 3 #init loop 0 limit
                  sltu         a0, s2, ra
main_211_0_t:     mul          t1, s4, t5
                  div          gp, a2, t0
                  addi         a2, a2, 3 #update loop 0 counter
                  divu         t4, t6, a2
                  div          tp, a7, a2
                  bne          a2, a1, main_211_0_t #branch for loop 0
                  beq          s6, t3, main_211_1_t #branch for loop 1
                  remu         s2, s0, tp
                  la           s0, region_0+3285 #start riscv_load_store_rand_instr_stream_18
                  sb           t3, 8(s0)
                  div          s1, a5, s2
                  lhu          s10, -7(s0)
                  lhu          s6, 3(s0)
                  lb           s9, -2(s0)
                  sb           t3, 2(s0)
                  and          s5, ra, s11
                  csrrs        s8, 0x344, zero
                  lbu          t3, 9(s0)
                  mulhsu       s11, t1, gp
                  csrrsi       a7, 0x301, 0
                  lhu          t3, 13(s0)
                  sltu         s1, s3, s11
                  div          t3, t3, t6
                  lbu          s2, -6(s0)
                  lbu          s6, -16(s0)
                  srli         s11, t3, 20
                  sw           s10, 15(s0)
                  sll          a1, s1, t6
                  mulhsu       s8, s10, t3
                  rem          s8, sp, t2
                  mul          t5, a6, t6
                  mulhsu       a2, a7, a5
                  lbu          t6, -4(s0)
                  sb           a6, 2(s0)
                  lb           a4, -12(s0)
                  auipc        s3, 782574
                  sb           zero, 2(s0)
                  sb           zero, -4(s0)
                  lb           gp, 9(s0)
                  lb           s2, 6(s0)
                  sb           t6, -13(s0)
                  sb           s7, -12(s0)
                  lb           s9, 16(s0)
                  remu         s4, t3, gp
                  lh           s3, 1(s0)
                  add          t0, sp, a7
                  lh           t1, -3(s0)
                  lb           t1, -11(s0)
                  sll          s9, s11, s11
                  csrrw        t2, 0x344, t6
                  sb           s10, -16(s0)
                  csrrw        s9, 0x304, a5
                  andi         tp, a0, 197
                  lb           s1, 12(s0) #end riscv_load_store_rand_instr_stream_18
                  la           s8, region_1+1768 #start load_store_instr_stream_1
                  la           a2, region_0+66 #start load_store_instr_stream_0
                  sb           s9, -1624(s8)
                  sb           a6, 549(s8)
                  lb           s9, 65(a2)
                  sb           s10, -27(a2)
                  lb           s11, -1503(s8)
                  sb           s4, 163(a2)
                  lb           s11, 1825(s8)
                  lbu          a1, 227(a2)
                  sb           s1, 107(a2)
                  lw           a1, 118(a2)
                  lbu          t4, 1970(s8)
                  lbu          a4, 135(a2)
                  sb           s0, 1760(s8)
                  sb           a1, 15(s8) #end load_store_instr_stream_1
                  lbu          s3, 73(a2) #end load_store_instr_stream_0
                  la           t3, region_0+3430 #start load_store_instr_stream_1
                  lhu          t0, -70(t3)
                  la           s4, region_1+12579 #start load_store_instr_stream_0
                  lb           ra, -1968(t3)
                  sb           zero, -52(s4)
                  lw           s1, 37(s4)
                  lbu          a5, 18(s4)
                  lhu          s0, -1394(t3)
                  lbu          s6, -927(t3)
                  lhu          s10, 3(s4)
                  lh           s1, 104(t3)
                  lbu          tp, -2037(t3)
                  sb           a2, -40(s4)
                  lhu          s8, 11(s4)
                  lbu          ra, 57(s4)
                  sb           s10, -1489(t3) #end load_store_instr_stream_1
                  sw           tp, 21(s4) #end load_store_instr_stream_0
                  la           tp, region_1+11997 #start riscv_load_store_rand_instr_stream_9
                  lbu          a7, 1172(tp)
                  lb           s4, -1184(tp)
                  andi         t3, a4, -1788
                  lbu          t2, 1764(tp)
                  lbu          a4, -946(tp)
                  or           s3, a7, t4
                  sltu         s2, a6, zero
                  lh           s9, 1009(tp)
                  sltu         s0, s5, s8
                  lb           s8, -1916(tp)
                  lh           t0, -1859(tp)
                  lb           s4, 796(tp)
                  lui          s10, 65672
                  rem          a4, a5, s7
                  csrrwi       s9, 0x304, 31
                  lbu          s5, 466(tp)
                  div          s4, a4, a0
                  csrrwi       a5, 0x304, 1
                  lb           t5, 1930(tp)
                  mulhsu       s5, t2, s11
                  mulh         s8, sp, a2
                  ori          s1, a5, 1016
                  sltu         s5, s8, s6
                  lb           t2, -1872(tp)
                  lbu          s5, -476(tp)
                  lw           s10, -1581(tp)
                  divu         t0, s5, gp
                  slt          gp, a7, s0
                  lb           s10, 328(tp)
                  mulhsu       s10, t6, t6
                  slli         s1, s7, 3
                  csrrsi       s0, 0x300, 0
                  srl          t5, s0, zero
                  lhu          a2, -1789(tp)
                  sltiu        a2, s4, 1751
                  xori         t3, s6, 85
                  xori         a2, a6, -1304
                  add          t2, s4, a5
                  auipc        a2, 551410
                  lw           t5, 299(tp)
                  auipc        a6, 789369
                  sra          s11, s1, s0
                  sltu         s3, s5, a1
                  csrrw        s5, 0x344, a4
                  lbu          a1, 359(tp)
                  sltiu        s5, a1, -869
                  lhu          s8, -509(tp)
                  lbu          s0, -1559(tp) #end riscv_load_store_rand_instr_stream_9
                  la           a0, region_0+1127 #start riscv_hazard_instr_stream_15
                  lb           s0, 128(a0)
                  csrrs        s10, 0x343, s10
                  lbu          a2, 34(a0)
                  mulhsu       s8, a6, s0
                  slli         s10, s9, 27
                  lb           s8, 0(a0)
                  lbu          s0, 158(a0)
                  rem          a2, s10, s9
                  rem          a6, s8, s0
                  sh           a6, 35(a0)
                  sub          a6, s8, s9
                  slti         s9, s0, 330
                  sra          a2, s0, s8
                  sb           s8, -21(a0)
                  lbu          s8, -216(a0)
                  csrrsi       s10, 0x305, 0
                  sub          a2, a6, s10
                  lh           s8, 183(a0)
                  srai         s10, s8, 6
                  and          s8, a2, a6
                  or           s9, s0, s10
                  lhu          a2, 27(a0)
                  slli         s8, s9, 9
                  auipc        s10, 383290
                  or           s0, a2, s8
                  sb           s10, 240(a0)
                  sltiu        s9, s10, 495
                  mul          a6, s8, a6
                  csrrc        s0, 0x343, a2
                  sb           a6, 191(a0)
                  and          s9, s0, s9
                  divu         s8, a2, a6
                  lh           s8, 147(a0)
                  csrrci       a2, 0x342, 0
                  srl          s9, s10, s10
                  sb           a2, 252(a0) #end riscv_hazard_instr_stream_15
                  la           s5, region_1+8778 #start riscv_load_store_hazard_instr_stream_31
                  lb           t6, 219(s5)
                  lbu          t1, 219(s5)
                  lb           a2, 219(s5)
                  lb           a1, 219(s5)
                  lbu          tp, 219(s5)
                  sb           s9, 219(s5)
                  sb           t5, 219(s5)
                  csrrs        ra, 0x301, zero
                  lbu          s1, 219(s5)
                  sb           a6, 219(s5)
                  lbu          t4, 219(s5)
                  csrrc        s1, 0x344, s11
                  lb           t5, 219(s5)
                  sb           s5, 219(s5)
                  lb           zero, 219(s5)
                  sb           a6, 219(s5)
                  lb           s10, 219(s5)
                  lb           t1, 219(s5)
                  lb           a1, 219(s5)
                  lbu          s1, 219(s5)
                  sb           a5, 219(s5)
                  lb           t4, 219(s5) #end riscv_load_store_hazard_instr_stream_31
                  la           s3, region_0+579 #start load_store_instr_stream_2
                  lh           a6, 15(s3)
                  lw           zero, -15(s3)
                  la           s9, region_0+2682 #start load_store_instr_stream_1
                  lb           t1, 773(s9)
                  sb           a3, -693(s9)
                  la           s1, region_0+1564 #start load_store_instr_stream_0
                  sb           a1, -831(s9)
                  lbu          s4, 9(s3)
                  la           a7, region_0+1656 #start load_store_instr_stream_3
                  lb           t6, 284(s9)
                  lb           s2, 8(s1)
                  sb           s1, -1393(s9)
                  lb           zero, -1354(a7)
                  lbu          t2, 6(s3)
                  lbu          a5, -1011(a7)
                  lhu          s11, 1(s3)
                  lh           ra, 276(a7)
                  sb           s11, -3(s1)
                  lbu          a1, 259(a7)
                  lhu          s6, 11(s3)
                  lbu          a1, -4(s1)
                  sb           t4, 16(s3)
                  lw           ra, 492(a7)
                  sb           t0, -15(s1)
                  lw           a4, -1330(s9)
                  sb           t3, 1(s1)
                  sb           s1, 751(a7)
                  lb           a1, 11(s3) #end load_store_instr_stream_2
                  sh           t3, -4(s1)
                  lbu          s0, -241(a7)
                  lhu          a0, -1388(s9)
                  lb           a1, -303(s9) #end load_store_instr_stream_1
                  lh           zero, 830(a7) #end load_store_instr_stream_3
                  sb           a5, -11(s1)
                  lb           s2, 2(s1) #end load_store_instr_stream_0
                  addi         t6, zero, 2 #init loop 1 counter
                  mul          a4, s0, s2
                  and          s6, zero, gp
                  sll          gp, s3, s3
                  mulh         t0, s8, s10
                  mulh         ra, s10, s6
                  addi         s4, zero, -15 #init loop 1 limit
                  mulhsu       a5, s2, s10
                  slti         s6, s3, 21
main_207_1_t:     or           gp, s8, s1
                  srli         a1, a7, 22
                  or           gp, t1, s11
                  ori          s9, a7, 1958
                  mulh         s1, s9, t2
                  slli         t0, s9, 17
                  addi         t6, t6, -10 #update loop 1 counter
                  xori         gp, a1, -263
                  addi         s0, zero, 7 #init loop 0 counter
                  sll          a0, s8, s10
                  and          t0, s11, gp
                  auipc        a6, 415406
                  addi         s11, zero, 7 #init loop 0 limit
main_207_0_t:     nop
                  csrrc        s2, 0x300, zero
                  csrrc        t4, 0x304, s6
                  addi         s0, s0, -4 #update loop 0 counter
                  csrrci       gp, 0x301, 0
                  bgeu         s0, s11, main_207_0_t #branch for loop 0
                  nop
                  bge          t6, s4, main_207_1_t #branch for loop 1
                  srai         gp, tp, 21
                  li           s9, 0x9f23ec61 #start riscv_int_numeric_corner_stream_7
                  li           a2, 0x80000000
                  li           s6, 0x80000000
                  li           a5, 0x80000000
                  li           a0, 0x80000000
                  li           s3, 0xe440fd2a
                  li           a4, 0x80000000
                  li           s0, 0x0
                  li           t4, 0xffffffff
                  li           s4, 0x0
                  divu         a2, a2, a0
                  mulh         s3, s3, a5
                  auipc        a0, 570565
                  mulh         a5, a4, s0
                  mulhu        a5, a2, a5
                  div          a4, a5, s0
                  divu         s0, s6, s3
                  mulhu        t4, t4, a2
                  auipc        s9, 96798
                  mulhsu       s6, s4, s4
                  nop
                  mulhu        a0, a0, s4
                  nop
                  mulh         s3, a4, a0
                  remu         a0, s6, a4
                  lui          a2, 700497
                  lui          a4, 227690
                  nop
                  div          a4, a4, s6
                  rem          s6, a0, a5
                  mul          a2, s9, s6 #end riscv_int_numeric_corner_stream_7
                  addi         a5, zero, 10 #init loop 1 counter
                  csrrsi       ra, 0x304, 0
                  sub          t1, s8, zero
                  sltiu        zero, t1, -1772
                  csrrwi       s5, 0x304, 21
                  addi         s11, zero, -2 #init loop 1 limit
main_213_1_t:     ori          t6, gp, 1820
                  sltiu        a4, t1, -690
                  or           tp, t5, a5
                  slti         a4, a7, -1666
                  addi         a5, a5, -4 #update loop 1 counter
                  rem          s8, a3, a4
                  addi         s4, zero, -5 #init loop 0 counter
                  addi         gp, zero, 10 #init loop 0 limit
                  remu         s6, s4, s8
                  rem          t2, s3, s4
                  rem          s1, sp, a0
                  or           t1, a0, s9
                  ori          s10, t5, -1924
main_213_0_t:     mul          a4, s1, s9
                  addi         s4, s4, 2 #update loop 0 counter
                  bltu         s4, gp, main_213_0_t #branch for loop 0
                  csrrw        ra, 0x304, t2
                  bne          a5, s11, main_213_1_t #branch for loop 1
                  csrrc        s8, 0x305, zero
main_107:         jal          t4, 21f
0:                jal          tp, 17f
1:                jal          ra, 19f
2:                jal          ra, 24f
3:                jal          ra, 9f
4:                jal          ra, 20f
5:                jal          s3, 13f
6:                jal          ra, 2b
7:                jal          a5, 4b
8:                jal          t1, 28f
9:                jal          t1, 11f
10:               jal          ra, 8b
11:               jal          t1, 23f
12:               jal          ra, 25f
13:               jal          ra, 22f
14:               jal          ra, 1b
15:               jal          t1, 12b
16:               jal          t1, 10b
17:               jal          t1, 27f
18:               jal          t1, 3b
19:               jal          ra, 6b
20:               jal          t0, 29f
21:               jal          s2, 15b
22:               jal          ra, 14b
23:               jal          t1, 5b
24:               jal          t1, 7b
25:               jal          ra, 16b
26:               jal          ra, 18b
27:               jal          ra, 26b
28:               jal          ra, 0b
29:               csrrc        a6, 0x343, zero
main_108:         jal          t4, 4f
0:                jal          t1, 3f
1:                jal          ra, 9f
2:                jal          ra, 12f
3:                jal          ra, 8f
4:                jal          t1, 5f
5:                jal          ra, 10f
6:                jal          ra, 11f
7:                jal          ra, 1b
8:                jal          ra, 2b
9:                jal          a7, 0b
10:               jal          ra, 6b
11:               jal          t0, 7b
12:               csrrci       s1, 0x304, 0
                  la           s10, region_1+15752 #start load_store_instr_stream_2
                  la           s9, region_1+30396 #start load_store_instr_stream_0
                  sw           a5, -56(s10)
                  la           t1, region_1+62759 #start load_store_instr_stream_3
                  lh           s11, -15(t1)
                  lhu          t5, 3(t1)
                  la           a4, region_1+35538 #start load_store_instr_stream_1
                  lw           t0, 56(s10)
                  lb           a1, 170(a4)
                  lbu          a0, 59(s10)
                  sb           t6, -203(s9)
                  sw           zero, 32(s9)
                  lb           t4, -10(t1)
                  lb           s5, 27(a4)
                  lbu          t5, -67(a4)
                  lb           a5, 201(s9)
                  lb           s11, -35(s10)
                  sb           s11, 49(a4)
                  sh           t4, -100(s9)
                  lbu          t5, 6(t1)
                  lb           s5, -10(s10)
                  lhu          t6, -22(s9)
                  lw           s5, -60(s10)
                  lbu          a6, 16(s9)
                  lbu          s5, 37(s10)
                  lbu          a1, -116(a4)
                  lb           s11, -81(a4) #end load_store_instr_stream_1
                  lbu          s11, 93(s9)
                  lh           a0, 40(s10) #end load_store_instr_stream_2
                  sb           a5, 15(s9)
                  lb           a2, 231(s9)
                  sb           s11, -6(t1) #end load_store_instr_stream_3
                  sb           sp, 199(s9) #end load_store_instr_stream_0
                  la           ra, region_0+2160 #start load_store_instr_stream_0
                  la           s1, region_1+55454 #start load_store_instr_stream_1
                  lbu          tp, -719(ra)
                  sb           s9, -1801(s1)
                  sb           a1, -1973(ra)
                  sw           s4, 838(s1)
                  lb           t5, -343(ra)
                  lb           t5, -403(s1)
                  lbu          t1, 1807(ra)
                  lb           zero, -1299(s1)
                  sh           a2, -1280(s1)
                  lb           s2, 1301(s1) #end load_store_instr_stream_1
                  lb           s2, -217(ra) #end load_store_instr_stream_0
                  addi         s8, zero, 10 #init loop 1 counter
                  sll          a5, a3, a2
                  mulh         s6, s0, zero
                  sltu         s1, t0, a7
                  ori          s0, tp, 589
                  csrrsi       s1, 0x344, 0
                  addi         s3, s5, -546
                  addi         a6, zero, 10 #init loop 1 limit
main_216_1_t:     mulhu        a7, t5, a3
                  csrrwi       t3, 0x342, 28
                  addi         s8, s8, -9 #update loop 1 counter
                  auipc        tp, 333972
                  addi         t6, zero, 9 #init loop 0 counter
                  sltu         zero, a3, s5
                  divu         s4, a5, a0
                  slti         s0, s0, -711
                  addi         t4, zero, 9 #init loop 0 limit
                  csrrc        t5, 0x304, zero
                  slli         s11, ra, 2
                  addi         t2, s2, 1072
main_216_0_t:     sub          tp, a5, s6
                  csrrsi       s5, 0x342, 0
                  addi         t6, t6, -8 #update loop 0 counter
                  ori          t2, zero, -1453
                  slti         tp, a6, 518
                  sltu         gp, s10, tp
                  csrrw        gp, 0x344, s2
                  slti         s3, a1, -256
                  slti         s9, s1, -1301
                  nop
                  bgeu         t6, t4, main_216_0_t #branch for loop 0
                  csrrwi       s6, 0x343, 22
                  bgeu         s8, a6, main_216_1_t #branch for loop 1
                  auipc        s10, 301263
                  addi         s3, zero, 0 #init loop 1 counter
                  addi         tp, zero, -17 #init loop 1 limit
                  slti         t6, tp, 609
                  mulhsu       s11, t5, s10
                  mulhu        s10, s0, s3
                  srl          a0, s0, sp
main_225_1_t:     rem          a7, a4, sp
                  mulhu        zero, gp, t1
                  addi         s3, s3, -1 #update loop 1 counter
                  addi         s6, zero, 8 #init loop 0 counter
                  mulhsu       a6, s1, a3
                  addi         t4, zero, 9 #init loop 0 limit
                  and          t6, s0, t0
                  addi         a6, gp, -648
                  sub          a0, s1, sp
main_225_0_t:     sub          a1, t6, a6
                  slli         s8, gp, 27
                  csrrw        s10, 0x304, a1
                  addi         s6, s6, 1 #update loop 0 counter
                  bltu         s6, t4, main_225_0_t #branch for loop 0
                  divu         a1, s8, s5
                  sub          s11, s3, a3
                  csrrw        s10, 0x343, zero
                  or           s1, s10, s5
                  sltu         s5, s8, s10
                  lui          a7, 875924
                  sltu         s5, s11, s0
                  remu         s2, s2, s2
                  bge          s3, tp, main_225_1_t #branch for loop 1
                  csrrw        ra, 0x301, a6
main_89:          jal          t4, 6f
0:                jal          ra, 19f
1:                jal          s3, 4f
2:                jal          ra, 18f
3:                jal          t1, 9f
4:                jal          t1, 2b
5:                jal          ra, 16f
6:                jal          ra, 13f
7:                jal          ra, 20f
8:                jal          s5, 5b
9:                jal          ra, 15f
10:               jal          ra, 24f
11:               jal          ra, 14f
12:               jal          ra, 7b
13:               jal          ra, 10b
14:               jal          s2, 3b
15:               jal          t1, 22f
16:               jal          t1, 11b
17:               jal          ra, 12b
18:               jal          ra, 21f
19:               jal          t2, 25f
20:               jal          ra, 23f
21:               jal          ra, 26f
22:               jal          ra, 27f
23:               jal          s4, 1b
24:               jal          s9, 17b
25:               jal          t1, 8b
26:               jal          ra, 0b
27:               csrrci       a5, 0x342, 0
                  addi         t0, zero, 8 #init loop 1 counter
                  divu         s10, s8, s2
                  xor          s2, s6, sp
                  remu         s9, tp, sp
                  mulh         a5, a6, t6
                  addi         a2, zero, -1034
                  andi         t5, tp, 435
                  addi         a1, zero, 14 #init loop 1 limit
                  remu         s9, a6, t5
                  csrrs        t2, 0x342, zero
main_200_1_t:     addi         s1, a3, 814
                  srl          zero, s3, s6
                  addi         tp, a3, 1619
                  nop
                  srli         s8, s10, 25
                  addi         t0, t0, 6 #update loop 1 counter
                  addi         s6, zero, -2 #init loop 0 counter
                  sub          s10, sp, s0
                  slt          ra, a1, s6
                  sra          a0, a0, a3
                  nop
                  div          s5, a1, a7
                  addi         t6, zero, 14 #init loop 0 limit
main_200_0_t:     add          s2, gp, a7
                  divu         a7, s2, a4
                  addi         s6, s6, 7 #update loop 0 counter
                  slli         s3, a3, 31
                  rem          t5, s10, sp
                  mulhu        a4, t4, s10
                  srl          a6, t0, s7
                  slti         a5, s9, -1341
                  blt          s6, t6, main_200_0_t #branch for loop 0
                  bne          t0, a1, main_200_1_t #branch for loop 1
                  mulhu        s3, s11, a6
main_109:         jal          t4, 6f
0:                jal          a6, 15f
1:                jal          ra, 3f
2:                jal          ra, 1b
3:                jal          ra, 12f
4:                jal          ra, 8f
5:                jal          t1, 0b
6:                jal          ra, 7f
7:                jal          ra, 19f
8:                jal          t1, 20f
9:                jal          ra, 17f
10:               jal          ra, 2b
11:               jal          t1, 9b
12:               jal          t1, 16f
13:               jal          ra, 18f
14:               jal          ra, 11b
15:               jal          ra, 10b
16:               jal          s4, 4b
17:               jal          a1, 13b
18:               jal          ra, 5b
19:               jal          t1, 14b
20:               rem          gp, a3, a6
                  la           s9, region_0+423 #start load_store_instr_stream_0
                  sb           a0, -31(s9)
                  la           t4, region_1+50221 #start load_store_instr_stream_1
                  lh           a1, 89(s9)
                  lb           t3, 202(t4)
                  lb           a2, -212(s9)
                  lb           s3, 50(s9)
                  lh           a7, -173(s9)
                  lbu          t2, -90(t4)
                  lb           s5, -254(s9)
                  lb           a7, -77(s9)
                  sb           t5, 26(t4)
                  lb           a6, 121(s9)
                  sw           a7, 231(t4)
                  lb           a6, 48(t4)
                  sb           s11, 135(s9)
                  lbu          a7, 98(t4) #end load_store_instr_stream_1
                  lh           a0, -175(s9) #end load_store_instr_stream_0
                  addi         t6, zero, -8 #init loop 1 counter
                  mulh         s0, a1, t0
                  remu         a5, s0, s8
                  addi         t0, zero, 6 #init loop 1 limit
                  srli         a1, t3, 1
main_220_1_t:     add          s1, s6, s3
                  srai         gp, a4, 14
                  addi         t6, t6, 7 #update loop 1 counter
                  addi         s10, zero, 5 #init loop 0 counter
                  rem          t2, s5, t0
                  mulhu        t4, t0, ra
                  sub          t1, s0, ra
                  addi         s2, zero, 17 #init loop 0 limit
main_220_0_t:     auipc        gp, 721059
                  csrrw        t1, 0x344, s7
                  addi         s10, s10, 10 #update loop 0 counter
                  slti         a1, t0, 1101
                  mulh         s3, s5, zero
                  blt          s10, s2, main_220_0_t #branch for loop 0
                  bne          t6, t0, main_220_1_t #branch for loop 1
                  ori          s11, a2, -694
                  la           s4, region_1+29523 #start riscv_load_store_hazard_instr_stream_4
                  lh           s1, 53(s4)
                  sltiu        t2, t0, 582
                  sb           s1, 24(s4)
                  lh           a2, -57(s4)
                  lh           t1, -57(s4)
                  lb           tp, 38(s4)
                  lbu          s9, 0(s4)
                  sb           s10, 0(s4)
                  sb           a3, -42(s4)
                  sb           a5, 23(s4)
                  lh           t5, 23(s4)
                  sb           s1, -33(s4)
                  lbu          t0, -10(s4)
                  sb           s1, -10(s4)
                  lbu          t3, -10(s4)
                  lb           s3, -10(s4)
                  lb           t6, -10(s4)
                  lhu          t6, 43(s4)
                  lb           t2, 0(s4)
                  lb           s1, 0(s4) #end riscv_load_store_hazard_instr_stream_4
                  la           s5, region_1+6200 #start riscv_load_store_rand_instr_stream_15
                  sh           s6, 6(s5)
                  sb           s11, 12(s5)
                  lbu          tp, 5(s5)
                  mulhsu       t6, s2, s11
                  lhu          zero, 12(s5)
                  sub          t4, s11, t0
                  sb           s9, -9(s5)
                  lbu          t4, 5(s5)
                  sw           a5, -4(s5)
                  sh           s2, -12(s5)
                  sb           a7, 5(s5)
                  csrrwi       a6, 0x304, 9
                  lb           t4, 1(s5)
                  csrrwi       a5, 0x301, 28
                  sb           s4, -3(s5)
                  sb           t1, -5(s5)
                  lb           zero, -9(s5)
                  lh           s8, -14(s5)
                  or           s3, a4, s4
                  slt          t1, sp, a7
                  lb           t4, -2(s5)
                  lbu          s9, -3(s5)
                  lb           a0, 10(s5)
                  srl          s8, a7, s4
                  lbu          a0, 9(s5)
                  xori         t4, s9, 1158
                  sltiu        gp, sp, -224
                  lh           s3, 2(s5)
                  auipc        s1, 497297
                  and          ra, s10, gp
                  rem          s6, a3, t6
                  nop
                  lb           a1, -10(s5)
                  remu         a6, ra, s1
                  xori         s2, s8, -1252
                  lbu          s9, -7(s5)
                  lbu          s1, 15(s5)
                  lb           s9, 7(s5)
                  sb           ra, 9(s5)
                  sltu         s1, a3, a6
                  sltu         s11, s5, ra
                  lh           s0, -10(s5)
                  slt          a6, s1, t0
                  remu         s2, s5, a3
                  lhu          a7, -12(s5)
                  sb           s11, 1(s5) #end riscv_load_store_rand_instr_stream_15
                  la           ra, region_1+42697 #start riscv_load_store_rand_instr_stream_21
                  add          t3, t2, t6
                  slli         t1, t1, 2
                  csrrci       s3, 0x343, 29
                  divu         a4, s0, a1
                  csrrw        t6, 0x304, t0
                  lb           s5, 9(ra)
                  ori          gp, t3, 574
                  and          a6, s4, a2
                  and          a0, gp, s5
                  lb           s9, -15(ra)
                  lb           t4, 0(ra)
                  sub          t3, ra, s0
                  or           s4, t3, s0
                  lb           t2, -16(ra)
                  slli         s0, a2, 3
                  nop
                  lb           a5, 0(ra)
                  lbu          s2, 10(ra)
                  sb           s0, 5(ra)
                  mul          s4, s4, s0
                  lbu          t6, -16(ra)
                  ori          t4, s0, 148
                  lb           a1, 3(ra)
                  lh           s9, 1(ra)
                  addi         a0, gp, 1736
                  lw           t6, -13(ra)
                  csrrsi       zero, 0x300, 0
                  sb           a5, 14(ra)
                  lb           a2, 12(ra) #end riscv_load_store_rand_instr_stream_21
                  la           s6, region_1+59668 #start riscv_load_store_hazard_instr_stream_20
                  sltiu        zero, a7, 48
                  lbu          s5, 6(s6)
                  lbu          a0, 6(s6)
                  lb           s11, 6(s6)
                  lw           t4, 8(s6)
                  csrrwi       a4, 0x342, 1
                  addi         t6, a0, -1118
                  lhu          s1, 8(s6)
                  lhu          a1, 8(s6)
                  sb           a6, 1(s6)
                  sb           s11, 1(s6)
                  sb           t3, 1(s6)
                  sb           t6, 1(s6)
                  lbu          tp, 1(s6)
                  sltiu        a4, a1, -1965
                  slti         s4, t0, -1056
                  lbu          tp, 1(s6)
                  mul          s11, tp, t5
                  lb           gp, -10(s6)
                  auipc        gp, 424784
                  sh           s4, 0(s6)
                  lw           a6, 0(s6) #end riscv_load_store_hazard_instr_stream_20
                  la           s2, region_0+3934 #start riscv_hazard_instr_stream_8
                  lb           a0, -93(s2)
                  lbu          a0, -83(s2)
                  lb           a5, -254(s2)
                  lhu          a5, 120(s2)
                  lb           a7, -161(s2)
                  mulh         a4, a6, a0
                  nop
                  xor          a4, a4, a7
                  addi         a4, s6, -384
                  slti         a7, a5, 1006
                  sb           a0, -256(s2)
                  sh           s6, 70(s2)
                  ori          a7, a6, 1003
                  lbu          a6, -151(s2)
                  lh           a0, 144(s2)
                  lb           a6, -57(s2)
                  lbu          s6, 143(s2)
                  ori          a6, a4, 1436
                  lbu          a6, -141(s2)
                  mulhu        a4, s6, s6
                  sb           a6, -98(s2)
                  lb           a5, 112(s2)
                  sra          a5, a0, a5
                  lb           a7, -100(s2)
                  sltiu        a4, a6, -1236
                  csrrw        a5, 0x301, a4
                  lb           a7, -232(s2)
                  auipc        a0, 316046
                  sb           a0, 145(s2)
                  lbu          a4, -155(s2)
                  lb           a5, -186(s2)
                  xor          a5, s6, a0
                  lb           a0, -39(s2)
                  sb           a7, 153(s2)
                  rem          s6, a7, a4
                  xor          a6, a7, a6
                  lbu          a6, -9(s2)
                  addi         a4, a7, 1509
                  lbu          a4, -151(s2)
                  sw           a4, 126(s2) #end riscv_hazard_instr_stream_8
main_99:          jal          t4, 0f
0:                jal          t0, 8f
1:                jal          t1, 13f
2:                jal          ra, 5f
3:                jal          s8, 6f
4:                jal          ra, 9f
5:                jal          ra, 14f
6:                jal          ra, 10f
7:                jal          ra, 4b
8:                jal          ra, 7b
9:                jal          t4, 1b
10:               jal          t5, 11f
11:               jal          gp, 2b
12:               jal          ra, 3b
13:               jal          ra, 12b
14:               divu         tp, t6, s6
                  la           s5, region_0+1478 #start riscv_load_store_hazard_instr_stream_2
                  lhu          a0, 112(s5)
                  lhu          ra, 112(s5)
                  lhu          s11, 112(s5)
                  ori          a7, s3, -284
                  sb           s4, 140(s5)
                  lb           t3, 140(s5)
                  lb           t0, -9(s5)
                  lbu          s0, -9(s5)
                  lb           a7, 33(s5)
                  lb           a5, 83(s5)
                  lbu          t4, -160(s5)
                  sb           t0, -160(s5)
                  lbu          zero, 80(s5)
                  lh           s0, 80(s5) #end riscv_load_store_hazard_instr_stream_2
                  la           s2, region_0+345 #start load_store_instr_stream_1
                  sb           s8, 51(s2)
                  lh           s0, 1(s2)
                  la           a7, region_1+53702 #start load_store_instr_stream_0
                  sh           t3, -18(a7)
                  lbu          zero, 46(s2)
                  lw           t5, 51(s2)
                  lb           s0, 36(a7)
                  lhu          a2, -3(s2)
                  lb           ra, 43(a7)
                  lbu          t4, -40(a7)
                  sb           a0, -54(s2)
                  sb           a0, 38(s2)
                  sb           t3, -50(s2)
                  lbu          zero, -4(s2)
                  lbu          t1, -3(s2) #end load_store_instr_stream_1
                  lw           s10, 26(a7)
                  lbu          t3, 59(a7) #end load_store_instr_stream_0
main_80:          jal          t4, 4f
0:                jal          ra, 2f
1:                jal          ra, 3f
2:                jal          s9, 6f
3:                jal          t1, 8f
4:                jal          t1, 0b
5:                jal          tp, 9f
6:                jal          ra, 1b
7:                jal          ra, 10f
8:                jal          ra, 5b
9:                jal          t5, 7b
10:               mulhu        t1, a1, a1
                  la           s3, region_0+1739 #start load_store_instr_stream_0
                  la           s2, region_0+2427 #start load_store_instr_stream_1
                  sb           a0, -42(s2)
                  lbu          ra, 71(s3)
                  sb           t3, 40(s2)
                  sh           a4, -195(s3)
                  sb           a6, 135(s3)
                  lbu          s1, 68(s2)
                  lh           a2, -217(s3)
                  sb           sp, -26(s3)
                  sb           s4, 255(s2)
                  lbu          s8, 13(s3)
                  sb           a2, 62(s2)
                  sb           a6, -226(s3)
                  lbu          a5, 210(s2)
                  lhu          a6, 159(s2)
                  lbu          a4, 100(s2)
                  lh           s6, -237(s2) #end load_store_instr_stream_1
                  lw           a2, -251(s3)
                  lh           s6, 149(s3) #end load_store_instr_stream_0
                  addi         gp, zero, 1 #init loop 0 counter
                  slt          ra, s1, s11
                  addi         s0, zero, 15 #init loop 0 limit
                  srai         t5, t3, 16
                  srli         s5, t6, 22
                  divu         t6, s4, a4
                  rem          t6, t4, gp
                  rem          a5, sp, s5
                  slli         a4, s8, 14
                  ori          s6, t5, 301
                  divu         zero, s4, s1
                  csrrc        s11, 0x300, zero
                  divu         t1, s1, a5
                  mulhsu       zero, a5, s0
main_223_0_t:     sltu         s2, t5, s11
                  addi         gp, gp, 9 #update loop 0 counter
                  csrrc        a2, 0x342, zero
                  blt          gp, s0, main_223_0_t #branch for loop 0
                  or           t0, ra, t0
                  la           s6, region_1+61169 #start riscv_load_store_hazard_instr_stream_15
                  lh           s10, 13(s6)
                  sh           a4, -23(s6)
                  sub          s9, ra, s2
                  sb           t2, -23(s6)
                  or           a0, ra, t4
                  lbu          t5, 56(s6)
                  addi         s5, a6, -1645
                  lb           t0, 56(s6)
                  lb           a0, 56(s6)
                  lbu          s10, 56(s6)
                  lbu          s0, 56(s6)
                  lb           ra, 56(s6)
                  sh           t1, 47(s6) #end riscv_load_store_hazard_instr_stream_15
                  li           gp, 0x0 #start riscv_int_numeric_corner_stream_28
                  li           a2, 0xc882f987
                  li           t6, 0x80000000
                  li           a7, 0x0
                  li           s2, 0x80000000
                  li           s1, 0x95c0e8ae
                  li           s6, 0xebeac3f6
                  li           t5, 0x80000000
                  li           t2, 0xffffffff
                  li           t1, 0x80000000
                  mulh         t6, t5, t2
                  remu         t1, a7, t1
                  add          s2, a7, t6
                  remu         t5, a2, t1
                  divu         t1, t1, t6
                  auipc        s6, 675585
                  mul          t1, s2, s2
                  mulhu        a2, s6, s1
                  divu         gp, t6, a2
                  rem          gp, s2, a2
                  mulhu        t1, a7, s2
                  mulh         s6, s2, s2
                  mulhu        a2, a7, t5
                  auipc        a7, 824545
                  mulh         t2, t1, t1
                  add          s1, s2, s6
                  divu         s1, t6, a7
                  div          t5, s1, a2 #end riscv_int_numeric_corner_stream_28
                  la           a4, region_1+8036 #start riscv_load_store_rand_instr_stream_20
                  rem          s4, t4, s4
                  mulhsu       ra, gp, t5
                  lhu          t0, -242(a4)
                  div          s1, s10, a5
                  mul          gp, a6, s0
                  lh           t6, -228(a4)
                  lb           t2, 56(a4)
                  sll          a7, s0, s11
                  lbu          t2, -181(a4)
                  sh           s10, -132(a4)
                  sw           s4, 248(a4)
                  csrrs        a0, 0x301, t6
                  srl          s10, t2, sp
                  lui          ra, 566831
                  lbu          s11, -235(a4)
                  lhu          s3, 90(a4)
                  lbu          t4, 74(a4)
                  divu         s3, s6, s4
                  sh           s3, 26(a4)
                  sb           s10, -209(a4)
                  div          tp, t5, t0
                  csrrc        s9, 0x304, tp
                  lhu          s4, -206(a4)
                  lbu          t6, 85(a4)
                  xor          s10, a6, s8
                  sb           t3, -32(a4)
                  sb           t1, -33(a4)
                  srai         s6, zero, 15
                  sb           s9, -229(a4)
                  lw           t3, -192(a4)
                  mulhu        t0, a4, a2
                  lb           s5, -221(a4)
                  lbu          a1, 153(a4)
                  xori         t3, s9, -1454
                  lhu          a7, 238(a4)
                  div          s9, a1, a5
                  csrrwi       ra, 0x344, 22
                  lbu          a1, 62(a4)
                  sltu         t3, t6, t5
                  mulhu        a0, t1, a0
                  slli         a7, s2, 21
                  sb           a4, 161(a4) #end riscv_load_store_rand_instr_stream_20
                  la           s9, region_1+24054 #start load_store_instr_stream_0
                  la           s4, region_1+13155 #start load_store_instr_stream_2
                  sb           zero, -692(s4)
                  la           s5, region_1+5023 #start load_store_instr_stream_1
                  lbu          gp, -1236(s4)
                  lhu          a1, -183(s5)
                  lhu          t5, 1345(s4)
                  lbu          a2, -10(s9)
                  sb           a2, -1126(s4)
                  lb           s11, -458(s4)
                  sb           a2, -30(s5)
                  lbu          a7, 192(s4)
                  sw           ra, 537(s4)
                  lbu          s6, -175(s5)
                  lh           s2, -2(s9)
                  lb           s8, -458(s4)
                  sh           s11, -89(s5)
                  sb           s8, -1750(s4)
                  sh           s0, -161(s5) #end load_store_instr_stream_1
                  lbu          s3, 7(s9)
                  sb           gp, 1301(s4) #end load_store_instr_stream_2
                  sb           t0, 13(s9)
                  lhu          s1, 10(s9) #end load_store_instr_stream_0
                  la           s3, region_1+8909 #start load_store_instr_stream_0
                  la           t4, region_0+2677 #start load_store_instr_stream_1
                  sb           s6, 15(s3)
                  lhu          ra, -1689(t4)
                  sh           a0, -7(s3)
                  lb           a0, -6(s3)
                  sh           s8, 15(s3)
                  sb           a1, 7(s3)
                  lbu          s5, 689(t4)
                  lbu          a1, 413(t4)
                  lb           s2, -10(s3)
                  sh           ra, -59(t4)
                  lb           a2, 716(t4)
                  lbu          t6, 1028(t4)
                  lb           a7, -1606(t4)
                  lbu          a2, 15(s3)
                  sh           t2, 1283(t4)
                  lb           s1, -2(s3)
                  lbu          s11, -1126(t4) #end load_store_instr_stream_1
                  sb           a0, 10(s3) #end load_store_instr_stream_0
                  la           a1, region_0+3560 #start riscv_load_store_rand_instr_stream_0
                  sw           s1, 116(a1)
                  sb           s3, 229(a1)
                  rem          a5, s5, a6
                  mulhsu       t3, s6, s2
                  csrrc        t3, 0x300, zero
                  sb           tp, 157(a1)
                  lb           s1, -231(a1)
                  sb           t0, -131(a1)
                  slt          t6, ra, a6
                  mulh         t2, s6, s5
                  lbu          t2, 189(a1)
                  csrrc        t0, 0x343, zero
                  csrrc        t2, 0x300, zero
                  sh           s6, 240(a1)
                  lb           t4, -213(a1)
                  xori         a4, t4, -439
                  sll          t1, t1, a6
                  lui          s0, 918385
                  nop
                  nop
                  sb           s4, -198(a1)
                  sb           s10, -15(a1)
                  lb           s0, 234(a1)
                  auipc        a6, 553085
                  slti         t0, s7, -481
                  csrrw        s3, 0x342, s11
                  sra          zero, t5, t0
                  sb           s8, 1(a1)
                  csrrsi       tp, 0x344, 0
                  mul          a5, t3, a2
                  mulh         t2, t0, s5
                  and          t0, s2, t2
                  sb           t2, -131(a1)
                  xori         t4, t3, -1150
                  sltiu        s6, a5, 1014
                  sb           t0, 102(a1)
                  ori          t5, a6, -310
                  slti         a6, t3, 1
                  lb           s5, 215(a1) #end riscv_load_store_rand_instr_stream_0
                  addi         s9, zero, 10 #init loop 1 counter
                  mulhu        s0, s6, s8
                  addi         a2, zero, 10 #init loop 1 limit
main_222_1_t:     rem          zero, s7, t2
                  slt          a4, s7, a1
                  mulhu        a4, zero, t0
                  addi         s9, s9, -7 #update loop 1 counter
                  or           s2, a5, s4
                  div          gp, s8, a6
                  addi         s4, zero, -5 #init loop 0 counter
                  mulhsu       t5, s0, tp
                  addi         t3, zero, -13 #init loop 0 limit
                  sll          a6, t5, s0
                  sll          gp, a2, s1
main_222_0_t:     sltiu        ra, zero, -1388
                  addi         s4, s4, -8 #update loop 0 counter
                  beq          s4, t3, main_222_0_t #branch for loop 0
                  addi         a1, ra, 1691
                  ori          s10, a0, -800
                  bgeu         s9, a2, main_222_1_t #branch for loop 1
                  auipc        zero, 584419
                  la           s2, region_0+1744 #start riscv_hazard_instr_stream_10
                  sh           t3, -186(s2)
                  lb           s4, -66(s2)
                  sb           s11, -76(s2)
                  lb           t3, 125(s2)
                  lh           a5, 186(s2)
                  or           t6, t6, t6
                  lbu          s11, -104(s2)
                  lbu          s11, -86(s2)
                  lb           s11, 201(s2)
                  csrrwi       t3, 0x301, 11
                  lb           s11, 43(s2)
                  lh           a5, 178(s2)
                  lb           t3, 69(s2)
                  lbu          t6, -83(s2)
                  sb           s1, 64(s2)
                  srai         t6, s1, 20
                  mulhu        s1, t3, s1
                  slt          a5, t6, s4
                  xor          s11, s4, a5
                  lbu          t3, -183(s2)
                  lbu          s4, -45(s2)
                  sb           s1, 145(s2)
                  lh           t3, -214(s2)
                  lb           t6, 248(s2)
                  lbu          t3, -38(s2)
                  lb           t6, -75(s2)
                  rem          t6, s11, a5
                  lbu          t3, 41(s2)
                  sb           t3, -229(s2)
                  sub          t6, s11, a5
                  csrrwi       s4, 0x344, 11
                  and          t3, t3, s1
                  lbu          a5, 37(s2)
                  sb           s11, 192(s2)
                  lb           s1, 186(s2)
                  lbu          s11, -197(s2)
                  nop
                  lb           a5, 243(s2)
                  xor          s4, t3, s4
                  add          s11, s1, s1
                  sh           s4, -114(s2)
                  divu         s11, a5, a5
                  lbu          s1, 248(s2)
                  lh           s1, 26(s2) #end riscv_hazard_instr_stream_10
                  la           s6, region_1+23020 #start riscv_load_store_hazard_instr_stream_23
                  sw           s11, 32(s6)
                  lb           s8, 33(s6)
                  sb           s7, 33(s6)
                  sb           t0, 33(s6)
                  csrrc        a6, 0x342, s6
                  sb           ra, 33(s6)
                  csrrwi       t4, 0x301, 23
                  sb           t4, 33(s6)
                  lbu          tp, 33(s6)
                  sb           a7, 33(s6)
                  lb           s2, 33(s6)
                  sb           t6, 33(s6)
                  lbu          t5, -32(s6) #end riscv_load_store_hazard_instr_stream_23
main_119:         jal          t4, 3f
0:                jal          ra, 2f
1:                jal          ra, 0b
2:                jal          t0, 10f
3:                jal          ra, 6f
4:                jal          t1, 1b
5:                jal          ra, 13f
6:                jal          ra, 7f
7:                jal          ra, 12f
8:                jal          t1, 4b
9:                jal          ra, 5b
10:               jal          t0, 9b
11:               jal          ra, 8b
12:               jal          ra, 11b
13:               or           s5, a5, a7
                  la           gp, region_1+21825 #start load_store_instr_stream_0
                  la           a1, region_0+3197 #start load_store_instr_stream_1
                  sw           s2, 7(gp)
                  lbu          t4, -12(a1)
                  lb           s4, 7(a1)
                  sb           s6, -50(gp)
                  lb           t4, -1(a1)
                  lb           a7, -4(gp)
                  sb           t6, -16(a1)
                  lbu          s3, 6(a1)
                  sb           a3, 1(gp)
                  sb           s4, 14(a1) #end load_store_instr_stream_1
                  sb           s3, -44(gp) #end load_store_instr_stream_0
                  la           a0, region_0+314 #start riscv_hazard_instr_stream_16
                  slti         s11, a2, -640
                  xori         s5, s11, -652
                  sb           s5, 15(a0)
                  srli         a2, a2, 27
                  csrrsi       s9, 0x304, 24
                  sub          t1, s9, s11
                  csrrwi       s11, 0x343, 30
                  div          s11, a2, a6
                  srai         a2, a6, 10
                  lw           s11, -14(a0)
                  slli         a2, s5, 20
                  lhu          a2, -6(a0)
                  add          s5, t1, s9
                  sw           t1, -10(a0)
                  lhu          a6, 16(a0)
                  auipc        t1, 689219
                  lw           s11, 14(a0)
                  lbu          t1, -9(a0)
                  sltiu        a6, s11, 592
                  or           t1, a2, a6
                  csrrsi       s5, 0x305, 0
                  csrrs        t1, 0x301, s5
                  rem          a2, s9, t1
                  sb           s5, 3(a0)
                  csrrwi       s5, 0x344, 21
                  auipc        s9, 933307
                  andi         s9, t1, 569
                  ori          a6, a6, -1828
                  xori         s11, s5, 804
                  or           s5, a6, s11
                  addi         a2, s11, 1953
                  sb           s5, -15(a0)
                  lbu          s9, 13(a0)
                  lb           s11, 7(a0)
                  sll          t1, s11, s9
                  mulh         s9, t1, t1
                  sltu         s9, a6, t1
                  nop
                  sh           a6, 6(a0) #end riscv_hazard_instr_stream_16
                  li           t3, 0x80000000 #start riscv_int_numeric_corner_stream_19
                  li           s3, 0xffffffff
                  li           a7, 0x80000000
                  li           t5, 0xffffffff
                  li           s4, 0x8be24e22
                  li           s9, 0x80000000
                  li           t6, 0xffffffff
                  li           t1, 0xd53f871e
                  li           a0, 0xffffffff
                  li           tp, 0x80000000
                  rem          s9, s9, t5
                  addi         a0, s3, -1642
                  sub          s9, t1, a0
                  div          t5, s4, tp
                  sub          s9, a0, s3
                  mulh         s3, tp, t6
                  rem          s9, s3, t1
                  lui          t6, 133602
                  addi         t1, s4, 901
                  add          a0, s9, a0
                  mulhu        s4, t6, t1
                  sub          t1, t1, t1
                  lui          t5, 985243
                  mulhsu       a7, a0, t6
                  mulhu        s9, s9, s9
                  mulhsu       tp, s3, s4 #end riscv_int_numeric_corner_stream_19
                  la           ra, region_1+62401 #start riscv_hazard_instr_stream_11
                  sra          s5, t4, s2
                  lb           t0, -883(ra)
                  sb           a5, 757(ra)
                  div          a1, s2, a1
                  sh           a1, -327(ra)
                  lhu          t0, -1643(ra)
                  lb           t4, 95(ra)
                  or           s5, s5, s5
                  lhu          t0, -1189(ra)
                  lb           s5, 1151(ra)
                  lbu          a1, 1840(ra)
                  or           t0, a1, t4
                  csrrci       a1, 0x300, 0
                  lbu          t4, 259(ra)
                  lb           t4, -472(ra)
                  lbu          t4, -328(ra)
                  sb           a1, -1671(ra)
                  mulh         a1, t4, s2
                  addi         s2, s2, -1717
                  lb           t4, -2043(ra)
                  sb           s5, -1382(ra)
                  lbu          t0, 536(ra)
                  remu         t0, t0, t4
                  lbu          a1, -1127(ra)
                  csrrc        s5, 0x344, s2
                  mulh         s2, t4, a5
                  sb           t4, 1753(ra) #end riscv_hazard_instr_stream_11
                  li           ra, 0x846d1bae #start riscv_int_numeric_corner_stream_14
                  li           t1, 0xffffffff
                  li           s10, 0x80000000
                  li           s4, 0x80000000
                  li           gp, 0xffffffff
                  li           a1, 0xffffffff
                  li           s8, 0x80000000
                  li           t5, 0x80000000
                  li           s2, 0x293b7647
                  li           s5, 0x80000000
                  lui          ra, 75090
                  add          s10, s5, a1
                  remu         s10, s2, s2
                  addi         a1, gp, -140
                  mulhsu       ra, s5, a1
                  mulh         s4, s4, gp
                  addi         s2, s10, -647
                  nop
                  sub          gp, t5, t1
                  divu         s8, s2, t5
                  addi         t5, s10, 899
                  lui          t1, 461600
                  mulhsu       s10, s8, ra
                  add          t5, s4, s8
                  mulh         s2, s4, s4
                  remu         s10, s10, s2
                  addi         t5, t1, 1434
                  mulh         s5, s4, s2
                  rem          s5, t1, s8
                  mulhsu       t5, a1, t5
                  mul          t1, ra, t1
                  addi         a1, s10, -442
                  mul          t1, s8, s10 #end riscv_int_numeric_corner_stream_14
                  li           s6, 0xe7f7ca95 #start riscv_int_numeric_corner_stream_27
                  li           a6, 0xffffffff
                  li           s11, 0x80000000
                  li           s5, 0xf110a38a
                  li           s1, 0x3121fdc2
                  li           s4, 0x0
                  li           t6, 0xffffffff
                  li           s0, 0x0
                  li           t1, 0xffffffff
                  li           s2, 0x0
                  nop
                  mulhu        s11, a6, s4
                  mulhsu       s6, s2, s4
                  addi         s6, s2, 1228
                  sub          a6, t1, t1
                  lui          s6, 603869
                  mulhu        s0, s5, s5
                  mulhsu       t6, a6, t6
                  lui          s6, 943629
                  remu         s11, s6, s0
                  mulhsu       t1, s11, s1
                  mulh         a6, s11, s11
                  sub          t6, t6, a6
                  sub          s6, s11, s0
                  mulhsu       t6, a6, t1
                  div          s0, s1, s1
                  addi         s11, s6, 1352
                  mulhsu       s6, t6, s4
                  mul          t1, s1, s4
                  mulhu        s0, t1, s1 #end riscv_int_numeric_corner_stream_27
                  la           a4, region_0+3468 #start riscv_load_store_rand_instr_stream_34
                  lhu          a2, 10(a4)
                  lbu          t5, 5(a4)
                  sra          t6, t0, s9
                  sltu         s6, a6, t1
                  lb           s0, -15(a4)
                  sub          a2, zero, a0
                  csrrsi       a2, 0x300, 0
                  lhu          s11, 6(a4)
                  xori         s2, a5, 351
                  lbu          t3, 7(a4)
                  sh           s9, 8(a4)
                  sh           a2, -10(a4)
                  sub          a5, s2, t5
                  nop
                  mul          zero, s8, gp
                  csrrwi       t6, 0x344, 30
                  lbu          t1, 13(a4)
                  slli         a5, a6, 5
                  lbu          a7, -7(a4)
                  csrrs        gp, 0x343, s9
                  divu         tp, gp, s5
                  sltu         a2, sp, sp
                  sb           a5, -6(a4) #end riscv_load_store_rand_instr_stream_34
                  la           s1, region_0+2463 #start load_store_instr_stream_1
                  la           s5, region_0+816 #start load_store_instr_stream_0
                  lh           s6, 679(s1)
                  lb           a2, 5(s5)
                  lb           t6, -650(s1)
                  lbu          a7, -2018(s1)
                  lb           t4, -5(s5)
                  lbu          t6, -1(s5)
                  sh           s0, 1519(s1)
                  sb           t3, -29(s5)
                  sb           s3, -62(s1)
                  sb           s4, 838(s1)
                  lbu          t4, -716(s1) #end load_store_instr_stream_1
                  lb           a6, 36(s5) #end load_store_instr_stream_0
                  la           s2, region_1+37819 #start riscv_load_store_rand_instr_stream_22
                  add          t6, gp, s0
                  ori          a2, a7, 1188
                  lhu          t0, -249(s2)
                  sltiu        s3, s5, -1239
                  csrrw        t4, 0x343, s6
                  lhu          a4, 143(s2)
                  srl          s0, s6, s9
                  lb           s5, -82(s2)
                  lb           t5, 188(s2)
                  sub          s0, a0, s11
                  lb           a0, -35(s2)
                  lhu          s3, 163(s2)
                  lhu          a0, 177(s2)
                  lh           t2, -167(s2)
                  auipc        s6, 776858
                  sltiu        s9, s4, 188
                  sub          gp, s9, s8
                  sltiu        s3, tp, 374
                  lhu          t5, -63(s2)
                  csrrci       a2, 0x342, 0
                  sub          a6, s8, s1
                  auipc        s0, 143514
                  lbu          s4, 222(s2)
                  sb           sp, -12(s2)
                  csrrsi       a6, 0x304, 0
                  sb           s3, -254(s2)
                  lb           tp, 18(s2)
                  mulhu        s10, s1, s3
                  nop
                  csrrc        t1, 0x344, zero
                  sltiu        a0, s3, -1253
                  lbu          a4, -190(s2)
                  sra          t5, s2, t6
                  addi         s10, t0, 789
                  csrrw        t6, 0x344, t0
                  sw           s11, 141(s2)
                  ori          s3, s3, -680
                  andi         ra, t3, -808
                  lb           s9, 34(s2)
                  lb           s0, -111(s2)
                  lb           a2, 112(s2)
                  lb           s3, 243(s2)
                  lhu          s6, -1(s2)
                  slli         t4, t2, 1
                  addi         gp, a2, -1488
                  lb           a6, -126(s2)
                  lh           a0, -195(s2)
                  remu         s9, a2, s2
                  lb           zero, 16(s2) #end riscv_load_store_rand_instr_stream_22
                  la           s6, region_0+2172 #start load_store_instr_stream_1
                  la           t5, region_0+1327 #start load_store_instr_stream_2
                  lb           a7, -46(t5)
                  la           s1, region_0+3393 #start load_store_instr_stream_3
                  sh           s1, 58(s6)
                  lb           a0, 60(s1)
                  sb           s9, 135(s6)
                  lb           s2, 62(t5)
                  lb           s0, 44(s1)
                  lh           t6, -236(s6)
                  sb           s2, -37(t5)
                  lh           s5, 11(t5)
                  lbu          gp, 17(s1)
                  la           s11, region_0+2065 #start load_store_instr_stream_0
                  lh           gp, -9(t5)
                  lh           s0, -150(s6)
                  sb           s4, -230(s6)
                  lbu          s3, -819(s11)
                  lbu          s2, 133(s6)
                  sb           t4, 44(s1)
                  lbu          a5, -1851(s11)
                  lbu          t1, -24(s1)
                  lbu          a4, 40(s1)
                  lb           s2, 99(s6)
                  lbu          a7, -1546(s11)
                  lb           a4, -38(s1)
                  sb           t3, -44(s6)
                  lb           t4, 30(s1)
                  sb           a6, 231(s6) #end load_store_instr_stream_1
                  sb           t0, 5(t5) #end load_store_instr_stream_2
                  sb           s9, 29(s1) #end load_store_instr_stream_3
                  lbu          a7, -1504(s11)
                  lhu          t6, 1253(s11)
                  lbu          a2, -1167(s11) #end load_store_instr_stream_0
                  li           s3, 0x80000000 #start riscv_int_numeric_corner_stream_11
                  li           s5, 0x0
                  li           t6, 0xffffffff
                  li           s4, 0x80000000
                  li           s0, 0xffffffff
                  li           t3, 0xfdf0a0b1
                  li           gp, 0x80000000
                  li           t0, 0x0
                  li           a2, 0x6a04481d
                  li           tp, 0x0
                  addi         s5, s0, 805
                  mulh         tp, s3, t3
                  rem          t0, s0, gp
                  add          a2, s3, t3
                  add          s5, t0, s5
                  mul          s3, t0, a2
                  remu         t0, s5, s4
                  auipc        s5, 520198
                  rem          s3, s3, gp
                  lui          s5, 763351
                  remu         s0, s5, tp
                  remu         tp, s0, s5
                  div          tp, tp, gp
                  mulhu        a2, a2, t0
                  auipc        gp, 149526
                  remu         gp, a2, s0
                  add          s5, t3, tp
                  mulhsu       gp, gp, s4
                  sub          gp, a2, t6
                  lui          s4, 925718
                  sub          t6, t3, s4
                  div          tp, a2, s3
                  div          s5, s4, tp
                  mulh         gp, t6, s5 #end riscv_int_numeric_corner_stream_11
                  la           s1, region_0+2484 #start riscv_load_store_hazard_instr_stream_32
                  rem          tp, s7, a4
                  lb           gp, -39(s1)
                  lhu          ra, 26(s1)
                  lhu          a7, 26(s1)
                  sb           a7, 26(s1)
                  sh           s4, 26(s1)
                  sb           s10, 26(s1)
                  lb           t6, 26(s1)
                  sll          s3, s10, t3
                  lui          zero, 459329
                  xor          a2, s7, ra
                  lh           tp, 26(s1)
                  lhu          t5, 26(s1)
                  lbu          s4, 26(s1)
                  lb           s6, 28(s1)
                  lh           ra, 28(s1)
                  sb           ra, 28(s1)
                  sw           t4, 28(s1)
                  lb           s6, 28(s1)
                  srli         s2, sp, 17
                  sb           a6, -46(s1)
                  lb           t5, -54(s1) #end riscv_load_store_hazard_instr_stream_32
                  la           a6, region_1+61748 #start riscv_load_store_rand_instr_stream_29
                  csrrw        s1, 0x304, tp
                  nop
                  sltu         s1, s3, a6
                  xori         t0, a6, 1981
                  xor          s1, ra, t4
                  mulhsu       a5, a0, a7
                  sb           s6, -40(a6)
                  lb           s11, -27(a6)
                  sll          s0, gp, s1
                  sh           s6, 48(a6)
                  lui          ra, 245148
                  mul          s3, gp, t0
                  sb           a5, -47(a6)
                  addi         s11, s7, -1769
                  sra          tp, s6, a2
                  sb           s9, 9(a6)
                  mulhu        s11, s5, a0
                  sb           s0, -19(a6)
                  xor          a7, s2, s2
                  mulhsu       t4, t0, s8
                  lb           s5, -1(a6)
                  remu         t2, a1, a6
                  xor          s4, t5, s5
                  auipc        t3, 10856
                  lb           s10, 27(a6)
                  xori         s11, t0, 859
                  lb           t0, -63(a6)
                  andi         t2, t4, 1106
                  divu         a2, s4, s3
                  sll          zero, t1, s10
                  sub          t4, s9, s7
                  rem          tp, a5, a6
                  add          t2, a7, s3
                  lui          a2, 857813
                  andi         a1, tp, -66
                  sltu         t5, s2, t2
                  lb           s2, -5(a6)
                  nop
                  add          t3, t0, t5
                  lb           t5, 13(a6) #end riscv_load_store_rand_instr_stream_29
                  addi         s1, zero, -2 #init loop 1 counter
                  addi         a0, zero, -6 #init loop 1 limit
                  sra          ra, a3, a3
main_237_1_t:     div          s4, gp, t5
                  addi         s1, s1, -1 #update loop 1 counter
                  sll          t4, t3, s0
                  addi         a7, zero, -10 #init loop 0 counter
                  addi         s5, zero, -19 #init loop 0 limit
                  csrrci       s6, 0x343, 5
main_237_0_t:     ori          a1, a6, 199
                  addi         a7, a7, -3 #update loop 0 counter
                  bge          a7, s5, main_237_0_t #branch for loop 0
                  slt          a1, tp, t6
                  bge          s1, a0, main_237_1_t #branch for loop 1
                  xori         t6, t2, -1948
                  la           t1, region_0+839 #start load_store_instr_stream_0
                  la           s6, region_1+32670 #start load_store_instr_stream_1
                  sw           t4, 494(s6)
                  sb           a6, 39(t1)
                  lbu          t3, 1669(s6)
                  lb           a0, -28(t1)
                  lbu          a0, 801(s6)
                  lb           a4, 41(t1)
                  sb           s1, -48(t1)
                  lb           s10, -1326(s6)
                  sb           a3, 16(t1)
                  lb           a6, -1099(s6)
                  sb           s3, -1425(s6)
                  lb           a6, 739(s6) #end load_store_instr_stream_1
                  sb           ra, 44(t1)
                  lbu          s3, -36(t1) #end load_store_instr_stream_0
                  la           a7, region_1+6131 #start load_store_instr_stream_1
                  la           a1, region_0+2009 #start load_store_instr_stream_0
                  lbu          t4, -1(a7)
                  lbu          s9, 197(a1)
                  lb           s2, 250(a1)
                  lbu          s6, -89(a1)
                  sb           a3, 246(a1)
                  lbu          s11, 49(a7)
                  lb           s3, -232(a1)
                  sb           a6, -44(a7)
                  lbu          t2, 19(a1)
                  lbu          tp, -225(a1)
                  sb           s0, 162(a1)
                  lw           t2, -47(a7)
                  lb           t4, 24(a7)
                  lb           s2, 62(a1)
                  lb           gp, -32(a7) #end load_store_instr_stream_1
                  lw           s9, -77(a1) #end load_store_instr_stream_0
                  la           a6, region_1+39649 #start riscv_hazard_instr_stream_12
                  lb           a4, 12(a6)
                  srli         s11, a1, 22
                  mul          t0, s3, s11
                  lhu          t0, -55(a6)
                  lh           tp, 37(a6)
                  csrrsi       s3, 0x342, 16
                  lw           t0, 63(a6)
                  sh           a1, 37(a6)
                  sh           t0, -13(a6)
                  lb           t0, -28(a6)
                  lbu          tp, 6(a6)
                  lbu          s11, 16(a6)
                  slti         tp, a1, 1276
                  lbu          t0, 19(a6)
                  slt          a1, t0, tp
                  lb           tp, -7(a6)
                  csrrs        s3, 0x301, s3
                  slli         t0, a1, 25
                  sb           a1, 4(a6)
                  lb           a4, 7(a6)
                  ori          tp, a1, -1015
                  lb           a4, -20(a6)
                  slt          s3, a4, s3
                  sll          t0, s11, tp
                  sb           a4, -50(a6)
                  lbu          a4, 8(a6)
                  mulhu        a4, s3, a1
                  lhu          a4, -5(a6)
                  lh           tp, 33(a6)
                  lbu          a1, -58(a6)
                  csrrsi       t0, 0x301, 0
                  lbu          a1, -28(a6)
                  lb           s3, -24(a6)
                  lbu          s3, 0(a6)
                  sll          s3, s11, s11
                  csrrc        s11, 0x304, a4
                  add          t0, s3, tp
                  lhu          s3, 15(a6)
                  sub          s11, a4, t0
                  lb           s11, -12(a6)
                  srai         s3, tp, 9
                  lbu          t0, -24(a6)
                  lb           s11, -32(a6)
                  lh           s11, 25(a6)
                  lbu          s3, -27(a6) #end riscv_hazard_instr_stream_12
                  la           t3, region_1+57090 #start load_store_instr_stream_1
                  la           s2, region_0+1276 #start load_store_instr_stream_0
                  lhu          t6, 1648(t3)
                  lbu          t2, 1873(t3)
                  lbu          a2, 64(s2)
                  sb           s8, 11(t3)
                  sb           ra, -3(s2)
                  lb           t6, -1995(t3)
                  sh           a3, -1606(t3)
                  lhu          s10, -1992(t3)
                  lw           t6, 16(s2)
                  lhu          tp, -674(t3)
                  sb           s3, 1724(t3)
                  lbu          s0, 43(s2)
                  lb           s11, 1009(t3) #end load_store_instr_stream_1
                  sh           t0, -44(s2) #end load_store_instr_stream_0
                  la           s6, region_0+1690 #start load_store_instr_stream_2
                  la           a7, region_0+2812 #start load_store_instr_stream_1
                  la           s9, region_0+3888 #start load_store_instr_stream_0
                  lb           s5, -75(a7)
                  la           a2, region_0+2919 #start load_store_instr_stream_3
                  lhu          a5, -136(a7)
                  sh           ra, -48(s9)
                  lbu          a1, 255(a7)
                  lbu          t5, 217(a2)
                  lbu          ra, 40(a2)
                  sh           gp, 111(a2)
                  lb           ra, 2(s6)
                  lbu          s2, -244(a7)
                  sb           t3, -59(s6)
                  sb           a1, 13(s6)
                  lbu          a6, 15(s9)
                  sb           zero, 49(a7)
                  sb           t3, -40(s6)
                  lbu          t2, 36(a7)
                  sb           t0, 118(a2)
                  sb           s1, -218(a2)
                  sh           a7, 256(a7)
                  lw           s1, 121(a2)
                  sb           s5, -52(s6) #end load_store_instr_stream_2
                  lbu          t3, -17(s9)
                  sb           s3, -182(a2)
                  lhu          t2, -181(a2) #end load_store_instr_stream_3
                  sb           a5, 40(s9)
                  lbu          t2, 24(a7) #end load_store_instr_stream_1
                  sh           s10, -20(s9) #end load_store_instr_stream_0
                  la           s3, region_1+61182 #start riscv_load_store_rand_instr_stream_31
                  srai         s11, a5, 3
                  sltiu        a4, ra, -801
                  sb           t1, -13(s3)
                  or           zero, gp, a4
                  lw           ra, 14(s3)
                  ori          tp, tp, -87
                  sb           t6, 4(s3)
                  sb           zero, 15(s3)
                  mulh         s5, s8, s8
                  lbu          s0, 16(s3)
                  sb           t3, 15(s3)
                  lb           s10, 7(s3)
                  csrrci       a6, 0x343, 20
                  lhu          t0, 6(s3)
                  lw           a6, -14(s3)
                  lb           t1, -15(s3)
                  lb           s10, -7(s3)
                  lbu          a1, -14(s3)
                  lw           t0, 14(s3)
                  sb           a1, -12(s3)
                  div          s5, a5, s1
                  sh           gp, -8(s3)
                  sb           t5, -4(s3)
                  sb           t3, -16(s3)
                  lb           s0, -4(s3)
                  add          s8, t6, s11
                  slt          s6, gp, ra
                  lw           s6, -6(s3)
                  lhu          a1, -2(s3)
                  mulh         t3, s3, t1
                  sll          t3, a0, a3
                  lb           s11, -11(s3)
                  sh           s11, -12(s3)
                  lb           t0, -11(s3)
                  sh           a6, -14(s3) #end riscv_load_store_rand_instr_stream_31
main_98:          jal          t4, 1f
0:                jal          gp, 4f
1:                jal          ra, 9f
2:                jal          a6, 11f
3:                jal          t1, 19f
4:                jal          ra, 10f
5:                jal          t1, 12f
6:                jal          ra, 16f
7:                jal          t1, 3b
8:                jal          ra, 22f
9:                jal          ra, 0b
10:               jal          t1, 13f
11:               jal          ra, 8b
12:               jal          s8, 17f
13:               jal          t4, 21f
14:               jal          gp, 5b
15:               jal          t1, 14b
16:               jal          t1, 20f
17:               jal          a5, 2b
18:               jal          ra, 15b
19:               jal          ra, 6b
20:               jal          ra, 18b
21:               jal          ra, 7b
22:               mulh         zero, a3, t2
                  la           s2, region_0+3971 #start riscv_hazard_instr_stream_26
                  nop
                  sh           t6, 1(s2)
                  lbu          a2, -12(s2)
                  addi         s9, s9, -1992
                  lbu          a2, -6(s2)
                  sb           s9, -13(s2)
                  lh           t6, -1(s2)
                  csrrw        s9, 0x343, a0
                  nop
                  sb           s9, -5(s2)
                  div          s5, s9, s1
                  csrrs        a2, 0x343, a2
                  add          t6, a0, s1
                  divu         a0, t6, s1
                  csrrci       s9, 0x342, 0
                  lbu          s9, 14(s2)
                  csrrs        s5, 0x342, t6
                  and          a2, s1, a2
                  csrrw        s9, 0x301, s9
                  auipc        s5, 47810
                  sw           s5, 5(s2)
                  mul          s9, s1, t6
                  lb           s1, 5(s2)
                  csrrci       a2, 0x300, 0
                  lw           s9, 13(s2)
                  lw           a0, -11(s2)
                  lhu          a0, 13(s2)
                  lb           a2, 10(s2)
                  csrrsi       a2, 0x343, 0
                  ori          a0, a2, -243
                  mul          s9, a2, t6
                  lb           s1, 6(s2)
                  mulhu        a2, s9, s9
                  lb           t6, 10(s2)
                  srl          a2, a0, a0
                  and          t6, t6, s1
                  lhu          s5, 7(s2)
                  lbu          s9, 14(s2)
                  csrrsi       s1, 0x343, 26
                  remu         t6, t6, s9
                  csrrwi       s1, 0x342, 26
                  slt          a2, t6, a0
                  csrrs        s1, 0x344, s5
                  sw           s5, 1(s2) #end riscv_hazard_instr_stream_26
                  la           gp, region_1+49149 #start riscv_load_store_hazard_instr_stream_29
                  lb           s1, -1553(gp)
                  lb           a7, -1390(gp)
                  lb           a4, -1390(gp)
                  lbu          s1, -1892(gp)
                  lb           s1, -521(gp)
                  lb           ra, -521(gp)
                  lhu          a1, -521(gp)
                  sb           t5, -143(gp)
                  lbu          s2, -143(gp)
                  sb           a1, -143(gp)
                  lbu          a7, -143(gp)
                  sb           t2, -143(gp)
                  lbu          s2, -832(gp)
                  sb           s11, -832(gp)
                  lbu          t4, -832(gp)
                  srl          t6, s8, s10
                  lb           a2, -832(gp) #end riscv_load_store_hazard_instr_stream_29
main_113:         jal          t4, 12f
0:                jal          gp, 9f
1:                jal          tp, 11f
2:                jal          t1, 4f
3:                jal          ra, 7f
4:                jal          ra, 0b
5:                jal          ra, 2b
6:                jal          ra, 1b
7:                jal          ra, 6b
8:                jal          s6, 14f
9:                jal          ra, 3b
10:               jal          t2, 13f
11:               jal          ra, 10b
12:               jal          t0, 5b
13:               jal          t0, 8b
14:               addi         s8, gp, -1617
                  la           t2, region_0+3105 #start load_store_instr_stream_1
                  la           a6, region_1+51698 #start load_store_instr_stream_0
                  lw           s0, 26(a6)
                  lb           t4, -1905(t2)
                  sw           a5, 22(a6)
                  lbu          t4, -318(t2)
                  sw           s0, 54(a6)
                  lb           s8, 360(t2)
                  lbu          s1, -20(a6)
                  sb           zero, -33(a6)
                  lbu          s8, -49(a6)
                  lbu          s1, -1643(t2)
                  sb           a1, -28(a6)
                  sh           s4, 149(t2) #end load_store_instr_stream_1
                  lhu          t4, -20(a6)
                  lb           s1, -29(a6) #end load_store_instr_stream_0
                  la           t3, region_1+56837 #start riscv_load_store_hazard_instr_stream_28
                  sb           t3, -1099(t3)
                  lhu          a4, -1099(t3)
                  csrrw        s4, 0x301, sp
                  lh           gp, -1099(t3)
                  xor          s3, s9, t3
                  slt          a6, a2, sp
                  sh           s6, -1099(t3)
                  lb           tp, -1099(t3)
                  lbu          t4, -166(t3)
                  sb           ra, -166(t3)
                  lb           t5, -166(t3)
                  lb           ra, -166(t3)
                  lb           gp, -166(t3)
                  lb           s5, -166(t3) #end riscv_load_store_hazard_instr_stream_28
                  la           a4, region_1+42457 #start riscv_hazard_instr_stream_32
                  lbu          a0, -1278(a4)
                  lb           s1, -1931(a4)
                  sh           a0, -1715(a4)
                  sh           s0, -1241(a4)
                  lbu          s0, -149(a4)
                  lbu          s1, -1604(a4)
                  nop
                  lbu          s0, -536(a4)
                  or           s0, s2, s1
                  addi         a6, s0, 234
                  lh           a6, -695(a4)
                  lh           a0, 315(a4)
                  sb           t2, 1106(a4)
                  sb           a0, -1081(a4)
                  lh           s2, 1223(a4)
                  lbu          t2, 1123(a4)
                  sb           s0, -700(a4)
                  lbu          t2, 748(a4)
                  csrrsi       a6, 0x305, 0
                  sh           t2, 563(a4)
                  sb           s1, 1847(a4)
                  add          s0, s0, s1
                  mul          t2, s1, s1
                  remu         s2, a0, a6
                  lw           t2, 295(a4)
                  slti         s1, t2, 799
                  csrrc        a6, 0x301, t2
                  lhu          a6, 221(a4)
                  sb           s0, -1288(a4)
                  lb           s1, 1370(a4)
                  lb           s1, -910(a4)
                  lbu          s1, -1549(a4)
                  sb           s0, -1848(a4)
                  sltu         s0, t2, s1
                  mulhu        s2, s2, s2
                  sltu         s2, s2, s1
                  sb           t2, -1044(a4)
                  sh           t2, 1025(a4)
                  sb           a0, -1334(a4)
                  sb           a6, -658(a4)
                  srli         s0, a6, 15
                  divu         a6, t2, a0
                  lbu          a6, -828(a4)
                  add          s1, t2, s1
                  lh           s1, 1987(a4) #end riscv_hazard_instr_stream_32
                  li           s1, 0xffffffff #start riscv_int_numeric_corner_stream_24
                  li           t3, 0x0
                  li           t0, 0xa9b84dbf
                  li           t2, 0x80000000
                  li           s11, 0x0
                  li           s2, 0x17ff83ab
                  li           t1, 0xb45aeb2f
                  li           a7, 0x674eabab
                  li           tp, 0x80000000
                  li           s5, 0x80000000
                  nop
                  add          s11, t2, t3
                  addi         t3, s1, 1417
                  div          tp, a7, a7
                  remu         s11, s2, t1
                  auipc        tp, 205244
                  lui          a7, 935367
                  mulhu        a7, s5, s2
                  sub          s2, t0, t3
                  auipc        s11, 993342
                  divu         t3, s2, t2
                  mulhsu       s5, t1, t2
                  divu         a7, t0, t3
                  rem          t1, t1, a7
                  add          s1, t0, s1
                  lui          s1, 73460
                  mulhu        tp, t0, t1
                  rem          tp, t3, t0
                  mulh         a7, s11, t1 #end riscv_int_numeric_corner_stream_24
                  la           a0, region_0+2830 #start riscv_load_store_hazard_instr_stream_3
                  lb           s3, 1(a0)
                  lb           a4, -253(a0)
                  csrrc        t2, 0x300, zero
                  lbu          t0, -253(a0)
                  lbu          t1, -253(a0)
                  lbu          t4, -253(a0)
                  sb           s1, -253(a0)
                  lb           gp, -253(a0)
                  lbu          a1, -253(a0)
                  lbu          a4, -253(a0)
                  lbu          a4, 214(a0)
                  sh           a4, 214(a0)
                  andi         s0, s8, 1613
                  and          s2, s6, t2
                  lhu          tp, -196(a0)
                  lb           s11, -196(a0)
                  lbu          zero, -196(a0)
                  csrrwi       t0, 0x304, 14
                  lb           s4, -196(a0)
                  sltiu        tp, a1, -452
                  lbu          a6, -196(a0)
                  lb           gp, -196(a0)
                  lhu          tp, -196(a0) #end riscv_load_store_hazard_instr_stream_3
                  la           gp, region_1+4953 #start riscv_hazard_instr_stream_25
                  slli         s11, a1, 9
                  xor          t6, s2, s11
                  lb           s2, -67(gp)
                  or           t6, t6, a1
                  sb           a1, 35(gp)
                  csrrs        a1, 0x301, t6
                  lb           s2, -153(gp)
                  lui          zero, 173404
                  sb           a1, 82(gp)
                  sb           s11, -256(gp)
                  csrrs        s11, 0x342, s2
                  csrrwi       s2, 0x343, 15
                  srai         s2, a1, 17
                  lb           s2, -9(gp)
                  sb           s11, -6(gp)
                  div          t6, s2, t6
                  csrrci       s6, 0x343, 0
                  lbu          zero, -53(gp)
                  slt          s11, t6, t6
                  mul          s11, s11, zero
                  lbu          s11, -30(gp)
                  lh           t6, -229(gp)
                  sub          zero, s11, s2
                  andi         t6, s11, 647
                  mul          s2, s6, zero
                  add          s11, s6, zero
                  lh           t6, 171(gp)
                  sub          s11, t6, t6
                  rem          s6, zero, zero
                  lhu          zero, 211(gp)
                  lhu          s2, -111(gp)
                  lw           s2, -161(gp)
                  srl          s2, s2, a1
                  csrrc        zero, 0x300, zero
                  lb           s11, -56(gp)
                  sra          a1, s6, s6
                  lhu          s11, -47(gp)
                  srai         t6, s2, 8
                  csrrci       s11, 0x305, 0
                  slti         s6, zero, -1288
                  sltu         zero, zero, s2
                  and          s6, s2, s6
                  sltiu        t6, zero, 1816
                  csrrsi       a1, 0x343, 29
                  rem          s2, a1, s11
                  lbu          s6, -200(gp) #end riscv_hazard_instr_stream_25
                  li           a1, 0xe54479bd #start riscv_int_numeric_corner_stream_26
                  li           s11, 0x27516177
                  li           a4, 0x80000000
                  li           t3, 0x2fbfcf03
                  li           s3, 0x80000000
                  li           t1, 0x80000000
                  li           s0, 0x9aba77d3
                  li           t0, 0x0
                  li           t4, 0xffffffff
                  li           a0, 0xffffffff
                  divu         t1, a4, s3
                  add          a4, a0, t3
                  auipc        a1, 744527
                  sub          a4, s0, t0
                  auipc        s3, 269107
                  mul          a0, t4, t3
                  divu         s11, t1, t3
                  remu         a4, s11, t1
                  mulhsu       s11, a1, t3
                  mul          a0, s11, s11
                  rem          a1, t0, t1
                  divu         a0, a0, a0
                  remu         a1, t0, t3
                  addi         a0, t3, 84
                  nop
                  remu         t3, t1, t3
                  auipc        s11, 187074
                  addi         t3, a0, -148
                  sub          a1, a1, t0
                  addi         a1, s3, 616
                  mulh         t4, a1, a4
                  div          a4, a0, s11
                  auipc        t1, 955150
                  mul          s3, s3, t0
                  nop #end riscv_int_numeric_corner_stream_26
                  la           t2, region_0+1683 #start load_store_instr_stream_1
                  lb           s6, 148(t2)
                  la           a6, region_1+54374 #start load_store_instr_stream_0
                  lb           ra, 20(t2)
                  lb           t4, 66(t2)
                  sb           t1, 118(a6)
                  lb           a2, -1562(a6)
                  sh           a7, 223(t2)
                  lb           t5, -22(t2)
                  lbu          a0, -170(t2)
                  lb           ra, 103(t2)
                  lbu          gp, -34(t2)
                  sb           t2, -968(a6)
                  lbu          zero, -107(t2)
                  lw           a1, -866(a6)
                  sb           s6, -214(t2) #end load_store_instr_stream_1
                  sb           a1, -287(a6) #end load_store_instr_stream_0
                  la           s11, region_1+32685 #start riscv_load_store_hazard_instr_stream_8
                  lh           s8, 1675(s11)
                  sh           t0, 1675(s11)
                  srli         t5, s9, 3
                  lbu          s3, -939(s11)
                  lhu          t2, -939(s11)
                  ori          t3, gp, -878
                  remu         s10, sp, a0
                  lb           a1, -786(s11)
                  lbu          a1, -1007(s11)
                  lhu          t4, -119(s11)
                  lh           s1, -119(s11)
                  sll          t6, s1, gp
                  or           zero, s7, s8
                  sb           s2, 1740(s11)
                  sb           a6, -1600(s11)
                  lbu          a7, -1600(s11)
                  div          s9, gp, t1
                  lhu          t3, -5(s11)
                  sw           a6, 295(s11)
                  nop
                  lbu          s2, 666(s11) #end riscv_load_store_hazard_instr_stream_8
                  la           a1, region_1+60307 #start riscv_load_store_rand_instr_stream_2
                  and          ra, t1, s7
                  sra          s4, s4, a1
                  rem          s1, s2, s6
                  csrrs        t4, 0x301, zero
                  mulh         s4, s11, s4
                  slt          a2, a1, a5
                  lh           gp, 3(a1)
                  lb           a4, -16(a1)
                  slt          zero, s5, t3
                  addi         t0, a5, 1348
                  srl          s10, a2, a1
                  sb           t2, -1(a1)
                  sub          s0, a3, s10
                  sb           t5, 6(a1)
                  remu         s6, sp, t4
                  sh           s11, -1(a1)
                  sh           s8, -7(a1)
                  rem          s2, a0, a7
                  div          a0, t4, t4
                  sb           s11, -10(a1)
                  auipc        t5, 460814
                  sltu         a4, t4, s4
                  csrrwi       t2, 0x342, 28
                  mulh         s1, s7, t3
                  lb           s8, 5(a1)
                  add          s9, s2, a3
                  lb           t4, -5(a1)
                  lb           a7, -14(a1)
                  add          s2, t3, gp
                  ori          tp, t5, -731
                  sra          s1, a5, a1
                  srl          a5, s10, s8
                  lhu          s5, 5(a1)
                  lbu          ra, -6(a1)
                  or           s6, gp, s4
                  sb           s5, -2(a1)
                  xori         t5, sp, -178
                  lh           s2, 1(a1)
                  sh           a2, 11(a1)
                  sb           a6, -5(a1)
                  lh           s11, -3(a1)
                  csrrw        s5, 0x342, t2
                  ori          a7, s11, 638
                  lbu          a2, -2(a1)
                  lui          s8, 897546
                  csrrci       zero, 0x344, 30
                  lhu          a5, 15(a1) #end riscv_load_store_rand_instr_stream_2
0:                mulhu        s11, s11, a5
1:                divu         s11, a6, a6
2:                bne          t6, s3, 6f
3:                bge          sp, s3, 21f
4:                and          t1, zero, s1
5:                srai         zero, s10, 26
6:                andi         s6, t3, -1197
7:                sub          ra, s6, s10
8:                addi         s0, a0, 1255
9:                bge          s4, tp, 18f
10:               srai         ra, zero, 30
11:               sltiu        t6, t2, -250
12:               and          s8, s0, t1
13:               bge          a1, a2, 16f
14:               slti         a6, a7, 221
15:               ori          t5, zero, 539
16:               bne          a6, gp, 20f
17:               xori         s0, s10, -422
18:               srai         t4, t2, 12
19:               beq          s6, a6, 39f
20:               or           s8, t5, s10
21:               bltu         s3, t2, 27f
22:               mulhu        s2, a7, gp
23:               sltiu        t2, s1, 1236
24:               csrrwi       gp, 0x343, 18
25:               csrrs        t3, 0x343, s1
26:               blt          s11, t0, 39f
27:               rem          zero, t0, a3
28:               slti         s3, t5, 1442
29:               remu         t4, t5, a1
30:               xori         tp, ra, 318
31:               csrrsi       gp, 0x343, 0
32:               slli         s9, t0, 23
33:               lui          t0, 35417
34:               slt          s3, a6, s1
35:               sub          s0, s6, a1
36:               csrrc        t2, 0x343, s7
37:               csrrc        tp, 0x343, t3
38:               nop
39:               srai         s1, s0, 19
40:               sltiu        s6, s6, 1264
41:               csrrs        t0, 0x343, a0
42:               mulhsu       gp, a3, gp
43:               srai         ra, t0, 24
44:               mulhsu       a0, a4, a5
45:               addi         gp, s6, -1620
46:               sra          a0, s9, s11
47:               slt          s4, s5, sp
48:               slt          a5, t0, a1
49:               mulh         s2, tp, s10
50:               andi         t2, a3, -1682
51:               blt          a0, tp, 61f
52:               xori         t5, a6, 213
53:               addi         s5, a5, -960
54:               or           s10, a3, a0
55:               srl          s2, s6, ra
56:               slti         s0, s6, 880
57:               bltu         a4, t1, 60f
58:               csrrc        s10, 0x301, zero
59:               mul          s11, a4, a4
60:               bgeu         zero, a0, 63f
61:               div          s9, s6, s2
62:               or           a7, a2, s6
63:               beq          s4, s1, 64f
64:               divu         a5, a6, s6
65:               csrrci       s3, 0x343, 0
66:               csrrw        ra, 0x344, a4
67:               mulhsu       a4, s9, t5
68:               lui          s1, 699424
69:               srl          a0, t2, s11
70:               andi         s5, s7, 1757
71:               csrrwi       t1, 0x344, 29
72:               and          s9, s3, s5
73:               bne          t2, t1, 84f
74:               divu         a2, s9, s3
75:               remu         gp, ra, s4
76:               srli         a0, t3, 25
77:               or           t4, sp, s10
78:               sub          s6, s6, ra
79:               csrrw        t0, 0x343, t3
80:               nop
81:               divu         a2, a0, s10
82:               srli         t5, a2, 27
83:               add          t3, zero, a6
84:               slti         s0, s7, 1555
85:               csrrc        s8, 0x344, zero
86:               divu         a7, t6, s3
87:               rem          t4, a2, s7
88:               and          gp, a3, t1
89:               sub          t0, s2, s1
90:               srai         a2, s1, 21
91:               slti         a5, s7, 1115
92:               slt          t4, s8, s8
93:               nop
94:               csrrw        s6, 0x344, s7
95:               divu         t0, s7, a5
96:               xori         a5, tp, 1330
97:               div          t4, t0, zero
98:               sll          s2, zero, s8
99:               slt          a1, gp, s9
100:              srli         ra, a2, 9
101:              csrrwi       zero, 0x342, 27
102:              bltu         a5, s7, 105f
103:              bltu         s8, t3, 110f
104:              or           s1, t4, s2
105:              csrrw        zero, 0x304, tp
106:              add          s1, s5, s7
107:              csrrci       a2, 0x342, 0
108:              sltiu        a7, s3, -1476
109:              bgeu         s4, gp, 120f
110:              mulh         a0, s2, t3
111:              csrrsi       t3, 0x342, 1
112:              sltiu        a6, s1, -1192
113:              bgeu         a4, s9, 123f
114:              slli         t6, s8, 22
115:              srl          a7, t4, s2
116:              mulh         a7, s7, t6
117:              and          a6, sp, s5
118:              ori          s2, zero, -1648
119:              mul          s9, a2, a0
120:              and          t4, t3, t4
121:              divu         t5, a0, t3
122:              csrrs        t0, 0x343, zero
123:              srli         a6, s3, 10
124:              sra          t0, t5, t4
125:              divu         s8, s8, s7
126:              or           s1, sp, a1
127:              csrrsi       zero, 0x344, 0
128:              ori          t6, s7, 871
129:              mulhu        ra, s3, s2
130:              blt          a5, sp, 144f
131:              csrrs        t1, 0x344, s6
132:              divu         s1, gp, tp
133:              csrrsi       a0, 0x305, 0
134:              blt          t3, a5, 145f
135:              sltiu        a4, a1, -524
136:              csrrwi       s9, 0x342, 22
137:              csrrwi       gp, 0x343, 6
138:              bltu         a0, t6, 143f
139:              ori          s9, t0, 1975
140:              andi         a2, t0, 258
141:              bltu         ra, t1, 145f
142:              blt          s11, gp, 160f
143:              sltu         s3, s6, s3
144:              add          a6, zero, s0
145:              bne          a5, s4, 147f
146:              auipc        t6, 560435
147:              slli         zero, s11, 16
148:              addi         t0, s9, -807
149:              add          a7, t0, gp
150:              csrrw        a6, 0x343, t0
151:              sll          s3, s11, a4
152:              bge          s9, sp, 157f
153:              xori         t6, s0, -1636
154:              mulhsu       a7, t0, t3
155:              slt          ra, a1, s3
156:              csrrs        s6, 0x344, s2
157:              mulh         t2, a2, zero
158:              csrrw        a0, 0x342, t3
159:              bne          a0, s3, 160f
160:              andi         s3, a7, 1984
161:              csrrsi       t0, 0x304, 0
162:              remu         a1, s11, gp
163:              sub          s5, a3, t5
164:              divu         t0, t5, s5
165:              mulhsu       s11, s7, t4
166:              csrrw        s8, 0x344, gp
167:              remu         t3, zero, zero
168:              remu         s8, s3, s11
169:              srai         zero, t5, 19
170:              add          s4, t4, ra
171:              and          s2, a3, a4
172:              mulhsu       s11, a4, sp
173:              slt          s4, t5, s4
174:              slli         s6, s11, 6
175:              mulhu        s8, s4, a2
176:              remu         a6, s11, sp
177:              csrrs        a1, 0x301, s4
178:              bge          s7, t4, 190f
179:              srli         s8, gp, 10
180:              nop
181:              csrrw        a4, 0x304, sp
182:              srli         t6, s9, 2
183:              and          s5, s3, a7
184:              srl          s1, t0, zero
185:              csrrw        zero, 0x301, s6
186:              remu         tp, t4, s0
187:              addi         t3, t1, -442
188:              csrrs        t6, 0x300, zero
189:              csrrs        a4, 0x305, zero
190:              sll          ra, s4, t2
191:              srl          a1, ra, a6
192:              slti         a0, gp, 1823
193:              nop
194:              andi         s0, s5, 740
195:              slti         tp, s4, -1632
196:              or           a0, t0, s4
197:              mulh         t3, t6, t6
198:              slt          t5, s1, s3
199:              mul          t2, s3, s3
200:              xori         s10, s4, 1162
201:              slli         tp, s1, 9
202:              xori         a6, s2, -276
203:              csrrwi       t0, 0x301, 27
204:              div          a4, s6, s11
205:              bgeu         t4, s8, 213f
206:              mulhu        t5, t1, tp
207:              slti         t0, t3, -1310
208:              sra          t2, a1, t1
209:              srli         s6, a4, 20
210:              bge          s0, zero, 225f
211:              slti         a1, s5, -1858
212:              and          t0, t5, a4
213:              divu         s3, t5, s4
214:              or           tp, s7, a1
215:              sll          s0, s6, t6
216:              bne          a4, s0, 219f
217:              mulhsu       s4, t3, s6
218:              xor          s10, a5, a6
219:              mulh         s6, gp, t6
220:              blt          s3, a7, 228f
221:              nop
222:              sra          t1, s10, a0
223:              beq          s9, s6, 227f
224:              divu         t1, ra, s11
225:              csrrsi       tp, 0x342, 0
226:              sltiu        a0, tp, -1243
227:              csrrwi       gp, 0x301, 31
228:              addi         s0, ra, -1285
229:              srli         t1, sp, 6
230:              beq          tp, a3, 231f
231:              csrrs        tp, 0x300, zero
232:              srl          t3, s10, a5
233:              bltu         t4, s5, 244f
234:              mul          t4, t1, t4
235:              addi         s5, s4, 763
236:              bltu         a3, sp, 247f
237:              bltu         a3, gp, 251f
238:              remu         a0, s3, s10
239:              or           s3, a7, s1
240:              bge          s6, a3, 248f
241:              rem          s8, s6, s9
242:              mul          s9, sp, a6
243:              srl          t5, t4, a1
244:              addi         a1, s1, -613
245:              divu         t2, t6, t3
246:              csrrc        a4, 0x300, zero
247:              sub          a6, a5, a4
248:              mulh         a1, t3, zero
249:              remu         s3, a0, s10
250:              bne          a4, s9, 257f
251:              auipc        ra, 596684
252:              sltiu        s3, a7, 512
253:              lui          ra, 885189
254:              slti         zero, a5, 659
255:              csrrwi       s5, 0x301, 18
256:              sltu         a0, a1, t1
257:              bge          tp, t0, 263f
258:              rem          s4, a4, gp
259:              remu         a6, t5, s1
260:              xor          t0, s4, s5
261:              csrrsi       t2, 0x342, 6
262:              divu         t3, a6, a2
263:              csrrc        t4, 0x300, zero
264:              remu         s6, s8, s0
265:              sra          t5, s3, a5
266:              or           a1, a6, gp
267:              bne          s10, a3, 272f
268:              add          s10, s2, s2
269:              csrrw        a0, 0x301, s10
270:              slli         s3, s2, 22
271:              csrrc        a2, 0x304, zero
272:              mulhsu       t4, s3, gp
273:              div          a1, a2, a5
274:              sltiu        s3, t2, -2020
275:              slti         s9, s6, 432
276:              csrrwi       a0, 0x304, 30
277:              srai         a5, a3, 15
278:              beq          t6, s11, 290f
279:              bltu         s10, a5, 282f
280:              nop
281:              csrrsi       a6, 0x342, 0
282:              mul          s10, ra, t5
283:              bge          s10, s11, 296f
284:              csrrs        s8, 0x344, s3
285:              srli         a0, a0, 7
286:              xor          s4, a4, s7
287:              nop
288:              srli         s4, s5, 12
289:              bltu         s5, zero, 294f
290:              slli         s1, a1, 4
291:              slti         a7, t1, -1845
292:              csrrs        s11, 0x342, a4
293:              bne          s2, a7, 311f
294:              sltu         t5, a6, s1
295:              srli         t3, s9, 15
296:              auipc        a4, 515526
297:              slli         t1, s10, 11
298:              xori         t3, s3, 1058
299:              and          a1, t1, zero
300:              or           s2, a7, a6
301:              sub          s11, t6, s9
302:              addi         s8, s5, 789
303:              or           s5, tp, s11
304:              beq          s3, s0, 307f
305:              sra          a5, s4, a0
306:              mulhsu       t5, a3, zero
307:              sltu         s2, a6, sp
308:              beq          s4, s3, 311f
309:              auipc        a4, 45820
310:              remu         a1, a1, a3
311:              srl          s0, a5, s6
312:              and          ra, a2, zero
313:              add          s8, t5, gp
314:              add          s8, a4, a2
315:              csrrs        s4, 0x342, zero
316:              mulhsu       t6, a1, tp
317:              srli         s4, a7, 4
318:              mulhu        a0, ra, a2
319:              mulhsu       s4, sp, s10
320:              csrrc        a5, 0x301, zero
321:              xor          s11, t1, a0
322:              slli         s8, s7, 2
323:              rem          t5, a3, t0
324:              and          a4, a5, a3
325:              xori         s1, zero, -140
326:              srli         s2, t4, 18
327:              csrrw        t6, 0x344, s8
328:              remu         ra, s8, a7
329:              div          s4, t4, s3
330:              slli         a0, s5, 14
331:              csrrsi       s1, 0x300, 0
332:              mulh         a4, s10, gp
333:              xor          zero, a2, s8
334:              slli         t0, t0, 21
335:              csrrci       a5, 0x304, 0
336:              bne          gp, s4, 351f
337:              ori          s3, tp, 363
338:              bgeu         a0, a2, 356f
339:              auipc        a1, 112243
340:              sra          a4, t0, s6
341:              blt          a0, s4, 350f
342:              xor          s6, t5, s7
343:              bge          t0, s6, 344f
344:              slti         a4, s1, 1920
345:              sltu         tp, t5, zero
346:              csrrsi       gp, 0x305, 0
347:              blt          gp, s5, 355f
348:              ori          tp, s3, 880
349:              sltiu        s11, t4, -1299
350:              bne          s3, s9, 354f
351:              ori          ra, s3, 450
352:              nop
353:              blt          a0, s2, 357f
354:              blt          s9, t2, 365f
355:              slti         a4, a0, 1473
356:              andi         s5, s6, -453
357:              csrrci       a1, 0x342, 20
358:              bltu         t4, t5, 361f
359:              slt          s8, s5, s5
360:              sra          a0, s4, tp
361:              slti         s2, t0, 1465
362:              andi         t0, ra, 83
363:              mul          t2, t1, tp
364:              addi         t0, s5, -1637
365:              addi         s2, s0, 554
366:              srli         t3, a0, 2
367:              or           s1, t0, s4
368:              sub          a5, s6, t0
369:              srli         a0, s1, 15
370:              bgeu         gp, zero, 380f
371:              xori         ra, t1, 846
372:              sra          t0, s4, a7
373:              bgeu         s1, a1, 375f
374:              xor          t0, t2, t2
375:              xori         t4, zero, -913
376:              bne          s7, s0, 396f
                  la           t6, region_1+48313 #start load_store_instr_stream_1
                  la           a0, region_0+791 #start load_store_instr_stream_0
                  lbu          s0, 1094(a0)
                  sb           s6, 5(t6)
                  sb           t5, -6(t6)
                  lb           t5, 530(a0)
                  lb           t5, -11(t6)
                  sh           ra, -201(a0)
                  lb           s3, -43(a0)
                  lw           a1, -9(t6)
                  sb           a4, -13(t6)
                  sb           a3, -248(a0)
                  lb           a6, -6(t6) #end load_store_instr_stream_1
                  sh           s2, 335(a0) #end load_store_instr_stream_0
377:              bge          s3, s10, 387f
378:              sltu         a4, a5, a2
379:              srl          a2, s4, s10
380:              sll          zero, zero, s11
381:              xor          s0, a7, a1
382:              add          s8, a1, t4
383:              xori         a1, s2, -1830
384:              bgeu         sp, a1, 387f
385:              csrrs        s10, 0x304, zero
386:              sub          gp, s5, s6
387:              srli         s2, a6, 29
388:              csrrs        a6, 0x342, zero
389:              addi         s5, t3, 1195
390:              csrrci       s2, 0x300, 0
391:              csrrci       s5, 0x343, 0
392:              and          s0, tp, a2
393:              mul          s3, s1, t3
394:              auipc        t0, 394894
395:              sltiu        a0, s0, 613
396:              slti         s11, s11, 1036
397:              csrrw        s9, 0x304, s3
398:              beq          t0, a5, 411f
399:              ori          a2, a1, -1123
400:              and          zero, s4, s2
401:              mulhsu       t3, s6, t0
402:              or           a7, t6, s9
403:              csrrwi       a7, 0x344, 0
404:              bne          s1, s8, 415f
405:              remu         tp, s0, sp
406:              div          a1, t5, s0
407:              slt          s5, a7, s10
408:              mulh         a6, s5, s4
409:              remu         a2, s4, a4
410:              ori          a7, s10, -307
411:              and          t6, a5, s11
412:              sll          s5, t0, tp
413:              csrrwi       s8, 0x304, 31
414:              sra          t1, s4, a3
415:              sll          s2, tp, s0
416:              mulh         a6, zero, a3
417:              and          t6, ra, t4
418:              bge          a7, t4, 421f
419:              csrrwi       a7, 0x304, 3
420:              nop
421:              remu         t2, sp, zero
422:              bge          s9, s0, 440f
423:              ori          s8, t3, -1220
424:              sll          a7, a1, t0
425:              slli         s0, s4, 13
426:              slli         s11, a2, 18
                  la           a1, region_1+37574 #start riscv_hazard_instr_stream_35
                  addi         a7, t2, 1770
                  lhu          t2, -36(a1)
                  slti         s2, s10, -815
                  sh           t2, 24(a1)
                  csrrci       a7, 0x301, 0
                  lhu          s0, -40(a1)
                  lbu          t6, 35(a1)
                  sb           a7, -3(a1)
                  and          t2, t6, s0
                  sh           s2, 60(a1)
                  or           t6, s2, s2
                  mulh         s10, t2, a7
                  sb           a7, -57(a1)
                  sh           a7, -44(a1)
                  lb           t2, -9(a1)
                  lbu          t6, -13(a1)
                  sb           s2, 28(a1)
                  lbu          s10, 3(a1)
                  slti         s2, t2, 141
                  mul          s0, t2, s2
                  csrrwi       s10, 0x304, 5
                  srl          a7, s0, a7
                  lhu          s2, 54(a1)
                  lui          a7, 234841
                  lbu          t2, -53(a1)
                  sll          t2, s2, s2
                  lbu          a7, 33(a1)
                  sub          s10, a7, t2
                  sh           t6, 10(a1)
                  lh           s2, -6(a1)
                  lb           t6, 53(a1) #end riscv_hazard_instr_stream_35
427:              beq          a6, s2, 428f
428:              bgeu         a6, t6, 440f
429:              div          gp, s0, s7
430:              xori         t5, t6, 877
431:              csrrs        s8, 0x305, zero
432:              csrrsi       a2, 0x305, 0
433:              csrrc        s4, 0x300, zero
434:              xor          s10, s8, a3
435:              srai         t4, ra, 18
436:              csrrw        s10, 0x301, s10
437:              srai         s0, s5, 5
438:              xor          s10, a3, s8
439:              bgeu         s8, s10, 444f
440:              bltu         s2, t3, 447f
441:              rem          a6, s11, a5
442:              csrrsi       ra, 0x342, 26
443:              or           a2, s10, a7
444:              csrrw        s6, 0x343, s6
445:              slli         s8, a2, 16
446:              xori         a6, tp, -1624
447:              sltiu        s1, s5, -550
448:              nop
449:              slti         a4, t4, -641
450:              mulh         t1, t3, a0
451:              div          a6, a7, s0
452:              andi         zero, sp, 213
453:              lui          tp, 922225
454:              xori         s10, a3, 1401
455:              srai         a1, t0, 29
456:              sltu         s10, a6, sp
457:              sll          gp, s6, zero
458:              sltu         tp, s5, sp
459:              ori          s9, gp, 1057
460:              nop
461:              bgeu         s3, t5, 469f
462:              add          ra, gp, s6
463:              bltu         t3, s10, 466f
464:              csrrc        tp, 0x342, zero
465:              csrrs        t6, 0x304, s2
466:              beq          tp, t0, 472f
467:              mul          t4, s0, s8
468:              sra          tp, s7, s3
469:              slli         a7, ra, 28
470:              sub          s5, t4, a2
471:              auipc        s11, 797244
472:              sltu         t2, s3, t1
473:              csrrsi       zero, 0x304, 0
474:              slli         a1, zero, 26
475:              srl          s10, tp, a3
476:              div          s3, s0, s8
477:              mulh         s0, s6, a3
478:              sub          gp, s6, t2
479:              lui          a6, 1019109
480:              csrrsi       t4, 0x300, 0
481:              slt          s4, s9, s2
482:              ori          s0, t1, 1690
483:              beq          s5, a2, 492f
484:              csrrwi       s5, 0x342, 12
485:              srli         a1, a7, 19
486:              sltiu        s1, s5, -842
487:              andi         zero, a2, -1829
488:              slti         t2, tp, -677
489:              csrrc        zero, 0x344, t0
490:              srai         s9, s1, 11
491:              bne          zero, sp, 492f
492:              bgeu         a4, s3, 507f
493:              xor          s1, a4, t4
494:              sra          a5, tp, gp
495:              bgeu         t3, t0, 506f
496:              remu         a5, t1, t5
497:              addi         s2, s8, -1116
498:              slt          t6, a4, s9
499:              csrrsi       t4, 0x343, 0
500:              mul          s2, sp, s9
501:              bge          s3, sp, 511f
502:              csrrwi       a4, 0x344, 8
503:              mulhu        s11, t6, s0
504:              or           s8, a1, a5
505:              and          s8, a7, s11
506:              sub          a4, tp, s9
507:              bgeu         s7, s8, 515f
508:              divu         a6, gp, s10
509:              xor          s9, t5, gp
510:              xori         ra, sp, -906
511:              mul          tp, t0, zero
512:              srli         s4, t1, 12
513:              mulhu        tp, gp, s1
514:              csrrsi       a4, 0x301, 28
515:              nop
516:              csrrci       s4, 0x344, 24
517:              auipc        t0, 921485
518:              bge          tp, a3, 536f
519:              slt          t0, s10, s7
520:              sub          a1, t4, s0
521:              bne          s7, s9, 523f
522:              bgeu         a5, t0, 525f
523:              blt          zero, s1, 534f
524:              csrrs        s9, 0x344, a5
525:              csrrc        zero, 0x344, s11
526:              csrrw        s0, 0x304, s9
527:              slt          t2, s0, a2
528:              nop
529:              sltiu        t0, t3, 102
530:              ori          a7, a4, 1553
531:              bltu         t0, a2, 545f
532:              slt          s8, t3, a7
533:              or           t4, zero, t5
534:              xor          tp, a4, a7
535:              xori         a2, tp, -1348
536:              ori          t6, sp, 940
537:              srl          tp, s1, s6
538:              and          a4, s7, a1
539:              rem          s8, s1, s2
540:              divu         s4, a6, gp
541:              slti         a7, s4, 2009
542:              mulhsu       s3, t1, t6
543:              bgeu         t2, s0, 547f
544:              andi         s9, a3, -1829
545:              csrrci       gp, 0x342, 0
546:              csrrsi       a0, 0x301, 0
547:              slt          s6, a3, a5
548:              xor          t4, a1, gp
549:              mul          s0, s4, zero
550:              div          a7, s5, s0
551:              divu         s11, sp, a0
552:              csrrw        s10, 0x304, s11
553:              ori          a6, s9, -443
554:              addi         t4, tp, 1721
555:              auipc        s5, 792792
556:              sra          t5, s6, s8
557:              div          s0, s5, s3
558:              mulh         s11, t5, zero
559:              bgeu         s8, a7, 563f
560:              slti         a1, s11, -71
561:              add          a5, a1, zero
562:              sra          a1, a4, gp
563:              sub          t3, t3, s9
564:              addi         s10, t1, -635
565:              csrrs        tp, 0x342, zero
566:              sll          s6, s8, s8
567:              beq          s10, a7, 571f
568:              xori         t1, s2, -1560
569:              ori          s8, t4, -1096
570:              auipc        t4, 660442
571:              ori          t0, s2, -1420
572:              and          t0, s3, s7
573:              divu         t4, t1, a5
574:              rem          t6, s6, s5
575:              divu         t4, s2, t0
576:              slti         t5, t1, 621
577:              mulhu        a2, s7, a2
578:              mulhsu       a6, a4, gp
579:              add          s8, t5, a4
580:              add          zero, s6, t1
581:              srli         a5, zero, 16
582:              remu         tp, t4, sp
583:              sub          a6, a1, a6
584:              lui          s1, 71769
585:              xor          a4, a1, t0
586:              csrrc        t2, 0x301, s11
587:              mulhsu       s11, s10, gp
588:              xor          t1, ra, s5
589:              or           t3, s8, a2
590:              mul          s8, s0, gp
591:              slt          s8, sp, a1
592:              sltiu        s10, a7, 1848
593:              and          s9, s10, a1
594:              csrrs        a6, 0x344, zero
595:              auipc        s3, 307106
596:              csrrw        t3, 0x342, t3
597:              xori         s0, s6, -1714
598:              csrrw        s2, 0x304, t3
599:              csrrwi       t3, 0x304, 18
600:              rem          zero, t4, t3
601:              blt          t2, a7, 604f
602:              beq          t6, a6, 607f
603:              bltu         t5, a6, 623f
604:              add          a4, a1, t6
605:              slti         zero, a2, -561
606:              csrrc        s9, 0x300, zero
607:              csrrwi       a1, 0x342, 26
608:              mulhsu       t4, s5, t0
609:              and          a0, s7, a6
610:              csrrs        s0, 0x342, zero
611:              bne          s11, s9, 614f
612:              csrrwi       t3, 0x342, 13
613:              div          a4, s4, sp
614:              and          t6, t4, a0
615:              sra          ra, gp, s9
616:              addi         a4, a3, 161
617:              slt          t6, t0, t0
618:              lui          s8, 340936
619:              sra          t5, a5, t6
620:              csrrci       s4, 0x343, 16
621:              nop
622:              sll          s1, zero, s0
623:              bge          s5, a5, 633f
624:              csrrsi       t2, 0x343, 0
625:              mulhsu       a1, a7, s6
626:              divu         s0, s2, s1
627:              rem          a1, sp, a2
628:              add          s4, a5, a7
629:              mul          a7, t6, s5
630:              slti         zero, tp, 472
631:              blt          t1, t3, 634f
632:              sub          t5, s10, s1
633:              csrrc        s3, 0x344, t0
634:              mul          a5, s6, t2
635:              addi         s0, a3, -52
636:              srli         a2, s8, 27
637:              csrrw        gp, 0x344, a6
638:              sll          a4, s7, s10
639:              andi         a1, tp, 1058
640:              or           s4, a7, t5
641:              bltu         s2, s7, 646f
642:              beq          t2, a2, 650f
643:              blt          a6, s7, 651f
644:              bltu         s8, gp, 647f
645:              bge          a5, a7, 657f
646:              bge          a5, a2, 664f
647:              auipc        s3, 416912
648:              bgeu         a1, zero, 668f
649:              csrrs        s10, 0x342, zero
650:              auipc        s1, 705079
651:              addi         t6, sp, -120
652:              xori         a0, t0, -2001
653:              srli         t1, s10, 9
654:              sltiu        t2, t6, 1148
655:              bne          s9, t2, 656f
656:              sltu         s1, s0, gp
657:              srli         s8, s7, 29
658:              ori          ra, tp, -1859
659:              and          s10, ra, a0
660:              sltu         t5, s1, s10
661:              lui          t1, 37122
662:              xori         t1, t3, -1244
663:              sltu         a4, s6, t1
664:              ori          t5, s1, 326
665:              csrrs        a0, 0x304, a7
666:              sra          s4, a6, tp
667:              bltu         s3, t5, 671f
668:              sltiu        a7, a7, 279
669:              nop
670:              mulhsu       gp, s1, s2
671:              csrrs        a6, 0x305, zero
672:              nop
673:              and          s5, s5, a5
674:              mulhsu       s1, s8, s10
675:              slli         s4, t1, 12
676:              slli         a1, a7, 29
677:              slli         t1, s2, 25
678:              auipc        s4, 849048
679:              mulhu        s4, a7, a7
680:              bltu         t1, t5, 698f
681:              sltiu        a6, t3, 1989
682:              srl          s3, a7, sp
683:              mulhsu       s0, s4, a7
684:              auipc        s1, 361956
685:              csrrci       a0, 0x344, 10
686:              beq          t1, s10, 696f
687:              remu         t1, ra, s2
                  la           a7, region_1+28415 #start riscv_hazard_instr_stream_14
                  lb           s8, 63(a7)
                  mulh         gp, a2, gp
                  lb           gp, 172(a7)
                  sb           tp, -158(a7)
                  andi         a0, gp, 2001
                  or           t6, t6, tp
                  rem          s8, a0, a2
                  srai         s8, s8, 1
                  div          tp, tp, t6
                  lh           t6, -53(a7)
                  addi         gp, t6, -797
                  srli         gp, a2, 4
                  lb           tp, -140(a7)
                  csrrs        a0, 0x344, gp
                  slli         s8, t6, 17
                  addi         t6, s8, -1047
                  lb           a0, 154(a7)
                  slti         a2, a0, -263
                  sb           gp, -56(a7)
                  csrrc        t6, 0x301, gp
                  lbu          tp, -6(a7)
                  xori         s8, tp, -1172
                  remu         s8, t6, gp
                  sll          a0, tp, s8
                  slt          tp, s8, t6
                  csrrsi       gp, 0x305, 0
                  srli         s8, gp, 2
                  sub          tp, a0, a0
                  xori         a0, a0, 1625
                  lb           s8, 194(a7)
                  sb           a2, 140(a7)
                  sb           a0, 171(a7)
                  mulhsu       a2, a2, a2
                  csrrsi       tp, 0x344, 0
                  lhu          s8, -65(a7)
                  or           s8, s8, gp
                  lb           a2, -153(a7)
                  srai         gp, a2, 10
                  lbu          s8, 58(a7)
                  lb           a2, 78(a7)
                  lbu          t6, -222(a7)
                  mul          a0, a2, tp
                  lbu          s8, -24(a7)
                  and          gp, tp, s8
                  sb           a2, 50(a7) #end riscv_hazard_instr_stream_14
688:              rem          s3, a7, t6
689:              slt          s2, a5, a0
690:              srai         t3, a3, 5
691:              sra          t2, t4, zero
692:              sll          gp, s4, t1
693:              csrrs        a0, 0x301, s1
694:              csrrc        a5, 0x342, zero
695:              mulhsu       a2, a7, a1
696:              mulh         tp, t2, s6
697:              blt          t6, s3, 708f
698:              sub          s3, s2, s1
699:              add          t4, s7, t0
700:              csrrci       tp, 0x344, 20
701:              auipc        a7, 522216
702:              and          s4, a7, ra
703:              divu         s9, s2, a0
704:              srai         s2, a3, 13
705:              srai         s2, t4, 15
706:              sltiu        s9, a4, 1983
707:              rem          s1, ra, s10
708:              nop
709:              srli         s11, t1, 21
710:              bge          s4, t1, 720f
711:              remu         a7, sp, s10
712:              nop
713:              csrrsi       tp, 0x300, 0
714:              bne          t1, s9, 721f
715:              bge          s9, s0, 716f
716:              lui          a6, 429764
717:              rem          t1, ra, zero
718:              xor          t1, a3, t5
719:              csrrwi       t5, 0x304, 10
720:              sll          a5, a2, gp
721:              csrrsi       a1, 0x342, 0
722:              or           s0, s1, t0
723:              slli         s10, s4, 12
724:              slti         t4, s5, 1185
725:              csrrci       s0, 0x305, 0
726:              bgeu         s3, a5, 731f
727:              addi         t2, gp, -366
728:              mulh         s5, t0, s6
729:              sub          t6, s8, t3
730:              csrrsi       s6, 0x300, 0
731:              or           a4, s10, a2
732:              slli         s2, zero, 29
733:              rem          a1, s11, s3
734:              csrrc        gp, 0x300, zero
735:              and          s4, a2, s2
736:              div          t2, a0, s5
737:              slli         t6, t3, 21
738:              lui          ra, 137031
739:              lui          s2, 401131
740:              mulhu        s0, s3, s5
741:              mulhu        a6, s10, t3
742:              srai         s5, gp, 26
743:              ori          t6, a3, -705
744:              sltiu        t0, a5, 1703
745:              auipc        a4, 687679
746:              xori         ra, s5, 1130
747:              mulh         a6, s2, s5
748:              srai         t1, s5, 23
749:              csrrci       s0, 0x344, 11
750:              bgeu         s11, a5, 754f
751:              sltu         a7, a1, s2
752:              auipc        s4, 755699
753:              sra          tp, a7, s7
754:              beq          s5, s8, 765f
755:              rem          t5, t2, s6
756:              sub          s0, s8, t1
757:              slti         s10, s7, -194
758:              bgeu         t4, zero, 762f
759:              bltu         s10, a2, 762f
760:              csrrs        gp, 0x301, zero
761:              and          a1, s2, t5
762:              addi         a1, a4, -526
763:              divu         a4, s0, gp
764:              csrrwi       s5, 0x344, 24
765:              lui          a6, 791221
766:              sra          s3, s11, gp
767:              addi         a4, t1, 546
768:              xor          tp, t3, s3
769:              ori          s2, gp, -884
770:              xori         a7, a2, -171
771:              andi         ra, a1, -685
772:              sltiu        s5, s6, 1367
773:              bge          s2, s3, 776f
774:              sub          t1, ra, t2
775:              or           t3, a7, gp
776:              sltu         a5, a4, s9
777:              csrrw        ra, 0x301, t1
778:              auipc        s9, 300751
779:              mulh         s2, t2, gp
780:              csrrw        a2, 0x301, s4
781:              sltiu        t6, a6, 539
782:              or           s3, s10, a3
783:              srli         gp, s3, 15
784:              mulhu        t2, ra, a2
785:              sll          s0, t0, s10
786:              bltu         s5, t0, 797f
787:              srl          tp, t5, tp
788:              or           s9, s10, a2
789:              sra          a1, s3, t2
790:              beq          s0, zero, 803f
791:              sll          s10, t2, a3
792:              rem          a6, s9, t2
793:              divu         gp, a0, s4
794:              bge          zero, t6, 796f
795:              beq          t4, s2, 801f
796:              csrrwi       tp, 0x342, 5
797:              andi         a1, s6, 277
798:              ori          s5, s6, 1654
799:              ori          gp, t6, -1956
800:              divu         a4, s2, t5
801:              csrrw        zero, 0x304, zero
802:              addi         t1, t3, 1110
803:              bltu         s2, gp, 818f
804:              div          s1, s3, s9
805:              div          t6, s1, a7
806:              remu         a7, s2, t3
807:              sra          t3, s6, a3
808:              mulhu        t5, s4, a0
809:              sra          s3, t5, t3
810:              sub          s11, t6, t6
811:              mul          a1, a2, s6
812:              divu         gp, s11, s3
813:              sltiu        tp, t6, -1478
814:              sll          a1, s11, a6
815:              beq          t2, s10, 818f
816:              divu         a6, s4, t1
817:              csrrwi       gp, 0x344, 21
818:              csrrw        s2, 0x301, s3
819:              divu         tp, s6, ra
820:              or           t3, tp, s1
821:              csrrwi       a7, 0x301, 21
822:              bge          s10, t0, 836f
823:              addi         s8, s5, 659
824:              nop
825:              or           t0, s4, zero
826:              nop
827:              slt          a2, t2, a3
828:              csrrsi       s6, 0x301, 0
829:              rem          s1, t1, s0
830:              xori         s5, s7, -1206
831:              remu         a7, s1, s7
832:              csrrci       s3, 0x305, 0
833:              sltu         s4, ra, a0
834:              sltiu        tp, s10, -1824
835:              bne          sp, a4, 844f
836:              mulhsu       s10, tp, a1
837:              beq          zero, sp, 840f
838:              csrrsi       t6, 0x304, 25
839:              sll          t5, a6, t3
840:              csrrs        a1, 0x343, zero
841:              and          t4, s3, a0
842:              mulhsu       s6, a3, s3
843:              auipc        ra, 469688
844:              csrrc        s8, 0x305, zero
845:              sll          s5, s4, t1
846:              csrrw        s5, 0x342, s0
847:              mulhsu       zero, s6, sp
848:              xor          t2, s6, s3
849:              xori         s5, s1, -1093
850:              ori          a6, t4, 82
851:              and          s1, t6, s1
852:              csrrci       s0, 0x343, 20
853:              sra          s11, s5, a4
854:              bne          s8, s2, 857f
855:              slt          s1, s9, t5
856:              sra          t0, tp, s5
857:              srai         s1, t1, 5
858:              sltiu        a1, sp, -1084
859:              sltiu        t6, a3, 1277
860:              rem          s9, a4, ra
861:              blt          a5, gp, 874f
862:              beq          sp, s6, 876f
863:              csrrwi       a5, 0x344, 15
864:              mul          ra, s3, s2
865:              srai         s3, s9, 4
866:              div          a4, a6, s5
867:              sra          s0, a3, a0
868:              mulhu        a6, a2, s5
869:              csrrsi       t4, 0x300, 0
870:              csrrc        a4, 0x343, a3
871:              srli         t3, zero, 24
872:              bltu         a7, t5, 883f
873:              csrrw        s10, 0x301, s11
874:              sll          a0, a0, s3
875:              remu         a5, sp, t2
876:              mulhu        a5, a5, ra
877:              nop
878:              mulhu        ra, s3, s3
879:              auipc        t2, 428611
880:              blt          s10, tp, 885f
881:              divu         t5, t4, s2
882:              sltu         s2, s6, a0
883:              slli         s3, s4, 4
884:              bgeu         t6, s5, 894f
885:              div          a1, s7, s8
886:              csrrci       s6, 0x342, 0
887:              blt          tp, sp, 897f
888:              csrrw        a1, 0x304, a1
889:              sltu         s5, t3, s1
890:              auipc        t5, 851782
891:              csrrs        s0, 0x305, zero
892:              bge          s4, s2, 895f
893:              remu         s3, s3, s11
894:              lui          a1, 886167
895:              sll          t2, tp, s0
896:              srli         a7, t1, 19
897:              sll          a5, zero, s6
898:              mulhsu       s0, a5, t1
899:              auipc        s0, 676977
900:              mul          s1, a2, s11
901:              sltiu        a5, t3, -1733
902:              beq          t6, t2, 920f
903:              srli         ra, a1, 24
904:              lui          t1, 734629
905:              csrrs        s6, 0x343, t1
906:              slli         a1, s1, 3
907:              nop
908:              csrrci       t2, 0x343, 15
909:              mul          gp, s3, tp
910:              beq          s1, a2, 918f
911:              xor          a4, t3, s8
912:              xor          s3, ra, t3
913:              remu         tp, a3, s11
914:              csrrwi       t5, 0x304, 27
915:              auipc        a6, 27470
916:              bge          s11, t0, 925f
917:              add          s5, s5, tp
918:              andi         a0, t6, 1716
919:              beq          t1, s4, 930f
920:              mulhu        t1, s8, zero
921:              sltu         a7, t6, t4
922:              ori          ra, zero, 416
923:              slli         s8, s4, 21
924:              bne          a5, t0, 936f
925:              sltiu        t5, t2, 415
926:              mulhu        t4, a3, s5
927:              lui          a2, 573983
928:              mulh         tp, gp, t4
929:              mulh         tp, a3, s8
930:              mulhu        s0, t2, a2
931:              bne          s2, s8, 938f
932:              bgeu         s2, t4, 952f
933:              bgeu         s11, s10, 936f
934:              auipc        ra, 496495
935:              mulh         a2, s6, s2
936:              csrrc        a0, 0x301, a6
937:              auipc        s5, 611300
938:              blt          a0, t1, 956f
939:              sub          a7, t4, s8
940:              csrrc        t5, 0x304, zero
941:              mulhu        a4, t0, s3
942:              mulhu        ra, s9, s11
943:              xor          t2, tp, a5
944:              srl          a1, s9, s7
945:              andi         a7, a5, -320
946:              mul          s8, t3, a4
947:              csrrci       a7, 0x301, 13
948:              and          t5, t0, ra
949:              addi         s1, ra, -1101
950:              mul          s3, s10, s9
951:              auipc        t6, 666944
952:              nop
953:              and          s4, s8, s10
954:              slti         s3, zero, -1769
955:              divu         t3, s6, s6
956:              bne          a7, s9, 957f
957:              nop
958:              mulhu        tp, s0, ra
959:              csrrci       t0, 0x304, 0
960:              bltu         tp, a7, 971f
961:              sub          s3, a2, s5
962:              sltu         s6, a0, ra
963:              sra          s3, ra, a5
964:              andi         s10, a7, 1968
965:              csrrc        a0, 0x301, t5
966:              addi         s9, s5, -1847
967:              srai         a1, t4, 0
968:              csrrs        a1, 0x305, zero
969:              xori         gp, a3, -2010
970:              auipc        s2, 745492
971:              srl          s6, s8, s10
972:              csrrs        s11, 0x344, zero
973:              srli         s9, sp, 17
974:              sltu         a2, s2, s11
975:              bge          sp, a6, 983f
976:              csrrc        t3, 0x301, t6
977:              bne          sp, s1, 981f
978:              xori         a6, s2, -1227
979:              bgeu         s0, a5, 994f
980:              slti         t0, s9, -1900
981:              divu         ra, s4, zero
982:              csrrci       a2, 0x300, 0
983:              and          tp, tp, t4
984:              blt          a6, s10, 988f
985:              sll          zero, tp, s3
986:              add          zero, a0, a0
987:              srli         s9, s1, 24
988:              auipc        t5, 884906
989:              sll          s10, s5, s8
990:              bltu         t1, s10, 994f
991:              csrrci       s6, 0x342, 25
992:              slti         a2, s10, -1104
993:              sltu         a5, t0, s5
994:              bltu         s1, t1, 996f
995:              sub          s2, a5, a1
996:              sltiu        t6, a4, -1408
997:              xori         s10, a7, 183
998:              csrrs        s9, 0x301, zero
999:              mulhu        a1, s10, ra
1000:             srli         s4, ra, 3
1001:             andi         t3, a7, -705
1002:             srai         a0, tp, 24
1003:             srl          a2, s2, s8
1004:             csrrw        zero, 0x344, s1
1005:             mulhsu       zero, t4, s7
1006:             blt          t2, a4, 1007f
1007:             beq          t5, t2, 1010f
1008:             mul          t0, zero, s5
1009:             bne          s11, s1, 1015f
1010:             addi         t2, tp, 1729
1011:             mulh         s3, t3, t6
1012:             mulh         s6, t0, s5
1013:             sra          s11, s1, s0
1014:             csrrci       s1, 0x301, 22
1015:             srai         s3, t0, 2
1016:             srli         t2, s7, 5
1017:             sll          s8, t5, gp
1018:             srl          t6, t3, a4
1019:             div          a0, a7, s4
1020:             csrrw        s2, 0x342, s8
1021:             mulh         t3, a0, t0
1022:             csrrwi       zero, 0x342, 4
1023:             bgeu         t6, a2, 1028f
1024:             srli         s6, a6, 14
1025:             srli         zero, sp, 29
1026:             srl          gp, t6, ra
1027:             and          s0, t0, gp
1028:             div          s5, t4, sp
1029:             rem          s2, ra, a5
1030:             slti         t3, t5, 1505
1031:             rem          a0, s5, a4
1032:             auipc        gp, 283599
1033:             sra          s3, s4, a3
1034:             lui          s8, 934367
1035:             mulhu        zero, gp, tp
1036:             and          a0, a6, t4
1037:             beq          s4, tp, 1045f
1038:             slt          zero, s6, s10
1039:             beq          s0, a0, 1054f
1040:             csrrw        a5, 0x343, s7
1041:             auipc        s0, 761977
1042:             xori         a1, a7, -1083
1043:             or           t3, t5, s4
1044:             bne          t6, a0, 1062f
1045:             srli         a0, t6, 31
1046:             and          t3, t2, t4
1047:             slti         t5, a0, 704
1048:             xor          s1, sp, a5
1049:             bge          s2, s4, 1059f
1050:             csrrw        a7, 0x343, tp
1051:             remu         t3, t1, s0
1052:             beq          ra, a3, 1055f
1053:             srai         s10, s2, 11
1054:             and          s1, tp, a3
1055:             mulhsu       ra, a1, a7
1056:             divu         s2, s3, a3
1057:             div          s4, a4, s11
1058:             beq          s11, gp, 1062f
1059:             srli         t3, s0, 20
1060:             beq          s4, a4, 1067f
1061:             xor          t1, a2, s8
1062:             mul          s0, a0, gp
1063:             div          a6, s1, t1
1064:             beq          t3, a3, 1073f
1065:             blt          a7, s1, 1068f
1066:             remu         a7, a1, tp
1067:             sll          s4, gp, s6
1068:             csrrc        s3, 0x301, zero
1069:             add          t6, s5, a2
1070:             bltu         a7, a7, 1081f
1071:             nop
1072:             csrrw        a5, 0x344, t2
1073:             csrrc        s10, 0x301, zero
1074:             srl          t6, t3, t5
1075:             bgeu         a7, t6, 1095f
1076:             andi         s3, a4, -85
1077:             mulhsu       t4, t3, t2
1078:             csrrc        t0, 0x301, a3
1079:             csrrw        t1, 0x304, s11
1080:             mulh         t2, s10, s7
1081:             sltiu        t2, a4, -563
1082:             slli         a2, sp, 3
1083:             mulh         a6, a7, t0
1084:             nop
1085:             xori         s0, a3, -646
1086:             csrrs        s11, 0x301, zero
1087:             mulhsu       t4, s6, s1
1088:             csrrs        t1, 0x304, s2
1089:             csrrwi       t4, 0x344, 18
1090:             sra          a5, a1, s6
1091:             csrrc        s10, 0x305, zero
1092:             remu         s1, s7, s10
1093:             csrrw        a4, 0x342, t0
1094:             srli         t4, s9, 4
1095:             srl          s3, s9, tp
1096:             sltu         a6, a5, t5
1097:             srl          tp, a3, s10
1098:             div          s0, a5, s10
1099:             bgeu         a1, a3, 1103f
1100:             sll          s3, a4, s7
1101:             bgeu         t5, s9, 1109f
1102:             bgeu         a7, a5, 1113f
1103:             auipc        a2, 325288
1104:             and          s9, s0, s0
1105:             sra          s0, a7, a3
1106:             csrrw        a6, 0x301, s11
1107:             sra          s3, t2, gp
1108:             add          s5, s7, sp
1109:             nop
1110:             bltu         a7, t5, 1120f
1111:             sub          t2, a5, a1
1112:             csrrw        a1, 0x342, s1
1113:             auipc        t0, 909307
1114:             slti         tp, a4, 734
1115:             csrrc        a7, 0x344, zero
1116:             auipc        t3, 694381
1117:             mul          s2, sp, s2
1118:             add          s1, a2, a7
1119:             bgeu         a7, a4, 1120f
1120:             bne          a1, s3, 1123f
1121:             mul          s2, s6, s10
1122:             csrrs        t1, 0x305, zero
1123:             div          s4, t5, s4
1124:             and          t0, zero, s4
1125:             sltu         a1, s9, t1
1126:             or           t5, a1, s0
1127:             srai         t2, a4, 29
1128:             lui          ra, 386931
1129:             sub          zero, a4, s3
1130:             bne          s4, sp, 1132f
1131:             slli         a7, t3, 24
1132:             addi         a2, a1, -1896
1133:             xori         s4, s10, -1130
1134:             auipc        s8, 562207
1135:             sll          a2, t4, t4
1136:             rem          a2, t1, t2
1137:             mulhsu       t4, t2, s0
1138:             bge          s3, tp, 1141f
1139:             srli         t5, t2, 19
1140:             bge          s9, a6, 1154f
1141:             csrrsi       s8, 0x343, 0
1142:             add          a7, a7, a5
1143:             add          a7, a1, t5
1144:             slti         t1, s1, -247
1145:             xori         t4, a5, 395
1146:             sltu         s6, s10, s11
1147:             srai         t6, s7, 19
1148:             csrrs        s11, 0x344, a2
1149:             auipc        s1, 79564
1150:             csrrc        s5, 0x300, zero
1151:             mulhsu       a0, s2, s9
1152:             xor          s5, s8, s2
1153:             srl          tp, a6, s10
1154:             mulhu        s8, a2, s4
1155:             slti         t2, a6, 1586
1156:             srai         a6, tp, 31
1157:             addi         gp, a6, 701
1158:             andi         s3, a1, -820
1159:             lui          t2, 264413
1160:             mulh         t1, gp, t5
1161:             div          s9, gp, t1
1162:             csrrs        s6, 0x343, a6
1163:             mul          s0, s7, gp
1164:             sra          a1, s5, s5
1165:             or           s2, a2, s7
1166:             sra          zero, tp, s3
1167:             csrrwi       s10, 0x344, 19
1168:             rem          tp, s8, t0
1169:             add          gp, s9, a3
1170:             remu         t6, a4, a1
1171:             xor          s8, t5, t2
1172:             slli         s2, zero, 25
1173:             lui          s9, 1002451
1174:             mulhu        ra, a0, zero
1175:             rem          a6, a2, sp
1176:             mulh         t4, t1, a4
1177:             andi         t5, a6, -347
1178:             srl          t6, t4, s9
1179:             remu         s3, a7, a2
1180:             csrrs        zero, 0x304, zero
1181:             addi         t2, t5, 58
1182:             sra          a5, t1, s3
1183:             div          t1, gp, tp
1184:             div          s5, sp, s4
1185:             blt          s7, t6, 1186f
1186:             mulhsu       tp, a6, s0
1187:             csrrw        a6, 0x343, s3
1188:             addi         a7, t1, 474
1189:             csrrci       s8, 0x304, 10
1190:             andi         a4, s10, -866
1191:             beq          a6, s9, 1196f
1192:             mul          zero, a1, gp
1193:             div          s4, a1, a2
1194:             bltu         s9, s6, 1197f
1195:             div          ra, t3, s8
1196:             csrrci       t0, 0x305, 0
1197:             sra          s4, a7, ra
1198:             csrrw        a4, 0x343, s1
1199:             andi         s6, t1, 210
1200:             slt          t0, a5, s7
1201:             auipc        t6, 116111
1202:             bltu         s9, s11, 1208f
1203:             ori          a1, t4, -201
1204:             bgeu         t1, t1, 1217f
1205:             mulh         s10, s3, t6
1206:             blt          ra, s9, 1217f
1207:             csrrw        s11, 0x342, s11
1208:             srl          s0, a2, gp
1209:             csrrwi       a5, 0x342, 29
1210:             csrrsi       t3, 0x305, 0
1211:             nop
1212:             mulh         a4, s9, s4
1213:             csrrwi       s1, 0x343, 6
1214:             bne          a1, s1, 1218f
1215:             srli         s10, s7, 10
1216:             blt          s6, gp, 1221f
1217:             csrrs        a7, 0x300, zero
1218:             lui          t1, 713556
1219:             mulhu        a5, t4, s3
1220:             slti         s0, s5, -1025
1221:             slti         a1, t0, 1110
1222:             mulh         s3, a4, s5
1223:             sll          t2, s9, t5
1224:             slli         s4, s7, 15
1225:             slti         gp, t3, -1015
1226:             mulh         t6, gp, s9
1227:             mulh         s1, a6, a4
1228:             div          gp, s8, t6
1229:             add          a0, t5, s4
1230:             sltu         s4, ra, s0
1231:             add          s11, s6, s10
1232:             slt          s9, a6, a2
1233:             bltu         gp, a4, 1251f
1234:             csrrw        s11, 0x344, a6
1235:             srai         a7, s2, 19
1236:             srl          a0, s4, s3
1237:             and          a4, a2, s1
1238:             sra          t1, t6, a0
1239:             divu         t2, s7, s4
1240:             rem          t5, s0, s1
1241:             xori         a0, a7, -575
1242:             bge          s2, a0, 1254f
1243:             srl          s4, s5, a5
1244:             csrrwi       t1, 0x343, 24
1245:             nop
1246:             sltiu        t3, a4, -27
1247:             mulh         tp, s4, s9
1248:             nop
1249:             bne          ra, gp, 1252f
1250:             or           t2, s3, a3
1251:             srai         s0, a4, 14
1252:             andi         t1, sp, 1703
1253:             csrrs        a0, 0x301, t3
1254:             or           s2, a4, a7
1255:             csrrw        t4, 0x301, t2
1256:             csrrw        s9, 0x342, gp
1257:             slti         a2, a0, -425
1258:             lui          t4, 624010
1259:             csrrsi       t6, 0x305, 0
1260:             sub          s8, a6, ra
1261:             divu         s0, t5, gp
1262:             sub          a2, s8, t4
1263:             lui          t4, 756835
1264:             bne          zero, t1, 1275f
1265:             beq          a4, a7, 1279f
1266:             sll          s6, a2, tp
1267:             slt          s5, s10, s5
1268:             csrrw        t3, 0x344, s10
1269:             csrrw        s3, 0x344, s5
1270:             srli         tp, a3, 16
1271:             mulh         s6, s1, s6
1272:             xori         s10, s9, 503
1273:             sltiu        a0, a5, -1361
1274:             mul          a2, sp, a7
1275:             andi         a1, s5, 498
1276:             or           tp, s5, a2
1277:             auipc        zero, 732338
1278:             sltu         a7, s0, gp
1279:             mul          a0, s9, s2
1280:             mulh         a6, ra, a3
1281:             blt          a6, t0, 1296f
1282:             sltu         s2, a5, ra
1283:             csrrw        t4, 0x301, tp
1284:             bge          a2, t2, 1294f
1285:             beq          t0, zero, 1290f
1286:             lui          t0, 784572
1287:             mulhu        a5, s9, t0
1288:             srl          t5, s9, s6
1289:             csrrc        t1, 0x343, zero
1290:             mulh         s9, t4, a1
1291:             mulhu        t2, s6, a3
1292:             xor          a2, s5, a1
1293:             sltu         a7, t1, a7
1294:             or           t2, t2, a7
1295:             lui          t0, 321002
1296:             mulhsu       a1, s4, s5
1297:             slti         a4, zero, 195
1298:             slt          s1, a4, a6
1299:             csrrci       a4, 0x344, 5
1300:             mulhu        t2, s5, a6
1301:             xor          s10, s1, a1
1302:             sra          a6, t4, s3
1303:             mulh         s8, t3, s11
1304:             andi         t4, a7, -1527
1305:             mulh         t1, s10, s3
1306:             mulhsu       a6, tp, ra
1307:             xori         s6, t1, 864
1308:             csrrc        s10, 0x342, a5
1309:             bge          a3, a5, 1316f
1310:             beq          s3, ra, 1323f
1311:             nop
1312:             csrrsi       a0, 0x300, 0
1313:             blt          s10, s5, 1333f
1314:             or           t2, s7, tp
1315:             srai         s1, a4, 9
1316:             slt          s2, s9, s9
1317:             add          s11, s8, a2
1318:             div          s9, a1, s1
1319:             auipc        t2, 1031700
1320:             beq          a0, sp, 1321f
1321:             csrrsi       tp, 0x342, 21
1322:             bgeu         a0, s1, 1323f
1323:             slli         s6, t1, 3
1324:             bgeu         s7, s9, 1327f
1325:             mul          a1, s4, s11
1326:             nop
1327:             addi         tp, tp, -611
1328:             csrrci       t3, 0x304, 16
1329:             csrrci       t5, 0x343, 0
1330:             mulhu        s11, t5, s0
1331:             andi         a0, t6, -249
1332:             andi         ra, s3, -18
1333:             and          a2, a6, t2
1334:             srl          s11, a7, sp
1335:             csrrci       t5, 0x305, 0
1336:             slt          s8, s1, s5
1337:             ori          s9, gp, -1590
1338:             ori          s11, s11, -1289
1339:             or           ra, gp, a7
1340:             csrrs        a6, 0x305, zero
1341:             csrrwi       s3, 0x342, 26
1342:             sltiu        tp, s3, 1674
1343:             bgeu         a5, s5, 1345f
1344:             slli         gp, s5, 30
1345:             mulhu        t6, a1, tp
1346:             srl          s0, a1, t0
1347:             sra          s1, s4, s5
1348:             srai         s0, t5, 18
1349:             or           t2, s9, a1
1350:             mulh         s4, s10, sp
1351:             bne          t2, t3, 1369f
1352:             bge          s2, t0, 1363f
1353:             remu         a7, sp, a5
1354:             bge          a3, s9, 1358f
1355:             sub          s11, t0, s5
1356:             slli         a0, t0, 10
1357:             sll          s10, tp, t4
1358:             bge          t3, s4, 1361f
1359:             bgeu         s1, a0, 1367f
1360:             srli         s1, s7, 11
1361:             xori         s6, t3, 1093
1362:             divu         s2, s0, t0
1363:             xori         s9, gp, 1080
1364:             divu         s6, a7, t6
1365:             div          a7, t3, s6
1366:             srai         t3, sp, 3
1367:             csrrw        s8, 0x343, s0
1368:             mulhu        t3, ra, a5
1369:             sll          a1, tp, s4
1370:             srai         s2, t1, 2
1371:             csrrw        a7, 0x344, t1
1372:             or           tp, s3, s3
1373:             andi         ra, s3, -2041
1374:             mul          tp, s7, ra
1375:             lui          t6, 231878
1376:             csrrwi       t0, 0x343, 14
1377:             csrrs        s0, 0x300, zero
1378:             sll          a0, s6, ra
1379:             lui          t3, 398474
1380:             sll          gp, zero, a6
1381:             ori          t4, s7, 164
1382:             and          s4, ra, sp
1383:             lui          zero, 530113
1384:             srli         s9, t3, 18
1385:             ori          s0, s6, -503
1386:             andi         s8, t5, -1270
1387:             blt          s5, ra, 1398f
1388:             bgeu         t5, a2, 1391f
1389:             blt          s7, a7, 1398f
1390:             andi         a6, ra, -1679
1391:             addi         a5, s7, 1274
1392:             srli         s2, a1, 13
1393:             bge          s2, t1, 1411f
1394:             srai         s4, zero, 24
1395:             lui          tp, 340920
1396:             csrrs        a4, 0x304, a7
1397:             auipc        a4, 247415
1398:             mul          s9, s0, a5
1399:             bgeu         sp, s1, 1403f
1400:             lui          a0, 204397
1401:             sltu         a6, s9, s2
1402:             csrrwi       t0, 0x343, 6
1403:             remu         s5, s8, s6
1404:             andi         a1, s5, 1025
1405:             csrrwi       t2, 0x343, 12
1406:             csrrs        t3, 0x305, zero
1407:             lui          s10, 484415
1408:             add          a0, sp, s4
1409:             auipc        s3, 632113
1410:             srl          a1, s11, a5
1411:             ori          ra, a7, 430
1412:             mulhsu       t1, s10, a3
1413:             csrrwi       t6, 0x301, 12
1414:             rem          a2, s0, a3
1415:             add          gp, s4, a6
1416:             andi         gp, s0, 1030
1417:             div          a1, s7, a2
1418:             sltu         t6, t0, tp
1419:             srli         ra, tp, 27
1420:             srai         s8, tp, 7
1421:             or           a6, a3, s11
1422:             or           a5, s10, t3
1423:             slt          s0, a1, a6
1424:             slti         s11, a1, -452
1425:             mulhu        a1, s0, tp
1426:             blt          s6, t1, 1432f
1427:             csrrw        s9, 0x343, a1
1428:             sltu         s8, a6, a1
1429:             mulhsu       tp, t6, t3
1430:             csrrsi       s3, 0x301, 30
1431:             slti         t5, sp, -1986
1432:             div          s5, a4, a3
1433:             slti         a0, s7, 151
1434:             auipc        s3, 838244
1435:             srl          a4, t6, t6
1436:             auipc        s4, 410220
1437:             bne          s8, s8, 1442f
1438:             andi         ra, s7, 337
1439:             mulh         s6, a5, t4
1440:             sltu         s6, a4, s11
1441:             csrrwi       a2, 0x344, 6
1442:             sltiu        t5, a2, 586
1443:             mulhsu       a7, ra, s1
1444:             csrrc        gp, 0x304, zero
1445:             add          s3, s6, t3
1446:             and          a1, a0, gp
1447:             sltiu        t0, t1, -1170
1448:             bltu         a6, s5, 1452f
1449:             and          s8, t4, s7
1450:             mulhsu       s10, a1, s7
1451:             blt          a5, a2, 1461f
1452:             auipc        t2, 999927
1453:             srai         s1, s6, 29
1454:             slt          a0, s4, s3
1455:             rem          s4, s11, s11
1456:             sra          gp, s1, a5
1457:             slli         t4, s9, 28
1458:             or           t3, s9, s0
1459:             slti         a6, s9, 1244
1460:             slti         s5, tp, 311
1461:             sltu         t0, a3, a0
1462:             blt          zero, t3, 1474f
1463:             xori         a2, a0, 848
1464:             addi         t6, t4, 1469
1465:             nop
1466:             add          a4, s3, t0
1467:             sub          t1, t2, s4
1468:             add          t1, s9, a6
1469:             div          s1, a6, t2
1470:             and          t5, sp, t3
1471:             slt          s8, s9, a2
1472:             csrrw        a5, 0x342, s9
1473:             mulhsu       t6, gp, t2
1474:             csrrsi       a1, 0x342, 3
1475:             auipc        t0, 749035
1476:             divu         s11, s6, t2
1477:             addi         a7, s6, -1989
1478:             mul          t5, a7, ra
1479:             sll          a5, a5, ra
1480:             csrrc        s10, 0x343, a7
1481:             sltiu        s5, s11, -235
1482:             beq          s8, s7, 1490f
1483:             csrrw        s4, 0x304, a3
1484:             sub          s10, a2, a4
1485:             xori         a4, a2, 1875
1486:             csrrwi       s5, 0x301, 25
1487:             csrrci       s5, 0x304, 0
1488:             xori         ra, a4, 269
1489:             slli         a4, a0, 27
1490:             bgeu         tp, a7, 1493f
1491:             csrrc        a0, 0x305, zero
1492:             add          s11, a4, a4
1493:             csrrci       zero, 0x343, 16
1494:             srai         s9, t3, 22
1495:             sub          zero, s5, s1
1496:             csrrw        s5, 0x343, a7
1497:             mul          s1, t3, s6
1498:             slli         s10, s2, 7
1499:             bltu         s2, a3, 1507f
1500:             or           s3, s4, t3
1501:             srli         a4, s10, 19
1502:             csrrs        a4, 0x305, zero
1503:             bge          s11, zero, 1508f
1504:             andi         t6, t2, -1337
1505:             csrrs        a1, 0x342, s2
1506:             mulhu        ra, s4, tp
1507:             mulhu        a0, tp, zero
1508:             csrrs        s9, 0x300, zero
1509:             sll          s6, s9, s9
1510:             csrrc        t3, 0x342, sp
1511:             bne          a6, s4, 1521f
1512:             div          t4, a4, t6
1513:             addi         tp, zero, -216
1514:             slti         ra, sp, 1258
1515:             sltiu        gp, s1, 1286
1516:             csrrci       s9, 0x300, 0
1517:             divu         a5, s6, s0
1518:             nop
1519:             csrrc        s6, 0x342, zero
1520:             and          ra, a6, s10
1521:             andi         zero, s8, 1124
1522:             blt          s9, sp, 1526f
1523:             rem          s1, t0, a5
1524:             csrrci       ra, 0x305, 0
1525:             csrrs        a4, 0x305, zero
1526:             rem          a5, a7, t4
1527:             srli         t3, s6, 16
1528:             mulhu        a1, gp, tp
1529:             sra          a6, s8, ra
1530:             and          t0, s9, s1
1531:             sltu         zero, s0, a0
1532:             auipc        zero, 145041
1533:             divu         t0, s1, tp
1534:             xor          s6, t0, a7
1535:             andi         a7, s3, 1407
1536:             sra          s2, ra, a2
1537:             mulhsu       a5, s6, t3
1538:             csrrsi       a7, 0x300, 0
1539:             sll          a2, a0, a4
1540:             srl          s1, s8, s3
1541:             div          s4, ra, s0
1542:             xor          t0, a2, t6
1543:             slt          a5, sp, a0
1544:             remu         t4, s1, a1
1545:             blt          a0, zero, 1556f
1546:             xori         s9, s6, 1605
1547:             addi         a7, a7, -1286
1548:             lui          s0, 441193
1549:             slli         t4, t0, 2
1550:             andi         s6, ra, -1741
1551:             mulh         t6, t0, a0
1552:             andi         t6, a3, -131
1553:             nop
1554:             mul          a4, s11, a7
1555:             slt          s5, t0, a3
1556:             bge          s1, a3, 1565f
1557:             slti         a1, a0, 1123
1558:             beq          t6, ra, 1561f
1559:             mulhsu       a4, t6, s11
1560:             nop
1561:             mulhu        tp, ra, sp
1562:             blt          t2, s11, 1566f
1563:             add          s11, t2, s2
1564:             auipc        gp, 827162
1565:             divu         s2, s10, a5
1566:             beq          a6, a3, 1577f
1567:             lui          t5, 590387
1568:             csrrci       s0, 0x305, 0
1569:             nop
1570:             xori         a4, t0, 1993
1571:             slti         s10, a6, 1991
1572:             bltu         s6, s9, 1587f
1573:             addi         s3, t3, 900
1574:             srli         s8, s1, 11
1575:             mulhsu       a4, t1, tp
1576:             srli         s11, a2, 17
1577:             bgeu         s5, zero, 1582f
1578:             addi         s3, s8, 225
1579:             csrrci       s5, 0x301, 0
1580:             rem          s0, t5, s7
1581:             csrrci       a4, 0x304, 15
1582:             rem          a7, a5, ra
1583:             xori         a7, a4, -1150
1584:             srl          t4, a0, s11
1585:             mulhsu       s5, s11, t2
1586:             div          a4, a2, ra
1587:             csrrsi       t5, 0x343, 0
1588:             blt          a6, s11, 1599f
1589:             srl          t4, a5, s3
1590:             slli         tp, s3, 4
1591:             andi         t1, sp, 1329
1592:             slti         s8, a0, -151
1593:             sltiu        s0, s6, 853
1594:             srai         s9, s3, 14
1595:             blt          s6, a1, 1615f
1596:             add          s1, a4, a2
1597:             auipc        s3, 1020120
1598:             sra          tp, s7, ra
1599:             slli         s9, a0, 7
1600:             bne          a0, gp, 1614f
1601:             xor          t3, t5, s5
1602:             ori          tp, ra, 1083
1603:             divu         s3, s11, s6
1604:             sltiu        a7, sp, -18
1605:             nop
1606:             sra          s11, zero, tp
1607:             bltu         gp, gp, 1619f
1608:             sll          s4, s9, t3
1609:             or           a1, t6, a2
1610:             or           t2, s9, t3
1611:             beq          s9, s11, 1624f
1612:             csrrwi       a7, 0x301, 24
1613:             mulhsu       zero, s4, a6
1614:             mul          s5, tp, t5
1615:             and          a5, a2, a7
1616:             and          s3, zero, s9
1617:             bgeu         a5, s6, 1624f
1618:             csrrci       s10, 0x301, 1
1619:             beq          sp, t6, 1620f
1620:             mulhsu       a7, s1, a6
1621:             beq          s0, a0, 1625f
1622:             ori          ra, s9, -1656
1623:             csrrw        tp, 0x342, s3
1624:             srl          s1, s1, s10
1625:             srli         s9, s10, 22
1626:             div          a2, sp, t6
1627:             or           zero, s4, sp
1628:             bgeu         a2, s0, 1631f
1629:             nop
1630:             sra          s0, s0, s5
1631:             mul          a7, t5, t2
1632:             or           s10, s6, ra
1633:             and          gp, s4, t0
1634:             bltu         s11, s5, 1637f
1635:             rem          s8, t2, s2
1636:             mulhu        s6, ra, s6
1637:             andi         a6, a0, 1398
1638:             sltu         t4, s0, s9
1639:             sub          s1, t1, t6
1640:             auipc        a7, 191502
1641:             xori         t4, a5, -79
1642:             srai         t1, s3, 18
1643:             slti         t5, t3, 204
1644:             csrrw        s2, 0x304, sp
1645:             csrrs        t3, 0x343, zero
1646:             srl          s0, t0, ra
1647:             div          a5, t6, tp
1648:             csrrw        s4, 0x344, sp
1649:             sra          t4, a2, s8
1650:             bne          s2, a3, 1656f
1651:             beq          s2, t0, 1654f
1652:             bltu         tp, s1, 1662f
1653:             xor          t1, a2, s11
1654:             beq          a3, s1, 1656f
1655:             mul          s10, tp, s4
1656:             addi         a2, ra, 516
1657:             nop
1658:             csrrsi       s2, 0x301, 0
1659:             bgeu         t6, t5, 1662f
1660:             add          t6, s7, t3
1661:             sub          s1, gp, ra
1662:             ori          a1, t1, -1769
1663:             slt          a4, s6, a6
1664:             sltu         s10, a0, t4
1665:             beq          a0, sp, 1673f
1666:             div          a5, zero, t6
1667:             add          t5, a5, a3
1668:             sll          a5, a5, t5
1669:             slti         t0, s9, 1832
1670:             bne          a0, zero, 1688f
1671:             nop
1672:             srl          t6, t6, gp
1673:             bgeu         s10, sp, 1691f
1674:             nop
1675:             rem          tp, s0, zero
1676:             nop
1677:             rem          a2, a2, s2
1678:             andi         a0, zero, 318
1679:             csrrsi       t0, 0x304, 24
1680:             sll          s4, a1, tp
1681:             rem          t3, a0, a7
1682:             div          s4, s3, t5
1683:             bne          a4, s7, 1684f
1684:             csrrwi       a6, 0x343, 9
1685:             add          a4, a4, a5
1686:             slli         a0, sp, 24
1687:             andi         t3, zero, -427
1688:             slt          s6, a6, s6
1689:             divu         t0, gp, s2
1690:             div          s11, s8, s2
1691:             csrrsi       s0, 0x342, 16
1692:             divu         t3, gp, s6
1693:             lui          s10, 931404
1694:             mul          zero, s11, s0
1695:             csrrwi       tp, 0x343, 11
1696:             csrrw        a0, 0x343, s5
1697:             csrrsi       s8, 0x301, 0
1698:             or           a7, t0, t0
1699:             remu         s5, s4, s9
1700:             divu         t5, zero, t1
1701:             and          s10, s10, s4
1702:             srai         s4, t6, 11
1703:             slti         s8, a5, -33
1704:             or           t6, t4, ra
1705:             csrrsi       a1, 0x342, 0
1706:             bltu         t6, t2, 1717f
1707:             div          s3, a6, s4
1708:             ori          s1, t3, -246
1709:             and          s8, a7, a2
1710:             srai         a5, s9, 9
1711:             beq          t4, a3, 1712f
1712:             slti         s1, tp, -1307
1713:             or           a5, a2, t5
1714:             slli         t5, t3, 11
1715:             sra          a1, t0, a2
1716:             csrrw        s2, 0x342, ra
1717:             auipc        s8, 25057
1718:             addi         a0, s9, 882
1719:             csrrci       s1, 0x300, 0
1720:             and          s10, s11, s11
1721:             add          gp, a3, a1
1722:             xor          tp, a7, s10
1723:             slti         a6, gp, 2039
1724:             div          s10, ra, a2
1725:             add          tp, s10, zero
1726:             csrrs        s1, 0x301, s1
1727:             andi         t3, t4, 884
1728:             xor          a0, s2, s10
1729:             srl          s6, a3, s11
1730:             csrrw        s2, 0x304, t5
1731:             ori          a1, zero, -1652
1732:             xor          t6, s0, s4
1733:             ori          t5, sp, -1285
1734:             andi         s9, s4, -1214
1735:             slli         s10, t1, 25
1736:             srli         ra, t1, 16
1737:             div          s5, s8, t5
1738:             mulhu        s11, a2, s10
1739:             bltu         a6, sp, 1747f
1740:             or           a7, s10, tp
1741:             mul          a5, sp, s2
1742:             remu         s5, a3, s10
1743:             csrrc        t5, 0x342, zero
1744:             srli         s2, t3, 29
1745:             csrrwi       s8, 0x304, 22
1746:             auipc        a1, 237306
1747:             csrrci       s4, 0x342, 7
1748:             divu         t3, a4, a5
1749:             xor          gp, gp, ra
1750:             csrrci       s5, 0x305, 0
1751:             xor          t1, s8, a1
1752:             mulhsu       a1, s2, t0
1753:             sub          t6, ra, t0
1754:             csrrw        s2, 0x343, t4
1755:             csrrw        s5, 0x343, s8
1756:             csrrwi       s5, 0x342, 0
1757:             lui          s1, 590684
1758:             csrrci       s3, 0x342, 17
1759:             csrrci       a2, 0x305, 0
1760:             bne          s0, gp, 1763f
1761:             or           a0, zero, s7
1762:             sltu         a6, t2, t3
1763:             lui          a0, 973496
1764:             srli         s9, s9, 1
1765:             addi         t3, a3, 791
1766:             csrrci       s2, 0x305, 0
1767:             srl          zero, s2, sp
1768:             sra          t4, a3, s8
1769:             divu         s0, s3, a4
1770:             csrrsi       t6, 0x342, 20
1771:             rem          t0, t0, zero
1772:             remu         a0, s1, a4
1773:             bltu         a7, a1, 1785f
1774:             sub          a0, a6, gp
1775:             rem          a6, a1, s9
1776:             andi         s2, zero, -1593
1777:             div          s0, ra, s11
1778:             xori         t6, tp, 1839
1779:             ori          a7, a7, 1447
1780:             ori          zero, t3, 1797
1781:             xor          a5, t6, s9
1782:             slt          a2, t6, a6
1783:             blt          sp, t2, 1786f
1784:             remu         gp, t6, s6
1785:             addi         a4, a0, 509
1786:             csrrw        s4, 0x343, gp
1787:             slli         s5, t4, 29
1788:             auipc        t4, 925037
1789:             csrrwi       s10, 0x343, 22
1790:             srl          t6, a7, sp
1791:             lui          s2, 496417
1792:             csrrs        s8, 0x304, zero
1793:             bne          ra, t5, 1796f
1794:             xor          s1, s9, gp
1795:             bne          t2, t3, 1797f
1796:             remu         s9, t6, s9
1797:             mulh         ra, a7, t0
1798:             andi         a7, s1, -1393
1799:             csrrsi       t6, 0x304, 0
1800:             sra          s6, s0, sp
1801:             mulhu        a7, s2, s1
1802:             csrrsi       a1, 0x342, 22
1803:             sub          gp, s9, s3
1804:             sra          t4, t4, s10
1805:             sra          t6, s8, tp
1806:             csrrs        s3, 0x304, zero
1807:             srli         t4, t1, 28
1808:             slli         tp, a3, 25
1809:             ori          t3, s9, -387
1810:             mulhsu       s1, s5, gp
1811:             sltu         a5, s0, a2
1812:             or           a0, t0, s10
1813:             rem          a7, gp, t4
1814:             nop
1815:             andi         a5, sp, 1426
1816:             srl          a4, ra, s2
1817:             csrrci       t4, 0x343, 22
1818:             csrrci       t5, 0x301, 0
1819:             csrrsi       t1, 0x305, 0
1820:             csrrc        tp, 0x342, ra
1821:             auipc        t6, 761880
1822:             sll          t1, sp, t0
1823:             divu         s1, t4, t0
1824:             remu         t1, t0, s4
1825:             mulhu        s3, t1, s8
1826:             ori          t3, t5, -1142
1827:             mul          a6, a5, t3
1828:             sll          s1, s8, a0
1829:             add          s2, s6, s1
1830:             sra          a0, s2, s0
1831:             rem          t4, s4, gp
1832:             sra          a2, tp, s5
1833:             xor          tp, t3, a6
1834:             mul          t3, ra, t3
1835:             csrrc        t0, 0x342, zero
1836:             auipc        s9, 226188
1837:             lui          a6, 701308
1838:             csrrci       s9, 0x343, 22
1839:             sll          s8, s6, s0
1840:             mulh         s10, s2, s0
1841:             mulh         zero, s5, s5
1842:             divu         s2, s11, a7
1843:             divu         s11, s10, s7
1844:             sra          s10, t4, s11
1845:             ori          t3, t6, -1026
1846:             beq          t5, a1, 1850f
1847:             mulh         t3, s1, s1
1848:             csrrci       t2, 0x342, 2
1849:             bltu         s7, s2, 1867f
1850:             bne          s5, t6, 1859f
1851:             sltu         s2, t6, a2
1852:             srl          s6, s1, gp
1853:             and          a1, ra, a5
1854:             csrrsi       t3, 0x301, 0
1855:             srai         t1, s10, 3
1856:             sra          s0, a4, s2
1857:             mulhsu       s0, t5, s1
1858:             sll          s1, zero, t5
1859:             mulh         s3, sp, s6
1860:             srai         gp, t6, 25
1861:             sltiu        s6, a3, -379
1862:             sltiu        zero, s6, 698
1863:             srai         s1, s5, 3
1864:             auipc        t0, 684938
1865:             blt          t2, tp, 1876f
1866:             divu         s8, s9, s11
1867:             bltu         s5, t4, 1882f
1868:             addi         a5, t6, -634
1869:             blt          s2, s11, 1872f
1870:             srli         s11, gp, 26
1871:             rem          a7, s0, s4
1872:             srai         t3, t0, 6
1873:             rem          zero, s2, s5
1874:             nop
1875:             srai         zero, a3, 19
1876:             bne          a4, s7, 1881f
1877:             div          s11, a1, s6
1878:             srl          tp, s7, t1
1879:             sltiu        t1, t0, 1122
1880:             blt          t5, tp, 1891f
1881:             mulhu        t1, t1, s2
1882:             and          s5, t6, a3
1883:             slli         a7, a1, 24
1884:             remu         s2, s4, s2
1885:             bgeu         t3, a6, 1889f
1886:             mulh         a4, a5, t0
1887:             srl          s4, s0, s0
1888:             slli         a1, t4, 26
1889:             srl          s0, s8, t0
1890:             csrrci       s3, 0x342, 18
1891:             nop
1892:             add          s11, s7, a2
1893:             ori          s2, t4, -1242
1894:             csrrci       ra, 0x301, 7
1895:             nop
1896:             nop
1897:             slli         zero, s3, 27
1898:             divu         s5, s11, a1
1899:             srai         s3, s9, 10
1900:             nop
1901:             or           s1, t2, s11
1902:             xori         a1, sp, 1045
1903:             bltu         a1, s9, 1910f
1904:             bltu         a3, s6, 1918f
1905:             csrrc        t5, 0x344, zero
1906:             csrrc        t2, 0x342, a5
1907:             mulhsu       ra, a6, a6
1908:             srli         tp, t4, 11
1909:             srai         a5, a6, 8
1910:             csrrw        s10, 0x344, s4
1911:             ori          a5, tp, -955
1912:             csrrwi       s1, 0x304, 13
1913:             csrrci       a6, 0x300, 0
1914:             sub          t3, t2, s8
1915:             and          s9, gp, s4
1916:             beq          tp, a4, 1917f
1917:             mulh         s0, s7, sp
1918:             and          s8, s11, s2
1919:             sltiu        s3, t4, 909
1920:             xor          s4, t3, ra
1921:             and          s9, a7, a2
1922:             ori          a4, t4, -392
1923:             mulh         ra, s9, s2
1924:             rem          s9, s6, gp
1925:             bltu         s5, t5, 1930f
1926:             sub          t4, t5, a5
1927:             sltu         a1, zero, t4
1928:             mulhu        s6, a3, s11
1929:             csrrs        a5, 0x344, a7
1930:             mul          zero, zero, t2
1931:             mulh         t2, zero, a7
1932:             auipc        a5, 1046977
1933:             mulh         tp, a3, a4
1934:             auipc        s9, 113798
1935:             xori         t2, sp, -462
1936:             mulh         s2, s9, s8
1937:             slli         a6, t4, 7
1938:             sltu         s10, s3, t1
1939:             csrrw        t1, 0x304, s2
1940:             beq          s10, t6, 1958f
                  la           t4, region_1+37887 #start riscv_hazard_instr_stream_0
                  lbu          ra, 68(t4)
                  lh           t2, -51(t4)
                  lbu          s1, 68(t4)
                  sb           s4, -216(t4)
                  rem          s5, t2, s4
                  divu         s5, a4, s1
                  lb           s5, -62(t4)
                  sb           a4, -148(t4)
                  lb           s4, 131(t4)
                  sll          s1, t2, s1
                  lb           ra, 51(t4)
                  sb           t2, -4(t4)
                  lui          s5, 989737
                  or           t2, s1, s4
                  lb           t2, 115(t4)
                  slti         s1, s5, -907
                  sra          s1, s1, s4
                  srli         a4, t2, 24
                  mulhsu       t2, s5, s4
                  lh           s1, 65(t4)
                  sw           s5, 137(t4)
                  lb           ra, -221(t4)
                  ori          t2, s1, 1863
                  ori          s4, s5, -288
                  lui          ra, 454155
                  lb           ra, -42(t4) #end riscv_hazard_instr_stream_0
1941:             blt          ra, gp, 1951f
1942:             csrrci       a1, 0x300, 0
1943:             slt          s4, a1, a3
1944:             slti         a2, s3, 1956
1945:             addi         s1, t6, -69
1946:             sra          s2, s10, ra
1947:             or           ra, s1, s4
1948:             mulh         s8, t0, gp
1949:             csrrw        a0, 0x304, a4
1950:             bge          s1, a1, 1956f
1951:             slti         ra, a0, -1736
1952:             sll          gp, t4, s5
1953:             sll          a0, a1, a3
1954:             beq          ra, s2, 1974f
1955:             sub          gp, a5, zero
1956:             sltu         s6, a5, t0
1957:             and          s0, tp, a1
1958:             sll          s4, s3, a6
1959:             ori          s4, a1, 1276
1960:             slli         s11, a5, 25
1961:             mulhsu       t6, t4, s7
1962:             srli         ra, s6, 29
1963:             sltiu        s2, t1, -1560
1964:             lui          s0, 32583
1965:             bne          t2, a5, 1975f
1966:             mulh         a7, a2, tp
1967:             xor          s5, a3, t4
1968:             mul          t0, t0, t6
1969:             ori          s4, a1, 1886
1970:             sra          t5, s7, t6
1971:             sll          t2, a0, tp
1972:             srai         t3, a5, 24
1973:             divu         a1, t2, s7
1974:             sub          tp, sp, t2
1975:             add          gp, a7, a2
1976:             srli         s5, s10, 17
1977:             sub          s10, t0, ra
1978:             blt          s7, a6, 1982f
1979:             addi         s4, t3, 1467
1980:             mulhsu       s2, s10, s10
1981:             andi         s5, s9, 1525
1982:             mul          a6, s5, s0
1983:             rem          t2, s3, s9
1984:             nop
1985:             sub          t2, s11, a3
1986:             beq          t0, s5, 1994f
1987:             sll          s1, s6, sp
1988:             sltiu        a5, a7, -267
1989:             mul          tp, a2, zero
1990:             srl          s6, a0, a7
1991:             divu         zero, s7, a2
1992:             blt          s10, s11, 2005f
1993:             xor          t5, s6, t3
1994:             sll          a6, a7, ra
1995:             sltiu        a4, a1, -87
1996:             lui          s6, 746658
1997:             csrrw        s0, 0x304, t3
1998:             beq          a2, sp, 2001f
1999:             bge          s6, t3, 2004f
2000:             ori          a2, gp, -2035
2001:             andi         s0, s10, -1170
2002:             bne          s2, t5, 2016f
2003:             add          t1, t4, a4
2004:             bgeu         a2, t2, 2024f
2005:             sra          s1, a3, zero
2006:             csrrs        s1, 0x305, zero
2007:             csrrs        a6, 0x301, zero
2008:             csrrwi       a2, 0x344, 3
2009:             srai         a1, tp, 19
2010:             sub          a0, s8, s2
2011:             sub          t1, s11, t5
2012:             bge          s5, t3, 2021f
2013:             csrrc        a5, 0x300, zero
2014:             mulh         zero, s4, t1
2015:             andi         s10, a2, -2028
2016:             lui          t5, 904513
2017:             sltu         s2, a6, s10
2018:             blt          gp, a4, 2036f
2019:             srli         a2, ra, 22
2020:             or           tp, tp, a4
2021:             or           zero, t5, s5
2022:             auipc        s3, 187690
2023:             sll          s8, s6, a2
2024:             remu         tp, t4, a3
2025:             lui          a0, 828725
2026:             csrrw        s4, 0x342, a7
2027:             remu         t3, a3, t0
2028:             srl          gp, t2, s10
2029:             addi         s11, a0, -965
2030:             csrrs        s8, 0x342, tp
2031:             or           s5, t4, a2
2032:             sll          a1, s5, s5
2033:             ori          a7, tp, -1313
2034:             ori          t5, a1, -191
2035:             beq          a7, s3, 2047f
2036:             or           a0, a6, s4
2037:             sltiu        t2, t4, -1602
2038:             xori         t5, s7, 712
2039:             divu         t1, t1, a6
2040:             bne          sp, t4, 2044f
2041:             xor          s6, gp, a5
2042:             csrrci       s10, 0x344, 0
2043:             csrrs        a0, 0x342, zero
2044:             bne          a7, tp, 2052f
2045:             csrrwi       gp, 0x343, 23
2046:             add          a7, a5, s0
2047:             sub          a0, tp, t3
2048:             andi         s8, s10, 1581
2049:             csrrs        s6, 0x344, a0
2050:             mul          gp, s5, a6
2051:             xor          t4, s6, a5
2052:             slt          s9, a2, s8
2053:             sltiu        s8, t3, 1645
2054:             bgeu         a5, t5, 2064f
2055:             mulh         a7, s3, a3
2056:             bne          ra, s7, 2060f
2057:             mulhu        s11, ra, t3
2058:             mulhu        t4, gp, sp
2059:             add          s1, ra, s9
2060:             csrrc        t2, 0x344, s8
2061:             divu         t4, s7, a5
2062:             csrrw        t2, 0x344, t1
2063:             srai         t1, t0, 11
2064:             slli         t6, gp, 11
2065:             csrrsi       s11, 0x301, 0
2066:             slt          s9, a0, t4
2067:             srl          s8, s6, t6
2068:             and          t4, s9, s2
2069:             bltu         s7, s7, 2080f
2070:             mulhu        s3, a0, a0
2071:             remu         s2, s0, s9
2072:             csrrwi       t5, 0x342, 22
2073:             csrrc        s8, 0x342, gp
2074:             and          s5, t1, t1
2075:             nop
2076:             andi         s10, s1, 1943
2077:             mulh         t3, a3, t6
2078:             mulhu        tp, s9, t0
2079:             and          a5, zero, s2
2080:             mulh         a0, a4, s8
2081:             sltiu        s5, zero, -586
2082:             srai         gp, gp, 19
2083:             srli         a1, s4, 29
2084:             bne          a5, a1, 2102f
2085:             csrrw        gp, 0x343, a7
2086:             sll          t4, s4, a1
2087:             slt          a1, s6, s4
2088:             divu         ra, t6, s10
2089:             rem          s5, s9, s4
2090:             xori         s8, t4, 982
2091:             or           s2, t3, zero
2092:             ori          s3, t4, -631
2093:             slt          ra, s5, t4
2094:             sra          t1, s1, a1
2095:             beq          s7, s7, 2098f
2096:             slli         a0, s2, 17
2097:             csrrci       gp, 0x304, 0
2098:             slt          s1, t3, t3
2099:             sub          a4, a5, s10
2100:             and          s6, s6, s3
2101:             sll          s2, ra, a3
2102:             rem          s1, s9, a3
2103:             div          t2, a0, s6
2104:             divu         t6, s0, a4
2105:             bgeu         s6, a7, 2106f
2106:             sltiu        a6, a6, -1624
2107:             csrrci       a6, 0x300, 0
2108:             auipc        t0, 237345
2109:             sltiu        s1, tp, 1886
2110:             lui          s3, 680052
2111:             sra          s2, gp, sp
2112:             addi         t1, t6, -1003
2113:             div          s9, a7, a3
2114:             sltiu        a0, gp, 923
2115:             bne          a0, s8, 2126f
2116:             auipc        t6, 92691
2117:             slli         t5, s6, 23
2118:             sub          zero, t3, s5
2119:             addi         t5, tp, -251
2120:             bne          s7, t3, 2121f
2121:             ori          a7, s4, -1071
2122:             csrrc        t1, 0x342, zero
2123:             bltu         sp, s11, 2129f
2124:             div          s11, s2, s10
2125:             bge          s11, a0, 2135f
2126:             csrrwi       s6, 0x342, 21
2127:             csrrc        a5, 0x343, a0
2128:             or           s10, a1, a0
2129:             csrrci       s4, 0x343, 0
2130:             slti         t6, s11, -1338
2131:             sll          s9, s4, ra
2132:             auipc        a2, 260564
2133:             sra          a7, s1, sp
2134:             csrrsi       tp, 0x300, 0
2135:             csrrs        tp, 0x342, zero
2136:             div          t0, s8, s9
2137:             and          t1, sp, s2
2138:             csrrc        t0, 0x305, zero
2139:             ori          a6, t1, 753
2140:             csrrc        s1, 0x301, t4
2141:             mulh         s10, a7, a7
2142:             add          a0, s7, t6
2143:             sub          t1, t0, gp
2144:             mul          s1, zero, s5
2145:             sra          s0, a1, s5
2146:             div          tp, s1, s1
2147:             sub          s9, t1, s3
2148:             sll          a1, a5, t5
2149:             csrrwi       a7, 0x342, 27
2150:             sll          a0, t3, a3
2151:             srl          s1, a5, tp
2152:             mul          s4, s5, a3
2153:             csrrs        ra, 0x304, zero
2154:             ori          a4, a5, -2032
2155:             csrrw        a6, 0x342, s7
2156:             remu         s10, a3, ra
2157:             div          t4, s5, t3
2158:             slli         ra, t4, 2
2159:             divu         s9, s11, s6
2160:             xor          s8, s11, s4
2161:             rem          a1, s4, sp
2162:             ori          a4, s1, -1667
2163:             add          a7, a0, s0
2164:             ori          tp, s1, 455
2165:             mulh         a6, a4, t6
2166:             mulhu        s2, a2, s7
2167:             mulh         a4, a3, s2
2168:             slti         a6, s10, -118
2169:             div          t2, s9, t5
2170:             xori         t1, ra, -27
2171:             andi         s4, tp, -1416
2172:             csrrw        s4, 0x304, s7
2173:             add          t5, s7, a7
2174:             csrrwi       a5, 0x342, 10
2175:             csrrw        t4, 0x344, s7
2176:             rem          s0, t1, t2
2177:             csrrci       ra, 0x342, 0
2178:             rem          a2, s6, ra
2179:             sltiu        ra, a3, -795
2180:             addi         t4, sp, -745
2181:             add          zero, t0, s3
2182:             addi         t1, t3, 1402
2183:             sll          t5, a2, t3
2184:             sltiu        s11, t0, -958
2185:             csrrci       s11, 0x300, 0
2186:             srl          a5, zero, s11
2187:             mulhsu       a1, s0, t6
2188:             srli         zero, ra, 19
2189:             xor          t2, s6, a7
2190:             sub          t6, t0, t5
2191:             lui          s10, 740681
2192:             mulh         a6, t1, s6
2193:             sub          a1, s7, tp
2194:             sltu         s2, a7, a5
2195:             add          a1, t2, s4
2196:             mulhsu       t1, t5, s3
2197:             slt          t3, a5, s2
2198:             srl          zero, zero, t0
2199:             sltu         t2, s3, t1
2200:             csrrwi       t3, 0x344, 10
2201:             mul          a7, s1, gp
2202:             and          a7, a7, s11
2203:             sltu         s8, s3, s1
2204:             csrrs        s0, 0x300, zero
2205:             andi         a6, s11, 239
2206:             bne          ra, t3, 2214f
2207:             beq          a5, s1, 2212f
2208:             auipc        t6, 994215
2209:             sra          a6, s9, s4
2210:             divu         t1, a6, tp
2211:             csrrwi       t1, 0x344, 12
2212:             sltiu        zero, t1, 263
2213:             slli         a0, s9, 16
2214:             srai         a7, s11, 11
2215:             addi         a1, a2, 1909
2216:             csrrci       s8, 0x342, 1
2217:             div          s0, a2, a7
2218:             mulhu        t0, t5, a1
2219:             csrrwi       t6, 0x301, 1
2220:             csrrsi       a0, 0x305, 0
2221:             blt          s6, a3, 2224f
2222:             mulhu        s9, s6, a5
2223:             ori          t5, tp, -1056
2224:             mulhsu       a0, s4, sp
2225:             ori          s8, s0, 1390
2226:             mul          a0, s10, s10
2227:             mulhu        s6, tp, a2
2228:             add          tp, a6, s8
2229:             slti         a5, a7, 650
2230:             xor          s3, a0, a6
2231:             sll          s10, s5, a1
2232:             or           s10, zero, a1
2233:             slt          a4, t1, s1
2234:             slti         s6, s0, 832
2235:             sltiu        s8, s1, -1345
2236:             bge          s5, s6, 2240f
2237:             csrrw        gp, 0x344, a3
2238:             bgeu         t3, a2, 2241f
2239:             bgeu         s8, sp, 2242f
2240:             remu         a7, s9, ra
2241:             blt          zero, s1, 2254f
2242:             and          s6, s7, t4
2243:             slli         t5, sp, 30
2244:             auipc        t5, 189050
2245:             div          t5, t6, t3
2246:             remu         tp, t5, a1
2247:             div          s5, a4, s6
2248:             sltu         s10, t0, a7
2249:             xori         s3, t4, -1866
2250:             bgeu         t6, a7, 2253f
2251:             csrrci       t4, 0x300, 0
2252:             nop
2253:             srai         a2, a4, 0
2254:             andi         a6, a1, -278
2255:             bne          ra, s6, 2266f
2256:             bltu         t4, s3, 2271f
2257:             blt          s11, s1, 2264f
2258:             nop
2259:             andi         s10, gp, 1906
2260:             bltu         t6, gp, 2262f
2261:             csrrs        s8, 0x305, zero
2262:             srli         t4, a7, 17
2263:             rem          s8, t0, s11
2264:             slli         s9, t5, 27
2265:             bge          t0, a6, 2268f
2266:             remu         s4, t2, gp
2267:             nop
2268:             rem          zero, t5, s5
2269:             csrrw        t0, 0x344, s2
2270:             divu         t3, s11, s9
2271:             nop
2272:             srai         ra, s2, 1
2273:             lui          s6, 468135
2274:             srl          s8, sp, t3
2275:             lui          s1, 839622
2276:             bgeu         s0, tp, 2289f
2277:             srai         tp, t2, 17
2278:             csrrw        t3, 0x343, a6
2279:             mulh         s0, s0, s1
2280:             and          a2, t6, s0
2281:             slti         s9, sp, -1368
2282:             bge          a2, s2, 2287f
2283:             and          a0, a3, a7
2284:             remu         tp, s2, sp
2285:             csrrc        s5, 0x301, s5
2286:             csrrw        s1, 0x344, zero
2287:             sll          t0, s4, a0
2288:             mulhu        t3, t0, s7
2289:             mulh         s10, s1, s11
2290:             bltu         zero, t6, 2293f
2291:             bne          a4, t4, 2300f
2292:             xor          s10, a2, t2
2293:             mulhsu       s4, tp, a6
2294:             ori          t6, ra, -1886
2295:             or           zero, s11, gp
2296:             rem          s6, s2, s7
2297:             beq          a5, t6, 2308f
2298:             xor          zero, a7, gp
2299:             csrrw        s10, 0x342, s3
2300:             remu         t3, s9, s7
2301:             bne          s6, s1, 2303f
2302:             remu         t3, s9, s10
2303:             slti         t4, t0, 171
2304:             beq          sp, a0, 2324f
2305:             srl          tp, t0, s0
2306:             srl          s1, a5, t2
2307:             slt          s10, s3, t2
2308:             mulhu        t0, a4, gp
2309:             csrrw        s9, 0x344, a7
2310:             remu         s11, t3, s3
2311:             bne          a4, zero, 2312f
2312:             sltiu        t0, t4, -986
2313:             slti         t6, a5, 1221
2314:             csrrs        s3, 0x305, zero
2315:             csrrw        s2, 0x301, sp
2316:             auipc        a7, 323958
2317:             bgeu         a4, tp, 2327f
2318:             remu         tp, a5, a6
2319:             csrrc        t6, 0x343, s3
2320:             csrrw        s9, 0x344, ra
2321:             mulh         t5, zero, a2
2322:             srl          s5, s1, s0
2323:             csrrwi       ra, 0x342, 18
2324:             sltu         ra, sp, a7
2325:             remu         t3, s6, t2
2326:             mulh         a0, s9, t5
2327:             sltiu        a2, a6, -1163
2328:             addi         t6, s7, 890
2329:             sltu         tp, t3, t6
2330:             slt          t4, s0, a3
2331:             and          a5, s9, ra
2332:             csrrwi       t3, 0x304, 20
2333:             csrrc        a5, 0x342, zero
2334:             xori         s8, ra, -1059
2335:             bne          s5, a5, 2338f
2336:             divu         a4, a2, t5
2337:             csrrsi       a2, 0x343, 0
2338:             ori          s9, s0, 1632
2339:             or           s0, t6, gp
2340:             mulhu        a6, a1, a3
2341:             xori         a2, s7, -372
2342:             and          ra, t5, t4
2343:             csrrc        gp, 0x344, zero
2344:             addi         tp, tp, -1834
2345:             mulhsu       t4, s3, s10
2346:             mulhsu       gp, t5, a5
2347:             bltu         t4, a0, 2351f
2348:             sltiu        t0, t2, -14
2349:             sltu         a7, a4, t0
2350:             blt          sp, s10, 2357f
2351:             divu         s3, s1, ra
2352:             csrrsi       t6, 0x305, 0
2353:             addi         s3, s7, 798
2354:             mul          gp, ra, a1
2355:             add          s10, s3, s8
2356:             bge          sp, s8, 2374f
2357:             bltu         a1, s0, 2369f
2358:             srai         a1, gp, 23
2359:             ori          t6, zero, -1646
2360:             sltiu        s1, s1, 1186
2361:             bge          a5, s2, 2369f
2362:             xor          zero, t5, s2
2363:             bgeu         ra, s6, 2374f
2364:             or           s9, a3, ra
2365:             blt          a7, s2, 2380f
2366:             auipc        s11, 190845
2367:             beq          a3, t2, 2371f
2368:             sll          t6, s1, s11
2369:             slt          s10, a1, s7
2370:             bne          s8, s0, 2380f
2371:             slti         t5, t0, -636
2372:             csrrci       s0, 0x342, 0
2373:             blt          sp, ra, 2391f
2374:             and          s3, s1, s2
2375:             sltu         s10, s11, a6
2376:             sltiu        s0, t6, 663
2377:             csrrc        s0, 0x305, zero
2378:             sra          t2, a3, t6
2379:             divu         t4, a0, t5
2380:             xori         s11, a7, -1387
2381:             rem          a5, s6, t0
2382:             csrrsi       ra, 0x305, 0
2383:             and          s8, a1, t2
2384:             divu         zero, s5, s10
2385:             slli         gp, t1, 26
2386:             nop
2387:             blt          s4, a0, 2398f
2388:             csrrs        a1, 0x343, zero
2389:             mulhu        s4, t6, s0
2390:             bne          a1, a3, 2393f
2391:             mulh         s2, a4, t4
2392:             mul          a4, a2, t2
2393:             srl          a1, a3, s2
2394:             auipc        zero, 119225
2395:             divu         s1, a7, s6
2396:             mul          t5, zero, gp
2397:             srai         s2, t4, 29
2398:             srli         s10, tp, 29
2399:             blt          s2, a2, 2402f
2400:             bge          s11, s7, 2408f
2401:             sltu         t4, a7, t1
2402:             xor          s3, s11, t4
2403:             add          a0, a6, s6
2404:             xor          t0, sp, s3
2405:             bltu         s6, s7, 2411f
2406:             andi         a7, s4, -615
2407:             csrrs        t5, 0x342, a0
2408:             andi         t5, s10, -1862
2409:             bge          a1, a6, 2414f
2410:             rem          a1, a5, a3
2411:             csrrwi       a4, 0x344, 30
2412:             or           s0, gp, t6
2413:             mul          s10, t0, t0
2414:             andi         zero, s7, -1343
2415:             and          s2, s1, s7
2416:             sub          a6, a1, s5
2417:             csrrw        zero, 0x343, t3
2418:             csrrc        s6, 0x342, a6
2419:             csrrwi       s6, 0x344, 21
2420:             lui          a7, 361899
2421:             rem          s2, t0, zero
2422:             csrrwi       s1, 0x301, 14
2423:             addi         a5, s9, 653
2424:             nop
2425:             mulhsu       gp, s11, t0
2426:             csrrwi       tp, 0x343, 10
2427:             sltiu        a6, a4, 246
2428:             csrrw        gp, 0x344, gp
2429:             csrrci       a6, 0x305, 0
2430:             bne          gp, s11, 2431f
2431:             csrrci       a6, 0x344, 0
2432:             mulhsu       a1, a1, t3
2433:             add          t1, s8, s8
2434:             nop
2435:             beq          a6, s4, 2439f
2436:             bltu         t4, t5, 2450f
2437:             bne          t1, a4, 2440f
2438:             or           t6, s11, a2
2439:             csrrs        s8, 0x344, a0
2440:             andi         a7, a6, 55
2441:             sra          a0, a1, t2
2442:             slli         a5, s0, 30
2443:             bgeu         t2, a3, 2447f
2444:             csrrw        t6, 0x342, zero
2445:             lui          s3, 386226
2446:             srli         gp, zero, 4
2447:             ori          t4, a3, 411
2448:             bge          s7, s4, 2462f
2449:             mul          t3, a4, t3
2450:             bltu         s9, t3, 2453f
2451:             bgeu         tp, a3, 2459f
2452:             xor          s6, t0, s6
2453:             slli         s10, s1, 10
2454:             slli         t6, t3, 22
2455:             addi         s4, s8, 1168
2456:             csrrc        s9, 0x344, zero
2457:             add          s8, t5, s6
2458:             ori          t1, s7, -450
2459:             xori         s1, a0, 804
2460:             mul          s3, t4, a6
2461:             slt          s0, t5, s11
2462:             or           t3, s3, a1
2463:             ori          a1, s2, -412
2464:             addi         a0, s5, -963
2465:             remu         tp, a4, a3
2466:             rem          a0, s7, s4
2467:             slt          s1, s10, t6
2468:             divu         s2, t0, t4
2469:             csrrsi       s8, 0x342, 0
2470:             srl          t1, gp, a5
2471:             div          a6, s11, a3
2472:             bne          t5, s0, 2474f
2473:             mulhu        s9, a3, t2
2474:             csrrs        s8, 0x300, zero
2475:             lui          a1, 858634
2476:             sll          s1, a2, zero
2477:             rem          s10, ra, s3
2478:             xori         t6, a3, 79
2479:             div          ra, s8, ra
2480:             sub          a1, t4, t4
2481:             mulhu        t5, s10, s4
2482:             csrrci       tp, 0x342, 0
2483:             bgeu         t1, gp, 2487f
2484:             csrrsi       t4, 0x343, 11
2485:             srai         a6, s6, 17
2486:             or           s0, a3, t6
2487:             mul          ra, s4, s1
2488:             remu         s1, s3, tp
2489:             sll          a7, t2, t5
2490:             sltu         a4, s5, a2
2491:             beq          s5, a4, 2509f
2492:             slt          a4, t0, t6
2493:             csrrw        s9, 0x301, a6
2494:             bgeu         a4, s6, 2505f
2495:             srl          t6, t1, t1
2496:             bge          sp, a3, 2504f
2497:             srli         a4, t4, 24
2498:             slti         s3, t5, -1207
2499:             mulhsu       a0, s7, s6
2500:             csrrsi       s10, 0x344, 17
2501:             and          t0, s7, t3
2502:             srli         s5, t0, 12
2503:             sltu         a7, zero, tp
2504:             csrrc        ra, 0x305, zero
2505:             div          t1, a2, s1
2506:             srai         s8, t6, 11
2507:             lui          t2, 843030
2508:             bne          s5, s1, 2520f
2509:             div          t2, a6, s0
2510:             xori         s4, a0, -295
2511:             csrrs        t2, 0x342, zero
2512:             and          a7, t3, sp
2513:             rem          s4, s8, a4
2514:             ori          a0, s10, 1436
2515:             csrrs        s2, 0x301, zero
2516:             slti         s3, s5, -1941
2517:             mul          s6, a4, zero
2518:             bgeu         s10, s6, 2521f
2519:             rem          t5, ra, s3
2520:             and          s0, sp, a3
2521:             sltu         ra, s3, t2
2522:             sll          s0, s8, s9
2523:             slt          t5, ra, tp
2524:             divu         t1, s4, t0
2525:             bge          gp, s7, 2540f
2526:             xor          a7, t2, s11
2527:             csrrwi       s3, 0x342, 0
2528:             xor          a1, s7, s3
2529:             xor          a2, sp, a7
2530:             slli         a7, t4, 2
2531:             csrrwi       s9, 0x344, 29
2532:             csrrw        s11, 0x304, s11
2533:             mulh         t6, sp, t5
2534:             ori          s6, a7, -1659
2535:             rem          s1, s8, s7
2536:             mul          s0, s3, s3
2537:             csrrs        s5, 0x344, zero
2538:             lui          a0, 343645
2539:             sll          a5, ra, t6
2540:             and          s5, s9, a1
2541:             mulh         a0, s11, s2
2542:             add          a6, s0, s3
2543:             beq          s5, s0, 2553f
2544:             ori          t4, s0, -1685
2545:             bge          a7, s10, 2550f
2546:             sltu         ra, gp, s2
2547:             mulh         s8, s9, s8
2548:             slli         a1, t2, 24
2549:             remu         a1, a6, gp
2550:             csrrw        s5, 0x342, s0
2551:             csrrw        s10, 0x343, a7
2552:             addi         t4, a7, -637
2553:             srli         t6, a3, 27
2554:             sra          t5, a2, s4
2555:             ori          ra, s9, 873
2556:             addi         ra, t6, -1291
2557:             lui          s4, 346641
2558:             xor          a7, s8, s1
2559:             lui          a7, 774789
2560:             mulhsu       gp, s0, a6
2561:             ori          ra, t0, -1828
2562:             bltu         s8, tp, 2563f
2563:             slti         s1, gp, -530
2564:             and          t0, s4, a0
2565:             bge          a7, a6, 2585f
2566:             csrrsi       s9, 0x300, 0
2567:             csrrci       a6, 0x301, 0
2568:             auipc        a5, 276313
2569:             sub          s3, ra, s3
2570:             sltu         t4, s7, s9
2571:             mul          a0, a5, s6
2572:             lui          a2, 50051
2573:             rem          s11, a7, tp
2574:             nop
2575:             or           t2, s1, a0
2576:             sub          t5, tp, s6
2577:             mulh         t1, s2, t1
2578:             mulhu        a4, a4, t2
2579:             sra          a4, s4, s10
2580:             slt          t5, tp, t1
2581:             beq          ra, a5, 2587f
2582:             xori         t1, t5, -1622
2583:             beq          s1, t6, 2593f
2584:             remu         a4, a4, a0
2585:             srli         zero, s2, 2
2586:             sll          t5, ra, s6
2587:             xor          a0, a5, t5
2588:             blt          a1, t1, 2592f
2589:             remu         s6, a2, t0
2590:             mul          s10, a6, s9
2591:             csrrw        a7, 0x342, t4
2592:             and          t0, s3, a0
2593:             andi         a5, s6, -1287
2594:             blt          a1, s3, 2599f
2595:             sltu         s2, t1, zero
2596:             ori          s4, t3, -1286
2597:             sll          ra, s10, s8
2598:             rem          s9, a6, s0
2599:             csrrsi       t6, 0x344, 22
2600:             srli         s5, t0, 7
2601:             csrrw        t5, 0x343, t5
2602:             remu         ra, s1, t0
2603:             csrrc        s0, 0x342, s6
2604:             csrrsi       t5, 0x343, 0
2605:             and          zero, t4, a2
2606:             bgeu         a7, t3, 2619f
2607:             add          tp, s11, sp
2608:             bgeu         s11, s9, 2619f
2609:             and          s9, a4, s1
2610:             and          s1, t3, s7
2611:             div          a0, gp, gp
2612:             slti         a1, t1, -1810
2613:             xor          tp, a4, t1
2614:             sll          t5, s8, a3
2615:             andi         zero, s5, -841
2616:             csrrw        t3, 0x301, s1
2617:             slti         s2, t4, 618
2618:             csrrc        t3, 0x304, t3
2619:             remu         s5, a6, s5
2620:             div          s4, a6, s6
2621:             csrrs        s11, 0x301, zero
2622:             add          t6, sp, ra
2623:             csrrw        a7, 0x304, s0
2624:             auipc        t3, 769553
2625:             sltiu        gp, s4, -1821
2626:             slti         s6, s5, 1381
2627:             sltiu        gp, a4, 610
2628:             lui          t0, 578296
2629:             mulh         a1, s10, s9
2630:             lui          s6, 828983
2631:             csrrsi       s1, 0x305, 0
2632:             divu         s4, tp, s3
2633:             slti         a4, t2, 1524
2634:             add          t0, s2, ra
                  la           tp, region_0+2333 #start load_store_instr_stream_0
                  la           s0, region_0+669 #start load_store_instr_stream_1
                  la           s2, region_0+1989 #start load_store_instr_stream_3
                  lbu          s5, 441(s0)
                  lhu          zero, -15(s2)
                  sb           t4, 1164(tp)
                  lb           t6, -476(s0)
                  lh           a1, -477(s0)
                  lbu          a4, 410(s0)
                  la           t4, region_0+1224 #start load_store_instr_stream_2
                  sh           zero, -1047(tp)
                  sb           s3, 796(tp)
                  lh           ra, -918(t4)
                  lw           t6, 1115(s0)
                  lb           t5, 1397(t4)
                  lb           s4, 1410(tp)
                  lb           a7, 1911(t4)
                  lb           s4, 1578(s0)
                  sb           sp, 716(tp)
                  sb           a5, -286(s0)
                  lb           s11, -6(s2)
                  sb           t4, 6(tp)
                  lw           a7, 1008(t4)
                  lb           a1, 13(s2)
                  lb           s3, 1274(s0)
                  sh           s4, -15(s2)
                  sw           a0, 631(tp)
                  sb           t3, -14(s2)
                  lbu          s3, 899(s0)
                  lh           zero, 9(s2)
                  lbu          s11, 1032(s0) #end load_store_instr_stream_1
                  lb           s9, -271(t4)
                  lb           a2, 1969(t4)
                  lw           a4, -260(t4) #end load_store_instr_stream_2
                  lbu          t0, 1489(tp)
                  sb           t5, -10(s2) #end load_store_instr_stream_3
                  lbu          t1, -806(tp)
                  lbu          ra, 470(tp) #end load_store_instr_stream_0
2635:             add          t4, a3, s9
2636:             xori         t6, s11, 1190
2637:             bne          t6, tp, 2648f
2638:             mul          t3, a1, a1
2639:             csrrci       s6, 0x301, 0
2640:             mulhu        s4, s11, s8
2641:             mulhu        s0, t4, t2
2642:             blt          a4, s0, 2649f
2643:             mulhsu       s6, a4, s0
2644:             sltu         s11, t4, s5
2645:             andi         s6, a4, -1493
2646:             add          a2, sp, t1
2647:             srl          a7, a5, a7
2648:             blt          zero, a2, 2657f
2649:             nop
2650:             and          t2, t0, a6
2651:             mulhsu       tp, s5, zero
2652:             sltu         t1, s8, s9
2653:             mul          a1, a0, a3
2654:             or           s9, t5, s1
2655:             bge          s1, t0, 2658f
2656:             sll          a6, t2, s2
2657:             andi         s9, a3, 366
2658:             beq          s0, s10, 2659f
2659:             xori         t0, t1, -43
2660:             addi         s9, a6, 0
2661:             bne          a1, gp, 2679f
2662:             sltiu        a2, t6, 894
2663:             and          s11, s3, a1
2664:             mulhu        s4, s8, a7
2665:             csrrc        a6, 0x304, zero
2666:             mulh         s0, s2, s3
2667:             srli         s4, s7, 31
2668:             bltu         t4, zero, 2671f
2669:             and          a7, t1, s5
2670:             blt          a1, a5, 2679f
2671:             divu         s11, s5, s11
2672:             sltu         a5, t1, a2
2673:             bltu         ra, a1, 2683f
2674:             add          a2, t1, a3
2675:             slti         t5, sp, 311
2676:             sra          s3, s10, t1
2677:             csrrsi       s4, 0x342, 0
2678:             lui          s2, 260678
2679:             xor          s4, gp, a6
2680:             sltiu        a5, tp, -120
2681:             slli         a2, tp, 28
2682:             add          tp, s3, t0
2683:             csrrci       s8, 0x344, 0
2684:             or           a6, gp, s4
2685:             blt          s6, sp, 2690f
2686:             xor          t4, t2, s6
2687:             sltiu        a0, t4, 1771
2688:             csrrci       a5, 0x344, 25
2689:             csrrwi       a2, 0x304, 28
2690:             mulhsu       a1, s10, a5
2691:             slti         a7, sp, -421
2692:             csrrci       a2, 0x300, 0
2693:             mulhu        s2, a7, s2
2694:             blt          t5, s3, 2712f
2695:             mulh         s2, s1, t4
2696:             bne          s8, s1, 2698f
2697:             slli         s4, a4, 8
2698:             csrrci       s5, 0x304, 0
2699:             addi         s3, a6, -433
2700:             csrrsi       t6, 0x300, 0
2701:             csrrwi       s2, 0x344, 18
2702:             srli         a6, s7, 2
2703:             csrrw        t1, 0x344, t1
2704:             csrrc        s10, 0x343, zero
2705:             sltiu        s3, t1, -1868
2706:             xori         s10, t6, -1035
2707:             ori          a1, s10, 1964
2708:             ori          t0, s3, 639
2709:             ori          s0, s4, 1906
2710:             divu         s10, s3, a2
2711:             bltu         a2, t6, 2725f
2712:             bge          a3, a7, 2715f
2713:             and          a1, a6, t1
2714:             mulh         s10, s6, s6
2715:             remu         s6, s6, t0
2716:             remu         s2, t4, zero
2717:             auipc        s4, 827689
2718:             addi         t3, t1, -1781
2719:             divu         t0, s7, a5
2720:             xori         a1, a2, -1508
2721:             auipc        s8, 666794
2722:             sra          a1, a0, tp
2723:             csrrw        t1, 0x343, s4
2724:             div          s11, s5, a4
2725:             bne          tp, a7, 2733f
2726:             lui          s2, 1047463
2727:             mulhu        zero, a7, s2
2728:             xori         t3, t2, -1660
2729:             mulhsu       t1, sp, s9
2730:             nop
2731:             and          tp, s3, s10
2732:             auipc        gp, 491781
2733:             mulhu        t1, t0, s0
2734:             and          s8, t1, zero
2735:             sltu         s1, s9, t4
2736:             srli         s3, ra, 14
2737:             remu         s9, s4, t1
2738:             auipc        s10, 1032892
2739:             xori         s8, s1, -1836
2740:             sltu         s9, zero, a3
2741:             blt          a3, s4, 2742f
2742:             csrrs        tp, 0x344, zero
2743:             slt          s8, a3, a5
2744:             or           ra, t5, s7
2745:             sra          s8, s10, a5
2746:             xor          a4, a6, t1
2747:             or           tp, t2, s7
2748:             sra          zero, s6, s9
2749:             divu         s3, s1, s11
2750:             auipc        s3, 840128
2751:             slti         a4, s8, 1269
2752:             srli         a1, s3, 0
2753:             and          s0, s1, s5
2754:             add          s2, sp, t0
2755:             mulh         a0, s11, s6
2756:             beq          a5, a2, 2774f
2757:             slt          zero, s11, s7
2758:             andi         s0, s11, 819
2759:             bge          s0, s1, 2770f
2760:             blt          s5, gp, 2780f
2761:             addi         ra, t4, 1285
2762:             beq          sp, t0, 2765f
2763:             sub          s3, s4, s8
2764:             csrrc        s10, 0x342, tp
2765:             mulhu        t4, gp, t5
2766:             sltu         a5, s11, a5
2767:             csrrw        a2, 0x344, s2
2768:             slti         gp, a2, 1595
2769:             remu         s4, a0, a6
2770:             bge          s7, s2, 2781f
2771:             or           a1, a4, s11
2772:             mul          t0, s9, a1
2773:             csrrwi       s2, 0x301, 22
2774:             srl          s9, s4, s3
2775:             mul          gp, t0, s11
2776:             div          tp, s7, t4
2777:             and          tp, s5, a6
2778:             remu         t5, a6, t6
2779:             bgeu         gp, t6, 2782f
2780:             bltu         ra, a3, 2784f
2781:             mulh         a4, a3, a7
2782:             and          tp, t1, s11
2783:             mulhsu       zero, zero, sp
2784:             srl          t2, a1, a0
2785:             slt          a6, a2, s8
2786:             slt          t1, s6, t2
2787:             ori          s3, a7, 473
2788:             addi         s0, t4, 629
2789:             sltiu        s5, a3, -272
2790:             mulhsu       s4, t3, tp
2791:             mulhu        t4, a5, a3
2792:             xori         t1, s9, -1940
2793:             mul          s4, s0, s4
2794:             sltu         zero, t3, s2
2795:             sll          s11, s2, tp
2796:             sll          s9, t0, t1
2797:             mul          s6, s6, s4
2798:             addi         t6, a0, 1472
2799:             srli         ra, t3, 1
2800:             remu         a6, s10, s8
2801:             xor          s9, s1, a5
2802:             slli         t2, a1, 27
2803:             addi         s0, t6, 1341
2804:             andi         s1, t1, 751
2805:             srai         s0, ra, 11
2806:             addi         s0, s7, 1972
2807:             sll          a0, t6, s10
2808:             sltiu        s5, ra, -558
2809:             mul          s0, sp, t1
2810:             sub          t2, s1, t1
2811:             csrrsi       s8, 0x305, 0
2812:             beq          s3, zero, 2818f
2813:             csrrci       a6, 0x300, 0
2814:             srli         a4, t3, 11
2815:             auipc        a1, 69322
2816:             srai         a0, s1, 11
2817:             csrrsi       s4, 0x342, 18
2818:             add          t3, a2, s9
2819:             andi         s5, s2, 10
2820:             mulhu        a2, a3, s8
2821:             andi         a7, gp, 188
2822:             sltiu        ra, a4, -624
2823:             sll          a1, a5, a5
2824:             rem          a5, s9, t5
2825:             sltiu        s11, ra, -714
2826:             sub          t0, gp, a5
2827:             bne          s2, t2, 2830f
2828:             add          t0, a3, gp
2829:             lui          a5, 459820
2830:             csrrc        a1, 0x305, zero
2831:             csrrc        t3, 0x300, zero
2832:             srai         s4, t0, 26
2833:             lui          s8, 893629
2834:             srli         t1, a2, 30
2835:             remu         ra, s10, a1
2836:             slli         a6, t1, 31
2837:             mulh         s11, s5, a5
2838:             csrrs        s0, 0x342, zero
2839:             ori          t5, s2, 683
2840:             or           t0, s8, a2
2841:             beq          s2, s4, 2854f
2842:             mulh         s0, t4, a2
2843:             bge          t2, sp, 2847f
2844:             slti         s0, s4, -1669
2845:             bgeu         sp, t2, 2849f
2846:             slt          s0, s9, a6
2847:             nop
2848:             sltiu        tp, s4, 852
2849:             csrrs        t0, 0x342, zero
2850:             beq          a0, tp, 2865f
2851:             addi         tp, a3, 190
2852:             slti         s6, zero, -1525
2853:             srai         t5, gp, 10
2854:             slli         s10, a7, 15
2855:             auipc        a1, 293113
2856:             add          s3, t0, a1
2857:             slt          a7, s10, s2
2858:             xor          t3, s8, s4
2859:             slti         a1, s5, -1199
2860:             csrrc        s6, 0x301, zero
2861:             sltu         ra, s6, s5
2862:             mulhsu       t6, s5, s2
2863:             csrrc        a5, 0x300, zero
2864:             or           s6, s2, a2
2865:             csrrsi       t6, 0x343, 29
2866:             beq          t2, s1, 2874f
2867:             lui          t4, 302972
2868:             lui          t1, 436708
2869:             mul          a0, s5, s11
2870:             csrrs        a1, 0x301, zero
2871:             andi         s10, t0, -983
2872:             div          a0, a5, t5
2873:             slt          s6, a0, a6
2874:             xori         t0, a6, 1355
2875:             andi         tp, a2, 250
2876:             csrrs        s1, 0x300, zero
2877:             rem          t3, s2, a3
2878:             srl          s11, t0, s11
2879:             mulh         s8, s11, s7
2880:             xor          t5, s1, a1
2881:             xori         gp, t6, -747
2882:             andi         tp, a6, -915
2883:             bgeu         t2, a3, 2895f
2884:             bltu         gp, ra, 2891f
2885:             sra          ra, s4, a6
2886:             auipc        s3, 687635
2887:             slt          s5, s7, gp
                  la           t6, region_0+2337 #start riscv_hazard_instr_stream_9
                  sb           ra, -283(t6)
                  lhu          ra, 1133(t6)
                  lh           t5, -781(t6)
                  lbu          t5, -1193(t6)
                  rem          s9, s1, t5
                  addi         t5, ra, -330
                  sll          ra, ra, t5
                  slt          a2, a1, s9
                  csrrs        a2, 0x343, a1
                  sw           s1, -633(t6)
                  slli         ra, s1, 29
                  lbu          s1, -480(t6)
                  add          s1, ra, a1
                  lbu          a1, 406(t6)
                  mulh         a1, t5, s9
                  andi         s1, s1, -366
                  lhu          s1, -479(t6)
                  sb           a2, -1978(t6)
                  lbu          s9, -778(t6)
                  sb           s9, 1162(t6)
                  csrrw        ra, 0x343, s9
                  csrrsi       s9, 0x304, 0
                  lbu          a2, 694(t6)
                  auipc        t5, 772833
                  lh           t5, 503(t6)
                  lb           t5, -273(t6)
                  sll          a1, t5, t5
                  sh           a2, -1579(t6)
                  lb           s9, 1268(t6)
                  sltu         s9, s9, s9
                  csrrc        ra, 0x301, s9
                  csrrc        t5, 0x301, s9
                  sh           ra, 583(t6)
                  lb           a1, 488(t6)
                  lb           ra, -2028(t6)
                  sb           a1, -1990(t6)
                  sb           a1, 1546(t6)
                  lbu          s1, -1094(t6)
                  srl          ra, a1, ra
                  csrrc        ra, 0x344, s1
                  auipc        s1, 441880
                  sb           a1, -274(t6) #end riscv_hazard_instr_stream_9
2888:             bge          a3, t2, 2893f
2889:             srli         a4, t5, 13
2890:             divu         s6, t6, s8
2891:             mulh         zero, a0, t6
2892:             and          s10, a3, t6
2893:             blt          s0, s5, 2896f
2894:             mulh         t0, t6, a1
2895:             sra          s4, gp, s6
2896:             and          a7, s3, sp
2897:             beq          t5, a3, 2907f
2898:             sub          s0, a5, t3
2899:             csrrs        s9, 0x305, zero
2900:             mulhu        zero, s6, s0
2901:             csrrci       a5, 0x300, 0
2902:             bltu         t3, s7, 2903f
2903:             sub          t4, t6, a0
2904:             sub          tp, t5, s4
2905:             addi         s4, s7, 1556
2906:             csrrsi       t6, 0x301, 0
2907:             bltu         a2, a5, 2918f
2908:             sra          t3, a0, s1
2909:             slti         a1, t5, 1211
2910:             csrrs        zero, 0x343, zero
2911:             ori          t2, s5, -1397
2912:             rem          a0, zero, s0
2913:             csrrwi       a7, 0x342, 31
2914:             slli         zero, s4, 21
2915:             mulhsu       s6, t4, s2
2916:             slli         s1, s2, 13
2917:             bgeu         s5, zero, 2919f
2918:             srl          s6, t6, t0
2919:             add          s5, gp, t5
2920:             remu         a1, t5, sp
2921:             bge          a2, a0, 2931f
2922:             blt          tp, s6, 2933f
2923:             ori          tp, s8, 1341
2924:             blt          gp, a6, 2936f
2925:             csrrs        gp, 0x344, s1
2926:             nop
2927:             mulhu        s0, a7, t0
2928:             xor          t1, s4, a7
2929:             xori         s2, a6, 1572
2930:             csrrc        t3, 0x342, s7
2931:             bge          s9, tp, 2949f
2932:             bltu         a5, s3, 2952f
2933:             bne          s8, t0, 2946f
2934:             mulhu        tp, t5, s1
2935:             csrrwi       zero, 0x344, 31
2936:             csrrc        s4, 0x305, zero
2937:             bge          ra, a6, 2941f
2938:             rem          a4, s0, a4
2939:             csrrci       t5, 0x305, 0
2940:             srl          s5, t4, s2
2941:             andi         s2, s5, 698
2942:             sll          a0, s0, tp
2943:             csrrc        s0, 0x301, zero
2944:             add          t5, tp, a0
2945:             blt          a4, s3, 2946f
2946:             andi         s9, s4, 2030
2947:             remu         s1, a4, s8
2948:             mulh         a0, sp, s5
2949:             remu         s8, s4, t2
2950:             mulhu        t4, t1, s8
2951:             and          tp, a1, a1
2952:             addi         t5, a1, 902
main_81:          jal          t4, 12f
0:                jal          a6, 10f
1:                jal          ra, 15f
2:                jal          t1, 6f
3:                jal          ra, 11f
4:                jal          t1, 7f
5:                jal          a1, 14f
6:                jal          ra, 1b
7:                jal          ra, 18f
8:                jal          ra, 4b
9:                jal          ra, 5b
10:               jal          tp, 13f
11:               jal          t1, 0b
12:               jal          ra, 9b
13:               jal          ra, 2b
14:               jal          a2, 17f
15:               jal          t1, 8b
16:               jal          t1, 3b
17:               jal          ra, 16b
18:               andi         a4, s0, 311
2953:             div          s10, s7, a5
2954:             rem          t1, s7, ra
2955:             bne          t1, t3, 2958f
2956:             blt          t4, a0, 2962f
2957:             rem          t6, tp, a1
2958:             nop
2959:             csrrw        t2, 0x342, s1
2960:             xor          t0, t2, s11
2961:             mulh         s2, t4, s1
2962:             csrrs        t3, 0x305, zero
2963:             lui          a0, 377716
2964:             div          t5, a3, s6
2965:             csrrwi       s10, 0x304, 26
                  xor          t0, t2, s11
                  mulh         s2, t4, s1
                  lui          a0, 377716
                  div          t5, a3, s6
                  andi         a4, t0, 264
                  sub          ra, s3, t3
                  andi         a0, s8, 1779
                  sra          t1, s0, s11
2966:             andi         a4, t0, 264
2967:             csrrc        t3, 0x344, zero
2968:             mul          s8, s2, t6
2969:             csrrwi       s8, 0x342, 16
2970:             rem          a2, t6, a5
2971:             slti         a0, t2, 1262
2972:             bgeu         tp, a0, 2980f
2973:             slt          s9, a0, t0
2974:             srai         tp, sp, 25
2975:             csrrc        s5, 0x305, zero
2976:             sltu         t1, t3, s10
2977:             addi         t5, a3, -518
2978:             srli         t4, a5, 7
2979:             sra          t1, s0, s11
2980:             mulh         a0, a4, s5
2981:             sltu         s6, t3, s10
2982:             csrrsi       s9, 0x344, 12
2983:             andi         a0, s8, 1779
                  sltu         t1, t3, s10
                  addi         t5, a3, -518
                  srli         t4, a5, 7
                  sra          t1, s0, s11
                  mulh         a0, a4, s5
                  rem          a2, t6, a5
                  slti         a0, t2, 1262

2984:             csrrw        s2, 0x344, s4
2985:             sub          ra, s3, t3
2986:             csrrs        a0, 0x344, s7
2987:             csrrsi       s11, 0x305, 0
2988:             andi         t2, zero, 335
2989:             csrrci       s5, 0x305, 0
2990:             sltu         s4, a0, ra
2991:             add          s1, zero, s1
2992:             srli         a4, a6, 29
2993:             slti         s2, s7, -775
2994:             srli         a6, s3, 4
2995:             csrrc        s10, 0x305, zero
2996:             sub          ra, tp, s6
2997:             csrrci       s3, 0x301, 26
2998:             lui          a5, 547842
2999:             rem          a5, t1, t3
3000:             sub          s11, t3, t5
3001:             mulhsu       s0, s4, s9
3002:             lui          t5, 607580
3003:             sll          t1, s4, s9
3004:             bne          sp, a0, 3007f
3005:             bge          zero, s4, 3012f
3006:             and          t3, s6, a5
3007:             blt          s6, a4, 3012f
3008:             rem          t0, a0, sp
3009:             srl          s0, t4, t6
3010:             div          s8, a7, a0
3011:             csrrc        s8, 0x305, zero
3012:             sltiu        s6, t4, 1438
3013:             andi         t1, a6, 1656
3014:             and          s1, a5, s9
3015:             csrrsi       s5, 0x305, 0
3016:             or           a1, s10, s11
3017:             ori          s1, s11, 511
3018:             or           a4, a2, sp
3019:             div          s0, a7, a7
3020:             sltiu        s11, t2, -696
3021:             nop
3022:             ori          a1, a3, 663
3023:             xor          a6, a6, tp
3024:             addi         a5, s2, 1398
3025:             nop
3026:             beq          tp, s11, 3037f
3027:             bge          s9, s8, 3028f
3028:             rem          a5, s7, t0
3029:             lui          s4, 204186
3030:             bge          s9, s1, 3041f
3031:             csrrci       gp, 0x301, 0
3032:             nop
3033:             slti         a4, s7, -1605
3034:             lui          ra, 657544
3035:             andi         s9, a6, 523
3036:             lui          s10, 477900
3037:             xori         t6, t4, 1998
3038:             bge          a6, tp, 3042f
3039:             csrrw        a2, 0x343, a2
3040:             lui          s8, 692092
3041:             mulh         s3, s9, a5
3042:             csrrci       s10, 0x300, 0
3043:             mulhsu       s9, a4, s8
3044:             csrrci       a0, 0x344, 0
3045:             addi         zero, a7, -489
3046:             csrrwi       s2, 0x343, 7
3047:             sll          t2, a5, s10
3048:             slti         a0, zero, 33
3049:             andi         tp, gp, 1949
3050:             csrrci       s3, 0x344, 0
3051:             bne          zero, t2, 3065f
3052:             mulh         s2, a1, t4
3053:             sltu         s1, sp, t6
3054:             div          t0, t5, a7
3055:             csrrsi       tp, 0x304, 14
3056:             csrrw        a0, 0x344, zero
3057:             mulhu        t2, t2, zero
3058:             bge          t6, gp, 3066f
3059:             slli         s4, s4, 29
3060:             slli         t1, s11, 31
3061:             srli         a5, t5, 31
3062:             slt          a1, a0, s6
3063:             srai         t5, ra, 5
3064:             sra          a5, s3, a1
3065:             beq          a6, t1, 3068f
3066:             lui          t1, 147781
3067:             srl          t2, s3, a4
3068:             xori         a6, tp, -363
3069:             csrrs        a5, 0x300, zero
3070:             slt          s8, t0, tp
3071:             bge          zero, s9, 3075f
3072:             auipc        a4, 133230
3073:             bgeu         a3, zero, 3082f
3074:             csrrw        s2, 0x301, s9
3075:             sltu         a1, a4, s4
3076:             mulhsu       s0, t1, sp
3077:             beq          s8, t4, 3087f
3078:             or           s1, sp, s4
3079:             or           s10, a3, a1
3080:             srli         t6, s3, 9
3081:             divu         t2, s0, s10
3082:             sltiu        a0, ra, -186
3083:             csrrs        t1, 0x342, s3
3084:             addi         t1, t4, -860
3085:             slt          t6, a2, t2
3086:             csrrwi       t6, 0x342, 22
3087:             ori          s6, s1, 572
3088:             srli         a5, s6, 20
3089:             srai         s9, s7, 9
3090:             div          a0, t4, a0
3091:             mulhu        s4, a2, t5
3092:             slti         t1, a2, -1654
3093:             bne          tp, t3, 3108f
3094:             mul          t2, s10, s9
3095:             auipc        a0, 703906
3096:             bgeu         t3, gp, 3101f
3097:             mulhsu       t2, t5, t5
3098:             remu         s2, ra, s9
3099:             remu         a5, zero, s10
3100:             add          t3, t0, t2
3101:             and          s6, a4, t2
3102:             andi         s9, s11, -565
3103:             csrrci       t3, 0x300, 0
3104:             addi         gp, s3, -44
3105:             bgeu         s2, t2, 3123f
3106:             auipc        s3, 974816
3107:             bgeu         gp, a3, 3110f
3108:             sll          s8, s8, sp
3109:             xori         s9, zero, 25
3110:             bltu         a6, s5, 3113f
3111:             srli         t2, t4, 29
3112:             andi         s3, t5, -1873
3113:             blt          s0, gp, 3124f
3114:             addi         tp, a7, 800
3115:             mulhu        a7, t1, t6
3116:             andi         s5, zero, -1785
3117:             srl          a1, a4, t2
3118:             bne          s4, tp, 3123f
3119:             sltu         t2, t5, s10
3120:             bltu         t5, gp, 3123f
3121:             srl          s8, s8, t5
3122:             slt          s5, t2, s5
3123:             srai         a6, a1, 20
3124:             csrrci       s3, 0x304, 0
3125:             slt          s2, s1, tp
3126:             mulhsu       s4, s11, gp
3127:             slli         a0, a4, 1
3128:             csrrc        tp, 0x344, zero
3129:             srai         a5, t4, 3
3130:             addi         a6, s8, 1002
3131:             srai         t4, t6, 12
3132:             or           t2, s8, s9
3133:             csrrsi       t5, 0x300, 0
3134:             csrrw        s11, 0x344, a6
3135:             bltu         s11, t2, 3148f
3136:             csrrwi       ra, 0x344, 10
3137:             rem          tp, s0, t1
3138:             slli         s9, t5, 24
3139:             blt          gp, s6, 3146f
3140:             ori          s11, s3, -774
3141:             and          a1, s6, s8
3142:             bltu         s4, a1, 3151f
3143:             sra          s3, tp, s7
3144:             lui          s5, 481823
3145:             nop
3146:             srai         s3, s1, 13
3147:             addi         a0, s10, -1035
3148:             andi         gp, t6, -298
3149:             csrrci       s11, 0x305, 0
3150:             csrrc        a6, 0x344, gp
3151:             and          a7, t5, s0
3152:             remu         s4, s11, t0
3153:             auipc        s6, 801576
3154:             slli         s5, a3, 10
3155:             csrrs        s5, 0x301, zero
3156:             sub          t5, s2, a1
3157:             nop
3158:             mul          a6, t2, t3
3159:             srl          ra, ra, a4
3160:             sltiu        s4, ra, 1398
3161:             sra          s10, a3, s2
3162:             sub          a2, gp, s10
3163:             csrrci       s0, 0x301, 0
3164:             divu         s6, s1, a0
3165:             bgeu         s6, zero, 3173f
3166:             and          a6, a0, s2
3167:             bgeu         sp, s3, 3170f
3168:             sltiu        s4, a7, -175
3169:             mul          a5, t6, s6
3170:             xori         a5, s6, 1654
3171:             csrrci       s2, 0x344, 6
3172:             sub          t0, t6, s10
3173:             rem          s3, s4, t5
3174:             csrrsi       a0, 0x305, 0
3175:             csrrci       t4, 0x344, 22
3176:             ori          t0, s10, 1553
3177:             ori          t3, a7, -1071
3178:             sra          s2, s6, s0
3179:             div          s5, s10, t5
3180:             and          s0, s2, t6
3181:             bne          a2, sp, 3192f
3182:             srai         zero, s3, 0
3183:             xor          s11, s4, gp
3184:             sltiu        t6, t4, 1499
3185:             add          s0, s0, zero
3186:             srai         s8, s6, 10
3187:             auipc        zero, 996100
3188:             srli         s8, t5, 17
3189:             sltu         s4, t4, zero
3190:             or           a6, s3, s6
3191:             addi         ra, s7, 1727
3192:             mulhu        t6, s8, s4
3193:             slti         tp, s11, -1584
3194:             srli         gp, zero, 30
3195:             xori         a7, s9, 1493
3196:             mul          s9, s6, gp
3197:             bltu         a1, zero, 3203f
3198:             csrrw        ra, 0x342, ra
3199:             mulhu        a2, t1, zero
3200:             mulhsu       s2, s3, s7
3201:             csrrs        t1, 0x305, zero
3202:             and          s9, s8, a7
3203:             slli         tp, a7, 13
3204:             sll          a7, t5, t2
3205:             mulhu        zero, t6, a6
3206:             lui          t4, 356849
3207:             csrrsi       s10, 0x304, 0
3208:             sltiu        s4, gp, -1135
3209:             csrrci       s10, 0x343, 0
3210:             slli         s11, s11, 23
3211:             csrrwi       a6, 0x301, 11
3212:             srai         s2, s9, 2
3213:             bne          s0, t0, 3214f
3214:             csrrsi       a4, 0x343, 21
3215:             mulh         ra, s9, s10
3216:             blt          s0, a0, 3220f
3217:             blt          s6, t3, 3225f
3218:             remu         tp, t6, t3
3219:             mulhsu       a4, s10, s10
3220:             addi         t4, s11, -427
3221:             mulh         s5, a7, s1
3222:             srai         s5, a2, 1
3223:             srli         s9, t5, 9
3224:             addi         s8, s2, 952
3225:             beq          t2, s2, 3245f
3226:             slli         a2, a6, 10
3227:             sll          tp, a6, a2
3228:             mulhu        s8, sp, t0
3229:             and          t1, a2, t5
3230:             mulhsu       s3, s1, a6
3231:             addi         s10, s1, 3
3232:             divu         t5, a0, zero
3233:             blt          a4, s1, 3243f
3234:             slli         s1, s5, 8
3235:             xor          s9, t1, tp
3236:             sub          s9, a6, s0
3237:             sltu         a1, sp, s2
3238:             andi         s0, t6, 1517
3239:             div          gp, s5, s4
3240:             bltu         a2, tp, 3243f
3241:             addi         s11, a3, 796
3242:             sll          s0, s0, a5
3243:             mulhsu       t0, gp, a1
3244:             srli         s5, t4, 23
3245:             remu         a7, zero, gp
3246:             csrrwi       a7, 0x342, 31
3247:             andi         s1, s0, 1785
3248:             bne          ra, gp, 3263f
3249:             sub          s0, t0, s1
3250:             bne          s7, sp, 3253f
3251:             srai         s6, a0, 8
3252:             beq          t2, t1, 3263f
3253:             andi         a0, a3, -992
3254:             slti         tp, sp, -570
3255:             sltiu        t5, s7, -772
3256:             andi         zero, a6, -1239
3257:             or           a2, s6, s9
3258:             divu         a7, a6, a6
3259:             mulhu        zero, s11, t5
3260:             csrrs        a0, 0x344, zero
3261:             sll          s2, a3, sp
3262:             or           a7, s7, a4
3263:             mulh         t6, s0, tp
3264:             slt          t0, a6, a2
3265:             sll          s9, s5, s0
3266:             blt          a2, zero, 3284f
3267:             sra          s11, a4, sp
3268:             mulhu        s4, s11, tp
3269:             bgeu         s9, s8, 3281f
3270:             mulhu        ra, s4, s2
3271:             div          s2, t6, s3
3272:             blt          t2, t0, 3276f
3273:             div          s10, s7, ra
3274:             andi         t4, a0, -1053
3275:             slli         s6, s2, 28
3276:             lui          a7, 403869
3277:             slti         zero, s2, -224
3278:             nop
3279:             slti         s10, a2, -159
3280:             mulh         s6, s5, gp
3281:             xori         a0, gp, -2042
3282:             srli         gp, a3, 0
3283:             csrrc        s2, 0x344, zero
3284:             bge          s0, a1, 3288f
3285:             bge          s10, gp, 3287f
3286:             csrrci       s4, 0x344, 26
3287:             or           t1, s8, t5
3288:             slli         t3, s0, 31
3289:             mulhsu       s1, s0, t0
3290:             rem          s8, zero, t1
3291:             sltiu        s4, t3, -391
3292:             blt          a1, t6, 3310f
3293:             mul          s8, a4, t1
3294:             and          ra, ra, t1
3295:             mulh         s3, s2, a3
3296:             sltu         s2, t4, t5
3297:             andi         a6, a4, -63
3298:             bgeu         s3, a7, 3301f
3299:             lui          a7, 384705
3300:             sub          s11, s4, tp
3301:             csrrc        t0, 0x343, a2
3302:             or           s1, a4, s3
3303:             ori          s8, t5, 1448
3304:             bgeu         a2, s11, 3309f
3305:             lui          s5, 186900
3306:             sra          a4, t3, a1
3307:             xor          a1, s6, t6
3308:             srai         a5, ra, 13
3309:             remu         t6, s1, sp
3310:             xori         a4, a4, 152
3311:             sltu         s9, a2, a5
3312:             div          t2, t4, s5
3313:             csrrc        t3, 0x301, t2
3314:             bgeu         a7, s9, 3328f
3315:             srli         s9, t1, 18
3316:             mulh         gp, s9, t3
3317:             srl          s0, t5, s1
3318:             mulh         ra, gp, gp
3319:             blt          a0, a3, 3320f
3320:             rem          t3, t1, a1
3321:             beq          a3, a2, 3331f
3322:             beq          t0, s0, 3333f
3323:             xor          a6, s4, s5
3324:             bne          s2, t6, 3334f
3325:             andi         s4, zero, 196
3326:             sll          s8, a2, s7
3327:             mulh         s5, t5, s7
3328:             addi         t6, a0, 1131
3329:             csrrc        ra, 0x343, a3
3330:             bltu         s3, t6, 3339f
3331:             csrrwi       a1, 0x344, 11
3332:             xor          s9, a7, s3
3333:             sltiu        s6, t2, -796
3334:             csrrc        t6, 0x342, a4
3335:             srai         s1, a0, 14
3336:             csrrci       a7, 0x343, 20
3337:             beq          a4, a1, 3342f
3338:             mulh         a6, s5, a0
3339:             srli         a2, tp, 21
3340:             mulh         t0, t1, a5
3341:             nop
3342:             addi         a6, tp, 1017
3343:             slli         tp, t2, 22
3344:             rem          a6, t2, a3
3345:             sra          ra, s0, s9
3346:             nop
3347:             csrrc        t3, 0x342, s4
3348:             beq          a6, a2, 3356f
3349:             and          s6, ra, s6
3350:             srli         s0, s5, 20
3351:             slt          zero, t1, s8
                  li           s8, 0x6f8803b8 #start riscv_int_numeric_corner_stream_32
                  li           t5, 0x0
                  li           t6, 0xffffffff
                  li           a2, 0x8632f1a3
                  li           t0, 0x0
                  li           s11, 0xffffffff
                  li           ra, 0xf413c1ad
                  li           s2, 0x80000000
                  li           s1, 0x0
                  li           t2, 0x80000000
                  mulhsu       a2, t2, t0
                  add          s2, t0, s1
                  addi         s2, t2, 1318
                  mul          t0, s2, t6
                  nop
                  remu         t2, a2, t6
                  nop
                  remu         t6, s11, a2
                  sub          t2, a2, s8
                  lui          s8, 672943
                  mulhsu       s11, t6, s2
                  mul          s2, s11, s11
                  lui          s1, 960890
                  mul          s11, s1, t5
                  addi         t0, a2, -1869
                  mulh         s11, t5, t2
                  mul          t6, t2, a2
                  mulh         t0, s8, t2
                  mulhu        t0, t0, s8
                  addi         s8, t0, 915
                  rem          t2, t5, s8
                  auipc        t0, 431215
                  mulh         t5, a2, s11
                  sub          s2, t5, t0
                  addi         t6, s11, 2014
                  mulhu        s2, t2, a2
                  mulhu        s2, t2, ra
                  sub          a2, a2, s11
                  mulh         t6, s11, s1
                  rem          s1, t6, s2 #end riscv_int_numeric_corner_stream_32
3352:             slt          t4, s9, tp
3353:             bge          s8, tp, 3356f
3354:             csrrc        s11, 0x342, s2
3355:             lui          s0, 929706
3356:             lui          tp, 1024218
3357:             blt          a5, gp, 3369f
3358:             ori          s11, ra, -607
3359:             srli         s1, s2, 12
3360:             sra          t4, s8, t1
3361:             bgeu         t0, s5, 3362f
3362:             andi         s3, a7, 104
3363:             bgeu         s6, s2, 3383f
3364:             srai         t2, gp, 22
3365:             add          s3, s0, t6
3366:             csrrc        ra, 0x343, a2
3367:             srai         s2, a6, 26
3368:             sra          s6, a3, s1
3369:             auipc        tp, 530583
3370:             srli         t5, a1, 6
3371:             mulhsu       a7, s3, s6
3372:             slli         a0, s8, 28
3373:             and          a4, s7, s4
3374:             div          a0, s5, a3
3375:             div          t6, s10, s2
3376:             csrrsi       ra, 0x305, 0
3377:             sltu         s4, a2, a7
3378:             blt          t3, a5, 3380f
3379:             sra          s3, t1, s1
3380:             slti         zero, t6, -939
3381:             bge          sp, a4, 3384f
3382:             slli         s11, s6, 24
3383:             sltu         tp, a4, s9
3384:             sra          s1, tp, a0
3385:             csrrc        a4, 0x304, zero
3386:             slli         t6, s6, 25
3387:             csrrsi       s6, 0x300, 0
3388:             mul          s11, t3, t2
3389:             slti         a6, s3, -1140
3390:             bge          t6, t4, 3396f
3391:             slti         a1, t1, 1437
3392:             and          t0, t3, t1
3393:             auipc        t1, 907814
3394:             sra          tp, s6, a6
3395:             csrrwi       t0, 0x342, 16
3396:             bltu         t2, t1, 3414f
3397:             sub          s1, s11, gp
3398:             slti         s3, zero, 195
3399:             andi         t3, a6, -1772
3400:             blt          s9, t6, 3403f
3401:             slt          s4, s11, a3
3402:             bgeu         a3, a1, 3407f
3403:             ori          s1, a5, -774
3404:             mulh         a0, a6, s1
3405:             nop
3406:             mul          s8, sp, gp
3407:             blt          s7, t4, 3415f
3408:             xori         s0, s9, 1036
3409:             srli         t0, t6, 20
3410:             nop
3411:             sra          a4, a0, a0
3412:             sll          tp, tp, s9
3413:             sra          s11, t1, tp
3414:             sra          s0, s4, s11
3415:             xor          s1, a6, a5
3416:             mulh         t3, s6, s1
3417:             bne          s1, s10, 3430f
3418:             srl          a2, s11, s2
3419:             blt          t2, s11, 3422f
3420:             blt          s11, a5, 3424f
3421:             bne          s1, gp, 3439f
3422:             sltu         t4, gp, t4
3423:             blt          s0, s11, 3438f
3424:             sltu         a0, a3, sp
3425:             addi         t4, ra, -193
3426:             bgeu         sp, a2, 3429f
3427:             addi         t6, a4, -962
3428:             bge          t2, s4, 3442f
                  la           t2, region_1+54519 #start riscv_load_store_rand_instr_stream_12
                  lh           s9, -11(t2)
                  lw           zero, 1(t2)
                  lh           s8, 1(t2)
                  auipc        t5, 431380
                  lb           tp, -8(t2)
                  lbu          s1, -8(t2)
                  sb           s11, 10(t2)
                  slti         tp, a3, -200
                  sb           s11, -6(t2)
                  slt          ra, a4, t3
                  sra          a4, s5, s1
                  nop
                  slt          s3, zero, s6
                  lbu          s4, -4(t2)
                  lbu          tp, 9(t2)
                  or           s1, a3, s5
                  csrrci       a1, 0x300, 0
                  mulhsu       a7, tp, s6
                  sb           s4, 15(t2)
                  sb           tp, 11(t2)
                  lb           a1, -6(t2)
                  csrrwi       ra, 0x343, 17
                  lhu          s0, -15(t2)
                  or           s8, sp, s5
                  auipc        t0, 476363
                  lhu          s2, -9(t2)
                  lb           s1, -16(t2)
                  lh           s4, 9(t2)
                  lb           s9, 0(t2)
                  csrrw        zero, 0x342, s5
                  sb           a7, -13(t2)
                  andi         t5, ra, -1583
                  csrrc        a0, 0x344, s3
                  sh           tp, -5(t2)
                  sh           t3, -1(t2)
                  and          s8, s8, a0
                  lb           t1, -5(t2) #end riscv_load_store_rand_instr_stream_12
3429:             sltiu        t1, s2, 1811
3430:             csrrwi       a1, 0x301, 9
3431:             bne          s7, s2, 3438f
3432:             slli         tp, s7, 4
3433:             sltiu        a0, a1, -1390
3434:             srli         tp, a1, 3
3435:             sltu         s6, a4, s10
3436:             sll          t5, s6, a3
3437:             mulhu        s1, a6, s2
3438:             add          s10, s5, s11
3439:             csrrci       t6, 0x305, 0
3440:             xori         t0, t4, 1331
3441:             csrrwi       tp, 0x343, 17
3442:             slli         a2, a7, 31
3443:             div          s4, ra, s10
3444:             nop
3445:             beq          a6, t4, 3456f
3446:             remu         t5, t6, t6
3447:             csrrs        a0, 0x342, a1
3448:             sub          a1, zero, a0
3449:             sll          tp, s2, s2
3450:             csrrci       a1, 0x344, 0
3451:             beq          s1, a0, 3452f
3452:             bltu         sp, gp, 3456f
3453:             mulh         t5, s9, t1
3454:             andi         a2, s11, -1767
3455:             sll          s1, t6, a3
3456:             mulhu        s5, t3, s4
3457:             sll          a0, s6, s9
3458:             lui          t0, 2862
3459:             sub          t4, ra, s11
3460:             csrrc        a4, 0x342, zero
3461:             beq          a0, s0, 3472f
3462:             xori         a4, zero, -1453
3463:             nop
3464:             addi         ra, a5, -1655
3465:             xori         s4, zero, -418
3466:             csrrwi       s4, 0x343, 6
3467:             or           a6, s0, t5
3468:             srli         s0, s6, 12
3469:             sub          s11, s9, a2
3470:             bgeu         a0, s6, 3474f
3471:             bltu         t2, s4, 3481f
3472:             csrrwi       s4, 0x342, 8
3473:             bne          t3, t4, 3474f
3474:             csrrwi       s4, 0x301, 21
3475:             slt          s11, t1, a4
3476:             mulhu        t3, t3, s2
3477:             bgeu         s2, t4, 3480f
3478:             mulh         a0, a0, s4
3479:             sra          s6, s9, t6
3480:             bltu         s7, s11, 3500f
3481:             slt          s8, a0, s3
3482:             auipc        t1, 131425
3483:             div          t1, s10, s1
3484:             mulhsu       s1, s10, s3
3485:             add          s6, t2, t0
3486:             slti         s5, s2, 2009
3487:             mulhsu       s8, gp, s2
3488:             sltiu        t6, s11, 139
3489:             mulhu        zero, a7, t5
3490:             csrrc        a7, 0x344, s6
3491:             slli         a4, s1, 19
3492:             mul          a5, s7, t0
3493:             xor          t3, t1, a3
3494:             mulh         gp, t3, t4
3495:             csrrci       ra, 0x301, 20
3496:             or           s1, s1, s10
3497:             remu         s9, a0, a7
3498:             csrrs        t3, 0x305, zero
3499:             remu         s5, gp, s1
3500:             mulh         a1, s6, s11
3501:             mulhsu       a6, s9, s3
3502:             sra          t0, s0, s4
3503:             slt          s0, t3, t3
3504:             slli         a1, t2, 11
3505:             slti         a1, s1, 1407
3506:             mul          t6, s11, a1
3507:             divu         s1, a2, a4
3508:             lui          a1, 556809
3509:             mul          t5, s10, t1
3510:             divu         t5, a2, s11
3511:             lui          s1, 126890
3512:             sra          s5, s5, s8
3513:             mulh         ra, gp, a5
3514:             csrrc        t6, 0x344, s4
3515:             sltu         t0, s4, s4
3516:             srli         gp, a7, 5
3517:             add          s2, a2, tp
3518:             sub          t1, s11, a1
3519:             slli         t0, t5, 4
3520:             auipc        a5, 812738
3521:             mul          zero, t4, a0
3522:             bne          t3, sp, 3533f
3523:             divu         a5, s10, s5
3524:             slti         a5, t1, 1851
3525:             addi         zero, s9, 1645
3526:             blt          a7, a6, 3531f
3527:             sltiu        a6, a0, -59
3528:             remu         tp, a4, sp
3529:             bltu         t4, s9, 3532f
3530:             rem          s10, a5, s6
3531:             mul          t4, t5, t1
3532:             csrrsi       a7, 0x342, 0
3533:             ori          a4, zero, 1247
3534:             bge          t6, t4, 3552f
3535:             srai         s4, s3, 28
3536:             sub          s1, s8, t3
3537:             mulh         a2, a4, s9
3538:             mulh         s2, t5, t2
3539:             div          s2, s0, a7
3540:             srli         s2, t1, 15
3541:             remu         s1, s10, a7
3542:             lui          s10, 801424
3543:             srli         s11, zero, 1
3544:             sltiu        s10, s0, 1019
3545:             beq          a1, sp, 3553f
3546:             mulhu        s3, s3, s3
3547:             srai         s2, a0, 6
3548:             csrrsi       t1, 0x300, 0
3549:             nop
3550:             addi         s8, sp, 683
3551:             blt          a3, a5, 3555f
3552:             slti         tp, s10, 979
3553:             add          t2, a1, s9
3554:             nop
3555:             csrrci       a7, 0x301, 24
3556:             bge          tp, tp, 3563f
3557:             bgeu         s8, t5, 3560f
3558:             mulh         a5, a0, s11
3559:             lui          s11, 699604
3560:             slti         t4, s8, -1332
3561:             andi         s2, s0, 204
3562:             divu         s8, s4, t3
3563:             remu         a6, s10, t3
3564:             mulhsu       s11, a7, a3
3565:             csrrw        a7, 0x304, t2
3566:             remu         s8, gp, s4
3567:             ori          t1, s5, 1659
3568:             rem          s0, t0, s2
3569:             sub          a1, ra, tp
3570:             mulh         t3, s11, a2
3571:             andi         s5, s8, -1299
3572:             xor          a2, t3, a0
3573:             slti         a6, a3, 1118
3574:             sra          a7, a4, s7
3575:             add          s2, t2, a7
3576:             sll          s2, a6, s3
3577:             slli         s6, a6, 0
3578:             beq          sp, a0, 3582f
3579:             bltu         t2, a0, 3591f
3580:             csrrci       a7, 0x300, 0
3581:             rem          s6, s8, s7
3582:             addi         t0, t2, -1071
3583:             mulh         a6, ra, s3
3584:             addi         zero, a0, -1256
3585:             xor          a6, a0, t1
3586:             slt          s3, t3, s1
3587:             or           s8, a0, gp
3588:             lui          s2, 482340
3589:             bgeu         s10, t6, 3590f
3590:             sra          s1, t3, t0
3591:             srli         s10, s9, 18
3592:             slt          a6, s2, t4
3593:             csrrci       s8, 0x343, 0
3594:             sltu         a0, a7, t2
3595:             sll          zero, a0, s7
3596:             sltu         s6, s6, s7
3597:             bltu         sp, s8, 3601f
3598:             auipc        gp, 295466
3599:             csrrc        t1, 0x301, zero
3600:             mulhsu       s9, a2, t0
3601:             auipc        t6, 978400
3602:             add          tp, s1, s6
3603:             slt          s4, a1, t4
3604:             xori         zero, s4, 444
3605:             sra          t1, ra, s4
3606:             slli         gp, s11, 24
3607:             ori          t0, s8, 274
3608:             addi         t4, s10, -1758
3609:             nop
3610:             bgeu         t0, s5, 3612f
3611:             bge          s1, t5, 3621f
3612:             sub          t6, a0, t0
3613:             blt          t1, s11, 3627f
3614:             csrrsi       t6, 0x305, 0
3615:             srli         a0, t4, 14
3616:             srl          s1, s10, tp
3617:             srli         a1, a7, 29
3618:             srl          s8, s4, ra
3619:             nop
3620:             csrrci       s3, 0x305, 0
3621:             slti         s10, s10, -417
3622:             sltiu        a6, a5, 397
3623:             add          s1, a2, s3
3624:             sub          ra, a1, a3
3625:             sll          s10, s9, ra
3626:             beq          s10, a0, 3636f
3627:             slt          a5, s2, s8
3628:             slt          a5, s6, s1
3629:             sra          t4, s7, t3
3630:             bne          a5, a6, 3635f
3631:             rem          t3, t2, s0
3632:             slti         s6, s11, 453
3633:             csrrwi       s8, 0x304, 20
3634:             mulh         t3, s7, zero
3635:             xori         ra, s10, 105
3636:             auipc        s8, 514947
3637:             sltiu        s1, a2, -1393
3638:             sll          a1, a7, s10
3639:             bne          s6, t0, 3657f
3640:             csrrs        gp, 0x305, zero
3641:             csrrwi       a2, 0x342, 18
3642:             sub          s10, s11, s4
3643:             csrrsi       a4, 0x301, 17
3644:             mulh         t1, s2, a0
3645:             csrrci       a7, 0x305, 0
3646:             slt          s2, s6, t0
3647:             mulhsu       a6, s9, s10
3648:             slti         t2, s1, -373
3649:             csrrc        t0, 0x343, zero
3650:             sltiu        s8, s9, 996
3651:             lui          a7, 568489
3652:             or           s5, s9, t0
3653:             sltiu        t5, s8, 103
3654:             divu         s8, s6, s10
3655:             auipc        s3, 758705
3656:             slt          t6, sp, s8
3657:             addi         zero, s2, -1418
3658:             sub          s9, a2, a2
3659:             csrrwi       t5, 0x343, 18
3660:             mulhsu       s9, s4, t0
3661:             mul          a4, gp, sp
3662:             mulhsu       s6, s0, s0
3663:             andi         a6, s10, 1110
3664:             bge          zero, t6, 3677f
3665:             bne          t5, a1, 3680f
3666:             add          t3, t0, s5
3667:             csrrc        s9, 0x301, ra
3668:             mulhu        tp, a2, sp
3669:             addi         a4, zero, 262
3670:             csrrwi       s9, 0x304, 23
3671:             rem          a4, a0, s2
3672:             sll          s11, s1, t5
3673:             csrrs        s4, 0x342, a5
3674:             slli         gp, t2, 3
3675:             csrrwi       a1, 0x304, 9
3676:             sltiu        a4, t1, -185
3677:             nop
3678:             blt          tp, a2, 3681f
3679:             xori         a1, zero, -1168
3680:             slli         gp, t0, 10
3681:             sra          t5, t2, a3
3682:             sltiu        s9, ra, 1183
3683:             bltu         t6, t4, 3694f
3684:             sub          ra, s9, gp
3685:             bne          sp, t3, 3694f
3686:             rem          tp, t0, a0
3687:             rem          s9, t5, t5
3688:             divu         zero, a0, tp
3689:             csrrw        s0, 0x344, t2
3690:             div          zero, s8, t5
3691:             addi         gp, t6, 1903
3692:             or           s1, a3, s1
3693:             beq          s1, s1, 3696f
3694:             xori         s11, sp, -1858
3695:             bgeu         gp, a6, 3706f
3696:             xor          s3, s10, a5
3697:             xori         a6, a3, -1006
3698:             slli         a0, s3, 26
3699:             csrrs        a2, 0x304, s1
3700:             mulhsu       ra, s2, s10
3701:             csrrwi       a4, 0x342, 25
3702:             beq          sp, a7, 3710f
3703:             add          a4, s3, ra
3704:             addi         a6, zero, -1219
3705:             bge          a6, s11, 3711f
3706:             csrrci       ra, 0x304, 19
3707:             xor          s3, s8, a6
3708:             srli         t0, s8, 24
3709:             bne          t2, t4, 3720f
3710:             csrrci       s0, 0x342, 0
3711:             div          zero, a6, sp
3712:             ori          s6, s9, -1136
3713:             divu         zero, t2, t5
3714:             slli         s1, a2, 6
3715:             sltu         s6, s6, a0
3716:             lui          s10, 128215
3717:             mulhu        a4, t2, s1
3718:             sub          ra, a1, t6
3719:             csrrs        a0, 0x304, s7
3720:             xori         s0, t3, -1054
3721:             xori         a6, t2, -297
3722:             mulh         a2, a0, s10
3723:             addi         s9, s1, -204
3724:             rem          s10, s8, a0
3725:             bge          t2, zero, 3745f
3726:             nop
3727:             mulh         s4, s1, s8
3728:             bge          s7, a0, 3739f
3729:             csrrs        t0, 0x305, zero
3730:             addi         t6, s3, -805
3731:             xori         t4, s1, 1322
3732:             sll          a1, s8, s3
3733:             slti         a2, a1, -108
3734:             srli         a0, a0, 21
3735:             blt          s4, s7, 3739f
3736:             csrrci       tp, 0x342, 6
3737:             bgeu         ra, s2, 3748f
3738:             xori         s4, a1, 1830
3739:             auipc        t5, 462845
3740:             bltu         t2, t4, 3743f
3741:             bge          s4, t5, 3747f
3742:             bne          a1, t6, 3744f
3743:             csrrs        s0, 0x304, tp
                  li           t0, 0x7ef5591d #start riscv_int_numeric_corner_stream_25
                  li           t1, 0xffffffff
                  li           s0, 0x0
                  li           a5, 0xffffffff
                  li           s8, 0x0
                  li           s1, 0x80000000
                  li           s5, 0x80000000
                  li           t6, 0x1e193f0e
                  li           t3, 0xffffffff
                  li           tp, 0x80000000
                  mulh         a5, s1, s5
                  mulhu        s1, t6, t0
                  mulh         a5, a5, t3
                  nop
                  div          s8, t0, a5
                  add          s8, t0, s8
                  mulh         s5, t0, t1
                  rem          t3, tp, tp
                  mul          s0, t6, s0
                  remu         s0, t6, s5
                  mulh         s5, s8, t0
                  remu         a5, s8, tp
                  mulh         t6, tp, t0
                  div          s5, s1, t6
                  mulhsu       t6, s5, t3
                  add          t0, t1, a5 #end riscv_int_numeric_corner_stream_25
3744:             csrrsi       t4, 0x343, 27
3745:             mulhu        s9, t6, s0
3746:             bne          t4, a0, 3759f
3747:             csrrwi       tp, 0x343, 6
3748:             slt          s10, zero, a3
3749:             srl          t6, a2, t3
3750:             and          zero, tp, t6
3751:             slli         t2, a1, 20
3752:             csrrw        s1, 0x342, s9
3753:             sltu         s1, s11, t0
3754:             csrrw        a7, 0x343, a0
3755:             xori         t3, s1, -834
3756:             addi         s6, s1, 472
3757:             nop
3758:             and          a2, t1, s11
3759:             mulh         gp, t5, sp
3760:             or           s4, a3, s2
3761:             bgeu         s10, s10, 3764f
3762:             mulhsu       s5, s2, s10
3763:             lui          s9, 599059
3764:             srai         s4, s0, 19
3765:             csrrw        s4, 0x344, a0
3766:             auipc        a1, 26115
3767:             xori         a4, s9, -925
3768:             nop
3769:             mulh         s3, a6, zero
3770:             or           a7, s7, s5
3771:             addi         s8, a7, 941
3772:             sub          ra, sp, ra
3773:             mul          s5, a2, a6
3774:             csrrs        s11, 0x301, zero
3775:             bgeu         s3, s11, 3787f
3776:             sll          s4, t6, a5
3777:             bne          ra, s8, 3778f
3778:             bge          ra, s5, 3782f
3779:             beq          zero, gp, 3788f
3780:             sll          t2, a2, t3
3781:             xor          s3, s4, s9
3782:             xor          a1, tp, t2
3783:             csrrci       t4, 0x305, 0
3784:             blt          s11, a6, 3787f
3785:             divu         a0, t4, sp
3786:             srai         a7, s1, 24
3787:             slli         a1, s7, 18
3788:             csrrw        t3, 0x342, s10
3789:             rem          t2, gp, sp
3790:             ori          s10, a2, 813
3791:             nop
3792:             sub          s10, s2, s4
3793:             nop
3794:             sll          a1, t5, s2
3795:             mul          zero, t5, s11
3796:             csrrci       gp, 0x305, 0
3797:             csrrsi       gp, 0x300, 0
3798:             slt          t1, ra, ra
3799:             bge          t4, s11, 3803f
3800:             div          t2, a2, tp
3801:             rem          s9, s5, t4
3802:             addi         s0, t2, -1966
3803:             div          ra, sp, s3
3804:             srli         s0, sp, 0
3805:             srai         zero, t6, 13
                  la           a0, region_0+2524 #start riscv_hazard_instr_stream_38
                  lb           s1, -15(a0)
                  lbu          s8, 2(a0)
                  mulh         ra, a7, s1
                  sb           s8, 3(a0)
                  and          ra, a7, ra
                  lw           s8, 12(a0)
                  csrrwi       a7, 0x343, 8
                  lbu          a7, -14(a0)
                  lb           s4, 11(a0)
                  ori          s6, ra, 1451
                  lb           s4, 3(a0)
                  and          a7, s6, a7
                  xori         s8, s1, -2019
                  lb           s8, -1(a0)
                  sltiu        s1, s8, 1224
                  mulhsu       ra, ra, s6
                  lui          ra, 821970
                  rem          s4, a7, s1
                  lh           a7, 8(a0)
                  lb           s8, 6(a0)
                  sb           ra, 13(a0)
                  sb           a7, 0(a0)
                  div          a7, ra, s1
                  csrrci       s1, 0x301, 0
                  addi         s8, a7, 1595
                  csrrs        s4, 0x344, s4
                  addi         s6, a7, 50
                  slti         s8, a7, 1067
                  csrrs        ra, 0x343, s6
                  lbu          s4, 9(a0)
                  csrrci       s8, 0x301, 0
                  lw           ra, 12(a0)
                  sll          a7, s8, s6
                  csrrci       s1, 0x342, 6
                  andi         s8, ra, 696
                  lb           s4, -16(a0)
                  csrrwi       ra, 0x343, 5
                  andi         ra, s1, -1420
                  lh           s1, -12(a0)
                  sb           s8, 5(a0)
                  csrrci       s8, 0x342, 6
                  slti         s6, s1, 1493
                  lh           s1, 8(a0)
                  csrrc        s8, 0x304, s4
                  sb           s1, -9(a0) #end riscv_hazard_instr_stream_38
3806:             srai         s3, t0, 28
3807:             mulhsu       s9, a2, a5
3808:             csrrwi       s9, 0x342, 9
3809:             and          s8, a2, a3
3810:             bgeu         a5, ra, 3818f
3811:             srai         s2, s6, 0
3812:             add          s11, a0, zero
3813:             add          ra, t0, gp
3814:             csrrwi       a6, 0x304, 14
3815:             nop
3816:             addi         t6, s1, -124
3817:             xori         s0, a7, 1233
3818:             srli         t6, s6, 30
3819:             mulhsu       s1, s8, gp
3820:             lui          a1, 47263
3821:             mulh         s3, a3, tp
3822:             srl          s3, s7, s10
3823:             slt          t5, a0, s4
3824:             csrrs        s8, 0x304, t3
3825:             slti         s1, s8, -550
3826:             mulhsu       gp, t4, t1
3827:             beq          t2, t6, 3832f
3828:             ori          a7, t6, -763
3829:             mulhsu       s9, s8, s9
3830:             bge          a7, t5, 3838f
3831:             remu         s8, s5, a4
3832:             sll          s3, s6, s6
3833:             beq          s4, s8, 3840f
3834:             sltu         t0, ra, a1
3835:             slti         t2, a0, -1416
3836:             remu         s2, s9, s1
3837:             rem          s10, s5, s0
3838:             csrrwi       t1, 0x344, 4
3839:             csrrwi       t0, 0x301, 14
3840:             remu         s6, a6, s10
3841:             bne          t5, s7, 3844f
3842:             beq          s11, s0, 3860f
3843:             sra          s6, a3, a0
3844:             sltu         a6, sp, a5
3845:             div          t3, s11, ra
3846:             rem          s1, s11, ra
3847:             nop
3848:             bne          zero, a5, 3863f
3849:             lui          a5, 874878
3850:             sra          t2, ra, s11
3851:             csrrs        s4, 0x305, zero
3852:             csrrsi       s6, 0x342, 0
3853:             and          t2, a0, s5
3854:             addi         zero, a4, 1143
3855:             mul          t0, t2, zero
3856:             mulh         s2, a3, s7
3857:             andi         tp, zero, 423
3858:             addi         s10, a6, -74
3859:             bltu         a5, a2, 3873f
3860:             lui          gp, 90170
3861:             mulhu        t3, a3, a0
3862:             addi         s3, a1, 460
3863:             csrrci       s2, 0x305, 0
3864:             nop
3865:             mulh         a1, s5, a5
3866:             ori          ra, gp, -627
3867:             lui          s1, 504114
3868:             nop
3869:             srl          a7, s4, a0
3870:             bge          t1, a2, 3880f
3871:             nop
3872:             nop
3873:             auipc        s9, 272246
3874:             mulhu        a5, a0, tp
3875:             sub          ra, s8, a1
3876:             lui          tp, 309538
3877:             sltiu        t1, a1, -1119
3878:             mulhsu       t6, a1, s5
3879:             and          t1, a3, t5
3880:             srai         s3, t4, 22
3881:             srli         s4, s1, 8
3882:             srai         s6, t4, 27
3883:             blt          a1, s1, 3886f
3884:             nop
3885:             xori         a1, s1, 850
3886:             csrrsi       tp, 0x343, 27
3887:             csrrwi       s11, 0x343, 8
3888:             sra          ra, s10, s2
3889:             srli         t4, s8, 25
3890:             slti         gp, a4, -1191
                  la           s6, region_1+16437 #start riscv_hazard_instr_stream_23
                  divu         t2, t2, a5
                  sra          s0, a5, t1
                  sub          t1, s0, t2
                  add          ra, s3, s0
                  sb           t1, -843(s6)
                  sb           ra, 1943(s6)
                  sltu         ra, ra, ra
                  lb           ra, 1382(s6)
                  sb           t2, 1356(s6)
                  sb           s3, -1005(s6)
                  sh           s0, -1875(s6)
                  mul          t2, ra, s3
                  sb           s0, -1198(s6)
                  sh           s3, 1429(s6)
                  div          a5, t1, s3
                  mulh         ra, t1, ra
                  lbu          ra, -1046(s6)
                  lh           t2, 1197(s6)
                  csrrs        s3, 0x343, a5
                  divu         t1, s0, s0
                  csrrwi       s3, 0x343, 17
                  lbu          a5, -1414(s6)
                  csrrc        ra, 0x343, t1
                  lh           s3, -337(s6)
                  or           ra, ra, t2
                  sb           t1, -820(s6)
                  sw           a5, 1559(s6)
                  add          t2, ra, s3
                  lbu          s0, 395(s6) #end riscv_hazard_instr_stream_23
3891:             sub          s1, s11, s8
3892:             srl          s3, a4, a1
3893:             rem          t0, a4, s7
3894:             srl          zero, a4, s2
3895:             sll          s1, a5, s2
3896:             sltiu        t6, a6, -1885
3897:             sltu         a0, t5, s5
3898:             ori          s3, a7, 1560
3899:             ori          s9, t3, 1751
3900:             sltu         s10, s1, t4
3901:             mulh         t6, tp, zero
3902:             add          a4, t4, s3
                  li           t5, 0x80000000 #start riscv_int_numeric_corner_stream_0
                  li           a6, 0x8e17d3f0
                  li           s8, 0x80000000
                  li           gp, 0x80000000
                  li           s11, 0xffffffff
                  li           s5, 0x0
                  li           ra, 0x0
                  li           s10, 0xfd0e9ab2
                  li           a7, 0x80000000
                  li           a5, 0x0
                  mulh         a5, s10, gp
                  mulhsu       s10, a6, s8
                  mulh         s8, s10, s10
                  addi         t5, t5, -1254
                  lui          s8, 138170
                  add          a5, s8, a5
                  mul          a5, t5, s8
                  nop
                  addi         a5, a6, 2032
                  rem          t5, s10, s10
                  nop
                  sub          a6, s10, ra
                  rem          a5, ra, s10
                  sub          a7, s11, s10
                  mulhu        t5, s8, a7
                  sub          s11, ra, a7
                  rem          s5, t5, a7
                  rem          gp, s11, ra
                  divu         gp, s8, ra
                  mulh         s11, a7, ra
                  divu         t5, s11, a6
                  auipc        s8, 638464
                  add          gp, ra, a7
                  lui          s11, 907838
                  divu         ra, s8, ra
                  addi         s5, a5, -207
                  rem          a6, gp, a5
                  lui          a7, 955022 #end riscv_int_numeric_corner_stream_0
3903:             divu         s11, t2, s11
3904:             ori          s5, s7, -84
3905:             lui          s6, 609801
3906:             sub          t6, a1, a2
3907:             srl          a6, s0, s2
3908:             lui          t2, 686656
3909:             remu         s10, s2, s10
3910:             sra          s0, s3, gp
3911:             sub          t4, s6, t4
3912:             csrrw        t3, 0x344, a3
3913:             ori          t4, s9, 1461
3914:             addi         t1, a4, 535
3915:             mulhsu       s10, s1, t6
3916:             lui          t0, 290524
3917:             lui          t1, 533344
3918:             csrrs        s9, 0x344, a6
3919:             csrrs        s6, 0x344, s2
3920:             slli         s3, s4, 8
3921:             rem          t4, a3, t3
3922:             andi         s4, s9, 595
3923:             srli         t0, ra, 5
3924:             srli         t1, s10, 19
3925:             sub          t6, zero, t4
3926:             bge          s3, t6, 3931f
3927:             auipc        t5, 594796
3928:             srl          s1, a2, ra
3929:             blt          s6, a0, 3947f
3930:             csrrw        s1, 0x342, t0
3931:             bltu         t6, a3, 3932f
3932:             srl          a2, a2, s6
3933:             blt          t1, ra, 3943f
3934:             addi         a7, a5, 170
3935:             divu         t2, t2, s3
3936:             srai         a7, t3, 11
3937:             csrrci       s0, 0x300, 0
3938:             mulhsu       s6, t5, a1
3939:             mulh         s2, s9, sp
3940:             blt          s5, s4, 3943f
3941:             xori         s0, ra, 590
3942:             nop
3943:             div          t1, t6, gp
3944:             div          s8, s1, a3
3945:             slt          t6, t2, a2
3946:             xor          s10, a5, s1
3947:             csrrs        s2, 0x343, zero
3948:             slt          s0, s11, s6
3949:             srai         s1, t4, 14
3950:             slti         s9, s9, -1746
3951:             or           a0, s1, gp
3952:             blt          s7, s7, 3954f
3953:             srli         a2, t0, 31
3954:             csrrsi       zero, 0x304, 15
3955:             add          t3, t6, a4
3956:             slti         s6, s10, -562
3957:             mulh         a0, ra, t2
3958:             sltiu        s9, tp, -567
3959:             csrrs        t4, 0x342, s9
3960:             addi         gp, a5, 1081
3961:             add          s0, s11, sp
3962:             beq          s9, ra, 3976f
3963:             or           s4, s3, gp
3964:             slli         a2, a7, 4
3965:             add          a2, s10, zero
3966:             srli         a2, a0, 12
3967:             csrrs        s2, 0x344, zero
3968:             csrrwi       s5, 0x343, 17
3969:             xor          a0, t6, t4
3970:             sltiu        gp, a2, 1807
3971:             csrrsi       t5, 0x343, 0
3972:             slti         a1, t6, 523
3973:             andi         s3, a2, 1701
3974:             beq          s0, t1, 3977f
3975:             sltu         t5, gp, s5
3976:             auipc        zero, 852607
3977:             mul          s6, t2, t1
3978:             beq          a0, t6, 3981f
3979:             andi         t2, s9, 1393
3980:             sra          a0, t2, t2
3981:             remu         ra, a2, a2
3982:             csrrci       ra, 0x342, 0
3983:             beq          zero, zero, 3991f
3984:             csrrwi       tp, 0x342, 21
3985:             sltu         s3, t3, s6
3986:             mulhu        s11, a7, t1
3987:             xori         t6, ra, -313
3988:             blt          gp, a4, 3989f
3989:             csrrc        tp, 0x301, zero
3990:             csrrw        t1, 0x304, s6
3991:             csrrci       gp, 0x305, 0
3992:             slli         s5, s4, 8
3993:             csrrc        ra, 0x344, t3
3994:             mulhu        s0, gp, s8
3995:             add          a1, s8, s9
3996:             sltiu        t0, t5, -1762
3997:             divu         s1, tp, a3
3998:             srl          gp, a4, a2
3999:             mul          s10, a4, a7
4000:             bltu         s10, t5, 4008f
4001:             blt          a5, a1, 4012f
4002:             andi         s8, zero, -812
4003:             csrrwi       s2, 0x342, 30
4004:             addi         s0, a5, -452
4005:             add          a1, s11, a0
4006:             bltu         a7, a2, 4012f
4007:             bge          t3, s9, 4016f
4008:             bltu         s8, a2, 4015f
4009:             or           a7, sp, t5
4010:             slt          s5, a2, s0
4011:             rem          t1, a0, t0
4012:             slli         t4, s8, 19
4013:             nop
4014:             bltu         sp, t3, 4024f
4015:             add          t0, t2, zero
4016:             sltiu        a1, s1, 1534
4017:             slti         a6, a3, -1350
4018:             remu         s10, s8, t1
4019:             lui          t5, 71787
4020:             srl          gp, s4, zero
4021:             auipc        s2, 879496
4022:             mulh         s0, a2, s2
4023:             auipc        s10, 890868
4024:             slti         t2, t2, -1761
4025:             and          a7, a7, s8
4026:             divu         t4, t5, tp
4027:             csrrs        t4, 0x343, ra
4028:             srli         a0, s8, 10
4029:             csrrci       a0, 0x300, 0
4030:             csrrs        a2, 0x343, a0
4031:             mulhu        a0, a4, t6
4032:             srl          zero, s6, a3
4033:             sltiu        s0, s7, -279
4034:             csrrwi       t3, 0x344, 5
4035:             or           t6, a7, a5
4036:             and          s6, t6, a3
4037:             addi         s0, a1, -1164
4038:             slli         a7, t4, 15
4039:             csrrw        a1, 0x343, t1
4040:             mul          s0, gp, s11
4041:             xor          a5, a1, ra
4042:             slt          t4, s1, s5
4043:             csrrs        t2, 0x343, zero
4044:             add          s2, s7, s6
4045:             slli         a7, s6, 1
4046:             add          s4, s6, ra
4047:             sra          t4, s5, s0
4048:             mulh         a5, s9, gp
4049:             mulhsu       s10, s10, tp
4050:             srl          gp, a0, s0
4051:             andi         s5, a7, -1955
4052:             add          t1, a4, s2
4053:             xor          s0, s4, s1
4054:             or           t4, a5, t1
4055:             mul          a4, s9, t0
4056:             srl          a0, t4, a3
4057:             srl          s1, s3, s2
4058:             bgeu         s10, t6, 4059f
4059:             rem          s11, zero, a2
4060:             csrrsi       s11, 0x300, 0
4061:             lui          t2, 790263
4062:             mulhu        zero, ra, s11
4063:             slt          t3, ra, a7
4064:             csrrc        zero, 0x342, s3
4065:             mulhu        tp, t2, a3
4066:             auipc        a0, 599485
4067:             xor          t3, t1, a4
4068:             srli         a5, s11, 19
4069:             remu         a2, a7, t4
4070:             nop
4071:             bltu         s0, t6, 4091f
4072:             mulh         t2, t3, s2
4073:             andi         t5, s0, 552
4074:             sra          t6, a2, s11
4075:             srl          s9, a3, gp
4076:             nop
4077:             bltu         a0, zero, 4087f
4078:             bne          ra, s8, 4081f
4079:             sll          a0, t0, s9
4080:             auipc        a1, 187829
                  li           t5, 0x0 #start riscv_int_numeric_corner_stream_34
                  li           s11, 0xffffffff
                  li           t2, 0x80000000
                  li           s3, 0x0
                  li           a5, 0xffffffff
                  li           s8, 0x68856d5
                  li           s5, 0x0
                  li           a7, 0xffffffff
                  li           a2, 0x40d225e4
                  li           s1, 0x9e9de92e
                  mulhu        s11, s3, s11
                  sub          s5, a2, s8
                  mul          s8, a5, a2
                  addi         s3, a5, 1308
                  nop
                  lui          a5, 946913
                  lui          s5, 795423
                  mul          a7, s1, s1
                  mulhu        t2, s3, t2
                  div          s8, a5, s1
                  nop
                  rem          s5, s3, s11
                  sub          t2, s5, t5
                  auipc        s11, 559271
                  add          a5, s8, t2
                  nop
                  nop
                  lui          a2, 197401
                  mul          t5, s1, a7
                  mulhu        a7, s1, a5
                  lui          s11, 96444
                  nop
                  mulhsu       t5, s1, s1
                  auipc        s5, 345731 #end riscv_int_numeric_corner_stream_34
4081:             sll          s9, t0, s5
4082:             xor          s2, s11, t2
4083:             csrrsi       a5, 0x342, 5
4084:             nop
4085:             mulhu        gp, s7, t4
4086:             xor          s11, s9, a7
4087:             mulh         ra, gp, a4
4088:             slti         a5, a2, 1902
4089:             slli         a0, s2, 8
4090:             sltu         a2, t6, t4
4091:             add          s0, t1, t0
4092:             or           t1, s5, s1
4093:             sub          t6, s11, s8
4094:             divu         a2, a4, s7
4095:             xori         s6, a3, 217
4096:             mulhsu       tp, s10, t3
4097:             srli         s0, a5, 21
4098:             divu         t6, a6, a4
4099:             beq          a1, t1, 4117f
4100:             mulhu        t4, s6, s11
4101:             add          s0, sp, a7
4102:             bne          a5, s7, 4106f
4103:             bge          s9, a3, 4108f
4104:             sub          a5, gp, t3
4105:             csrrc        s11, 0x304, s2
4106:             slt          a0, t1, t4
4107:             csrrw        s6, 0x304, a1
4108:             csrrc        a6, 0x300, zero
4109:             csrrs        s3, 0x304, zero
4110:             lui          tp, 1018628
4111:             csrrsi       a6, 0x304, 11
4112:             srl          ra, s8, a0
4113:             sltiu        t1, a0, 1599
4114:             bltu         t3, t6, 4129f
4115:             slli         t2, t2, 8
4116:             or           tp, a4, a5
4117:             div          a6, a2, s0
4118:             csrrw        a5, 0x342, sp
4119:             andi         ra, t6, -1860
4120:             slt          t6, zero, s10
4121:             sra          s6, s3, s2
4122:             auipc        s10, 285690
4123:             and          t5, a1, s9
4124:             mulhu        a1, s5, s0
4125:             bgeu         s9, s5, 4129f
4126:             slti         a0, zero, -1702
4127:             addi         zero, a1, 1633
4128:             auipc        s10, 760221
4129:             beq          t6, s8, 4140f
4130:             bge          s0, ra, 4135f
4131:             srli         s1, t3, 17
4132:             sltu         s8, s2, a7
4133:             csrrw        s5, 0x344, s3
4134:             csrrw        gp, 0x344, s3
4135:             csrrw        s6, 0x344, t6
4136:             div          t4, t6, t5
4137:             csrrc        s9, 0x301, t0
4138:             srai         s10, a4, 13
4139:             xori         s11, a0, -1257
4140:             remu         t6, s1, a1
4141:             bne          s0, s4, 4154f
4142:             bne          s8, s8, 4160f
4143:             srli         t0, a5, 10
4144:             csrrwi       s4, 0x344, 27
4145:             srai         s2, s3, 6
4146:             rem          a5, s1, a6
4147:             beq          t5, t4, 4158f
4148:             csrrwi       a2, 0x344, 16
4149:             sll          t2, sp, s5
4150:             srl          s5, t3, s0
4151:             slt          zero, a4, gp
4152:             nop
4153:             auipc        t3, 470535
4154:             blt          s0, s8, 4158f
4155:             srli         s0, sp, 17
4156:             beq          t4, s0, 4159f
4157:             lui          ra, 944364
4158:             srl          a1, a7, t3
4159:             mulhu        t4, s10, a0
4160:             csrrwi       s4, 0x344, 30
4161:             andi         a1, tp, 448
4162:             mul          s3, gp, s2
4163:             xor          t4, s7, s11
4164:             or           t3, s3, a6
4165:             beq          a2, a1, 4177f
4166:             csrrwi       t2, 0x344, 2
4167:             divu         a1, s7, t5
4168:             add          s6, a1, t2
4169:             srli         a0, a3, 26
4170:             csrrci       a2, 0x301, 0
4171:             bltu         s4, s3, 4182f
4172:             xor          t6, t4, tp
4173:             csrrc        s3, 0x344, s4
4174:             ori          a6, s7, -1809
4175:             div          a4, t5, zero
4176:             sltu         ra, t0, s6
4177:             sub          s9, tp, t0
4178:             csrrsi       s4, 0x301, 15
4179:             nop
4180:             srli         t0, s3, 14
4181:             sra          t4, t3, a6
4182:             andi         a4, t3, 1251
4183:             addi         s0, t3, -809
4184:             csrrc        s2, 0x342, zero
4185:             bgeu         s2, a3, 4188f
4186:             sub          tp, a6, sp
4187:             sra          t2, a1, gp
4188:             mul          s2, a2, t6
4189:             mulh         tp, s11, a4
4190:             remu         t4, s2, t2
4191:             srl          s10, a7, a4
4192:             csrrwi       s4, 0x342, 5
4193:             bne          a1, a3, 4211f
4194:             divu         s1, t5, s3
4195:             csrrsi       a7, 0x342, 0
4196:             beq          a1, s2, 4199f
4197:             div          s6, s2, s11
4198:             srai         a7, a1, 3
4199:             slt          t6, s4, s6
4200:             csrrwi       zero, 0x343, 31
4201:             mulhsu       zero, s9, a5
4202:             sra          t5, a2, s1
4203:             mul          t5, zero, s9
4204:             nop
4205:             sltu         gp, a4, s8
4206:             blt          sp, s5, 4210f
4207:             csrrci       s4, 0x300, 0
4208:             add          t4, s0, ra
4209:             bge          s4, s3, 4219f
4210:             sll          t1, ra, s6
4211:             csrrsi       s1, 0x300, 0
4212:             divu         s5, s1, a0
4213:             csrrc        tp, 0x344, s2
4214:             andi         ra, t6, -774
4215:             slli         s9, s4, 5
4216:             remu         zero, a2, t4
4217:             csrrsi       s9, 0x342, 20
4218:             srl          gp, ra, a1
4219:             slti         s1, s2, 908
4220:             addi         a2, a7, 957
4221:             sub          s4, s2, s8
4222:             sll          zero, a0, a1
4223:             blt          a2, t0, 4241f
4224:             mulhsu       t5, t1, s0
4225:             rem          s8, t4, t2
4226:             or           s9, s8, s10
4227:             remu         a7, s8, s10
4228:             xori         s1, a6, -1455
4229:             mul          a2, a5, a5
4230:             lui          a4, 763971
4231:             bge          t1, t4, 4234f
4232:             xori         zero, a6, 166
4233:             auipc        tp, 555432
4234:             mulhsu       a5, s10, a0
4235:             rem          s0, a7, tp
4236:             addi         a1, t5, 1096
4237:             mulh         t0, a0, s5
4238:             xori         a1, a2, -317
4239:             bltu         gp, zero, 4244f
4240:             csrrsi       a7, 0x304, 5
4241:             csrrw        s5, 0x304, a4
4242:             add          s4, gp, a1
4243:             remu         t4, a7, a1
4244:             slt          t6, s2, s1
4245:             srai         s6, t1, 6
4246:             addi         s6, ra, 2046
4247:             xori         s5, t3, -1390
4248:             csrrc        s3, 0x305, zero
4249:             andi         tp, s4, -1797
4250:             mul          s9, a0, zero
4251:             add          t5, ra, zero
4252:             csrrs        ra, 0x305, zero
4253:             sll          s5, s8, s11
4254:             auipc        a5, 765265
4255:             sra          s5, s7, s7
4256:             slti         s2, a5, 44
4257:             add          a1, a1, t1
4258:             lui          t1, 466184
4259:             sra          a6, s9, a7
4260:             xori         s3, a3, 428
4261:             mulhu        a0, s4, s7
4262:             nop
4263:             bltu         t6, s11, 4278f
4264:             sra          s3, sp, s6
4265:             addi         a6, a4, -1779
4266:             ori          t4, tp, -1947
4267:             mul          zero, a0, t3
4268:             csrrc        gp, 0x304, s3
4269:             sra          t4, s7, zero
4270:             and          s2, a1, t3
4271:             or           s2, tp, a6
4272:             csrrs        t0, 0x342, zero
4273:             mul          a1, a0, a7
4274:             csrrs        a1, 0x300, zero
4275:             or           t0, t1, gp
4276:             srl          s3, a6, t2
4277:             and          s1, t5, a1
4278:             slli         a5, s0, 15
4279:             srli         s6, a5, 15
4280:             andi         t5, t0, 980
4281:             addi         a7, s9, -27
4282:             csrrci       s2, 0x305, 0
4283:             mulh         s4, t3, s2
4284:             and          zero, t2, a3
4285:             srli         t1, t5, 0
4286:             addi         t0, t6, -1788
4287:             bgeu         sp, s0, 4299f
4288:             divu         tp, s9, t0
4289:             add          a7, tp, t3
4290:             mulhu        t5, s4, tp
4291:             csrrwi       s5, 0x304, 4
4292:             slli         tp, gp, 17
4293:             sll          s0, s4, s0
4294:             srli         t0, gp, 18
                  la           t6, region_1+46224 #start riscv_load_store_rand_instr_stream_38
                  sb           t5, -7(t6)
                  add          s3, a6, s4
                  ori          a0, s1, 1472
                  add          s0, a1, sp
                  lbu          s1, 5(t6)
                  csrrs        t1, 0x300, zero
                  csrrs        tp, 0x304, zero
                  lb           s2, 8(t6)
                  srli         t4, ra, 16
                  lb           t5, 9(t6)
                  sb           tp, 11(t6)
                  lb           a0, 6(t6)
                  and          t3, t5, s5
                  mul          s8, a3, t2
                  sb           s9, 15(t6)
                  lh           t3, 10(t6)
                  xor          a2, t0, a3
                  auipc        a1, 208964
                  sb           a3, -15(t6)
                  lui          s10, 718469
                  remu         s11, s7, s2
                  lb           s9, 10(t6)
                  mulhsu       s11, zero, ra
                  sub          t3, s7, a4
                  lb           s2, 8(t6)
                  lb           s11, -10(t6)
                  remu         gp, s9, a4
                  lh           zero, 10(t6)
                  lh           t1, -2(t6)
                  sh           s1, -6(t6)
                  sb           a0, -15(t6)
                  lhu          s3, 12(t6)
                  lh           s6, 12(t6)
                  lb           s9, -9(t6) #end riscv_load_store_rand_instr_stream_38
4295:             bge          zero, t6, 4315f
4296:             xori         s3, t5, 1866
4297:             xori         a6, a5, -1470
4298:             xori         a6, t2, 19
4299:             rem          t2, a6, s1
4300:             and          t6, s11, s5
4301:             csrrc        a7, 0x342, zero
4302:             blt          ra, a5, 4308f
4303:             sub          s6, zero, s11
4304:             and          s4, s5, t0
4305:             sltiu        zero, s10, -817
4306:             andi         zero, s5, -1789
4307:             blt          a5, a1, 4310f
4308:             beq          s6, s1, 4322f
4309:             xor          s2, s6, zero
4310:             srai         t0, a4, 21
4311:             mul          t4, t3, a7
4312:             bge          t2, a2, 4316f
4313:             slt          s0, t0, s11
4314:             mulhu        t4, a6, a2
4315:             csrrw        a5, 0x301, s2
4316:             bge          s1, a2, 4326f
4317:             divu         tp, a5, s0
4318:             andi         s11, a2, 1710
4319:             divu         t5, s10, ra
4320:             srai         s2, t2, 20
4321:             mul          ra, a6, s3
4322:             xor          a4, s11, a7
4323:             xori         t6, t0, -653
4324:             andi         a1, a1, 1484
4325:             lui          s2, 378114
4326:             mulhsu       t0, gp, ra
4327:             and          a1, s11, s9
4328:             mulhsu       a0, s7, s11
4329:             sub          ra, s11, a4
4330:             divu         ra, tp, s0
4331:             ori          a1, s2, -751
4332:             mulh         s11, s5, a4
4333:             blt          s7, t3, 4344f
4334:             beq          t1, ra, 4338f
4335:             mulh         a0, t5, t1
4336:             div          a5, s10, tp
4337:             bgeu         t3, t4, 4340f
4338:             srai         t0, a2, 8
                  addi         s1, zero, 9 #init loop 0 counter
                  slli         t2, a6, 16
                  csrrs        s9, 0x344, t4
                  addi         s8, zero, 5 #init loop 0 limit
                  xori         s6, gp, -1778
                  and          s9, t6, a4
                  csrrsi       a5, 0x305, 0
main_233_0_t:     xori         s9, s4, -73
                  addi         s1, s1, -3 #update loop 0 counter
                  srli         s2, ra, 18
                  bgeu         s1, s8, main_233_0_t #branch for loop 0
                  lui          s11, 478497
4339:             nop
4340:             bge          a6, a0, 4341f
4341:             sra          a7, s7, a4
4342:             csrrci       a6, 0x301, 15
4343:             andi         t2, t1, 1277
4344:             add          a7, gp, s5
4345:             csrrci       a4, 0x305, 0
4346:             add          ra, ra, t2
4347:             xori         t6, a1, -136
4348:             xor          t3, t1, s2
4349:             blt          t0, t5, 4350f
4350:             bge          s11, a6, 4357f
4351:             remu         a1, t3, a7
4352:             blt          ra, sp, 4363f
4353:             mulhsu       s11, s2, s11
main_86:          jal          t4, 14f
0:                jal          t1, 18f
1:                jal          ra, 6f
2:                jal          t1, 19f
3:                jal          t1, 7f
4:                jal          ra, 11f
5:                jal          s8, 15f
6:                jal          t0, 13f
7:                jal          ra, 5b
8:                jal          ra, 1b
9:                jal          ra, 16f
10:               jal          t1, 8b
11:               jal          ra, 12f
12:               jal          s9, 3b
13:               jal          ra, 17f
14:               jal          s2, 10b
15:               jal          gp, 9b
16:               jal          s8, 0b
17:               jal          ra, 2b
18:               jal          t1, 20f
19:               jal          ra, 4b
20:               addi         s1, gp, 1215
4354:             mul          s2, a6, s1
4355:             csrrc        a0, 0x301, zero
4356:             csrrw        t4, 0x342, a3
4357:             ori          t3, s4, -1413
4358:             xori         a0, ra, -954
4359:             srai         tp, t4, 0
4360:             andi         t3, t3, -1451
4361:             mulhu        t0, s8, s9
4362:             divu         t6, a0, t0
4363:             mulhsu       a4, s6, ra
4364:             bne          sp, t1, 4369f
4365:             divu         s9, a2, gp
4366:             add          t5, ra, t5
4367:             addi         a6, t2, -1735
4368:             sltiu        gp, a6, -1911
4369:             csrrs        t3, 0x305, zero
4370:             andi         s2, s8, -178
4371:             sltu         ra, s6, a4
4372:             csrrw        t1, 0x344, a0
4373:             remu         a0, s5, t5
4374:             beq          ra, a4, 4387f
4375:             and          s9, a6, a7
4376:             ori          t1, t4, 724
4377:             bgeu         t2, a3, 4385f
4378:             xor          t4, t3, a7
4379:             csrrs        t5, 0x342, s10
4380:             csrrs        a6, 0x305, zero
4381:             sltu         a0, a7, t2
4382:             mulhsu       s2, t6, sp
4383:             xor          s9, sp, s5
4384:             sltu         a4, tp, t1
4385:             bge          t5, a7, 4394f
4386:             lui          s1, 709896
4387:             sll          s8, s11, s3
4388:             or           s8, ra, s6
4389:             sltiu        t2, zero, 756
4390:             csrrs        s6, 0x344, s6
4391:             csrrwi       a2, 0x304, 20
4392:             sra          a0, a7, gp
4393:             bgeu         s10, gp, 4401f
4394:             or           zero, s6, t6
4395:             bgeu         a5, t4, 4397f
4396:             slli         tp, a1, 22
4397:             andi         t1, t5, -623
4398:             slti         t0, s5, 117
4399:             lui          t5, 27818
4400:             csrrsi       s10, 0x342, 0
4401:             nop
4402:             or           tp, s4, t3
4403:             bltu         s7, s2, 4407f
4404:             and          s5, s5, a2
4405:             csrrsi       a1, 0x342, 0
4406:             sra          s9, t4, t5
4407:             sra          t3, a0, t2
4408:             slti         t3, s1, 1907
4409:             srai         s9, t1, 1
4410:             csrrs        s2, 0x344, zero
4411:             mul          t0, a7, t1
4412:             csrrwi       s4, 0x344, 23
4413:             sub          tp, s3, s6
4414:             beq          a2, a6, 4417f
4415:             ori          a1, s11, 187
4416:             csrrs        s4, 0x344, a5
4417:             and          a6, a0, zero
4418:             csrrwi       s10, 0x342, 21
4419:             csrrw        s9, 0x301, s1
4420:             andi         s3, s2, -252
4421:             mul          s2, s3, sp
4422:             mulhu        a4, s7, a0
4423:             ori          s9, s8, -1472
4424:             mul          s3, ra, t4
4425:             and          s2, t2, t0
4426:             lui          gp, 1023386
4427:             mulh         s10, s4, ra
4428:             bgeu         s9, a5, 4432f
4429:             beq          a5, s7, 4441f
4430:             slt          s4, a5, t1
4431:             bne          t0, t4, 4442f
4432:             addi         zero, s6, 909
4433:             blt          a2, s1, 4436f
4434:             and          t4, s8, tp
4435:             ori          s10, ra, -323
4436:             bge          a6, s7, 4439f
4437:             csrrc        a2, 0x305, zero
4438:             and          t5, s7, a3
4439:             sltu         a5, t1, s9
4440:             rem          s10, s7, s8
4441:             sltiu        a5, zero, 1423
4442:             bgeu         a2, t1, 4453f
4443:             rem          gp, s5, s4
4444:             and          t5, s11, s3
4445:             bltu         a4, t3, 4446f
4446:             beq          a4, t4, 4456f
4447:             slli         s4, t4, 28
4448:             ori          ra, s9, 671
4449:             bne          a1, s8, 4462f
4450:             auipc        t3, 639609
4451:             mul          t4, sp, s0
4452:             slt          tp, a6, s3
4453:             xor          a1, s5, s7
4454:             rem          s2, t3, s3
4455:             srli         a7, s9, 29
4456:             divu         zero, a5, a7
4457:             csrrsi       s10, 0x342, 10
4458:             xori         s2, a7, -873
4459:             csrrc        t0, 0x344, ra
4460:             sll          s5, s9, a5
4461:             csrrsi       s2, 0x343, 0
4462:             srl          s2, s9, s1
4463:             mulh         zero, t3, t6
4464:             andi         s11, a1, 1138
4465:             csrrc        a1, 0x305, zero
4466:             bge          ra, s5, 4468f
4467:             beq          t2, s6, 4475f
4468:             and          tp, s0, t2
4469:             remu         t6, a1, tp
4470:             sub          s2, s0, s8
4471:             ori          s3, t3, 1880
4472:             or           t5, a0, zero
4473:             slt          a2, a4, tp
4474:             and          zero, s5, ra
4475:             slt          t0, s8, t3
4476:             or           a0, gp, tp
4477:             mulhu        a4, t3, t5
4478:             mulhu        s11, s3, s2
4479:             beq          s8, a6, 4497f
4480:             nop
4481:             srai         ra, s4, 0
4482:             csrrw        s9, 0x342, a1
4483:             divu         gp, a3, s9
4484:             csrrci       a7, 0x343, 0
4485:             slt          s11, gp, t1
4486:             or           a2, s11, s6
4487:             csrrwi       t3, 0x342, 0
4488:             xor          a6, t2, a0
4489:             beq          a2, s8, 4490f
4490:             srai         t3, t2, 25
4491:             xor          s5, s2, t6
4492:             srli         s9, s8, 25
4493:             csrrs        s5, 0x342, t2
4494:             srli         s10, a6, 22
4495:             mulhu        ra, s8, t4
4496:             bne          s9, ra, 4503f
4497:             mulhu        tp, a2, gp
4498:             xor          s11, t3, s5
4499:             rem          a5, s5, a6
4500:             srl          gp, t3, a4
4501:             bgeu         s0, a0, 4506f
4502:             blt          ra, s6, 4505f
4503:             bge          t1, ra, 4513f
4504:             mul          s11, s1, s6
4505:             andi         a0, a1, 1926
4506:             beq          t2, a7, 4517f
4507:             rem          t2, a4, sp
4508:             blt          t1, s8, 4517f
4509:             divu         a4, a6, a1
4510:             csrrw        s3, 0x344, s10
4511:             bne          t4, a2, 4516f
4512:             csrrwi       t2, 0x304, 28
4513:             bne          s5, t1, 4533f
4514:             nop
4515:             auipc        s5, 898488
4516:             rem          s6, a6, s8
4517:             blt          t5, t2, 4535f
4518:             slt          gp, a6, s8
4519:             mul          t1, s0, a6
4520:             andi         a1, a0, 1671
4521:             csrrsi       zero, 0x343, 13
4522:             ori          a2, s10, 818
4523:             lui          gp, 24726
4524:             ori          a1, s8, -1775
4525:             xor          t1, a6, s2
4526:             csrrwi       ra, 0x342, 0
4527:             sltiu        zero, a4, -759
4528:             xori         tp, s8, 1831
4529:             csrrci       t4, 0x344, 10
4530:             mulhu        a5, a5, tp
4531:             or           zero, a0, gp
4532:             csrrc        s3, 0x343, t3
4533:             divu         s9, s1, s4
4534:             sltiu        s5, t5, -570
4535:             mulhsu       a1, s4, s7
4536:             beq          t4, gp, 4551f
4537:             csrrc        a7, 0x344, s8
4538:             xor          a6, t6, a0
4539:             csrrs        a5, 0x343, t6
4540:             addi         s6, a0, 1438
4541:             divu         a2, a6, s2
4542:             bltu         tp, a5, 4556f
4543:             mulh         t5, sp, s6
4544:             beq          t1, t6, 4552f
4545:             nop
4546:             remu         a1, s11, s2
4547:             csrrwi       s9, 0x301, 3
4548:             ori          t6, s6, -1899
4549:             mulhsu       s9, a0, a1
4550:             remu         s4, gp, s8
4551:             auipc        zero, 486556
4552:             bgeu         a0, t2, 4558f
4553:             lui          a2, 191284
4554:             bgeu         tp, t0, 4558f
4555:             bge          a5, t1, 4558f
4556:             slt          t0, t3, t5
4557:             and          tp, t4, s6
4558:             csrrc        a4, 0x342, a3
4559:             srli         a6, t6, 27
4560:             mulhu        a4, s3, s5
4561:             csrrc        s10, 0x344, s2
4562:             sub          a6, t5, s11
4563:             csrrw        a0, 0x301, gp
4564:             ori          s9, s5, -1488
4565:             rem          t5, t0, s6
4566:             divu         a7, a2, tp
4567:             add          t6, a4, t2
4568:             sltu         a2, s8, s5
4569:             addi         s6, s1, 790
4570:             sub          s3, a1, a5
4571:             rem          ra, a3, t6
4572:             srai         gp, a3, 24
4573:             nop
4574:             ori          s6, s1, -463
4575:             nop
4576:             csrrci       s5, 0x301, 0
4577:             csrrwi       t4, 0x304, 7
4578:             srli         t2, s7, 1
4579:             sub          t5, a0, ra
4580:             nop
4581:             srl          s3, s6, a1
4582:             beq          a4, s5, 4585f
4583:             csrrwi       gp, 0x301, 10
4584:             mulhsu       s11, t1, s10
4585:             rem          t4, zero, a5
4586:             csrrwi       zero, 0x343, 6
4587:             addi         ra, t3, -275
4588:             csrrs        zero, 0x305, zero
4589:             csrrw        s10, 0x343, a3
4590:             mulh         t1, s1, s0
4591:             addi         a2, a4, 843
4592:             bne          a4, a7, 4605f
4593:             sub          s2, t3, t2
4594:             nop
4595:             xori         a2, s7, 981
4596:             auipc        s0, 878818
4597:             rem          a2, a5, s1
4598:             bgeu         t0, tp, 4599f
4599:             nop
4600:             or           s4, s10, sp
4601:             andi         s2, s4, 1081
4602:             remu         s1, s5, a7
4603:             blt          s11, a2, 4606f
4604:             divu         a1, a4, a5
4605:             nop
4606:             beq          a4, s6, 4611f
4607:             csrrsi       zero, 0x304, 16
4608:             sll          a2, a4, a3
4609:             or           s4, a0, a3
4610:             xor          s8, s7, a4
4611:             nop
4612:             add          a6, tp, s10
4613:             xor          s11, t2, s6
4614:             srl          s6, a3, a6
4615:             sra          a2, a1, a5
4616:             xori         t0, t3, 656
4617:             srai         s5, a5, 1
4618:             mul          t5, zero, s11
4619:             and          t5, s1, t5
4620:             mul          t4, s2, s10
4621:             xori         s0, sp, 263
4622:             beq          s3, a7, 4633f
4623:             slli         a1, t3, 12
4624:             xor          s10, s8, s4
4625:             andi         zero, s3, 368
4626:             lui          s1, 129839
4627:             or           ra, s11, ra
4628:             srli         a2, s0, 28
4629:             rem          a2, s8, t0
4630:             csrrwi       s8, 0x304, 5
4631:             mulhsu       t0, a0, s11
4632:             csrrsi       s8, 0x301, 0
4633:             div          s9, t3, t5
4634:             bne          s7, t0, 4637f
4635:             csrrs        a6, 0x343, zero
4636:             csrrci       a4, 0x301, 0
4637:             or           ra, a5, gp
4638:             sub          t3, s2, a7
4639:             sll          t2, s6, t6
4640:             srai         zero, a1, 24
4641:             csrrsi       s6, 0x305, 0
4642:             slli         t2, tp, 7
4643:             srai         s6, a2, 7
4644:             slt          t5, t3, s8
4645:             sub          t1, s8, s11
4646:             bge          s5, t5, 4649f
4647:             csrrci       s8, 0x305, 0
4648:             nop
4649:             auipc        t2, 569212
4650:             lui          a6, 718336
4651:             csrrs        a4, 0x343, zero
4652:             and          t3, t1, s7
4653:             bge          t0, s0, 4668f
4654:             bgeu         t3, t6, 4666f
4655:             srl          s0, t1, s1
4656:             xori         s2, t5, 1499
4657:             srli         t0, s6, 7
4658:             div          a4, a6, sp
4659:             srl          s10, t3, s4
4660:             sub          t0, s10, a5
4661:             lui          s2, 23251
4662:             csrrsi       zero, 0x343, 12
4663:             xori         tp, s9, 1546
4664:             auipc        s8, 1040601
4665:             sub          s1, s10, s1
4666:             nop
4667:             lui          tp, 229402
4668:             blt          t2, t1, 4677f
4669:             csrrs        ra, 0x301, zero
4670:             and          tp, s3, sp
4671:             bltu         a3, s5, 4685f
4672:             sra          t1, a7, a6
4673:             srl          s6, a0, s0
4674:             add          a4, zero, s10
4675:             andi         t4, ra, -1241
4676:             slli         a7, s4, 20
4677:             ori          zero, a2, -1766
4678:             bne          s3, t0, 4680f
4679:             sra          s5, s2, t5
4680:             mul          s4, s11, a0
4681:             sub          a2, a0, ra
4682:             lui          a5, 173163
4683:             csrrsi       a2, 0x305, 0
4684:             xori         a7, s3, 897
4685:             srli         ra, s10, 1
4686:             sltiu        a6, t6, -1162
4687:             divu         a6, s5, s9
4688:             srli         tp, s7, 7
4689:             csrrw        t3, 0x304, sp
4690:             bne          a0, a4, 4697f
4691:             or           a5, t2, t1
4692:             slti         s3, s7, -1547
4693:             div          gp, s3, t5
4694:             srli         a4, gp, 8
4695:             beq          a4, a4, 4700f
4696:             sub          s4, a6, ra
4697:             csrrci       t4, 0x301, 0
4698:             divu         s0, a6, tp
4699:             beq          t0, s5, 4709f
4700:             and          t2, gp, zero
4701:             lui          s5, 1024902
4702:             or           s5, s8, t1
4703:             csrrci       t0, 0x344, 8
4704:             xor          t3, a4, s3
4705:             bne          t1, t2, 4713f
4706:             sra          a5, t3, s9
4707:             addi         s1, a2, 22
4708:             sll          t3, t3, t0
4709:             bge          s9, s5, 4720f
4710:             sltu         s3, s6, a6
4711:             srai         s4, sp, 2
4712:             csrrci       t0, 0x344, 15
4713:             csrrs        s11, 0x305, zero
4714:             csrrw        ra, 0x301, s4
4715:             mulhu        s10, s9, t2
4716:             csrrs        t3, 0x300, zero
4717:             csrrci       s1, 0x344, 0
4718:             add          s6, s11, a1
4719:             bgeu         s1, a2, 4730f
4720:             xori         s8, s4, 1075
4721:             addi         s3, a5, 233
4722:             csrrc        s4, 0x300, zero
4723:             and          t2, tp, a5
4724:             csrrci       gp, 0x344, 20
4725:             lui          tp, 330698
4726:             sltu         t2, s7, s7
4727:             div          s9, a3, a4
4728:             mulhsu       t4, t0, a3
4729:             bltu         s9, s3, 4733f
4730:             auipc        t1, 917427
4731:             lui          a4, 360754
4732:             rem          s11, t2, gp
4733:             beq          s4, s6, 4734f
4734:             addi         t6, t0, 1936
4735:             csrrwi       s10, 0x343, 7
4736:             mul          s9, a7, s5
4737:             mulhu        a4, t1, s1
4738:             mulhsu       t1, a2, s11
4739:             csrrwi       s2, 0x304, 21
4740:             sltu         s11, a4, s8
4741:             csrrc        s8, 0x344, s5
4742:             bgeu         t4, s7, 4748f
4743:             bge          s7, a3, 4753f
4744:             andi         tp, a6, -1449
4745:             sll          s8, t2, a2
4746:             srli         t1, tp, 0
4747:             srl          s0, s2, t4
4748:             csrrsi       a4, 0x343, 0
4749:             srli         a2, s8, 0
4750:             srai         s1, a5, 8
4751:             ori          gp, s1, 1865
4752:             andi         s6, s9, 1354
4753:             csrrw        zero, 0x301, a7
4754:             bge          t1, a3, 4758f
4755:             mul          s2, zero, t2
4756:             bge          tp, a3, 4764f
4757:             bgeu         t0, sp, 4760f
4758:             xor          s2, t5, s8
4759:             slli         a6, a7, 14
4760:             divu         t0, s7, s10
4761:             srl          a4, sp, a5
4762:             slt          s5, s10, s9
4763:             sra          s0, t0, s2
4764:             sra          s1, ra, s3
4765:             andi         s1, s8, 385
4766:             xori         zero, s3, -1333
4767:             csrrsi       a2, 0x344, 0
4768:             beq          ra, a6, 4788f
4769:             csrrci       a7, 0x305, 0
4770:             mulhsu       a1, s9, a2
4771:             andi         t2, t6, 338
4772:             csrrs        s11, 0x305, zero
4773:             csrrwi       s6, 0x343, 5
4774:             csrrc        t5, 0x343, zero
4775:             andi         t2, a4, 573
4776:             mulhu        ra, ra, s6
4777:             slt          t6, s3, a5
4778:             bne          t3, a4, 4782f
4779:             csrrsi       t1, 0x343, 12
4780:             bgeu         a4, ra, 4798f
4781:             sltiu        s3, s5, 362
4782:             mulhsu       s6, s7, sp
4783:             bgeu         a3, s1, 4801f
4784:             div          s2, zero, s8
4785:             beq          t6, t4, 4803f
4786:             mulhsu       s11, a4, gp
4787:             sub          t2, zero, t5
4788:             csrrsi       t0, 0x344, 0
4789:             auipc        a4, 769802
4790:             bltu         t2, t5, 4808f
4791:             csrrwi       s4, 0x301, 2
4792:             csrrwi       s1, 0x344, 19
4793:             div          ra, s2, ra
4794:             sra          gp, t0, t3
4795:             rem          s2, s5, s4
4796:             srl          a5, a0, s3
4797:             csrrci       a4, 0x343, 0
4798:             csrrwi       zero, 0x342, 18
4799:             nop
4800:             remu         t2, t4, s10
4801:             csrrs        s0, 0x344, zero
4802:             srl          s0, s0, a7
4803:             rem          t3, a5, ra
4804:             csrrci       ra, 0x344, 0
4805:             div          t0, zero, s7
4806:             beq          t5, a3, 4814f
4807:             srli         s3, sp, 3
4808:             srai         s3, a3, 12
4809:             auipc        s3, 135419
4810:             auipc        gp, 205291
4811:             or           s1, t3, zero
4812:             sltu         s11, a4, a4
4813:             srai         a4, tp, 31
4814:             xori         tp, sp, -2015
4815:             sub          t3, s0, gp
4816:             xori         t3, t5, 1075
4817:             bge          t5, t5, 4837f
4818:             xor          tp, a1, a5
4819:             or           s5, a6, a4
4820:             sltiu        a4, t2, 678
4821:             divu         t2, s9, s8
4822:             andi         a4, t2, 1252
4823:             auipc        t3, 535495
4824:             bltu         a3, s3, 4827f
4825:             blt          t3, s6, 4829f
4826:             nop
4827:             remu         t2, zero, s5
4828:             xor          t5, ra, gp
4829:             sll          ra, t4, s10
4830:             slti         a0, s1, -1239
4831:             csrrci       s6, 0x305, 0
4832:             or           t3, ra, t3
4833:             csrrw        t6, 0x342, s0
4834:             csrrw        tp, 0x344, gp
4835:             ori          tp, a3, 1930
4836:             bltu         t3, a6, 4849f
4837:             blt          a1, s7, 4852f
4838:             csrrsi       t1, 0x344, 0
4839:             slt          s9, a2, ra
4840:             slt          s10, s7, a7
4841:             and          t4, s8, s7
4842:             srl          s9, t4, s1
4843:             bgeu         t0, s1, 4854f
4844:             bge          a2, zero, 4852f
4845:             ori          s4, t4, -1008
4846:             csrrs        a7, 0x344, gp
4847:             blt          a7, t4, 4857f
4848:             sltu         a1, s3, t1
4849:             csrrsi       tp, 0x344, 0
4850:             sra          t4, t2, gp
4851:             or           t1, s10, sp
4852:             mulhu        t2, s2, a2
4853:             sra          t0, a6, a6
4854:             csrrw        gp, 0x304, t6
4855:             csrrsi       s5, 0x305, 0
4856:             divu         s5, t5, a0
4857:             slti         s0, t1, 1801
4858:             remu         zero, t6, a3
4859:             div          gp, t5, s3
4860:             csrrci       t3, 0x301, 5
4861:             bltu         s9, a7, 4865f
4862:             mulh         zero, a5, s9
4863:             slti         s2, s9, -1822
4864:             csrrci       s4, 0x304, 18
4865:             csrrci       t2, 0x305, 0
4866:             mul          a7, t3, s2
4867:             csrrci       a0, 0x305, 0
4868:             bgeu         s1, tp, 4871f
4869:             sltiu        gp, t3, -1460
4870:             and          t6, a7, t3
4871:             mulh         ra, t1, s1
4872:             csrrs        s6, 0x305, zero
4873:             slli         t6, s6, 23
4874:             blt          ra, sp, 4883f
4875:             lui          s3, 813926
4876:             sll          t4, zero, s0
4877:             beq          t0, s7, 4891f
4878:             csrrwi       tp, 0x342, 26
4879:             bge          a6, s1, 4880f
4880:             sll          gp, gp, gp
4881:             divu         t1, s1, zero
4882:             xor          a1, s0, s7
4883:             srli         t6, s5, 5
4884:             srl          t5, s8, t0
4885:             csrrwi       t5, 0x301, 13
4886:             csrrci       a0, 0x343, 0
4887:             ori          t6, a3, -198
4888:             csrrs        s4, 0x342, t4
4889:             xori         t6, s8, 257
4890:             beq          t4, a4, 4895f
4891:             srl          gp, s6, a1
4892:             slti         s0, s2, 1335
4893:             bltu         s5, t3, 4903f
4894:             lui          a0, 273909
4895:             csrrc        s10, 0x342, a0
4896:             sll          s0, zero, tp
4897:             beq          a1, a7, 4909f
4898:             slli         t5, s6, 14
4899:             rem          a5, sp, s9
4900:             blt          s2, s0, 4907f
4901:             auipc        t0, 603948
4902:             csrrsi       s1, 0x342, 0
4903:             mulh         s6, t5, a7
4904:             nop
4905:             nop
4906:             add          a1, s8, t5
4907:             andi         t0, t6, -1440
4908:             csrrsi       t4, 0x344, 0
4909:             csrrwi       gp, 0x342, 0
4910:             xori         a0, s5, 1749
4911:             remu         ra, a2, s4
4912:             blt          t2, t5, 4915f
4913:             slli         ra, a1, 31
4914:             srai         a0, s9, 29
4915:             slti         t2, a5, -684
4916:             csrrw        zero, 0x301, a4
4917:             csrrs        t3, 0x344, a5
4918:             slt          s2, t0, a4
4919:             or           a2, t5, s10
4920:             beq          tp, t4, 4923f
4921:             slti         a0, a6, -60
4922:             slt          t2, t3, s0
4923:             nop
4924:             bltu         s9, a5, 4935f
4925:             bltu         s2, a0, 4929f
4926:             sra          s0, t6, t6
4927:             mul          s10, s6, s5
4928:             nop
4929:             andi         s3, ra, -743
4930:             or           a2, s9, t3
4931:             mulhsu       t3, tp, sp
4932:             slt          s6, s7, t3
4933:             slt          t5, t1, t5
4934:             addi         a1, sp, 2036
4935:             sub          s10, s6, t3
4936:             rem          s8, a5, s5
4937:             slti         s1, t3, 853
4938:             csrrs        s3, 0x344, s3
4939:             div          s11, a7, s0
4940:             sll          s11, s6, a4
4941:             add          a4, a6, sp
4942:             xor          s4, t1, s11
4943:             nop
4944:             beq          s4, t3, 4955f
4945:             bgeu         a2, tp, 4946f
4946:             remu         s0, tp, a6
4947:             sltu         s1, s3, t4
4948:             div          a4, s0, a2
4949:             slt          t2, s11, s0
4950:             mulhu        s1, a1, s1
4951:             bgeu         tp, t1, 4957f
4952:             andi         gp, s3, -372
4953:             slt          s0, s2, t3
4954:             slti         s2, s2, -165
4955:             mul          t1, s2, s3
4956:             sra          s5, t2, a0
4957:             and          tp, s6, t6
4958:             andi         t5, gp, 648
4959:             or           s9, a4, s4
4960:             mulhsu       gp, s3, a2
4961:             csrrwi       s0, 0x343, 14
4962:             add          gp, a1, s11
4963:             div          gp, t3, a2
4964:             csrrs        t2, 0x344, zero
4965:             mulh         a5, s0, s3
4966:             beq          s6, t5, 4969f
4967:             csrrs        t1, 0x342, zero
4968:             slti         t4, s0, -1749
4969:             slt          tp, t6, a1
4970:             andi         s6, s6, -1910
4971:             srli         t5, t5, 30
4972:             mulhu        zero, t4, s0
4973:             bge          t0, a4, 4978f
4974:             sltiu        s9, tp, -128
4975:             lui          t6, 226362
4976:             bne          tp, s7, 4978f
4977:             nop
4978:             csrrwi       t4, 0x344, 7
4979:             csrrci       a1, 0x304, 0
4980:             remu         t3, s3, t5
4981:             bne          a4, s1, 4985f
4982:             sub          t1, t6, t6
4983:             csrrsi       t6, 0x305, 0
4984:             andi         a6, a3, 1292
4985:             xor          s10, t4, s0
4986:             srli         t0, sp, 2
4987:             xor          s10, s5, gp
4988:             xori         t1, ra, -1122
4989:             bgeu         s6, sp, 4990f
4990:             csrrwi       t4, 0x301, 5
4991:             div          tp, s3, gp
4992:             csrrsi       a4, 0x301, 0
4993:             xor          s8, zero, a1
4994:             csrrwi       s11, 0x304, 30
4995:             sltiu        s11, a7, -1060
4996:             slt          t5, gp, t4
4997:             add          t2, a2, a0
4998:             mulhu        gp, t5, s1
4999:             mul          s3, gp, a3
5000:             srai         a5, a6, 16
5001:             mulh         a5, a2, ra
5002:             ori          t2, sp, -1778
5003:             mulh         zero, t5, t5
5004:             srl          s9, a4, a4
5005:             lui          a4, 455048
5006:             nop
5007:             srai         t2, s10, 14
5008:             lui          a1, 489859
5009:             bne          a1, s9, 5020f
5010:             xor          ra, s10, s4
5011:             sltu         s4, sp, gp
5012:             csrrc        s10, 0x301, zero
5013:             csrrwi       s6, 0x343, 14
5014:             slti         t6, zero, 555
5015:             xor          s6, s0, t3
5016:             blt          s8, a5, 5028f
5017:             srli         s2, t5, 29
5018:             srai         a2, a5, 26
5019:             sltu         a2, s5, s6
5020:             bne          a3, sp, 5025f
5021:             slt          tp, t0, t3
5022:             beq          t2, zero, 5040f
5023:             ori          t1, s0, -45
5024:             lui          gp, 222822
5025:             sltu         s3, a3, a5
5026:             slti         t1, s1, 1621
5027:             divu         s0, s7, a3
5028:             blt          a3, s9, 5048f
5029:             csrrw        a4, 0x301, s5
5030:             nop
5031:             slt          a6, zero, a5
5032:             csrrw        tp, 0x342, s1
5033:             slli         s1, s4, 30
5034:             addi         gp, t1, 1832
5035:             add          zero, a2, a0
5036:             csrrwi       t2, 0x344, 1
5037:             div          a1, a7, t3
5038:             srai         a6, t2, 31
5039:             nop
5040:             remu         s3, a2, s2
5041:             srl          s3, s8, zero
5042:             divu         s0, tp, s9
5043:             bne          s5, t4, 5046f
5044:             csrrw        tp, 0x304, a0
5045:             or           s0, s11, ra
5046:             add          a6, zero, a1
5047:             mulhsu       s11, a3, t5
5048:             srai         t5, s6, 21
5049:             divu         a6, s11, s1
5050:             blt          zero, t0, 5058f
5051:             slti         t4, t2, 147
5052:             addi         s10, s1, -1480
5053:             or           t3, gp, s1
5054:             remu         s0, s7, a5
5055:             blt          s1, s1, 5058f
5056:             andi         a6, tp, 1880
5057:             mul          s4, ra, s7
5058:             mul          s4, s6, t4
5059:             srl          s5, s7, t5
5060:             xori         t6, a1, -191
5061:             xor          ra, s7, a2
5062:             bne          t4, s5, 5068f
5063:             bne          s0, t6, 5065f
5064:             slt          gp, a0, tp
5065:             srli         s4, a0, 20
5066:             srli         a7, a3, 16
5067:             csrrs        t1, 0x304, s7
5068:             sltu         a4, t2, s10
5069:             add          t0, s3, t3
5070:             nop
5071:             remu         t0, s2, t4
5072:             auipc        s6, 274389
5073:             sltiu        s5, t2, 691
5074:             xor          t5, s1, t5
5075:             mulh         gp, s11, sp
5076:             bge          s7, a4, 5084f
5077:             slti         t3, t2, -1913
5078:             csrrci       s9, 0x305, 0
5079:             csrrsi       s5, 0x342, 0
5080:             xori         s3, ra, 1616
5081:             slt          s5, s5, a4
5082:             srai         t6, s2, 11
5083:             mul          s10, gp, sp
5084:             mul          s4, t5, gp
5085:             slt          s2, t3, sp
5086:             bne          s11, s5, 5091f
5087:             beq          t0, s3, 5094f
5088:             and          s8, s1, tp
5089:             mul          s11, s3, t2
5090:             bne          t6, t3, 5091f
5091:             csrrw        s0, 0x344, sp
5092:             csrrwi       a2, 0x301, 28
5093:             bne          t4, s8, 5103f
5094:             ori          a6, s7, 1020
5095:             sll          s6, tp, s8
5096:             srai         t2, ra, 14
5097:             lui          t5, 989313
5098:             sra          a2, t3, tp
5099:             and          t2, s10, s8
5100:             csrrs        gp, 0x304, s9
5101:             csrrs        s6, 0x342, zero
5102:             srai         s6, t4, 2
5103:             auipc        s3, 442857
5104:             srai         a0, tp, 7
5105:             sll          s3, zero, s0
5106:             csrrsi       zero, 0x343, 0
5107:             mulh         s1, a7, t4
5108:             sltiu        t1, a5, -1803
5109:             rem          t0, a3, t3
5110:             or           t1, t0, t0
5111:             div          a7, s0, a0
5112:             srl          s4, a5, s4
5113:             csrrs        t2, 0x304, a3
5114:             blt          zero, ra, 5117f
5115:             div          s10, t5, s8
5116:             xori         s2, t5, 104
5117:             sltu         t6, ra, s0
5118:             or           t4, t6, a3
5119:             sltu         s2, t0, s10
5120:             csrrw        a1, 0x342, tp
5121:             sll          s9, a7, t4
5122:             csrrwi       s10, 0x343, 9
5123:             csrrc        s5, 0x301, zero
5124:             auipc        t1, 367625
5125:             beq          s11, a2, 5134f
5126:             slti         s9, t0, 715
5127:             bgeu         s4, sp, 5130f
5128:             srl          s0, a5, a1
5129:             srli         s8, ra, 25
5130:             csrrs        t5, 0x344, a3
5131:             csrrsi       t5, 0x304, 0
5132:             bne          s11, tp, 5136f
5133:             and          a6, a3, a6
5134:             csrrsi       a0, 0x344, 0
5135:             andi         a5, s10, -1415
5136:             srai         a0, a0, 3
5137:             bne          a4, s2, 5148f
5138:             csrrsi       a5, 0x301, 0
5139:             slli         s1, t3, 22
5140:             or           tp, a7, s4
5141:             blt          zero, a3, 5154f
5142:             auipc        t4, 616654
5143:             csrrw        a2, 0x344, tp
5144:             sra          s3, s11, s0
5145:             and          t6, a2, a6
5146:             blt          t1, tp, 5156f
5147:             bgeu         a0, tp, 5158f
5148:             rem          a4, t6, s6
5149:             slt          s4, t0, ra
5150:             divu         a4, a1, s1
5151:             or           s10, t3, a6
5152:             slli         t2, a7, 0
5153:             mul          s11, a2, ra
5154:             srli         a6, s1, 11
5155:             lui          s11, 779998
5156:             sltiu        gp, t4, 844
5157:             bne          a5, s3, 5160f
5158:             xor          t4, a7, a6
5159:             mul          s8, t0, s5
5160:             csrrs        s11, 0x304, s4
5161:             rem          gp, s11, a6
5162:             csrrci       zero, 0x304, 12
5163:             lui          t6, 687902
5164:             bgeu         s10, a1, 5168f
5165:             csrrc        a7, 0x304, s1
5166:             ori          s5, t5, 1588
5167:             csrrc        s1, 0x342, zero
5168:             xor          t6, s7, a5
5169:             beq          a7, s6, 5183f
5170:             remu         zero, s2, s10
5171:             add          t3, a1, a2
5172:             sub          a1, a5, a6
5173:             add          t4, t2, a5
5174:             bltu         s3, ra, 5189f
5175:             bgeu         s10, a1, 5193f
5176:             csrrsi       s9, 0x343, 24
5177:             mul          t1, ra, zero
5178:             slt          t4, a6, s6
5179:             xori         s3, a4, 354
5180:             rem          s2, a0, tp
5181:             sltu         t4, s4, t5
5182:             bltu         ra, s3, 5186f
5183:             xori         t4, s7, -1600
                  la           gp, region_0+43 #start riscv_load_store_rand_instr_stream_35
                  sb           s1, 1950(gp)
                  slt          zero, a0, zero
                  sll          t6, a3, s5
                  lbu          a6, 664(gp)
                  lui          t5, 607524
                  sb           a6, 1252(gp)
                  lh           a6, 1019(gp)
                  sb           t4, 855(gp)
                  sb           s1, 1840(gp)
                  srl          s10, t4, sp
                  sb           s5, 1825(gp)
                  lb           a5, 627(gp)
                  csrrs        s11, 0x344, zero
                  lb           s5, 2014(gp)
                  lb           a5, 554(gp)
                  csrrw        s0, 0x343, s5
                  remu         t6, a1, s4
                  csrrci       a6, 0x305, 0
                  lb           a5, 1981(gp)
                  div          a1, s0, zero
                  mul          t0, a1, a0
                  lb           a5, 524(gp)
                  slti         s0, t3, 1717
                  lb           s0, 1255(gp)
                  lhu          ra, 1085(gp)
                  lw           s5, 689(gp)
                  lb           s5, 172(gp) #end riscv_load_store_rand_instr_stream_35
5184:             sltu         t3, t2, s3
5185:             sltu         s11, a2, a0
5186:             ori          ra, t2, 1539
5187:             sltu         s5, a3, t2
5188:             rem          s6, t6, t6
5189:             slt          t6, a0, s11
5190:             srli         t6, a5, 18
5191:             slli         tp, a6, 21
5192:             slli         a7, a2, 26
5193:             slti         s4, s7, 1412
5194:             div          t2, a2, s0
5195:             and          t6, a7, s1
5196:             bgeu         s7, a6, 5199f
5197:             csrrci       s0, 0x301, 30
5198:             xori         t1, s9, -1897
5199:             sra          s5, t5, s2
5200:             csrrw        tp, 0x342, s3
5201:             lui          s8, 478318
5202:             bltu         s8, s6, 5220f
5203:             mulh         a2, s3, a3
5204:             or           t4, t1, gp
5205:             mul          t6, tp, a6
5206:             slli         t6, a5, 6
5207:             slt          a7, ra, s4
5208:             ori          s1, s4, -647
5209:             xor          tp, a2, a3
5210:             addi         a4, tp, -1198
5211:             mulhu        s8, t1, a1
5212:             remu         a7, s10, tp
5213:             bge          a6, a2, 5216f
5214:             srai         s2, t1, 18
5215:             bgeu         s6, t3, 5221f
5216:             srai         t6, gp, 31
5217:             sltu         zero, sp, s2
5218:             slti         a4, t6, 470
5219:             xor          gp, zero, a6
5220:             ori          t1, t4, -1399
5221:             divu         a7, a5, t6
5222:             auipc        a1, 855156
5223:             srai         s11, tp, 9
5224:             bge          gp, s9, 5234f
5225:             ori          s5, t2, 1661
5226:             srai         s3, sp, 8
5227:             csrrwi       t4, 0x343, 12
5228:             bgeu         t5, ra, 5232f
5229:             sra          s0, s7, t0
5230:             srai         s9, a0, 4
5231:             rem          a7, ra, s11
5232:             csrrw        s9, 0x342, a3
5233:             srai         a5, t4, 21
5234:             srl          a0, gp, s10
5235:             div          a5, s9, t4
5236:             addi         s10, t1, 293
5237:             mul          a4, s3, a2
5238:             srl          a7, s5, s9
5239:             lui          a6, 282720
5240:             slt          tp, a2, sp
5241:             bgeu         a4, zero, 5249f
5242:             mul          a6, t3, t6
5243:             sltiu        a2, s8, 126
5244:             divu         gp, a3, t3
5245:             slt          s1, s9, s0
5246:             csrrc        s8, 0x343, s3
5247:             csrrsi       t6, 0x305, 0
5248:             auipc        s8, 459529
5249:             bltu         s1, gp, 5260f
5250:             mulh         a0, s0, s2
5251:             slti         t0, s11, 1802
5252:             xor          a2, s7, a6
5253:             csrrw        s3, 0x301, sp
5254:             sltiu        s11, s9, -749
5255:             srli         a4, s4, 14
5256:             csrrwi       t4, 0x342, 31
5257:             divu         t1, s0, s1
5258:             sll          t0, ra, t2
5259:             blt          t1, s6, 5263f
5260:             sra          ra, t6, a6
5261:             ori          a5, a7, -365
5262:             bltu         s0, s0, 5265f
5263:             nop
5264:             mulh         t1, s5, s11
5265:             bge          s2, t1, 5268f
5266:             slli         tp, t5, 20
5267:             csrrci       t0, 0x342, 0
5268:             csrrci       a5, 0x304, 0
5269:             csrrci       a7, 0x304, 6
5270:             srl          s9, sp, t3
5271:             sub          s8, s1, a5
5272:             bltu         a6, s7, 5292f
5273:             add          s0, s8, a5
5274:             csrrsi       t1, 0x305, 0
5275:             srl          a2, s3, t5
5276:             beq          t1, a1, 5289f
5277:             slti         t2, a1, 1794
5278:             slli         a5, s7, 11
5279:             csrrw        zero, 0x344, s11
5280:             xor          s9, s8, s2
5281:             add          t2, a6, s5
5282:             mulhu        t1, a1, t4
5283:             bne          s10, s4, 5292f
5284:             addi         s5, t4, 1444
5285:             sltu         zero, a5, zero
5286:             bgeu         a1, t4, 5298f
5287:             beq          s4, sp, 5297f
5288:             bge          a1, s1, 5306f
5289:             or           s0, a3, a5
5290:             csrrs        a4, 0x304, t4
5291:             csrrw        s9, 0x344, tp
5292:             slti         tp, a1, -689
5293:             add          s2, s1, a2
5294:             nop
5295:             srli         a0, gp, 12
5296:             nop
5297:             lui          t2, 752760
5298:             ori          s1, t6, 833
5299:             andi         s9, s8, -1758
5300:             mulh         s2, a2, t0
5301:             sll          gp, t4, gp
5302:             csrrwi       t1, 0x343, 9
5303:             xori         s6, t0, -1244
5304:             csrrci       zero, 0x344, 14
5305:             mulhu        s3, s1, s6
5306:             andi         zero, t4, -973
5307:             srai         a2, s0, 30
5308:             auipc        s4, 629357
5309:             addi         gp, s10, -533
5310:             lui          t5, 714369
5311:             div          a5, s11, t5
5312:             mulhsu       s4, gp, t0
5313:             slti         s0, s5, 639
5314:             ori          ra, t0, 270
5315:             xor          t3, s7, s10
                  li           s10, 0x7b193720 #start riscv_int_numeric_corner_stream_17
                  li           s5, 0x0
                  li           t5, 0x0
                  li           s8, 0x80000000
                  li           s6, 0x6c8d1237
                  li           t4, 0x80000000
                  li           a7, 0x80000000
                  li           gp, 0x793fb436
                  li           s11, 0xc9f38ed3
                  li           a4, 0x1de16898
                  addi         a4, s10, 1677
                  add          a7, t5, s11
                  mulh         s6, s6, s8
                  auipc        t4, 755485
                  add          a4, s5, t4
                  mulhu        a4, s6, s10
                  mulh         s8, gp, s11
                  divu         s6, a7, gp
                  lui          s5, 179631
                  mulhsu       s8, s5, s5
                  divu         s11, t4, gp
                  mulhu        s5, s11, s10
                  nop
                  div          t4, t5, gp
                  div          t4, t4, a7
                  mulhsu       t4, s11, s10
                  mulhu        a4, a4, s11
                  sub          gp, s11, t4
                  mulh         t5, s8, s10
                  rem          a7, gp, t5
                  remu         s8, s11, s10
                  divu         a4, s5, t4
                  div          gp, s6, a4
                  nop
                  rem          gp, a4, t4
                  mulhu        s8, a7, s10 #end riscv_int_numeric_corner_stream_17
5316:             add          t1, a1, a0
5317:             add          ra, s3, s1
5318:             andi         t5, s3, 1269
5319:             mulhsu       ra, a3, s3
5320:             auipc        s3, 620924
5321:             srl          a6, t4, a2
5322:             csrrw        t2, 0x343, t4
5323:             xori         a2, a3, -520
5324:             divu         s5, s4, s6
5325:             or           s8, a4, t0
5326:             mulh         s8, t2, a3
5327:             xori         s0, tp, 921
5328:             srl          t4, a3, t1
5329:             and          s1, t1, a1
5330:             srl          t3, a1, a3
5331:             bltu         zero, a0, 5342f
5332:             csrrw        a5, 0x343, a6
5333:             mul          s9, t4, a6
5334:             srai         t5, a7, 6
5335:             srai         s5, t3, 16
5336:             csrrwi       s1, 0x344, 7
5337:             beq          a7, t4, 5348f
5338:             srli         tp, a4, 22
5339:             lui          s4, 601229
5340:             ori          s4, sp, 629
5341:             rem          a4, t1, tp
5342:             sltu         ra, a4, t4
5343:             divu         gp, s1, ra
5344:             beq          a1, zero, 5345f
5345:             csrrc        s5, 0x342, s10
5346:             divu         t1, a7, s0
5347:             srai         s6, s11, 5
5348:             sltu         s11, a3, a0
5349:             srai         s2, a7, 27
5350:             addi         s6, t0, 1001
5351:             add          a0, s3, s3
5352:             srai         zero, s0, 20
5353:             or           a0, t2, a0
5354:             xori         a4, a7, -874
5355:             csrrc        a6, 0x304, s11
5356:             bge          s9, t1, 5358f
5357:             srli         s9, ra, 30
5358:             sll          s0, a2, ra
5359:             mulh         t2, s0, s10
5360:             bgeu         s6, s7, 5365f
5361:             bne          t1, s2, 5368f
5362:             mulhsu       s0, t0, t5
5363:             bltu         zero, a2, 5366f
5364:             sra          t6, a0, s4
5365:             add          s8, s2, a6
5366:             sll          t5, s0, a2
5367:             ori          s4, tp, -19
5368:             sltiu        s9, a4, 2015
5369:             srl          a7, s3, s0
5370:             slti         t4, t5, -1817
5371:             lui          s2, 336663
5372:             csrrw        s10, 0x342, t1
5373:             bgeu         s5, t3, 5378f
5374:             rem          t4, a4, s5
5375:             blt          gp, t0, 5389f
5376:             srai         s3, zero, 20
5377:             mul          a4, gp, tp
5378:             and          tp, s1, s7
5379:             mulh         s8, a2, a7
5380:             divu         t0, a5, a5
5381:             xor          t0, a2, s10
5382:             blt          zero, s2, 5383f
5383:             or           s9, t3, a5
5384:             bne          t5, s8, 5392f
5385:             nop
5386:             mulhsu       a0, a5, tp
5387:             csrrwi       s4, 0x343, 6
5388:             remu         ra, a1, t5
5389:             lui          a0, 189093
5390:             sub          a0, t5, s4
5391:             csrrs        s10, 0x342, zero
5392:             add          t5, s0, s4
5393:             div          a1, s10, s2
5394:             rem          t4, zero, tp
5395:             div          t1, t5, ra
5396:             remu         t4, sp, s11
5397:             blt          ra, t0, 5412f
5398:             rem          a4, t2, a6
5399:             bne          s7, s2, 5409f
5400:             xori         t0, s9, 1310
5401:             sltu         t4, s11, a4
5402:             srai         s2, t2, 4
5403:             add          t3, a0, t4
5404:             xori         s10, a0, -729
5405:             slli         a1, sp, 26
5406:             mulhu        t6, s11, a2
5407:             bge          s8, a6, 5420f
5408:             auipc        s0, 756527
5409:             addi         t2, t3, -1110
5410:             bltu         s0, s3, 5428f
5411:             div          s2, zero, s8
5412:             csrrci       tp, 0x344, 13
5413:             add          a5, t2, t6
5414:             csrrw        t4, 0x343, ra
5415:             addi         t2, t4, 264
5416:             lui          a2, 192014
5417:             rem          ra, t5, s7
5418:             or           s5, s9, sp
5419:             bltu         s8, t5, 5422f
5420:             addi         a6, s3, -1198
5421:             or           s5, a1, a3
5422:             and          t3, a4, s11
5423:             divu         zero, s0, s5
5424:             auipc        s0, 779421
5425:             remu         a7, s4, s1
5426:             addi         t5, t2, -17
5427:             divu         s0, t2, a6
5428:             andi         s6, a5, 314
5429:             csrrsi       t1, 0x301, 0
5430:             bge          s9, a5, 5444f
5431:             csrrw        a4, 0x342, t2
5432:             bge          a7, s2, 5438f
5433:             xori         s2, t0, 739
5434:             slli         s11, a0, 24
5435:             xori         tp, tp, 1313
5436:             bgeu         t1, s5, 5444f
5437:             slti         a5, a7, 668
5438:             mulh         a6, t3, gp
5439:             csrrci       s0, 0x344, 16
5440:             srai         t4, sp, 25
5441:             srl          s10, zero, ra
5442:             mulh         a5, gp, ra
5443:             csrrsi       a0, 0x301, 8
5444:             addi         t5, s8, -997
5445:             slt          s9, s11, s6
5446:             xor          s11, a1, t1
5447:             addi         ra, tp, -465
5448:             xori         a6, a1, 154
5449:             csrrsi       s0, 0x342, 5
5450:             xori         a5, s0, 1833
5451:             csrrci       s3, 0x300, 0
5452:             auipc        s2, 708169
5453:             slti         t2, a1, -1636
5454:             divu         a2, t4, t0
5455:             srli         a7, s2, 6
5456:             csrrw        gp, 0x304, a2
5457:             csrrw        s9, 0x344, a6
5458:             ori          t0, t3, -647
5459:             div          s4, t5, t2
5460:             sra          tp, t1, t6
main_96:          jal          t4, 15f
0:                jal          ra, 2f
1:                jal          ra, 14f
2:                jal          s3, 30f
3:                jal          t3, 25f
4:                jal          ra, 1b
5:                jal          ra, 19f
6:                jal          t0, 0b
7:                jal          ra, 23f
8:                jal          s1, 12f
9:                jal          ra, 17f
10:               jal          ra, 18f
11:               jal          ra, 4b
12:               jal          ra, 16f
13:               jal          ra, 9b
14:               jal          s9, 21f
15:               jal          t1, 8b
16:               jal          s0, 10b
17:               jal          ra, 6b
18:               jal          a1, 29f
19:               jal          ra, 7b
20:               jal          ra, 13b
21:               jal          ra, 20b
22:               jal          ra, 27f
23:               jal          ra, 28f
24:               jal          s6, 26f
25:               jal          a5, 24b
26:               jal          tp, 5b
27:               jal          s3, 11b
28:               jal          ra, 22b
29:               jal          ra, 3b
30:               divu         a4, ra, s9
5461:             bltu         t4, s1, 5465f
5462:             bge          a3, a6, 5467f
5463:             xori         t5, t4, 1672
5464:             xori         a1, ra, -1695
5465:             sll          t6, a1, t2
5466:             sltu         s4, s11, s8
5467:             slti         s4, a2, -1332
5468:             sltu         s8, s4, s7
5469:             beq          t4, s4, 5471f
5470:             csrrw        a5, 0x342, tp
5471:             and          t2, t6, s1
5472:             ori          t1, t1, -57
5473:             and          s10, t0, t6
5474:             csrrsi       t3, 0x305, 0
5475:             auipc        t0, 239465
5476:             xor          t2, tp, s10
5477:             csrrci       t4, 0x342, 0
5478:             add          s3, a6, s11
5479:             srai         s11, s7, 21
5480:             auipc        s6, 29670
5481:             sub          t4, a0, zero
5482:             bgeu         t3, s1, 5486f
5483:             sll          s8, s9, sp
5484:             slt          s4, s3, t0
5485:             csrrc        t4, 0x300, zero
5486:             lui          s9, 753781
5487:             sll          s11, s3, a0
5488:             auipc        t0, 540237
5489:             divu         s5, t4, t2
5490:             csrrs        t5, 0x305, zero
5491:             mulh         t6, s2, tp
5492:             rem          a5, s3, a1
5493:             csrrw        a2, 0x304, s3
5494:             xori         s1, a3, -1715
5495:             csrrw        t5, 0x301, t1
5496:             blt          t2, a7, 5511f
5497:             div          s3, a6, s1
5498:             add          s9, s7, s6
5499:             csrrc        t5, 0x300, zero
5500:             divu         t6, s8, t2
5501:             mul          t1, t1, s5
5502:             slti         t2, a0, -578
5503:             nop
5504:             sra          s3, s10, s3
5505:             csrrs        s9, 0x305, zero
5506:             slli         s10, t5, 19
5507:             bgeu         s9, sp, 5512f
5508:             lui          t6, 148671
5509:             or           s4, s11, tp
5510:             lui          a7, 677139
5511:             xori         a7, s0, 7
5512:             csrrs        t6, 0x301, a2
5513:             csrrw        t2, 0x342, t0
5514:             add          s6, gp, t0
5515:             nop
5516:             and          s6, t1, s11
5517:             sra          s2, sp, sp
5518:             srai         s4, s8, 16
5519:             slti         a1, t3, -1076
5520:             slt          s11, a6, s4
5521:             divu         s1, a0, a0
5522:             slt          a7, s3, s11
5523:             blt          s6, s9, 5527f
5524:             srli         t5, s0, 25
5525:             sltu         a6, s4, t1
5526:             mul          s6, t3, a2
5527:             csrrw        a6, 0x304, s9
5528:             bge          s2, gp, 5531f
5529:             sltu         a4, t4, s5
5530:             or           a6, a2, a3
5531:             blt          t2, s6, 5542f
5532:             ori          a2, a3, 1059
5533:             nop
5534:             beq          t6, t5, 5546f
5535:             beq          s0, s9, 5536f
5536:             srai         gp, s9, 4
5537:             rem          t6, ra, a2
5538:             xori         s0, s9, 102
5539:             auipc        a1, 19147
5540:             divu         s5, gp, gp
5541:             nop
5542:             mulh         t6, tp, a6
5543:             slt          s2, a4, gp
5544:             slt          zero, a4, t5
5545:             bne          t4, sp, 5563f
5546:             xor          s9, t0, t4
5547:             xor          a2, s6, s5
5548:             bltu         ra, a2, 5551f
5549:             remu         t0, s4, t1
5550:             lui          s5, 366319
5551:             addi         a7, t5, -68
5552:             csrrsi       s2, 0x342, 12
5553:             bgeu         t2, s7, 5556f
5554:             bge          s3, s5, 5562f
5555:             csrrwi       a5, 0x301, 21
5556:             remu         s5, ra, a3
5557:             srai         gp, t2, 10
5558:             sltiu        s1, a3, -504
5559:             bne          a6, t1, 5579f
5560:             blt          t0, a6, 5569f
5561:             slti         s9, s5, -1077
5562:             div          gp, a0, s11
5563:             rem          t6, s6, a2
5564:             andi         a0, t1, -227
5565:             mulhu        gp, tp, a3
5566:             sra          a7, s8, s2
5567:             mul          t4, s10, t1
5568:             mul          s11, a6, zero
5569:             mul          s9, s0, a1
5570:             sra          t5, a0, tp
5571:             bne          a1, s8, 5581f
5572:             sltu         s5, zero, s11
5573:             mulh         t4, s2, s2
5574:             andi         s5, t0, 1711
5575:             slti         s0, tp, -1651
5576:             srl          gp, t1, s6
5577:             lui          s2, 261212
5578:             remu         s10, s2, gp
5579:             addi         tp, s8, -528
5580:             auipc        s9, 723286
5581:             bltu         t3, s6, 5592f
5582:             csrrw        s6, 0x344, gp
5583:             mulhsu       s8, s9, s3
5584:             csrrc        t0, 0x305, zero
5585:             nop
5586:             blt          a6, s6, 5593f
5587:             xor          s4, a3, tp
5588:             sra          a6, t0, s10
5589:             beq          a7, a3, 5600f
5590:             srl          s9, s8, s10
5591:             xor          a4, a0, s7
5592:             bne          s2, a2, 5593f
5593:             andi         s9, t2, -899
5594:             sltu         a4, s8, a0
5595:             auipc        t1, 1036364
5596:             auipc        s1, 832283
5597:             bltu         t6, a6, 5600f
5598:             remu         t1, zero, s6
5599:             sra          t2, s0, s6
5600:             bge          s2, a0, 5610f
5601:             mulhu        t4, s9, s3
5602:             auipc        t3, 273459
5603:             nop
5604:             nop
5605:             csrrwi       a0, 0x342, 11
5606:             addi         gp, s0, 1456
5607:             andi         t1, s8, 299
5608:             bgeu         a5, s5, 5621f
5609:             slti         s5, s1, -458
5610:             bge          a7, s5, 5613f
5611:             bgeu         a7, s1, 5619f
5612:             sll          s8, ra, s2
5613:             csrrs        t4, 0x304, t6
5614:             sra          a2, a0, gp
5615:             sub          s9, s2, t0
5616:             auipc        s0, 643777
5617:             csrrw        a0, 0x301, s11
5618:             or           t5, s8, s11
5619:             sra          s0, t5, s1
5620:             addi         s9, a5, 504
5621:             div          s3, a7, t0
5622:             srl          s1, t1, t0
5623:             nop
5624:             blt          t1, a0, 5629f
5625:             slti         a0, s4, -1532
5626:             mulhsu       s11, a3, a4
5627:             mulhsu       s11, a7, sp
5628:             beq          a0, s9, 5632f
5629:             or           t0, ra, s8
5630:             andi         t3, s11, 474
5631:             addi         s11, s11, 908
5632:             sll          a6, s7, s11
5633:             ori          s10, t6, 1117
5634:             ori          a4, s3, 450
5635:             lui          s8, 376896
5636:             beq          tp, t2, 5640f
5637:             srli         a2, t4, 16
5638:             rem          a1, gp, a7
5639:             sub          t6, zero, a3
5640:             csrrwi       zero, 0x301, 21
5641:             csrrsi       a4, 0x301, 0
5642:             add          a1, s4, a0
5643:             xor          s5, ra, a5
5644:             csrrc        s6, 0x344, zero
5645:             mul          t4, a6, a1
5646:             and          t5, t3, s2
5647:             bge          a6, t2, 5658f
5648:             blt          a4, s5, 5651f
5649:             div          ra, s4, a5
5650:             addi         s11, s1, 378
5651:             div          a7, gp, s8
5652:             slt          a5, tp, s2
5653:             andi         zero, s0, -210
5654:             slti         s0, sp, -570
5655:             sra          a1, a1, s2
5656:             slt          s8, a2, s2
5657:             add          a2, zero, a7
5658:             srai         s8, t6, 2
5659:             sra          ra, a0, a0
5660:             remu         a1, s11, t1
5661:             csrrs        s2, 0x305, zero
5662:             sltu         a7, t3, s6
5663:             mulh         t1, t2, s7
5664:             mulhu        t6, gp, gp
5665:             sub          s0, a1, t3
5666:             slti         t6, s8, -854
5667:             mulhu        s10, t1, a4
5668:             div          s1, s6, a0
5669:             blt          s1, s9, 5684f
5670:             addi         t5, ra, 1655
5671:             andi         a4, t5, -1236
5672:             bgeu         s3, s0, 5673f
5673:             sll          s0, a2, s2
5674:             bne          s6, s9, 5685f
5675:             srai         a2, t2, 7
5676:             xori         t3, s7, 766
5677:             slt          zero, t0, s4
5678:             nop
5679:             mulh         ra, s10, s1
5680:             add          zero, t2, ra
5681:             slli         s5, a2, 11
5682:             and          s5, t0, a1
5683:             addi         t3, s6, -1633
5684:             rem          a4, ra, a0
5685:             or           t5, gp, a4
5686:             slt          s0, s8, s10
5687:             xor          tp, t3, a1
5688:             bltu         t4, s4, 5689f
5689:             sub          gp, a5, a2
5690:             divu         t0, a2, gp
5691:             ori          t5, a5, -1042
5692:             mulh         s1, gp, s4
5693:             slt          s0, s5, t4
5694:             sub          s6, a2, a4
5695:             xori         ra, t0, -1311
5696:             mulh         s2, s6, a7
5697:             and          t0, s0, s4
5698:             beq          t3, s2, 5712f
5699:             remu         t1, gp, s6
5700:             xori         s1, s9, -1253
5701:             mulh         a1, t1, t6
5702:             slli         s3, a0, 26
5703:             xor          s10, t0, s1
5704:             nop
5705:             mulhsu       s4, zero, t1
5706:             bgeu         s6, s6, 5716f
5707:             mulhsu       t2, s1, t6
5708:             remu         s1, a5, t4
5709:             slti         s9, t2, 1829
5710:             beq          s5, zero, 5730f
5711:             div          s10, s11, a7
5712:             bltu         t5, s4, 5720f
5713:             srai         a1, s3, 1
5714:             sub          s6, s11, s2
5715:             xor          s9, s10, a1
5716:             sltu         t4, t1, s3
5717:             bgeu         s10, ra, 5723f
5718:             ori          s2, tp, -623
5719:             or           a5, s8, tp
5720:             beq          t5, a2, 5727f
5721:             csrrs        s2, 0x300, zero
5722:             csrrc        a6, 0x301, zero
5723:             andi         t2, tp, -1869
5724:             csrrs        a0, 0x304, zero
5725:             mulhu        a4, s8, s9
5726:             add          tp, a4, t1
5727:             slli         t3, s9, 22
5728:             sltiu        s6, s6, -354
5729:             srai         a4, s7, 4
5730:             sltiu        s10, s2, 1223
5731:             csrrc        t2, 0x343, zero
5732:             rem          a5, gp, a1
5733:             auipc        s5, 642654
5734:             rem          gp, a3, s8
5735:             auipc        a1, 150778
5736:             bgeu         s3, s10, 5754f
5737:             div          a7, a0, s3
5738:             addi         t2, s1, -1596
5739:             addi         a7, a6, 627
5740:             sltiu        a7, s4, -925
5741:             sltiu        s6, t0, -2008
5742:             csrrs        s6, 0x305, zero
5743:             nop
5744:             bge          s5, s2, 5747f
5745:             add          t1, s6, a3
5746:             divu         t2, a4, s9
5747:             csrrw        t5, 0x301, a7
5748:             auipc        a0, 942067
5749:             rem          a2, a0, gp
5750:             sltu         s0, s10, a0
5751:             divu         gp, sp, s7
5752:             lui          s11, 923926
5753:             nop
5754:             addi         t5, a5, -955
5755:             slti         s5, s6, 813
5756:             bge          t5, t0, 5761f
5757:             csrrs        s4, 0x304, zero
5758:             lui          s0, 55648
5759:             add          s6, t5, t3
5760:             csrrsi       t5, 0x343, 0
5761:             srai         a0, s7, 31
5762:             lui          s4, 966708
5763:             sltu         a5, s9, t1
5764:             csrrs        s3, 0x305, zero
5765:             csrrs        s11, 0x305, zero
5766:             lui          s1, 799448
5767:             csrrw        s5, 0x304, t1
5768:             csrrsi       s0, 0x342, 0
5769:             csrrwi       t4, 0x343, 9
5770:             csrrsi       t2, 0x343, 0
5771:             sra          t3, tp, s2
5772:             csrrc        t3, 0x300, zero
5773:             or           s9, t4, t2
5774:             mulhsu       t5, s1, s4
5775:             beq          t3, zero, 5779f
5776:             bltu         a0, a7, 5779f
5777:             mul          s3, s4, s4
5778:             mulhu        a7, s10, sp
5779:             srli         a7, a1, 22
5780:             nop
5781:             remu         s11, s7, a7
5782:             csrrs        s11, 0x304, a6
5783:             xor          a2, t0, s1
5784:             beq          ra, gp, 5786f
5785:             bge          a3, gp, 5794f
5786:             mul          ra, s6, a3
5787:             remu         s3, a1, s11
5788:             bne          a3, zero, 5806f
5789:             srl          gp, t5, zero
5790:             sltu         t6, t0, sp
5791:             slli         a7, a4, 25
5792:             bgeu         t4, t2, 5795f
5793:             slli         tp, s9, 16
5794:             xori         zero, t2, 516
5795:             mulhsu       s3, s2, s8
5796:             rem          s6, t0, t3
5797:             slt          t5, s8, gp
5798:             add          gp, s2, s9
5799:             sltiu        a5, t5, 1579
5800:             csrrci       t6, 0x344, 0
5801:             xor          t1, t6, s8
5802:             sltu         a0, s5, t1
5803:             sltu         t3, s1, a5
5804:             addi         s3, gp, 528
5805:             sra          t0, t0, a0
5806:             sra          s0, t1, s9
5807:             csrrwi       s9, 0x342, 24
5808:             slt          s4, a7, gp
5809:             addi         zero, t3, -1993
5810:             bge          zero, s0, 5821f
5811:             mulh         t5, s3, t0
5812:             srl          a4, s3, sp
5813:             csrrc        a7, 0x344, a2
5814:             remu         t1, t5, s3
5815:             rem          t6, a6, a7
5816:             blt          s1, t3, 5828f
5817:             sub          s6, t2, s0
5818:             bltu         a5, s5, 5829f
5819:             div          t2, s1, zero
5820:             xori         a6, t4, -1160
5821:             rem          s5, ra, s9
5822:             div          t2, s5, t5
5823:             bne          s8, s10, 5841f
5824:             csrrw        t3, 0x343, s2
5825:             bne          zero, s3, 5826f
5826:             rem          a4, a3, a1
5827:             rem          s9, s4, t3
5828:             or           s4, t2, t4
5829:             xor          s3, t2, t3
5830:             mulhsu       t0, gp, s11
5831:             sra          s6, s1, t4
5832:             auipc        gp, 470861
5833:             bltu         a7, gp, 5836f
5834:             beq          a2, gp, 5840f
5835:             lui          s4, 91883
5836:             csrrci       s1, 0x300, 0
5837:             blt          s4, a3, 5847f
5838:             bgeu         s1, s5, 5849f
5839:             srl          t5, sp, s8
5840:             bgeu         a0, s4, 5854f
5841:             csrrs        s6, 0x305, zero
5842:             slt          ra, s6, s2
5843:             sra          a0, sp, s4
5844:             sltiu        a6, a6, -1222
5845:             bltu         gp, t5, 5850f
5846:             slti         a5, t0, -344
5847:             bgeu         s7, s1, 5851f
5848:             slt          t2, s3, s6
5849:             bltu         s9, a6, 5852f
5850:             mulh         ra, sp, a7
5851:             sltiu        t5, a6, 1377
5852:             remu         a0, a0, a4
5853:             mul          ra, gp, ra
5854:             csrrw        s9, 0x344, zero
5855:             sub          s1, s10, s5
5856:             andi         s3, t3, -1792
5857:             addi         t3, a6, -224
                  la           s2, region_0+3832 #start load_store_instr_stream_0
                  la           t1, region_1+65106 #start load_store_instr_stream_1
                  lb           t5, -93(t1)
                  lbu          s1, 11(s2)
                  lbu          zero, -77(t1)
                  lhu          s3, 0(s2)
                  lb           s0, 8(s2)
                  sw           s7, 226(t1)
                  lw           s0, -206(t1)
                  sw           t4, -8(s2)
                  lb           s11, 79(t1)
                  lb           s0, 120(t1)
                  lw           s9, 62(t1) #end load_store_instr_stream_1
                  sh           tp, 4(s2) #end load_store_instr_stream_0
5858:             beq          s4, a6, 5876f
5859:             slli         s0, a0, 4
5860:             mulhsu       t6, t4, s10
5861:             csrrci       a0, 0x301, 22
5862:             bltu         a1, t4, 5872f
5863:             rem          t1, t5, a5
5864:             add          a4, t2, s6
5865:             add          a0, s10, a1
5866:             sub          s0, a1, tp
5867:             addi         s9, a7, -1151
5868:             addi         s4, t4, 1178
5869:             xori         t4, s0, 1566
5870:             and          s6, s10, s11
5871:             csrrwi       s3, 0x344, 17
5872:             bne          a1, zero, 5881f
5873:             mulh         s5, t3, sp
5874:             bgeu         sp, s2, 5879f
5875:             and          s3, gp, ra
5876:             bgeu         ra, gp, 5880f
5877:             srli         s11, s3, 0
5878:             remu         a4, s1, s1
5879:             slt          a7, t4, s7
5880:             and          a2, zero, t2
5881:             add          t5, a3, sp
5882:             ori          s0, a4, 1693
5883:             mulhu        t5, s9, tp
5884:             slt          s1, a3, sp
5885:             csrrci       tp, 0x344, 0
5886:             mulhu        gp, t3, s5
5887:             andi         s6, s0, 135
5888:             or           t1, s4, t4
5889:             bltu         a7, a5, 5896f
5890:             mulhu        s5, t1, s2
5891:             nop
5892:             mulhu        s8, s0, s8
5893:             csrrci       s3, 0x304, 0
5894:             addi         zero, s4, -719
5895:             sll          t3, t2, s6
5896:             divu         a1, t3, sp
5897:             andi         a6, s2, -1348
5898:             bgeu         t0, s9, 5900f
5899:             sra          s4, t5, a7
5900:             sub          t5, s8, a5
5901:             bge          s7, ra, 5904f
5902:             slli         s3, s9, 22
5903:             nop
5904:             srai         s1, t6, 4
5905:             slt          ra, t4, t3
5906:             srai         t0, a3, 2
5907:             add          t0, s8, ra
5908:             sltu         s4, a4, a3
5909:             remu         s2, s7, a6
5910:             csrrsi       t1, 0x304, 31
5911:             div          t3, s2, s1
5912:             slt          s9, ra, t0
5913:             bge          s7, gp, 5914f
5914:             rem          a0, t1, s1
5915:             bne          a6, s11, 5926f
5916:             andi         a0, tp, -343
5917:             blt          a6, s8, 5930f
5918:             blt          a1, a5, 5921f
5919:             srai         ra, a5, 22
5920:             div          s1, s11, s2
5921:             andi         gp, t5, -1968
5922:             srli         s11, sp, 3
5923:             xor          s10, s8, s0
5924:             slti         a6, s0, 1169
5925:             bltu         t4, a2, 5940f
5926:             remu         t6, t5, s7
5927:             srl          a2, t5, s8
5928:             and          s8, s8, a2
5929:             bge          a4, a3, 5937f
5930:             csrrs        t3, 0x305, zero
5931:             slli         s1, a1, 20
5932:             and          ra, gp, a4
5933:             bltu         t1, tp, 5953f
5934:             slli         s6, zero, 18
5935:             remu         s1, a2, t0
5936:             remu         s0, s1, s9
5937:             bge          t4, s1, 5940f
5938:             csrrci       t2, 0x305, 0
5939:             mul          a4, s11, a2
5940:             sltiu        t0, a2, 1840
5941:             div          t3, t3, s5
5942:             and          s5, t3, t6
5943:             auipc        s10, 807319
5944:             sub          s5, a2, s2
5945:             blt          s11, s0, 5949f
5946:             div          s0, s10, s3
5947:             csrrwi       s8, 0x343, 26
5948:             sub          s10, s1, a7
5949:             nop
5950:             lui          s9, 141788
5951:             auipc        t3, 441985
5952:             bge          t4, a5, 5960f
5953:             remu         s4, s3, tp
5954:             csrrci       s6, 0x342, 0
5955:             xori         t2, t3, -203
5956:             addi         a2, a0, 837
5957:             srai         gp, a3, 7
5958:             rem          s5, t5, s4
5959:             csrrc        a2, 0x344, zero
5960:             divu         s1, a2, tp
5961:             slt          s11, s0, s0
5962:             ori          tp, tp, 1313
5963:             srli         t1, s5, 26
5964:             csrrwi       t3, 0x301, 11
5965:             ori          ra, gp, 1130
5966:             remu         t4, a6, a1
5967:             mulhu        s5, a3, gp
5968:             mulhu        zero, t2, a6
5969:             csrrw        a7, 0x301, s7
5970:             xori         a1, t4, -730
5971:             csrrs        t6, 0x344, s7
5972:             sub          zero, a5, s7
5973:             lui          t3, 484665
5974:             add          s11, t5, sp
5975:             beq          t4, a7, 5987f
5976:             bltu         s7, gp, 5977f
5977:             ori          a2, s11, 19
5978:             ori          t6, s1, -1681
5979:             bgeu         t0, s5, 5990f
5980:             csrrs        s10, 0x301, a6
5981:             sltu         t5, s10, t1
5982:             xori         t2, a2, 248
5983:             bgeu         t3, t0, 5987f
5984:             auipc        s6, 55694
5985:             addi         t3, a5, 1477
5986:             sra          s1, s10, zero
5987:             slti         s11, a4, 1396
5988:             srl          a2, a6, a7
5989:             lui          s5, 329363
5990:             sra          s5, a2, s1
5991:             mulh         s6, s5, a5
5992:             slli         t5, a7, 9
5993:             div          a6, t0, a5
5994:             slli         t3, t3, 26
5995:             mulhsu       a5, s1, s4
5996:             csrrsi       gp, 0x305, 0
5997:             bltu         gp, a0, 5998f
5998:             csrrw        a0, 0x344, s10
5999:             sltu         t5, s8, s10
6000:             nop
6001:             bge          t5, t1, 6004f
6002:             divu         s5, a7, s8
6003:             bgeu         tp, s6, 6007f
6004:             addi         s3, a6, 1431
6005:             csrrc        t0, 0x344, ra
6006:             rem          a7, t3, zero
6007:             bltu         s4, s6, 6012f
6008:             remu         s8, t0, s1
6009:             slli         s1, s6, 17
6010:             ori          tp, a3, 851
6011:             mul          zero, s0, t3
6012:             csrrw        s2, 0x342, s10
6013:             divu         s6, s0, s7
6014:             nop
6015:             slti         a7, a2, 1317
6016:             nop
6017:             bltu         a4, a2, 6027f
6018:             bltu         t3, a1, 6032f
6019:             remu         tp, tp, t1
6020:             and          s5, s11, t5
6021:             remu         s6, s9, s6
6022:             csrrw        a5, 0x342, a0
6023:             sub          s4, a2, s9
6024:             auipc        s8, 572981
6025:             slti         s9, s2, 1816
6026:             slt          s11, a7, s9
6027:             mulhsu       s4, s0, s5
6028:             csrrsi       s1, 0x301, 0
6029:             blt          s4, a0, 6037f
6030:             mulhsu       a5, s2, a5
6031:             and          t4, s11, s4
6032:             rem          s4, t2, t4
6033:             div          s4, tp, a5
6034:             divu         t5, s2, a0
6035:             auipc        s6, 463924
6036:             bgeu         a6, tp, 6048f
6037:             mul          a4, s3, s1
6038:             remu         s9, s5, a4
6039:             mulhsu       t6, t3, t3
6040:             csrrsi       t6, 0x300, 0
6041:             csrrci       t3, 0x305, 0
6042:             sub          s0, s3, s3
6043:             mulh         s1, s2, a3
6044:             srai         a6, s1, 29
6045:             csrrs        a4, 0x343, s8
6046:             csrrci       a4, 0x300, 0
6047:             mulhu        s10, s0, zero
6048:             remu         s8, a0, t5
6049:             slt          s11, s11, a2
6050:             div          s10, a6, sp
6051:             divu         t6, s7, t1
6052:             divu         s1, a6, a5
6053:             sra          t1, a4, a0
6054:             csrrsi       s2, 0x343, 11
6055:             slti         s5, t3, -1582
6056:             srli         s1, a0, 12
6057:             rem          s10, a4, t5
6058:             csrrw        s6, 0x344, s6
6059:             and          a6, s0, tp
6060:             and          s10, a7, s2
6061:             srl          t2, s8, s3
6062:             csrrci       a0, 0x342, 13
6063:             srl          t4, zero, s7
6064:             mulh         tp, sp, a6
6065:             blt          a2, zero, 6070f
6066:             slt          a6, s6, a6
6067:             bge          t3, t2, 6074f
6068:             mulhu        t1, zero, a6
6069:             mulh         a2, t1, t2
6070:             bne          t2, a7, 6079f
6071:             csrrw        s9, 0x343, s10
6072:             srli         tp, a7, 20
6073:             lui          t5, 1034666
6074:             andi         t0, a6, 1330
6075:             ori          s5, s4, -969
6076:             csrrc        t1, 0x305, zero
6077:             bltu         a7, ra, 6095f
6078:             srli         t5, s9, 11
6079:             add          t5, s0, a5
6080:             blt          s11, a4, 6084f
6081:             mul          t0, ra, sp
6082:             andi         s3, s4, -611
6083:             auipc        s2, 326767
6084:             slt          t1, a6, t6
6085:             csrrs        t0, 0x304, a1
6086:             csrrwi       t3, 0x304, 24
6087:             remu         s5, s4, s2
6088:             csrrsi       t3, 0x305, 0
6089:             remu         s4, sp, t6
6090:             add          t1, a4, t1
6091:             auipc        zero, 984892
6092:             remu         ra, s6, t6
6093:             lui          a1, 301356
6094:             sltu         a5, s1, t1
6095:             sll          a1, s4, s2
6096:             sltu         a2, s1, a1
6097:             addi         a2, a2, 1307
6098:             mulhsu       tp, s11, ra
6099:             andi         t1, a1, 1021
6100:             div          ra, a7, s0
6101:             csrrs        s2, 0x342, t3
6102:             csrrw        s4, 0x342, t0
6103:             sltiu        t0, s7, -493
6104:             csrrci       t0, 0x304, 30
6105:             sra          ra, a6, t2
6106:             remu         s11, a0, t4
6107:             csrrs        s9, 0x343, ra
6108:             blt          sp, t2, 6118f
6109:             csrrsi       t3, 0x300, 0
6110:             slt          s2, ra, zero
6111:             sltiu        t4, t6, -1646
6112:             srl          ra, s11, s1
6113:             divu         s9, gp, sp
6114:             remu         gp, a4, a0
6115:             bltu         s8, s11, 6118f
6116:             remu         s8, s9, a3
6117:             csrrwi       t1, 0x343, 31
6118:             bgeu         t1, t3, 6133f
6119:             slli         s11, s5, 12
6120:             remu         gp, t5, s3
6121:             csrrsi       s6, 0x344, 0
6122:             bgeu         s11, t6, 6125f
6123:             sll          t0, s3, s5
6124:             mulhsu       s1, ra, zero
6125:             slti         a0, s6, 514
6126:             srl          ra, ra, t6
6127:             mulhsu       s10, ra, s1
6128:             bgeu         t0, gp, 6136f
6129:             and          a1, s8, a7
6130:             bne          a2, s6, 6150f
6131:             csrrci       s3, 0x301, 1
6132:             bgeu         t3, s8, 6143f
6133:             mul          t3, a5, s4
6134:             addi         ra, s5, 445
6135:             lui          s9, 292055
6136:             remu         t4, t5, s2
6137:             sra          a6, zero, s4
6138:             beq          t2, tp, 6140f
6139:             ori          zero, s2, -1246
6140:             andi         a7, tp, 822
6141:             nop
6142:             csrrc        a6, 0x342, s1
6143:             sub          t3, s1, s4
6144:             bgeu         sp, s6, 6157f
6145:             mulh         a1, s6, sp
6146:             sra          t6, a7, s10
6147:             mulh         s11, a6, t0
6148:             xori         t6, s9, 1836
6149:             divu         t3, a0, s0
6150:             rem          a4, tp, a7
6151:             div          s11, t4, t3
6152:             lui          s11, 66269
6153:             csrrsi       s4, 0x344, 0
6154:             mul          a6, a3, s3
6155:             add          s6, s8, s1
6156:             nop
6157:             csrrw        s9, 0x342, s7
6158:             sltu         s3, s9, s6
6159:             auipc        a0, 945139
6160:             andi         t5, t2, -1935
6161:             csrrsi       a6, 0x304, 3
6162:             sltu         a1, t0, a7
6163:             sra          a1, a5, ra
6164:             rem          s11, s6, a2
6165:             lui          s3, 315974
6166:             mulh         t6, s9, t1
6167:             beq          t6, t4, 6170f
6168:             sra          gp, a5, t4
6169:             srl          s6, s2, s0
6170:             bge          s7, gp, 6173f
6171:             xori         a7, s1, -387
6172:             beq          s7, s3, 6190f
6173:             remu         gp, t2, s7
6174:             slti         a0, t2, -1951
6175:             bgeu         s0, s5, 6181f
6176:             rem          s11, a2, zero
6177:             bne          a7, t5, 6188f
6178:             div          t5, s1, t3
6179:             srai         s6, a0, 12
6180:             csrrs        zero, 0x343, ra
6181:             bge          tp, a0, 6187f
6182:             mulh         tp, s6, s3
6183:             addi         a6, t5, 1784
6184:             csrrci       s11, 0x305, 0
6185:             csrrsi       ra, 0x304, 21
6186:             sltu         t0, a0, s8
6187:             xori         s2, a6, -1051
6188:             csrrwi       s8, 0x342, 4
6189:             nop
6190:             mulhu        a6, a5, s11
6191:             addi         t2, a5, 895
6192:             xor          s0, gp, zero
6193:             xor          s5, t1, tp
6194:             slli         a4, s9, 10
6195:             lui          s8, 711942
6196:             mulh         ra, s10, a0
6197:             bne          ra, s0, 6208f
6198:             or           s8, tp, t2
6199:             nop
6200:             rem          a5, t1, zero
6201:             add          a4, t3, t3
6202:             csrrc        a5, 0x344, zero
6203:             mul          gp, s1, t3
6204:             andi         a4, a5, -408
6205:             divu         s4, a6, s1
6206:             mulh         s8, s1, t0
6207:             sub          s0, t4, a7
6208:             csrrc        s4, 0x300, zero
6209:             xor          ra, a4, s9
6210:             csrrc        t2, 0x342, zero
6211:             or           tp, a7, t6
6212:             add          t2, a2, s2
6213:             beq          s1, s6, 6216f
6214:             csrrc        a7, 0x342, zero
6215:             csrrs        a0, 0x301, t2
6216:             sltiu        s11, a6, -1475
6217:             csrrsi       t2, 0x305, 0
6218:             nop
6219:             rem          t4, t3, a5
6220:             rem          t5, zero, s11
6221:             slti         s1, ra, 557
6222:             remu         s6, s0, s1
6223:             lui          a0, 182660
6224:             csrrw        t0, 0x342, s0
6225:             addi         s11, s5, 1747
6226:             addi         t3, a2, 1950
6227:             csrrsi       a4, 0x305, 0
6228:             csrrc        a1, 0x304, a7
6229:             csrrwi       t6, 0x342, 18
6230:             csrrci       s5, 0x342, 31
6231:             csrrc        t1, 0x301, zero
6232:             andi         t4, t1, 1107
6233:             slli         s10, t0, 8
6234:             sra          s11, s9, zero
6235:             rem          a1, gp, s3
6236:             csrrsi       s10, 0x304, 0
6237:             blt          tp, s6, 6249f
6238:             auipc        t6, 591680
6239:             csrrw        s8, 0x343, s4
6240:             xor          zero, a0, t3
6241:             csrrc        s10, 0x343, zero
6242:             and          t6, t3, a4
6243:             andi         s8, a6, 150
6244:             nop
6245:             sra          s9, tp, s3
6246:             div          t1, s8, t3
6247:             or           t4, s2, s7
6248:             csrrwi       t5, 0x342, 29
6249:             div          t2, s4, ra
6250:             nop
6251:             csrrsi       s2, 0x344, 18
6252:             sra          a5, s5, a0
6253:             mul          a0, s3, t0
6254:             csrrw        s1, 0x344, s5
6255:             csrrci       s8, 0x304, 0
6256:             csrrci       t0, 0x342, 9
6257:             addi         s11, zero, -1652
6258:             sub          s0, a2, a4
6259:             or           s4, s8, s4
6260:             andi         tp, a2, -193
6261:             auipc        tp, 607867
6262:             csrrw        a1, 0x304, a3
6263:             srai         s6, t3, 2
6264:             xor          t3, s3, s0
6265:             nop
6266:             sra          a4, s9, a4
6267:             lui          a6, 189566
6268:             ori          s11, s6, -1870
6269:             rem          s2, s9, a1
6270:             slli         s3, s10, 28
6271:             ori          s3, s5, 615
6272:             csrrc        t4, 0x343, zero
6273:             remu         a5, sp, s8
6274:             or           a7, tp, ra
6275:             divu         t3, ra, t4
6276:             sltiu        ra, ra, 638
6277:             div          s11, tp, ra
6278:             csrrci       tp, 0x342, 0
6279:             csrrci       s0, 0x301, 31
6280:             csrrsi       t1, 0x300, 0
6281:             bge          t1, s6, 6296f
6282:             addi         a2, t1, -1903
6283:             csrrw        t4, 0x344, ra
6284:             slti         s3, a1, -1913
6285:             sltiu        s5, s9, 1829
6286:             csrrw        t1, 0x304, t3
6287:             beq          s5, s2, 6292f
6288:             xor          t2, s9, t3
6289:             csrrwi       a7, 0x342, 12
6290:             mulhu        s8, s2, ra
6291:             auipc        a6, 766935
6292:             and          s5, a3, ra
6293:             csrrwi       s1, 0x343, 3
6294:             andi         a5, s5, 1154
6295:             lui          gp, 987480
6296:             addi         tp, t1, 1872
6297:             remu         gp, s10, zero
6298:             srli         s0, t6, 1
6299:             addi         a5, s2, 79
6300:             beq          tp, s9, 6304f
6301:             srl          t1, a2, zero
6302:             mul          s2, s0, s11
6303:             add          a0, s6, a1
6304:             auipc        t4, 370669
6305:             csrrc        s3, 0x305, zero
6306:             div          s1, a4, t2
6307:             bgeu         s9, zero, 6308f
6308:             sll          s1, s1, s10
6309:             lui          a0, 1013012
6310:             sll          a2, t1, a4
6311:             sra          t0, t2, a2
6312:             divu         t6, s8, s1
6313:             bgeu         s4, a1, 6318f
6314:             mulhsu       t1, a0, s0
6315:             mulhu        s11, t1, s5
6316:             srli         a2, a5, 25
6317:             csrrc        t3, 0x300, zero
6318:             slli         s4, gp, 2
6319:             div          t5, t6, a3
6320:             beq          t0, sp, 6322f
6321:             csrrc        s11, 0x305, zero
6322:             sra          tp, t5, t4
6323:             andi         a6, t6, 1939
6324:             remu         gp, s5, s4
6325:             blt          s8, gp, 6339f
6326:             csrrwi       s11, 0x344, 10
6327:             mul          s8, ra, sp
6328:             csrrci       tp, 0x304, 0
6329:             sltu         t2, t4, sp
6330:             mul          a6, t3, a2
6331:             blt          s4, s2, 6338f
6332:             sra          s6, gp, a7
6333:             mulhsu       s9, s11, s0
6334:             and          s6, t6, s10
6335:             bge          t6, s11, 6338f
6336:             mulhu        ra, a1, ra
6337:             mulhu        a7, a4, t6
6338:             csrrci       t1, 0x305, 0
6339:             mulhsu       a4, a7, zero
6340:             sltiu        s9, s7, 1385
6341:             or           tp, s0, gp
6342:             lui          ra, 440580
6343:             sltiu        a6, s3, 864
6344:             addi         a0, a3, 1696
6345:             auipc        a7, 671725
6346:             xori         s10, s11, -168
6347:             csrrsi       t6, 0x300, 0
6348:             sra          t0, s4, t0
6349:             slt          t3, s5, t0
6350:             xor          s0, s5, zero
6351:             srai         t3, s11, 19
6352:             slli         s10, ra, 6
6353:             csrrs        a2, 0x343, s0
6354:             bgeu         s9, s6, 6364f
6355:             sltu         s10, t2, s6
6356:             blt          s4, a5, 6367f
6357:             nop
6358:             csrrc        zero, 0x344, zero
6359:             srai         zero, a0, 21
6360:             csrrci       a4, 0x301, 0
6361:             sltiu        a5, t4, 974
6362:             srai         a2, a5, 2
6363:             csrrwi       ra, 0x342, 13
6364:             sltiu        t4, s7, 1954
6365:             ori          t0, t1, -230
6366:             mul          t1, a4, t5
6367:             bge          s2, t1, 6371f
6368:             sltiu        s6, t5, -365
6369:             slti         a0, s5, -335
6370:             sll          s6, t2, ra
6371:             andi         t2, a1, 1476
6372:             sub          ra, zero, a3
6373:             ori          ra, a0, 1239
6374:             sltiu        t5, zero, -987
6375:             slti         s8, s5, -1919
6376:             divu         s11, s9, s1
6377:             bltu         t5, sp, 6380f
6378:             xor          gp, t5, s7
6379:             csrrci       a1, 0x344, 0
                  la           s2, region_1+47243 #start riscv_load_store_hazard_instr_stream_19
                  auipc        a7, 181093
                  sb           t6, 122(s2)
                  and          s10, a6, a3
                  sb           t1, 122(s2)
                  sb           ra, 78(s2)
                  lb           s9, -12(s2)
                  lb           a6, 199(s2)
                  lbu          s1, 24(s2)
                  sh           t4, 159(s2)
                  mulhu        a0, s1, a7
                  sltiu        zero, s9, 1538
                  sh           t1, 111(s2)
                  lb           s0, -170(s2)
                  lbu          ra, -170(s2)
                  lbu          s11, -170(s2)
                  sra          s1, a4, a3
                  lbu          s10, -4(s2)
                  lh           ra, -179(s2)
                  lhu          s6, -179(s2)
                  sw           zero, -179(s2)
                  lb           t1, 218(s2)
                  sb           s4, 218(s2)
                  csrrci       a2, 0x342, 0
                  sll          t2, t2, s8
                  lbu          a7, 118(s2)
                  sb           s10, -70(s2) #end riscv_load_store_hazard_instr_stream_19
6380:             mulhsu       a0, t6, t1
6381:             mulh         s0, ra, s3
6382:             slt          s10, s11, s10
6383:             bltu         sp, a7, 6396f
6384:             div          s10, ra, a2
6385:             or           a7, s1, s7
6386:             mulh         a4, t4, a0
6387:             slt          t3, s9, s4
6388:             sub          a6, t1, s11
6389:             bltu         a2, s0, 6407f
6390:             auipc        tp, 821738
6391:             addi         a7, t5, 1688
6392:             bge          t5, s5, 6403f
6393:             and          a7, t1, s8
6394:             sra          s2, a6, t2
6395:             mulhu        t5, s7, s9
6396:             mulh         s3, gp, t3
6397:             bltu         s3, a6, 6400f
6398:             slt          a5, a6, a4
6399:             divu         t3, a1, t1
6400:             xor          s5, s6, t0
6401:             rem          t4, a5, tp
6402:             bge          a1, s1, 6422f
6403:             bge          gp, a7, 6411f
6404:             sra          t1, a2, a3
6405:             csrrsi       s2, 0x305, 0
6406:             auipc        a7, 804533
6407:             add          t2, a1, t1
6408:             sub          t3, s1, t5
6409:             slti         s9, a7, 1344
6410:             lui          t3, 975749
6411:             slt          a5, a5, t4
6412:             csrrsi       s2, 0x342, 11
6413:             lui          t4, 851030
6414:             csrrci       s3, 0x342, 0
6415:             nop
6416:             sub          a4, s7, a1
6417:             beq          t6, t6, 6420f
6418:             divu         t6, t0, gp
6419:             mulh         s9, t5, t2
6420:             xor          s3, s9, t3
6421:             sltu         t0, a2, s3
6422:             mulhu        s8, a4, t1
6423:             andi         s5, s4, -52
6424:             mulhsu       s9, s6, ra
6425:             andi         ra, s10, 903
6426:             csrrci       t1, 0x301, 0
6427:             bgeu         t2, s10, 6428f
6428:             srai         zero, s2, 29
6429:             beq          ra, s11, 6433f
6430:             beq          s9, s9, 6438f
6431:             xori         s9, s5, -1124
6432:             sltiu        a0, s9, 1685
6433:             and          a2, s5, t6
6434:             sub          s4, s1, a7
6435:             xor          t1, a6, s4
6436:             bne          s9, s3, 6446f
6437:             slt          t3, s10, a6
6438:             sltiu        a7, t0, -701
6439:             bge          s0, a4, 6457f
6440:             slli         a7, a4, 10
6441:             ori          t6, sp, -1723
6442:             blt          s4, t0, 6451f
6443:             mulhu        s11, s8, a3
6444:             xor          t6, s9, t2
6445:             csrrw        s2, 0x301, t0
6446:             sltiu        s3, s7, 106
6447:             blt          s8, s2, 6451f
6448:             sll          a7, a0, gp
6449:             xor          t0, a7, s3
6450:             sll          t3, t1, a5
6451:             mulhu        a6, a4, a2
6452:             bltu         a0, t5, 6455f
6453:             csrrc        t2, 0x301, s2
6454:             auipc        a6, 138178
6455:             addi         s5, a1, -888
6456:             csrrwi       s2, 0x304, 11
6457:             andi         tp, a3, -415
6458:             sll          t6, a3, s4
6459:             bne          s1, s9, 6467f
6460:             or           s1, s1, t4
6461:             or           s0, s3, s7
6462:             andi         s3, s3, -1593
6463:             blt          s1, s10, 6474f
6464:             ori          s6, t5, -690
6465:             sra          gp, s10, t6
6466:             srl          s6, s7, a5
6467:             div          s11, s4, s4
6468:             and          t5, s11, s3
6469:             ori          s4, t2, -1491
6470:             slli         a4, gp, 3
6471:             srai         gp, a5, 24
6472:             slt          s11, s5, s10
6473:             bgeu         t6, s4, 6477f
6474:             divu         s3, t4, a2
6475:             addi         t6, s7, -1334
6476:             csrrsi       zero, 0x304, 26
6477:             srli         s5, s1, 12
6478:             mulh         s6, s0, t1
6479:             csrrwi       s4, 0x301, 11
6480:             addi         s6, t4, 1021
6481:             slti         a0, a1, 436
6482:             divu         s3, tp, a1
6483:             mulhu        s10, tp, s11
6484:             csrrw        s4, 0x304, t0
6485:             mul          t4, s6, s0
6486:             srl          t6, a4, s11
6487:             slt          a1, gp, s10
6488:             mulhu        gp, a0, t2
6489:             xori         zero, gp, -1203
6490:             csrrsi       t3, 0x300, 0
6491:             xori         a5, a7, 1740
6492:             remu         s4, t6, t0
6493:             beq          a5, s4, 6495f
6494:             bge          a6, sp, 6502f
6495:             csrrs        t5, 0x305, zero
6496:             blt          sp, a1, 6499f
6497:             add          a5, ra, a1
6498:             csrrs        a5, 0x300, zero
6499:             srl          s4, s8, s8
6500:             srai         s0, a5, 14
6501:             slti         tp, s11, 1379
6502:             addi         a4, t5, -1064
6503:             sra          s0, s8, a7
6504:             sub          ra, a7, gp
6505:             bltu         s4, s6, 6518f
6506:             bne          t2, t5, 6524f
6507:             beq          t0, t2, 6510f
6508:             csrrc        s6, 0x300, zero
6509:             mulhu        s3, t0, a1
6510:             xori         a7, t1, -47
6511:             srl          zero, s4, a7
6512:             and          t4, t2, a6
6513:             csrrsi       s3, 0x342, 22
6514:             ori          t1, s4, 1184
6515:             bne          s4, s3, 6520f
6516:             bge          a2, a6, 6530f
6517:             sltiu        a0, a7, 1267
6518:             sub          s4, a6, t0
6519:             mul          ra, t1, s7
6520:             csrrsi       s10, 0x344, 25
6521:             bgeu         t6, t3, 6525f
6522:             bgeu         t5, s2, 6540f
6523:             blt          gp, s9, 6533f
6524:             and          s10, a2, t4
6525:             srai         s5, a5, 5
6526:             divu         s4, s10, s9
6527:             remu         t5, a0, s0
6528:             sub          s2, t5, a7
6529:             addi         s2, s10, 1718
6530:             srli         t4, sp, 4
6531:             bne          t6, s8, 6540f
6532:             auipc        s5, 798357
6533:             ori          t3, s2, 558
6534:             div          a0, a5, s4
6535:             csrrc        s1, 0x304, a7
6536:             srai         s2, a1, 19
6537:             csrrc        s10, 0x342, zero
6538:             sll          t1, t2, zero
6539:             sra          tp, a5, a3
6540:             addi         t3, sp, 77
6541:             mulhu        s2, tp, t2
6542:             auipc        t1, 83125
6543:             lui          a2, 880448
6544:             mulhsu       t6, a1, s9
6545:             remu         a5, t3, t6
6546:             xor          s5, s5, a4
6547:             csrrwi       s3, 0x342, 13
6548:             csrrc        zero, 0x301, zero
6549:             slti         a7, s5, 1121
6550:             add          t4, a6, s2
6551:             csrrwi       a5, 0x343, 17
6552:             div          t2, a0, s1
6553:             lui          s1, 1032926
6554:             bne          ra, t6, 6559f
6555:             csrrw        s3, 0x344, a5
6556:             sub          zero, t1, a1
6557:             csrrw        a0, 0x301, s9
6558:             mul          s6, s5, gp
6559:             mulhu        t3, s3, s7
6560:             sub          a0, tp, tp
6561:             blt          t0, a0, 6571f
6562:             sltu         t1, s5, a7
6563:             bne          gp, gp, 6574f
6564:             nop
6565:             sltu         a7, s5, t2
6566:             xori         a5, s5, -779
6567:             divu         ra, a3, t4
6568:             bltu         t3, zero, 6580f
6569:             csrrsi       s2, 0x344, 11
6570:             bne          s5, a1, 6581f
6571:             srl          s2, t3, a0
6572:             sll          s3, s8, s6
6573:             div          ra, s5, a0
6574:             div          a7, t0, gp
6575:             slli         a1, ra, 16
6576:             mulhu        gp, s10, t5
6577:             bne          t2, s11, 6580f
6578:             srl          a0, t0, s5
                  la           s11, region_1+61186 #start riscv_load_store_rand_instr_stream_8
                  lb           s5, -1479(s11)
                  sra          t4, a0, s1
                  lbu          s8, 1879(s11)
                  rem          s4, tp, s1
                  srl          t0, a6, s10
                  slli         s1, s5, 13
                  lw           a4, -654(s11)
                  mul          a6, s9, s1
                  lh           a1, -204(s11)
                  xor          a0, s7, s10
                  lbu          t3, -2030(s11)
                  add          s0, s2, s10
                  csrrci       t3, 0x342, 25
                  sltiu        zero, t0, -1240
                  sll          ra, a3, a0
                  lbu          s3, 1405(s11)
                  rem          t5, a0, s11
                  xori         s6, a2, -1621
                  lw           t0, -1418(s11)
                  lbu          a7, 273(s11)
                  lhu          t6, 612(s11)
                  srl          tp, a3, t5
                  xori         gp, s10, -142
                  lbu          t1, 1629(s11)
                  srl          ra, s4, t0
                  sb           ra, -1552(s11)
                  lbu          s8, 542(s11)
                  lb           s9, -19(s11)
                  xori         a0, s5, -1513
                  lbu          s0, -283(s11)
                  nop
                  sb           s10, 591(s11)
                  sh           t5, -2036(s11)
                  lbu          t4, 1305(s11)
                  or           s2, s10, t4
                  or           s9, s9, s0
                  lbu          s8, -1483(s11)
                  lui          s4, 204452
                  mulh         s4, t4, a1
                  lb           t5, 1798(s11)
                  mul          t5, s9, t6
                  xori         t1, s11, 439
                  remu         s6, s2, a2
                  slti         tp, a7, -2028
                  sb           a4, -1409(s11)
                  mulhsu       a5, t4, a3
                  sw           ra, -810(s11) #end riscv_load_store_rand_instr_stream_8
6579:             slti         a2, ra, -1284
6580:             sub          t0, s3, a5
6581:             mulh         a6, s11, s0
6582:             blt          a5, a5, 6583f
6583:             blt          s5, a2, 6586f
6584:             xor          a7, t0, ra
6585:             bge          s9, a6, 6605f
6586:             divu         s2, sp, a1
6587:             and          zero, a4, s9
6588:             divu         a7, s10, a2
6589:             blt          s0, zero, 6590f
6590:             addi         a1, zero, -641
6591:             csrrw        s2, 0x343, s5
6592:             csrrwi       s1, 0x304, 7
6593:             csrrs        s2, 0x342, zero
6594:             mulhsu       a4, s11, s10
6595:             sub          t3, s11, s1
6596:             slt          t4, a4, sp
6597:             sra          s11, s10, t6
6598:             csrrsi       s11, 0x305, 0
6599:             auipc        gp, 1037547
6600:             sltu         s2, a1, s2
6601:             mulhsu       t6, s3, sp
6602:             bne          t0, s2, 6617f
6603:             sll          gp, t2, sp
6604:             xori         a4, s2, 1713
6605:             or           s5, s3, s5
6606:             mul          t0, t6, a1
6607:             rem          s6, s1, a0
6608:             csrrs        s5, 0x343, zero
6609:             sll          zero, a2, s6
6610:             sub          s6, s6, a6
6611:             sra          s8, s7, s4
6612:             divu         a2, sp, a0
6613:             csrrsi       s4, 0x343, 0
6614:             and          a0, t3, s11
6615:             mulhsu       s3, t2, t5
6616:             and          t2, s4, t5
6617:             remu         t1, ra, s1
6618:             csrrci       a1, 0x342, 0
6619:             divu         a0, zero, a7
6620:             slti         a7, s8, 1224
6621:             csrrc        ra, 0x301, zero
6622:             slli         s9, s11, 2
6623:             bltu         s6, s4, 6629f
6624:             div          a7, s1, t5
6625:             sltu         a6, a2, a6
6626:             mulhsu       a5, s1, a6
6627:             andi         s9, s6, -1618
6628:             bgeu         s7, s7, 6635f
6629:             mulhu        t5, ra, a3
6630:             remu         t0, s7, s8
6631:             slt          gp, t2, a0
6632:             nop
6633:             auipc        a6, 108615
6634:             divu         s4, s7, s10
6635:             rem          t3, t5, t5
6636:             srli         s1, s5, 31
6637:             srl          s10, t4, t1
6638:             srli         s2, t1, 3
6639:             mulh         s9, tp, gp
6640:             srli         t4, a7, 8
6641:             andi         t5, tp, -773
6642:             sltu         t1, gp, t1
6643:             remu         a7, s0, s6
6644:             blt          a3, a5, 6656f
6645:             csrrw        s9, 0x304, zero
6646:             ori          t0, s4, -416
6647:             sll          s8, s5, s7
6648:             beq          ra, s5, 6656f
6649:             ori          s1, t0, 1176
6650:             mulhu        gp, a6, t1
6651:             srli         s2, s2, 14
6652:             nop
6653:             csrrw        s4, 0x343, t0
6654:             sltu         s0, a5, ra
6655:             sra          s1, a6, s4
6656:             srai         s2, s6, 24
6657:             xori         t6, a7, 224
6658:             ori          s4, gp, -584
6659:             lui          t3, 568878
6660:             sltu         t6, zero, s10
6661:             sltu         zero, a3, t2
6662:             divu         zero, ra, t6
6663:             sub          a7, a4, s8
6664:             csrrci       zero, 0x343, 11
6665:             sra          t6, s10, s8
6666:             sltu         a4, a3, gp
6667:             csrrsi       s4, 0x343, 16
6668:             mulhu        s2, s3, s4
6669:             srl          s10, a2, t5
6670:             rem          t6, t3, gp
6671:             and          s9, s2, zero
6672:             rem          s10, ra, s11
6673:             mul          s11, t6, s6
6674:             slti         a4, t0, 117
6675:             auipc        s3, 161849
6676:             sltiu        gp, s2, 1465
6677:             sltu         s11, zero, ra
6678:             remu         t1, t0, ra
6679:             nop
6680:             srli         t2, zero, 14
6681:             nop
6682:             xor          s4, t2, s7
6683:             nop
6684:             csrrci       s0, 0x304, 3
6685:             remu         s4, a6, a5
6686:             csrrsi       zero, 0x344, 0
6687:             sub          t0, s8, sp
6688:             bltu         s7, t1, 6689f
6689:             div          a5, t4, s5
6690:             csrrw        t4, 0x344, t1
6691:             div          s1, s3, s8
6692:             sltu         s5, t1, s10
6693:             div          a2, a3, s8
6694:             srl          s5, t3, s2
6695:             srai         t0, t3, 12
6696:             ori          a5, sp, 483
6697:             and          s0, s4, a4
6698:             blt          s10, s9, 6707f
6699:             beq          a3, a0, 6710f
6700:             csrrsi       a0, 0x304, 0
6701:             bne          t0, s4, 6715f
6702:             xor          a0, a2, a4
6703:             mul          t0, a5, t6
6704:             remu         s9, gp, zero
6705:             and          gp, s11, s11
6706:             sltiu        t3, a4, 1121
6707:             nop
6708:             remu         ra, a3, a7
6709:             and          zero, s2, s2
6710:             ori          t6, t3, -605
6711:             srai         s9, zero, 27
6712:             andi         t1, s8, 2019
6713:             srli         s6, t0, 27
6714:             csrrsi       a6, 0x342, 4
6715:             add          s3, a7, a3
6716:             xor          t4, t4, a5
6717:             mulhsu       t3, s3, a2
6718:             xor          gp, a7, s7
6719:             sll          a5, gp, gp
6720:             csrrs        t6, 0x301, zero
6721:             mul          t2, s4, a3
6722:             sltiu        s5, a6, 699
6723:             bge          s3, t6, 6738f
6724:             csrrc        s0, 0x301, zero
6725:             srl          t4, zero, s7
6726:             csrrsi       s5, 0x301, 21
6727:             sltiu        t2, s8, -651
6728:             csrrw        s6, 0x342, ra
6729:             bgeu         tp, s6, 6732f
6730:             slti         t2, s10, 590
6731:             bne          t6, t3, 6735f
6732:             auipc        ra, 214979
6733:             div          t2, ra, zero
6734:             sra          t5, s7, s0
6735:             csrrw        s0, 0x342, sp
6736:             remu         gp, s8, a6
6737:             sltu         t5, a2, t5
6738:             sll          s10, sp, t3
6739:             bge          s7, a3, 6743f
6740:             bgeu         s3, s6, 6743f
6741:             blt          ra, s7, 6748f
6742:             bge          t6, s6, 6760f
6743:             srl          s5, a6, a0
6744:             lui          gp, 697989
6745:             blt          t4, s3, 6750f
6746:             remu         t6, t5, gp
6747:             bge          s1, a4, 6751f
6748:             mulhsu       s2, t3, gp
6749:             sub          zero, t1, t6
6750:             srai         a1, s8, 29
6751:             srai         s6, s3, 21
6752:             blt          a5, t3, 6755f
6753:             srl          a5, s3, sp
6754:             csrrw        ra, 0x342, sp
6755:             add          s10, s9, s7
6756:             bge          s5, t3, 6757f
6757:             blt          a3, a2, 6762f
6758:             bltu         a6, t0, 6769f
6759:             csrrw        s1, 0x304, s0
6760:             rem          s2, s9, sp
6761:             and          t2, t2, s4
6762:             srai         s2, s7, 3
6763:             divu         s6, s11, t5
6764:             csrrc        s10, 0x342, zero
6765:             srai         t6, t3, 21
6766:             slli         a2, sp, 14
6767:             ori          t1, t3, -1249
6768:             xor          s9, s0, tp
6769:             slt          t5, sp, s5
6770:             addi         s9, t3, 54
6771:             nop
6772:             csrrw        a4, 0x343, t3
6773:             remu         ra, a0, s0
6774:             ori          t4, a1, 1598
6775:             xor          t4, tp, s5
6776:             slt          a6, t1, t2
6777:             divu         t2, s0, zero
6778:             remu         a7, t3, s2
6779:             blt          sp, s5, 6789f
6780:             bltu         a0, a3, 6800f
6781:             bne          t0, t6, 6792f
6782:             mulhu        s0, s8, zero
6783:             sll          zero, a3, t3
6784:             csrrs        s4, 0x342, zero
6785:             srai         a0, tp, 12
6786:             div          a1, s9, t2
6787:             slli         a4, s4, 5
6788:             divu         ra, s9, a4
6789:             bne          s1, a4, 6802f
6790:             sll          s11, a5, s6
6791:             div          s10, s4, s5
6792:             slli         t1, a1, 25
6793:             add          s0, t6, a5
6794:             xor          t4, tp, a0
6795:             srli         t0, a2, 19
6796:             andi         t1, s0, -1795
6797:             srai         t5, s3, 27
6798:             divu         ra, t2, t4
6799:             csrrw        s5, 0x343, ra
6800:             sltiu        t1, a1, -1908
6801:             beq          a5, a6, 6803f
6802:             csrrsi       s2, 0x342, 0
6803:             divu         a4, sp, a2
6804:             xor          a4, t2, a7
6805:             mulhu        s1, s5, t5
6806:             or           s6, t6, s9
6807:             or           t5, a5, s0
6808:             bge          zero, t0, 6811f
6809:             div          s6, s5, s9
6810:             bge          a3, t6, 6820f
6811:             mulh         t6, zero, s3
6812:             nop
6813:             srai         t2, tp, 10
6814:             blt          a0, a6, 6822f
6815:             slti         t5, a1, -1345
6816:             or           tp, zero, t4
6817:             rem          gp, t4, s10
6818:             srli         t1, a4, 30
6819:             auipc        s2, 384594
6820:             beq          t1, t3, 6826f
6821:             mulhu        s9, s0, t5
6822:             xor          t3, s0, t3
6823:             srl          s9, s10, t3
6824:             slt          t3, s1, s11
6825:             ori          a6, t0, -1524
6826:             auipc        a2, 552351
6827:             slli         a1, s1, 1
6828:             slti         s11, t0, -852
6829:             mulh         a2, sp, t1
6830:             or           t5, t1, s9
6831:             auipc        s6, 788625
6832:             bge          t3, t4, 6835f
6833:             srl          a7, s7, s5
6834:             mulh         s6, t3, t5
6835:             slt          s6, gp, t3
6836:             remu         s5, s0, t2
6837:             mul          t4, t6, s10
6838:             lui          s3, 852659
6839:             mulhsu       s1, s3, s1
6840:             sll          gp, t2, zero
6841:             csrrw        s1, 0x301, s7
6842:             sra          t6, t3, a4
6843:             srai         a7, s11, 21
6844:             csrrc        s0, 0x344, zero
6845:             lui          zero, 561571
6846:             mul          s8, s7, s5
6847:             mulhu        a7, t0, a1
6848:             csrrw        t2, 0x342, s1
6849:             beq          a1, s9, 6867f
6850:             slt          a1, s1, s9
6851:             mulh         a7, a0, t5
6852:             sll          a7, s6, t4
6853:             srli         s2, s9, 23
6854:             lui          a5, 1033109
6855:             ori          s5, a3, -1314
6856:             blt          t6, s1, 6859f
6857:             xor          s11, s11, t0
6858:             sra          t3, a0, t1
6859:             sub          t3, s5, s10
6860:             addi         s0, zero, 669
6861:             lui          t6, 111242
6862:             csrrsi       t2, 0x301, 0
6863:             bltu         sp, a1, 6873f
6864:             slt          s6, s3, a6
6865:             or           t1, s3, t1
6866:             mulhu        t1, s8, s0
6867:             bltu         ra, a4, 6878f
6868:             bgeu         s2, s7, 6871f
6869:             mul          a6, s4, a7
6870:             sltu         s3, s9, s10
6871:             csrrci       s4, 0x343, 0
6872:             srli         t5, gp, 2
6873:             sltu         a4, s10, a0
6874:             divu         a7, s0, t0
6875:             xor          s1, s8, ra
6876:             csrrci       gp, 0x301, 0
6877:             or           t0, s10, ra
6878:             mulh         t3, t6, a2
6879:             xor          t5, t6, t4
6880:             divu         gp, a7, s6
6881:             mulhu        t6, s11, s8
6882:             sll          ra, s3, s5
6883:             sltu         s1, a4, s1
6884:             mulhsu       a1, s5, s1
6885:             slli         a6, t1, 6
6886:             sra          ra, a0, t3
6887:             bgeu         s1, s10, 6897f
6888:             div          t2, s4, s9
6889:             mulhsu       a6, a0, s0
6890:             sra          s9, t2, t1
6891:             csrrwi       s11, 0x342, 2
6892:             slli         s3, s3, 23
6893:             srai         s4, s8, 5
6894:             sra          t2, s10, s7
6895:             csrrsi       a4, 0x343, 13
6896:             csrrc        a2, 0x342, zero
6897:             div          s0, a5, s5
6898:             slt          t4, a1, s11
6899:             mulhsu       gp, t1, a7
6900:             csrrci       ra, 0x344, 0
6901:             mulhu        a5, s5, s7
6902:             sll          s4, ra, s6
6903:             csrrc        t1, 0x344, t2
6904:             andi         s0, s4, 1598
6905:             bge          t5, a0, 6913f
6906:             csrrwi       t2, 0x304, 22
6907:             srli         ra, zero, 26
6908:             or           a7, s8, gp
6909:             or           s4, s7, s0
6910:             slli         a7, s2, 4
6911:             div          gp, s9, zero
6912:             sll          zero, a2, t3
6913:             csrrc        a4, 0x344, s3
6914:             xori         a5, s2, 930
6915:             csrrsi       ra, 0x301, 0
6916:             blt          t2, a6, 6922f
6917:             csrrwi       t4, 0x304, 26
6918:             blt          a5, s10, 6922f
6919:             mulh         a1, s10, s3
6920:             remu         s6, t1, s1
6921:             sll          s11, a3, s4
6922:             bltu         a1, a2, 6936f
6923:             mulhu        gp, a7, zero
6924:             sll          s0, sp, s9
6925:             ori          t0, a4, 1935
6926:             auipc        s10, 486792
6927:             lui          t4, 177871
6928:             bge          t5, t4, 6932f
6929:             slli         a6, t5, 26
6930:             mul          s11, s0, t0
6931:             csrrci       s3, 0x304, 23
6932:             csrrw        s3, 0x342, s11
6933:             add          t2, s7, t6
6934:             csrrsi       a6, 0x305, 0
                  la           s1, region_1+53960 #start riscv_hazard_instr_stream_31
                  sltu         a5, s8, a6
                  sub          t1, a6, a5
                  andi         t1, s8, -115
                  nop
                  lb           s8, -185(s1)
                  sh           a6, -180(s1)
                  sb           a0, -245(s1)
                  lbu          s0, -20(s1)
                  sh           a0, 150(s1)
                  ori          a5, t1, 50
                  lb           a5, 43(s1)
                  lbu          s8, 27(s1)
                  csrrw        a5, 0x343, a6
                  srli         a6, s0, 21
                  sra          a6, s0, a6
                  lbu          t1, -153(s1)
                  sltiu        a6, s8, 941
                  lw           a5, -128(s1)
                  slt          s0, s8, s8
                  sltiu        a6, a6, 683
                  csrrwi       a0, 0x342, 27
                  lbu          s8, 221(s1)
                  auipc        a5, 343180
                  andi         t1, a6, -1878
                  sltu         a0, a0, a0
                  lb           a0, -171(s1)
                  mulhsu       t1, a0, a0
                  lb           a5, -38(s1)
                  srl          s8, a5, a5
                  sltu         s8, a5, a6
                  lb           t1, 237(s1)
                  xori         t1, a5, -230
                  lbu          t1, -57(s1)
                  sll          a5, t1, a6
                  lbu          s8, 221(s1)
                  addi         a6, a6, -1384
                  lh           t1, 38(s1)
                  sb           t1, 183(s1)
                  andi         a0, a0, 1226
                  mulh         s0, a5, a6
                  sb           a0, -88(s1)
                  mulh         a0, a0, a6
                  lb           t1, -61(s1)
                  lhu          s0, 14(s1)
                  mulhu        a5, s8, s8
                  lbu          a6, -179(s1)
                  andi         a6, a6, -1943
                  nop
                  sltiu        a5, s0, 1924
                  divu         s8, s8, t1
                  lb           t1, 238(s1) #end riscv_hazard_instr_stream_31
6935:             andi         a2, s6, -196
6936:             and          gp, a3, a6
6937:             slt          a1, s0, a2
6938:             and          t0, t5, s10
6939:             mulhsu       a7, s2, tp
6940:             csrrw        s0, 0x301, t6
6941:             sll          a4, a4, s5
6942:             csrrci       a7, 0x343, 14
6943:             sltu         s2, zero, s0
6944:             sub          s6, t4, a7
6945:             csrrwi       a4, 0x344, 4
6946:             slli         a2, a5, 22
6947:             slli         s10, s11, 16
6948:             csrrsi       t4, 0x344, 7
6949:             divu         t5, a4, s8
6950:             lui          s8, 538888
6951:             addi         s5, a0, -1165
6952:             auipc        ra, 970883
6953:             nop
6954:             nop
6955:             blt          s3, t1, 6964f
6956:             and          a1, t0, a5
6957:             bltu         t0, s8, 6959f
6958:             andi         a6, s11, -622
6959:             xori         s4, s2, 1186
6960:             srai         gp, t3, 22
6961:             bltu         t4, s2, 6968f
6962:             rem          gp, t0, zero
6963:             sltiu        s11, a7, 605
6964:             slti         zero, ra, -1149
6965:             auipc        s1, 10724
6966:             xori         t3, t1, 1908
6967:             slti         t0, s0, -1340
6968:             div          s6, a6, s11
6969:             csrrs        s4, 0x342, a3
6970:             bge          a7, a5, 6971f
6971:             xori         s5, s3, 1076
6972:             add          t0, s1, a0
6973:             nop
6974:             auipc        t1, 295334
6975:             remu         s1, a4, tp
6976:             div          tp, s10, t5
6977:             bge          s1, gp, 6995f
6978:             div          t6, tp, s0
6979:             and          t5, s8, zero
6980:             lui          s4, 513868
6981:             addi         gp, s1, -1250
6982:             srl          t0, s6, a3
6983:             csrrw        a6, 0x343, a1
6984:             blt          s11, a6, 6999f
6985:             csrrwi       a2, 0x301, 2
6986:             nop
6987:             and          t3, tp, s0
6988:             or           s2, t2, a5
6989:             csrrc        t5, 0x300, zero
6990:             sltu         s3, s1, t4
6991:             slli         s11, t4, 8
6992:             sra          s10, t2, a3
6993:             add          s0, zero, gp
6994:             slli         s5, t2, 12
6995:             srl          s9, t5, s4
6996:             srl          ra, a6, a3
6997:             add          t6, s6, s11
6998:             slli         t4, a6, 25
6999:             sll          t2, t4, t1
7000:             csrrc        s2, 0x304, ra
7001:             and          t5, a4, t4
7002:             slti         s6, a4, 1083
7003:             ori          s10, a3, -1226
7004:             csrrw        s8, 0x301, t6
7005:             mul          ra, t4, a0
7006:             xor          a1, t2, s7
7007:             csrrs        s5, 0x301, zero
7008:             sra          s11, a3, ra
7009:             bne          s4, sp, 7020f
7010:             srai         s3, a5, 24
7011:             ori          s11, t6, 941
7012:             divu         tp, a0, t4
7013:             nop
7014:             mul          s3, sp, t3
7015:             add          s6, t4, gp
7016:             csrrwi       s9, 0x304, 26
7017:             bltu         s5, t4, 7037f
7018:             addi         a5, s11, 1839
7019:             or           a7, s5, a3
7020:             addi         s11, s11, -422
7021:             nop
7022:             csrrwi       s10, 0x342, 3
7023:             div          s1, gp, sp
7024:             slli         s6, s10, 23
7025:             or           a0, t1, s6
7026:             srl          t3, t0, a7
7027:             sub          s10, t5, t5
7028:             csrrs        s5, 0x304, zero
7029:             bltu         a6, s3, 7034f
7030:             csrrw        s10, 0x301, a3
7031:             slt          zero, t3, tp
7032:             or           s5, a0, t4
7033:             srai         tp, s4, 9
7034:             csrrsi       t0, 0x300, 0
7035:             xori         a6, t3, -187
7036:             srli         zero, s1, 27
7037:             mulh         s4, t4, t5
7038:             csrrw        s0, 0x304, s9
7039:             sltu         a1, a5, s3
7040:             slli         s8, s1, 29
7041:             rem          s0, t0, s10
7042:             slli         s5, a4, 1
7043:             divu         a0, a2, s9
7044:             csrrci       s3, 0x344, 8
7045:             csrrwi       t4, 0x304, 7
7046:             srl          ra, s11, t5
7047:             slt          s6, s10, s5
7048:             lui          t2, 255737
7049:             divu         s0, s10, s2
7050:             srl          a0, ra, s3
7051:             srli         s4, a4, 17
7052:             bltu         sp, t4, 7064f
7053:             blt          a0, s6, 7056f
7054:             lui          t4, 894346
7055:             addi         s5, t5, 582
7056:             lui          s10, 19309
7057:             csrrsi       s2, 0x305, 0
7058:             lui          t5, 160671
7059:             bgeu         a1, a1, 7064f
7060:             slt          t5, s2, a5
7061:             srl          s11, s5, t4
7062:             mulhsu       s4, sp, s10
7063:             sra          s2, t4, t5
7064:             csrrwi       t4, 0x304, 13
7065:             csrrs        s8, 0x305, zero
7066:             blt          a6, a7, 7084f
7067:             xori         s10, s9, -862
7068:             csrrw        a6, 0x343, a2
7069:             auipc        t3, 583025
7070:             andi         s9, s0, 1306
7071:             remu         s10, a0, t3
7072:             xori         gp, zero, -1076
7073:             csrrw        s6, 0x304, s3
7074:             or           s4, tp, s0
7075:             sll          s8, gp, t0
7076:             bge          t3, t2, 7080f
7077:             xori         s2, gp, 300
7078:             or           s11, sp, ra
7079:             beq          t3, s3, 7080f
7080:             auipc        s3, 843003
7081:             remu         s4, t1, s8
7082:             csrrs        s8, 0x305, zero
7083:             or           t2, s11, t4
7084:             mulhsu       s10, t2, a2
7085:             bltu         a4, s1, 7088f
7086:             sltu         t2, t1, a2
7087:             addi         s9, s11, -608
7088:             csrrsi       s5, 0x344, 0
7089:             srli         a2, s5, 12
7090:             mul          t0, ra, t1
7091:             srli         zero, t1, 8
7092:             mulhu        t4, ra, s10
7093:             and          gp, a7, a4
7094:             rem          a1, a7, gp
7095:             auipc        ra, 671888
7096:             mulhsu       t0, s2, a0
7097:             rem          s5, t6, t2
7098:             rem          s8, s7, ra
7099:             div          t6, t6, s8
7100:             beq          sp, sp, 7111f
7101:             bgeu         s6, t2, 7109f
7102:             blt          sp, s4, 7105f
7103:             and          s6, a3, s1
7104:             sra          gp, s3, s2
7105:             csrrwi       t3, 0x342, 27
7106:             bge          t1, t6, 7119f
7107:             csrrwi       t6, 0x344, 25
7108:             div          s8, gp, a4
7109:             csrrc        zero, 0x342, s2
7110:             srai         s3, a4, 4
7111:             csrrc        tp, 0x305, zero
                  la           a7, region_0+1931 #start riscv_load_store_rand_instr_stream_1
                  mulhsu       s1, a7, a3
                  lw           gp, 97(a7)
                  sltu         a5, sp, a1
                  remu         t1, tp, sp
                  lb           s3, -752(a7)
                  lhu          t2, 1173(a7)
                  mulhu        a4, s2, a3
                  add          ra, s11, a3
                  sra          t5, t6, t2
                  lbu          s11, 948(a7)
                  sh           t0, 905(a7)
                  lbu          a1, -1015(a7)
                  csrrc        zero, 0x301, s0
                  lh           s5, 1447(a7)
                  div          tp, t6, t4
                  lbu          t0, -1228(a7)
                  lhu          a2, 2009(a7)
                  srai         t5, s0, 22
                  lhu          s11, -1225(a7)
                  sb           s10, 18(a7)
                  sb           s7, -1378(a7)
                  sh           t5, -1251(a7)
                  lb           a5, -806(a7)
                  lbu          t6, -1198(a7)
                  lbu          a6, 1006(a7)
                  lb           s2, 1245(a7)
                  sb           t2, -1442(a7)
                  lui          s8, 645585
                  lbu          t5, -1682(a7)
                  srai         t3, s6, 9
                  lb           s2, -1714(a7)
                  sb           a0, 340(a7) #end riscv_load_store_rand_instr_stream_1
7112:             mul          s11, s2, a7
7113:             slli         s9, sp, 2
7114:             and          gp, s1, tp
7115:             auipc        ra, 594651
7116:             and          t5, ra, a3
7117:             csrrc        s8, 0x305, zero
7118:             divu         a4, t5, t5
7119:             bgeu         t0, t5, 7122f
7120:             bne          tp, s2, 7138f
7121:             srai         s11, a5, 21
7122:             csrrwi       s0, 0x343, 29
7123:             sra          t6, s7, a2
7124:             slt          a5, t4, t2
7125:             srai         a5, s3, 9
7126:             div          t5, s10, zero
7127:             csrrsi       t0, 0x301, 0
7128:             csrrci       a1, 0x301, 17
7129:             csrrc        s11, 0x343, a0
7130:             sll          s4, t2, ra
7131:             mulhsu       t3, t5, zero
7132:             sltu         a0, t3, a4
7133:             csrrc        s9, 0x300, zero
7134:             bltu         a2, s3, 7137f
7135:             mulhsu       s1, a6, t2
7136:             or           zero, gp, t1
7137:             rem          s5, s7, a0
7138:             lui          gp, 621235
7139:             blt          ra, a1, 7142f
7140:             srli         gp, s2, 1
7141:             csrrc        s2, 0x301, zero
7142:             sltu         a7, a2, s8
7143:             bltu         t6, sp, 7154f
7144:             bne          a3, t6, 7155f
7145:             csrrwi       a5, 0x343, 25
7146:             csrrs        s4, 0x305, zero
7147:             slli         s0, s0, 14
7148:             andi         s6, s8, -103
7149:             beq          t4, tp, 7156f
7150:             lui          s0, 609833
7151:             mulhsu       s11, a7, t0
7152:             sub          s9, a6, s7
7153:             andi         s11, s10, 1374
7154:             addi         zero, gp, 1159
7155:             mul          s0, s4, a6
7156:             mul          t5, a1, t6
7157:             csrrs        a0, 0x305, zero
7158:             bge          t1, a6, 7164f
7159:             bltu         s6, zero, 7163f
7160:             beq          s4, t2, 7168f
7161:             bgeu         s5, t5, 7170f
7162:             add          s4, s3, t4
7163:             beq          gp, a0, 7168f
7164:             beq          s6, gp, 7172f
7165:             csrrc        s5, 0x344, zero
7166:             ori          t3, t1, 1053
7167:             csrrc        tp, 0x344, s1
7168:             srli         s8, tp, 9
7169:             blt          t5, zero, 7171f
7170:             xor          s1, t3, a3
7171:             divu         s4, a0, s9
7172:             blt          a1, t2, 7187f
7173:             div          s3, t1, t3
7174:             mulhu        s2, tp, s3
7175:             srli         s10, t4, 2
7176:             csrrsi       s3, 0x301, 22
7177:             remu         tp, t6, sp
7178:             sltu         s3, s8, a7
7179:             srl          a2, ra, gp
7180:             slti         a4, sp, 1352
7181:             csrrc        t4, 0x304, a3
7182:             mulh         s0, s0, s11
7183:             sll          t6, tp, sp
7184:             bltu         s8, a6, 7198f
7185:             srl          t5, t3, tp
7186:             auipc        tp, 1025630
7187:             and          s0, t2, s4
7188:             lui          t4, 347281
7189:             srli         tp, a4, 30
7190:             mulhsu       a5, a4, t2
7191:             blt          a2, a5, 7204f
7192:             csrrci       t1, 0x300, 0
7193:             sltiu        zero, t5, 299
7194:             slli         s10, t4, 28
7195:             slt          s0, t1, s11
7196:             sltu         a5, t1, t3
7197:             srli         t0, s6, 10
7198:             sub          s9, a3, s10
7199:             sltiu        s11, a1, 1305
7200:             beq          a6, s3, 7205f
7201:             csrrsi       a6, 0x342, 0
7202:             andi         t6, s5, -1918
7203:             nop
7204:             xori         s9, s5, -1829
7205:             mulhsu       s10, s4, a7
7206:             div          a0, s2, gp
7207:             nop
7208:             mulhu        gp, t1, s1
7209:             sltiu        s4, s5, -315
7210:             bne          s3, a1, 7220f
7211:             lui          s10, 561471
7212:             slli         t5, a6, 14
7213:             csrrc        a2, 0x305, zero
7214:             bge          s11, s8, 7217f
7215:             sub          tp, a1, a3
7216:             bgeu         a0, s10, 7217f
7217:             srli         a1, a4, 31
7218:             mul          s4, a5, s0
7219:             remu         s2, t2, t4
7220:             slli         s6, t3, 29
7221:             lui          t6, 556128
7222:             bgeu         ra, t5, 7242f
7223:             slli         a1, ra, 24
7224:             xor          s6, a1, t0
7225:             srl          s3, a7, a0
7226:             bne          s3, s7, 7230f
7227:             csrrwi       t3, 0x301, 23
7228:             xori         a6, a1, -991
7229:             bltu         t1, t3, 7239f
7230:             srli         t2, zero, 15
7231:             remu         a0, t0, a4
7232:             slt          tp, tp, a4
7233:             div          ra, a2, ra
7234:             csrrs        s2, 0x301, a0
7235:             rem          s8, s8, t6
7236:             xori         s11, s11, -1310
7237:             rem          gp, t4, a0
7238:             remu         s11, t6, zero
7239:             slli         a5, s2, 16
7240:             csrrs        a6, 0x305, zero
7241:             div          t2, s11, s11
7242:             mul          zero, t5, t1
7243:             beq          s8, s9, 7247f
7244:             bne          s6, t0, 7256f
7245:             slt          s1, t5, s11
7246:             mul          t6, s10, a0
7247:             csrrs        a1, 0x300, zero
7248:             srli         ra, t2, 23
7249:             srl          s11, t3, s7
7250:             addi         s2, a6, -524
7251:             sltu         s11, a6, s7
7252:             sub          t0, t6, gp
7253:             bltu         s11, s10, 7254f
7254:             csrrci       a6, 0x344, 0
7255:             ori          a1, sp, 195
7256:             slt          s11, a2, a7
7257:             xori         t5, a4, -819
7258:             bne          s0, ra, 7269f
7259:             nop
7260:             divu         t4, s11, t0
7261:             csrrwi       t6, 0x342, 25
7262:             or           gp, a1, t1
7263:             csrrw        zero, 0x343, t0
7264:             xor          s9, t6, s0
7265:             rem          t3, s3, s7
7266:             div          a1, gp, ra
7267:             addi         s5, gp, 1380
7268:             srli         gp, a0, 0
7269:             beq          sp, t2, 7272f
7270:             or           t5, s6, a7
7271:             xor          a1, a1, t1
7272:             sltiu        s11, s5, -1865
7273:             blt          t1, t3, 7291f
7274:             csrrwi       a6, 0x343, 19
7275:             add          s10, a2, s10
7276:             or           a6, s4, a4
7277:             mul          s0, a7, a1
7278:             xori         t2, sp, 825
7279:             xor          a4, t3, a0
7280:             div          s10, s10, sp
7281:             csrrw        t4, 0x301, t5
7282:             bltu         a3, t0, 7293f
7283:             xori         gp, s3, 920
7284:             srli         s2, s11, 15
7285:             blt          tp, s9, 7303f
7286:             csrrc        s11, 0x344, zero
7287:             and          s2, t2, s2
7288:             sltu         s3, a4, s7
7289:             srl          t5, s9, a7
7290:             andi         s8, s11, -1394
7291:             csrrwi       t1, 0x342, 17
7292:             sll          s10, s10, t6
7293:             bgeu         t1, zero, 7304f
7294:             xori         s2, t2, 1803
7295:             srai         s4, a7, 8
7296:             beq          s4, s4, 7300f
7297:             slt          t5, s1, s1
7298:             remu         t0, s5, s1
7299:             remu         ra, tp, s6
7300:             slt          a1, s8, t0
7301:             sll          t6, gp, s3
7302:             remu         a0, t0, s1
7303:             blt          t3, sp, 7304f
7304:             blt          sp, a4, 7306f
7305:             sra          s11, s5, a5
7306:             srl          t3, s7, t2
7307:             bgeu         a0, a3, 7317f
7308:             bne          sp, t1, 7320f
7309:             srai         a5, s3, 8
7310:             slli         s3, sp, 1
7311:             nop
7312:             mul          t1, s8, s11
7313:             and          s2, s3, s9
7314:             bltu         s2, s11, 7318f
7315:             div          ra, gp, a3
7316:             bge          a7, a5, 7319f
7317:             xor          s3, s3, t2
7318:             sra          zero, t3, s0
7319:             nop
7320:             bltu         s9, t6, 7328f
7321:             xori         a5, a7, 1419
7322:             or           a4, a1, s10
7323:             slli         t1, s6, 10
7324:             csrrci       gp, 0x343, 0
7325:             sltu         s6, t6, zero
7326:             slt          t2, s6, s2
7327:             mulhsu       t5, a2, t4
7328:             sll          s0, sp, s2
7329:             mul          s8, s4, sp
7330:             rem          t2, t1, s9
7331:             csrrwi       s10, 0x342, 16
7332:             nop
7333:             bltu         a2, sp, 7348f
7334:             slli         a2, zero, 6
7335:             csrrc        a5, 0x343, s7
7336:             sra          gp, s4, t3
7337:             bgeu         t3, sp, 7346f
7338:             slli         s10, t1, 24
7339:             slti         s6, sp, 1569
7340:             andi         t3, s0, 1536
7341:             div          a1, t0, s6
7342:             slti         s11, t6, 1617
7343:             andi         s4, a6, -1143
7344:             csrrwi       a0, 0x301, 23
7345:             bgeu         s11, a0, 7352f
7346:             rem          a2, s7, s7
7347:             remu         s4, ra, a3
7348:             bne          s7, s4, 7351f
7349:             andi         zero, a7, -1445
7350:             beq          a6, a7, 7360f
7351:             mul          s11, t6, t0
7352:             sll          a4, t3, ra
7353:             sltu         t0, a5, s2
7354:             add          gp, tp, a3
7355:             csrrs        t4, 0x344, zero
7356:             lui          s5, 934497
7357:             sll          s2, s11, ra
7358:             rem          a6, a3, a6
7359:             ori          a6, s10, -884
7360:             beq          a4, a7, 7371f
7361:             addi         s5, a4, -1220
7362:             mulhu        s0, t0, s9
7363:             and          t5, t4, a4
7364:             mul          t0, s1, a6
7365:             xori         s6, t6, -1520
7366:             mulhu        gp, s4, gp
7367:             srai         t4, s0, 16
7368:             mulhsu       gp, s7, a3
7369:             addi         t3, s4, 1391
7370:             csrrs        t0, 0x343, zero
7371:             slli         s8, a3, 19
7372:             csrrwi       s4, 0x342, 11
7373:             bgeu         s3, sp, 7381f
7374:             mulhu        a5, a7, s0
7375:             sll          s5, s0, s4
7376:             and          s8, s4, t3
7377:             mulhu        t0, s8, s10
7378:             csrrw        a4, 0x301, s8
7379:             csrrwi       tp, 0x301, 7
7380:             slli         s11, zero, 3
7381:             mul          s4, t0, s10
7382:             andi         s2, t4, -1030
7383:             bge          t6, s1, 7387f
7384:             addi         t3, a3, 833
7385:             div          a7, a4, s4
7386:             rem          a0, s5, a3
7387:             auipc        t1, 962485
7388:             srai         gp, t2, 17
7389:             csrrwi       t2, 0x343, 25
7390:             mulhu        zero, s2, s11
7391:             div          s2, t5, s0
7392:             csrrs        a1, 0x342, a3
7393:             srl          s10, t6, a4
7394:             xori         gp, s3, 969
7395:             lui          zero, 95604
7396:             sltu         s2, s4, a7
7397:             slti         s6, zero, -1111
7398:             beq          a0, s3, 7401f
7399:             sra          a0, s5, t1
7400:             mulhu        a7, ra, zero
7401:             csrrci       s8, 0x301, 0
7402:             xori         s5, zero, -168
7403:             mulhsu       s9, s1, tp
7404:             srl          s1, a6, a0
7405:             add          a6, a7, sp
7406:             csrrc        gp, 0x305, zero
7407:             csrrci       a4, 0x344, 9
7408:             csrrwi       a5, 0x344, 31
7409:             mulhu        a4, s7, a0
7410:             beq          s0, s2, 7416f
7411:             csrrs        t4, 0x342, tp
7412:             sll          s1, t6, s7
7413:             blt          s11, a6, 7418f
7414:             csrrsi       a2, 0x305, 0
7415:             or           t1, s11, s2
7416:             mulhu        gp, s8, a2
7417:             csrrs        a0, 0x305, zero
7418:             and          a4, s2, sp
7419:             sltiu        s11, zero, 388
7420:             blt          a5, t2, 7423f
7421:             sub          s4, t6, t1
7422:             csrrwi       s4, 0x344, 15
7423:             or           a0, s8, s3
7424:             sra          t4, a6, t6
7425:             ori          s9, a0, -201
7426:             lui          a2, 504711
7427:             slli         s10, a3, 1
7428:             ori          zero, t2, -61
7429:             rem          a7, tp, a4
7430:             sra          t3, t1, a6
7431:             sub          a2, a2, ra
7432:             divu         tp, a5, a7
7433:             slli         s1, a0, 29
7434:             mulhsu       s0, a3, tp
7435:             xor          s1, s2, t3
7436:             csrrc        a0, 0x304, a4
7437:             nop
7438:             bgeu         s6, gp, 7451f
7439:             blt          t6, a5, 7453f
7440:             xor          t0, a2, gp
7441:             addi         s0, s6, -685
7442:             beq          a7, a2, 7462f
7443:             sltu         a2, s6, a7
7444:             sub          t5, s2, s7
7445:             rem          ra, s11, a3
7446:             mulh         a4, s2, a4
7447:             csrrci       s3, 0x304, 31
7448:             slt          a7, t0, s6
7449:             rem          t1, tp, a5
7450:             div          a0, a1, t2
7451:             slt          ra, t6, s11
7452:             remu         a1, t3, t4
7453:             sltiu        s2, s5, 1102
7454:             slli         gp, a6, 9
7455:             slt          t0, a0, a4
7456:             srli         a2, s5, 20
7457:             mulhsu       t6, a7, a6
7458:             addi         s4, a2, -148
7459:             slli         s9, s2, 7
7460:             xor          s0, a7, t6
7461:             blt          s3, a0, 7479f
7462:             srai         s1, s11, 10
7463:             beq          s10, t3, 7466f
7464:             nop
7465:             bltu         a0, a7, 7470f
7466:             auipc        s5, 937688
7467:             sltu         ra, s1, s4
7468:             srli         gp, t6, 1
7469:             auipc        s4, 190348
7470:             slli         a1, t3, 15
7471:             divu         a5, s2, s1
7472:             bge          t0, zero, 7473f
7473:             xori         s2, s0, 1584
7474:             sra          s10, s7, t1
7475:             sltu         s2, t5, a6
7476:             srli         s1, a7, 0
7477:             sltiu        t4, gp, -1562
7478:             remu         a0, s10, s9
7479:             or           a6, s10, t4
7480:             bltu         a4, t5, 7494f
7481:             slli         a1, s3, 28
7482:             divu         t3, t2, t0
7483:             srai         s9, s0, 4
7484:             ori          s0, t6, -621
7485:             ori          a6, a0, -637
7486:             csrrs        t2, 0x301, zero
7487:             andi         a1, a5, 1373
7488:             slti         t0, t1, -1841
7489:             csrrsi       t1, 0x300, 0
7490:             csrrw        s11, 0x342, a0
7491:             blt          s1, a1, 7497f
7492:             slli         t3, gp, 30
7493:             divu         s11, s8, t5
7494:             mulhu        a6, tp, gp
7495:             lui          t3, 43637
7496:             sltiu        s10, a1, -189
7497:             divu         gp, s6, s0
7498:             nop
7499:             andi         s5, zero, 1753
7500:             lui          s1, 302877
7501:             remu         s0, zero, t4
7502:             slli         tp, t0, 9
7503:             srli         t0, a0, 10
7504:             sltiu        t6, t2, -1616
7505:             csrrsi       a5, 0x300, 0
7506:             lui          s2, 1008332
7507:             divu         zero, a2, a0
7508:             addi         t1, a0, -1903
7509:             beq          zero, s1, 7511f
7510:             sub          a4, a5, s4
7511:             mulhsu       zero, a4, s1
7512:             blt          t6, s0, 7517f
7513:             addi         s9, gp, -302
7514:             csrrc        a6, 0x304, a1
7515:             xori         s5, a4, 1180
7516:             div          a7, s11, t1
7517:             blt          s3, s1, 7525f
7518:             slli         s6, a5, 18
7519:             srli         s9, a5, 27
7520:             bgeu         a3, a7, 7524f
7521:             csrrw        s6, 0x301, ra
7522:             csrrs        a4, 0x344, a0
7523:             sub          s4, t5, s5
7524:             slli         t5, t2, 19
7525:             csrrsi       a5, 0x344, 19
7526:             bne          zero, s6, 7531f
7527:             sltu         a2, tp, t1
7528:             div          t1, sp, a4
7529:             or           s0, a7, t4
7530:             or           s8, t6, s10
7531:             mul          s8, a0, s4
7532:             csrrci       s5, 0x300, 0
7533:             csrrs        s3, 0x304, zero
7534:             rem          t2, s7, gp
7535:             xor          t6, s4, s7
7536:             csrrsi       t2, 0x301, 0
7537:             sltu         t1, t0, a3
7538:             srai         s3, a5, 19
7539:             xori         s11, s9, 187
7540:             ori          s8, gp, 474
7541:             csrrwi       a0, 0x342, 8
7542:             csrrs        ra, 0x342, zero
7543:             rem          t2, a2, s2
7544:             nop
7545:             bne          tp, s1, 7556f
7546:             div          t5, s4, t5
7547:             addi         s1, s11, -1886
7548:             xor          t2, zero, s10
7549:             srai         s2, a1, 30
7550:             sra          ra, a3, a6
7551:             sra          s11, s7, s9
7552:             csrrw        a6, 0x304, s6
7553:             divu         s4, s9, a0
7554:             auipc        s6, 732589
7555:             csrrwi       a5, 0x343, 25
7556:             csrrs        s2, 0x343, zero
7557:             xor          s11, sp, s9
7558:             bltu         t4, s1, 7567f
7559:             csrrci       t6, 0x304, 19
7560:             slt          zero, a7, t0
7561:             beq          t0, a2, 7576f
7562:             xori         a5, t3, 692
7563:             sub          s4, tp, t0
7564:             andi         t4, zero, 1189
7565:             addi         s9, ra, 1778
7566:             csrrs        s2, 0x301, s11
7567:             sltu         a5, a2, t4
7568:             ori          a5, t1, -142
7569:             sll          s3, s1, a2
7570:             nop
7571:             csrrci       s9, 0x343, 3
7572:             bge          s3, t5, 7575f
7573:             slt          a7, s3, s7
7574:             mulh         s0, t0, gp
7575:             div          t3, s10, t2
7576:             csrrc        s8, 0x304, zero
7577:             csrrc        a2, 0x300, zero
7578:             auipc        a4, 307879
7579:             auipc        t4, 54017
7580:             csrrwi       s5, 0x304, 1
7581:             sra          t0, t3, a1
7582:             ori          a6, ra, -1186
7583:             csrrw        zero, 0x342, tp
7584:             slti         t6, s0, -1969
7585:             and          s2, s0, t0
7586:             sra          s8, s5, s6
7587:             auipc        s3, 174860
7588:             andi         a0, s11, -1624
7589:             auipc        s2, 704246
7590:             slti         gp, s10, 699
7591:             addi         s10, tp, -1165
7592:             div          t5, a0, a2
7593:             remu         a4, a7, tp
7594:             and          gp, t0, s1
7595:             rem          t6, s7, s6
7596:             and          a5, sp, a3
7597:             csrrci       t1, 0x305, 0
7598:             bne          s4, tp, 7608f
7599:             mulh         s8, zero, a1
7600:             nop
7601:             csrrs        a5, 0x342, zero
7602:             or           s5, a7, t6
7603:             sltu         a6, a2, sp
7604:             sll          t6, s2, t0
7605:             mulhsu       a7, a0, a0
7606:             mulh         s11, s0, s8
7607:             addi         a7, t4, -1471
7608:             slti         a4, ra, -1299
7609:             and          a6, s4, a7
7610:             sub          t4, zero, a2
7611:             slli         s9, tp, 19
7612:             slli         a5, a2, 25
7613:             addi         zero, a5, 1185
7614:             slt          s9, s6, a4
7615:             csrrs        s8, 0x344, zero
7616:             xori         a4, s11, -1374
7617:             rem          zero, t3, s2
7618:             auipc        a2, 257842
7619:             sltiu        s11, t5, 268
7620:             add          tp, a2, t3
7621:             add          gp, s5, t5
7622:             addi         a4, s3, -407
7623:             srl          t5, s1, gp
7624:             slt          t6, t1, a1
7625:             slli         t3, t1, 19
7626:             sll          t0, t0, gp
7627:             csrrci       t4, 0x301, 0
7628:             slti         s8, t4, -1830
7629:             nop
7630:             csrrw        a1, 0x301, s9
7631:             slt          t4, s9, a6
7632:             andi         tp, s1, -644
7633:             addi         a1, a3, 124
7634:             ori          t2, s11, -1724
7635:             beq          a5, s2, 7653f
7636:             lui          t4, 602488
7637:             slt          tp, a5, a1
7638:             blt          gp, s5, 7658f
7639:             csrrwi       ra, 0x344, 21
7640:             div          ra, s5, t4
7641:             slli         t0, s9, 20
7642:             divu         s10, a1, tp
7643:             mulhu        t3, a4, a0
7644:             csrrwi       s5, 0x301, 1
7645:             mulh         s5, s10, a0
7646:             mulhsu       gp, tp, s5
7647:             xor          t3, s5, a7
7648:             srai         t2, a6, 17
7649:             csrrwi       s5, 0x304, 13
7650:             csrrs        s5, 0x300, zero
7651:             slli         t3, s4, 27
7652:             sltu         gp, s7, t4
7653:             div          a2, s6, t4
7654:             nop
7655:             and          t6, s5, a5
7656:             slli         s1, a5, 21
7657:             mulhsu       gp, t4, a7
7658:             andi         s11, t2, -377
7659:             sub          a0, sp, s11
7660:             mulhu        t1, s11, s3
7661:             andi         zero, a1, 698
7662:             srl          s2, tp, t0
7663:             remu         tp, a0, s8
7664:             srli         a1, a6, 6
7665:             csrrc        t5, 0x344, zero
7666:             sub          s10, s7, a1
7667:             blt          t5, a3, 7671f
7668:             slti         a1, t4, 533
7669:             mul          a1, t5, a4
7670:             bgeu         a3, a3, 7688f
7671:             beq          s3, sp, 7672f
7672:             srai         a6, s9, 7
7673:             addi         t6, a7, 1649
7674:             bgeu         a5, t5, 7686f
7675:             slli         tp, a3, 19
7676:             divu         gp, sp, s7
7677:             srli         t3, a1, 30
7678:             csrrwi       a0, 0x301, 23
7679:             sra          a5, a1, zero
7680:             mulh         t6, s1, s1
7681:             csrrc        a5, 0x343, zero
7682:             bne          a5, s9, 7695f
7683:             bgeu         tp, s6, 7686f
7684:             sltu         t0, s11, a6
7685:             add          s5, sp, t2
7686:             rem          t1, gp, zero
7687:             csrrw        a4, 0x304, ra
7688:             csrrs        gp, 0x304, zero
7689:             auipc        s9, 152637
7690:             srli         t6, t2, 18
7691:             beq          a4, s4, 7694f
7692:             andi         t5, a7, 1942
7693:             csrrwi       s9, 0x304, 30
7694:             blt          s5, s9, 7697f
7695:             srai         s4, t1, 22
7696:             sltu         t0, a2, s10
7697:             sll          a2, s10, zero
7698:             mulhsu       t1, ra, t0
7699:             sra          zero, a0, s1
7700:             bgeu         s11, t1, 7707f
7701:             csrrwi       s1, 0x342, 20
7702:             lui          s4, 50418
7703:             sra          s11, t4, s2
7704:             sll          zero, t3, a1
7705:             lui          s8, 165884
7706:             mul          s9, a3, s11
7707:             sltiu        t4, a5, 1654
7708:             sub          a4, a6, t0
7709:             bne          s10, s1, 7717f
7710:             addi         a6, s4, 790
7711:             bge          a1, s3, 7714f
7712:             srai         a1, a3, 28
7713:             ori          s6, s10, 346
7714:             csrrc        t4, 0x304, t6
7715:             auipc        t4, 154091
7716:             ori          s5, t5, 1087
7717:             slli         s5, ra, 12
7718:             bgeu         t3, sp, 7722f
7719:             mulh         t2, gp, s6
7720:             xori         t0, a4, -288
7721:             mulhu        s0, a7, t2
7722:             bne          t2, t6, 7723f
7723:             andi         s2, t4, 947
7724:             xor          a6, t1, a3
7725:             csrrs        s10, 0x304, s1
7726:             sub          gp, s3, a1
7727:             slt          a1, ra, s6
7728:             srl          a2, a1, s2
7729:             csrrci       s10, 0x344, 0
7730:             div          t0, a2, ra
7731:             csrrc        s4, 0x300, zero
7732:             xori         t0, t4, 1938
7733:             blt          t1, a0, 7743f
7734:             csrrs        s2, 0x304, tp
7735:             bne          t2, t2, 7746f
7736:             srai         a6, t4, 1
7737:             slli         a1, ra, 24
7738:             slti         t1, gp, 471
7739:             div          a6, tp, s7
7740:             addi         s2, t2, 865
7741:             slti         s10, s7, 1591
7742:             csrrsi       a6, 0x304, 16
7743:             and          t5, gp, s0
7744:             csrrc        t6, 0x305, zero
7745:             slt          a6, t0, a6
7746:             srli         a6, s4, 11
7747:             csrrs        t1, 0x300, zero
7748:             srl          t3, t2, t1
7749:             xor          t3, a0, s1
7750:             srai         gp, a7, 23
7751:             beq          a3, gp, 7762f
7752:             csrrc        zero, 0x344, s4
7753:             nop
7754:             ori          ra, tp, -978
7755:             remu         s8, zero, s5
7756:             beq          s1, gp, 7757f
7757:             slli         s10, s2, 11
7758:             srai         s9, a6, 8
7759:             addi         t6, t1, -47
7760:             auipc        s1, 413883
7761:             slti         gp, t4, -1696
7762:             csrrs        t2, 0x305, zero
7763:             sub          s2, a3, a4
7764:             blt          s8, a1, 7767f
7765:             div          a5, zero, s8
7766:             csrrw        s10, 0x304, s7
7767:             lui          t3, 200339
7768:             sltu         a7, s3, a3
7769:             addi         a6, s9, 71
7770:             or           t6, s0, s1
7771:             andi         t6, a2, -1997
7772:             lui          s8, 921921
7773:             slt          s0, t6, a2
7774:             slt          s8, s10, tp
7775:             xori         a0, ra, 1788
7776:             bltu         a0, t5, 7786f
7777:             sltiu        a0, s6, -692
7778:             bgeu         t4, t5, 7781f
7779:             mulhsu       a6, t5, sp
7780:             mulhu        s2, a7, s4
7781:             slt          t2, s7, t3
7782:             csrrci       s0, 0x344, 0
7783:             bgeu         a7, s3, 7787f
7784:             bltu         t6, a6, 7796f
7785:             mulhu        a2, s8, s6
7786:             csrrs        a1, 0x305, zero
7787:             srl          s9, a7, t3
7788:             addi         a4, s3, -101
7789:             csrrci       t6, 0x342, 22
7790:             mulhsu       t3, zero, s5
7791:             divu         a5, s0, t3
7792:             or           s3, s2, a6
7793:             ori          s4, t4, 2019
7794:             mulhsu       a6, ra, a4
7795:             mulhu        s1, zero, s6
7796:             divu         t2, a2, tp
7797:             slt          a1, a4, a1
7798:             csrrw        s2, 0x301, s11
7799:             xori         a2, a6, 1330
7800:             mulhu        a1, a1, t3
7801:             remu         s6, s4, zero
7802:             beq          zero, s0, 7820f
7803:             xor          t6, t3, a6
7804:             xor          s0, a4, a3
7805:             divu         gp, s0, ra
7806:             csrrw        gp, 0x301, tp
7807:             slli         t4, s10, 4
7808:             sra          s6, s0, s4
7809:             mul          s3, s11, s0
7810:             addi         a1, s0, -575
7811:             bltu         a4, t2, 7822f
7812:             sll          t1, t5, s5
7813:             remu         s11, t3, s6
7814:             or           a6, gp, s3
7815:             blt          t4, a2, 7817f
7816:             mulhsu       s11, s2, a5
7817:             andi         a6, a3, -501
7818:             srl          s3, a6, t6
7819:             nop
7820:             slli         a0, t2, 16
7821:             sltiu        t6, s4, 66
7822:             csrrs        s4, 0x300, zero
7823:             slt          s11, tp, s0
7824:             lui          t3, 238703
7825:             sub          a2, a3, tp
7826:             srl          a4, s11, a5
7827:             sra          t0, a6, a7
7828:             and          s6, s9, zero
7829:             auipc        a0, 674736
7830:             sltiu        t3, s11, -1994
7831:             andi         zero, s0, 736
7832:             slt          t0, a6, a0
7833:             srai         ra, a7, 12
7834:             slt          a2, a1, s7
7835:             nop
7836:             bgeu         ra, s3, 7845f
7837:             blt          sp, a7, 7855f
7838:             csrrs        s9, 0x300, zero
7839:             csrrc        ra, 0x305, zero
7840:             auipc        a6, 754612
7841:             csrrc        a5, 0x300, zero
7842:             slt          a1, gp, a5
7843:             bge          s8, s6, 7846f
7844:             blt          s3, a4, 7864f
7845:             sub          zero, a4, a7
7846:             mulhsu       gp, s4, t6
7847:             srli         tp, s8, 15
7848:             csrrci       s9, 0x305, 0
7849:             slt          s8, s11, t6
7850:             xor          t6, a0, a1
7851:             sltu         gp, a2, a6
7852:             bge          ra, s3, 7855f
7853:             sltu         s3, s7, t4
7854:             sub          t2, t2, s3
7855:             or           a2, sp, s2
7856:             slli         t1, t1, 22
7857:             divu         t0, t6, s3
7858:             bge          t4, a7, 7866f
7859:             auipc        a5, 782696
7860:             bgeu         zero, a0, 7864f
7861:             sll          a7, s5, s8
7862:             csrrs        a2, 0x344, s4
7863:             srl          a0, s5, a5
7864:             sra          a7, s1, s8
7865:             csrrs        s5, 0x304, zero
7866:             mul          a7, s9, t2
7867:             slt          s5, s9, t5
7868:             srli         zero, s9, 2
7869:             bgeu         a4, a0, 7874f
7870:             csrrs        s1, 0x343, zero
7871:             add          zero, a4, t0
7872:             srai         gp, a2, 19
7873:             slti         s9, a4, 107
7874:             csrrs        a6, 0x301, zero
7875:             mulhsu       tp, zero, sp
7876:             srai         t2, s2, 10
7877:             csrrc        s2, 0x304, s5
7878:             csrrsi       a4, 0x300, 0
7879:             csrrs        zero, 0x342, a3
7880:             remu         s1, t6, t4
7881:             sll          s6, a4, s4
7882:             and          s1, t3, s1
7883:             xor          s5, a4, a6
7884:             sltiu        zero, t2, -1509
7885:             slli         s11, sp, 9
7886:             mulhu        s4, a4, t1
7887:             andi         t2, sp, 445
7888:             csrrw        a4, 0x343, s1
7889:             csrrci       a1, 0x304, 18
7890:             slt          t1, t2, t6
7891:             divu         s3, s3, t1
7892:             sub          t4, s5, gp
7893:             mulh         s11, ra, a5
7894:             add          gp, s7, a2
7895:             or           zero, s5, a2
7896:             bne          s8, a2, 7901f
7897:             sltu         s2, s0, s6
7898:             csrrw        t1, 0x301, s1
7899:             csrrc        s11, 0x343, t0
7900:             and          t6, a2, t1
7901:             or           s9, s7, a1
7902:             bgeu         a5, a2, 7908f
7903:             csrrc        ra, 0x342, zero
7904:             slt          ra, sp, sp
7905:             bltu         s7, t5, 7908f
7906:             andi         tp, s8, -586
7907:             slli         tp, s10, 17
7908:             ori          s10, s9, 1137
7909:             slli         a0, s9, 26
7910:             ori          a1, t3, 1457
7911:             csrrwi       s1, 0x344, 31
7912:             mulh         s6, a6, s3
7913:             blt          t4, t6, 7914f
7914:             nop
7915:             or           t6, t0, a3
7916:             xor          t2, t1, gp
7917:             add          t2, s2, tp
7918:             sll          t5, a7, sp
7919:             xor          t1, s8, t2
7920:             bgeu         s2, t0, 7931f
7921:             divu         t6, a4, s9
7922:             nop
7923:             bge          a2, s1, 7936f
7924:             div          s11, a4, s6
7925:             sll          zero, s4, a6
7926:             csrrwi       gp, 0x304, 7
7927:             beq          zero, zero, 7941f
7928:             csrrci       s5, 0x300, 0
7929:             srl          t2, t0, s0
7930:             bltu         t2, a7, 7941f
7931:             divu         t3, a2, s1
7932:             beq          t1, zero, 7939f
7933:             mulhu        a4, s10, a3
7934:             srai         s0, s1, 26
7935:             sra          a0, s11, t3
7936:             mulh         s6, a5, s8
7937:             csrrwi       t3, 0x304, 10
7938:             sll          t6, s8, ra
7939:             srai         a2, t6, 10
7940:             srli         a1, s1, 14
7941:             slli         s2, t1, 26
7942:             slli         s4, s9, 11
7943:             slti         t0, gp, -924
7944:             blt          s11, s7, 7959f
7945:             sra          a0, s2, a7
7946:             slli         a5, s6, 13
7947:             andi         a2, s6, 1287
7948:             add          ra, s9, s11
7949:             slli         tp, s5, 30
7950:             srai         a5, t6, 13
7951:             xori         s5, zero, 1373
7952:             mulh         a4, t2, a4
7953:             xori         s3, a2, 521
7954:             mulhu        s3, sp, s1
7955:             blt          t0, a3, 7963f
7956:             bne          ra, tp, 7960f
7957:             sltiu        tp, a0, 1359
7958:             ori          t5, tp, 1849
7959:             mul          a5, t1, sp
7960:             slli         a7, ra, 2
7961:             bgeu         a7, a5, 7971f
7962:             mul          ra, s1, s0
7963:             div          a6, t3, s9
7964:             and          a2, tp, a2
7965:             csrrci       a0, 0x305, 0
7966:             addi         s3, t4, -1068
7967:             rem          s2, a6, s11
7968:             div          s10, a7, s6
7969:             slt          t4, s7, s6
                  addi         s6, zero, -7 #init loop 1 counter
                  csrrs        a2, 0x300, zero
                  addi         s8, zero, -13 #init loop 1 limit
                  srl          t3, s3, a2
main_226_1_t:     remu         t4, s6, tp
                  mulh         s3, s7, a7
                  addi         s6, s6, -8 #update loop 1 counter
                  addi         s11, zero, 1 #init loop 0 counter
                  addi         ra, zero, -19 #init loop 0 limit
                  xori         s0, gp, -1031
                  mulhsu       t2, s7, t0
                  sll          a1, t6, s4
main_226_0_t:     nop
                  sll          t1, t4, s5
                  addi         s11, s11, -5 #update loop 0 counter
                  bne          s11, ra, main_226_0_t #branch for loop 0
                  addi         tp, s11, -701
                  srai         s10, s6, 26
                  bge          s6, s8, main_226_1_t #branch for loop 1
                  rem          s10, s5, s1
7970:             srli         a7, t4, 25
7971:             andi         a1, s6, 370
7972:             lui          t0, 965264
7973:             slli         s3, a4, 8
7974:             rem          t2, a2, a1
7975:             divu         a4, s7, t5
7976:             srai         s10, s3, 27
7977:             bgeu         a6, s10, 7983f
7978:             bne          ra, tp, 7992f
7979:             add          gp, a3, s4
7980:             slti         a7, s7, -1020
7981:             csrrs        a2, 0x344, s5
7982:             ori          a0, t2, -302
7983:             slli         s10, t4, 19
7984:             csrrc        zero, 0x304, zero
7985:             addi         a2, t5, 666
7986:             xor          a4, t4, a2
7987:             xori         s3, s8, -1381
7988:             ori          s11, a7, -1559
7989:             blt          t0, tp, 7993f
7990:             ori          t2, t4, -4
7991:             srl          t6, a5, s3
7992:             and          s9, a7, s2
7993:             slti         a6, a0, 447
7994:             mulhu        t6, s9, gp
                  la           t6, region_1+46392 #start riscv_hazard_instr_stream_2
                  csrrwi       a2, 0x301, 22
                  mul          a6, a4, a0
                  nop
                  sb           t4, 402(t6)
                  lbu          s3, 1433(t6)
                  sltiu        a0, s3, 602
                  sb           a6, 911(t6)
                  add          s3, t4, s3
                  srai         t4, t4, 15
                  sltiu        a4, s3, -1349
                  csrrci       a4, 0x343, 0
                  lui          a4, 569744
                  sltu         a0, a6, a6
                  sb           a6, 1079(t6)
                  lbu          s3, -1665(t6)
                  remu         s3, s3, s3
                  csrrs        a6, 0x304, a6
                  lbu          a2, -2021(t6)
                  sb           t4, -1533(t6)
                  lbu          a0, 1581(t6)
                  ori          a2, s3, 617
                  sub          a2, a2, a4
                  add          a4, a4, a2
                  lbu          a2, 1059(t6)
                  sb           t4, -994(t6)
                  sltiu        a0, a4, -243
                  nop
                  and          a6, t4, a0
                  sb           s3, 407(t6) #end riscv_hazard_instr_stream_2
7995:             beq          zero, s5, 7996f
7996:             csrrsi       a7, 0x300, 0
7997:             srl          t3, tp, a4
7998:             divu         a2, s10, a4
7999:             or           t4, a6, s3
8000:             add          a5, s1, zero
8001:             srl          a5, zero, s1
8002:             csrrsi       s0, 0x300, 0
8003:             slli         s2, s7, 8
8004:             bne          s5, s1, 8007f
8005:             rem          s9, t0, a3
8006:             rem          t6, t6, s6
8007:             divu         a0, t2, a3
8008:             bgeu         s3, s0, 8016f
8009:             div          s0, ra, t4
8010:             lui          zero, 932376
8011:             mulh         s10, a4, a0
8012:             sra          s4, a2, a2
8013:             ori          tp, a1, 1117
8014:             blt          tp, a4, 8017f
8015:             sra          t2, a5, t2
8016:             divu         a1, t0, s7
8017:             bltu         s4, s7, 8019f
8018:             slt          zero, s10, s8
8019:             sub          t3, s11, t3
8020:             mul          ra, gp, t4
8021:             addi         a6, s1, 1037
8022:             sltu         s2, a5, s8
8023:             remu         a1, gp, ra
8024:             sra          a6, t5, s3
8025:             bltu         s5, s4, 8038f
8026:             srl          t1, s1, s10
8027:             mulh         a5, t0, t3
8028:             xori         s2, a3, 1126
8029:             csrrwi       t6, 0x342, 7
8030:             srli         t4, t6, 4
8031:             xori         a6, s11, 760
8032:             bge          s2, s5, 8052f
8033:             sra          t0, s10, t6
8034:             nop
8035:             srli         t3, s6, 24
8036:             mulhsu       a4, s3, s11
8037:             div          tp, a7, t6
8038:             mulhsu       t0, s3, a6
8039:             sll          t3, a7, tp
8040:             add          s1, s6, ra
8041:             sub          a2, s10, a6
8042:             xori         gp, s10, -949
8043:             bge          a6, a2, 8061f
8044:             bne          a5, t0, 8053f
8045:             bgeu         t3, t4, 8048f
8046:             auipc        a5, 42319
8047:             sltu         s5, s10, t1
8048:             auipc        s6, 186212
8049:             mul          s4, a5, s7
8050:             srai         gp, s7, 25
8051:             srai         s9, t5, 8
8052:             remu         s10, a6, zero
8053:             div          s6, gp, t0
8054:             bge          t2, a0, 8065f
8055:             sltu         s10, s4, t4
8056:             bne          s1, s10, 8059f
8057:             csrrci       s9, 0x300, 0
8058:             mulh         gp, a3, ra
8059:             mulhu        tp, a6, a7
8060:             srli         t2, s2, 26
8061:             div          t5, s3, s4
8062:             bltu         a0, s3, 8063f
8063:             and          s5, t4, s10
8064:             beq          a6, t4, 8075f
8065:             slt          a7, s7, s2
8066:             csrrs        a0, 0x344, zero
8067:             sltiu        t4, gp, 97
8068:             divu         a1, ra, s0
8069:             addi         s2, a0, 1787
8070:             bge          t0, tp, 8075f
8071:             slti         a5, s5, -1796
8072:             andi         s10, a4, 2032
8073:             csrrwi       s8, 0x304, 19
8074:             or           a2, sp, sp
8075:             andi         zero, t6, -74
8076:             div          s5, t6, a1
8077:             bne          t1, a3, 8081f
8078:             srai         ra, t1, 30
8079:             csrrsi       s0, 0x343, 17
8080:             mul          tp, gp, gp
8081:             andi         t4, s10, -339
8082:             csrrs        s10, 0x343, zero
8083:             slt          t2, a3, a7
8084:             and          t2, s3, a1
8085:             sub          a0, a0, gp
8086:             sltu         a5, t2, t2
8087:             remu         t2, s3, ra
8088:             and          gp, s1, s3
8089:             xori         zero, a5, -458
8090:             auipc        s4, 474379
8091:             csrrwi       s10, 0x343, 29
8092:             mulhu        a0, t6, s5
8093:             srl          s9, a7, s10
8094:             sub          tp, t3, a7
8095:             slti         t6, a7, 1253
8096:             remu         s10, t2, s7
8097:             bge          t2, t3, 8105f
8098:             bgeu         t3, t4, 8108f
8099:             bge          t5, t6, 8111f
8100:             xor          s9, a5, sp
8101:             bge          s10, a2, 8119f
8102:             sltiu        a2, ra, -166
8103:             csrrw        s0, 0x304, a7
8104:             addi         a0, s8, 1862
8105:             bgeu         s1, t4, 8108f
8106:             mul          s0, a0, gp
8107:             ori          a6, s2, -1759
8108:             xor          t5, s1, s6
8109:             and          s5, s4, ra
8110:             csrrc        a0, 0x305, zero
8111:             bge          t1, t1, 8116f
8112:             ori          t1, s3, 1954
8113:             csrrs        zero, 0x343, s2
8114:             addi         a0, s0, -1929
8115:             xori         s11, t1, -1515
8116:             csrrs        s10, 0x301, a0
8117:             csrrsi       t6, 0x343, 0
8118:             slt          a5, ra, a0
8119:             xori         s8, s8, 306
8120:             addi         s11, ra, -619
8121:             srai         s2, sp, 4
8122:             ori          s9, t4, -1476
8123:             bge          t1, s5, 8130f
8124:             csrrs        s2, 0x305, zero
8125:             sltiu        a7, a3, 751
8126:             nop
8127:             bne          a5, a2, 8138f
8128:             srl          t1, a6, s9
8129:             xori         t0, t5, -706
8130:             div          a4, s9, t3
8131:             srai         s3, s11, 10
8132:             lui          s2, 122444
8133:             xor          a4, gp, s6
8134:             slli         a4, a6, 18
8135:             sltiu        s10, s5, 1028
8136:             bne          t2, t5, 8151f
8137:             bltu         a0, t5, 8141f
8138:             csrrw        t2, 0x344, gp
8139:             slti         t5, s10, 1929
8140:             remu         a1, s11, s9
8141:             csrrc        s4, 0x304, ra
8142:             srli         a0, s2, 30
8143:             addi         s0, t0, -1387
8144:             sub          tp, s8, a6
8145:             sltu         t0, s9, s6
8146:             csrrw        ra, 0x344, t0
8147:             sltiu        a0, tp, -2
8148:             divu         t2, t6, ra
8149:             or           t4, tp, zero
8150:             sub          t6, s9, s4
8151:             mul          s5, s11, s5
8152:             bgeu         t3, t3, 8162f
8153:             add          s4, s8, t5
8154:             bltu         t0, s2, 8164f
8155:             sra          a6, s11, t4
8156:             auipc        a1, 678658
8157:             mulhsu       s9, t3, a7
8158:             beq          s7, s2, 8162f
8159:             csrrc        s4, 0x304, zero
8160:             divu         s5, t2, gp
8161:             csrrw        ra, 0x343, s11
8162:             andi         s1, s6, 1877
8163:             mul          s10, s4, t4
8164:             nop
8165:             ori          s8, s11, 1896
8166:             and          s3, s3, a4
8167:             mulhsu       gp, ra, s1
8168:             rem          s9, a3, a1
8169:             add          a2, a0, a7
8170:             srl          t2, s2, s4
8171:             csrrwi       s0, 0x343, 9
8172:             mul          a6, a1, a5
8173:             xor          a4, s9, a0
8174:             csrrc        a1, 0x342, zero
8175:             slli         tp, sp, 3
8176:             sra          a0, tp, tp
8177:             mulhu        t6, s11, t0
8178:             rem          a4, a1, s11
8179:             slt          a7, t1, sp
8180:             sltu         a2, sp, a7
8181:             xori         s9, t3, 1083
8182:             csrrs        t1, 0x342, zero
8183:             lui          t6, 14088
8184:             csrrci       t4, 0x343, 0
8185:             mulh         gp, t4, s9
8186:             bge          tp, zero, 8189f
8187:             lui          t0, 501832
8188:             srl          t2, s8, sp
8189:             rem          t0, s3, tp
8190:             sll          t4, a3, t1
8191:             mulhsu       s5, t2, s11
8192:             rem          a6, a4, ra
8193:             or           s3, a5, gp
8194:             bgeu         t0, t4, 8214f
8195:             mulhsu       t4, t5, t4
8196:             slti         zero, s0, -888
8197:             csrrs        tp, 0x301, zero
8198:             csrrw        s3, 0x343, a0
8199:             slli         s5, a4, 19
8200:             csrrw        a1, 0x344, a3
8201:             srl          a0, t6, a0
8202:             andi         a2, a5, 408
8203:             csrrci       s10, 0x342, 0
8204:             sll          t4, s0, t4
8205:             slli         s4, s7, 20
8206:             lui          s1, 320889
8207:             divu         t2, s5, s8
8208:             bge          s2, a0, 8209f
8209:             sra          s4, s8, t1
8210:             div          a5, a1, t5
8211:             add          t3, a2, t3
8212:             divu         t0, a3, t2
8213:             remu         a2, a7, tp
8214:             lui          s11, 365282
8215:             mulh         a4, s6, a5
8216:             bgeu         a3, a0, 8219f
8217:             csrrs        a5, 0x305, zero
8218:             slt          s10, a1, s4
8219:             csrrsi       t0, 0x344, 0
8220:             xor          s6, sp, sp
8221:             slti         s10, t0, 1854
8222:             lui          s0, 612080
8223:             and          s4, s2, s7
8224:             csrrwi       ra, 0x304, 29
8225:             bgeu         tp, a0, 8236f
8226:             andi         s3, sp, 179
8227:             nop
8228:             mulhsu       s3, sp, sp
8229:             bltu         t4, s1, 8233f
8230:             lui          s1, 24351
8231:             nop
8232:             csrrwi       s10, 0x344, 18
8233:             sra          s3, s4, a3
8234:             divu         a1, s11, t6
8235:             sltiu        a2, s7, 332
8236:             slt          s8, zero, s11
8237:             ori          s1, t0, -348
8238:             csrrs        s9, 0x305, zero
8239:             sltu         a7, s2, a0
8240:             slli         a1, s8, 1
8241:             blt          s8, a1, 8244f
8242:             bltu         t2, t5, 8253f
8243:             andi         s9, sp, -109
8244:             remu         gp, s3, s3
8245:             mulhu        t3, t0, zero
8246:             or           s8, t5, sp
8247:             rem          s9, s2, t3
8248:             csrrw        t3, 0x343, s3
8249:             remu         s8, sp, s4
8250:             auipc        s8, 234759
8251:             ori          t5, tp, 762
8252:             and          a4, a0, a2
8253:             csrrc        t0, 0x301, zero
8254:             addi         s3, ra, -1740
8255:             csrrci       a6, 0x300, 0
8256:             csrrsi       t4, 0x301, 0
8257:             csrrw        s3, 0x342, s11
8258:             bne          s8, s7, 8271f
8259:             or           zero, s0, s0
8260:             beq          t1, s9, 8275f
8261:             mulhu        t4, s3, t0
8262:             and          s0, s7, t0
8263:             csrrs        s2, 0x342, t1
8264:             csrrc        a5, 0x343, t2
8265:             add          tp, ra, t6
8266:             xor          a1, s11, t0
8267:             csrrw        a4, 0x342, s8
8268:             bge          gp, s2, 8269f
8269:             nop
8270:             and          gp, t2, a3
8271:             csrrsi       s11, 0x304, 23
8272:             divu         a0, a1, s3
8273:             mulhsu       s8, a0, gp
8274:             xori         t0, a0, -294
8275:             xori         tp, a3, 436
8276:             sltu         s11, t4, zero
8277:             srl          a1, t1, t2
8278:             srli         a4, a1, 1
8279:             csrrw        gp, 0x301, t6
8280:             sll          s2, a2, t5
8281:             ori          s11, a3, -1054
8282:             blt          a3, t6, 8291f
8283:             xori         a0, t2, 1136
8284:             mulhu        s2, a5, t3
8285:             or           gp, t1, a7
8286:             div          s11, s7, gp
8287:             csrrc        s10, 0x300, zero
8288:             or           tp, s1, t3
8289:             slti         t6, s3, -896
8290:             slli         t4, t4, 3
                  addi         s4, zero, 6 #init loop 0 counter
                  remu         t0, tp, t0
                  div          s11, t2, s0
                  addi         a4, zero, 13 #init loop 0 limit
                  addi         s9, s7, 734
                  sra          s10, a0, t2
                  sltiu        s11, t0, 1340
                  andi         a5, s5, -303
main_210_0_t:     divu         a6, ra, a6
                  addi         s4, s4, 7 #update loop 0 counter
                  sub          ra, a7, s8
                  csrrw        s5, 0x301, a0
                  csrrw        s0, 0x301, s8
                  beq          s4, a4, main_210_0_t #branch for loop 0
                  sub          s10, a5, t2
8291:             sll          s4, s10, a2
8292:             bltu         a0, a2, 8299f
8293:             csrrci       t5, 0x301, 18
8294:             mulhsu       s10, a6, sp
8295:             blt          s1, a3, 8298f
8296:             csrrwi       t4, 0x301, 28
8297:             srai         a1, s1, 17
8298:             xori         t5, a1, -1370
8299:             bne          ra, s3, 8304f
8300:             auipc        s10, 615164
8301:             bgeu         a0, a7, 8305f
8302:             div          gp, a2, s4
8303:             or           t2, a1, a7
8304:             div          t1, s9, a4
8305:             add          t3, s2, t3
8306:             ori          t5, sp, 1703
8307:             beq          t2, a0, 8318f
8308:             srli         s2, s2, 21
8309:             lui          s2, 882491
8310:             csrrci       a0, 0x305, 0
8311:             csrrci       s4, 0x300, 0
8312:             remu         ra, s7, s4
8313:             xori         s4, zero, -1971
8314:             andi         a5, tp, -1133
8315:             slti         a5, s3, -1356
8316:             ori          s8, tp, 1463
8317:             mulh         t2, a0, t2
8318:             csrrwi       a2, 0x344, 29
8319:             nop
8320:             sll          a1, s8, a4
8321:             csrrci       s2, 0x305, 0
8322:             or           s0, s1, t1
8323:             divu         s10, s7, ra
8324:             sll          t1, s8, a5
8325:             csrrs        s9, 0x344, s5
8326:             sll          t3, sp, a0
                  la           t3, region_1+13744 #start riscv_hazard_instr_stream_3
                  lb           ra, -27(t3)
                  lbu          a1, -47(t3)
                  remu         ra, a1, a1
                  sb           s3, 3(t3)
                  lbu          t0, 48(t3)
                  sb           s4, 4(t3)
                  lbu          a1, -25(t3)
                  csrrci       tp, 0x344, 0
                  lhu          s3, 62(t3)
                  mulhu        a1, a1, ra
                  rem          tp, s4, t0
                  sb           ra, -55(t3)
                  andi         t0, ra, -399
                  slli         ra, tp, 25
                  csrrci       t0, 0x344, 23
                  lb           ra, -62(t3)
                  sb           s3, -21(t3)
                  sw           s4, -8(t3)
                  add          tp, tp, ra
                  lb           tp, 64(t3)
                  sb           a1, -9(t3)
                  lbu          s3, 43(t3)
                  lb           t0, 59(t3)
                  lb           a1, -42(t3)
                  csrrci       tp, 0x300, 0
                  lbu          s3, -36(t3)
                  lw           t0, -28(t3)
                  slt          a1, s3, ra
                  slti         t0, s4, -735
                  sra          s4, a1, s3
                  csrrwi       tp, 0x301, 19
                  lh           tp, -24(t3)
                  sb           s3, 47(t3)
                  lbu          t0, -10(t3)
                  lhu          ra, 30(t3)
                  remu         tp, tp, s4
                  divu         t0, ra, ra
                  lw           tp, 64(t3)
                  lbu          a1, 5(t3) #end riscv_hazard_instr_stream_3
8327:             mulh         a6, s3, a4
8328:             mulhu        t6, s6, ra
8329:             or           t3, sp, t6
8330:             csrrsi       s4, 0x301, 0
8331:             bltu         s11, s11, 8349f
8332:             sll          a2, t1, t4
8333:             div          t1, s7, a1
8334:             sltu         s10, a4, t5
8335:             sub          s1, t0, gp
8336:             csrrc        a4, 0x343, zero
8337:             addi         s0, a6, -1323
8338:             xor          s5, s4, s0
8339:             xor          tp, s8, tp
8340:             bgeu         t6, ra, 8348f
8341:             srl          a0, a3, s3
8342:             srli         a4, s11, 4
8343:             bge          s0, zero, 8346f
8344:             blt          a7, t4, 8358f
8345:             csrrw        t6, 0x344, sp
8346:             slli         s5, t0, 7
8347:             andi         s6, t6, -1162
8348:             mulhu        s6, t4, t2
8349:             sltu         tp, sp, t5
8350:             sll          s9, tp, a0
8351:             or           t4, t5, s5
8352:             sll          s11, s3, s1
8353:             blt          a5, ra, 8371f
8354:             div          zero, a3, s2
8355:             divu         s10, t4, s7
8356:             sltiu        s4, a0, -1346
8357:             sltu         s5, s10, s9
8358:             or           s6, t4, s1
8359:             mulh         ra, a2, ra
8360:             bltu         s7, t5, 8366f
8361:             ori          t0, t3, -1066
8362:             bltu         s7, tp, 8372f
8363:             addi         s9, s11, 473
8364:             mulhu        s9, t0, a0
8365:             csrrs        s9, 0x305, zero
8366:             csrrc        a6, 0x344, a0
8367:             slt          gp, s4, s11
8368:             srli         s9, t6, 28
8369:             div          t0, gp, a1
8370:             sltiu        a4, s9, 1477
8371:             mulhsu       t4, sp, s8
8372:             xori         t2, sp, -930
8373:             slt          t0, a1, s7
8374:             ori          s8, a0, -1087
8375:             remu         t0, ra, sp
8376:             sub          s11, s2, a4
8377:             csrrw        t0, 0x343, t3
8378:             csrrsi       t4, 0x344, 0
8379:             mul          s9, t6, sp
8380:             mulhu        a7, s3, s7
8381:             slti         s9, t5, 1306
8382:             ori          a1, t0, 808
8383:             csrrwi       s4, 0x301, 26
8384:             bge          s8, s4, 8389f
8385:             or           a0, t4, s2
8386:             csrrci       a6, 0x305, 0
8387:             remu         s10, s10, t0
8388:             div          a2, s9, s9
8389:             and          t0, s8, s10
8390:             mulhsu       s5, ra, a3
8391:             or           s9, t5, s8
8392:             blt          a7, t5, 8400f
8393:             or           a4, t5, s4
8394:             lui          s8, 511424
8395:             sltiu        t6, gp, 524
8396:             or           t5, t3, s8
8397:             divu         t3, t5, s6
8398:             mul          s4, s9, a4
8399:             csrrs        s2, 0x342, s1
8400:             mulhu        s4, a3, a2
8401:             divu         s6, a5, s0
8402:             remu         s3, t0, s11
8403:             csrrs        s3, 0x305, zero
8404:             bltu         s5, t4, 8416f
8405:             auipc        s11, 78301
8406:             xori         s5, s11, 327
8407:             beq          a5, zero, 8409f
8408:             divu         t4, t1, a5
8409:             csrrci       s11, 0x343, 4
8410:             lui          s2, 81745
8411:             add          a6, gp, tp
8412:             csrrw        t1, 0x344, s1
8413:             bne          t0, s8, 8414f
8414:             divu         a2, a3, sp
8415:             csrrsi       a6, 0x301, 3
8416:             sltiu        gp, sp, -1683
8417:             or           s4, a1, t3
8418:             bge          a2, s11, 8436f
8419:             slli         tp, s10, 2
8420:             bltu         s1, a5, 8435f
8421:             auipc        s10, 470198
8422:             srl          t6, a7, s6
8423:             slli         tp, s8, 29
8424:             sub          tp, zero, s8
8425:             bltu         t1, s6, 8428f
8426:             and          a2, s3, s11
8427:             sltu         s6, a6, a0
8428:             bltu         a1, s3, 8432f
8429:             csrrsi       a4, 0x304, 13
8430:             divu         t4, s10, s0
8431:             bne          s5, s3, 8435f
8432:             or           a5, s1, a6
8433:             xor          t6, t6, s8
8434:             srai         gp, t2, 26
8435:             add          a5, a2, t5
8436:             bge          s9, a3, 8439f
8437:             mul          ra, t4, a4
8438:             auipc        t5, 871581
8439:             andi         s4, s7, 4
8440:             slt          t1, a5, t0
8441:             addi         s5, a7, -210
8442:             sub          t2, s2, s6
8443:             andi         s8, t6, -1699
8444:             csrrs        gp, 0x304, zero
8445:             bgeu         zero, s8, 8465f
8446:             xor          t6, zero, t6
8447:             csrrs        ra, 0x300, zero
8448:             csrrwi       zero, 0x304, 2
8449:             sltiu        s2, sp, 660
8450:             xori         a6, t5, -2004
8451:             auipc        t4, 655366
8452:             csrrwi       a7, 0x304, 2
8453:             or           t2, ra, tp
8454:             srai         s0, t4, 12
8455:             mulhu        tp, t0, a7
8456:             lui          zero, 908228
8457:             sltiu        t3, t2, -107
8458:             mulh         s0, s1, t5
8459:             mulhsu       s8, a6, s5
8460:             sltu         t2, s1, a6
8461:             xori         s0, s4, -872
8462:             bgeu         a0, a1, 8466f
8463:             slt          s2, a1, t4
8464:             add          a4, s8, t1
8465:             slt          tp, s7, t2
8466:             mul          a0, a4, a3
8467:             sra          zero, a0, t1
8468:             sub          a5, t4, a5
8469:             bgeu         ra, s0, 8482f
8470:             beq          s5, s5, 8475f
8471:             sub          a2, a7, a5
8472:             mulhsu       ra, s8, t2
8473:             sub          gp, tp, s4
8474:             csrrci       ra, 0x300, 0
8475:             xori         t1, t5, -1552
8476:             sltu         t4, t2, t3
8477:             mul          a6, s1, t6
8478:             addi         t5, a7, 231
8479:             sltu         t2, t5, a4
8480:             srl          s0, a7, s1
8481:             mul          ra, a7, gp
8482:             csrrci       a4, 0x344, 21
8483:             sub          s6, s0, t4
8484:             csrrwi       s10, 0x343, 29
8485:             or           gp, t4, s1
8486:             div          t4, ra, s6
8487:             andi         t2, a1, 258
8488:             sub          t1, a7, t5
8489:             beq          a7, a0, 8500f
8490:             and          gp, t3, s5
8491:             sra          ra, s5, s7
8492:             add          s8, a5, s2
8493:             mulh         s3, s8, t6
8494:             csrrsi       a6, 0x301, 7
8495:             slt          t3, s0, sp
8496:             bgeu         tp, t5, 8498f
8497:             sra          s3, a3, s9
8498:             ori          ra, s6, 1442
8499:             sll          s0, s5, a5
8500:             csrrsi       s3, 0x304, 0
8501:             sltu         s4, s11, a3
8502:             slti         s9, t6, -1453
8503:             mulh         a1, a4, s4
8504:             slti         s10, s7, 1726
8505:             add          zero, a7, a1
8506:             csrrwi       t5, 0x344, 12
8507:             ori          s3, s4, -743
8508:             div          s5, a4, s5
8509:             slti         s5, s6, -1921
8510:             slli         tp, sp, 17
8511:             blt          s8, zero, 8519f
8512:             csrrci       t3, 0x342, 0
8513:             and          s9, s0, s5
                  la           a4, region_1+26262 #start load_store_instr_stream_0
                  la           a0, region_1+5805 #start load_store_instr_stream_1
                  lbu          a7, -13(a4)
                  sh           a7, -639(a0)
                  lb           t6, 33(a4)
                  la           a6, region_1+20565 #start load_store_instr_stream_2
                  sb           t6, -53(a6)
                  lw           t2, -22(a4)
                  lw           s4, 2(a4)
                  lbu          s6, -999(a0)
                  sb           a3, -241(a6)
                  lb           ra, -1536(a0)
                  lb           a7, 50(a6)
                  lh           s8, 185(a6)
                  lbu          t6, -1458(a0)
                  sw           t4, -421(a0) #end load_store_instr_stream_1
                  sb           a4, -35(a4)
                  sb           s1, -31(a4)
                  lbu          t1, -157(a6) #end load_store_instr_stream_2
                  sh           s6, -30(a4)
                  lb           s4, -17(a4) #end load_store_instr_stream_0
8514:             xor          a5, s5, t6
8515:             xor          s9, a4, t3
8516:             bgeu         sp, a2, 8523f
8517:             sltu         a1, t2, s11
8518:             rem          a2, t5, a2
8519:             mulhu        a6, t4, s10
8520:             srai         t3, s10, 12
8521:             csrrs        t1, 0x305, zero
8522:             andi         s6, s3, -838
8523:             addi         s8, a7, -535
8524:             sltiu        t2, a4, 1488
8525:             add          s1, s7, t0
8526:             slti         s4, a6, -965
8527:             mulhu        s4, a5, a5
8528:             csrrs        a2, 0x344, zero
8529:             addi         a0, s6, -863
8530:             slt          t6, a7, t3
8531:             sra          s2, tp, s5
8532:             remu         t2, s10, a3
8533:             mulh         s6, s5, tp
8534:             or           s4, s11, s8
8535:             div          t2, s1, a7
8536:             csrrc        t5, 0x300, zero
8537:             csrrci       a4, 0x344, 16
8538:             xor          s11, tp, s7
8539:             csrrci       s11, 0x301, 9
8540:             mulh         a7, s3, t1
8541:             xori         t5, s10, -832
8542:             andi         s11, zero, 1914
8543:             srl          s0, t3, a6
8544:             mulhsu       t3, t6, s1
8545:             slti         s5, s0, 993
8546:             srai         s1, sp, 4
8547:             blt          gp, s8, 8565f
8548:             mulhu        gp, a6, s9
8549:             srli         t1, a0, 3
8550:             bge          tp, s6, 8553f
8551:             csrrsi       s10, 0x305, 0
8552:             bgeu         tp, sp, 8566f
8553:             csrrsi       s1, 0x344, 0
8554:             xor          s5, a7, s1
8555:             xori         s8, a6, 1992
8556:             xori         gp, s3, 260
8557:             srai         s4, s8, 23
8558:             sltu         a7, a4, a4
8559:             addi         a0, t4, 1711
8560:             div          s8, s10, sp
8561:             or           a7, tp, gp
8562:             ori          s9, a4, 842
8563:             or           t3, a6, a2
8564:             slt          s4, t6, t0
8565:             rem          a7, ra, a2
8566:             div          s6, zero, zero
8567:             bge          s10, a0, 8570f
8568:             sll          s1, s6, s8
8569:             sltu         zero, s10, ra
8570:             bltu         a3, t6, 8582f
8571:             add          gp, tp, s7
8572:             and          t2, s10, sp
8573:             srli         a7, t5, 29
8574:             srl          t4, a5, a2
8575:             beq          s4, t2, 8585f
8576:             divu         s5, zero, zero
8577:             sltiu        a5, gp, -1254
8578:             andi         t4, s1, 303
8579:             beq          s5, a7, 8580f
8580:             rem          t3, sp, s2
8581:             csrrw        s2, 0x304, s10
8582:             csrrs        a7, 0x305, zero
8583:             divu         t4, t2, a1
8584:             mulh         a5, t6, t2
8585:             csrrci       s4, 0x300, 0
8586:             slt          s9, s11, s0
8587:             add          a5, t3, s7
8588:             xori         gp, s11, -523
8589:             or           t6, t1, a6
8590:             bgeu         tp, s7, 8600f
8591:             slt          s5, ra, s1
8592:             xor          a1, s1, a5
8593:             slti         s10, ra, 650
8594:             slti         s5, s8, 136
8595:             srai         t1, a2, 13
8596:             bgeu         t1, s9, 8602f
8597:             csrrc        a4, 0x301, a7
8598:             slti         tp, a5, -626
8599:             xor          a2, s7, gp
8600:             sltiu        s3, a1, 1147
8601:             rem          s4, a2, s9
8602:             or           a1, s11, s5
8603:             csrrwi       s3, 0x304, 19
8604:             bge          sp, s6, 8609f
8605:             csrrc        t4, 0x305, zero
8606:             mulhu        zero, s0, s4
8607:             sub          zero, s0, a3
8608:             blt          ra, s4, 8617f
8609:             csrrwi       s11, 0x342, 27
8610:             sra          t1, s6, s7
8611:             mulhsu       s11, s3, a5
8612:             srli         t0, t2, 13
8613:             slt          t2, a0, gp
8614:             addi         a5, t4, -1532
8615:             mulhsu       tp, a7, a2
8616:             sltiu        s3, s3, 896
8617:             csrrci       s4, 0x301, 0
8618:             add          s11, t1, a3
8619:             csrrw        a7, 0x344, zero
8620:             csrrsi       t2, 0x300, 0
8621:             bge          a6, gp, 8632f
8622:             divu         ra, a4, a6
8623:             csrrsi       a1, 0x304, 13
8624:             srai         ra, s0, 16
8625:             csrrci       a2, 0x342, 14
8626:             sub          s5, a0, ra
8627:             srl          s2, t1, sp
8628:             auipc        s0, 51471
8629:             sltu         a1, zero, a5
8630:             or           t0, s6, t3
8631:             addi         zero, t4, 953
8632:             sltu         a1, t3, a4
8633:             blt          zero, tp, 8636f
8634:             blt          sp, s10, 8642f
8635:             slt          gp, t5, t1
8636:             lui          a6, 987535
8637:             slli         a1, s8, 26
8638:             sll          a7, s2, t3
8639:             csrrsi       t3, 0x305, 0
8640:             sltu         t0, gp, a6
8641:             mulhu        s3, t4, t1
8642:             bltu         s3, s1, 8653f
8643:             auipc        t3, 414384
8644:             and          s3, a7, s11
8645:             divu         a4, zero, s8
8646:             srli         zero, t2, 30
8647:             xori         s5, s3, -151
8648:             mulhsu       a0, s5, a3
8649:             slli         s4, a2, 13
8650:             bge          s1, a2, 8653f
8651:             remu         t0, t4, a0
8652:             mulhu        t1, a3, ra
8653:             slti         a5, ra, -1014
8654:             sltiu        t5, a1, 1944
8655:             bge          a2, s2, 8666f
8656:             bltu         t4, s4, 8668f
8657:             mulh         t1, a2, s10
8658:             csrrs        ra, 0x304, zero
8659:             divu         t4, a1, sp
8660:             mulh         s5, t5, s3
8661:             slli         s10, a7, 16
8662:             srli         s9, s4, 27
8663:             andi         t0, a1, 564
8664:             div          s3, a7, t2
8665:             lui          s0, 892516
8666:             csrrc        s8, 0x343, zero
8667:             beq          s8, s3, 8670f
8668:             srai         a1, t1, 14
8669:             srai         a5, t4, 8
8670:             bgeu         a7, t4, 8685f
8671:             addi         a1, t0, -1319
8672:             slti         ra, s11, 777
8673:             csrrw        t0, 0x342, s8
8674:             srl          ra, t0, t1
8675:             ori          zero, a4, 66
8676:             rem          a5, t1, t3
8677:             andi         t4, t4, -1934
8678:             lui          t6, 830313
8679:             srai         a0, t0, 7
8680:             mulhu        t6, t1, t4
8681:             csrrsi       s11, 0x301, 0
8682:             mulhsu       gp, t5, t4
8683:             xor          t6, a6, t5
8684:             nop
8685:             addi         t1, a7, -1351
8686:             auipc        s10, 605066
8687:             srl          s5, s5, tp
8688:             rem          t2, ra, t5
8689:             slti         s2, s7, -1136
8690:             addi         a2, s4, -1564
8691:             csrrc        ra, 0x300, zero
8692:             addi         t1, s0, 955
8693:             remu         t2, s0, s0
8694:             lui          a0, 202552
8695:             rem          s5, zero, zero
8696:             sltu         t3, s0, t0
8697:             xor          s6, t6, s0
8698:             slli         a2, s10, 0
8699:             csrrc        a6, 0x301, gp
8700:             divu         t4, a1, s10
8701:             addi         s4, s4, -662
8702:             sra          a6, s2, ra
8703:             nop
8704:             auipc        a1, 820232
8705:             slti         a7, a1, -1741
8706:             bltu         t3, a4, 8719f
8707:             add          s3, a4, t4
8708:             bge          t2, s1, 8718f
8709:             beq          s8, t3, 8712f
8710:             bne          s6, a5, 8714f
8711:             andi         t4, s4, -1377
8712:             srl          s5, t2, a4
8713:             bltu         zero, gp, 8716f
8714:             mulhu        t3, s5, s0
8715:             sltiu        t4, t2, -1415
8716:             or           s4, a4, t2
8717:             xor          s5, a0, s2
8718:             sltiu        t6, a2, -151
8719:             andi         s4, t3, -501
8720:             bne          a1, s8, 8724f
8721:             beq          s9, t2, 8728f
8722:             slli         a4, gp, 16
8723:             slti         a0, s11, -1601
8724:             blt          t3, a0, 8744f
8725:             bgeu         a4, sp, 8730f
8726:             div          t5, s11, a2
8727:             csrrci       a5, 0x304, 0
8728:             remu         s1, s10, a5
8729:             addi         a2, s0, -348
8730:             slli         s4, zero, 9
8731:             csrrwi       zero, 0x301, 27
8732:             remu         t2, t3, tp
8733:             csrrci       s9, 0x343, 19
8734:             remu         s11, s4, zero
8735:             bgeu         s0, a2, 8736f
8736:             slli         s11, sp, 18
8737:             xori         t1, s7, 1446
8738:             csrrw        s9, 0x342, a1
8739:             csrrwi       ra, 0x342, 1
8740:             csrrci       t5, 0x342, 0
8741:             nop
8742:             bgeu         tp, s2, 8753f
8743:             csrrwi       s4, 0x343, 30
8744:             nop
8745:             sra          s0, t3, t1
8746:             remu         t6, a5, s7
8747:             or           a4, t1, a4
8748:             andi         s3, s11, -731
8749:             sll          t4, s1, a5
8750:             slli         tp, t6, 30
8751:             sra          s10, t4, a7
8752:             slti         s5, t0, -1888
8753:             beq          s0, s1, 8761f
8754:             rem          s1, a1, a5
8755:             csrrwi       a5, 0x343, 27
8756:             slti         tp, t6, -1326
8757:             bne          tp, s6, 8760f
8758:             srli         t3, ra, 0
8759:             addi         t5, t4, -1939
8760:             bltu         s4, t6, 8770f
8761:             or           t5, a0, s2
8762:             sltiu        t6, s4, 1833
8763:             divu         t4, t6, t5
8764:             xor          t1, s6, ra
8765:             sll          a7, a5, s9
8766:             bne          a3, s11, 8767f
8767:             and          t3, zero, a2
8768:             xori         s1, s0, 1335
8769:             and          s0, s0, a5
8770:             csrrs        s4, 0x344, zero
8771:             slli         s5, sp, 19
8772:             csrrwi       a0, 0x343, 30
8773:             blt          sp, t3, 8775f
8774:             sra          t0, tp, zero
8775:             remu         s2, a3, t5
8776:             xori         gp, t3, -1813
8777:             slt          s10, s6, s4
8778:             csrrci       a1, 0x343, 29
8779:             andi         a2, a0, -1211
8780:             mulh         t6, sp, tp
8781:             and          tp, s4, s1
8782:             rem          a2, a5, a5
8783:             mulh         a4, t1, t0
8784:             csrrci       t1, 0x304, 0
8785:             bltu         a0, s11, 8791f
8786:             mul          s9, a4, s10
8787:             blt          s11, a2, 8796f
8788:             xori         a2, ra, -1268
8789:             ori          t2, a0, 474
8790:             beq          s0, s2, 8808f
8791:             csrrw        s1, 0x344, a6
8792:             bgeu         a4, gp, 8806f
8793:             div          t2, a7, s9
8794:             csrrwi       s8, 0x343, 24
8795:             csrrci       tp, 0x300, 0
8796:             xor          t2, t5, s10
8797:             csrrw        s4, 0x301, ra
8798:             sltiu        s5, sp, -154
8799:             sll          t3, s11, t0
8800:             beq          a7, a3, 8811f
8801:             sltu         s10, a2, s2
8802:             and          a7, s10, t4
8803:             xor          t0, s1, a0
8804:             bltu         s4, s1, 8822f
8805:             auipc        s5, 466460
8806:             add          a4, s6, t4
8807:             mulh         s5, a5, zero
8808:             nop
8809:             ori          a5, s10, 1600
8810:             divu         t4, a7, s10
8811:             mulhu        ra, s7, t3
8812:             csrrs        t4, 0x344, zero
8813:             nop
8814:             mulhsu       s4, t3, ra
8815:             mulhu        zero, ra, s2
8816:             andi         a2, ra, 787
8817:             or           t4, s5, a5
8818:             mulh         a2, s9, t4
8819:             csrrci       t1, 0x301, 0
8820:             add          s5, ra, a5
8821:             bltu         t5, s7, 8826f
8822:             sltiu        s8, t0, -1414
8823:             xor          a0, a2, s6
8824:             mulhu        t2, a6, s7
8825:             slti         t3, s9, -815
8826:             slli         t6, t1, 10
8827:             slti         gp, t2, 722
8828:             csrrc        t4, 0x301, s6
8829:             lui          s5, 118335
8830:             srli         t4, zero, 3
8831:             xori         s0, ra, -1606
8832:             csrrsi       s11, 0x300, 0
8833:             div          a6, t4, s0
8834:             rem          ra, a4, a7
8835:             csrrs        a4, 0x304, zero
8836:             mulhsu       zero, a2, a1
8837:             or           s4, a6, gp
8838:             div          s9, s8, gp
8839:             ori          zero, ra, -47
8840:             mul          s0, s11, t1
8841:             bge          a3, sp, 8849f
8842:             div          zero, t5, t6
8843:             mulh         ra, t4, s9
8844:             blt          s5, t6, 8848f
8845:             auipc        t0, 838431
8846:             sub          s11, tp, s7
8847:             mulhu        t2, gp, a5
8848:             remu         ra, a0, s6
8849:             srl          t5, s11, ra
8850:             divu         s9, t5, a0
8851:             csrrci       a2, 0x344, 0
8852:             beq          s0, a7, 8856f
8853:             mul          s1, a7, t1
8854:             sltu         s8, s2, t6
8855:             ori          s8, s2, -1166
8856:             auipc        ra, 487491
8857:             mulhsu       s5, s10, t3
8858:             sub          t5, a4, s6
8859:             csrrwi       s4, 0x344, 12
8860:             nop
8861:             srl          a7, gp, s5
8862:             ori          s10, s11, -1300
8863:             csrrwi       s1, 0x301, 4
8864:             csrrc        s2, 0x343, zero
8865:             div          t0, gp, s8
8866:             sltiu        t2, s11, 547
8867:             mul          s6, s5, t2
8868:             div          s4, a7, t1
8869:             or           a6, a0, a0
8870:             srl          t2, t2, s11
8871:             sltiu        ra, t4, -972
8872:             slli         ra, gp, 12
8873:             csrrs        a7, 0x305, zero
8874:             slt          s4, a2, a3
8875:             nop
8876:             sra          a7, t5, t3
8877:             bne          a6, a7, 8887f
8878:             csrrci       a0, 0x343, 17
8879:             slti         a7, zero, -2012
8880:             xori         s4, s1, -1665
8881:             mulhsu       t4, t5, t2
8882:             rem          t5, t1, a5
8883:             mul          s1, t2, s11
8884:             mul          t6, a3, t6
8885:             csrrsi       t3, 0x304, 0
8886:             xor          s6, s6, t2
8887:             mul          s4, t0, gp
8888:             srai         s4, sp, 11
8889:             sub          s0, a1, a5
8890:             auipc        t5, 975920
8891:             blt          t6, a6, 8911f
8892:             xor          gp, t6, a3
8893:             slt          t6, t4, gp
8894:             or           s11, t6, a7
8895:             bge          s2, s9, 8898f
8896:             and          s0, a5, t1
8897:             sltiu        a7, a5, -1084
8898:             div          s1, s2, s10
8899:             blt          a5, s6, 8904f
8900:             and          zero, gp, t5
8901:             divu         s11, t3, s5
8902:             div          a1, tp, a6
8903:             addi         a1, t3, -707
8904:             auipc        s6, 493145
8905:             sll          a1, s0, gp
8906:             srl          t3, sp, t2
8907:             beq          t4, s3, 8911f
8908:             sra          t3, s9, s1
8909:             add          s1, s5, s2
8910:             lui          s11, 417539
8911:             auipc        t6, 67199
8912:             rem          t0, a4, a3
8913:             srli         s3, t6, 27
8914:             sll          a5, t0, t5
8915:             csrrsi       s9, 0x344, 23
8916:             addi         s4, s4, -1229
8917:             csrrci       a5, 0x305, 0
8918:             nop
8919:             divu         t6, t6, s2
8920:             blt          t1, s2, 8929f
8921:             beq          t5, a2, 8927f
8922:             slli         s0, s10, 25
8923:             mulh         s4, s3, tp
8924:             sll          gp, t3, s7
8925:             addi         t5, zero, -721
8926:             auipc        s0, 835713
8927:             rem          s9, a1, s4
main_85:          jal          t4, 6f
0:                jal          t1, 1f
1:                jal          t4, 15f
2:                jal          ra, 12f
3:                jal          ra, 11f
4:                jal          ra, 10f
5:                jal          ra, 17f
6:                jal          ra, 3b
7:                jal          ra, 9f
8:                jal          a1, 13f
9:                jal          ra, 2b
10:               jal          tp, 5b
11:               jal          ra, 14f
12:               jal          ra, 16f
13:               jal          ra, 4b
14:               jal          ra, 0b
15:               jal          t1, 7b
16:               jal          s0, 8b
17:               slti         s3, t3, 99
8928:             bltu         s1, a2, 8939f
8929:             bge          ra, t0, 8937f
8930:             and          s6, a6, t2
8931:             srli         a1, s11, 0
8932:             add          a6, a7, s3
8933:             csrrsi       t3, 0x304, 1
8934:             sll          s4, a6, s3
8935:             csrrsi       t3, 0x304, 29
8936:             or           ra, a0, t6
8937:             csrrw        s6, 0x342, t3
8938:             lui          t2, 429295
8939:             xori         a2, t2, 937
8940:             slt          s5, tp, s3
8941:             bne          s5, s7, 8942f
8942:             add          ra, t4, s7
8943:             slt          zero, a3, sp
8944:             or           a2, s10, a6
8945:             addi         a1, t2, -1007
8946:             csrrci       s2, 0x342, 21
8947:             beq          s2, s0, 8949f
8948:             mulh         s0, s8, zero
8949:             csrrw        tp, 0x343, s6
8950:             sltiu        a4, a5, 2042
8951:             lui          tp, 784085
8952:             sll          t1, tp, tp
8953:             sub          s4, s0, sp
8954:             mulhsu       s10, s4, ra
8955:             slli         ra, s10, 10
8956:             mulhu        t4, a1, t2
8957:             csrrc        t4, 0x343, zero
8958:             mulh         s0, s11, a5
8959:             xor          a7, gp, a6
8960:             rem          t1, t3, s7
8961:             and          t1, sp, a0
8962:             slt          t5, a6, s10
8963:             csrrc        s5, 0x301, a4
8964:             slli         t6, ra, 28
8965:             addi         a2, s0, 1629
8966:             bge          s0, s0, 8973f
8967:             srli         s0, t4, 18
8968:             srai         s3, t0, 11
8969:             sll          s3, s11, s8
8970:             csrrs        a5, 0x343, zero
8971:             xor          s1, s11, s2
8972:             csrrc        a5, 0x343, zero
8973:             auipc        s5, 785258
8974:             sltu         t3, s4, a0
8975:             csrrci       gp, 0x343, 0
8976:             mul          a6, s0, a3
8977:             csrrs        s6, 0x343, a2
8978:             bne          s2, ra, 8981f
8979:             csrrs        t1, 0x344, gp
8980:             mulhsu       s2, zero, t3
8981:             div          t0, t1, gp
8982:             bge          s5, tp, 8995f
8983:             auipc        s4, 826478
8984:             slt          gp, s9, t1
8985:             andi         a2, gp, -119
8986:             slt          t2, t3, a1
8987:             slti         s1, t0, 291
8988:             csrrci       s4, 0x343, 0
8989:             mulhsu       t2, gp, t1
8990:             rem          s4, sp, a4
8991:             srli         s6, t6, 1
main_112:         jal          t4, 17f
0:                jal          a4, 3f
1:                jal          t4, 13f
2:                jal          ra, 16f
3:                jal          ra, 4f
4:                jal          ra, 19f
5:                jal          t1, 1b
6:                jal          gp, 7f
7:                jal          t1, 2b
8:                jal          t1, 20f
9:                jal          t1, 8b
10:               jal          ra, 6b
11:               jal          t1, 14f
12:               jal          t0, 9b
13:               jal          s2, 0b
14:               jal          s5, 10b
15:               jal          ra, 18f
16:               jal          ra, 12b
17:               jal          t1, 5b
18:               jal          ra, 11b
19:               jal          ra, 15b
20:               mulhu        s0, a2, tp
8992:             mul          ra, s3, t3
8993:             xor          a0, s10, s4
8994:             mulh         ra, s0, a1
8995:             csrrci       t1, 0x300, 0
8996:             bgeu         zero, s6, 8997f
8997:             or           s10, t2, a0
8998:             lui          s2, 960858
8999:             sll          tp, a4, t6
9000:             ori          zero, a2, 5
9001:             srl          s2, gp, tp
9002:             lui          a5, 645950
9003:             sltiu        s5, t2, 1932
9004:             sltu         s3, tp, t6
9005:             xor          gp, a3, gp
9006:             bgeu         t0, a7, 9020f
9007:             mulhsu       t1, tp, a1
9008:             divu         a2, s3, zero
9009:             add          t6, t2, s3
9010:             mulhsu       t2, a6, a3
9011:             xori         s10, a2, 629
9012:             sll          s3, s4, s4
9013:             beq          a3, tp, 9031f
9014:             slt          gp, s10, s8
9015:             xori         gp, sp, -1922
9016:             csrrc        t6, 0x305, zero
9017:             div          a1, a1, zero
9018:             sub          t2, gp, gp
9019:             add          t3, t3, a0
9020:             xori         s10, t4, -674
9021:             sltu         a1, a4, t2
9022:             sra          a7, a2, t6
9023:             mulhsu       t5, t4, s9
9024:             srai         t6, s3, 17
9025:             slli         t5, s9, 13
9026:             bne          s3, a2, 9037f
9027:             bltu         s5, a2, 9042f
9028:             csrrw        s9, 0x344, sp
9029:             srl          ra, a0, gp
9030:             mulhu        t6, sp, a6
9031:             xori         a1, t5, 593
9032:             mulhu        t3, s8, t2
9033:             srl          t3, a0, a5
9034:             slli         tp, s9, 26
9035:             div          t0, s5, t3
9036:             mul          s0, a3, s8
9037:             mulhsu       t0, t3, t3
9038:             auipc        a4, 623102
9039:             beq          a3, t3, 9042f
9040:             bne          s8, s7, 9048f
9041:             sra          s5, zero, a3
9042:             srl          t0, a5, s2
9043:             rem          a0, a7, s5
9044:             xori         t3, s7, 1933
9045:             mulhsu       a0, t2, t1
9046:             mulhsu       t6, a5, s9
9047:             srli         a2, s1, 2
9048:             csrrwi       t4, 0x342, 19
9049:             sra          t2, a4, t1
9050:             mulhsu       s10, ra, s2
9051:             add          s4, s11, a4
9052:             and          zero, s8, tp
9053:             addi         a5, s10, -1913
9054:             srl          ra, zero, t5
9055:             csrrc        gp, 0x305, zero
9056:             mulhu        s9, s3, s10
9057:             mulhu        s1, a0, s0
9058:             mulh         a0, s11, a3
9059:             srl          tp, a2, s0
9060:             blt          s10, a2, 9065f
9061:             sltu         a1, a5, s4
9062:             bgeu         s0, tp, 9073f
9063:             slt          a0, t1, ra
9064:             bgeu         s7, a2, 9074f
9065:             csrrwi       t5, 0x301, 1
9066:             csrrc        s3, 0x300, zero
9067:             auipc        t2, 556537
9068:             bgeu         a6, t3, 9086f
9069:             csrrw        a0, 0x343, s6
9070:             mulhsu       a7, s10, t0
9071:             csrrci       s4, 0x342, 0
9072:             csrrw        t2, 0x304, s6
9073:             andi         ra, s8, -1881
9074:             srli         a2, a0, 31
9075:             sub          s2, s10, t2
9076:             bge          s1, t1, 9080f
9077:             remu         t5, s4, ra
9078:             addi         s9, tp, 513
9079:             sltiu        s2, s11, -738
9080:             sub          a7, a7, a5
9081:             andi         t2, s3, -654
9082:             mul          a5, s5, sp
9083:             sltiu        s5, s4, -857
9084:             divu         t3, t2, s6
9085:             andi         s9, t6, -600
9086:             bge          t2, a0, 9098f
9087:             div          a6, s1, s6
9088:             or           a6, s7, t1
9089:             beq          s6, t0, 9092f
9090:             mul          s10, ra, s1
9091:             csrrc        a7, 0x304, s0
9092:             bgeu         a5, a5, 9095f
9093:             bge          t5, a0, 9107f
9094:             sltu         t5, tp, s4
9095:             bge          s2, a0, 9108f
9096:             xor          t0, a4, gp
9097:             slti         a1, sp, 50
9098:             mulh         a4, a0, t6
9099:             bgeu         t3, t0, 9109f
9100:             mulhsu       tp, t5, ra
9101:             srai         a6, a1, 17
9102:             csrrwi       s10, 0x343, 9
9103:             mul          a2, s5, s6
9104:             csrrs        t0, 0x304, zero
9105:             csrrc        t3, 0x304, s4
9106:             sltu         s8, s10, t5
9107:             bne          t6, t1, 9115f
9108:             mulhsu       a2, s0, s4
9109:             sra          s0, a6, s0
9110:             slli         a7, a7, 22
9111:             bltu         a5, s9, 9116f
9112:             csrrw        s0, 0x344, a2
9113:             csrrc        a7, 0x301, s7
9114:             bgeu         a2, zero, 9120f
9115:             nop
9116:             csrrsi       s4, 0x304, 13
9117:             beq          s9, t0, 9124f
9118:             csrrc        a0, 0x300, zero
9119:             addi         t1, tp, 131
9120:             mulhu        t5, a1, t2
9121:             and          t0, a5, t6
9122:             bge          s8, a5, 9142f
9123:             srai         s1, ra, 28
9124:             div          a6, s1, t3
9125:             remu         ra, s8, t4
9126:             csrrci       a2, 0x305, 0
9127:             ori          a6, a0, -1554
9128:             ori          t0, s2, 1973
9129:             lui          zero, 120321
9130:             xori         s9, s10, -239
9131:             divu         a1, zero, t0
9132:             div          s8, s2, a2
9133:             nop
9134:             add          t5, ra, t2
9135:             csrrc        t0, 0x301, zero
9136:             srl          s2, s1, t5
9137:             bgeu         s5, t1, 9141f
9138:             sltu         s2, s0, t0
9139:             xori         gp, t1, 2002
9140:             remu         t0, a1, t0
9141:             divu         s4, s0, zero
9142:             beq          s2, s0, 9144f
9143:             bge          a3, s4, 9154f
9144:             beq          s4, t1, 9162f
9145:             srai         s6, a3, 4
9146:             csrrc        s5, 0x305, zero
9147:             csrrwi       s5, 0x343, 24
9148:             csrrs        t5, 0x344, zero
9149:             csrrwi       s6, 0x301, 28
9150:             csrrwi       a4, 0x343, 1
9151:             rem          t4, s6, a4
9152:             mulhsu       s6, s10, sp
9153:             csrrw        ra, 0x304, t0
9154:             xor          s2, a5, s8
9155:             bgeu         s5, t3, 9163f
9156:             addi         t5, s10, -320
9157:             bgeu         s9, a4, 9168f
9158:             ori          a5, t6, 43
9159:             sltiu        ra, t3, -359
9160:             ori          t1, s3, -554
9161:             rem          tp, sp, a0
9162:             sra          t2, a2, s2
9163:             csrrs        a7, 0x342, t2
9164:             sll          t1, a7, a1
                  la           t5, region_1+51522 #start riscv_load_store_rand_instr_stream_6
                  andi         s0, s8, 1259
                  sra          s4, t5, sp
                  lbu          t6, -22(t5)
                  xor          s6, tp, t5
                  lbu          t2, 47(t5)
                  rem          s4, s4, a0
                  lb           s6, -43(t5)
                  csrrwi       s1, 0x301, 8
                  add          s9, s2, s10
                  sb           s7, -42(t5)
                  srai         t2, a4, 9
                  lh           t4, -56(t5)
                  csrrsi       a0, 0x342, 21
                  sb           a1, -26(t5)
                  sw           s10, 38(t5)
                  csrrci       t6, 0x304, 0
                  sb           s7, -26(t5)
                  lb           a4, 39(t5)
                  sll          ra, s0, s8
                  mulhu        gp, ra, tp
                  ori          a6, zero, 1819
                  slti         a0, s6, -1924
                  remu         s4, s11, t1
                  sw           t4, -50(t5)
                  sb           s6, 21(t5)
                  and          s0, a7, a4
                  lbu          a0, -41(t5)
                  slli         s10, s10, 14
                  srli         s10, tp, 5
                  lb           tp, 25(t5)
                  sra          t4, a5, s10
                  sb           s11, 4(t5)
                  lbu          s4, -52(t5)
                  divu         zero, t1, a2
                  sb           s10, -15(t5)
                  lhu          s10, -50(t5)
                  lhu          s2, 28(t5)
                  sb           s1, -59(t5)
                  remu         s10, s4, t4
                  lbu          t0, 10(t5)
                  sh           sp, -30(t5)
                  lb           a7, 14(t5) #end riscv_load_store_rand_instr_stream_6
9165:             bne          s0, a2, 9183f
9166:             divu         s3, a3, a5
9167:             andi         a4, s10, -90
9168:             csrrci       t5, 0x300, 0
9169:             slti         s8, t1, -377
9170:             mulhu        t3, s6, gp
9171:             csrrs        s2, 0x305, zero
9172:             beq          s5, s10, 9183f
9173:             csrrsi       a0, 0x305, 0
9174:             sra          a4, t2, s8
9175:             sltiu        s11, s5, -468
9176:             srl          a4, zero, a1
9177:             mul          ra, a2, s2
9178:             sra          s8, ra, a6
9179:             lui          tp, 551542
9180:             mul          a5, zero, sp
9181:             slli         ra, s10, 30
9182:             csrrw        s2, 0x343, s5
9183:             beq          a0, zero, 9186f
9184:             remu         s10, a5, sp
9185:             bgeu         tp, s7, 9195f
9186:             bgeu         a1, s4, 9187f
9187:             or           zero, a5, a5
9188:             ori          s2, a2, 866
9189:             srl          t3, gp, s2
9190:             auipc        s2, 218443
9191:             xori         s3, s8, 1969
9192:             sll          a7, a1, t3
9193:             csrrsi       s0, 0x304, 27
9194:             csrrci       s1, 0x300, 0
9195:             bgeu         s11, a7, 9199f
9196:             bgeu         s11, s5, 9200f
9197:             csrrwi       s6, 0x304, 5
9198:             sltiu        s4, s7, 233
9199:             mulh         a1, s7, s0
9200:             bgeu         t0, ra, 9209f
9201:             andi         s4, s9, -658
9202:             csrrc        s11, 0x300, zero
9203:             csrrs        t3, 0x301, a3
9204:             sltiu        t6, t2, 1903
9205:             ori          t6, a3, -344
9206:             csrrw        t6, 0x343, t3
9207:             sub          a7, sp, s6
9208:             div          t4, a1, t4
9209:             bgeu         gp, s6, 9224f
9210:             andi         a0, s8, 142
9211:             xori         zero, s1, -149
9212:             ori          t6, s5, 883
9213:             xor          s9, a7, s2
9214:             srai         a6, gp, 30
9215:             mulhsu       a7, a4, a2
9216:             bltu         s7, a1, 9219f
9217:             csrrwi       a5, 0x342, 14
9218:             srai         t5, a4, 2
9219:             csrrs        s0, 0x305, zero
9220:             sll          s3, t0, tp
9221:             remu         t0, s4, a6
9222:             bne          s8, s4, 9225f
9223:             bgeu         s4, s11, 9224f
9224:             ori          t0, s10, -1269
9225:             sll          t4, t2, t3
9226:             sll          gp, sp, a3
9227:             xor          a4, s0, s1
9228:             slt          s9, s6, s8
9229:             auipc        s10, 296514
9230:             mulh         a5, ra, a6
9231:             mul          a4, a2, t4
9232:             csrrsi       s6, 0x301, 0
9233:             add          s11, a1, zero
9234:             mulhsu       s10, tp, a5
9235:             auipc        s1, 283022
9236:             addi         gp, a5, -1450
9237:             andi         ra, a0, -447
9238:             divu         s3, s3, gp
9239:             or           t4, s10, s0
9240:             divu         a7, a6, zero
9241:             sltu         t4, a1, s0
9242:             xor          s6, s3, s8
9243:             slti         t3, t5, 464
9244:             div          t2, t4, s10
9245:             bltu         s9, a1, 9248f
9246:             andi         a2, a7, -921
9247:             remu         tp, s11, a2
9248:             div          t5, s6, sp
9249:             slti         s8, t0, 1015
9250:             sltu         s2, a5, s4
9251:             srl          t0, a2, a6
9252:             csrrs        s6, 0x342, zero
9253:             sltiu        s4, s5, -1143
9254:             slli         t6, s0, 4
9255:             xor          s3, s6, s0
9256:             csrrsi       s4, 0x344, 6
9257:             mulhu        a0, t5, a3
9258:             sra          a6, s9, a3
9259:             mulhsu       t3, a2, t6
9260:             lui          s2, 691473
9261:             csrrw        s4, 0x301, s0
9262:             ori          t6, ra, -1883
9263:             blt          s3, t4, 9275f
9264:             sltu         a6, t6, t2
9265:             csrrwi       t2, 0x342, 0
9266:             sll          s0, a7, tp
9267:             sltu         a4, s8, a6
9268:             remu         a1, t3, a3
9269:             and          s1, t1, s0
9270:             bne          a0, s4, 9275f
9271:             and          s8, s5, s0
9272:             addi         s8, a1, -271
9273:             xor          a4, zero, s3
9274:             csrrci       t5, 0x300, 0
9275:             or           s1, t0, a3
9276:             csrrc        t3, 0x304, a3
9277:             divu         s3, s10, t1
9278:             sra          t3, a0, s4
9279:             or           ra, t6, s2
9280:             sltu         s9, t3, s3
9281:             srli         a5, t0, 27
9282:             srai         tp, s1, 23
9283:             mulh         s3, t3, t3
9284:             sltiu        a6, s6, -1301
9285:             slti         t6, a5, 1438
9286:             srli         a6, t5, 8
9287:             andi         a0, a3, 1518
9288:             slli         a7, t5, 9
9289:             andi         s2, s11, -801
9290:             mul          a5, s3, ra
9291:             xori         t1, s4, -1047
9292:             ori          s0, s9, 1743
9293:             auipc        zero, 45742
9294:             srai         s11, s1, 4
9295:             bgeu         s10, t6, 9298f
9296:             csrrci       t1, 0x301, 30
9297:             mul          t0, s10, t2
9298:             bne          zero, t3, 9301f
9299:             sll          t0, s6, s1
9300:             csrrci       a6, 0x343, 0
9301:             sltiu        t4, t6, 103
9302:             div          a1, s3, s8
9303:             sub          s6, s10, s7
9304:             rem          t1, t2, s6
9305:             bge          ra, a5, 9307f
9306:             sub          a6, s4, s8
9307:             bltu         a0, s5, 9315f
9308:             mulh         s3, t2, a0
9309:             sra          a5, s5, t0
9310:             andi         s5, s2, -1812
9311:             mul          s10, s4, s4
9312:             or           s5, tp, t5
9313:             beq          s4, s9, 9320f
9314:             nop
9315:             srl          s11, a1, s3
9316:             srli         s9, s7, 11
9317:             rem          a2, ra, sp
9318:             nop
9319:             csrrci       a0, 0x304, 0
9320:             csrrsi       s8, 0x344, 0
9321:             sub          tp, s7, t1
9322:             slti         s2, t3, 1443
9323:             slti         t6, a4, -1153
9324:             csrrs        s5, 0x301, zero
9325:             and          t1, s7, t5
9326:             bge          gp, s5, 9329f
9327:             bltu         s11, a1, 9339f
9328:             slt          a7, t0, a7
9329:             xor          s8, zero, s1
9330:             srai         s9, a0, 27
9331:             add          tp, s0, a1
9332:             xor          s6, t3, a0
9333:             slti         s1, a2, 1777
9334:             and          s0, t3, ra
9335:             srai         s3, t3, 1
9336:             mulh         s6, s3, s7
9337:             auipc        t6, 670949
9338:             or           s9, a1, s6
9339:             mulh         t5, s11, tp
9340:             slt          t3, tp, a1
9341:             mulhsu       t5, ra, a5
9342:             auipc        t6, 725297
9343:             lui          t0, 517755
9344:             auipc        t0, 908025
9345:             slli         t5, a6, 19
9346:             auipc        a6, 644004
9347:             rem          zero, a6, zero
9348:             and          s4, s7, t3
9349:             slt          a7, s7, a1
9350:             xor          t5, t0, s8
9351:             andi         t0, s11, 537
9352:             mulhu        a6, s2, t2
9353:             nop
9354:             xori         s8, t2, 910
9355:             csrrsi       s2, 0x342, 0
9356:             divu         a0, s2, s3
9357:             remu         s5, s8, t1
9358:             csrrw        s3, 0x342, t5
9359:             slli         s11, zero, 10
9360:             csrrs        s5, 0x301, s11
9361:             csrrs        s10, 0x344, zero
9362:             csrrw        s6, 0x301, a3
9363:             divu         ra, t4, t4
9364:             andi         t1, a5, -1442
9365:             xor          t4, t3, s3
                  la           a6, region_0+3798 #start load_store_instr_stream_0
                  lb           s0, 177(a6)
                  la           s1, region_1+61563 #start load_store_instr_stream_1
                  lw           t2, -82(a6)
                  sb           t6, 172(a6)
                  sh           s5, 53(s1)
                  lb           t2, 24(s1)
                  lbu          s5, 52(s1)
                  lh           ra, 154(a6)
                  sh           s2, 206(a6)
                  lbu          s0, -62(s1)
                  lb           t3, -46(s1)
                  lb           t3, 124(a6)
                  lbu          a4, 157(a6)
                  lbu          s6, -49(s1)
                  lb           tp, 205(a6)
                  lb           ra, -85(a6)
                  lb           t5, 12(s1)
                  lbu          a2, 4(s1) #end load_store_instr_stream_1
                  sh           t4, 194(a6) #end load_store_instr_stream_0
9366:             srli         s3, t2, 28
9367:             csrrw        t0, 0x301, s2
9368:             srl          t0, gp, a7
9369:             csrrsi       a5, 0x301, 0
9370:             blt          t5, s10, 9378f
9371:             srl          s11, a7, sp
9372:             ori          s9, t4, -337
9373:             sltu         t5, t5, a7
9374:             xor          t6, t6, s10
9375:             sll          s10, ra, t4
9376:             and          s2, s5, a1
9377:             srl          s1, t3, s7
9378:             beq          s1, s9, 9384f
9379:             sll          t5, tp, gp
9380:             xor          s2, s0, t1
9381:             csrrc        a7, 0x305, zero
9382:             divu         t1, a7, s10
9383:             or           tp, a2, t3
9384:             srli         ra, t5, 18
9385:             mul          s2, s10, s0
9386:             bne          s2, s11, 9397f
9387:             csrrc        s0, 0x304, zero
9388:             csrrc        tp, 0x304, zero
9389:             addi         a0, s9, -559
9390:             andi         s0, a7, -112
9391:             sra          t1, s6, t2
9392:             auipc        s11, 675205
9393:             auipc        s11, 307306
9394:             slli         s5, a1, 28
9395:             blt          a0, a0, 9399f
9396:             csrrwi       tp, 0x344, 24
9397:             csrrwi       s5, 0x301, 17
9398:             add          t6, s5, a3
9399:             csrrw        t2, 0x304, a6
9400:             bge          s0, t6, 9414f
9401:             blt          t0, a6, 9404f
9402:             rem          s10, t4, t4
9403:             xor          t2, t6, t3
9404:             srli         t5, s0, 20
9405:             sub          s1, ra, a3
9406:             csrrsi       t2, 0x305, 0
9407:             or           s5, a7, s7
9408:             csrrw        t5, 0x304, s1
9409:             xori         t3, s6, -1295
9410:             csrrs        tp, 0x305, zero
9411:             add          s9, s6, a2
9412:             csrrw        a4, 0x343, s6
                  la           s3, region_0+1957 #start load_store_instr_stream_1
                  la           a0, region_0+3990 #start load_store_instr_stream_0
                  lb           ra, -10(s3)
                  la           gp, region_0+977 #start load_store_instr_stream_2
                  lbu          s0, -9(gp)
                  lbu          a6, 13(a0)
                  lbu          t4, -42(gp)
                  lb           t2, -8(a0)
                  sb           t1, -40(gp)
                  lbu          s6, -18(gp)
                  lw           s8, -6(a0)
                  sh           a2, -10(a0)
                  lbu          s2, -10(gp)
                  lbu          a5, 5(a0)
                  lb           a1, -13(gp) #end load_store_instr_stream_2
                  sb           s1, 2(s3)
                  sb           s1, -4(s3)
                  lb           a5, -9(a0)
                  sb           a1, 3(s3)
                  sb           a0, -4(s3)
                  lbu          t1, 11(a0)
                  sb           a7, 3(s3) #end load_store_instr_stream_1
                  lb           t5, 13(a0) #end load_store_instr_stream_0
9413:             add          t4, s0, s2
9414:             slti         zero, t3, 862
9415:             srai         a1, a5, 18
9416:             slt          ra, a5, t5
9417:             csrrw        zero, 0x343, t4
9418:             sll          tp, s6, a1
9419:             sub          s11, sp, t6
9420:             bltu         a6, a2, 9431f
9421:             xori         zero, s11, 10
9422:             srai         t6, s9, 20
9423:             srl          zero, a3, s7
9424:             rem          s9, t4, s2
9425:             slti         a0, zero, 1035
9426:             bge          t5, s2, 9429f
9427:             sub          a0, s10, s6
9428:             xor          t0, s1, s4
                  addi         a2, zero, 0 #init loop 0 counter
                  srl          t4, s2, a6
                  srai         gp, ra, 2
                  addi         s6, zero, 15 #init loop 0 limit
main_212_0_t:     mul          t2, s4, a1
                  divu         ra, a1, a5
                  addi         a2, a2, 10 #update loop 0 counter
                  bltu         a2, s6, main_212_0_t #branch for loop 0
                  rem          s4, a0, a4
9429:             sub          t6, ra, s1
9430:             slti         s3, s3, -941
9431:             sra          a7, a4, sp
9432:             divu         a4, t3, a4
9433:             ori          s9, t6, 928
9434:             bge          s11, s7, 9444f
9435:             srli         s9, a7, 31
9436:             srl          a5, a0, a5
9437:             remu         t2, s11, a7
9438:             ori          t5, a4, -552
9439:             blt          t0, gp, 9457f
9440:             csrrw        a5, 0x344, s6
9441:             xori         a7, t4, -1150
9442:             add          a7, s9, t6
9443:             sub          s8, s3, t3
                  la           s11, region_0+2198 #start load_store_instr_stream_1
                  la           a0, region_1+20291 #start load_store_instr_stream_0
                  sw           t5, 37(a0)
                  lb           a5, 1492(s11)
                  lh           t3, 5(a0)
                  sw           gp, 9(a0)
                  lbu          t5, 2(a0)
                  lb           t6, 1027(s11)
                  lh           t6, -33(a0)
                  lh           s3, 1000(s11)
                  lb           s2, 44(a0)
                  lb           gp, 816(s11)
                  lw           gp, 1790(s11)
                  lbu          s6, -61(a0)
                  lbu          a6, 1229(s11) #end load_store_instr_stream_1
                  lhu          s9, -5(a0) #end load_store_instr_stream_0
9444:             bgeu         s5, s9, 9453f
9445:             div          t0, t3, a1
9446:             blt          s0, a7, 9447f
9447:             and          tp, zero, a6
9448:             and          s4, a7, s5
9449:             sll          s10, sp, s1
9450:             beq          s6, ra, 9453f
9451:             andi         a6, s10, 1434
9452:             mulhsu       s4, t2, s6
9453:             mulhsu       t2, s0, a7
9454:             divu         t5, t6, s7
9455:             xor          s11, a5, a7
9456:             blt          a0, sp, 9461f
9457:             sltu         s2, a2, a0
9458:             xori         t3, t5, -85
9459:             slt          t4, s5, gp
9460:             srl          t4, gp, zero
9461:             srl          s3, a1, s10
9462:             mulhu        a4, s5, a1
9463:             or           s0, s5, a7
9464:             beq          ra, s7, 9469f
9465:             xori         s8, t5, -1340
9466:             sltiu        ra, tp, -812
9467:             ori          a6, s1, 1474
9468:             beq          t0, t0, 9486f
9469:             divu         s5, a7, tp
9470:             slli         s1, t4, 4
9471:             blt          a7, s1, 9481f
9472:             lui          t5, 221737
9473:             srai         a6, s8, 27
9474:             divu         tp, a5, gp
9475:             sra          gp, s7, s6
9476:             csrrwi       ra, 0x344, 25
9477:             csrrc        s2, 0x304, zero
9478:             andi         a6, s4, 1075
9479:             csrrwi       s0, 0x343, 20
9480:             csrrc        t1, 0x300, zero
9481:             csrrwi       t3, 0x304, 28
9482:             mul          t6, s3, s4
9483:             auipc        zero, 944122
9484:             mulhu        a6, s0, s6
9485:             sltiu        t0, a1, 441
9486:             rem          t0, s6, zero
9487:             rem          s5, s0, s7
9488:             sra          gp, a0, s2
9489:             add          s6, t1, a4
9490:             div          s4, s4, a1
9491:             remu         ra, tp, a2
9492:             or           a2, t4, zero
9493:             csrrw        s2, 0x343, tp
9494:             andi         s1, s6, -292
9495:             beq          s2, a2, 9499f
9496:             divu         a2, ra, a0
9497:             add          a2, s5, zero
9498:             srli         s10, a5, 23
9499:             mul          t5, a2, s8
9500:             div          s9, a1, s2
9501:             nop
9502:             mulhu        a2, a6, ra
9503:             rem          t6, t0, t6
9504:             bltu         a1, s6, 9524f
9505:             sra          s3, t1, a2
9506:             xori         t3, a4, -1501
9507:             slti         gp, s2, 1231
9508:             nop
9509:             csrrs        s0, 0x344, a3
9510:             mul          s8, s7, a4
9511:             csrrs        t2, 0x342, tp
9512:             csrrwi       s1, 0x342, 19
9513:             bgeu         a4, s2, 9524f
9514:             rem          s1, s5, a6
9515:             add          s9, t1, a7
9516:             sra          t1, t1, s9
9517:             nop
9518:             mulhsu       t2, s2, s5
9519:             sltu         s11, s7, a1
9520:             nop
9521:             bltu         a2, a6, 9522f
9522:             divu         tp, s2, t0
9523:             remu         zero, t6, t5
9524:             sra          ra, t2, a0
9525:             div          a7, t5, a2
9526:             divu         s10, t5, t3
9527:             ori          gp, s1, -216
9528:             slli         s0, s5, 31
9529:             divu         a1, s7, t2
9530:             rem          s6, s6, s7
9531:             slti         a5, sp, -1114
9532:             beq          a4, a2, 9536f
9533:             nop
9534:             mulh         s9, t5, t3
9535:             rem          s9, sp, s2
9536:             bgeu         t0, tp, 9551f
9537:             andi         t6, s8, -458
9538:             srli         gp, s2, 7
9539:             sltiu        t4, a6, -1701
9540:             xor          t4, a1, t6
9541:             sra          t2, s7, a3
9542:             xor          s11, a0, ra
9543:             bge          t6, s7, 9556f
9544:             bltu         ra, s2, 9547f
9545:             sub          s6, gp, s6
9546:             mulh         a7, zero, t1
9547:             or           t5, t6, s7
9548:             mul          ra, s1, s0
9549:             ori          t2, s10, 373
9550:             and          t1, zero, sp
9551:             csrrc        s9, 0x344, gp
9552:             div          t2, s4, a6
9553:             lui          s3, 860668
9554:             andi         a7, s5, 693
9555:             or           tp, t6, s6
9556:             lui          a0, 455312
9557:             csrrc        a5, 0x305, zero
9558:             beq          s0, t0, 9561f
9559:             sll          s2, s10, s0
9560:             or           s3, a7, zero
9561:             mul          t2, s8, s5
9562:             divu         a1, s8, t5
9563:             blt          s8, sp, 9565f
9564:             mulhu        s8, s4, s7
9565:             sub          t5, a7, s0
9566:             mulhu        s9, sp, s11
9567:             sltu         s8, s8, a5
9568:             divu         t3, tp, a3
9569:             xori         s10, t2, 1628
9570:             or           s9, s4, s10
9571:             csrrw        s8, 0x301, s2
9572:             beq          a7, a6, 9575f
9573:             lui          s4, 285412
9574:             csrrci       a4, 0x301, 17
9575:             mul          gp, a5, a2
9576:             or           a7, s11, s2
9577:             nop
9578:             bne          s4, s0, 9585f
9579:             slt          tp, t6, t5
9580:             sll          a1, s7, a7
9581:             srl          s9, a3, t1
9582:             sltu         tp, s11, s0
9583:             addi         s10, s2, -1661
9584:             or           t1, sp, s4
9585:             srli         s5, a5, 19
9586:             mulhsu       s5, t0, s0
9587:             rem          t6, t6, s6
9588:             csrrs        s4, 0x342, s7
9589:             csrrci       t0, 0x342, 0
9590:             csrrc        s11, 0x342, zero
9591:             slt          ra, a6, s3
9592:             bgeu         s5, a4, 9600f
9593:             sltu         a4, ra, t5
9594:             sll          t1, t1, s2
9595:             srli         s1, ra, 24
9596:             xor          a0, t1, s1
9597:             rem          t2, s5, a1
9598:             srli         a5, sp, 7
9599:             sra          t1, sp, s4
9600:             csrrsi       s10, 0x304, 6
9601:             ori          t0, s11, -1506
9602:             csrrw        s1, 0x342, s5
9603:             sll          a4, a3, s2
9604:             mulhsu       a0, a3, ra
9605:             srl          s4, a6, s6
9606:             bgeu         t0, tp, 9617f
9607:             sll          s4, a6, t3
9608:             sra          a6, sp, s1
9609:             sub          t6, ra, a0
9610:             sltu         t2, sp, a1
9611:             nop
9612:             csrrci       s9, 0x344, 0
9613:             slli         s5, t2, 26
9614:             srli         s1, t5, 4
9615:             csrrwi       s6, 0x301, 10
9616:             csrrci       s6, 0x301, 0
9617:             bgeu         s0, a5, 9635f
9618:             xori         s4, t0, 2026
9619:             sll          t3, t3, t1
9620:             rem          t0, ra, s7
9621:             blt          a7, s2, 9631f
9622:             sra          s6, t5, s6
9623:             sra          s3, s6, s8
9624:             sub          t0, s2, zero
9625:             auipc        gp, 239613
9626:             mulh         ra, t3, s3
9627:             and          t0, s7, s0
9628:             csrrwi       a5, 0x304, 1
9629:             mulhu        t3, s5, a5
9630:             remu         t5, s4, sp
9631:             and          ra, s9, t2
9632:             sra          zero, t2, gp
9633:             csrrsi       a4, 0x342, 0
9634:             srl          t5, s9, s8
9635:             rem          s1, t6, a7
9636:             remu         t0, a1, s10
9637:             sltiu        a0, t3, 1750
9638:             add          s9, s4, gp
9639:             auipc        t3, 437954
9640:             mulhu        a5, a0, s4
9641:             csrrci       t1, 0x344, 0
9642:             mul          a5, a1, a7
9643:             csrrs        s10, 0x305, zero
9644:             auipc        s11, 702399
9645:             beq          t2, a2, 9653f
9646:             bltu         a6, s0, 9650f
9647:             slli         a1, a3, 24
9648:             sub          a2, s3, t6
9649:             srli         s9, a1, 10
9650:             sra          zero, s8, a5
9651:             xori         t0, s10, -1098
9652:             csrrc        s11, 0x344, zero
9653:             auipc        t2, 343216
9654:             srl          t2, s10, a5
9655:             sub          s3, t2, tp
9656:             sltiu        a2, t0, -1408
9657:             sra          a5, s9, s0
9658:             slli         t6, t2, 19
9659:             slli         tp, a0, 28
9660:             mulh         tp, s5, zero
9661:             slli         s3, s1, 7
9662:             mulhu        zero, s4, a1
9663:             mul          s4, tp, s6
                  la           s6, region_1+64431 #start load_store_instr_stream_1
                  la           s1, region_0+2103 #start load_store_instr_stream_0
                  lbu          t0, -16(s1)
                  lh           a6, -1(s1)
                  lb           t2, 4(s1)
                  sb           s9, -6(s6)
                  sb           s8, 5(s1)
                  sb           s2, -16(s6)
                  sb           s4, 7(s6)
                  sb           ra, 0(s1)
                  lbu          s0, -18(s1)
                  lb           ra, 8(s6)
                  lb           a5, 10(s6) #end load_store_instr_stream_1
                  sh           s6, -37(s1)
                  lb           tp, 58(s1) #end load_store_instr_stream_0
9664:             and          a1, a6, a0
9665:             addi         t2, t4, -154
9666:             lui          s10, 779888
9667:             sltiu        s6, t3, 1719
9668:             csrrwi       t4, 0x342, 16
9669:             sltiu        t4, ra, -597
9670:             beq          t6, a0, 9685f
9671:             csrrc        t1, 0x344, zero
9672:             add          s9, s1, sp
9673:             addi         t1, s9, 419
9674:             sra          s5, a7, t4
9675:             lui          s10, 201863
9676:             addi         t3, t2, -807
9677:             ori          t3, t5, -1490
9678:             mulh         ra, t6, t3
9679:             remu         zero, s11, t0
9680:             or           s9, t3, gp
9681:             csrrci       a0, 0x304, 0
9682:             csrrc        a6, 0x301, a0
9683:             sltu         s10, s11, s0
9684:             blt          s3, a4, 9688f
9685:             csrrc        s9, 0x343, zero
9686:             csrrci       t0, 0x300, 0
9687:             bge          s2, a1, 9691f
9688:             csrrwi       a2, 0x342, 5
9689:             addi         s2, ra, -1093
9690:             nop
9691:             and          t4, t2, t6
9692:             andi         s0, t2, 784
9693:             slli         s6, s4, 19
9694:             slt          a1, a5, a6
9695:             auipc        ra, 970484
9696:             beq          sp, gp, 9707f
9697:             sub          zero, s2, t1
9698:             xor          a2, s11, t1
9699:             xor          t1, s10, t1
9700:             lui          s5, 174365
9701:             lui          s6, 996453
9702:             remu         tp, s0, a1
9703:             and          tp, s11, a6
9704:             csrrs        a7, 0x305, zero
9705:             mulhsu       s2, t6, s4
9706:             bltu         a0, s2, 9718f
9707:             and          t4, a2, s10
9708:             srli         s6, s7, 5
9709:             divu         s1, s11, a4
9710:             divu         t2, s0, a2
9711:             andi         s9, s3, -2017
9712:             addi         s0, a3, 2047
9713:             mulhsu       s5, a5, a6
9714:             or           t4, sp, a1
9715:             mulh         a1, a6, t6
9716:             csrrw        s3, 0x301, a1
9717:             xori         tp, a7, 110
9718:             slli         t5, a5, 29
9719:             sra          t6, gp, t5
9720:             srli         a5, s4, 13
9721:             bltu         t0, a7, 9724f
9722:             mul          gp, t5, a4
9723:             bltu         s6, a7, 9724f
9724:             slt          t6, t0, sp
9725:             bne          s9, a2, 9730f
9726:             div          t2, a5, a0
9727:             xori         t2, s4, 1816
9728:             auipc        a2, 916680
9729:             mul          s0, s4, t6
9730:             srli         t6, s0, 5
9731:             auipc        t1, 273739
9732:             csrrwi       tp, 0x301, 9
9733:             csrrci       gp, 0x301, 0
9734:             csrrwi       s2, 0x342, 24
9735:             auipc        s8, 321573
9736:             xor          t3, s3, tp
9737:             blt          a7, s8, 9742f
9738:             divu         s1, s4, a1
9739:             and          a0, a3, t0
9740:             add          t2, a1, s6
9741:             auipc        s5, 357739
9742:             xori         s1, a2, -335
9743:             csrrw        gp, 0x301, a0
9744:             bgeu         ra, t3, 9755f
9745:             srli         a0, t6, 1
9746:             csrrw        s10, 0x301, t1
9747:             beq          s8, t6, 9767f
9748:             csrrci       t1, 0x344, 18
9749:             slt          s9, ra, a0
9750:             auipc        zero, 102402
9751:             auipc        a0, 551684
9752:             slli         s11, s8, 21
9753:             csrrc        a4, 0x304, t0
9754:             lui          s9, 968326
9755:             xor          a4, s1, t6
9756:             srli         s0, a4, 23
9757:             bltu         t2, t1, 9775f
9758:             addi         t1, a6, 1239
9759:             nop
9760:             auipc        s4, 457051
9761:             sll          s10, s7, t2
9762:             add          t3, t6, a5
9763:             csrrsi       s3, 0x304, 2
9764:             csrrci       a6, 0x343, 5
9765:             mulh         t1, s3, s11
9766:             mulh         a1, t4, s7
9767:             bltu         s8, s2, 9773f
9768:             xor          a5, s10, s8
9769:             sltiu        a4, a1, -1988
9770:             mulh         s10, a4, t5
9771:             csrrsi       s5, 0x344, 0
9772:             nop
9773:             bge          a6, a2, 9786f
9774:             andi         t3, s2, 1784
9775:             csrrc        a0, 0x305, zero
9776:             sltiu        s10, s11, -718
9777:             srli         a7, sp, 2
9778:             andi         zero, t4, -1222
9779:             nop
9780:             srai         t0, s1, 10
9781:             csrrw        a7, 0x301, t5
9782:             csrrw        s0, 0x344, gp
9783:             lui          s9, 385129
9784:             bltu         t2, s6, 9793f
9785:             add          s10, zero, t2
9786:             div          a0, zero, s4
9787:             mulh         gp, ra, tp
9788:             sra          t1, t3, tp
9789:             div          tp, a4, s5
9790:             csrrw        t6, 0x343, t6
9791:             bne          s6, s8, 9805f
9792:             sltiu        a7, ra, 1100
9793:             ori          s3, t3, -1456
9794:             csrrci       t3, 0x344, 6
9795:             auipc        s1, 666869
9796:             beq          s7, t3, 9797f
9797:             sub          s8, tp, t0
9798:             nop
9799:             sub          a2, s8, s9
9800:             addi         t6, ra, -1849
9801:             csrrs        s5, 0x301, zero
9802:             sltu         t6, gp, a2
9803:             csrrsi       t0, 0x301, 29
9804:             sltu         t3, s2, a0
9805:             divu         a5, s1, t3
9806:             sub          s4, t2, s0
9807:             bltu         a5, t1, 9817f
9808:             bltu         a4, t5, 9811f
9809:             beq          s5, a0, 9811f
9810:             csrrs        a2, 0x300, zero
9811:             srl          s4, t3, gp
9812:             sra          a6, s10, t2
9813:             csrrsi       s2, 0x343, 5
9814:             sra          s5, ra, a3
9815:             sra          t4, a4, t5
9816:             sltiu        s2, s0, 584
9817:             divu         s6, s5, tp
9818:             csrrci       s5, 0x304, 0
9819:             xori         zero, a4, -393
9820:             rem          s10, sp, s2
9821:             mulhsu       t6, t1, s3
9822:             sub          t6, a1, a0
9823:             sltiu        s8, a7, -822
9824:             slli         s6, t5, 7
9825:             mulhu        a1, s3, tp
9826:             srl          a6, s10, s7
9827:             csrrci       t5, 0x342, 0
9828:             sll          t3, a2, sp
9829:             slt          s9, s1, t2
9830:             csrrwi       t3, 0x344, 12
9831:             sll          tp, zero, t0
9832:             slti         t5, a3, -1283
9833:             andi         a5, s11, 625
9834:             blt          s5, tp, 9844f
9835:             blt          tp, a7, 9853f
9836:             mulhu        ra, ra, a0
9837:             bge          t5, s11, 9843f
9838:             srl          s3, s0, a2
9839:             add          t4, s2, s8
9840:             csrrwi       s3, 0x301, 21
9841:             slli         a5, a3, 5
9842:             xor          a6, s3, a0
9843:             srai         s10, t0, 2
9844:             csrrs        a1, 0x304, a3
9845:             div          s9, s7, t3
9846:             csrrw        s0, 0x343, s5
9847:             lui          s1, 759179
9848:             csrrw        a5, 0x344, a3
9849:             mul          s3, ra, a1
9850:             csrrci       s10, 0x301, 5
9851:             sub          a0, a0, t5
9852:             divu         a7, t1, s1
9853:             bge          a6, a4, 9860f
9854:             and          s4, t2, t1
9855:             andi         zero, a1, 132
9856:             csrrsi       tp, 0x342, 0
9857:             sltiu        t5, a7, 537
9858:             ori          s6, s4, 1889
9859:             bge          t5, s3, 9862f
9860:             csrrci       gp, 0x300, 0
9861:             srl          a0, t4, a1
9862:             slti         t5, s2, 1987
9863:             csrrwi       s6, 0x301, 22
9864:             sra          s5, t2, t0
9865:             nop
9866:             csrrw        a1, 0x304, t3
9867:             or           a1, s7, s7
9868:             csrrci       t1, 0x343, 4
9869:             divu         zero, s1, sp
9870:             slti         a4, s0, -1220
9871:             slt          s0, s4, s6
9872:             sltiu        s3, a5, 933
9873:             remu         s4, gp, s5
                  la           s8, region_1+52940 #start riscv_load_store_rand_instr_stream_13
                  div          s10, s3, s5
                  mulh         s10, t3, s9
                  mulh         a1, a7, s0
                  ori          a6, s11, 1301
                  csrrci       t4, 0x304, 1
                  lbu          s0, -180(s8)
                  csrrs        s1, 0x300, zero
                  lui          t0, 200292
                  lb           s9, -46(s8)
                  sb           t2, -142(s8)
                  mulhu        s2, s9, t3
                  sltiu        s0, s7, -1574
                  xori         a0, s1, 46
                  sb           s10, 149(s8)
                  and          t0, ra, zero
                  lbu          t6, -60(s8)
                  csrrwi       s2, 0x344, 8
                  div          tp, t3, a4
                  lb           s5, -234(s8)
                  lb           ra, -109(s8)
                  csrrc        s2, 0x305, zero
                  lb           s3, -187(s8)
                  and          tp, a3, t0
                  nop
                  srai         a1, t5, 16
                  rem          s3, s4, s6
                  lhu          a6, 246(s8)
                  rem          gp, t2, ra
                  csrrsi       s6, 0x343, 0
                  sb           s10, 156(s8)
                  xori         a5, a4, 1679
                  remu         t6, s0, s1
                  lbu          s11, -232(s8)
                  sll          a7, t2, a5
                  lhu          s10, -28(s8)
                  lbu          t2, 180(s8)
                  csrrci       s10, 0x343, 24
                  sb           s1, -236(s8)
                  add          t5, s2, s0
                  lhu          t0, -200(s8) #end riscv_load_store_rand_instr_stream_13
9874:             nop
9875:             csrrs        tp, 0x342, s4
9876:             csrrc        a7, 0x301, s0
9877:             sra          ra, s10, a4
9878:             rem          t0, zero, sp
9879:             csrrc        s2, 0x301, zero
9880:             div          a2, zero, a4
9881:             addi         t3, t2, 65
9882:             sltiu        s10, a4, -1061
9883:             csrrc        s5, 0x343, t3
9884:             rem          s11, s6, s11
9885:             div          zero, t3, a7
9886:             csrrc        s4, 0x305, zero
9887:             slli         a5, s3, 15
9888:             add          t6, t0, zero
9889:             sub          s6, t4, gp
9890:             bge          a2, s7, 9900f
9891:             slt          s9, s9, a6
9892:             csrrw        a4, 0x342, t0
9893:             blt          t2, tp, 9911f
9894:             slli         zero, a0, 8
9895:             bge          a1, s2, 9898f
9896:             mul          a7, a5, t1
9897:             ori          ra, s4, 1954
9898:             mulh         s10, a4, s3
9899:             auipc        t2, 126793
9900:             addi         t2, s11, -914
9901:             remu         t6, s5, t2
9902:             csrrc        t4, 0x300, zero
9903:             add          t2, t6, s7
9904:             divu         a6, s2, s0
9905:             addi         gp, s0, -1429
9906:             bgeu         sp, s0, 9914f
9907:             or           s0, t2, s4
9908:             remu         s2, a3, s5
9909:             slli         t5, s6, 15
9910:             csrrwi       t6, 0x344, 28
9911:             csrrwi       t6, 0x344, 2
9912:             bne          s3, a3, 9923f
9913:             sll          s10, tp, t4
9914:             bgeu         a1, a7, 9918f
9915:             srl          s5, t0, s11
9916:             xor          a2, s11, t4
9917:             blt          zero, gp, 9920f
9918:             bge          s0, tp, 9923f
9919:             bgeu         t5, a3, 9920f
9920:             xori         s6, s7, 1704
9921:             csrrsi       a4, 0x344, 7
9922:             and          a4, t6, s0
9923:             ori          t0, s4, 1816
9924:             srl          ra, sp, s7
9925:             csrrci       a6, 0x305, 0
9926:             mulhu        s9, s1, a2
9927:             xori         s11, a6, -90
9928:             auipc        t2, 146660
9929:             andi         ra, s2, -1983
9930:             srl          s2, s5, t3
9931:             mulhsu       gp, t5, s8
9932:             add          t0, a2, sp
                  la           ra, region_1+40440 #start riscv_load_store_hazard_instr_stream_14
                  lbu          a5, -46(ra)
                  sh           t1, -46(ra)
                  lw           s1, -184(ra)
                  sll          s6, s10, a7
                  sw           t4, -184(ra)
                  divu         t0, t3, s4
                  lb           s10, -184(ra)
                  andi         s6, zero, -189
                  lb           s9, -184(ra)
                  lb           a5, -184(ra)
                  lh           s6, -184(ra)
                  csrrsi       t1, 0x344, 0
                  sb           sp, -184(ra)
                  sh           t2, -184(ra)
                  sw           gp, -184(ra)
                  sh           t1, -184(ra)
                  lhu          t1, -184(ra)
                  sh           a5, -184(ra)
                  lbu          a6, -184(ra) #end riscv_load_store_hazard_instr_stream_14
9933:             csrrwi       s2, 0x343, 6
9934:             csrrw        a2, 0x301, s9
9935:             andi         s11, t5, 396
9936:             csrrs        s5, 0x342, zero
9937:             csrrs        s4, 0x300, zero
9938:             rem          t5, s9, s11
9939:             lui          a7, 248226
9940:             beq          gp, s10, 9941f
9941:             csrrc        s5, 0x343, a4
9942:             csrrs        t6, 0x342, a3
9943:             andi         t4, a3, -1924
9944:             csrrs        s11, 0x305, zero
9945:             bltu         gp, zero, 9948f
9946:             add          t3, sp, s11
9947:             bne          s4, s10, 9952f
9948:             andi         s3, s0, 1485
9949:             blt          s1, s11, 9969f
9950:             mulhsu       s2, a0, s7
9951:             slti         s6, s4, 59
9952:             nop
9953:             csrrci       s11, 0x300, 0
9954:             slt          s1, t1, ra
9955:             rem          s9, a1, t1
9956:             lui          t6, 829191
9957:             add          tp, tp, gp
9958:             rem          s0, s1, s9
9959:             bge          s1, sp, 9962f
9960:             sltu         a0, a1, t2
9961:             addi         t2, s9, -1184
9962:             csrrsi       s5, 0x344, 0
9963:             div          a2, s2, tp
9964:             bne          s9, s2, 9973f
9965:             div          s8, a7, s4
9966:             csrrw        t1, 0x304, t3
9967:             csrrw        a6, 0x343, t0
9968:             srli         s2, t5, 16
9969:             bne          zero, ra, 9973f
9970:             and          t2, ra, gp
9971:             mulhu        s10, sp, s1
9972:             blt          t0, t3, 9984f
9973:             bgeu         s3, t1, 9984f
9974:             srli         a6, s3, 11
9975:             blt          s2, t3, 9986f
9976:             nop
9977:             mul          t2, s5, ra
9978:             auipc        t6, 270378
9979:             mulh         t1, a1, a5
9980:             blt          s3, a2, 9984f
9981:             slli         s9, a2, 31
9982:             and          s8, a6, t5
9983:             divu         a5, s10, a5
9984:             blt          s8, t0, 9999f
9985:             csrrsi       s8, 0x305, 0
9986:             auipc        t0, 379962
9987:             bne          ra, sp, 9995f
9988:             and          s9, tp, t6
9989:             sll          a2, gp, a1
9990:             beq          t0, zero, 9999f
9991:             beq          a5, s3, 9999f
9992:             add          s6, s2, sp
9993:             or           a7, s8, a1
9994:             sub          s5, t2, t2
9995:             csrrwi       s4, 0x304, 28
9996:             sra          a4, gp, a6
9997:             csrrs        s9, 0x300, zero
9998:             csrrwi       s6, 0x344, 12
9999:             srai         s6, t5, 1
                  la x23, test_done
                  jalr x0, x23, 0
test_done:        
                  li gp, 0x73746f70
                  j write_tohost
write_tohost:     
                  li t5, 0xfffffffc

                  sw gp, 0(t5)

_exit:            
                  j write_tohost

instr_end:        
                  nop

