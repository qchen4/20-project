
h0_start:
init:             
                  li x0, 0xd
                  li x1, 0x95bad895
                  li x3, 0x4b59de38
                  li x4, 0xf06d696a
                  li x5, 0x80000000
                  li x6, 0x4b75dcf3
                  li x7, 0x0
                  li x9, 0xee80edc4
                  li x10, 0xf9b9db3b
                  li x11, 0x0
                  li x12, 0xa
                  li x13, 0x0
                  li x14, 0xa2685796
                  li x15, 0x9
                  li x16, 0xf5b374fd
                  li x17, 0x80000000
                  li x18, 0xf
                  li x19, 0x1f12aa7a
                  li x20, 0x3
                  li x21, 0x4
                  li x22, 0x75fa5a15
                  li x23, 0xf896e136
                  li x24, 0xf1c7cee8
                  li x25, 0x0
                  li x26, 0xfe3d0e34
                  li x27, 0xfe53f84f
                  li x28, 0x8
                  li x29, 0xd0ba9a9a
                  li x30, 0x0
                  li x31, 0xbf9bc03c
                  la x2, user_stack_end
                  csrr x26, 0x300
                  csrr x13, 0x304
                  csrw 0x300, x26
                  csrw 0x304, x13
main:             la           a1, sub_1
                  slli         tp, a7, 15
                  add          s8, s10, a0
                  addi         a1, a1, 171
                  bltu         s6, a7, main_j2 #branch to jump instr
                  slt          t1, a4, ra
                  srai         a0, s10, 26
                  divu         a5, s1, t2
                  sltiu        zero, s5, 1420
main_j2:          jalr         a7, a1, -169 #jump main -> sub_1
                  la           t5, region_0+2260 #start riscv_load_store_hazard_instr_stream_10
                  lw           a4, -23(t5)
                  sh           s10, 174(t5)
                  lhu          s6, 174(t5)
                  sh           s3, 174(t5)
                  sb           a6, 121(t5)
                  sw           a4, 121(t5)
                  sb           s0, 121(t5)
                  sw           a6, 85(t5)
                  mul          tp, s4, s11
                  sh           t3, 85(t5)
                  sw           t5, 85(t5) #end riscv_load_store_hazard_instr_stream_10
                  la           s9, region_1+21755 #start riscv_load_store_hazard_instr_stream_14
                  lh           a1, -77(s9)
                  sh           s0, -77(s9)
                  sb           t5, -77(s9)
                  csrrwi       s8, 0x342, 4
                  lhu          t0, -77(s9)
                  sw           a2, -77(s9)
                  sb           t5, -77(s9)
                  rem          t2, s9, t2
                  lw           a3, -77(s9)
                  sw           a0, -77(s9)
                  sb           zero, -77(s9)
                  lb           tp, -77(s9)
                  lbu          s2, -77(s9)
                  lh           s10, -77(s9)
                  lw           a3, -77(s9)
                  sh           t6, -77(s9)
                  lw           s6, -77(s9)
                  auipc        a3, 542460
                  lbu          tp, -77(s9)
                  sltu         s6, a5, t0
                  lhu          s3, -77(s9)
                  sw           t0, -77(s9)
                  csrrci       tp, 0x343, 9
                  sb           gp, -77(s9)
                  sw           t6, -77(s9) #end riscv_load_store_hazard_instr_stream_14
                  la           s6, region_1+29429 #start riscv_load_store_hazard_instr_stream_1
                  xor          a5, tp, t3
                  lw           s7, -11(s6)
                  lb           t5, -11(s6)
                  lhu          zero, -11(s6)
                  lb           s11, -11(s6)
                  lh           a5, 14(s6)
                  auipc        s2, 938362
                  lbu          a6, 14(s6)
                  sw           t6, 14(s6)
                  lw           a4, 14(s6)
                  sh           tp, -13(s6)
                  lh           ra, -13(s6)
                  slt          s1, s3, zero
                  sw           t6, -13(s6)
                  lbu          s4, 9(s6)
                  lbu          s7, 9(s6)
                  sb           t1, -12(s6)
                  sh           t6, -12(s6) #end riscv_load_store_hazard_instr_stream_1
                  la           a5, region_0+1025 #start riscv_load_store_hazard_instr_stream_11
                  lbu          t0, 563(a5)
                  lhu          s11, -782(a5)
                  sw           a5, -782(a5)
                  lb           a0, -782(a5)
                  csrrw        a0, 0x343, s7
                  sh           s4, -782(a5)
                  sb           s2, -328(a5)
                  lbu          a3, -328(a5)
                  sw           s6, -314(a5)
                  mulh         a2, a1, t3
                  lhu          s10, -314(a5)
                  lbu          t5, -314(a5)
                  lbu          tp, -314(a5)
                  lw           s11, -314(a5)
                  sh           t4, 226(a5)
                  lh           s7, 1374(a5)
                  sb           sp, 1374(a5)
                  lw           tp, 1374(a5)
                  lbu          a6, 1374(a5)
                  sh           t0, 1374(a5)
                  sb           gp, 1374(a5)
                  lbu          s4, 1374(a5) #end riscv_load_store_hazard_instr_stream_11
                  la           s11, region_0+2812 #start riscv_load_store_rand_instr_stream_2
                  mulhsu       s9, a7, a4
                  auipc        s5, 219560
                  or           s6, s4, a7
                  slt          t1, a4, a2
                  sltiu        a2, zero, -1190
                  andi         t4, s9, 530
                  div          a0, t0, s1
                  mulh         a5, sp, a5
                  mulhsu       a6, a5, t6
                  sw           s9, 11(s11)
                  sw           a2, 36(s11)
                  lbu          s3, -50(s11)
                  lh           s3, -54(s11)
                  add          s3, gp, s7
                  mulhsu       zero, t1, t2
                  sub          zero, s0, t0
                  rem          s7, ra, s11
                  lbu          s1, -27(s11)
                  div          t4, a1, s5
                  and          s10, a6, s7
                  sw           a5, -46(s11)
                  sll          a4, t5, a2
                  sw           s7, -47(s11)
                  mulhsu       a5, ra, a7
                  sltu         s7, ra, a3
                  sltiu        s1, zero, 1921
                  rem          s3, s7, s3
                  csrrs        s6, 0x343, zero
                  lhu          s4, -63(s11)
                  slt          t4, s2, a0
                  sltiu        t1, zero, -1090
                  sw           t5, 12(s11)
                  sw           a4, -41(s11)
                  nop
                  csrrci       s7, 0x304, 0
                  addi         zero, s7, -891
                  div          zero, s8, a3
                  lbu          a4, -17(s11)
                  lhu          zero, -14(s11) #end riscv_load_store_rand_instr_stream_2
                  la           a4, region_1+15516 #start riscv_load_store_hazard_instr_stream_4
                  lbu          a1, 8(a4)
                  lh           t4, 8(a4)
                  ori          a1, t2, -1607
                  lw           t4, 8(a4)
                  lh           a2, 8(a4)
                  lw           s1, 8(a4)
                  csrrc        a0, 0x343, zero
                  div          s11, t5, t2
                  sw           a7, 8(a4)
                  xori         t0, s11, -1813
                  slt          tp, sp, t5
                  auipc        t0, 30680
                  lhu          s2, -6(a4)
                  sb           s5, -6(a4)
                  sh           s5, 1(a4)
                  lhu          s6, 10(a4)
                  lhu          gp, 10(a4)
                  lbu          s1, 10(a4)
                  lhu          a1, 10(a4)
                  sb           tp, 10(a4)
                  lb           s7, 6(a4)
                  lh           t4, 6(a4)
                  sltiu        t4, sp, -1993
                  lb           a2, 6(a4)
                  lhu          t5, 6(a4)
                  sb           t0, -10(a4)
                  lhu          a5, 12(a4) #end riscv_load_store_hazard_instr_stream_4
                  la           s3, region_0+1608 #start load_store_instr_stream_0
                  la           s11, region_1+52984 #start load_store_instr_stream_1
                  sh           a4, -60(s3)
                  lhu          s2, -41(s11)
                  sb           a7, -57(s3)
                  sb           ra, 56(s11)
                  lh           t6, -34(s11)
                  sw           t3, 120(s3)
                  sb           s1, -16(s3)
                  sw           a7, 31(s3)
                  lbu          zero, -52(s11)
                  lb           t4, -13(s11)
                  lhu          a0, -236(s3)
                  lhu          tp, 48(s11) #end load_store_instr_stream_1
                  lh           gp, 74(s3)
                  sb           t2, 150(s3) #end load_store_instr_stream_0
                  la           s5, region_0+2866 #start riscv_load_store_hazard_instr_stream_13
                  lh           s9, 179(s5)
                  lhu          a7, -256(s5)
                  sb           t0, -18(s5)
                  sb           s8, -18(s5)
                  lhu          gp, -187(s5)
                  sh           a1, -95(s5)
                  lw           ra, -95(s5)
                  sb           t4, -95(s5)
                  lw           a2, -95(s5)
                  add          s7, s4, t0
                  lb           s4, -95(s5)
                  lb           t5, -204(s5)
                  csrrsi       s7, 0x343, 0
                  sh           t4, -26(s5)
                  sb           ra, -12(s5)
                  lhu          s4, -12(s5)
                  lh           s7, -153(s5)
                  srai         tp, s7, 30
                  lb           gp, -130(s5)
                  sh           s6, -130(s5)
                  nop
                  rem          t2, zero, t5
                  lw           s2, -130(s5)
                  csrrsi       a1, 0x304, 26
                  mulhsu       s4, t3, zero
                  lb           t2, 17(s5) #end riscv_load_store_hazard_instr_stream_13
                  la           s10, region_0+2270 #start riscv_load_store_hazard_instr_stream_8
                  auipc        s11, 155008
                  lb           t6, 465(s10)
                  lhu          t2, -279(s10)
                  lbu          s1, -475(s10)
                  lb           t0, -1460(s10)
                  lh           t4, -609(s10)
                  ori          ra, t6, -1957
                  sh           s7, -609(s10)
                  lw           ra, 1180(s10)
                  sh           s3, 131(s10)
                  lhu          t1, -1639(s10)
                  mulhsu       s3, s9, s10
                  sh           zero, -1639(s10)
                  sh           s11, 426(s10)
                  lbu          s9, -779(s10)
                  lb           s11, -779(s10)
                  mulhu        s2, t6, s9
                  sh           s9, 181(s10)
                  lw           a7, -877(s10)
                  sw           s9, -877(s10)
                  ori          s7, s6, 338
                  sh           s2, -877(s10)
                  lw           a3, -877(s10)
                  sh           ra, -877(s10)
                  sh           s6, -877(s10) #end riscv_load_store_hazard_instr_stream_8
                  la           a2, region_1+32795 #start riscv_load_store_hazard_instr_stream_16
                  sw           s2, 111(a2)
                  sb           s5, 111(a2)
                  lb           s10, 218(a2)
                  lw           gp, 218(a2)
                  sh           a3, 218(a2)
                  lbu          s5, 218(a2)
                  sb           s11, 139(a2)
                  sw           sp, 95(a2)
                  srl          t1, t2, s7
                  lh           ra, -63(a2)
                  sub          s8, s7, s10
                  sw           a0, -63(a2)
                  add          gp, t5, ra
                  sh           s2, -63(a2)
                  sb           s7, -63(a2) #end riscv_load_store_hazard_instr_stream_16
                  la           gp, region_1+53374 #start load_store_instr_stream_0
                  lhu          s10, -200(gp)
                  la           a7, region_1+50514 #start load_store_instr_stream_4
                  la           ra, region_1+27985 #start load_store_instr_stream_1
                  la           a3, region_1+42766 #start load_store_instr_stream_3
                  sb           t3, -191(a3)
                  lb           t4, 191(a3)
                  la           a5, region_1+2140 #start load_store_instr_stream_2
                  sh           t3, 1917(ra)
                  lw           s7, -230(a7)
                  sh           s5, 172(gp)
                  sb           t3, -1028(a5)
                  lb           s2, -241(a3)
                  lh           a4, 209(a7)
                  lhu          s1, -522(ra)
                  sb           ra, 795(a5)
                  sb           a2, -206(a7)
                  lb           t4, 974(ra)
                  lbu          t0, -152(gp)
                  lbu          zero, 181(gp)
                  sb           s5, 199(a3)
                  sb           a7, 128(gp)
                  lb           s11, -695(a5)
                  lbu          s2, 145(gp)
                  lb           a6, -21(a3)
                  sh           s3, 608(ra)
                  lh           s7, 1475(a5)
                  sb           s7, -30(a3)
                  lw           t1, -68(gp)
                  lbu          s3, 1109(ra)
                  lhu          s6, -144(a3)
                  sh           a6, -159(a3) #end load_store_instr_stream_3
                  sw           a7, 41(gp)
                  lh           s10, -303(ra)
                  sb           a5, -296(ra) #end load_store_instr_stream_1
                  lhu          zero, 254(a7)
                  lh           a6, 46(a7)
                  sh           s1, -215(a5) #end load_store_instr_stream_2
                  sw           s10, 24(a7)
                  lbu          s4, 11(a7) #end load_store_instr_stream_4
                  sh           s7, -210(gp) #end load_store_instr_stream_0
                  la           s7, region_0+2315 #start riscv_load_store_hazard_instr_stream_12
                  lbu          t1, 13(s7)
                  slti         t6, s7, -1998
                  lh           s9, 13(s7)
                  lbu          s1, 46(s7)
                  lbu          s5, 46(s7)
                  lh           a2, 46(s7)
                  lw           a0, 46(s7)
                  lb           a7, 46(s7)
                  sw           t5, 46(s7)
                  sh           s1, 6(s7)
                  add          a0, a2, a4
                  lhu          t6, -50(s7)
                  lb           tp, -50(s7)
                  sb           s6, -50(s7)
                  lw           t6, -50(s7) #end riscv_load_store_hazard_instr_stream_12
                  la           ra, region_1+47007 #start riscv_load_store_rand_instr_stream_15
                  lh           s3, 1481(ra)
                  add          a1, a3, zero
                  div          t4, t2, t3
                  xor          s10, a6, a4
                  lh           a0, 737(ra)
                  rem          s2, sp, s4
                  sb           gp, -1143(ra)
                  mulhsu       s10, a2, a7
                  lb           t2, 901(ra)
                  sh           sp, -1450(ra)
                  sh           a3, 1491(ra)
                  lb           s6, 1648(ra)
                  sll          t4, a7, s11
                  lh           s1, -760(ra)
                  csrrci       s7, 0x305, 0
                  lbu          t2, -509(ra)
                  csrrsi       s2, 0x301, 26
                  mulhu        tp, s2, s11
                  srl          t4, a5, a6
                  slti         s5, t1, 176
                  csrrc        a4, 0x305, zero
                  lbu          gp, -1281(ra)
                  lh           a1, 1782(ra)
                  divu         t5, s9, s8
                  auipc        gp, 523346
                  sltiu        a6, a7, 2004
                  slt          t0, s4, s11
                  divu         s11, a0, sp
                  nop
                  csrrw        a1, 0x343, t2
                  lh           a2, 38(ra)
                  sltiu        t5, t1, 1203
                  lh           a2, -1952(ra)
                  csrrc        a0, 0x301, zero
                  sra          a0, a5, s6
                  sh           a4, 1664(ra)
                  csrrci       t0, 0x304, 0
                  lui          gp, 83027
                  lbu          a1, 918(ra)
                  remu         s11, t6, s5
                  lh           tp, -394(ra)
                  lb           s2, -1139(ra)
                  xori         a3, a6, -17
                  divu         s10, a4, s9
                  lw           t5, 1802(ra)
                  sw           t3, 1555(ra)
                  slli         s2, t6, 16
                  lw           s11, -1173(ra)
                  lw           a1, -452(ra)
                  lb           a1, -1591(ra)
                  sh           gp, -1977(ra)
                  lui          t5, 585280
                  sh           gp, -104(ra)
                  lhu          t1, -1583(ra) #end riscv_load_store_rand_instr_stream_15
                  la           s8, region_0+3828 #start riscv_load_store_hazard_instr_stream_5
                  sh           s9, 4(s8)
                  sltu         a1, s4, t4
                  lbu          a3, 4(s8)
                  lw           a0, 4(s8)
                  lhu          s3, 4(s8)
                  addi         s9, s9, 486
                  sw           s4, 4(s8)
                  lb           t0, 4(s8)
                  lbu          t6, 4(s8)
                  sh           gp, 4(s8)
                  lb           s1, 5(s8)
                  mul          t1, s3, s4
                  sb           s7, -14(s8)
                  srli         t5, s4, 21
                  sub          s4, s11, s4
                  lh           gp, 6(s8)
                  sh           a0, 6(s8)
                  sh           s7, 6(s8)
                  divu         s11, s2, gp
                  sb           s9, -7(s8)
                  lhu          a0, 2(s8)
                  lhu          t6, 2(s8) #end riscv_load_store_hazard_instr_stream_5
                  la           a7, region_1+17806 #start load_store_instr_stream_1
                  lw           zero, 18(a7)
                  sb           t5, -18(a7)
                  lbu          a6, -40(a7)
                  la           a5, region_0+76 #start load_store_instr_stream_0
                  lh           s5, 63(a7)
                  sw           tp, 6(a5)
                  lbu          s2, 48(a7)
                  sw           s11, 8(a5)
                  lhu          s4, -10(a5)
                  lbu          tp, -9(a7)
                  lhu          t5, -15(a5)
                  lhu          t2, -54(a7)
                  lh           tp, 13(a5)
                  sb           t5, 61(a7)
                  lhu          s6, 17(a7)
                  sh           zero, 30(a7) #end load_store_instr_stream_1
                  lw           t6, 8(a5) #end load_store_instr_stream_0
                  la           a3, region_0+1710 #start riscv_load_store_rand_instr_stream_8
                  sh           gp, -6(a3)
                  ori          t4, a4, 244
                  sb           a2, -26(a3)
                  slli         t1, a6, 17
                  lhu          gp, 52(a3)
                  sltu         a0, s4, s1
                  lhu          s3, 12(a3)
                  slt          t1, t0, t0
                  sw           t4, 3(a3)
                  xori         a4, t0, 278
                  sra          s4, a7, s1
                  sb           t1, -64(a3)
                  div          t5, s11, s1
                  lh           a5, 13(a3)
                  sh           a6, -31(a3)
                  mul          a1, s2, t5
                  sw           t0, 30(a3)
                  csrrci       s7, 0x301, 22
                  sltiu        t2, t0, -25
                  addi         t6, a1, -1643
                  srli         s9, a0, 12
                  divu         t1, t3, sp
                  sb           a7, -55(a3)
                  lw           a6, -57(a3)
                  sltu         t0, s9, t2
                  sb           t0, -53(a3)
                  slti         s8, s8, 1932
                  slli         a2, s10, 7
                  lb           t0, 41(a3)
                  slt          a6, s11, s8
                  addi         a1, a7, 1152
                  lb           t0, 19(a3)
                  mul          s3, gp, a3
                  mulh         t2, tp, t6
                  sb           a5, 5(a3) #end riscv_load_store_rand_instr_stream_8
                  la           s4, region_0+3811 #start riscv_load_store_hazard_instr_stream_9
                  sb           a1, -59(s4)
                  sb           t6, 47(s4)
                  lw           s10, 47(s4)
                  sh           s10, 47(s4)
                  lb           a1, -57(s4)
                  mulhsu       t6, a2, sp
                  sw           s11, -57(s4)
                  lh           a0, -57(s4)
                  lb           t4, -12(s4)
                  sh           t6, -33(s4)
                  lh           s10, 60(s4)
                  sb           a4, 10(s4)
                  lb           s9, 42(s4)
                  sw           t2, 42(s4)
                  lb           a3, 8(s4)
                  sltu         s2, s2, s9
                  lh           t0, 28(s4) #end riscv_load_store_hazard_instr_stream_9
                  la           ra, region_1+45395 #start riscv_load_store_hazard_instr_stream_0
                  lw           s4, 52(ra)
                  sw           a4, 52(ra)
                  lui          s2, 280134
                  sh           t3, 52(ra)
                  lhu          a3, 52(ra)
                  lbu          tp, 52(ra)
                  sb           gp, 52(ra)
                  add          a6, t1, zero
                  lhu          gp, 52(ra)
                  sb           a2, 52(ra)
                  lhu          t2, 52(ra)
                  lbu          t0, 52(ra)
                  sh           s4, -59(ra) #end riscv_load_store_hazard_instr_stream_0
                  la           s2, region_1+64556 #start load_store_instr_stream_1
                  la           s7, region_1+10433 #start load_store_instr_stream_4
                  la           s10, region_1+8852 #start load_store_instr_stream_0
                  la           t6, region_1+19443 #start load_store_instr_stream_2
                  sw           s2, 8(s2)
                  lbu          s4, -14(s2)
                  sb           s6, -37(t6)
                  lw           a0, 54(t6)
                  lw           zero, 249(s7)
                  lhu          a1, 1443(s10)
                  la           s6, region_1+386 #start load_store_instr_stream_3
                  lh           s8, -386(s7)
                  lh           a4, -450(s10)
                  sb           s4, 7(s2)
                  lh           s1, 1751(s6)
                  sb           zero, -34(t6)
                  lhu          tp, -549(s10)
                  lbu          tp, 6(s2)
                  sw           t3, 32(t6)
                  sw           a3, -13(s2)
                  sb           ra, -148(s7)
                  sh           ra, 353(s6)
                  lhu          t2, 1933(s10)
                  lbu          s4, 704(s7)
                  lw           s5, 8(s2)
                  lbu          a6, 44(t6)
                  lhu          s3, -1752(s7)
                  sh           s11, -9(s2)
                  sh           s9, 1057(s10)
                  lh           tp, 1245(s10)
                  lw           a7, -8(s2)
                  sb           ra, 35(t6)
                  lhu          a6, -1953(s10)
                  lh           s1, 222(s6)
                  lbu          t0, -1362(s7)
                  lw           t4, 321(s6)
                  lw           s3, 12(s2)
                  sh           a1, 253(s10)
                  lhu          ra, 8(s2) #end load_store_instr_stream_1
                  lbu          t0, -12(t6) #end load_store_instr_stream_2
                  lb           a0, 1508(s6) #end load_store_instr_stream_3
                  sw           s11, 669(s7)
                  sh           s7, -1107(s7) #end load_store_instr_stream_4
                  lbu          t1, 1871(s10) #end load_store_instr_stream_0
                  la           s1, region_1+30278 #start riscv_load_store_hazard_instr_stream_3
                  lh           a4, 213(s1)
                  sb           s11, 213(s1)
                  lbu          a5, 213(s1)
                  lb           t6, -12(s1)
                  lb           a6, -12(s1)
                  lbu          a5, -12(s1)
                  lhu          tp, -12(s1)
                  lhu          s3, -30(s1)
                  sh           a6, -30(s1)
                  sb           a2, -30(s1)
                  sw           gp, -30(s1)
                  srl          s10, a0, s3
                  lb           a0, -30(s1)
                  sh           t0, -30(s1)
                  sw           a0, -30(s1)
                  lhu          a3, 102(s1)
                  lhu          ra, 102(s1)
                  lw           s4, 102(s1)
                  lh           zero, 102(s1)
                  sb           s6, 102(s1)
                  lbu          s9, 102(s1) #end riscv_load_store_hazard_instr_stream_3
                  la           a1, region_0+2468 #start load_store_instr_stream_2
                  la           gp, region_0+1794 #start load_store_instr_stream_1
                  lbu          t1, 1500(a1)
                  la           s6, region_0+105 #start load_store_instr_stream_0
                  sh           tp, -58(gp)
                  la           s4, region_0+180 #start load_store_instr_stream_3
                  la           a3, region_0+1240 #start load_store_instr_stream_4
                  sw           s1, 1092(s6)
                  sh           t4, 1205(a1)
                  lbu          s10, -107(a3)
                  lbu          s11, 37(gp)
                  lhu          t2, 347(s6)
                  lbu          a6, 1091(a1)
                  lw           s8, 115(a3)
                  lb           s2, -52(gp)
                  sb           s9, 1731(s4)
                  lw           s8, -1476(a1)
                  sh           a7, 156(gp)
                  lb           s2, 341(s4)
                  lh           a6, 1941(s6)
                  sb           s9, 503(s4)
                  lw           a7, -171(gp)
                  sh           s10, 391(s6)
                  lhu          a7, 370(a1)
                  lb           t6, 138(s6)
                  lh           s1, 1554(s6)
                  lb           s1, 594(a1)
                  lhu          s5, 1100(a1)
                  lh           t6, -209(a3)
                  sh           s11, 163(a3)
                  sb           s4, -83(gp)
                  sb           sp, -1647(a1)
                  sw           t5, 1215(s4)
                  lbu          tp, 1204(a1)
                  lw           a0, -57(a3) #end load_store_instr_stream_4
                  lbu          t4, 1306(s4)
                  lhu          a5, -108(gp) #end load_store_instr_stream_1
                  lb           s9, -1729(a1) #end load_store_instr_stream_2
                  sw           s4, 1114(s4) #end load_store_instr_stream_3
                  sh           t1, 1044(s6) #end load_store_instr_stream_0
                  la           tp, region_0+912 #start riscv_load_store_rand_instr_stream_1
                  sh           t3, -185(tp)
                  lw           a0, 33(tp)
                  lhu          zero, -106(tp)
                  or           s4, s8, s7
                  lbu          gp, -233(tp)
                  and          s8, t2, s0
                  csrrci       a0, 0x343, 13
                  srli         s5, s9, 21
                  lh           t2, 213(tp)
                  lw           zero, -148(tp)
                  csrrwi       s1, 0x342, 15
                  csrrci       a4, 0x300, 0
                  or           s11, a6, a5
                  divu         s5, gp, t0
                  andi         t0, a4, 1818
                  lb           t0, -206(tp)
                  mul          s2, s4, t6
                  lw           s4, -243(tp)
                  lbu          a7, 111(tp)
                  srli         s5, s5, 14
                  or           t4, s5, t3
                  mulhsu       s7, t3, a4
                  sll          s8, ra, s4
                  lhu          a6, -207(tp)
                  lw           t6, -180(tp)
                  remu         s5, s10, gp
                  lbu          a2, -129(tp)
                  sltu         s3, s5, s11
                  sw           a1, -86(tp)
                  sw           a3, -18(tp)
                  lh           a1, -100(tp)
                  sw           t1, 250(tp)
                  lw           s5, -77(tp)
                  sra          gp, sp, s11
                  srli         t0, s9, 11
                  sltiu        t1, s5, 69
                  csrrci       t6, 0x301, 19
                  lhu          s9, -93(tp)
                  lbu          a7, -243(tp)
                  sltu         s1, a5, s11
                  lw           a3, 100(tp)
                  srai         s5, s2, 23
                  sltiu        a1, a2, 1432
                  lw           t1, -4(tp)
                  nop
                  sb           s3, -230(tp) #end riscv_load_store_rand_instr_stream_1
                  la           t5, region_1+36711 #start riscv_load_store_rand_instr_stream_16
                  sb           tp, 46(t5)
                  andi         s1, a7, -137
                  csrrs        s7, 0x300, zero
                  sw           s3, 30(t5)
                  lbu          ra, 64(t5)
                  slli         gp, sp, 19
                  lb           a2, 16(t5)
                  lw           gp, -23(t5)
                  lhu          s9, 32(t5)
                  lhu          t1, 4(t5)
                  nop
                  lhu          s7, 32(t5)
                  rem          t1, t1, a0
                  lh           a6, -54(t5)
                  sh           s9, 23(t5)
                  sltiu        s3, a4, 1021
                  addi         s7, a6, 399
                  mulhu        s10, s7, a7
                  lhu          a2, -26(t5)
                  sh           s0, -29(t5)
                  lhu          a5, 47(t5)
                  sw           a3, -14(t5)
                  lh           s9, -11(t5)
                  div          t4, t5, tp
                  add          s3, a7, a4
                  slt          ra, t4, s9
                  sb           s3, 3(t5)
                  and          t6, a0, t2
                  sw           s9, -37(t5)
                  addi         a7, a7, 1017
                  csrrwi       t6, 0x304, 10
                  lb           s3, 42(t5) #end riscv_load_store_rand_instr_stream_16
                  la           a7, region_1+21368 #start riscv_load_store_hazard_instr_stream_15
                  lw           t2, -15(a7)
                  sh           t1, -15(a7)
                  lbu          t4, -15(a7)
                  sw           t1, -15(a7)
                  sh           a0, -15(a7)
                  sh           s7, -15(a7)
                  sh           a3, -15(a7)
                  lh           t0, -15(a7)
                  csrrci       a4, 0x342, 15
                  xor          t1, a5, zero
                  lhu          s7, 1(a7)
                  lhu          s3, 1(a7)
                  sh           s0, 1(a7)
                  andi         ra, tp, -1335
                  sh           a0, -8(a7)
                  lbu          tp, -8(a7)
                  addi         s8, s10, -1925
                  lh           a6, -8(a7)
                  srl          s5, a7, s5
                  sw           tp, -15(a7) #end riscv_load_store_hazard_instr_stream_15
                  la           s2, region_1+27388 #start riscv_load_store_rand_instr_stream_13
                  nop
                  auipc        a3, 307569
                  slti         t1, ra, -1533
                  lw           s7, -2018(s2)
                  csrrwi       t0, 0x343, 11
                  sll          s11, s10, sp
                  csrrsi       zero, 0x342, 15
                  lbu          s7, 1816(s2)
                  sltu         s3, a6, t1
                  sb           s0, 896(s2)
                  lbu          a1, -272(s2)
                  srli         a0, sp, 21
                  sh           t2, -941(s2)
                  csrrs        s6, 0x301, zero
                  lh           s4, 765(s2)
                  csrrsi       s1, 0x301, 3
                  lhu          s10, -1281(s2)
                  slli         t2, s3, 9
                  csrrc        s4, 0x342, a4
                  csrrci       s11, 0x301, 27
                  csrrsi       a2, 0x301, 0
                  lhu          t4, -1673(s2)
                  xori         gp, t2, 935
                  xor          s9, a0, s3
                  lb           s4, -1100(s2)
                  lhu          s9, 592(s2)
                  lh           t0, 119(s2)
                  rem          s9, t6, t3
                  srai         s5, s4, 15
                  rem          s1, a4, t3
                  or           tp, t4, a1
                  sub          s9, t3, t6
                  srl          a0, zero, a3
                  lui          t6, 486701
                  lhu          gp, -340(s2)
                  sb           a5, -1682(s2)
                  lbu          t6, -1824(s2)
                  sub          t6, a1, s0
                  lhu          s4, -23(s2)
                  div          s5, a1, a4
                  sh           s4, -1338(s2)
                  sb           a5, 1350(s2)
                  csrrc        s7, 0x305, zero
                  lh           t1, -830(s2)
                  auipc        a2, 812039
                  sh           s8, 1557(s2)
                  mulhsu       s3, s5, s8
                  srai         s10, s3, 30
                  ori          a1, s3, 640
                  lh           s3, -991(s2) #end riscv_load_store_rand_instr_stream_13
                  la           a1, region_1+51989 #start riscv_load_store_hazard_instr_stream_7
                  slli         zero, t2, 9
                  sh           a7, -4(a1)
                  lbu          t1, -4(a1)
                  lhu          a7, -13(a1)
                  sw           a1, -13(a1)
                  lhu          gp, -13(a1)
                  add          a3, a1, a1
                  lhu          s5, -13(a1)
                  lbu          s9, -13(a1)
                  lbu          t2, -13(a1)
                  lbu          tp, -13(a1)
                  sh           s7, -13(a1)
                  lh           t0, -13(a1)
                  lb           s3, -13(a1)
                  lbu          t5, -13(a1)
                  sw           a0, 14(a1)
                  sw           gp, 14(a1) #end riscv_load_store_hazard_instr_stream_7
                  la           s11, region_1+18928 #start load_store_instr_stream_0
                  la           s7, region_0+3761 #start load_store_instr_stream_1
                  sb           t1, -15(s11)
                  lh           a7, -15(s7)
                  sb           s5, -6(s11)
                  sb           gp, 2(s7)
                  lbu          t4, -10(s7)
                  lw           s1, 1(s11)
                  sb           a2, -14(s7)
                  lbu          a7, -14(s11)
                  sh           s6, 14(s7)
                  lhu          a0, -6(s7)
                  lh           a3, 12(s11)
                  lh           s8, 3(s11)
                  lb           s4, 16(s11)
                  sw           s7, -4(s7)
                  lbu          s2, -2(s7)
                  lw           s6, -2(s7) #end load_store_instr_stream_1
                  sw           a5, -1(s11)
                  lh           s3, 3(s11) #end load_store_instr_stream_0
                  la           s10, region_0+3368 #start riscv_load_store_rand_instr_stream_5
                  mulhu        a5, a6, a3
                  lui          t0, 805638
                  slt          a4, a0, ra
                  nop
                  auipc        s6, 896684
                  lhu          s8, -231(s10)
                  sll          s11, a0, a4
                  sra          a3, tp, s0
                  sh           s8, -1489(s10)
                  addi         a2, a3, 1218
                  xor          t6, s7, a0
                  lw           gp, 591(s10)
                  csrrwi       s4, 0x304, 18
                  slli         s7, s11, 7
                  csrrci       t1, 0x300, 0
                  lbu          ra, -1423(s10)
                  csrrci       s3, 0x301, 0
                  divu         t6, t0, t5
                  sb           s0, -934(s10)
                  lh           a6, -1658(s10)
                  remu         t4, s6, tp
                  lh           a6, 295(s10)
                  slt          tp, tp, s3
                  xori         t4, t5, 1625
                  lhu          t1, -451(s10)
                  sll          a3, t2, a7
                  rem          ra, s11, t6
                  slli         s4, s6, 31
                  sh           s11, -1614(s10)
                  lhu          a3, 361(s10)
                  add          s3, t5, t2
                  sh           s6, -1821(s10)
                  lbu          s3, -1044(s10)
                  slt          s5, s5, a5
                  sw           s0, -152(s10)
                  nop
                  sh           t1, 483(s10)
                  sw           a3, -777(s10)
                  csrrsi       zero, 0x342, 8
                  sb           t2, 591(s10)
                  add          t6, s0, s9
                  csrrwi       a2, 0x343, 5
                  lw           t0, 454(s10)
                  lbu          a6, -828(s10)
                  andi         s8, s6, 1522
                  lw           a5, -446(s10) #end riscv_load_store_rand_instr_stream_5
                  la           a0, region_0+2361 #start load_store_instr_stream_1
                  lh           gp, 1481(a0)
                  la           a3, region_1+40037 #start load_store_instr_stream_0
                  lhu          s1, 936(a0)
                  lhu          ra, -1513(a0)
                  lh           t2, -125(a3)
                  lh           a7, 134(a3)
                  sh           s8, 588(a0)
                  sh           t0, 1146(a0)
                  sb           a2, -201(a0)
                  lh           ra, -116(a3)
                  sb           s11, 159(a3)
                  lw           a6, -133(a3)
                  sh           s5, 1594(a0)
                  lb           s2, -164(a3)
                  lh           t4, 23(a3)
                  sw           t6, 234(a0)
                  sh           s9, 1249(a0)
                  lbu          a5, 13(a3)
                  lhu          s1, -24(a3)
                  sw           s11, -1046(a0) #end load_store_instr_stream_1
                  lw           t1, -139(a3) #end load_store_instr_stream_0
                  la           s8, region_1+65194 #start riscv_load_store_rand_instr_stream_10
                  lb           s3, 14(s8)
                  sw           a7, 34(s8)
                  and          s6, sp, a1
                  lbu          s10, 51(s8)
                  lw           t2, -227(s8)
                  sw           s10, 105(s8)
                  slt          s7, a2, gp
                  auipc        a1, 52656
                  sh           s7, 224(s8)
                  lhu          t6, 222(s8)
                  sb           ra, 201(s8)
                  sub          a7, s10, a5
                  lw           a4, 183(s8)
                  lb           a7, 178(s8)
                  sh           a0, -106(s8)
                  lb           t2, 182(s8)
                  lhu          t1, 189(s8)
                  lbu          s4, 61(s8)
                  lb           a5, 205(s8)
                  lhu          s5, 160(s8)
                  slt          gp, s10, s7
                  lh           s1, 57(s8)
                  lhu          a0, 97(s8)
                  srai         a1, zero, 26
                  sw           t3, 163(s8)
                  lh           t4, 187(s8)
                  mulhu        s7, a6, t4
                  andi         a4, t1, 1762
                  sb           s4, 48(s8)
                  mulh         a3, t1, t1
                  sh           a4, -53(s8)
                  xor          a1, s0, ra
                  lbu          zero, -204(s8) #end riscv_load_store_rand_instr_stream_10
                  la           s8, region_1+62292 #start riscv_load_store_rand_instr_stream_7
                  rem          s5, s8, a6
                  addi         s4, a7, -892
                  remu         zero, t3, a0
                  lhu          zero, -576(s8)
                  lb           a1, -467(s8)
                  sb           t6, -1105(s8)
                  xori         t6, s2, -174
                  sw           t0, -234(s8)
                  sw           t6, -1357(s8)
                  lh           s5, 538(s8)
                  srai         a3, t4, 14
                  lbu          tp, 1659(s8)
                  sb           tp, 1555(s8)
                  sra          s1, a4, zero
                  mulh         ra, a4, tp
                  srai         t4, s3, 8
                  mulhsu       s4, s11, ra
                  srai         s11, sp, 15
                  xor          a1, zero, t0
                  lw           s10, -344(s8)
                  lhu          t6, -1902(s8) #end riscv_load_store_rand_instr_stream_7
                  la           s4, region_0+1718 #start riscv_load_store_hazard_instr_stream_2
                  and          ra, s10, s1
                  sb           a6, 15(s4)
                  sub          ra, tp, t0
                  lbu          a7, -236(s4)
                  and          s6, s2, gp
                  lh           a2, -236(s4)
                  sh           sp, 120(s4)
                  sb           a2, -143(s4)
                  lh           gp, 220(s4)
                  lbu          s8, 8(s4)
                  lhu          ra, -162(s4)
                  lbu          t0, 153(s4)
                  csrrs        a2, 0x343, zero
                  auipc        s8, 836023
                  lh           gp, -117(s4)
                  lw           t5, 200(s4)
                  lb           s5, 121(s4)
                  sh           s9, -77(s4)
                  lh           tp, -77(s4) #end riscv_load_store_hazard_instr_stream_2
                  la           s7, region_1+29573 #start riscv_load_store_rand_instr_stream_12
                  csrrsi       s5, 0x305, 0
                  slt          zero, a1, s2
                  sw           t3, -39(s7)
                  divu         ra, a1, a2
                  lui          s8, 241706
                  srl          gp, a5, tp
                  srai         a1, s2, 20
                  csrrw        s9, 0x304, t2
                  lbu          s11, 13(s7)
                  rem          s10, a4, tp
                  lb           a1, 43(s7)
                  slti         a6, zero, 1284
                  lb           s1, -27(s7)
                  add          t2, s5, a3
                  mulh         gp, s4, s6
                  rem          s1, t4, s9
                  sh           a7, 56(s7)
                  lw           s4, -18(s7)
                  addi         s8, tp, -586
                  lb           s11, 7(s7)
                  sb           t4, 34(s7)
                  sub          a5, s0, s9
                  mul          a1, s4, s5
                  slli         s3, t2, 26
                  lbu          t5, -36(s7)
                  sb           s4, -58(s7)
                  lw           a6, -51(s7)
                  csrrsi       gp, 0x304, 1
                  andi         t4, s0, 823
                  srai         zero, t2, 5
                  lbu          tp, 54(s7) #end riscv_load_store_rand_instr_stream_12
                  la           s2, region_1+26276 #start riscv_load_store_rand_instr_stream_14
                  and          s10, ra, s8
                  mulh         s6, s3, s7
                  lh           s7, 10(s2)
                  sb           t1, 16(s2)
                  csrrsi       t0, 0x304, 24
                  lbu          t1, 9(s2)
                  csrrwi       a7, 0x343, 29
                  div          a3, t5, a2
                  and          a4, s5, s10
                  andi         s11, t0, 1171
                  slli         a6, gp, 1
                  nop
                  slt          gp, a7, s10
                  csrrsi       s8, 0x301, 31
                  sh           s1, 0(s2)
                  slt          t0, s8, s0
                  csrrc        t0, 0x300, zero
                  sh           a3, 0(s2)
                  remu         s11, t1, s7
                  sb           a3, 12(s2)
                  sw           s3, 12(s2)
                  lw           a2, 11(s2)
                  sltu         s4, t2, zero
                  sw           s2, 9(s2)
                  lw           s11, -4(s2)
                  xori         a7, a0, -1173
                  xor          zero, a6, s6
                  csrrwi       a6, 0x343, 10
                  sw           s8, -11(s2)
                  sb           a7, -9(s2)
                  sw           s8, 2(s2) #end riscv_load_store_rand_instr_stream_14
                  la           t6, region_1+51315 #start riscv_load_store_rand_instr_stream_6
                  auipc        s2, 1018186
                  lb           a6, -239(t6)
                  auipc        t1, 697668
                  srli         s1, a0, 16
                  lw           a3, 107(t6)
                  lh           s5, 9(t6)
                  lb           t2, -182(t6)
                  lh           s3, -136(t6)
                  sltiu        s2, s0, 1834
                  csrrw        a4, 0x343, t1
                  rem          s10, gp, zero
                  sw           a5, -43(t6)
                  slli         a1, s6, 0
                  lbu          a5, -128(t6)
                  sh           sp, -74(t6)
                  sltiu        a2, a7, 1369
                  and          s2, ra, a7
                  lbu          s6, -145(t6)
                  sw           zero, 154(t6)
                  lw           t0, 36(t6)
                  sb           a7, -115(t6)
                  lw           s4, -22(t6)
                  csrrwi       ra, 0x342, 4
                  lbu          a2, 171(t6)
                  lw           a4, -198(t6)
                  csrrci       a7, 0x342, 22
                  lui          t2, 123446
                  lw           s10, 192(t6)
                  lw           s4, -82(t6)
                  or           a1, t2, s6
                  sw           a0, 153(t6)
                  sw           a5, -15(t6)
                  lbu          s4, -107(t6)
                  lhu          tp, -39(t6)
                  mulhu        a5, s2, t3
                  srl          s9, a3, gp
                  lh           s4, 69(t6)
                  xori         a0, s6, 523
                  sb           s11, 84(t6)
                  xor          s5, ra, s2
                  auipc        zero, 837993
                  lw           a6, -84(t6)
                  lb           s6, -227(t6)
                  csrrs        a0, 0x305, zero
                  sh           s3, -118(t6) #end riscv_load_store_rand_instr_stream_6
                  la           a6, region_0+608 #start riscv_load_store_rand_instr_stream_4
                  lw           s3, -9(a6)
                  csrrc        a1, 0x342, zero
                  lw           a1, 39(a6)
                  lhu          s10, -8(a6)
                  lhu          a1, -16(a6)
                  lhu          a0, -24(a6)
                  sltu         s5, t4, s7
                  lb           t2, 24(a6)
                  sll          s3, s2, tp
                  sb           s2, -36(a6)
                  addi         s7, s2, 346
                  lhu          s6, 20(a6)
                  csrrsi       s7, 0x301, 4
                  lb           t4, 46(a6)
                  lbu          s6, 4(a6)
                  sltu         t4, s2, t3
                  sh           t0, -8(a6)
                  srli         a7, sp, 6
                  lbu          s3, 21(a6)
                  lui          t6, 155631
                  csrrw        s4, 0x343, s3
                  ori          t2, a3, 218
                  lbu          s4, -44(a6)
                  lh           ra, 28(a6)
                  lh           t4, 48(a6)
                  sh           s1, 17(a6)
                  sltiu        t1, t1, 1728
                  add          a3, t4, t0
                  srai         s5, a3, 18
                  lw           a4, 28(a6)
                  sub          s1, s0, zero
                  andi         s1, tp, -135
                  slti         s2, s7, -952
                  sltu         s4, s7, a2
                  divu         t1, zero, tp
                  csrrci       s7, 0x342, 5
                  mulhsu       s3, s3, a2
                  sh           s8, 43(a6)
                  or           t2, s10, ra
                  lh           s8, -45(a6)
                  mulhu        ra, ra, a2
                  divu         s8, a1, t2
                  sw           t1, -5(a6)
                  sh           s10, 62(a6)
                  lh           gp, -14(a6)
                  lhu          s3, 28(a6) #end riscv_load_store_rand_instr_stream_4
                  la           s10, region_1+25000 #start riscv_load_store_hazard_instr_stream_6
                  lbu          s6, 12(s10)
                  sh           s5, 12(s10)
                  sb           sp, 12(s10)
                  sb           t3, 2(s10)
                  sb           tp, 2(s10)
                  lh           s8, 2(s10)
                  sh           s9, -2(s10)
                  addi         s8, a6, -1995
                  add          a2, s6, a5
                  sltiu        a3, t4, 650
                  lbu          s9, -2(s10)
                  lw           a2, -14(s10)
                  lbu          t0, 16(s10)
                  sw           s9, 16(s10)
                  lb           a6, 3(s10)
                  mulhu        a2, a2, s1
                  lbu          gp, 3(s10)
                  csrrci       a4, 0x343, 0
                  lw           t1, 3(s10)
                  lh           t1, 3(s10)
                  lhu          s7, -6(s10)
                  sh           a6, -16(s10) #end riscv_load_store_hazard_instr_stream_6
                  la           ra, region_0+1 #start riscv_load_store_rand_instr_stream_0
                  andi         a6, t2, -1749
                  nop
                  andi         gp, a0, -1770
                  sh           a6, 12(ra)
                  xori         s1, s0, 731
                  lhu          s10, 12(ra)
                  lh           s4, 2(ra)
                  srl          t4, t3, t6
                  or           a4, t3, s7
                  lhu          a0, 8(ra)
                  and          a5, a0, sp
                  and          a0, t3, s8
                  srli         a4, a0, 25
                  csrrc        t2, 0x342, s4
                  addi         a7, s6, -1195
                  andi         t0, sp, -522
                  addi         s7, s9, 1478
                  add          s5, s7, t6
                  sw           a6, -1(ra)
                  lb           s6, 0(ra)
                  xori         s5, s10, 561
                  sh           s2, 11(ra)
                  lbu          a5, 16(ra)
                  lbu          a2, 10(ra)
                  lh           s9, 15(ra)
                  sltiu        s2, t1, 1451
                  srli         a4, gp, 5
                  or           a1, gp, a0
                  lw           zero, 15(ra)
                  csrrc        s3, 0x300, zero
                  srl          t5, a3, t3
                  sub          tp, s9, s9
                  sub          gp, a4, s9
                  csrrsi       a5, 0x304, 13
                  sltiu        t2, s1, -1885
                  sh           t6, 12(ra) #end riscv_load_store_rand_instr_stream_0
                  la           s10, region_1+24828 #start riscv_load_store_rand_instr_stream_3
                  lhu          s6, 1302(s10)
                  csrrs        gp, 0x342, zero
                  sltiu        s8, s8, -379
                  srli         a5, a2, 21
                  csrrsi       s2, 0x301, 22
                  slli         s3, t4, 11
                  add          t0, s5, a1
                  sh           s0, 896(s10)
                  sub          a4, t0, t4
                  sltu         a2, sp, t3
                  mulh         s8, s5, gp
                  and          t6, sp, s0
                  sh           s10, -1705(s10)
                  sub          t1, tp, t5
                  lui          s7, 363318
                  srli         gp, t2, 15
                  lw           a0, 1447(s10)
                  sb           s6, -1332(s10)
                  lw           s1, 835(s10)
                  ori          s4, t1, 606
                  lhu          t0, 2016(s10)
                  csrrsi       tp, 0x342, 7
                  lh           a7, -796(s10)
                  csrrc        t0, 0x342, t1
                  sw           s9, -1829(s10)
                  sb           s10, -721(s10)
                  csrrs        t6, 0x305, zero
                  sh           a1, -1196(s10)
                  slt          s11, ra, s8
                  xor          ra, tp, s1
                  sh           t4, 953(s10)
                  add          s2, sp, t3
                  sb           s10, -57(s10)
                  sw           t2, -105(s10)
                  sh           s10, -1614(s10)
                  sw           a1, -449(s10)
                  lbu          s2, -437(s10)
                  addi         zero, t4, -97
                  slti         s9, ra, -439
                  sw           s8, -58(s10)
                  sb           t3, 677(s10)
                  lhu          s9, 565(s10) #end riscv_load_store_rand_instr_stream_3
                  la           s9, region_0+638 #start riscv_load_store_rand_instr_stream_9
                  sltiu        ra, a3, -112
                  add          a3, t6, s11
                  csrrsi       t6, 0x304, 2
                  sw           a4, -18(s9)
                  csrrs        a4, 0x304, zero
                  xori         t1, t0, -1601
                  auipc        a2, 1001713
                  lh           a4, -51(s9)
                  mul          s10, s5, s4
                  lb           t4, 56(s9)
                  remu         a7, sp, t6
                  sb           a3, -63(s9)
                  lh           t4, 43(s9)
                  divu         gp, gp, t5
                  add          s4, s0, gp
                  sb           zero, 31(s9)
                  sw           tp, 39(s9)
                  csrrsi       t2, 0x342, 0
                  sb           zero, -41(s9)
                  csrrc        a5, 0x305, zero
                  lh           t5, 2(s9)
                  sb           tp, -26(s9)
                  csrrsi       tp, 0x304, 0
                  lbu          a0, -13(s9)
                  mulhu        a4, a2, a1
                  div          a6, s1, s8
                  csrrsi       s8, 0x342, 4
                  mulh         s4, s4, s0
                  lw           a7, -19(s9)
                  sll          a2, t4, a1
                  sh           t1, 16(s9)
                  lbu          zero, 42(s9)
                  sll          t1, s9, t3
                  lh           zero, -4(s9)
                  sb           s9, 54(s9)
                  remu         a1, s7, s11
                  sw           a5, -29(s9)
                  or           t1, s7, t6
                  mulh         s6, a5, s6
                  sub          t2, a2, t6
                  lhu          a2, -7(s9)
                  lhu          t0, -12(s9)
                  sb           a1, 23(s9)
                  addi         t5, zero, -1647
                  lbu          t2, 7(s9)
                  csrrsi       t4, 0x305, 0
                  csrrc        a3, 0x305, zero
                  add          a3, a6, a3
                  slt          zero, tp, a5
                  lhu          t2, -52(s9)
                  sb           gp, -46(s9)
                  lb           ra, -7(s9) #end riscv_load_store_rand_instr_stream_9
                  la           t6, region_0+1821 #start riscv_load_store_rand_instr_stream_11
                  sw           s11, 19(t6)
                  add          t0, zero, t5
                  mulhu        s1, ra, s6
                  srl          s5, t6, s1
                  lb           t4, 10(t6)
                  lb           t5, 30(t6)
                  or           ra, ra, ra
                  lh           s6, 62(t6)
                  div          zero, tp, a0
                  lbu          s11, -61(t6)
                  srai         a0, gp, 5
                  divu         a1, a6, gp
                  lb           s9, 35(t6)
                  sh           s0, 53(t6)
                  remu         s4, a0, a5
                  lh           a5, -58(t6)
                  srai         s8, s1, 9
                  addi         s10, a3, -807
                  slti         s8, ra, -1198
                  csrrc        ra, 0x304, zero
                  lh           s2, -35(t6)
                  sh           s1, -35(t6)
                  mul          t1, s11, s2
                  ori          s7, s0, 1096
                  rem          s5, t0, a0
                  sub          a7, a4, sp
                  mulhu        s9, t4, s1
                  or           a5, a0, a1
                  xor          a5, a6, s4
                  mulhu        a1, a6, a4
                  slti         a6, s2, 74
                  or           s1, s8, t1
                  lui          a2, 533918
                  lh           a2, -36(t6)
                  slt          s10, t2, s5
                  slti         t2, t0, -598
                  mulh         s1, t3, a5
                  sw           s8, -55(t6)
                  lhu          ra, -56(t6) #end riscv_load_store_rand_instr_stream_11
0:                xor          gp, t6, s1
1:                lui          a5, 977913
2:                sub          t0, t2, a1
3:                slt          a5, a1, s4
4:                sltiu        a4, t1, -1641
5:                blt          s5, t4, 20f
6:                div          a0, a2, a6
7:                bgeu         tp, a1, 25f
8:                or           s11, ra, a2
9:                addi         s10, s10, 574
10:               xor          s10, s3, s4
11:               bne          a4, a5, 27f
12:               auipc        s1, 850829
13:               bge          a2, a2, 27f
14:               divu         t6, a4, a0
15:               or           tp, s8, s9
16:               ori          s1, ra, 1878
17:               bne          t2, tp, 37f
18:               csrrc        a0, 0x342, sp
19:               mulh         a0, a0, t4
20:               nop
21:               slti         a3, s2, -1281
22:               sub          s5, s8, t4
23:               bne          gp, a0, 38f
24:               mulhsu       a0, a0, tp
25:               mulh         s8, t2, s1
26:               csrrci       s9, 0x305, 0
27:               srl          t6, a5, t2
28:               csrrc        s10, 0x305, zero
29:               lui          s10, 707513
30:               mul          a0, t2, a2
31:               slti         zero, s6, 504
32:               slti         gp, a4, -448
33:               and          a5, sp, t6
34:               bltu         s4, t3, 38f
35:               sra          t0, s11, a3
36:               andi         t2, a1, 342
37:               mulhu        a5, s0, s3
38:               slli         s7, a4, 7
39:               addi         t2, t6, 225
40:               lui          zero, 278584
41:               nop
42:               add          t5, a6, s0
43:               bge          t6, s4, 61f
44:               csrrsi       s6, 0x300, 0
45:               bltu         s10, t6, 64f
46:               csrrc        s3, 0x343, gp
47:               csrrwi       a6, 0x342, 3
48:               csrrw        a4, 0x301, sp
49:               srl          ra, s4, t1
50:               sltiu        s7, sp, 994
51:               sub          t5, tp, s11
52:               lui          s11, 799259
53:               mulh         s1, s9, a5
54:               srli         t2, t1, 23
55:               sra          t2, s1, t1
56:               bgeu         a6, t1, 61f
57:               sltiu        s5, t0, 1421
58:               srl          s4, a0, t3
59:               slti         s8, t6, 1342
60:               slt          gp, s10, s5
61:               nop
62:               csrrsi       s8, 0x301, 27
63:               ori          a3, s0, 500
64:               ori          s6, t3, -1661
65:               csrrc        s3, 0x343, a3
66:               sltiu        a1, zero, -116
67:               sll          zero, s4, a4
68:               csrrwi       a7, 0x304, 14
69:               slli         s11, s3, 21
70:               add          zero, a0, t0
71:               mulh         zero, a6, s3
72:               addi         s5, t5, -111
73:               or           t5, t2, s8
74:               and          s11, ra, a4
75:               div          t5, zero, a7
76:               mul          a7, s11, sp
77:               bne          s5, s0, 97f
78:               sub          a3, a3, s11
79:               and          ra, t0, t3
80:               lui          t1, 44202
81:               csrrc        a4, 0x342, a2
82:               mulh         tp, a1, a5
83:               sra          t1, t6, s9
84:               xori         s7, tp, -1924
85:               slli         t0, t3, 2
86:               xor          gp, t5, t1
87:               mulhsu       t4, s10, t1
88:               mulhu        s7, zero, t2
89:               rem          s4, s6, a6
90:               mulhu        s11, t6, ra
91:               sltu         a6, s11, s3
92:               auipc        zero, 828852
93:               slt          a6, a6, s0
94:               addi         a7, s5, 166
95:               lui          s1, 225644
96:               lui          a4, 415691
97:               csrrci       s5, 0x300, 0
98:               sltiu        a2, gp, 1601
99:               csrrs        s10, 0x305, zero
100:              beq          s11, s8, 104f
101:              andi         a2, s7, 99
102:              lui          a4, 995781
103:              add          t4, t6, s5
104:              nop
105:              srl          s5, a3, t2
106:              csrrs        s11, 0x342, zero
107:              mul          a2, t3, t3
108:              xori         a5, a2, 333
109:              or           t5, t2, t3
110:              sub          a0, s9, a3
111:              csrrw        s9, 0x342, a2
112:              rem          a5, a2, s2
113:              srli         s2, ra, 27
114:              slt          zero, s4, s9
115:              andi         s3, t1, 475
116:              remu         t6, s1, s0
117:              slli         s10, a4, 13
118:              blt          s10, t1, 132f
119:              mulhu        s8, t1, s1
120:              xor          t0, s3, t3
121:              sll          s5, gp, tp
122:              div          s3, a1, s11
123:              xori         t1, s6, -1110
124:              sltu         s9, t1, t5
125:              addi         t1, a0, 581
126:              csrrs        s1, 0x301, zero
127:              andi         a1, zero, -849
128:              bne          a4, s5, 135f
129:              auipc        a6, 267580
130:              srl          a6, gp, t2
131:              slti         t0, s2, 2028
132:              addi         s7, a3, 926
133:              srl          a7, a0, t1
134:              csrrwi       zero, 0x342, 23
135:              sra          a1, t3, a6
136:              mulhsu       t6, s10, a1
137:              divu         t5, s4, a0
138:              sltiu        t5, a0, -193
139:              csrrsi       a0, 0x342, 0
140:              csrrsi       s5, 0x300, 0
141:              addi         s8, s8, -2024
142:              xor          a7, s4, s4
143:              srai         t4, t5, 11
144:              divu         t6, s1, t0
145:              srli         a6, a2, 6
146:              add          a7, t0, a1
147:              andi         a2, t6, -228
148:              andi         zero, s11, -1761
149:              remu         t6, a5, s9
150:              remu         s9, a3, s5
151:              or           a1, a3, t3
152:              rem          s8, a0, t3
153:              mul          s7, t1, t3
154:              or           s5, t1, tp
155:              and          s1, a6, t3
156:              slli         t2, gp, 29
157:              bne          s3, s0, 176f
158:              slli         ra, s10, 30
159:              nop
160:              sltiu        s5, s1, 17
161:              sub          s4, t3, tp
162:              andi         t6, t4, 1376
163:              srl          a0, t6, s7
164:              sltu         a3, t4, a6
165:              slti         a2, t2, 1640
166:              beq          a7, t1, 167f
167:              sll          t2, a3, tp
168:              bne          a2, a6, 187f
169:              slli         t5, s6, 24
170:              mulh         s1, s7, a0
171:              sll          s2, s3, a5
172:              remu         a1, a7, a5
173:              div          a0, s5, a4
174:              bltu         t1, s2, 181f
175:              bgeu         s11, s8, 185f
176:              csrrs        a0, 0x301, zero
177:              blt          sp, s5, 194f
178:              div          s8, t6, s4
179:              auipc        ra, 247342
180:              bne          s1, a6, 189f
181:              slti         zero, a6, 1165
182:              or           gp, zero, a3
183:              csrrci       gp, 0x342, 0
184:              div          s7, s1, tp
185:              sll          s9, t4, gp
186:              bgeu         s11, a4, 205f
187:              remu         s3, s11, a0
188:              sltiu        a5, gp, 48
189:              blt          s7, t2, 203f
190:              and          a5, t2, a4
191:              sll          s7, s9, s11
192:              sltu         a4, zero, a2
193:              divu         a2, s9, ra
194:              csrrs        a6, 0x304, zero
195:              andi         s6, sp, 376
196:              sltiu        s11, sp, -720
197:              sltu         a5, s9, t2
198:              srl          a7, sp, s6
199:              csrrsi       a1, 0x343, 14
200:              csrrw        s9, 0x343, t3
201:              blt          s11, zero, 218f
202:              sra          s8, t5, s9
203:              and          a2, a2, a1
204:              mulhu        s3, ra, ra
205:              sll          tp, s2, s10
206:              sltiu        a6, a0, 626
207:              nop
208:              bltu         t2, gp, 216f
209:              auipc        ra, 667562
210:              csrrsi       t2, 0x304, 0
211:              srli         t1, s6, 17
212:              divu         t1, t0, t0
213:              csrrw        t2, 0x342, sp
214:              sltu         s11, s3, zero
215:              ori          t6, t2, -1454
216:              and          t6, t1, t0
217:              sub          s6, s11, s9
218:              mulh         t6, s7, s2
219:              mulhu        a4, s10, s8
220:              sll          s1, gp, a0
221:              sub          t6, ra, a6
222:              slli         s6, s5, 20
223:              csrrs        s10, 0x300, zero
224:              auipc        t6, 668846
225:              rem          s5, s2, t2
226:              xor          gp, zero, s2
227:              xori         a3, s1, -972
228:              csrrc        s7, 0x304, s10
229:              auipc        a5, 375942
230:              csrrci       t6, 0x300, 0
231:              divu         s6, t1, s5
232:              bgeu         s9, t2, 251f
233:              csrrwi       t1, 0x304, 31
234:              bgeu         t6, t2, 239f
235:              blt          s9, s2, 241f
236:              xori         t5, t6, 109
237:              addi         a7, a1, -853
238:              csrrci       a7, 0x301, 0
239:              and          gp, a0, t0
240:              slt          s10, s2, s2
241:              andi         s8, t3, 1030
242:              csrrw        s7, 0x304, a0
243:              xor          s1, a1, s2
244:              or           a1, t5, a7
245:              bne          s11, a1, 253f
246:              ori          t1, s1, 879
247:              andi         a5, s8, -920
248:              bge          s6, a2, 251f
249:              divu         t0, t5, s11
250:              addi         t6, t2, 959
251:              or           s2, t0, s10
252:              xor          t0, s2, s10
253:              xor          a7, s9, t2
254:              nop
255:              srl          a6, t5, a3
256:              srai         zero, ra, 31
257:              rem          a5, t6, a0
258:              srli         s5, gp, 11
259:              slli         t6, s3, 16
260:              lui          s3, 844459
261:              csrrw        s11, 0x343, s4
262:              div          tp, s4, gp
263:              bne          t2, s3, 282f
264:              sub          t4, a1, s4
265:              mulhu        s2, s9, s9
266:              addi         s4, s1, -2016
267:              divu         a1, s2, a2
268:              sra          a2, t0, t5
269:              mulh         s3, s4, s7
270:              sll          s11, s2, tp
271:              div          a6, a6, t1
272:              add          a0, s6, a3
273:              bgeu         t1, s0, 291f
274:              bne          t0, s1, 289f
275:              bne          zero, a0, 293f
276:              ori          t4, zero, -90
277:              xori         t1, tp, 135
278:              nop
279:              slli         a6, zero, 10
280:              bne          ra, t1, 295f
281:              mulhsu       s3, s11, t6
282:              beq          a2, s0, 285f
283:              or           gp, a1, tp
284:              xor          zero, t2, a6
285:              srli         s10, a0, 30
286:              ori          s5, t2, 1470
287:              srai         s7, a2, 16
288:              mulhu        t4, s3, a0
289:              xor          a7, a4, s7
290:              auipc        gp, 979275
291:              csrrci       zero, 0x342, 0
292:              csrrw        a6, 0x343, sp
293:              csrrsi       tp, 0x304, 0
294:              or           ra, t2, ra
295:              bltu         a2, a0, 305f
296:              mulhsu       a7, zero, s2
297:              slti         t0, s9, 1086
298:              bne          s7, a1, 312f
299:              xori         a1, ra, 1790
300:              csrrs        t6, 0x301, zero
301:              slti         zero, s9, 1506
302:              bltu         t5, a6, 306f
303:              beq          a0, a5, 308f
304:              addi         s2, s10, 950
305:              bltu         s10, a6, 312f
306:              and          s6, t1, t5
307:              and          s6, s10, a5
308:              srli         a4, s7, 9
309:              srai         ra, t3, 8
310:              ori          s2, s4, -1554
311:              rem          t2, t1, t1
312:              bltu         a7, t5, 331f
313:              beq          t3, zero, 332f
314:              mul          zero, gp, s11
315:              lui          t0, 451087
316:              mulhsu       a5, ra, s0
317:              divu         s11, s2, t4
318:              sltiu        t1, ra, -966
319:              add          zero, a4, s10
320:              add          s5, s4, s8
321:              xor          s4, a2, t1
322:              xori         a1, gp, -765
323:              mul          a6, t2, zero
324:              slt          a3, t3, a6
325:              add          ra, s1, s10
326:              andi         a6, t2, -1215
327:              srli         zero, sp, 20
328:              srl          s1, a5, t3
329:              remu         t1, t3, a0
330:              slt          a5, t5, s3
331:              xor          s3, s11, s0
332:              or           zero, s2, s6
333:              slti         s1, s7, 27
334:              csrrsi       t1, 0x300, 0
335:              srl          t2, s1, t1
336:              xori         a5, t4, 269
337:              slli         ra, a6, 17
338:              sll          zero, s2, s2
339:              add          t5, s10, s10
340:              blt          s1, ra, 360f
341:              srai         a2, a2, 11
342:              csrrs        gp, 0x301, tp
343:              sltiu        t2, s7, 272
344:              and          s7, a2, t4
345:              blt          a3, s8, 353f
346:              bgeu         ra, a2, 360f
347:              sll          s1, a4, a7
348:              csrrs        s8, 0x343, zero
349:              divu         s4, s2, s1
350:              beq          a5, t0, 366f
351:              bgeu         s7, t5, 358f
352:              bltu         t3, a1, 358f
353:              csrrs        s10, 0x305, zero
354:              bne          ra, s11, 358f
355:              mulhu        t4, s1, s11
356:              csrrwi       s3, 0x301, 23
357:              xor          a0, s10, sp
358:              csrrc        ra, 0x342, gp
359:              sra          t0, t0, t4
360:              addi         t0, t1, 875
361:              rem          a6, s0, t0
362:              divu         a3, s3, s1
                  sltu         s11, s6, s8
                  csrrw        s7, 0x301, a2
                  srai         s7, s10, 24
                  srl          a0, a3, t0
                  la           a1, sub_1
                  csrrc        s10, 0x304, zero
                  csrrci       zero, 0x304, 19
                  addi         a1, a1, 151
                  csrrwi       a4, 0x301, 12
main_j1:          jalr         a7, a1, -148 #jump main -> sub_1
363:              xori         a2, s1, -1077
364:              xori         s11, s6, 816
365:              ori          t5, s10, -1263
366:              sltu         t0, s5, s6
367:              bge          s2, t6, 386f
368:              mul          s3, t1, s2
369:              addi         s2, s4, -514
370:              beq          t2, a3, 379f
371:              div          t5, a4, t2
372:              ori          s10, tp, 1505
373:              bgeu         a6, s6, 390f
374:              mulhu        t4, s7, gp
375:              bgeu         t0, ra, 395f
376:              slti         s8, s5, -1044
377:              csrrci       a2, 0x300, 0
378:              xori         s5, s4, -2015
379:              and          gp, sp, t3
380:              csrrwi       t1, 0x343, 11
381:              sub          a2, gp, t3
382:              ori          t4, t2, 969
383:              andi         s9, s9, 1760
384:              srai         t0, a4, 0
385:              sub          t4, s1, a2
386:              beq          s10, a2, 387f
387:              sra          s6, a7, zero
388:              lui          t4, 366385
389:              bgeu         a2, sp, 403f
390:              xor          s11, a0, a4
391:              bge          a7, a3, 408f
392:              mulhsu       t2, a7, t4
393:              rem          tp, a0, a4
394:              csrrw        s10, 0x301, t5
395:              blt          s6, s10, 400f
396:              add          zero, ra, a2
397:              srli         s11, s9, 20
398:              bltu         tp, s5, 406f
399:              sra          a6, s8, s4
400:              bltu         t1, t1, 419f
401:              slt          t2, sp, s6
402:              mul          t2, t2, a5
403:              nop
404:              ori          s2, a5, -166
405:              beq          t6, a5, 419f
406:              auipc        t0, 339983
407:              bgeu         a4, s10, 426f
408:              bgeu         sp, t2, 413f
409:              beq          sp, tp, 427f
410:              sub          gp, sp, a0
411:              srai         t2, s3, 30
412:              csrrw        zero, 0x301, t4
413:              srai         t0, t0, 26
414:              lui          t5, 578303
415:              andi         ra, a5, -1285
416:              srai         s2, s7, 20
417:              csrrwi       a2, 0x343, 31
418:              nop
419:              andi         a2, a5, 1391
420:              csrrc        tp, 0x301, zero
421:              csrrci       a0, 0x343, 0
422:              rem          a3, s11, a6
423:              sltiu        s2, s9, 927
424:              and          s10, s4, a3
425:              ori          t6, t0, -361
426:              and          zero, ra, a4
427:              mulh         a5, s3, a4
428:              bgeu         s7, a1, 447f
429:              srl          a4, s7, a0
430:              auipc        zero, 383587
431:              slt          s2, t2, s7
432:              auipc        t0, 107066
433:              nop
434:              bltu         s0, a4, 442f
435:              xori         s5, a1, -2026
436:              mulh         a3, a1, t5
437:              rem          s4, s4, a4
438:              slli         tp, ra, 26
439:              csrrs        a1, 0x301, zero
440:              auipc        a0, 185952
441:              xori         s7, s8, -742
442:              slli         s5, a5, 20
443:              addi         s1, t0, -1174
444:              sltu         t4, s2, t0
445:              beq          s1, s5, 459f
446:              lui          s10, 322659
447:              divu         s1, a7, s5
448:              csrrci       gp, 0x343, 14
449:              mul          s3, s1, t5
450:              or           s7, s3, t5
451:              slt          s7, gp, s3
452:              mulhsu       t5, s0, s0
453:              srli         s8, a6, 27
454:              bgeu         t3, t1, 473f
455:              sll          t4, t6, s7
456:              mulhsu       t0, s6, t5
457:              bgeu         a6, a3, 462f
458:              csrrs        t4, 0x305, zero
459:              srli         ra, a4, 14
460:              mulh         s2, t6, a6
461:              bltu         a7, gp, 468f
462:              bgeu         t5, t4, 469f
463:              csrrsi       a5, 0x304, 0
464:              beq          s0, s5, 478f
465:              sra          a1, t0, zero
466:              or           a6, zero, a0
467:              mul          s8, s6, a1
468:              andi         gp, t0, -1047
469:              sll          s6, s2, a3
470:              add          t2, s9, s6
471:              bge          s0, a5, 486f
472:              csrrwi       a1, 0x304, 0
473:              lui          s7, 728773
474:              add          zero, s11, s8
475:              or           s10, t0, t1
476:              ori          t1, s2, -71
477:              csrrsi       t6, 0x343, 19
478:              csrrc        a2, 0x300, zero
479:              slti         s11, t4, 361
480:              div          s1, t2, s8
481:              sub          a1, t5, a3
482:              add          zero, s5, a2
483:              sra          a3, s5, a7
484:              rem          t6, a4, a1
485:              nop
486:              slti         t4, a1, -1550
487:              csrrw        s4, 0x304, s5
488:              and          a5, a6, t4
489:              div          ra, tp, s11
490:              blt          t5, s4, 510f
491:              beq          gp, a1, 507f
492:              add          t0, s6, t4
493:              lui          t1, 738665
494:              lui          s3, 408999
495:              add          gp, t3, a4
496:              csrrc        a3, 0x304, zero
497:              mul          t6, a1, t3
498:              rem          t4, s4, ra
499:              csrrci       a7, 0x305, 0
500:              mulhu        ra, a6, t5
501:              xor          gp, zero, a5
502:              mul          gp, s8, a5
503:              bltu         t4, a2, 521f
504:              slt          a3, s0, a4
505:              bne          a2, a6, 524f
506:              csrrc        a4, 0x304, a3
507:              bgeu         t4, t2, 526f
508:              remu         t4, t4, t2
509:              beq          s4, s3, 510f
510:              bgeu         t1, a4, 527f
511:              lui          a7, 142674
512:              ori          t5, s0, 588
513:              slt          a5, t6, t4
514:              nop
515:              mulhu        s1, s11, s11
516:              csrrwi       s9, 0x342, 17
517:              csrrwi       a0, 0x343, 20
518:              sub          a2, a5, gp
519:              bge          t5, s4, 529f
520:              srai         a2, s7, 2
521:              slt          a6, t6, t5
522:              slli         s1, a4, 24
523:              remu         t6, zero, a3
524:              csrrwi       gp, 0x343, 1
525:              andi         s5, a5, 566
526:              beq          zero, s4, 532f
527:              srai         s11, s0, 15
528:              bne          t0, s5, 545f
529:              div          t0, t1, t1
530:              xor          t6, s8, zero
531:              mulhu        gp, a0, s2
532:              or           a2, a2, a1
533:              divu         t0, s1, a2
534:              mulhu        a6, s9, s8
535:              andi         s4, ra, -968
536:              csrrc        ra, 0x300, zero
537:              slti         t0, s5, -902
538:              srl          tp, s10, t4
539:              xori         t4, t4, -22
540:              sll          t2, sp, a7
541:              rem          tp, a2, s4
542:              or           s3, ra, gp
543:              mul          t1, ra, s5
544:              sub          s1, a2, a1
545:              divu         a2, tp, tp
546:              mul          a3, s11, s8
547:              slti         s1, ra, 809
548:              csrrw        s7, 0x301, t6
549:              csrrci       s2, 0x342, 0
550:              sub          ra, s10, s9
551:              srai         a0, a7, 17
552:              sra          a3, s10, s2
553:              remu         a2, s8, t0
554:              mulh         t5, a3, s6
555:              slti         a6, t2, 949
556:              srli         s10, s11, 30
557:              mulh         gp, s3, s0
558:              mulh         a4, a5, s9
559:              csrrwi       a3, 0x343, 20
560:              xor          tp, a7, s11
561:              and          a0, s9, tp
562:              srli         t1, zero, 6
563:              rem          a2, s6, s5
564:              or           a5, s0, a6
565:              sra          t0, a7, tp
566:              lui          t0, 480045
567:              remu         a4, a2, t5
568:              sltiu        t2, t2, -2018
569:              or           a7, gp, t2
570:              csrrc        s7, 0x342, zero
571:              nop
572:              sub          tp, s6, t0
573:              mulhu        a2, s9, s0
574:              blt          a3, s7, 577f
575:              bge          s2, t3, 595f
576:              addi         a7, s7, 1407
577:              sub          zero, ra, a5
578:              sltiu        a3, t1, 501
579:              div          a4, a3, t3
580:              and          t0, s3, s5
581:              sltu         s11, a3, s11
582:              ori          s3, s9, 1688
583:              div          s5, zero, t0
584:              bge          a2, t0, 592f
585:              slt          s7, a6, t3
586:              bgeu         t4, s11, 595f
587:              div          s5, t4, s2
588:              blt          t6, a7, 592f
589:              sra          s3, a5, t1
590:              slt          t1, zero, a2
591:              div          gp, s6, s10
592:              divu         t0, s5, s6
593:              bltu         t1, gp, 597f
594:              addi         t1, tp, -1733
595:              auipc        a3, 901239
596:              csrrc        s4, 0x343, zero
597:              srai         s1, a5, 25
598:              sltiu        s9, t6, 195
599:              nop
600:              auipc        a4, 725245
601:              add          t6, s2, t6
602:              bne          a4, t2, 617f
603:              lui          s9, 765958
604:              lui          s8, 809863
605:              sll          s5, a5, gp
606:              csrrci       a2, 0x300, 0
607:              srli         s7, a7, 21
608:              mul          a3, s4, s7
609:              srai         t1, t1, 30
610:              remu         t2, a7, t2
611:              csrrci       a4, 0x343, 5
612:              ori          s2, a5, -517
613:              add          t0, a2, t3
614:              csrrwi       s1, 0x301, 6
615:              slti         s2, s11, -1711
616:              csrrsi       s3, 0x343, 0
617:              add          a1, t4, s10
618:              csrrwi       s11, 0x304, 16
619:              addi         a1, ra, 350
620:              remu         ra, t4, t4
621:              srai         s8, a3, 2
622:              bltu         t1, s2, 626f
623:              div          t4, t3, a0
624:              div          a2, s4, ra
625:              xor          t6, s10, s7
626:              mulh         t0, s6, a1
627:              csrrwi       a4, 0x343, 14
628:              add          ra, t5, sp
629:              mulhsu       t1, s8, zero
630:              and          a1, a5, s1
631:              divu         s3, t5, a0
632:              sra          s1, t1, zero
633:              div          s4, s5, t0
634:              slti         ra, s1, 189
635:              bgeu         s2, s10, 653f
636:              slli         zero, a4, 23
637:              sltiu        s10, a2, -1491
638:              sra          s3, t2, a6
639:              mulhsu       s7, t1, zero
640:              blt          t3, gp, 660f
641:              rem          gp, s9, zero
642:              mulhsu       t4, t4, t0
643:              add          a5, s3, s1
644:              nop
645:              csrrw        s8, 0x304, t4
646:              bge          ra, zero, 655f
647:              sll          s8, a3, s10
648:              slt          t4, t0, s2
649:              rem          tp, ra, a0
650:              auipc        t4, 512309
651:              bltu         s11, tp, 659f
652:              srli         a2, s0, 28
653:              srl          s10, a5, s11
654:              bne          a3, t1, 655f
655:              mulhsu       s6, s3, a5
656:              or           t2, s2, gp
657:              bgeu         a5, zero, 677f
658:              csrrci       s7, 0x305, 0
659:              add          a5, s7, s6
660:              rem          a4, s6, t2
661:              or           s7, s0, s5
662:              mul          a0, s8, s5
663:              xor          a7, s10, s4
664:              mulh         t2, s6, a4
665:              csrrwi       a2, 0x301, 9
666:              mul          a1, tp, t0
667:              bltu         s1, ra, 684f
668:              div          t6, a1, s0
669:              addi         s8, tp, 184
670:              slti         t4, a0, 584
671:              mulhsu       a0, a4, zero
672:              auipc        a4, 422455
673:              bgeu         a5, t0, 688f
674:              srai         s3, t4, 28
675:              rem          s11, s8, tp
676:              rem          t1, a0, s5
677:              rem          a5, a2, a0
678:              div          a2, s11, t5
679:              csrrs        t2, 0x305, zero
680:              addi         ra, a6, 1393
681:              sra          tp, a3, s11
682:              bgeu         s9, sp, 700f
683:              csrrc        a4, 0x343, t4
684:              csrrsi       s10, 0x343, 21
685:              srl          zero, zero, a7
686:              add          s11, a4, ra
687:              beq          t2, t3, 701f
688:              csrrwi       ra, 0x343, 21
689:              slt          t6, s9, s2
690:              sra          a4, a6, sp
691:              mulh         a1, ra, t6
692:              blt          sp, s5, 711f
693:              srli         s11, a5, 9
694:              remu         a1, ra, a0
695:              lui          s3, 140225
696:              csrrs        gp, 0x304, zero
697:              and          a4, a4, t3
698:              slli         s9, a5, 14
699:              sub          s5, ra, a2
700:              mulhsu       s2, a6, gp
701:              xor          s3, a0, s1
702:              ori          s5, a5, -206
703:              sra          s6, a3, a0
704:              beq          t1, tp, 723f
705:              beq          s7, t3, 724f
706:              bgeu         a3, t0, 710f
707:              add          s1, a0, t5
708:              ori          a3, a7, 287
709:              and          a3, t4, s6
710:              addi         s5, t3, 1279
711:              slli         a5, s8, 23
712:              mulhsu       t5, ra, s0
713:              xori         s3, t1, 156
714:              auipc        s6, 67374
715:              sltiu        a7, t0, -796
716:              sra          a7, s9, t0
717:              sub          ra, a5, t1
718:              bgeu         s2, a4, 732f
719:              div          t1, a6, a1
720:              rem          s4, t3, s5
721:              srl          s4, s7, t0
722:              or           gp, a4, s11
723:              srai         s11, s0, 28
724:              mul          s3, a4, s4
725:              xori         s8, s1, -1366
726:              sub          a3, a4, s3
727:              add          a1, s6, s2
728:              bgeu         a3, a2, 747f
729:              mulh         s6, a5, t1
730:              ori          gp, sp, 2021
731:              addi         a0, s4, 1412
732:              remu         t4, tp, a0
733:              bgeu         s7, sp, 752f
734:              xor          zero, t3, s1
735:              divu         s6, ra, s4
736:              csrrs        s2, 0x343, zero
737:              xori         s10, a7, -91
738:              slti         ra, a1, -603
739:              srai         s7, a5, 12
740:              slti         tp, t5, 874
741:              xori         a5, s3, 1934
742:              mul          t0, zero, gp
743:              or           a4, s9, s10
744:              xori         a4, s6, -977
745:              csrrs        ra, 0x342, s2
746:              csrrwi       a0, 0x342, 10
747:              sub          s6, t1, a4
748:              lui          s5, 197030
749:              bltu         gp, t6, 764f
750:              slt          s3, s9, t0
751:              slt          s3, a2, a2
752:              nop
753:              bge          s9, zero, 763f
754:              div          t5, a5, s11
755:              nop
756:              and          t1, zero, s4
757:              xor          a6, t1, s11
758:              bltu         a6, s2, 772f
759:              sltiu        s9, t1, 1709
760:              ori          a3, s11, 1758
761:              lui          t2, 820873
762:              bgeu         t1, a6, 765f
763:              andi         zero, tp, -1054
764:              bge          s6, s10, 771f
765:              divu         gp, a3, s8
766:              and          t6, a5, t5
767:              rem          a5, s3, a4
768:              srai         s5, ra, 13
769:              add          s6, a2, a5
770:              bne          s8, a0, 775f
771:              mulhu        t4, t4, s3
772:              and          a1, t0, a7
773:              mul          a0, s0, s7
774:              csrrci       t5, 0x301, 0
775:              andi         a2, a4, 1947
776:              ori          s4, t0, 450
777:              csrrsi       t6, 0x300, 0
778:              nop
779:              csrrw        s3, 0x304, tp
780:              sra          s2, ra, t5
781:              csrrci       s2, 0x343, 10
782:              csrrci       s6, 0x342, 2
783:              or           gp, a0, s6
784:              csrrc        s2, 0x305, zero
785:              srl          a3, s7, t3
786:              sub          s10, s6, ra
787:              sra          s5, s11, a7
788:              rem          s3, t0, a7
789:              slli         zero, t4, 13
790:              xori         t2, a3, 1164
791:              csrrsi       s9, 0x304, 17
792:              rem          s11, t4, a2
793:              srli         s10, s11, 19
794:              sltiu        s6, t5, 1490
795:              slti         s7, a4, -1293
796:              csrrw        a5, 0x304, s11
797:              srl          s6, t6, a0
798:              xori         tp, a1, -352
799:              csrrc        t6, 0x342, zero
800:              sra          s8, t6, ra
801:              blt          s4, t4, 807f
802:              xor          zero, s6, a2
803:              sub          a4, s11, t1
804:              slt          s8, t4, t4
805:              bge          a5, s2, 821f
806:              beq          s7, t3, 811f
807:              or           s1, s5, t5
808:              xori         a2, sp, 1936
                  la           a2, region_0+2413 #start load_store_instr_stream_1
                  la           s11, region_0+1578 #start load_store_instr_stream_0
                  la           s8, region_0+631 #start load_store_instr_stream_3
                  la           s1, region_0+3049 #start load_store_instr_stream_2
                  sb           a5, -1269(a2)
                  sw           s0, -222(s11)
                  lb           a5, 762(a2)
                  lh           s4, 33(s1)
                  sw           t1, -133(s8)
                  lbu          a1, 230(s8)
                  sw           a3, 38(s11)
                  lhu          a7, -106(s8)
                  sw           t3, -129(s8)
                  sb           s2, -60(s1)
                  lb           s7, -50(s1)
                  lw           a1, -1998(a2)
                  lh           s9, -2045(a2)
                  sw           tp, -46(s1)
                  lbu          s9, -300(a2)
                  lb           s2, 58(s1)
                  lb           a1, -255(s8)
                  sw           a2, -228(s11)
                  lw           t0, -15(s1)
                  lbu          a0, -1529(a2)
                  sh           sp, 1(s1)
                  lb           s6, 88(s11)
                  lb           a7, 81(s8)
                  lb           s3, -53(s1)
                  lhu          t0, -174(s11)
                  lh           t2, -2005(a2)
                  sb           t1, -160(s8) #end load_store_instr_stream_3
                  lw           a1, 159(a2)
                  sb           t6, -3(s11)
                  sw           gp, -18(s1) #end load_store_instr_stream_2
                  sw           t3, 1645(a2) #end load_store_instr_stream_1
                  sh           t3, -56(s11) #end load_store_instr_stream_0
809:              csrrsi       t6, 0x305, 0
810:              rem          a6, s1, a2
811:              csrrsi       t4, 0x300, 0
812:              xori         s1, a0, 221
813:              csrrci       a5, 0x305, 0
814:              nop
815:              slli         s6, t5, 6
816:              slti         a7, s10, -149
817:              andi         s11, t3, 310
818:              xori         tp, a4, 1372
819:              sub          s5, a2, a2
820:              or           s11, s0, s5
821:              bgeu         a5, t5, 838f
822:              remu         a4, a3, s6
823:              slti         s6, s3, 1168
824:              bne          gp, s8, 832f
825:              sltiu        a1, s11, -1670
826:              sub          a6, a7, a6
827:              srl          s5, gp, gp
828:              addi         t2, gp, -450
829:              remu         s9, ra, t6
830:              csrrs        a7, 0x300, zero
831:              csrrsi       a2, 0x305, 0
832:              srai         t0, t3, 26
833:              csrrc        s3, 0x304, s11
834:              and          a2, zero, s2
835:              mul          s3, s6, s3
836:              csrrsi       a4, 0x300, 0
837:              divu         s3, s7, t1
838:              sub          t5, ra, s1
839:              xori         a4, t1, 1563
840:              xori         s2, a7, 1657
841:              csrrwi       s8, 0x342, 17
842:              sub          tp, a1, s9
843:              csrrwi       s11, 0x301, 1
844:              sub          t0, t5, s4
845:              mulh         t5, t5, a5
846:              mulh         s6, t4, t6
847:              blt          s0, s6, 854f
848:              sra          a6, a3, t6
849:              xor          s4, a6, ra
850:              add          a0, t2, t4
851:              and          t2, sp, a3
852:              div          a3, s4, s1
853:              csrrci       a1, 0x342, 18
854:              sltiu        s2, t4, 1478
855:              csrrc        s11, 0x305, zero
                  la x28, test_done
                  jalr x0, x28, 0
test_done:        
                  li gp, 0x73746f70
                  j write_tohost
sub_1:            bltu         s4, t0, sub_1_stack_p
                  srli         a3, t2, 19
                  csrrci       t4, 0x300, 0
sub_1_stack_p:    addi         sp, sp, -40
                  nop
                  divu         t1, s5, a7
                  mul          s1, a0, s2
                  csrrwi       s10, 0x343, 28
                  srai         s11, a2, 18
                  sw           a7, 4(sp)
                  xori         s1, a1, -1308
                  mulhsu       s2, t5, s7
                  xori         s1, sp, -1127
                  mulh         t2, t6, s2
                  mulhu        s7, a7, t3
                  andi         s8, t0, -725
                  beq          s7, t1, sub_1_j4 #branch to jump instr
                  add          a1, a2, a0
                  sll          t4, a3, a4
                  ori          t5, s11, 482
                  add          a3, s7, sp
                  add          a4, t2, a0
sub_1_j4:         jal          a7, sub_2 #jump sub_1 -> sub_2
                  la           t1, region_1+35773 #start riscv_load_store_hazard_instr_stream_5
                  sb           t3, 112(t1)
                  lhu          t6, 112(t1)
                  add          ra, s5, a2
                  slti         t2, s8, 980
                  lhu          s4, 112(t1)
                  lw           a5, -154(t1)
                  sw           s3, -154(t1)
                  lh           a5, -154(t1)
                  sb           tp, -154(t1)
                  lb           ra, -154(t1)
                  lbu          s6, -154(t1)
                  lw           s7, -227(t1)
                  lb           a0, -227(t1)
                  sh           t0, -227(t1)
                  sra          t2, zero, s1
                  lh           t5, -227(t1)
                  lh           a7, -227(t1)
                  sw           gp, -227(t1)
                  sh           s2, -227(t1)
                  sh           s1, -227(t1)
                  csrrsi       a4, 0x343, 21
                  lh           a0, -227(t1)
                  remu         gp, a2, s5
                  sh           a0, -227(t1) #end riscv_load_store_hazard_instr_stream_5
                  la           a5, region_1+47675 #start load_store_instr_stream_0
                  la           s7, region_1+16694 #start load_store_instr_stream_1
                  sw           t1, -30(a5)
                  sb           s10, -29(a5)
                  la           a4, region_1+31877 #start load_store_instr_stream_2
                  lw           t1, 58(a5)
                  sb           s6, 45(a5)
                  lb           a7, -90(a4)
                  sw           a7, -1271(a4)
                  lbu          a0, -17(s7)
                  sh           a3, -917(a4)
                  sb           t0, -56(s7)
                  sb           gp, 494(a4)
                  lw           t6, -22(s7)
                  lw           s3, 31(a5)
                  lh           a0, 47(s7)
                  lhu          s3, -13(s7)
                  lw           t1, 1920(a4)
                  lh           ra, 960(a4)
                  sb           s10, -60(a5)
                  sh           a7, 1585(a4)
                  sh           ra, 32(s7)
                  lh           s3, -1330(a4)
                  lw           a0, 4(a5)
                  lw           a0, 53(a5)
                  sh           s6, 1148(a4)
                  lh           a0, 30(s7)
                  lh           gp, -1174(a4) #end load_store_instr_stream_2
                  lh           t2, -1(s7) #end load_store_instr_stream_1
                  sw           s0, -13(a5) #end load_store_instr_stream_0
                  la           t2, region_0+1978 #start riscv_load_store_rand_instr_stream_4
                  lb           s4, -1(t2)
                  sltu         a6, a7, s0
                  sh           t4, 50(t2)
                  lbu          s6, 11(t2)
                  sb           a5, -55(t2)
                  csrrsi       t6, 0x304, 0
                  srli         a6, gp, 29
                  sll          a3, s9, s5
                  mulhsu       t5, t4, a1
                  sh           t5, -49(t2)
                  sb           t3, -27(t2)
                  nop
                  sh           t1, -20(t2)
                  lh           s4, -39(t2)
                  lh           a7, 37(t2)
                  sh           gp, -23(t2)
                  srai         s6, s2, 10
                  mulh         tp, a4, t3
                  sll          a4, a6, t6
                  xor          a1, t1, t6
                  csrrci       s4, 0x305, 0
                  lw           s2, -64(t2)
                  mulhu        a6, tp, ra
                  slti         s6, s1, 1741
                  sw           a2, -35(t2)
                  sw           s2, -51(t2)
                  lhu          s9, 50(t2)
                  xor          s9, sp, sp
                  sb           gp, -10(t2)
                  or           a7, a3, s9
                  lh           t0, 33(t2)
                  sw           gp, -59(t2) #end riscv_load_store_rand_instr_stream_4
                  la           t5, region_0+1694 #start riscv_load_store_hazard_instr_stream_1
                  slt          a4, t4, a6
                  sll          s2, s9, s9
                  lbu          a7, 207(t5)
                  lh           a3, 135(t5)
                  csrrc        a1, 0x300, zero
                  lbu          zero, 135(t5)
                  lbu          t4, -115(t5)
                  sh           gp, -115(t5)
                  sw           s6, -115(t5)
                  andi         s10, s6, -16
                  lh           s8, -206(t5)
                  lw           a1, -206(t5)
                  lh           a7, 190(t5)
                  sh           s9, 190(t5)
                  sh           s4, 190(t5)
                  sh           s7, 190(t5) #end riscv_load_store_hazard_instr_stream_1
                  la           s3, region_1+24926 #start riscv_load_store_hazard_instr_stream_2
                  lh           a6, 16(s3)
                  lh           a3, 16(s3)
                  csrrci       s9, 0x304, 0
                  sh           s4, 16(s3)
                  div          a0, tp, t6
                  sltiu        t0, a2, 420
                  sw           t5, 16(s3)
                  sll          t6, a0, t4
                  sh           t0, 16(s3)
                  lbu          a3, 16(s3)
                  slt          s6, s7, t1
                  lhu          s9, -4(s3)
                  sw           s1, 15(s3)
                  sb           s3, 4(s3)
                  csrrs        a2, 0x300, zero
                  sb           t4, 4(s3) #end riscv_load_store_hazard_instr_stream_2
                  la           s5, region_0+3681 #start riscv_load_store_rand_instr_stream_6
                  sltiu        s7, s2, -451
                  xor          s2, s1, sp
                  addi         s7, a3, 877
                  and          s6, a0, t0
                  sw           s1, 42(s5)
                  mulhu        s11, s1, a3
                  sll          a1, s9, a0
                  sw           ra, 52(s5)
                  mulhu        a0, a2, t6
                  lbu          zero, -36(s5)
                  lui          s3, 47747
                  mulhu        a6, s7, a6
                  divu         s8, a2, s9
                  csrrs        s2, 0x305, zero
                  lw           a6, -46(s5)
                  slli         s2, t0, 5
                  mul          a1, a7, t1
                  lb           t0, 30(s5)
                  add          a3, a5, tp
                  remu         a2, t5, gp
                  sub          t6, s2, a4
                  lbu          tp, -52(s5)
                  slli         a1, a2, 30
                  lui          a7, 676024
                  csrrci       t2, 0x342, 21
                  xor          a0, t6, tp
                  lhu          gp, 58(s5)
                  lw           a1, 33(s5)
                  sb           s11, 38(s5)
                  lh           a2, -64(s5) #end riscv_load_store_rand_instr_stream_6
                  la           a6, region_1+6001 #start riscv_load_store_rand_instr_stream_5
                  csrrwi       s10, 0x301, 8
                  sltu         s7, s2, a3
                  sll          s4, a0, t0
                  csrrw        zero, 0x304, s1
                  divu         t4, a4, s10
                  sb           t2, -12(a6)
                  lbu          s7, -4(a6)
                  or           s2, gp, s0
                  mulhsu       s6, t5, t6
                  csrrci       s1, 0x300, 0
                  nop
                  csrrw        s3, 0x301, t4
                  csrrwi       gp, 0x301, 4
                  auipc        a4, 472705
                  sh           a2, 13(a6)
                  sltiu        t2, s10, 1719
                  sb           t1, -13(a6)
                  slt          s4, a6, sp
                  lh           t2, -2(a6)
                  or           s2, a3, s2
                  sh           a6, 9(a6)
                  lhu          zero, -13(a6)
                  lw           s4, -12(a6)
                  and          t6, a6, a1
                  ori          zero, tp, 1991
                  lh           s8, 0(a6)
                  andi         a3, s4, -334
                  lhu          a4, -4(a6)
                  lh           s2, -11(a6)
                  csrrc        a4, 0x305, zero
                  mulhu        t4, t0, a1
                  sub          gp, t3, tp
                  lhu          t2, 12(a6) #end riscv_load_store_rand_instr_stream_5
                  la           t1, region_1+63156 #start riscv_load_store_rand_instr_stream_1
                  lbu          t2, 14(t1)
                  ori          t5, t0, 262
                  sltiu        s4, t1, -569
                  lb           s10, 1(t1)
                  srli         t2, s3, 18
                  lh           ra, 5(t1)
                  lui          s3, 521880
                  xori         s6, a1, 1425
                  sra          s6, s11, t0
                  lb           s3, 0(t1)
                  csrrw        gp, 0x301, a4
                  sb           gp, -13(t1)
                  sh           gp, -1(t1)
                  sw           a0, 13(t1)
                  csrrci       s6, 0x300, 0
                  sb           a6, 2(t1)
                  lw           s9, -2(t1)
                  or           t2, sp, sp
                  mulhu        s9, s10, a3
                  slli         s2, t3, 1
                  mul          a3, a1, t0
                  lbu          gp, 12(t1) #end riscv_load_store_rand_instr_stream_1
                  la           a5, region_1+36848 #start riscv_load_store_rand_instr_stream_2
                  lb           t2, 208(a5)
                  sra          t0, s4, s3
                  lbu          s3, -108(a5)
                  lw           s1, 22(a5)
                  csrrwi       a6, 0x343, 21
                  lb           a6, -188(a5)
                  csrrw        s1, 0x342, a7
                  mulhu        s11, a0, s6
                  sh           t5, 148(a5)
                  sh           zero, 9(a5)
                  slti         a4, a7, 431
                  lb           t4, -107(a5)
                  mulhu        t1, s9, a5
                  sh           s6, 247(a5)
                  sb           zero, 168(a5)
                  sra          a2, s4, a3
                  lw           s8, 194(a5)
                  sb           ra, -5(a5)
                  xori         a6, s6, -1336
                  sh           a6, 225(a5)
                  lw           s10, 254(a5)
                  sub          s2, t0, a1
                  lh           tp, -25(a5)
                  sb           s7, -50(a5)
                  rem          a1, a3, t0
                  lh           s5, -211(a5)
                  or           s5, s9, s2
                  csrrsi       s5, 0x300, 0
                  lui          a0, 1037920
                  srli         zero, a3, 18
                  lw           zero, -256(a5)
                  lhu          a3, 219(a5)
                  sw           a4, 125(a5)
                  sltu         zero, s5, a5
                  xor          a1, s1, s10
                  addi         t5, s9, -1550
                  lhu          s10, -253(a5)
                  mulhsu       t5, s8, a4
                  lh           ra, 150(a5)
                  srl          s6, s4, zero
                  div          a2, a6, s1
                  nop
                  lhu          s7, -12(a5)
                  sh           a2, 135(a5)
                  sh           ra, 94(a5)
                  mulhsu       a0, s1, a7
                  lw           s9, -14(a5)
                  rem          t6, a6, a1
                  lhu          t2, 73(a5)
                  slli         tp, a7, 7
                  lhu          s7, -75(a5)
                  csrrsi       t5, 0x301, 0
                  sw           a2, 56(a5)
                  srl          s6, t0, a2
                  xori         s2, s6, 1795
                  lbu          s5, 101(a5) #end riscv_load_store_rand_instr_stream_2
                  la           t2, region_1+64100 #start riscv_load_store_hazard_instr_stream_4
                  lbu          a0, 54(t2)
                  lw           s11, 54(t2)
                  lhu          gp, 54(t2)
                  lbu          t6, 54(t2)
                  lhu          a3, 54(t2)
                  lh           t1, 54(t2)
                  lbu          a2, 54(t2)
                  sw           s10, 54(t2)
                  sh           a2, 54(t2)
                  lhu          s4, 54(t2)
                  lb           a0, 54(t2)
                  lhu          a5, 54(t2)
                  mul          t0, a4, t4
                  lb           gp, 54(t2) #end riscv_load_store_hazard_instr_stream_4
                  la           t4, region_1+14335 #start riscv_load_store_rand_instr_stream_3
                  lh           t6, 60(t4)
                  andi         t5, a0, -646
                  remu         t6, gp, t4
                  sh           s3, -27(t4)
                  xori         s4, s6, 227
                  sw           s2, 27(t4)
                  slti         t2, t6, -1150
                  lw           s7, -64(t4)
                  lw           ra, -33(t4)
                  csrrwi       s7, 0x343, 19
                  mulhsu       gp, t3, t2
                  lui          t2, 1037257
                  lhu          a7, 24(t4)
                  div          ra, a6, s2
                  divu         a5, t1, a0
                  lb           gp, 48(t4)
                  lbu          s2, -10(t4)
                  addi         t2, ra, -1540
                  sb           s6, -44(t4)
                  lhu          a2, 17(t4)
                  sw           zero, -3(t4)
                  csrrwi       s6, 0x304, 26
                  mulhsu       t2, s10, t1
                  sh           t5, 11(t4)
                  csrrwi       a4, 0x342, 25
                  lb           s1, 29(t4)
                  sw           t5, -2(t4)
                  lh           s1, 54(t4)
                  add          s3, a5, s9
                  lhu          s11, -38(t4)
                  lb           t0, 33(t4)
                  lw           s10, 23(t4)
                  lbu          t5, 16(t4)
                  sh           t0, 62(t4)
                  auipc        a2, 737648
                  lh           s10, 19(t4)
                  lh           ra, 42(t4) #end riscv_load_store_rand_instr_stream_3
                  la           a6, region_0+2075 #start riscv_load_store_hazard_instr_stream_6
                  sw           s8, 812(a6)
                  sb           ra, 812(a6)
                  sw           t4, 812(a6)
                  lb           s4, 812(a6)
                  sb           a5, 812(a6)
                  lbu          s9, 812(a6)
                  srai         a1, t3, 12
                  lw           s9, 812(a6)
                  sb           zero, 812(a6)
                  mul          s6, t0, t4
                  sh           a0, 812(a6)
                  lhu          a5, 812(a6)
                  lh           t1, 812(a6)
                  lw           gp, 812(a6)
                  csrrsi       zero, 0x343, 19
                  sw           s10, 209(a6)
                  lw           a2, 209(a6)
                  srai         s2, t0, 13
                  lhu          s2, 209(a6)
                  lhu          s5, 209(a6)
                  lh           ra, 1472(a6) #end riscv_load_store_hazard_instr_stream_6
                  la           a2, region_0+1416 #start riscv_load_store_rand_instr_stream_0
                  lb           a3, 23(a2)
                  sw           t5, 60(a2)
                  lh           t1, 39(a2)
                  lh           ra, -41(a2)
                  sltu         s5, ra, s0
                  lb           t6, -56(a2)
                  lh           s11, -55(a2)
                  sh           s2, 54(a2)
                  mulhsu       s6, t5, a3
                  lb           a7, 63(a2)
                  srli         s9, s9, 4
                  remu         s2, s10, tp
                  sw           t6, -38(a2)
                  lh           s6, 20(a2)
                  and          a7, s8, a7
                  csrrci       s9, 0x300, 0
                  slt          t6, tp, s10
                  sra          t6, s1, t2
                  sh           ra, 15(a2)
                  remu         a5, ra, a6
                  lb           s3, -47(a2)
                  lw           s11, -25(a2)
                  lw           s7, 59(a2)
                  csrrc        a3, 0x301, zero
                  lw           s10, -27(a2)
                  lbu          t5, -40(a2)
                  lbu          s6, 43(a2)
                  lhu          s10, -50(a2)
                  xori         a7, s1, -1083
                  lh           a5, 43(a2)
                  lbu          s1, -58(a2)
                  srl          s5, t5, a2
                  lbu          s9, 31(a2)
                  lh           ra, -59(a2)
                  sb           a5, 30(a2)
                  andi         zero, zero, 956
                  lhu          s1, -30(a2) #end riscv_load_store_rand_instr_stream_0
                  la           t0, region_1+47276 #start riscv_load_store_hazard_instr_stream_3
                  lw           s11, -638(t0)
                  xor          s4, a0, s1
                  sw           s11, 717(t0)
                  lbu          tp, 598(t0)
                  lhu          a2, -1244(t0)
                  divu         zero, gp, s6
                  lb           t4, -1244(t0)
                  sw           s6, 397(t0)
                  lb           a2, 512(t0)
                  slti         t6, a1, 1277
                  csrrsi       a6, 0x305, 0
                  lhu          s5, 512(t0)
                  lbu          t2, 1653(t0)
                  lhu          s11, -416(t0) #end riscv_load_store_hazard_instr_stream_3
                  la           s3, region_0+2387 #start riscv_load_store_hazard_instr_stream_0
                  lb           gp, -41(s3)
                  sll          gp, s10, s5
                  sh           s11, -41(s3)
                  sb           t5, -41(s3)
                  sh           s5, -41(s3)
                  sb           t3, -41(s3)
                  sw           t3, -41(s3)
                  lh           s1, -41(s3)
                  sh           s3, -41(s3)
                  lbu          t1, -41(s3)
                  lhu          a7, -41(s3)
                  lbu          s7, -41(s3)
                  sltiu        ra, t4, -1746
                  sh           t3, -41(s3)
                  lb           t6, -41(s3)
                  lhu          t0, -41(s3)
                  lh           tp, -41(s3) #end riscv_load_store_hazard_instr_stream_0
                  la           t6, region_0+3472 #start load_store_instr_stream_1
                  lbu          a5, 34(t6)
                  la           ra, region_1+35632 #start load_store_instr_stream_0
                  sh           s1, -39(t6)
                  sw           gp, -7(ra)
                  lw           a6, 19(t6)
                  sh           ra, -11(ra)
                  lh           s3, 50(t6)
                  lb           a4, -2(ra)
                  lb           s7, -2(t6)
                  lhu          s6, 0(ra)
                  lbu          zero, 42(t6)
                  lw           s9, 12(ra)
                  lhu          s7, 57(t6)
                  sh           s8, 25(t6)
                  sb           a3, -3(ra)
                  lbu          t4, 12(t6) #end load_store_instr_stream_1
                  sh           s8, 0(ra) #end load_store_instr_stream_0
0:                mulhsu       tp, s7, s2
1:                andi         t6, t3, 971
2:                bne          a6, t1, 7f
3:                add          s7, a3, s4
4:                csrrs        a5, 0x342, zero
5:                csrrc        t4, 0x305, zero
6:                beq          s7, t4, 13f
7:                csrrwi       a7, 0x343, 17
8:                div          t4, t3, a4
9:                csrrci       a6, 0x305, 0
10:               nop
11:               mulh         a0, s4, t2
12:               srl          a2, t5, t3
13:               beq          a2, a6, 21f
14:               csrrci       a3, 0x343, 0
15:               srai         a2, a4, 19
16:               slt          s9, s0, zero
17:               add          a7, s7, s0
18:               lui          s7, 63489
19:               addi         t1, s3, -785
20:               addi         s1, s5, -1834
21:               nop
22:               xori         s8, a6, 1888
23:               csrrwi       a2, 0x342, 24
24:               sub          a2, t0, a6
25:               slli         s3, t6, 11
26:               beq          ra, s10, 32f
27:               csrrsi       s1, 0x342, 29
28:               srai         t6, t0, 28
29:               nop
30:               slli         tp, s9, 0
31:               sll          t0, s11, s2
32:               or           zero, a1, s1
33:               srli         a4, t3, 7
34:               mulhu        a1, a5, ra
35:               add          s7, t2, a0
36:               lui          t6, 115824
37:               bge          tp, tp, 50f
38:               div          s8, s11, t2
39:               mul          s7, s0, ra
40:               sra          t4, gp, a6
41:               divu         s11, t1, a2
42:               xor          s2, zero, s1
43:               andi         a7, s11, -1321
44:               sra          s3, s4, s4
45:               csrrwi       ra, 0x342, 11
46:               and          a6, a2, tp
47:               srl          a6, t4, a5
48:               div          t6, s4, a2
49:               rem          s3, s3, a1
50:               xor          gp, s8, s9
51:               mulh         a6, gp, a6
52:               mul          s3, a3, a0
53:               divu         s11, s10, a5
54:               sub          t5, gp, s0
55:               div          a7, s5, a1
56:               mulhsu       s9, s0, t5
57:               slt          t4, a3, a1
58:               div          a4, s11, s3
59:               rem          tp, s10, s8
60:               xori         t1, zero, -870
61:               andi         s6, s4, -353
62:               nop
63:               sub          t4, a4, s4
64:               andi         t4, s11, -1752
65:               srai         a4, sp, 23
66:               srai         a0, zero, 2
67:               sra          ra, sp, t5
68:               bgeu         t6, ra, 80f
69:               sltu         a2, zero, ra
70:               bge          tp, ra, 73f
71:               mulhu        ra, gp, s3
72:               csrrwi       s11, 0x342, 28
73:               xori         s4, a1, -1379
74:               lui          tp, 683021
75:               xor          a3, t2, s4
76:               rem          a1, sp, t6
77:               mulhsu       s7, s5, t3
78:               beq          s7, s11, 85f
79:               sra          t4, a7, zero
80:               mulh         ra, a0, a3
81:               andi         s4, t5, 151
82:               csrrs        a2, 0x305, zero
83:               bge          a0, zero, 94f
84:               xori         t2, a2, -946
85:               addi         s8, a4, 1462
86:               bltu         a4, a4, 99f
87:               srai         t0, s1, 16
88:               lui          t5, 273448
89:               beq          ra, a2, 90f
90:               bne          t3, t5, 94f
91:               bgeu         t1, s4, 103f
92:               csrrsi       a6, 0x301, 0
93:               andi         t4, s8, 1595
94:               slli         s6, a1, 2
95:               sra          s9, a2, s4
96:               csrrc        t0, 0x305, zero
97:               srli         a2, sp, 8
98:               csrrs        t2, 0x304, zero
99:               beq          t3, s2, 105f
100:              mulhu        s10, t1, s10
101:              slti         s2, a4, -1200
102:              slti         s3, t1, 1245
103:              srli         s11, t5, 14
104:              slli         s8, s8, 12
105:              slt          gp, t2, s6
106:              rem          a7, s9, a3
107:              srli         s6, a2, 23
108:              divu         gp, t4, a4
109:              nop
110:              bltu         ra, ra, 119f
111:              csrrci       s1, 0x301, 26
112:              or           a4, s6, t3
113:              csrrc        s6, 0x305, zero
114:              mulhu        t0, a4, sp
115:              add          s4, t1, zero
116:              sub          ra, s8, a2
117:              bne          s2, tp, 121f
118:              div          s1, s10, s7
119:              csrrw        t4, 0x343, s6
120:              bne          s4, s10, 135f
121:              csrrs        s8, 0x342, s6
122:              sltu         a1, s4, s7
123:              blt          s4, t1, 129f
124:              csrrwi       a6, 0x342, 15
125:              slt          s7, s1, t1
126:              divu         s6, a5, s7
127:              csrrs        a7, 0x301, zero
128:              slli         s11, t1, 7
129:              rem          s11, t5, t2
130:              remu         a4, t1, s1
131:              mul          s5, ra, s11
132:              div          tp, a0, gp
133:              sltiu        gp, s7, -866
134:              csrrsi       s10, 0x343, 9
135:              rem          zero, t6, s5
136:              andi         t1, a7, 1463
137:              and          s4, s1, t3
138:              rem          a4, a1, t5
139:              xor          s9, s3, a6
140:              lui          t1, 785679
141:              xori         s7, t4, -972
142:              and          a2, s5, s3
143:              and          t2, t4, tp
144:              mulhsu       t5, s10, a4
145:              beq          s5, t2, 151f
146:              add          t6, t0, t3
147:              ori          a2, t2, -504
148:              csrrwi       t0, 0x342, 19
149:              bgeu         ra, zero, 158f
150:              xor          t2, sp, tp
151:              add          s8, s10, s10
152:              sltiu        a4, s5, 28
153:              slti         s4, a7, 1013
154:              sll          s3, t1, s1
155:              slt          s10, a5, s5
156:              bne          t3, s5, 160f
157:              div          a0, tp, s0
158:              nop
159:              nop
160:              nop
161:              csrrs        s9, 0x300, zero
162:              bge          sp, a0, 174f
163:              or           tp, a6, t5
164:              andi         t4, s7, 1956
165:              mulh         s6, s9, tp
166:              lui          t0, 30052
167:              slli         ra, s7, 4
168:              csrrc        s1, 0x301, tp
169:              csrrci       a1, 0x305, 0
170:              bge          s3, t3, 180f
171:              lui          s8, 70063
172:              csrrci       s1, 0x301, 27
173:              andi         t4, s3, -979
174:              srai         tp, t4, 16
175:              slli         a6, t4, 30
176:              nop
177:              srli         gp, zero, 13
178:              sltu         t2, s8, t6
179:              sll          t6, s7, s3
180:              sra          s10, a2, sp
181:              srli         s4, s3, 23
182:              lui          gp, 743295
183:              slli         t5, s11, 31
184:              andi         tp, t5, -54
185:              mulh         a0, s10, a7
186:              srl          t5, s9, a3
187:              or           t5, a4, t2
188:              divu         zero, gp, s2
189:              mulh         s1, t6, a6
190:              slli         s4, t3, 9
191:              sltu         s8, t6, s4
192:              slti         gp, s9, 1366
193:              bge          a2, t2, 203f
194:              csrrs        s11, 0x304, zero
195:              ori          ra, s9, 1792
196:              sra          s9, sp, s4
197:              mulhsu       a7, t3, a7
198:              bltu         tp, t3, 212f
199:              sltu         s4, tp, zero
200:              add          a5, a7, s6
201:              csrrci       s7, 0x304, 25
202:              sltu         a7, a5, s1
203:              lui          a1, 1028728
204:              csrrw        s11, 0x304, tp
205:              add          zero, s2, zero
206:              csrrci       s5, 0x301, 8
207:              nop
208:              sltu         ra, tp, a6
209:              csrrw        a5, 0x343, a1
210:              slli         t1, s8, 19
211:              mulhsu       a6, t2, t1
212:              auipc        a4, 796432
213:              add          a3, t1, a0
214:              or           a2, s11, a3
215:              or           a2, t1, s1
216:              csrrc        s10, 0x305, zero
217:              and          t4, a7, s3
218:              xori         ra, gp, -1114
219:              srli         zero, t6, 11
220:              remu         t2, gp, a7
221:              div          s10, a3, ra
222:              sra          s2, s10, a2
223:              slti         t0, s4, -1121
224:              srai         gp, a1, 18
225:              and          s1, a1, s1
226:              sll          a2, a1, s10
227:              sra          s2, t6, t1
228:              mulhsu       t4, a2, t5
229:              sub          ra, a0, t5
230:              csrrsi       gp, 0x304, 20
231:              srli         a7, s10, 7
232:              or           s4, a5, s3
233:              rem          a1, ra, tp
234:              sra          s8, s7, t0
235:              csrrs        s7, 0x343, a4
236:              mul          s3, s2, s4
237:              srl          s9, t3, t3
238:              slt          t5, zero, tp
239:              csrrc        a4, 0x305, zero
240:              or           a1, s5, zero
241:              sltiu        t4, s10, 236
242:              csrrs        a5, 0x305, zero
243:              or           s8, a0, a3
244:              nop
245:              bge          s6, t4, 248f
246:              csrrs        t1, 0x342, zero
247:              slt          s6, a4, t1
248:              beq          a4, s2, 249f
249:              slt          a5, t2, s4
250:              addi         gp, t4, -1353
251:              slt          s5, t6, a4
252:              mulh         s11, s2, s8
253:              srli         a6, s8, 31
254:              csrrw        s9, 0x301, s1
255:              bltu         t6, a1, 274f
256:              rem          s10, s4, a7
257:              srli         s10, s4, 30
258:              srai         s1, gp, 0
259:              bltu         zero, s8, 279f
260:              srli         s11, s10, 28
261:              sub          s5, a2, a5
262:              xor          a2, a1, t5
263:              ori          s7, s11, -727
264:              ori          t6, t6, -1411
                  slt          zero, t5, gp
                  slli         t1, ra, 20
                  la           gp, sub_2
                  csrrci       s3, 0x343, 0
                  remu         s4, s10, a3
                  divu         t2, tp, s6
                  addi         gp, gp, 682
                  bgeu         sp, a5, sub_1_j3 #branch to jump instr
                  remu         t5, s7, s4
                  mulh         a2, a6, s0
                  sll          a7, s8, t2
                  slli         s6, s9, 26
                  csrrwi       a6, 0x301, 22
sub_1_j3:         jalr         a7, gp, -680 #jump sub_1 -> sub_2
265:              bge          s5, a2, 279f
266:              addi         s10, s9, 961
267:              srl          t4, s3, s2
268:              lui          ra, 497315
269:              sltu         t0, s2, t1
270:              mulhsu       s7, t2, a5
271:              divu         gp, s2, s8
272:              sub          zero, s5, zero
273:              divu         s9, s0, t6
274:              bne          t6, s6, 275f
275:              mulh         s7, s8, a7
276:              ori          a7, a1, 1856
277:              csrrci       a6, 0x343, 0
278:              csrrci       s2, 0x342, 0
279:              divu         t2, a3, s9
280:              or           ra, gp, s3
281:              slti         s1, s11, 832
282:              srli         ra, s5, 13
283:              or           t5, s3, a4
284:              csrrs        s11, 0x305, zero
285:              slt          s5, s6, s0
286:              beq          s4, t1, 290f
287:              slt          s8, t6, s1
288:              slti         a6, t1, -151
289:              slli         a7, s9, 2
290:              bne          a1, s1, 299f
291:              bge          t0, s3, 299f
292:              div          t6, sp, t3
293:              or           t2, gp, a1
294:              mulh         t6, tp, s4
295:              lui          tp, 127910
296:              div          s4, a4, ra
297:              slli         t1, tp, 11
298:              xori         a7, s5, 1155
299:              slli         s5, sp, 27
300:              nop
301:              csrrsi       s8, 0x305, 0
302:              csrrs        t2, 0x305, zero
303:              csrrw        a4, 0x342, a2
304:              slt          t1, t3, s10
305:              add          s8, s6, s8
306:              slli         s4, ra, 0
307:              auipc        tp, 976530
308:              csrrsi       t1, 0x343, 9
309:              nop
310:              srai         t1, s5, 6
311:              srai         a7, tp, 11
312:              slti         a1, zero, -1899
313:              slti         s6, s6, -1447
314:              sltu         a7, t3, s1
315:              mulhsu       ra, t4, t4
316:              bgeu         a1, tp, 322f
317:              and          s7, t1, a3
318:              srl          s7, a5, t5
319:              sll          a6, t4, t5
320:              bltu         s6, s5, 339f
321:              csrrw        gp, 0x342, t6
322:              div          t0, s5, a7
323:              sll          a4, a0, a7
324:              srli         s9, s3, 18
325:              sltiu        s1, a4, 1200
326:              beq          t5, a6, 338f
327:              andi         t5, t2, -856
328:              mulhsu       s9, s9, s5
329:              divu         s9, a7, ra
330:              nop
331:              rem          s1, a0, s5
332:              csrrwi       a7, 0x342, 17
333:              xori         t5, t1, -1193
334:              rem          s2, s10, t5
335:              sll          s7, t2, s3
336:              auipc        a1, 914153
337:              mul          t6, s10, s3
338:              rem          a6, tp, t6
339:              csrrc        s11, 0x342, gp
340:              divu         a5, t0, s11
341:              sltiu        s4, s3, 249
342:              beq          a2, s6, 353f
343:              mulhsu       s2, s10, a4
344:              xori         t0, tp, -1746
345:              slli         a4, s4, 19
346:              auipc        a5, 393927
347:              nop
348:              mul          ra, zero, s3
349:              bne          s2, sp, 364f
350:              srli         t0, t5, 6
351:              mulhsu       s8, sp, s4
352:              mul          s5, s5, zero
353:              ori          ra, s11, 1389
354:              beq          s0, s2, 366f
355:              xori         s8, t4, -1857
356:              or           s3, t4, s1
357:              slli         t0, t1, 23
358:              mul          a4, s4, gp
359:              ori          s1, t0, -610
360:              srai         s8, a0, 3
361:              remu         t6, s11, a0
362:              divu         t4, s3, s11
363:              bge          t0, t4, 370f
364:              csrrs        s7, 0x342, zero
365:              add          s11, s9, s4
366:              sltu         t1, zero, t5
367:              slli         s7, t3, 5
368:              bltu         s3, t1, 376f
369:              div          ra, s4, s4
370:              bgeu         s10, a0, 376f
371:              auipc        a2, 644652
372:              or           t4, ra, s11
373:              slt          a2, a5, t3
374:              ori          a4, s0, -640
375:              sub          s6, s7, sp
376:              slti         s4, s5, 1586
                  xor          a5, t3, a4
                  slti         s1, a3, -592
                  lw           a7, 4(sp)
                  sltu         t1, a3, t5
                  addi         sp, sp, 40
                  slti         t6, ra, 846
                  srl          ra, a3, a3
                  slti         t0, tp, -1449
853:              addi x10, x17, 0
853:              jalr x10, x10, 0
sub_2:            mulhu        t6, zero, t3
                  auipc        gp, 386861
                  addi         sp, sp, -12
                  sltu         zero, ra, t6
                  csrrsi       tp, 0x301, 27
                  sw           a7, 4(sp)
                  xor          t6, s3, t1
                  div          a0, a5, a0
                  sltiu        s10, tp, -1667
                  xori         s1, s3, -1033
                  la           s9, region_1+60983 #start load_store_instr_stream_1
                  lhu          a2, -6(s9)
                  la           s10, region_0+1847 #start load_store_instr_stream_0
                  lh           s4, -12(s9)
                  lhu          gp, -14(s9)
                  lh           a5, 93(s10)
                  sh           s5, -2(s10)
                  lh           s8, -103(s10)
                  lw           ra, 207(s10)
                  lw           t5, 1(s9)
                  sh           a4, 236(s10)
                  sb           s0, -4(s9) #end load_store_instr_stream_1
                  sb           t3, -96(s10) #end load_store_instr_stream_0
                  la           t2, region_1+11738 #start load_store_instr_stream_2
                  la           s4, region_1+42990 #start load_store_instr_stream_0
                  la           t1, region_1+5323 #start load_store_instr_stream_1
                  lhu          zero, 16(t1)
                  sb           a1, -79(t2)
                  lh           s1, -1(s4)
                  sh           t4, 34(t1)
                  lb           t5, 16(s4)
                  lh           a7, 7(t2)
                  lhu          zero, 22(t1)
                  lbu          s9, 159(t2)
                  sw           s3, 16(s4)
                  lh           t6, -37(t1)
                  sw           a5, -45(t1)
                  lbu          a4, 7(s4)
                  lb           a7, 0(s4)
                  sb           a7, 0(t1)
                  lbu          s6, 7(s4)
                  lhu          s3, -12(t2)
                  lb           s3, -46(t2) #end load_store_instr_stream_2
                  lh           s2, 3(t1)
                  sh           a3, 1(s4)
                  lb           s6, -47(t1)
                  lbu          s7, 38(t1)
                  sb           s1, 28(t1) #end load_store_instr_stream_1
                  lw           a2, 14(s4) #end load_store_instr_stream_0
                  la           t4, region_1+52202 #start riscv_load_store_hazard_instr_stream_4
                  sh           t4, 12(t4)
                  sh           t5, 12(t4)
                  lw           a6, 193(t4)
                  lw           t6, 193(t4)
                  lbu          a3, 193(t4)
                  lw           zero, 240(t4)
                  sh           s3, 253(t4)
                  sb           a5, 253(t4)
                  lhu          ra, 253(t4)
                  mulhsu       a6, a1, s1
                  lb           s6, -133(t4)
                  lbu          a5, -133(t4)
                  lbu          s9, -133(t4)
                  lw           a7, -109(t4)
                  lw           s7, -109(t4)
                  sb           s10, -109(t4)
                  sh           s4, -230(t4)
                  lb           a0, -143(t4)
                  sh           s4, -143(t4)
                  lw           t5, 5(t4) #end riscv_load_store_hazard_instr_stream_4
                  la           s7, region_0+3702 #start riscv_load_store_hazard_instr_stream_7
                  lw           zero, -1(s7)
                  srai         a7, t2, 23
                  sw           a0, -1(s7)
                  sb           gp, -1(s7)
                  sw           s5, -1(s7)
                  lbu          t4, -1(s7)
                  sra          t1, sp, s7
                  lh           a0, -1(s7)
                  sh           s6, -1(s7)
                  sh           s3, -1(s7)
                  divu         ra, sp, t6
                  lhu          a3, -1(s7)
                  lw           s4, -1(s7)
                  slti         zero, s10, 475
                  sh           ra, -1(s7)
                  lh           t4, -1(s7)
                  sw           sp, -1(s7) #end riscv_load_store_hazard_instr_stream_7
                  la           s8, region_1+28868 #start load_store_instr_stream_1
                  sw           t1, 245(s8)
                  la           a4, region_1+33950 #start load_store_instr_stream_0
                  la           a2, region_1+3437 #start load_store_instr_stream_3
                  la           a1, region_1+31945 #start load_store_instr_stream_4
                  sh           s5, -1846(a4)
                  lw           a7, 235(s8)
                  sb           a4, 836(a2)
                  lb           zero, 221(a4)
                  sh           s7, 209(a1)
                  la           a6, region_1+45475 #start load_store_instr_stream_2
                  sh           a4, 96(a1)
                  sb           a2, -234(a1)
                  lbu          s1, 55(a2)
                  lbu          t5, -93(s8)
                  lbu          a7, 1803(a6)
                  sh           s6, -33(a1)
                  lhu          s11, -1856(a6)
                  lh           t1, -1031(a2)
                  lb           s6, 70(s8)
                  lbu          s1, -947(a6)
                  lb           a7, -1820(a4)
                  lh           s4, 159(s8)
                  lh           a5, -445(a4)
                  lhu          gp, 1545(a6)
                  lb           s9, -398(a2)
                  lhu          s10, 125(a1)
                  lh           a5, 144(a1)
                  lb           a5, 70(s8)
                  sb           s2, -1660(a2)
                  lhu          t2, -236(s8)
                  lbu          s11, 12(a1)
                  lhu          t6, 623(a6)
                  lhu          tp, 365(a2) #end load_store_instr_stream_3
                  sh           ra, 212(s8) #end load_store_instr_stream_1
                  sb           s5, -232(a1) #end load_store_instr_stream_4
                  sb           t0, -1223(a6) #end load_store_instr_stream_2
                  sw           a7, 824(a4) #end load_store_instr_stream_0
                  la           a0, region_0+816 #start load_store_instr_stream_1
                  la           s7, region_1+48421 #start load_store_instr_stream_0
                  sw           t3, 16(a0)
                  lbu          zero, -84(s7)
                  lhu          ra, -8(a0)
                  lh           a1, -210(s7)
                  lh           gp, -7(a0)
                  sw           tp, -237(s7)
                  sh           s2, -71(s7)
                  sb           t3, -12(a0)
                  lh           s8, -27(a0)
                  lbu          zero, -97(s7)
                  lb           s11, -34(a0)
                  sb           t0, 8(a0)
                  lhu          s6, -118(s7)
                  lw           a4, -45(a0) #end load_store_instr_stream_1
                  sh           s7, 9(s7) #end load_store_instr_stream_0
                  la           gp, region_1+9217 #start riscv_load_store_hazard_instr_stream_5
                  sw           s1, -1596(gp)
                  sh           s9, -1596(gp)
                  lw           a2, -1163(gp)
                  lhu          t0, -1717(gp)
                  lh           t1, 1443(gp)
                  csrrsi       a7, 0x304, 0
                  sb           s2, 1148(gp)
                  lb           s3, 1148(gp)
                  lb           s6, 1148(gp)
                  lbu          t0, 1148(gp)
                  lbu          a7, 1703(gp)
                  sb           a4, -1885(gp)
                  csrrs        a7, 0x305, zero
                  lb           t5, 814(gp)
                  sh           a0, 814(gp)
                  sw           a6, -1513(gp)
                  lh           a4, 366(gp)
                  sh           s11, 366(gp)
                  sb           s1, 102(gp) #end riscv_load_store_hazard_instr_stream_5
                  la           a6, region_1+51002 #start riscv_load_store_rand_instr_stream_3
                  sh           s4, 128(a6)
                  sh           a4, -221(a6)
                  mulh         t0, t1, s9
                  auipc        s3, 538565
                  lbu          s11, 215(a6)
                  lbu          gp, 194(a6)
                  slt          t2, zero, a7
                  and          a3, t6, s4
                  mul          s1, sp, ra
                  lhu          t6, 32(a6)
                  lw           a7, 68(a6)
                  csrrc        s7, 0x343, zero
                  and          a1, gp, s8
                  srl          s7, s4, t4
                  csrrci       a2, 0x300, 0
                  sll          s4, ra, s2
                  addi         zero, sp, 1248
                  xor          zero, s9, s11
                  mul          a4, zero, s5
                  sh           a3, -122(a6)
                  andi         s1, s6, -1815
                  lb           a1, -151(a6)
                  nop
                  sltu         gp, a0, a2
                  lb           s10, -153(a6)
                  lw           t1, -199(a6)
                  lbu          t1, 245(a6)
                  sra          s7, a3, t0
                  sw           a6, -248(a6)
                  srai         ra, gp, 3
                  lbu          t4, -236(a6)
                  auipc        s4, 533755
                  csrrw        s7, 0x342, s11
                  sb           t3, 65(a6)
                  sh           a6, -76(a6)
                  lbu          a2, -162(a6)
                  sll          s8, s3, a0
                  sb           s5, 127(a6)
                  srli         ra, a5, 21
                  srl          s10, t5, s2
                  and          t1, a2, s0
                  sw           a3, 158(a6)
                  lw           t6, 31(a6)
                  sw           s8, 190(a6)
                  lbu          s2, -217(a6)
                  csrrs        a1, 0x304, s8
                  and          t4, t5, a0
                  sh           s3, 160(a6)
                  sra          s4, t6, ra
                  sh           t0, -99(a6) #end riscv_load_store_rand_instr_stream_3
                  la           s6, region_0+2469 #start riscv_load_store_rand_instr_stream_13
                  sltu         t1, a2, s2
                  csrrwi       s10, 0x304, 17
                  srai         s10, s3, 8
                  mulhsu       t6, t2, s9
                  auipc        zero, 981071
                  lb           a5, -16(s6)
                  auipc        a2, 862457
                  slli         tp, s8, 29
                  sh           s10, 8(s6)
                  srai         a1, t4, 16
                  sb           sp, -7(s6)
                  lw           tp, 15(s6)
                  sw           s10, -1(s6)
                  csrrc        t5, 0x342, s9
                  sh           ra, -10(s6)
                  div          t2, a2, a7
                  lbu          s1, 1(s6)
                  sw           s2, -7(s6)
                  lhu          t5, 4(s6)
                  xori         ra, s7, -1274
                  srli         s8, t0, 23
                  sb           t2, -9(s6)
                  lw           s1, -8(s6)
                  slt          s1, s2, a6
                  sh           a0, 6(s6)
                  csrrci       s7, 0x305, 0
                  lbu          a2, 14(s6)
                  lw           a2, 14(s6)
                  or           zero, s2, s8
                  remu         a7, t2, t5
                  lw           t2, 15(s6)
                  lhu          a7, -12(s6)
                  lw           t6, 7(s6)
                  xor          ra, t2, s11
                  and          s1, s0, a5
                  sub          ra, t2, s3
                  csrrw        a2, 0x343, t2
                  sw           t0, -14(s6)
                  sh           a4, 8(s6) #end riscv_load_store_rand_instr_stream_13
                  la           a5, region_0+1599 #start riscv_load_store_rand_instr_stream_8
                  nop
                  lh           s5, -220(a5)
                  sb           a7, 103(a5)
                  lb           zero, -103(a5)
                  sub          s11, a5, a0
                  sb           a7, 253(a5)
                  srai         tp, a6, 19
                  lhu          zero, -198(a5)
                  sw           a0, 85(a5)
                  lui          s1, 757434
                  lw           s4, -179(a5)
                  sw           s8, -19(a5)
                  lbu          s6, -151(a5)
                  mulhsu       a3, s2, tp
                  srai         s11, ra, 20
                  lb           s6, 90(a5)
                  csrrw        s9, 0x304, a0
                  div          a1, zero, t1
                  and          s10, t1, t4
                  sh           s4, -55(a5)
                  lh           a7, -78(a5)
                  nop
                  mulh         s10, t5, t2
                  lh           a6, 86(a5)
                  lhu          s7, 230(a5)
                  lbu          t6, 104(a5)
                  lh           s4, 207(a5)
                  lbu          t2, 175(a5)
                  divu         a0, a0, s6
                  lb           a1, 84(a5)
                  lw           s11, -191(a5)
                  csrrw        a3, 0x343, tp
                  srai         a6, t2, 0
                  lbu          s9, -18(a5)
                  sb           s7, -16(a5)
                  sh           zero, 102(a5)
                  sh           s10, -162(a5)
                  srl          a3, t4, zero
                  srli         s1, t2, 16
                  lh           s1, -19(a5)
                  ori          s2, t2, 436
                  slt          a0, t0, t3
                  sw           t6, 32(a5) #end riscv_load_store_rand_instr_stream_8
                  la           t6, region_1+21596 #start load_store_instr_stream_0
                  la           gp, region_1+58427 #start load_store_instr_stream_1
                  lh           s9, 248(t6)
                  sb           s10, -17(t6)
                  sb           t5, -99(t6)
                  lh           a5, 183(t6)
                  lhu          ra, -4(gp)
                  sw           s1, -99(t6)
                  sb           a7, -140(gp)
                  lw           s3, 29(gp)
                  sb           t1, 30(t6)
                  lbu          a4, 52(t6)
                  lhu          t5, 236(gp)
                  lh           a0, -173(t6)
                  sw           gp, -47(t6)
                  sb           s7, -49(gp) #end load_store_instr_stream_1
                  lb           s7, -112(t6) #end load_store_instr_stream_0
                  la           t5, region_0+712 #start riscv_load_store_hazard_instr_stream_10
                  sw           s10, -130(t5)
                  lh           t2, -130(t5)
                  slli         s8, s4, 2
                  lb           t2, -130(t5)
                  auipc        t2, 326173
                  lb           s4, -130(t5)
                  lw           s5, -130(t5)
                  sw           s3, -130(t5)
                  ori          a5, s0, 713
                  lb           a4, -130(t5)
                  lw           a2, -130(t5)
                  lbu          a3, -130(t5)
                  lw           a6, -130(t5) #end riscv_load_store_hazard_instr_stream_10
                  la           s5, region_0+2052 #start riscv_load_store_rand_instr_stream_6
                  lb           a2, -13(s5)
                  sw           zero, -1(s5)
                  sb           s11, -15(s5)
                  lhu          ra, -5(s5)
                  lhu          a7, -9(s5)
                  addi         a5, s1, -1354
                  lw           a3, 2(s5)
                  srl          s1, a1, a4
                  remu         s9, a1, t0
                  slt          a3, t4, t5
                  sb           ra, -2(s5)
                  sb           s4, 4(s5)
                  sb           t4, -9(s5)
                  rem          a3, t0, a7
                  sra          a0, t0, t6
                  sb           s1, -12(s5)
                  sb           t0, -12(s5)
                  lhu          s4, 4(s5)
                  sh           t2, -11(s5)
                  sb           s2, -2(s5)
                  lui          a5, 120314
                  lw           t2, -12(s5)
                  nop
                  lb           a6, 7(s5)
                  rem          t0, s0, a4
                  sh           s4, -1(s5)
                  sltu         ra, a1, a0
                  sb           a1, -16(s5)
                  sh           ra, -6(s5)
                  lh           s4, 2(s5) #end riscv_load_store_rand_instr_stream_6
                  la           s4, region_1+30112 #start riscv_load_store_rand_instr_stream_5
                  lhu          a1, 6(s4)
                  lw           s3, 1(s4)
                  remu         s6, s8, t2
                  and          tp, s9, a6
                  csrrci       a5, 0x305, 0
                  slti         a6, s6, 1951
                  csrrc        t0, 0x300, zero
                  slti         zero, t0, -161
                  lh           a5, 10(s4)
                  lw           gp, -16(s4)
                  lui          s2, 653073
                  sra          a3, a7, a5
                  and          t4, t4, t6
                  srli         t2, s10, 10
                  mulhu        a3, s5, a7
                  xori         s8, a7, 1475
                  addi         a2, gp, 108
                  xori         a3, s9, 99
                  lh           a1, 14(s4)
                  lw           a2, -12(s4)
                  slt          gp, a4, s2
                  lb           a5, -6(s4)
                  sb           a4, 14(s4)
                  xori         ra, t1, -426
                  mulh         a6, t5, s0
                  csrrsi       t0, 0x342, 0
                  lw           s10, -7(s4)
                  add          t2, t1, a1
                  csrrw        a4, 0x343, s1
                  sb           zero, 3(s4) #end riscv_load_store_rand_instr_stream_5
                  la           s4, region_1+64279 #start riscv_load_store_hazard_instr_stream_6
                  lbu          gp, -52(s4)
                  sw           t5, -52(s4)
                  lw           s10, -52(s4)
                  lbu          a7, -52(s4)
                  sb           a4, -52(s4)
                  sh           gp, -52(s4)
                  lbu          s2, -52(s4)
                  sh           ra, -52(s4)
                  sltu         s9, a7, a6
                  lbu          a5, -52(s4)
                  sh           a3, -52(s4)
                  sh           s1, -52(s4)
                  lh           s2, -52(s4)
                  lw           s7, -52(s4)
                  lw           t4, -52(s4)
                  lb           s1, -52(s4)
                  div          t0, t1, a3
                  lhu          zero, -52(s4) #end riscv_load_store_hazard_instr_stream_6
                  la           t0, region_1+39311 #start riscv_load_store_hazard_instr_stream_8
                  sw           t3, -3(t0)
                  lh           zero, -3(t0)
                  lhu          s4, -2(t0)
                  lhu          tp, -2(t0)
                  lui          a4, 204032
                  sh           ra, -13(t0)
                  csrrsi       a4, 0x304, 30
                  lw           t5, 14(t0)
                  sb           s3, -8(t0)
                  sb           s6, -8(t0)
                  sb           s2, -8(t0)
                  sb           s8, -8(t0)
                  sw           s9, -8(t0)
                  rem          s5, sp, s11
                  sltu         t5, t0, s5
                  lh           t2, -8(t0)
                  sw           s7, -8(t0)
                  csrrsi       a3, 0x301, 26
                  ori          s5, zero, 231
                  sb           a7, -8(t0)
                  lw           t6, -8(t0) #end riscv_load_store_hazard_instr_stream_8
                  la           a6, region_0+3140 #start riscv_load_store_hazard_instr_stream_11
                  lh           t2, -58(a6)
                  sb           s8, -58(a6)
                  lbu          tp, 60(a6)
                  lbu          s8, 60(a6)
                  mulhsu       a3, s8, zero
                  lb           t1, 60(a6)
                  sw           s3, 60(a6)
                  sb           sp, -61(a6)
                  lhu          a4, 38(a6)
                  sh           a1, -23(a6)
                  csrrs        t5, 0x301, a6
                  nop
                  lbu          t4, 33(a6)
                  lhu          a7, 33(a6)
                  lbu          a3, 23(a6) #end riscv_load_store_hazard_instr_stream_11
                  la           t2, region_0+485 #start riscv_load_store_hazard_instr_stream_3
                  lh           a3, 102(t2)
                  lw           t6, 157(t2)
                  and          s8, t2, a1
                  sh           t0, -216(t2)
                  lh           s8, 261(t2)
                  sb           tp, 261(t2)
                  sh           a0, -446(t2)
                  remu         s9, t2, s2
                  srli         zero, t3, 11
                  csrrsi       s5, 0x305, 0
                  sra          s5, tp, a7
                  div          s3, s2, s5
                  sb           t2, 102(t2)
                  sh           a0, 1906(t2)
                  sw           s6, 655(t2)
                  lbu          a3, 655(t2)
                  lhu          a5, 1610(t2)
                  sw           a3, 1610(t2) #end riscv_load_store_hazard_instr_stream_3
                  la           s1, region_0+3350 #start riscv_load_store_rand_instr_stream_12
                  lh           t2, -1486(s1)
                  lw           a3, 120(s1)
                  csrrw        t1, 0x343, a4
                  lw           t5, -585(s1)
                  lb           s7, -1719(s1)
                  lb           s10, -1183(s1)
                  lh           gp, -238(s1)
                  lbu          s10, -827(s1)
                  sh           s3, -1005(s1)
                  lh           a1, 487(s1)
                  addi         t5, t3, -457
                  sll          s10, s1, s6
                  sh           a1, -596(s1)
                  sw           t2, -554(s1)
                  lhu          s2, 262(s1)
                  addi         t2, s8, -300
                  sb           s1, -505(s1)
                  nop
                  mulhsu       s11, a7, a0
                  sw           s11, -1359(s1)
                  sw           s10, -1596(s1)
                  lbu          t5, -35(s1)
                  lhu          t1, -398(s1)
                  remu         s4, a6, s7
                  sw           s10, 391(s1)
                  mul          t1, s4, s6
                  lbu          t1, -1644(s1)
                  lh           s4, -1741(s1)
                  lh           zero, -753(s1)
                  lw           s2, -1019(s1)
                  sh           a2, -584(s1)
                  sb           t4, -1836(s1)
                  csrrs        t1, 0x343, zero
                  lb           t4, -1773(s1)
                  lb           gp, -585(s1)
                  lh           a0, 713(s1)
                  slt          t2, s1, s4
                  sw           s11, 545(s1) #end riscv_load_store_rand_instr_stream_12
                  la           s10, region_0+3336 #start riscv_load_store_hazard_instr_stream_9
                  sh           s2, -1649(s10)
                  sltiu        a5, t4, 2029
                  lbu          a2, -1649(s10)
                  lhu          a0, -1649(s10)
                  lw           t0, -434(s10)
                  lhu          s6, -434(s10)
                  lw           t1, -301(s10)
                  lb           a0, -301(s10)
                  lh           s5, -301(s10)
                  lbu          a4, -301(s10)
                  lbu          s8, -301(s10)
                  lw           s2, 671(s10)
                  lh           s4, 671(s10)
                  lh           s3, 671(s10)
                  sw           s3, 671(s10)
                  lh           a0, 671(s10)
                  lh           s8, 671(s10)
                  lhu          zero, 671(s10)
                  lw           gp, 671(s10)
                  lh           a4, 671(s10) #end riscv_load_store_hazard_instr_stream_9
                  la           t5, region_1+5033 #start riscv_load_store_hazard_instr_stream_12
                  lbu          s6, -640(t5)
                  lw           s9, -640(t5)
                  lhu          s1, -640(t5)
                  or           t4, a1, gp
                  lhu          s11, -640(t5)
                  sb           s5, -640(t5)
                  xori         a1, a1, 656
                  add          a7, s3, a7
                  lb           t2, -640(t5)
                  sb           s10, -1597(t5)
                  divu         t1, s1, a2
                  xor          a0, a2, s6
                  lbu          zero, -1597(t5)
                  sb           t0, 1668(t5)
                  sw           s0, 1668(t5)
                  lhu          a2, 1668(t5)
                  lh           s3, 41(t5)
                  slt          t6, s8, sp
                  lbu          a0, 41(t5)
                  lhu          t1, 41(t5)
                  lw           a0, 41(t5)
                  csrrw        ra, 0x343, sp
                  sh           a7, 432(t5)
                  sh           sp, -884(t5) #end riscv_load_store_hazard_instr_stream_12
                  la           t1, region_1+30861 #start riscv_load_store_hazard_instr_stream_13
                  lh           t2, 35(t1)
                  lb           a3, 52(t1)
                  lb           t5, -27(t1)
                  lhu          a3, -27(t1)
                  lb           t0, -27(t1)
                  sb           a7, -27(t1)
                  lhu          a4, -27(t1)
                  sw           a4, -27(t1)
                  lbu          s3, -13(t1)
                  or           s10, zero, zero
                  sh           sp, -13(t1)
                  sh           s2, 63(t1)
                  lb           tp, 63(t1)
                  sra          s9, a4, s2
                  slt          zero, s1, s3
                  sh           s10, 63(t1)
                  lw           a1, 63(t1)
                  lw           a1, -36(t1)
                  lw           s4, -36(t1)
                  lhu          s7, -36(t1)
                  slli         s6, t1, 26
                  lh           a5, -36(t1)
                  add          a7, t3, t5
                  lbu          s3, -7(t1) #end riscv_load_store_hazard_instr_stream_13
                  la           t0, region_1+50944 #start riscv_load_store_hazard_instr_stream_1
                  lbu          a3, 448(t0)
                  lbu          a6, 448(t0)
                  lb           t5, -141(t0)
                  lw           a2, -141(t0)
                  andi         s2, a2, -1288
                  lhu          a7, 1726(t0)
                  sh           a0, 1726(t0)
                  lh           s5, 1726(t0)
                  lb           ra, -1643(t0)
                  remu         t1, a2, t0
                  lhu          s8, -1643(t0)
                  sh           sp, -1643(t0)
                  sh           tp, -1538(t0)
                  lw           a7, -1538(t0)
                  lb           t2, -1538(t0)
                  lbu          gp, -1538(t0)
                  lw           s9, -1538(t0)
                  sh           gp, -1538(t0) #end riscv_load_store_hazard_instr_stream_1
                  la           s2, region_1+25421 #start riscv_load_store_rand_instr_stream_14
                  lbu          s1, -36(s2)
                  auipc        t1, 481074
                  lw           s3, -3(s2)
                  lbu          t2, -59(s2)
                  div          s6, a5, a4
                  lw           a5, -12(s2)
                  srli         s8, tp, 20
                  xor          s9, t2, a1
                  sw           gp, 38(s2)
                  sw           a7, -13(s2)
                  lhu          s7, -14(s2)
                  lb           gp, -37(s2)
                  mulhsu       s10, tp, s9
                  slt          s6, zero, a7
                  rem          t0, t1, zero
                  sll          a2, a6, a4
                  andi         t0, a6, -1986
                  xor          a5, t3, s10
                  lb           a1, 7(s2)
                  and          t6, a6, a0
                  slti         s6, t3, 1207
                  sltiu        a2, a2, -223
                  div          s8, a0, a4
                  lw           t6, -24(s2)
                  csrrci       a0, 0x343, 24
                  sb           zero, -39(s2)
                  sb           t5, -36(s2)
                  lh           t5, -44(s2) #end riscv_load_store_rand_instr_stream_14
                  la           t1, region_0+2496 #start riscv_load_store_rand_instr_stream_0
                  mulh         a0, a3, a1
                  lhu          zero, -2(t1)
                  slli         t0, sp, 11
                  or           s4, s0, t1
                  sb           a1, -15(t1)
                  lbu          a1, 14(t1)
                  lh           t6, 6(t1)
                  slt          s7, t6, zero
                  lhu          gp, 12(t1)
                  add          t5, ra, s8
                  srl          a7, tp, t2
                  slli         a4, s8, 14
                  sw           gp, 10(t1)
                  sra          t2, sp, s3
                  lb           zero, -13(t1)
                  mulhu        t6, s4, s2
                  sh           s10, -9(t1)
                  csrrc        s2, 0x343, s1
                  ori          gp, a6, 128
                  lbu          s8, -11(t1)
                  lw           gp, 8(t1)
                  slti         ra, s3, 1027
                  lhu          s1, -10(t1)
                  addi         s11, t1, -130
                  auipc        a6, 497994
                  nop
                  sw           s5, 16(t1)
                  lw           s6, -10(t1)
                  lh           ra, 0(t1)
                  slli         s9, s5, 0
                  sw           t6, 11(t1)
                  remu         a5, s1, a1
                  sw           s4, -7(t1)
                  sh           t5, 16(t1)
                  sw           zero, 9(t1) #end riscv_load_store_rand_instr_stream_0
                  la           t1, region_0+2506 #start riscv_load_store_rand_instr_stream_4
                  mul          a3, tp, s5
                  csrrci       tp, 0x305, 0
                  srl          s7, zero, ra
                  lhu          s10, 57(t1)
                  lb           a0, 15(t1)
                  slt          a3, s0, t5
                  mulhu        t4, a0, t1
                  auipc        s9, 812825
                  sh           s3, -10(t1)
                  lh           t5, -52(t1)
                  csrrw        s2, 0x301, t2
                  lh           a5, -25(t1)
                  sltiu        zero, s9, -238
                  csrrc        s10, 0x343, a6
                  sb           sp, 22(t1)
                  mulhu        a5, t3, a4
                  lw           a3, 25(t1)
                  lb           s5, 19(t1)
                  srai         s10, s10, 5
                  lb           ra, 22(t1)
                  lh           ra, -39(t1)
                  remu         a3, s4, s11
                  srli         t0, t2, 18
                  lhu          a6, 22(t1)
                  lw           a7, -10(t1)
                  lbu          s2, -13(t1)
                  lw           a0, 22(t1)
                  sw           a0, -45(t1)
                  mulhu        a7, t6, t0
                  lh           t2, -60(t1)
                  sw           ra, 49(t1)
                  lh           s11, -22(t1)
                  csrrc        s7, 0x304, zero
                  sub          a7, t1, tp
                  sw           t5, 34(t1)
                  xor          s7, s0, a0
                  lw           a1, -26(t1)
                  xor          s8, s10, t4
                  sw           a3, 31(t1)
                  lw           t5, -26(t1)
                  remu         ra, s6, t1
                  lw           a7, 19(t1)
                  sw           gp, 14(t1)
                  lh           t2, -19(t1)
                  lw           a0, 21(t1)
                  csrrsi       s9, 0x300, 0
                  lbu          s3, 26(t1) #end riscv_load_store_rand_instr_stream_4
                  la           t5, region_1+46506 #start riscv_load_store_hazard_instr_stream_14
                  lhu          s11, 16(t5)
                  lw           a4, 16(t5)
                  sh           s6, 16(t5)
                  sh           zero, 16(t5)
                  sw           a1, 16(t5)
                  sb           t3, 16(t5)
                  csrrci       s11, 0x300, 0
                  srl          ra, s11, s3
                  sll          s9, a1, t0
                  lb           s1, 16(t5)
                  lh           a5, -55(t5)
                  lh           s10, -55(t5)
                  csrrsi       a1, 0x301, 0
                  addi         t2, s4, -796
                  srl          s2, a5, a6
                  sh           t0, -55(t5) #end riscv_load_store_hazard_instr_stream_14
                  la           s10, region_1+49211 #start riscv_load_store_rand_instr_stream_2
                  lw           a2, 9(s10)
                  lh           ra, -15(s10)
                  lbu          a2, -4(s10)
                  lb           s4, 4(s10)
                  slt          s1, s3, s4
                  sw           zero, -15(s10)
                  lhu          zero, -10(s10)
                  xor          s6, s11, t2
                  lh           a0, 4(s10)
                  sw           a5, -15(s10)
                  xor          a3, s4, s5
                  or           t1, t5, t0
                  add          ra, s10, gp
                  lw           t1, 6(s10)
                  lhu          s4, -16(s10)
                  sb           s10, 11(s10)
                  mulh         t2, a0, t6
                  lh           gp, 14(s10)
                  sw           s11, -15(s10)
                  csrrci       a7, 0x342, 0
                  sw           t3, -8(s10)
                  lb           zero, 14(s10)
                  lh           a7, -5(s10)
                  lbu          s6, -10(s10)
                  srli         t5, zero, 1
                  lw           t5, -3(s10)
                  sltu         s2, t2, t0
                  csrrwi       s3, 0x304, 2
                  lhu          t5, -9(s10)
                  lhu          a7, -9(s10)
                  xori         ra, sp, 1465
                  mulhu        s9, a1, a7
                  auipc        a7, 935796
                  auipc        tp, 864555
                  addi         s2, s2, 1618
                  lb           s6, -9(s10) #end riscv_load_store_rand_instr_stream_2
                  la           t4, region_1+55526 #start load_store_instr_stream_1
                  sb           t1, -30(t4)
                  la           a5, region_0+1527 #start load_store_instr_stream_0
                  sh           tp, -11(a5)
                  lw           a1, 4(t4)
                  lb           t0, 23(t4)
                  lbu          a7, -144(a5)
                  sh           a3, -43(t4)
                  lhu          s7, 18(a5)
                  sh           s11, 64(a5)
                  lh           a4, -6(t4)
                  sb           s6, -205(a5)
                  lb           t0, -223(a5)
                  lw           t0, 7(t4)
                  sh           s3, -20(t4)
                  sb           t5, 234(a5)
                  lh           a7, -9(t4)
                  lw           t1, -28(t4)
                  lb           s6, -147(a5)
                  lhu          gp, -53(t4) #end load_store_instr_stream_1
                  lb           s8, 121(a5) #end load_store_instr_stream_0
                  la           s5, region_0+3629 #start riscv_load_store_hazard_instr_stream_2
                  sll          s9, t1, a5
                  slt          a0, s4, s3
                  lh           t4, -52(s5)
                  sw           s2, -52(s5)
                  srl          t4, a2, s9
                  lbu          a7, 57(s5)
                  sb           s4, 57(s5)
                  sb           t6, 54(s5)
                  lw           t0, 54(s5)
                  lh           t2, -62(s5)
                  lb           zero, -30(s5)
                  sh           s4, -34(s5)
                  lhu          s2, -34(s5)
                  lhu          t6, -49(s5)
                  lbu          t5, 3(s5)
                  sh           s2, 18(s5)
                  lh           t6, 18(s5)
                  sh           a7, 64(s5)
                  lb           s6, 64(s5)
                  sh           t6, 14(s5)
                  csrrwi       gp, 0x301, 23
                  ori          t4, s2, 63
                  lb           s9, -44(s5)
                  ori          s8, sp, -1749
                  lh           gp, -44(s5) #end riscv_load_store_hazard_instr_stream_2
                  la           t4, region_1+59216 #start riscv_load_store_rand_instr_stream_1
                  csrrwi       s6, 0x301, 18
                  andi         s10, s8, -1321
                  csrrwi       a0, 0x342, 30
                  lw           a6, 132(t4)
                  lb           a5, 89(t4)
                  lbu          a1, -100(t4)
                  srli         a4, sp, 15
                  sb           a7, -30(t4)
                  sltu         s11, zero, s10
                  lw           a5, 86(t4)
                  sb           zero, 222(t4)
                  lw           s9, 37(t4)
                  csrrc        a0, 0x343, s3
                  add          s7, tp, t5
                  lh           a3, -13(t4)
                  auipc        a7, 155282
                  sub          s1, a7, ra
                  xori         a0, s7, 1895
                  lb           a5, 11(t4)
                  divu         s4, t0, s5
                  andi         ra, gp, -513
                  sh           a2, 190(t4)
                  ori          s11, t2, 616
                  lb           s9, -169(t4) #end riscv_load_store_rand_instr_stream_1
                  la           s10, region_1+35652 #start riscv_load_store_rand_instr_stream_10
                  mulh         s4, s7, tp
                  remu         s4, t0, t3
                  sh           t6, 6(s10)
                  lhu          s3, -8(s10)
                  sh           t2, -15(s10)
                  mulhsu       a4, s6, s2
                  lui          s7, 152748
                  slt          s7, t6, a0
                  lw           tp, 14(s10)
                  lw           s8, -13(s10)
                  lw           s11, 14(s10)
                  rem          ra, s9, s3
                  lh           s7, -6(s10)
                  and          t1, s9, t4
                  sh           tp, -3(s10)
                  sb           t3, -5(s10)
                  or           s3, s3, s3
                  sb           s5, -7(s10)
                  slti         tp, a6, 239
                  csrrw        s2, 0x301, sp
                  sra          a2, s0, t4
                  srl          a1, a7, s5
                  csrrci       a5, 0x304, 23
                  srli         a6, s7, 8
                  slt          gp, s5, t1
                  lui          s2, 526272
                  srl          a2, t2, a2
                  lh           t1, 6(s10)
                  lh           s7, -12(s10)
                  addi         s9, a6, -1483
                  lh           a5, 4(s10)
                  lh           a0, -6(s10)
                  csrrc        ra, 0x301, a3
                  lb           s5, -5(s10)
                  lhu          s6, -16(s10)
                  lw           a0, 12(s10)
                  nop
                  lw           a3, 3(s10)
                  lh           s5, 4(s10)
                  lbu          t6, -7(s10) #end riscv_load_store_rand_instr_stream_10
                  la           t5, region_0+2383 #start riscv_load_store_rand_instr_stream_7
                  sra          a1, s7, t4
                  auipc        s11, 967679
                  srl          a3, zero, t5
                  sw           gp, -13(t5)
                  sw           a2, 27(t5)
                  sb           t0, 15(t5)
                  lw           a7, -11(t5)
                  lui          ra, 980753
                  sw           gp, -19(t5)
                  sra          s11, s2, s11
                  lhu          t6, 60(t5)
                  andi         s5, t3, 1665
                  lb           tp, 23(t5)
                  rem          a6, sp, s2
                  csrrw        s8, 0x342, t6
                  sb           a4, 33(t5)
                  lb           s4, -50(t5)
                  lw           a5, 40(t5)
                  lbu          s4, 21(t5)
                  lbu          s1, 60(t5)
                  sra          a6, t5, s2
                  csrrci       s10, 0x300, 0
                  sb           s8, -28(t5)
                  ori          s9, s5, -1275
                  lhu          s11, 23(t5)
                  sb           s11, -42(t5)
                  sub          s7, a4, zero
                  sw           s11, 4(t5)
                  lw           s3, 15(t5)
                  xori         s9, t4, 238
                  sw           tp, -43(t5) #end riscv_load_store_rand_instr_stream_7
0:                srai         t0, a7, 26
1:                or           gp, s4, a2
2:                beq          s11, s7, 18f
3:                beq          s7, ra, 12f
4:                and          s3, t1, a1
5:                sltiu        a7, ra, -1482
6:                srl          s3, a4, t3
7:                xori         ra, s4, -1187
8:                bltu         s10, t4, 16f
9:                lui          a3, 999317
10:               rem          gp, s9, t6
11:               bge          tp, a1, 27f
12:               mul          t4, t0, gp
13:               slt          a5, sp, s0
14:               slti         t6, s7, 910
15:               xor          a3, gp, a0
16:               lui          a6, 418840
17:               mulhsu       s1, gp, a3
18:               rem          s4, a7, ra
19:               csrrs        t2, 0x305, zero
20:               blt          s5, t0, 23f
21:               mulhu        s3, t4, s9
22:               mul          s3, gp, a7
23:               srli         a4, tp, 21
24:               slli         s10, s0, 17
25:               remu         s9, s3, t1
26:               srl          a0, zero, sp
27:               mulhu        a7, a1, s8
28:               and          t2, s1, zero
29:               add          t1, s11, t4
30:               slt          a4, gp, s8
31:               blt          sp, a1, 51f
32:               csrrc        a7, 0x304, a6
33:               sltiu        t6, a1, -927
34:               divu         a2, a6, t4
35:               bltu         gp, a5, 46f
36:               srai         s8, s6, 16
37:               bgeu         s8, sp, 40f
38:               divu         t2, a0, a5
39:               sll          s4, a4, t6
40:               div          a6, t3, s3
41:               ori          a1, t5, -419
42:               rem          t6, t2, a7
43:               bgeu         t0, t5, 58f
44:               xori         a3, s4, -1635
45:               add          ra, s4, s9
46:               rem          s4, ra, t5
47:               or           a3, s3, t6
48:               xori         gp, t4, 403
49:               slli         s8, a2, 20
50:               auipc        a3, 906527
51:               bne          s10, a4, 63f
52:               sll          a1, s3, t5
53:               beq          s1, gp, 56f
54:               slti         a5, t1, -646
55:               slti         a5, s8, -326
56:               slt          t6, ra, tp
57:               div          s2, t1, a0
58:               csrrwi       s8, 0x304, 1
59:               nop
60:               nop
61:               mulhsu       t6, ra, s9
62:               add          s11, t5, sp
63:               xor          t0, t6, s10
64:               mulhu        t0, s9, s3
65:               add          a7, s11, t2
66:               sltiu        s5, a0, -2031
67:               bne          a6, gp, 71f
68:               mul          s7, tp, s5
69:               mulhu        s1, ra, s6
70:               sltiu        zero, s4, -70
71:               ori          s6, a3, 736
72:               mulhsu       s8, t3, a0
73:               divu         t1, ra, s5
74:               mulhsu       a6, s9, s4
75:               bne          a1, t3, 81f
76:               bltu         a1, a7, 77f
77:               csrrci       s9, 0x342, 0
78:               mul          a0, a3, t5
79:               and          s5, a2, t0
80:               bgeu         gp, s0, 95f
81:               csrrsi       s4, 0x300, 0
82:               csrrw        a3, 0x342, t5
83:               bltu         s0, s4, 89f
84:               ori          a7, gp, 1524
85:               ori          s4, s10, -2038
86:               csrrsi       s4, 0x305, 0
87:               sltiu        s1, t0, -1268
88:               csrrci       a1, 0x304, 0
89:               csrrw        a2, 0x301, a6
90:               srl          s5, a1, s4
91:               remu         s10, t2, a0
92:               bne          s1, s7, 95f
93:               xori         s10, s5, 1725
94:               srl          s6, ra, t6
95:               bgeu         zero, s9, 103f
96:               csrrsi       s1, 0x342, 8
97:               sub          t4, a7, s0
98:               blt          a5, s0, 114f
99:               auipc        t2, 304319
100:              rem          s5, a4, t6
101:              nop
102:              bge          s3, s10, 115f
103:              xori         t2, a0, 1549
104:              sra          s8, a0, a1
105:              addi         a4, a4, 859
106:              sltu         t0, a7, t3
107:              lui          a0, 317063
108:              srl          a6, s10, gp
109:              sll          s3, s4, a4
110:              rem          s6, a2, s9
111:              slli         s9, ra, 6
112:              ori          a7, s0, -484
113:              and          a7, s1, t3
114:              srai         t4, s9, 20
115:              sll          s11, s11, t0
116:              mulhu        s1, t2, a1
117:              bne          t1, t6, 127f
118:              slti         a1, a7, -1586
119:              bge          a7, s9, 127f
120:              div          s1, tp, t5
121:              srai         t0, a6, 23
122:              sra          s11, s11, sp
123:              sra          t6, tp, a2
124:              div          s2, a3, ra
125:              slti         t6, a5, -754
126:              blt          t4, zero, 127f
127:              mulh         tp, zero, s11
128:              slti         zero, a4, 995
129:              rem          t4, a6, t0
130:              sltiu        s8, gp, -290
131:              or           s1, a1, s7
132:              xori         a1, s8, 1035
133:              add          ra, t0, s7
134:              blt          s1, a0, 135f
135:              csrrwi       s2, 0x304, 29
136:              csrrc        s10, 0x304, s5
137:              srl          s4, s0, t0
138:              or           zero, a3, t4
139:              add          t6, s11, a3
140:              sltiu        s11, a6, -800
141:              csrrci       ra, 0x301, 22
142:              sll          t5, a0, a1
143:              bge          s4, s3, 146f
144:              ori          a3, t2, 1462
145:              andi         t4, s6, 1119
146:              divu         a1, gp, t1
147:              addi         s6, s7, -1686
148:              slli         a3, s7, 14
149:              csrrwi       a0, 0x342, 0
150:              bne          ra, s10, 156f
151:              slt          t6, s0, sp
152:              bne          t4, gp, 163f
153:              mulhsu       t1, a7, s2
154:              srai         t6, t4, 28
155:              srli         a2, s1, 29
156:              lui          s8, 997331
157:              add          s6, s4, s6
158:              div          s3, a2, t2
159:              mulhsu       a0, t1, t5
160:              bge          t3, s4, 177f
161:              and          a2, a7, a5
162:              beq          ra, s10, 180f
163:              bne          a5, t1, 174f
164:              sra          s4, t5, s5
165:              csrrwi       a0, 0x304, 1
166:              addi         t6, s4, -1592
167:              sll          s10, a2, s3
168:              sub          a4, a4, sp
169:              bne          gp, a4, 172f
170:              sra          a7, a5, a1
171:              srai         a3, t6, 15
172:              srli         a1, t1, 6
173:              sra          s5, s10, a7
174:              slti         t6, a5, 645
175:              div          s10, s9, s0
176:              csrrsi       s4, 0x304, 17
177:              srli         s1, a6, 23
178:              addi         s9, sp, 24
179:              bge          ra, s5, 199f
180:              auipc        t4, 919204
181:              slti         zero, t2, 1335
182:              mulhu        s6, s8, t1
183:              csrrwi       t6, 0x304, 15
184:              mulh         a7, a6, t0
185:              sra          s3, a0, s8
186:              mulhsu       t0, s4, s2
187:              mulh         t5, t1, a2
188:              csrrci       s6, 0x343, 27
189:              remu         s4, t6, s5
190:              mul          zero, a1, sp
191:              csrrw        t1, 0x343, t4
192:              mulhu        s11, a5, s7
193:              andi         t0, s4, 1195
194:              sub          s10, s6, a2
195:              nop
196:              slt          s5, s6, s6
197:              or           a5, s7, gp
198:              div          s7, t3, s8
199:              slli         s10, s11, 27
200:              add          tp, s8, a2
201:              csrrc        s7, 0x304, a5
202:              div          s9, t4, t4
203:              ori          s6, s1, 471
204:              remu         t4, s3, s11
205:              xor          s1, s3, s4
206:              bgeu         zero, a5, 214f
207:              rem          a4, a1, s8
208:              bltu         t6, s8, 219f
209:              sltu         t4, zero, s9
210:              divu         s1, s5, s3
211:              div          ra, s7, s8
212:              ori          a3, s2, -1951
213:              slt          t0, zero, s4
214:              add          s1, s6, a1
215:              csrrw        t4, 0x301, s4
216:              bge          s2, s2, 219f
217:              bge          t1, t3, 230f
218:              remu         a5, s6, a5
219:              sra          t4, tp, a2
220:              and          t5, s10, t2
221:              add          t5, tp, a2
222:              remu         a3, t5, s9
223:              bge          a0, a5, 224f
224:              bgeu         s2, sp, 232f
225:              srl          s10, a4, ra
226:              bge          a3, a7, 242f
227:              mul          t4, s5, t6
228:              sltu         zero, s4, a3
229:              ori          t6, t4, -1991
230:              bge          s7, t1, 236f
231:              lui          a3, 726471
232:              sub          ra, t5, s0
233:              csrrw        gp, 0x342, t5
234:              auipc        t5, 584421
235:              mul          a4, s9, ra
236:              div          a5, t5, s6
237:              bgeu         a7, s3, 252f
238:              csrrw        a4, 0x342, s9
239:              and          gp, s10, a6
240:              addi         a6, a5, 181
241:              xori         gp, t0, 1045
242:              slli         tp, a1, 25
243:              andi         a4, a6, 774
244:              andi         a7, t1, -894
245:              srli         ra, a1, 10
246:              slt          s3, ra, a3
247:              srli         s4, sp, 8
248:              xori         a5, t0, -1060
249:              sltiu        s5, sp, 1136
250:              blt          s4, s5, 259f
                  la           s10, region_1+10973 #start riscv_load_store_hazard_instr_stream_0
                  lbu          t2, 154(s10)
                  lh           s7, 64(s10)
                  sh           s1, -222(s10)
                  lb           t1, -222(s10)
                  lbu          a0, -222(s10)
                  lbu          s9, -222(s10)
                  sh           t0, -222(s10)
                  sh           s8, -222(s10)
                  sh           s5, -222(s10)
                  sh           s2, 49(s10)
                  lhu          a7, 49(s10)
                  sb           ra, 49(s10)
                  lb           s2, 170(s10)
                  auipc        t4, 178173
                  sll          a4, s6, tp
                  sh           t3, 170(s10)
                  lhu          a4, -180(s10)
                  sw           a4, -59(s10)
                  lhu          a4, -59(s10)
                  lh           a5, -59(s10)
                  sh           s5, 224(s10) #end riscv_load_store_hazard_instr_stream_0
251:              csrrc        s6, 0x300, zero
252:              bltu         a7, s4, 260f
253:              csrrsi       tp, 0x301, 13
254:              ori          a7, ra, -1031
255:              csrrwi       a1, 0x301, 4
256:              blt          s1, s4, 272f
257:              nop
258:              xori         s4, t3, -1766
259:              bltu         s0, t0, 262f
260:              slli         t6, tp, 10
                  la           a7, region_0+2764 #start riscv_load_store_rand_instr_stream_9
                  sh           t2, 448(a7)
                  or           a1, s11, s7
                  srl          gp, t0, a0
                  nop
                  mulhu        s2, t2, t2
                  csrrs        s7, 0x301, zero
                  rem          t0, zero, zero
                  sw           a5, 864(a7)
                  add          s11, sp, s9
                  sra          s5, ra, t1
                  sw           s11, -1648(a7)
                  lb           t1, -49(a7)
                  sw           a2, -1366(a7)
                  srli         a0, t0, 5
                  lb           s2, 654(a7)
                  lw           s4, -1013(a7)
                  slti         s8, t4, -1480
                  csrrci       s6, 0x342, 0
                  srl          s4, a6, a2
                  sh           s3, 1019(a7)
                  csrrc        s5, 0x300, zero
                  sh           t5, 981(a7)
                  lh           s4, -17(a7)
                  slt          s5, t2, s9
                  mulh         a2, s10, s8
                  csrrwi       zero, 0x343, 18
                  auipc        zero, 416489
                  sltiu        s3, zero, 427
                  csrrw        a6, 0x304, s8
                  sh           t6, -903(a7)
                  lhu          t4, -1209(a7)
                  sltiu        s10, s8, -1288
                  sh           a5, -461(a7)
                  csrrs        a2, 0x304, s7
                  srli         s10, s1, 26
                  sb           sp, -781(a7)
                  ori          t6, a7, -1436
                  lb           t2, 526(a7)
                  addi         t4, s1, 204
                  nop
                  csrrwi       a0, 0x301, 13
                  lhu          s10, -108(a7)
                  sh           t4, -1217(a7)
                  sw           t1, -880(a7)
                  csrrw        gp, 0x301, s4
                  lw           a2, -1857(a7)
                  sh           ra, -1851(a7)
                  sll          gp, zero, s3
                  sh           zero, -844(a7)
                  lw           ra, -378(a7)
                  divu         a1, sp, a6
                  lh           ra, -605(a7)
                  lhu          a5, -1043(a7)
                  lh           a6, -694(a7)
                  andi         s5, gp, 1484
                  sw           a7, 571(a7) #end riscv_load_store_rand_instr_stream_9
261:              nop
262:              nop
263:              bge          ra, t5, 269f
264:              mulhsu       a3, t2, s5
265:              csrrc        s11, 0x301, gp
266:              addi         s10, s2, -1968
267:              ori          gp, a4, 1511
268:              csrrc        ra, 0x305, zero
269:              srl          t5, t2, s2
270:              slt          s10, gp, zero
271:              srli         t0, s3, 3
272:              div          s1, t6, s0
273:              csrrci       zero, 0x304, 9
274:              sll          a1, t6, s0
275:              bltu         s7, s10, 286f
276:              bge          s0, tp, 277f
277:              xori         s5, a7, 1679
278:              add          tp, s4, s2
279:              csrrs        ra, 0x304, zero
280:              csrrw        a0, 0x343, t4
281:              slt          t0, a2, s5
282:              rem          gp, s7, s6
283:              slt          a1, s11, a1
284:              div          a3, t0, t0
285:              add          a4, s9, s6
286:              csrrci       tp, 0x300, 0
287:              slli         s3, s11, 7
288:              bne          s5, t5, 291f
289:              srli         a4, t2, 8
290:              divu         s3, s4, t6
291:              xor          t6, t3, gp
292:              sub          tp, a2, a6
293:              slli         a6, t3, 14
294:              csrrw        a4, 0x304, a4
295:              remu         a4, a5, s1
296:              mul          s6, t0, s4
297:              sltiu        tp, a1, 1071
298:              csrrwi       ra, 0x304, 28
299:              bgeu         a5, a0, 315f
300:              mulh         t2, a3, gp
301:              lui          s5, 822719
302:              slli         ra, gp, 9
303:              csrrw        a4, 0x304, s9
304:              lui          s11, 781824
305:              mulhu        a5, s0, s6
306:              csrrc        zero, 0x304, s0
307:              mulh         a4, t2, a7
308:              lui          t6, 75517
309:              beq          sp, t2, 324f
310:              and          zero, a0, t0
311:              ori          tp, s2, 1800
312:              auipc        s6, 159174
313:              slli         t2, s10, 22
314:              xori         gp, ra, -410
315:              srai         a5, zero, 9
316:              sltiu        t0, s4, 1527
317:              and          s7, tp, s3
318:              mulh         a7, a1, s11
319:              sltiu        a2, a6, -1657
320:              csrrci       ra, 0x301, 6
321:              bne          s2, t2, 332f
322:              bge          gp, s3, 323f
323:              nop
324:              sra          t1, gp, s4
325:              slli         s7, ra, 14
326:              csrrw        tp, 0x304, t2
327:              mulhu        zero, a5, s5
328:              bltu         s5, s3, 346f
329:              mul          s6, a2, a5
330:              sub          ra, t0, ra
331:              sltu         s3, a6, t5
332:              beq          s6, s6, 336f
333:              nop
334:              or           a7, s3, ra
335:              csrrs        a5, 0x301, s7
336:              srli         a6, s10, 0
337:              slti         t1, t5, -702
338:              srl          s7, s4, a7
339:              andi         t5, t4, 1964
340:              andi         a2, s8, -159
341:              lui          s9, 591549
342:              mul          a1, s2, a4
343:              andi         t5, s6, -1771
344:              csrrwi       a2, 0x342, 28
345:              srl          a5, tp, t3
346:              sub          s7, s0, s5
347:              srl          t6, a2, s4
348:              bltu         s1, a4, 351f
349:              xori         a1, t1, 387
350:              sub          a2, s5, s6
351:              xor          s5, s3, s1
352:              sra          a7, t5, a4
353:              xor          s10, a3, s5
354:              mulh         s4, a6, a1
355:              blt          t3, ra, 361f
356:              srli         a3, zero, 5
357:              srli         s3, gp, 27
358:              slli         s6, t1, 10
359:              rem          zero, t6, ra
360:              addi         a3, s3, 225
361:              mulhsu       s5, s10, a5
362:              and          a1, t3, s1
363:              or           s1, s8, s1
364:              bge          s3, t1, 376f
365:              ori          zero, a5, 1458
366:              xori         t0, t4, 27
367:              xor          a1, s4, s2
368:              bge          sp, s6, 378f
369:              slli         s9, s9, 17
370:              slt          t2, sp, s5
371:              csrrci       a5, 0x301, 31
372:              slt          s8, a1, t4
373:              bgeu         a7, t3, 390f
374:              or           gp, t6, t5
375:              div          t5, s8, sp
376:              or           s1, a0, a3
377:              xor          s10, s5, s3
378:              blt          s9, s11, 394f
379:              mulhsu       s11, zero, gp
380:              srai         s1, a5, 18
381:              csrrw        s10, 0x343, t1
382:              auipc        t2, 185706
383:              srli         s6, t3, 14
384:              bgeu         t4, a2, 385f
385:              bgeu         gp, s3, 388f
386:              slt          s7, t3, s3
387:              csrrs        a5, 0x304, zero
388:              csrrs        a1, 0x343, a4
389:              ori          t1, a0, -647
390:              slti         a2, a6, -1421
391:              rem          t1, s9, s2
392:              sra          s10, s9, t5
393:              slti         a5, zero, -389
394:              mul          s1, s7, s1
395:              slli         s5, a0, 24
396:              csrrsi       s2, 0x343, 2
397:              xor          a5, s10, t6
398:              xori         t1, s3, -871
399:              bne          a3, a2, 403f
400:              bge          zero, a5, 416f
401:              srl          s9, t4, s6
402:              sltiu        s11, s6, 1076
403:              sltiu        t4, s11, 128
404:              divu         zero, s3, a5
405:              sltu         a4, s2, s6
406:              xori         t0, zero, 768
407:              slli         a4, a4, 10
408:              csrrc        s8, 0x304, zero
409:              csrrw        t1, 0x304, sp
410:              div          t6, a3, tp
411:              csrrw        s3, 0x343, a6
412:              divu         t1, t2, a0
413:              xor          a5, s6, zero
414:              xor          s11, s5, tp
415:              div          t1, s3, s2
416:              lui          t0, 962283
417:              csrrci       a5, 0x304, 16
418:              or           a5, a5, a0
419:              sltiu        a2, sp, -1707
420:              andi         a4, a6, 802
421:              csrrc        t6, 0x305, zero
422:              sll          s9, s8, s7
423:              mulhu        a2, s0, t3
424:              srai         s9, t6, 20
425:              srai         t0, ra, 14
426:              xori         t0, a4, -1211
427:              slti         s2, ra, 906
428:              addi         a0, t2, 1927
429:              beq          a1, s6, 440f
430:              bltu         s2, tp, 446f
431:              andi         s11, t0, -1564
432:              slt          tp, zero, t1
433:              csrrsi       t2, 0x300, 0
434:              or           s9, a4, s0
435:              slli         a2, zero, 8
436:              slti         s2, t0, -598
437:              and          t5, t3, s7
438:              ori          t6, a6, -905
439:              remu         a4, tp, t3
440:              sub          s11, t5, a7
441:              srl          t4, a5, s1
442:              nop
443:              bgeu         s0, gp, 446f
444:              csrrwi       s9, 0x343, 10
445:              mulhsu       a3, t2, s2
446:              remu         t0, zero, s8
447:              sll          s4, sp, zero
448:              sll          s5, sp, s0
449:              div          s6, t0, s4
450:              remu         a1, a7, zero
451:              csrrc        s7, 0x300, zero
452:              nop
453:              srai         a6, t0, 12
454:              csrrwi       a6, 0x301, 13
455:              srai         a6, s0, 21
456:              nop
457:              srai         s5, a1, 7
458:              csrrci       t1, 0x343, 0
459:              csrrci       t0, 0x342, 26
460:              bge          s0, zero, 471f
461:              slli         a0, s10, 26
462:              sltu         a3, s0, a5
463:              srl          a4, a0, t2
464:              csrrsi       t2, 0x305, 0
465:              slti         s7, t5, -412
466:              mulh         a3, tp, a0
467:              sra          s10, s8, a4
468:              auipc        s10, 369000
469:              remu         t2, s7, s10
470:              csrrci       t6, 0x305, 0
471:              mul          a4, gp, s1
472:              sltiu        s10, a7, -56
473:              slt          t5, s8, a5
474:              or           s6, s4, a7
475:              bltu         t3, s9, 478f
476:              csrrci       s8, 0x301, 0
477:              sra          ra, sp, t2
478:              slti         s8, s8, 1323
479:              csrrs        a5, 0x305, zero
480:              addi         a5, s8, 645
481:              csrrs        a3, 0x343, zero
482:              bge          t5, s1, 499f
483:              nop
484:              bgeu         a6, s3, 487f
485:              or           a5, a4, s1
486:              andi         a7, a3, 2017
487:              nop
488:              slti         t6, t5, -692
489:              addi         t5, t6, 1843
490:              slti         tp, zero, -809
491:              sltu         t0, t1, s1
492:              sll          s5, t2, s5
493:              xor          s11, t4, s0
494:              beq          s10, s9, 512f
495:              mulhsu       t2, a6, s11
496:              bltu         t3, s10, 508f
497:              sub          zero, t6, a2
498:              divu         t1, t1, s10
499:              slt          s2, a0, a1
500:              sltiu        a4, s10, -2027
501:              remu         t0, s1, s11
502:              ori          zero, s6, 485
503:              rem          s1, gp, a6
504:              nop
505:              slt          t6, zero, t5
506:              csrrc        a0, 0x304, a6
507:              beq          a3, t1, 508f
508:              sub          s3, t5, zero
509:              beq          s8, a7, 517f
510:              auipc        tp, 1041565
511:              csrrc        a6, 0x301, t3
512:              sub          gp, a1, s6
513:              ori          t0, s1, -633
514:              sltu         tp, s8, s10
515:              xor          a1, a5, a4
516:              andi         s11, a6, -15
517:              sub          s11, t5, a3
518:              addi         a7, s2, 1051
519:              auipc        t5, 156431
520:              divu         ra, t2, a4
521:              div          t5, t1, s10
522:              remu         ra, s2, a1
523:              csrrs        s4, 0x343, zero
524:              mulhsu       tp, s6, a5
525:              sltu         s9, s1, t2
526:              sll          gp, t2, t4
527:              csrrw        gp, 0x343, t2
528:              srl          s7, s5, t5
529:              mulh         s8, s9, t2
530:              sll          s10, s0, a3
531:              andi         s8, a1, 1553
532:              mulh         t1, t5, s5
533:              sra          s1, t6, t1
534:              andi         a5, s2, 1891
535:              sltiu        t0, a4, 1914
536:              lui          a5, 247178
537:              and          a4, s5, t2
538:              bne          t6, t4, 544f
539:              sra          s1, s7, s8
540:              slli         ra, a4, 11
541:              csrrwi       t5, 0x343, 27
542:              lui          s6, 278854
543:              bne          a5, t4, 549f
544:              divu         a7, zero, t3
545:              or           a7, s8, s11
546:              bge          t2, ra, 561f
547:              lui          t2, 576592
548:              csrrw        t1, 0x301, s9
549:              slti         tp, t1, 1262
550:              mul          s2, a2, a4
551:              xor          s7, gp, sp
552:              csrrs        a0, 0x342, zero
553:              sub          s5, s3, t6
554:              div          a1, s6, a5
555:              csrrc        s1, 0x342, zero
556:              ori          s6, s8, -851
557:              xori         tp, s6, 923
558:              csrrsi       s8, 0x343, 15
559:              beq          t0, ra, 569f
560:              add          s11, a6, ra
561:              div          s6, s7, s3
562:              slt          a2, s10, s4
563:              rem          t6, t2, a0
564:              rem          a6, t5, ra
565:              div          s3, s3, s0
566:              sub          zero, t4, ra
567:              rem          a1, s8, a4
568:              slli         a3, t0, 21
569:              auipc        ra, 325528
570:              srli         t5, s10, 31
571:              blt          tp, t4, 584f
572:              csrrs        s2, 0x300, zero
573:              xor          s5, sp, zero
574:              lui          s9, 772154
575:              sll          s8, s3, t4
576:              bgeu         ra, a2, 582f
577:              slti         s4, s10, -574
578:              csrrc        a5, 0x305, zero
579:              nop
580:              sltu         s2, a6, s11
581:              div          s2, s10, s5
582:              and          a5, s4, a5
583:              csrrs        a7, 0x300, zero
584:              srl          s11, a0, ra
585:              mul          a2, s9, a0
586:              div          t0, t0, t6
587:              csrrci       a0, 0x343, 0
588:              srl          a4, t0, s4
589:              nop
590:              sra          s10, a0, a2
591:              add          s4, s10, tp
592:              mulhu        a0, s1, t1
593:              rem          s3, a4, s3
594:              divu         a2, gp, t1
595:              slt          a7, s11, s5
596:              auipc        s6, 88091
597:              csrrci       zero, 0x304, 0
598:              auipc        a1, 782654
599:              csrrsi       s6, 0x343, 11
600:              remu         a2, s1, s8
601:              remu         s3, a1, t5
602:              csrrc        t2, 0x301, zero
603:              csrrw        a5, 0x342, a5
604:              mul          t0, zero, t3
605:              div          s2, s1, s10
606:              auipc        zero, 421053
607:              sltiu        s5, a1, -1442
608:              xori         a2, a0, -1301
609:              div          gp, s6, s0
610:              bltu         s10, s1, 630f
611:              sub          gp, s9, a6
612:              nop
613:              srai         s7, s7, 4
614:              auipc        tp, 880858
615:              csrrci       a4, 0x342, 26
616:              csrrc        s7, 0x343, zero
617:              csrrc        s3, 0x343, zero
618:              csrrwi       t0, 0x304, 26
619:              lui          gp, 847219
620:              and          t4, s4, s8
621:              divu         gp, sp, tp
622:              csrrs        a2, 0x342, zero
623:              andi         a6, t6, 740
624:              addi         zero, t0, 611
625:              beq          a7, t6, 634f
626:              ori          a0, a2, 630
627:              bltu         s6, zero, 638f
628:              sll          s1, t5, a0
629:              bge          s1, t2, 644f
630:              sra          s8, t6, s2
631:              mulhu        a6, s9, a5
632:              beq          sp, a0, 640f
633:              bltu         s10, t6, 641f
634:              addi         t2, s3, 1063
635:              lui          s9, 581063
636:              div          s10, t5, s8
637:              or           a5, a7, t5
638:              div          a3, a1, s8
639:              mulhu        s3, s3, a7
640:              slt          s6, s1, s1
641:              sub          s6, s4, ra
642:              xori         s6, s4, 1094
643:              csrrsi       s4, 0x342, 0
644:              sll          zero, s5, t0
645:              lui          a3, 564111
646:              blt          t5, sp, 647f
647:              bne          a7, sp, 650f
648:              sltiu        s4, a5, 1406
649:              add          s6, t0, s0
650:              bgeu         sp, s9, 666f
651:              csrrw        a5, 0x343, t4
652:              beq          s0, s4, 663f
653:              csrrc        zero, 0x304, t6
654:              blt          a2, a1, 660f
655:              csrrs        s11, 0x343, t4
656:              beq          t5, a3, 674f
657:              mulh         s10, s5, t2
658:              csrrci       tp, 0x343, 24
659:              srli         s4, a0, 14
660:              sll          s6, a3, s3
661:              blt          s10, s4, 664f
662:              sltiu        zero, s9, 68
663:              bne          t0, t2, 679f
664:              or           s2, t5, s5
665:              mulhsu       a4, gp, s9
666:              remu         s1, t5, a0
667:              bge          s7, s11, 671f
668:              slli         tp, a0, 26
669:              xori         gp, s8, 1741
670:              bltu         t2, s0, 678f
671:              bltu         ra, s1, 688f
672:              mulhsu       s3, s3, tp
673:              sltu         a6, a3, s8
674:              slli         a2, a2, 4
675:              bltu         t4, ra, 678f
676:              slli         a1, a4, 13
677:              divu         a5, a0, sp
678:              csrrs        a1, 0x304, zero
679:              div          t6, t6, t4
680:              remu         s9, t3, t5
681:              sra          a5, zero, t6
682:              rem          s11, a4, gp
683:              andi         gp, t3, -1574
684:              bge          ra, a7, 687f
685:              sltu         t6, s1, s7
686:              lui          a7, 3684
687:              divu         s6, sp, s1
688:              csrrw        a1, 0x304, a1
689:              blt          s4, t1, 690f
690:              bne          t5, t2, 701f
691:              srai         t0, s10, 1
692:              csrrsi       gp, 0x342, 22
693:              mul          s4, a0, s11
694:              or           t1, a0, s1
695:              div          a5, s11, s6
696:              csrrsi       t5, 0x343, 17
697:              div          t0, a0, a7
698:              or           t6, t1, s8
699:              and          s1, t3, s9
700:              lui          s11, 794068
701:              srai         a4, ra, 15
702:              addi         t4, s10, -104
703:              csrrsi       a5, 0x301, 26
704:              sub          s10, s8, t0
705:              nop
706:              remu         t2, gp, ra
707:              blt          s2, t1, 715f
708:              mulh         a2, s7, t1
709:              sltiu        s6, a4, -788
710:              srli         t6, s10, 16
711:              csrrci       s9, 0x301, 0
712:              beq          ra, zero, 721f
713:              csrrc        t2, 0x343, t2
714:              srai         t4, s6, 4
715:              srai         a5, s4, 22
716:              lui          a2, 899644
717:              csrrsi       ra, 0x343, 0
718:              and          s6, s9, s8
719:              sub          s4, s10, t3
720:              csrrw        t6, 0x301, t3
721:              slli         tp, s11, 12
722:              slli         t4, a0, 29
723:              slt          a0, ra, s6
724:              beq          t2, zero, 727f
725:              and          s2, a6, s5
726:              rem          a6, s11, gp
727:              divu         s3, zero, zero
728:              xori         s8, t5, 1417
729:              rem          ra, t1, a5
730:              ori          a1, a6, -1523
731:              and          gp, tp, s11
                  la           s2, region_1+7051 #start riscv_load_store_rand_instr_stream_11
                  and          a7, a4, s10
                  lw           s3, -1288(s2)
                  csrrs        gp, 0x342, zero
                  lbu          gp, -1719(s2)
                  xor          a7, zero, a3
                  divu         s1, a2, t2
                  andi         t4, a1, -1419
                  sh           s4, -1240(s2)
                  sra          a1, a6, a0
                  sh           ra, -998(s2)
                  lhu          a2, -1457(s2)
                  srli         s1, s6, 0
                  csrrci       s5, 0x304, 0
                  mulhu        s10, s2, zero
                  csrrc        tp, 0x304, zero
                  sh           s7, -712(s2)
                  lb           t0, -827(s2)
                  slti         s11, s2, -80
                  sll          tp, s5, s1
                  slt          s8, a7, a2
                  lb           s11, 344(s2)
                  lb           t1, -643(s2)
                  lhu          s5, 701(s2)
                  mulh         s10, a1, s3
                  andi         s6, s5, 908
                  lhu          t6, -192(s2)
                  lh           s7, 1405(s2)
                  lb           s11, 1775(s2)
                  csrrsi       a0, 0x301, 0
                  lbu          s8, -49(s2)
                  lb           s6, 1515(s2) #end riscv_load_store_rand_instr_stream_11
732:              bge          s5, s0, 733f
733:              remu         a0, sp, tp
734:              add          t1, a3, t6
735:              addi         gp, a0, 1051
736:              sltu         s1, a7, s8
737:              bgeu         a5, t2, 752f
738:              bge          t4, a7, 739f
739:              csrrwi       s10, 0x342, 21
740:              mulhu        s3, s11, s4
741:              sub          s8, s10, s0
742:              srai         ra, s10, 16
743:              bne          t1, s2, 751f
744:              add          a2, a5, s5
745:              xor          s1, a5, gp
746:              xori         ra, s4, 1608
747:              slt          s3, a2, a3
748:              or           s4, t5, s6
749:              andi         s1, t3, 789
750:              add          s7, a5, s10
751:              sra          a7, s10, t5
752:              div          t1, sp, t4
753:              bne          zero, s7, 756f
754:              sub          s2, s10, s1
755:              sll          a0, s2, a1
756:              and          s2, a0, s10
757:              csrrs        a6, 0x343, a1
758:              ori          zero, s6, -618
759:              lui          s1, 396751
760:              bltu         s10, s9, 764f
761:              csrrci       zero, 0x343, 0
762:              addi         t1, t1, -1404
763:              or           s5, t0, sp
764:              slt          t0, a1, t2
                  lw           a7, 4(sp)
                  and          a3, ra, t4
                  addi         sp, sp, 12
                  sra          a1, a4, s11
                  slli         s11, a5, 15
                  sra          zero, a0, s5
                  rem          a6, tp, t6
                  csrrwi       s4, 0x342, 29
                  sra          s2, s9, s8
                  nop
1794:             addi x5, x17, 0
1794:             jalr x5, x5, 0
write_tohost:     
                  li t5, 0xfffffffc

                  sw gp, 0(t5)

_exit:            
                  j write_tohost

instr_end:        
                  nop

