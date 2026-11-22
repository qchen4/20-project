
h0_start:
init:             
                  li x0, 0xf3802e94
                  li x1, 0xfa9c7ad6
                  li x3, 0x3
                  li x5, 0x80000000
                  li x6, 0x79b24e87
                  li x7, 0x80000000
                  li x8, 0xb
                  li x9, 0x0
                  li x10, 0xf58c3053
                  li x11, 0x9
                  li x12, 0x0
                  li x13, 0x80000000
                  li x14, 0x80000000
                  li x15, 0xfb9b5982
                  li x16, 0xfb3f7530
                  li x17, 0x0
                  li x18, 0x0
                  li x19, 0xfb5d42d0
                  li x20, 0x3
                  li x21, 0xfdd32bb2
                  li x22, 0xfbf49f28
                  li x23, 0x0
                  li x24, 0x2
                  li x25, 0x0
                  li x26, 0x80000000
                  li x27, 0x0
                  li x28, 0xe1a0e26
                  li x29, 0x80000000
                  li x30, 0x80000000
                  li x31, 0xfeffa30b
                  la x2, user_stack_end
                  csrr x27, 0x300
                  csrr x31, 0x304
                  csrw 0x300, x27
                  csrw 0x304, x31
main:             li           s10, 0x80000000 #start riscv_int_numeric_corner_stream_26
                  li           t2, 0xda50f0c9
                  li           s7, 0xe9048fdb
                  li           s11, 0x80000000
                  li           s5, 0xffffffff
                  li           s6, 0x0
                  li           a6, 0x0
                  li           t4, 0x80000000
                  li           ra, 0x0
                  li           s8, 0xcfe624fc
                  remu         s6, t4, a6
                  mulhsu       a6, s7, s7
                  mulhsu       s10, s8, s5
                  mulhu        s11, t2, s11
                  sub          s6, t4, ra
                  auipc        ra, 258112
                  remu         s6, s5, s5
                  div          a6, t2, ra
                  auipc        t4, 103013
                  mulh         s7, ra, s11
                  mulhu        s10, s7, s7
                  divu         a6, t4, s10
                  addi         ra, ra, 1475
                  mulh         ra, t2, s10
                  auipc        s5, 974994
                  div          s10, t2, s5
                  mul          s7, s8, t2
                  add          a6, s5, s8
                  div          t2, s7, s5 #end riscv_int_numeric_corner_stream_26
                  la           a1, region_1+53709 #start riscv_load_store_rand_instr_stream_36
                  slti         a3, t4, -1213
                  lh           t6, -1785(a1)
                  lb           t3, 1276(a1)
                  addi         s7, t4, 1749
                  csrrci       ra, 0x300, 0
                  lbu          s7, -1255(a1)
                  lh           s0, 287(a1)
                  lbu          gp, -1582(a1)
                  lbu          a5, -1467(a1)
                  lhu          s8, -1947(a1)
                  sw           tp, 427(a1)
                  lbu          t2, -784(a1)
                  lbu          t3, 89(a1)
                  div          t1, a6, a1
                  sb           s11, -165(a1)
                  mul          t5, s1, a0
                  andi         s9, t5, 281
                  lb           t4, -1106(a1)
                  sltu         s5, t1, t4
                  lb           ra, -1143(a1)
                  sb           s1, -76(a1)
                  sb           zero, -214(a1)
                  sb           t6, 1889(a1)
                  lbu          s2, 143(a1)
                  sh           s5, 1217(a1)
                  srl          t1, gp, gp
                  ori          gp, a1, 191
                  sb           s10, 14(a1)
                  csrrs        s2, 0x343, zero
                  sw           tp, 507(a1)
                  sb           s6, -1390(a1)
                  csrrc        t3, 0x342, zero
                  sw           s9, 1735(a1)
                  srl          a2, zero, s5
                  lh           a2, 1435(a1)
                  lbu          s11, -1191(a1)
                  csrrc        s0, 0x342, s5
                  lbu          a7, 440(a1)
                  csrrsi       t2, 0x300, 0
                  auipc        s11, 573050
                  sra          zero, t4, a1
                  lbu          s6, 1023(a1)
                  lb           t3, 983(a1)
                  sh           t4, 227(a1)
                  lb           s1, 1424(a1) #end riscv_load_store_rand_instr_stream_36
                  la           a2, region_1+52839 #start load_store_instr_stream_1
                  la           a5, region_1+44404 #start load_store_instr_stream_0
                  lb           a7, 1583(a5)
                  sh           s2, -322(a5)
                  lbu          a6, 60(a2)
                  lb           s0, -46(a2)
                  sb           t0, -47(a2)
                  lbu          t1, 5(a2)
                  lbu          t2, -105(a5)
                  lbu          t1, 2042(a5)
                  sh           s5, -1266(a5)
                  lbu          s1, 32(a2)
                  lb           s6, 1431(a5)
                  lbu          a4, 427(a5)
                  lbu          s8, 56(a2)
                  sb           a7, -45(a2)
                  lh           t3, 29(a2) #end load_store_instr_stream_1
                  lh           a1, -128(a5) #end load_store_instr_stream_0
                  la           s11, region_0+2354 #start load_store_instr_stream_2
                  la           t2, region_0+146 #start load_store_instr_stream_0
                  la           a6, region_0+472 #start load_store_instr_stream_1
                  sb           t6, 117(s11)
                  sb           sp, 62(t2)
                  la           a3, region_0+310 #start load_store_instr_stream_3
                  lbu          t0, 1(a3)
                  sb           a5, -151(s11)
                  sb           s7, 8(a3)
                  lb           s2, 66(a6)
                  lbu          gp, -42(s11)
                  lbu          a5, 51(a6)
                  lbu          ra, 13(a3)
                  lhu          a1, -154(a6)
                  sb           t3, -43(t2)
                  lbu          a4, 87(t2)
                  lb           ra, 16(a3)
                  lbu          s0, -199(a6)
                  sh           s8, -64(s11)
                  lb           a2, 254(a6)
                  lbu          t3, 159(s11)
                  sb           t6, 58(t2)
                  lb           s9, 7(a3)
                  sw           t6, 148(a6)
                  sb           s9, -9(a3)
                  sb           ra, -36(t2)
                  lbu          t4, -1(a3)
                  sb           a0, -47(s11)
                  lw           s0, 200(a6)
                  lbu          t1, -249(s11)
                  lbu          s6, 75(t2)
                  lbu          t4, -30(t2)
                  sb           a7, 179(s11)
                  sw           t2, -10(a3)
                  lhu          s1, -142(a6) #end load_store_instr_stream_1
                  lbu          s1, 3(a3) #end load_store_instr_stream_3
                  lbu          t4, -245(s11) #end load_store_instr_stream_2
                  lbu          a4, 178(t2) #end load_store_instr_stream_0
                  addi         s8, zero, 6 #init loop 0 counter
                  remu         t3, s6, s2
                  lui          t0, 375736
                  csrrc        zero, 0x342, zero
                  xori         a4, t4, -933
                  mul          t2, s5, s4
                  addi         s11, zero, 15 #init loop 0 limit
                  mulhsu       t6, a0, s1
                  slti         a6, t3, 1825
                  csrrs        s0, 0x304, zero
main_203_0_t:     rem          zero, a4, s8
                  srl          s4, zero, a2
                  sltu         a2, a7, s5
                  srl          a4, a7, t3
                  mulhsu       a2, s2, a3
                  csrrwi       a4, 0x304, 7
                  rem          s0, t2, s6
                  srli         s9, s11, 31
                  addi         s8, s8, 1 #update loop 0 counter
                  lui          a6, 400593
                  csrrw        t5, 0x301, s0
                  sltu         s6, t1, t3
                  sra          a7, s0, t1
                  srai         s7, s6, 14
                  sll          s10, t1, a7
                  blt          s8, s11, main_203_0_t #branch for loop 0
                  mul          a2, a7, tp
                  la           s3, region_0+896 #start riscv_hazard_instr_stream_4
                  nop
                  or           t0, t1, a2
                  sh           a1, -2(s3)
                  slt          a1, t1, t0
                  mulhu        a5, a5, a2
                  lh           a5, 4(s3)
                  sb           t0, -6(s3)
                  lb           a2, 9(s3)
                  sb           a2, -1(s3)
                  xor          t1, a5, a1
                  lbu          a5, -1(s3)
                  slt          a2, a2, a1
                  srai         a2, a5, 30
                  sra          t0, a3, t1
                  sw           a1, -8(s3)
                  lbu          a2, 9(s3)
                  sb           a2, 12(s3)
                  mulhu        a5, t0, a5
                  add          a3, a2, a3
                  lhu          a1, 6(s3)
                  slli         t0, t1, 7
                  mul          a1, t0, a1
                  ori          a1, t1, -1503
                  lbu          a3, -1(s3)
                  csrrs        a2, 0x344, t0
                  srai         t1, a3, 3
                  slli         a5, a1, 18
                  mul          a2, a2, a2
                  csrrc        a2, 0x342, a1
                  lbu          a5, -16(s3) #end riscv_hazard_instr_stream_4
main_89:          jal          ra, 21f
0:                jal          ra, 4f
1:                jal          t1, 26f
2:                jal          ra, 23f
3:                jal          t1, 14f
4:                jal          ra, 10f
5:                jal          ra, 1b
6:                jal          ra, 25f
7:                jal          ra, 3b
8:                jal          ra, 9f
9:                jal          ra, 15f
10:               jal          s6, 2b
11:               jal          t1, 8b
12:               jal          s3, 19f
13:               jal          t1, 27f
14:               jal          t2, 17f
15:               jal          t1, 20f
16:               jal          t1, 5b
17:               jal          ra, 16b
18:               jal          a4, 12b
19:               jal          ra, 22f
20:               jal          s8, 7b
21:               jal          ra, 6b
22:               jal          ra, 0b
23:               jal          ra, 24f
24:               jal          ra, 11b
25:               jal          s1, 18b
26:               jal          t3, 13b
27:               nop
                  la           s9, region_0+3553 #start riscv_load_store_rand_instr_stream_24
                  sltu         a5, t4, t1
                  lb           s2, -1591(s9)
                  srl          s6, s7, s3
                  lb           t6, -866(s9)
                  nop
                  sra          s8, ra, t2
                  slti         t6, s7, 1639
                  mulh         s6, s8, s7
                  mul          s11, a3, s8
                  sh           ra, -1291(s9)
                  sb           t3, -1538(s9)
                  lui          s10, 860733
                  addi         t2, s7, 1583
                  rem          s8, t1, a2
                  divu         a4, a4, s0
                  div          a7, s11, a6
                  divu         a6, t6, a0
                  add          s8, t2, s4
                  sb           t0, -1775(s9)
                  lbu          s7, 238(s9)
                  lbu          t1, -1198(s9)
                  lhu          zero, -241(s9)
                  lhu          s2, -1279(s9)
                  sb           s3, -1958(s9)
                  mulh         a4, tp, s1
                  sb           sp, 262(s9)
                  lb           s0, -2(s9)
                  srai         s8, s1, 8
                  mulh         gp, s10, a2
                  srl          s2, t4, a2
                  sltiu        a6, zero, 629
                  mul          a4, t3, a7
                  lb           s8, -92(s9)
                  slt          a5, a2, s9
                  lbu          s5, 400(s9) #end riscv_load_store_rand_instr_stream_24
                  la           s11, region_0+1896 #start load_store_instr_stream_1
                  lb           s10, -9(s11)
                  la           t1, region_0+510 #start load_store_instr_stream_4
                  la           s4, region_0+1672 #start load_store_instr_stream_0
                  lb           s0, -57(s4)
                  la           a2, region_0+2890 #start load_store_instr_stream_3
                  sh           a2, 1202(a2)
                  sb           s4, 121(t1)
                  la           s9, region_0+2437 #start load_store_instr_stream_2
                  lhu          s1, 2(s11)
                  sh           gp, -1761(s9)
                  lb           s10, -39(t1)
                  sh           t4, -423(s9)
                  lbu          t4, -25(s4)
                  sb           sp, -1415(a2)
                  lbu          s8, -203(t1)
                  sb           t1, -31(s4)
                  sw           a4, -77(s9)
                  lbu          t2, 111(t1)
                  lbu          s1, -612(s9)
                  lb           zero, -186(s9)
                  lb           t4, -685(a2)
                  lw           t2, 42(t1)
                  lb           a1, -39(s11)
                  sh           s11, -810(a2)
                  sb           a2, 887(s9)
                  sw           a1, -48(s11)
                  lb           a7, 329(a2)
                  sb           a7, -183(t1)
                  lb           t4, -43(a2)
                  lbu          s10, -29(s4)
                  lhu          t4, 44(s4)
                  lb           s3, 640(s9)
                  lb           t0, -1839(a2) #end load_store_instr_stream_3
                  lb           ra, -7(t1)
                  lw           s3, 1211(s9)
                  sb           zero, -1635(s9)
                  lh           s6, 152(t1)
                  lb           s10, 31(s11) #end load_store_instr_stream_1
                  lb           s6, -18(t1) #end load_store_instr_stream_4
                  sh           t1, 321(s9) #end load_store_instr_stream_2
                  lh           t2, 0(s4) #end load_store_instr_stream_0
                  li           s4, 0xb8d6dbbf #start riscv_int_numeric_corner_stream_28
                  li           a1, 0xffffffff
                  li           a7, 0x0
                  li           t0, 0xffffffff
                  li           s1, 0x0
                  li           s8, 0x80000000
                  li           gp, 0x9fe4a280
                  li           ra, 0xdb732530
                  li           a5, 0x9aab2f25
                  li           t3, 0x0
                  div          s8, s1, s8
                  auipc        t3, 236715
                  addi         a1, ra, -214
                  addi         t3, ra, -1912
                  divu         ra, a1, ra
                  lui          s8, 116733
                  mulh         ra, gp, a7
                  mulhsu       t3, a7, s4
                  mulh         gp, ra, s1
                  divu         a1, s4, a5
                  divu         t0, s1, t3
                  div          a1, a5, ra
                  mulh         a5, s1, gp
                  rem          ra, a1, a5
                  mul          s4, ra, s8
                  div          s8, s1, a7
                  add          t0, t0, s4
                  add          s4, gp, s1
                  divu         a7, gp, s8
                  divu         a7, t3, s1
                  auipc        t3, 393601
                  add          s4, t0, a5
                  rem          a1, t3, t3
                  mulhu        s4, t3, ra
                  div          a5, s1, a7
                  lui          t0, 989011
                  nop
                  add          a5, s4, a1
                  rem          gp, a7, a7
                  mul          s4, t3, t0 #end riscv_int_numeric_corner_stream_28
                  la           s0, region_1+21915 #start riscv_load_store_rand_instr_stream_34
                  mulhu        t0, s2, a7
                  lbu          t4, 1812(s0)
                  lh           a5, 433(s0)
                  addi         s7, t3, 824
                  or           s3, a1, tp
                  slli         gp, t1, 24
                  div          a5, t1, s4
                  nop
                  sb           s7, 426(s0)
                  mulhsu       s4, s5, s10
                  auipc        s6, 44761
                  lw           a6, 1029(s0)
                  sb           a0, 736(s0)
                  mulhsu       t0, s2, s5
                  sw           a0, -415(s0)
                  lbu          a6, 1280(s0)
                  lhu          a1, -1089(s0)
                  nop
                  or           s6, s10, s11
                  andi         a3, t4, 1564
                  lb           t2, 1516(s0)
                  csrrc        a4, 0x305, zero
                  addi         a4, s6, -135
                  sub          a4, t6, zero
                  sw           t0, 1229(s0)
                  slti         gp, t6, -565
                  lb           s2, 1880(s0)
                  lb           s11, -444(s0)
                  lhu          t1, 921(s0)
                  lh           s8, 11(s0)
                  lbu          s6, -447(s0)
                  lbu          a7, 1958(s0)
                  sb           s0, -244(s0)
                  addi         s3, a7, 469
                  remu         s3, t4, a3
                  lbu          gp, 50(s0)
                  srli         s8, a4, 9
                  nop
                  lb           s4, -1620(s0)
                  csrrw        t5, 0x344, s4
                  xori         t2, s5, 1207
                  lb           s10, -569(s0)
                  lb           t4, 1119(s0)
                  lw           s1, 537(s0)
                  slli         a2, s9, 7
                  sh           s4, -1521(s0)
                  sb           s8, 69(s0)
                  lhu          t6, 847(s0)
                  sb           s0, 1876(s0)
                  lh           a4, 1619(s0)
                  xor          s4, zero, s7
                  lb           zero, -942(s0)
                  remu         s1, t1, s2
                  sltu         s1, t2, gp
                  lbu          t4, -699(s0) #end riscv_load_store_rand_instr_stream_34
main_85:          jal          ra, 5f
0:                jal          ra, 28f
1:                jal          a6, 24f
2:                jal          ra, 19f
3:                jal          t0, 2b
4:                jal          t1, 15f
5:                jal          ra, 6f
6:                jal          ra, 26f
7:                jal          a6, 21f
8:                jal          ra, 7b
9:                jal          ra, 8b
10:               jal          t1, 13f
11:               jal          ra, 1b
12:               jal          t1, 18f
13:               jal          ra, 27f
14:               jal          ra, 23f
15:               jal          ra, 3b
16:               jal          t1, 14b
17:               jal          t1, 9b
18:               jal          s1, 16b
19:               jal          ra, 20f
20:               jal          ra, 11b
21:               jal          t1, 25f
22:               jal          ra, 10b
23:               jal          ra, 4b
24:               jal          t1, 0b
25:               jal          ra, 12b
26:               jal          ra, 22b
27:               jal          s4, 17b
28:               addi         gp, t3, 661
                  la           t3, region_1+43936 #start riscv_load_store_hazard_instr_stream_6
                  lh           s2, 130(t3)
                  divu         s1, t6, s3
                  sb           sp, -1(t3)
                  sb           t3, -1(t3)
                  lbu          s8, -1(t3)
                  sb           s10, -1(t3)
                  lbu          a1, -1(t3)
                  srli         s3, s7, 18
                  sb           ra, -1(t3)
                  lbu          s10, -1(t3)
                  sb           s5, -1(t3)
                  auipc        s7, 788058
                  sll          t4, sp, s2
                  lbu          s4, 202(t3)
                  lbu          s4, 202(t3)
                  and          s10, zero, a7
                  mul          gp, s0, zero
                  lhu          s4, 202(t3)
                  sb           t6, 213(t3)
                  lb           ra, 213(t3)
                  rem          s0, gp, t3
                  sb           a4, 23(t3)
                  lh           a7, 134(t3)
                  lh           a6, 134(t3)
                  lbu          a2, 178(t3)
                  sh           s7, 178(t3) #end riscv_load_store_hazard_instr_stream_6
                  addi         t6, zero, -8 #init loop 0 counter
                  addi         t5, s5, 1984
                  addi         a3, zero, -17 #init loop 0 limit
                  csrrw        a4, 0x343, a7
                  mulhsu       zero, a2, s4
                  sub          gp, s4, s1
main_230_0_t:     addi         a4, s3, 1919
                  xori         s10, t1, -1068
                  and          t0, a7, t2
                  addi         t6, t6, -3 #update loop 0 counter
                  slti         s10, tp, 1186
                  sra          s11, a2, a6
                  bge          t6, a3, main_230_0_t #branch for loop 0
                  sltu         s11, a0, t4
                  la           a4, region_0+1118 #start riscv_load_store_hazard_instr_stream_29
                  lb           t4, 2(a4)
                  lbu          t6, 2(a4)
                  sw           zero, 2(a4)
                  sw           s5, 2(a4)
                  auipc        t4, 58259
                  lbu          s2, -5(a4)
                  lb           s8, -5(a4)
                  sb           s0, -5(a4)
                  lbu          s5, -5(a4)
                  lbu          a1, -5(a4)
                  lhu          gp, -14(a4)
                  lb           s11, 7(a4)
                  lbu          s11, 7(a4)
                  sb           s8, 7(a4) #end riscv_load_store_hazard_instr_stream_29
                  la           a7, region_0+1268 #start riscv_load_store_hazard_instr_stream_27
                  lhu          t0, 12(a7)
                  lb           t3, 12(a7)
                  sh           a3, 12(a7)
                  lbu          gp, -3(a7)
                  sb           a2, -5(a7)
                  lbu          zero, -5(a7)
                  sb           t1, 14(a7)
                  sll          s3, tp, s3
                  sb           a2, 14(a7)
                  csrrwi       s2, 0x301, 20
                  sb           s5, 5(a7)
                  lb           s2, -2(a7)
                  lb           s1, 16(a7)
                  sb           t3, -6(a7)
                  mulhsu       a5, t1, s3
                  lhu          s8, -8(a7)
                  sw           s4, -8(a7)
                  lhu          t6, -10(a7)
                  lh           t1, -10(a7)
                  srl          t5, a0, s7
                  lhu          s1, -10(a7)
                  lb           s1, 3(a7)
                  lhu          s4, -2(a7)
                  sb           a2, -7(a7) #end riscv_load_store_hazard_instr_stream_27
                  la           a3, region_0+1170 #start riscv_hazard_instr_stream_17
                  mulhsu       zero, s1, s6
                  remu         s1, s1, zero
                  lb           zero, 61(a3)
                  xor          s1, s0, s6
                  lui          zero, 260791
                  sra          a5, s6, s6
                  mulhu        s6, s6, s0
                  lw           s0, -22(a3)
                  sb           a5, 55(a3)
                  lb           s1, -13(a3)
                  lui          s6, 349906
                  lbu          zero, 35(a3)
                  lh           zero, -10(a3)
                  lbu          s6, -37(a3)
                  sub          s1, zero, t4
                  sh           a5, -60(a3)
                  lbu          a5, 53(a3)
                  srl          a5, zero, zero
                  lb           s6, -28(a3)
                  ori          zero, zero, 1578
                  mulhsu       s0, a5, t4
                  lbu          s1, 50(a3)
                  sh           a5, 12(a3)
                  mulhsu       s6, a5, s0
                  andi         s0, s6, -293
                  sltu         a5, s6, zero
                  rem          a5, s1, zero
                  auipc        t4, 129946
                  srl          s0, zero, s0
                  sra          a5, zero, zero
                  sltiu        a5, a5, 920
                  sh           s6, 54(a3)
                  sll          s0, t4, t4
                  sra          t4, s1, s0
                  lbu          s6, -15(a3)
                  lb           t4, -59(a3) #end riscv_hazard_instr_stream_17
                  la           a3, region_0+2252 #start load_store_instr_stream_1
                  la           a7, region_1+30983 #start load_store_instr_stream_0
                  lw           a5, 212(a3)
                  lbu          t3, 140(a7)
                  sb           s7, -1117(a3)
                  sh           s8, -243(a7)
                  sb           s1, -128(a7)
                  sb           s7, -897(a3)
                  sb           a4, -1927(a3)
                  lhu          s2, 3(a7)
                  lbu          t1, -375(a3)
                  lb           s7, 198(a3)
                  lbu          gp, -192(a7)
                  lh           s6, 644(a3) #end load_store_instr_stream_1
                  lhu          zero, -195(a7) #end load_store_instr_stream_0
                  la           t5, region_1+6241 #start load_store_instr_stream_2
                  sb           s5, -16(t5)
                  lw           t4, 59(t5)
                  la           s7, region_1+45490 #start load_store_instr_stream_1
                  sw           a4, -53(t5)
                  lb           a1, -1671(s7)
                  la           s6, region_1+13150 #start load_store_instr_stream_0
                  lbu          t4, -11(s6)
                  lh           s0, 0(s6)
                  lb           t3, 1147(s7)
                  sw           sp, -1430(s7)
                  sb           s10, -3(s6)
                  lw           t3, -21(t5)
                  lbu          s11, -54(t5)
                  sb           t2, -303(s7)
                  sh           s0, -63(t5) #end load_store_instr_stream_2
                  lb           s3, -1577(s7)
                  lbu          t0, 2(s6)
                  sw           t4, -10(s6)
                  sb           s2, 615(s7) #end load_store_instr_stream_1
                  sh           s11, 6(s6) #end load_store_instr_stream_0
main_98:          jal          ra, 20f
0:                jal          s1, 7f
1:                jal          ra, 21f
2:                jal          ra, 14f
3:                jal          ra, 6f
4:                jal          s7, 17f
5:                jal          ra, 13f
6:                jal          a4, 10f
7:                jal          ra, 11f
8:                jal          ra, 12f
9:                jal          ra, 0b
10:               jal          t1, 5b
11:               jal          t1, 19f
12:               jal          s10, 16f
13:               jal          t1, 1b
14:               jal          ra, 8b
15:               jal          a3, 4b
16:               jal          a2, 15b
17:               jal          ra, 18f
18:               jal          ra, 9b
19:               jal          ra, 22f
20:               jal          ra, 3b
21:               jal          s6, 2b
22:               sltiu        t2, a6, -1138
                  la           s0, region_1+29536 #start riscv_hazard_instr_stream_13
                  lbu          s4, -1107(s0)
                  lw           t0, -1472(s0)
                  add          s7, t0, s11
                  csrrc        t0, 0x304, a4
                  sb           a5, 114(s0)
                  sra          s4, a4, s7
                  lh           s4, 880(s0)
                  lb           s4, -214(s0)
                  xori         s7, a5, -663
                  sh           t0, 196(s0)
                  lw           a4, -24(s0)
                  lhu          t0, 858(s0)
                  auipc        t0, 415451
                  lh           a5, -930(s0)
                  add          a4, t0, s11
                  rem          s7, s4, s4
                  sh           s11, 338(s0)
                  div          s7, s11, s7
                  addi         a4, s7, -453
                  sb           t0, -1738(s0)
                  lbu          s4, 99(s0)
                  ori          t0, s11, 510
                  remu         a4, t0, s7
                  lbu          t0, 1711(s0)
                  lw           a4, -1220(s0)
                  sub          a5, t0, s11
                  add          a4, a4, s11
                  lhu          a5, -1080(s0)
                  auipc        a5, 850272
                  lbu          s11, 1104(s0)
                  lh           a4, 616(s0)
                  slt          a4, a5, a4
                  csrrs        a5, 0x342, s4
                  lb           a4, 1377(s0)
                  auipc        s11, 594990
                  csrrc        a4, 0x343, a4
                  lbu          s4, -1444(s0)
                  rem          t0, s11, t0
                  or           t0, t0, s7
                  ori          s7, s4, 133
                  lh           t0, -1174(s0)
                  sb           a5, -1908(s0)
                  lhu          s11, -1450(s0)
                  sra          a5, s11, s7
                  csrrw        s4, 0x301, s7
                  lbu          a4, -1289(s0)
                  mul          a4, a4, s11
                  add          a4, a5, s4
                  sb           s11, -1069(s0)
                  csrrsi       s7, 0x344, 0
                  lb           s4, -1535(s0)
                  lw           s11, -696(s0)
                  lbu          s11, -2044(s0) #end riscv_hazard_instr_stream_13
                  addi         t3, zero, -9 #init loop 1 counter
                  andi         s11, t1, -385
                  sra          s1, t6, s6
                  xor          a1, a1, t6
                  addi         s9, zero, -15 #init loop 1 limit
                  auipc        t0, 7964
                  srai         s10, a5, 6
                  or           s4, s9, s3
                  rem          s1, a5, s8
main_237_1_t:     div          t5, t5, a2
                  rem          t1, tp, t4
                  addi         t3, t3, -6 #update loop 1 counter
                  addi         ra, zero, 10 #init loop 0 counter
                  addi         s2, zero, 8 #init loop 0 limit
                  srl          t6, t6, ra
main_237_0_t:     addi         zero, a5, -1811
                  addi         ra, ra, -7 #update loop 0 counter
                  divu         a5, a1, s8
                  add          s11, a0, tp
                  bgeu         ra, s2, main_237_0_t #branch for loop 0
                  csrrc        s0, 0x301, s11
                  beq          t3, s9, main_237_1_t #branch for loop 1
                  auipc        t6, 798598
                  addi         s4, zero, 4 #init loop 0 counter
                  nop
                  mul          t6, gp, s0
                  sltu         s8, t0, a7
                  ori          a6, s11, 294
                  srl          a3, s1, s11
                  and          s5, a7, a2
                  addi         t1, zero, 13 #init loop 0 limit
                  or           a5, s4, s7
                  lui          t5, 106580
                  xori         a1, s7, 1670
main_228_0_t:     rem          s6, s6, t0
                  addi         s4, s4, 3 #update loop 0 counter
                  sltu         a5, a4, s3
                  nop
                  bne          s4, t1, main_228_0_t #branch for loop 0
                  xor          t3, s11, s9
                  la           s1, region_1+61618 #start riscv_hazard_instr_stream_26
                  csrrsi       a1, 0x301, 16
                  sb           t0, 1815(s1)
                  sll          s4, s4, a6
                  lb           a1, 2001(s1)
                  srli         t0, a5, 23
                  lb           a5, -400(s1)
                  xori         a5, s10, -1999
                  lh           t0, 1794(s1)
                  lh           a1, 352(s1)
                  lbu          s4, -1743(s1)
                  lbu          t0, -600(s1)
                  sub          s10, s4, a1
                  lbu          t0, 1012(s1)
                  csrrsi       a1, 0x344, 2
                  lb           s4, -1740(s1)
                  lh           a6, 1582(s1)
                  lbu          a1, 1776(s1)
                  lw           t0, 6(s1)
                  sltu         t0, a6, a6
                  sb           s10, -1221(s1)
                  div          t0, t0, a5
                  xori         a5, a6, -1486
                  sub          a1, s4, a5
                  lbu          a5, -1893(s1)
                  remu         a5, a6, t0
                  lh           s4, -1090(s1)
                  sh           s10, -268(s1)
                  lb           t0, 1211(s1)
                  sll          a6, t0, t0
                  sb           a6, -1351(s1)
                  sb           a1, -1350(s1)
                  lhu          a6, -628(s1)
                  lb           s10, -864(s1)
                  div          s10, s10, a5
                  lb           a5, -1126(s1)
                  srl          t0, s10, a5
                  sb           s10, -1604(s1)
                  csrrw        s10, 0x343, a5
                  xor          a5, t0, a6
                  mulhu        s10, a1, a5
                  lb           a5, -1529(s1)
                  xor          a6, s10, a1
                  lb           s10, -713(s1)
                  lb           t0, -1261(s1)
                  lb           s10, 806(s1)
                  lbu          a6, 2025(s1) #end riscv_hazard_instr_stream_26
                  addi         t5, zero, 10 #init loop 0 counter
                  mulhsu       s9, s3, a4
                  addi         a1, zero, 7 #init loop 0 limit
main_219_0_t:     sub          a3, t2, s7
                  slli         t1, s7, 23
                  addi         t5, t5, -6 #update loop 0 counter
                  slti         s11, t4, 1799
                  xor          t6, t3, a6
                  mul          s3, a1, t5
                  div          t3, a7, s3
                  bgeu         t5, a1, main_219_0_t #branch for loop 0
                  mul          s3, a5, s0
                  la           a2, region_0+2390 #start load_store_instr_stream_1
                  sb           a5, 29(a2)
                  la           s3, region_1+58708 #start load_store_instr_stream_0
                  lbu          s2, 177(a2)
                  sb           s8, -30(a2)
                  sb           s10, 11(s3)
                  lw           t6, 58(a2)
                  lbu          t1, -11(s3)
                  lb           s0, 13(s3)
                  sb           t3, 109(a2)
                  lbu          s0, -13(s3)
                  sh           s2, 206(a2)
                  lbu          a6, 162(a2) #end load_store_instr_stream_1
                  lb           s6, -13(s3) #end load_store_instr_stream_0
                  addi         ra, zero, 7 #init loop 1 counter
                  addi         s1, zero, 15 #init loop 1 limit
main_214_1_t:     sltiu        s7, a7, 1532
                  nop
                  addi         ra, ra, 4 #update loop 1 counter
                  addi         t1, zero, -5 #init loop 0 counter
                  addi         s3, zero, -13 #init loop 0 limit
main_214_0_t:     rem          a3, t0, s7
                  ori          a1, t4, -1728
                  addi         t1, t1, -8 #update loop 0 counter
                  sra          a5, s9, a3
                  bne          t1, s3, main_214_0_t #branch for loop 0
                  auipc        s11, 141917
                  bne          ra, s1, main_214_1_t #branch for loop 1
                  or           gp, s0, s6
main_86:          jal          ra, 4f
0:                jal          t5, 6f
1:                jal          gp, 7f
2:                jal          ra, 17f
3:                jal          ra, 2b
4:                jal          t1, 5f
5:                jal          t1, 12f
6:                jal          t1, 16f
7:                jal          ra, 9f
8:                jal          a6, 21f
9:                jal          ra, 15f
10:               jal          t1, 3b
11:               jal          s2, 1b
12:               jal          ra, 10b
13:               jal          t1, 18f
14:               jal          t1, 11b
15:               jal          ra, 0b
16:               jal          ra, 13b
17:               jal          ra, 8b
18:               jal          ra, 19f
19:               jal          t6, 20f
20:               jal          t0, 22f
21:               jal          ra, 14b
22:               csrrwi       a6, 0x343, 8
                  la           a4, region_1+38903 #start load_store_instr_stream_0
                  la           a5, region_0+612 #start load_store_instr_stream_1
                  lbu          a6, 22(a4)
                  lb           s10, -53(a5)
                  lb           t6, 116(a4)
                  sb           s2, -136(a4)
                  sw           a2, 248(a5)
                  sh           a4, -23(a4)
                  sb           a6, -225(a5)
                  lh           a2, 234(a5)
                  lhu          s11, -57(a4)
                  sb           s11, 31(a5) #end load_store_instr_stream_1
                  lb           t3, 74(a4) #end load_store_instr_stream_0
                  la           t4, region_1+35937 #start load_store_instr_stream_1
                  la           s10, region_1+2565 #start load_store_instr_stream_0
                  sb           t4, 23(s10)
                  lb           a5, -1211(t4)
                  sb           s11, 64(s10)
                  sb           ra, 1382(t4)
                  lbu          t0, -4(s10)
                  lbu          t0, 2032(t4)
                  lbu          s5, -26(s10)
                  lbu          a4, -1706(t4)
                  lbu          a3, -12(t4)
                  lb           zero, -40(s10)
                  lbu          t3, -435(t4)
                  lb           t0, -1570(t4)
                  lb           s11, 8(s10)
                  lh           s2, -17(s10)
                  lb           a7, 15(s10)
                  lbu          zero, 1345(t4) #end load_store_instr_stream_1
                  lb           a2, 24(s10) #end load_store_instr_stream_0
main_116:         jal          ra, 6f
0:                jal          ra, 5f
1:                jal          ra, 14f
2:                jal          t1, 1b
3:                jal          t2, 13f
4:                jal          t5, 2b
5:                jal          ra, 9f
6:                jal          s0, 11f
7:                jal          s5, 12f
8:                jal          gp, 3b
9:                jal          t3, 10f
10:               jal          ra, 7b
11:               jal          ra, 8b
12:               jal          ra, 4b
13:               jal          ra, 0b
14:               rem          t3, t3, s1
                  la           a1, region_0+4067 #start load_store_instr_stream_1
                  la           s11, region_0+3264 #start load_store_instr_stream_0
                  sb           s11, -62(a1)
                  lb           s8, -238(s11)
                  lbu          a2, -46(a1)
                  sb           t0, -46(a1)
                  sh           s4, -15(a1)
                  sb           a5, -35(s11)
                  sb           s7, -58(a1)
                  sb           t0, 6(a1)
                  lb           s5, 11(a1)
                  sh           s10, 54(s11)
                  lhu          s7, 114(s11)
                  lh           s8, 3(a1) #end load_store_instr_stream_1
                  lbu          t1, -116(s11) #end load_store_instr_stream_0
                  la           s5, region_1+28899 #start load_store_instr_stream_0
                  la           s0, region_1+25951 #start load_store_instr_stream_1
                  sb           t6, 105(s5)
                  lbu          t1, -16(s0)
                  lb           s3, 812(s5)
                  lbu          t4, -10(s0)
                  lbu          s3, -534(s5)
                  sb           a3, -1754(s5)
                  lb           s3, 15(s0)
                  sh           s4, -5(s0)
                  sb           a3, 900(s5)
                  lb           s10, -11(s0)
                  lbu          s6, -1400(s5)
                  lb           a5, 1827(s5)
                  lb           a4, -5(s0)
                  lbu          a5, -9(s0) #end load_store_instr_stream_1
                  lb           s3, 1703(s5) #end load_store_instr_stream_0
                  la           s0, region_0+1920 #start riscv_hazard_instr_stream_33
                  mulhsu       t1, a1, s3
                  sh           s3, -12(s0)
                  lb           t0, 7(s0)
                  lbu          s6, 0(s0)
                  lhu          a1, -4(s0)
                  lui          t1, 218043
                  lh           s6, 8(s0)
                  slli         t0, s6, 27
                  sra          a1, s6, s6
                  remu         a5, s3, t1
                  mulh         t1, a1, a1
                  ori          s3, s3, -1415
                  slli         a1, a5, 6
                  nop
                  addi         a5, s6, -633
                  lbu          s6, 10(s0)
                  sb           t0, 4(s0)
                  srli         t1, s3, 13
                  csrrwi       t0, 0x304, 24
                  slt          s6, t0, s3
                  slli         t0, s3, 12
                  lbu          s3, -10(s0)
                  sb           t1, -2(s0)
                  nop
                  lb           a5, 11(s0)
                  srli         s6, t1, 2
                  sb           a1, 11(s0)
                  lhu          t0, 4(s0)
                  lbu          s3, -2(s0) #end riscv_hazard_instr_stream_33
                  la           s6, region_0+718 #start riscv_hazard_instr_stream_27
                  srli         t1, a3, 8
                  slli         a7, zero, 27
                  csrrwi       zero, 0x301, 8
                  lbu          a5, 875(s6)
                  div          a7, zero, t0
                  lb           a5, 18(s6)
                  lbu          a3, 271(s6)
                  lbu          a7, 431(s6)
                  lbu          a3, 1065(s6)
                  auipc        a5, 629925
                  slt          a3, a5, a5
                  xori         a5, a3, 209
                  nop
                  lh           t1, -122(s6)
                  lb           a7, 1164(s6)
                  csrrsi       t1, 0x305, 0
                  ori          a7, t0, 131
                  divu         t1, a5, a5
                  lbu          t0, 29(s6)
                  csrrw        a7, 0x342, t1
                  add          t0, a5, zero
                  add          t1, a3, a7
                  lh           zero, 1312(s6)
                  mul          t0, a7, zero
                  lb           t0, 591(s6)
                  csrrwi       a5, 0x342, 21
                  lhu          t0, 1780(s6)
                  lh           t0, 1584(s6)
                  csrrc        t1, 0x304, zero
                  sra          t1, a5, a3
                  csrrsi       a7, 0x344, 0
                  sb           zero, 1655(s6)
                  sw           a7, -650(s6)
                  lbu          t0, -581(s6)
                  sb           a7, 1833(s6) #end riscv_hazard_instr_stream_27
                  la           a6, region_0+2100 #start riscv_load_store_hazard_instr_stream_4
                  lui          s6, 459761
                  sb           tp, 13(a6)
                  lb           zero, 13(a6)
                  sb           tp, 13(a6)
                  lb           a1, 13(a6)
                  sb           a0, 7(a6)
                  lbu          t4, 7(a6)
                  sb           s5, 7(a6)
                  sb           a5, 7(a6)
                  lb           s11, 7(a6)
                  lbu          s1, 7(a6)
                  csrrwi       s3, 0x301, 2
                  sb           s5, -15(a6) #end riscv_load_store_hazard_instr_stream_4
                  la           s5, region_0+3454 #start riscv_load_store_rand_instr_stream_11
                  lb           a2, -1577(s5)
                  lb           zero, 223(s5)
                  sra          t6, a3, a4
                  lbu          s9, -1328(s5)
                  remu         s1, s0, t0
                  andi         t4, t3, 1119
                  sb           s10, 501(s5)
                  sub          zero, s2, s3
                  sub          s3, t3, a5
                  lhu          a4, -1892(s5)
                  csrrw        a1, 0x304, s7
                  remu         s8, gp, a0
                  lhu          s1, 12(s5)
                  sb           s3, 468(s5)
                  lh           s10, -1372(s5)
                  and          s9, a0, sp
                  csrrsi       s2, 0x300, 0
                  lb           t1, -573(s5)
                  csrrw        t2, 0x301, s2
                  lhu          s6, -548(s5)
                  lw           s11, -1274(s5)
                  sb           a0, -1697(s5)
                  srai         s10, gp, 2
                  sb           s7, -1461(s5)
                  csrrsi       s7, 0x300, 0
                  lbu          t5, -429(s5)
                  lb           t0, -131(s5)
                  lbu          gp, 635(s5)
                  lh           zero, 334(s5)
                  divu         s1, s0, a2
                  lb           s4, -1961(s5)
                  divu         s7, gp, s6
                  lhu          s3, -2034(s5) #end riscv_load_store_rand_instr_stream_11
main_83:          jal          ra, 7f
0:                jal          t1, 1f
1:                jal          t5, 9f
2:                jal          ra, 8f
3:                jal          t1, 4f
4:                jal          ra, 10f
5:                jal          t1, 6f
6:                jal          ra, 3b
7:                jal          gp, 0b
8:                jal          ra, 5b
9:                jal          s3, 2b
10:               sltu         t3, a1, s8
                  li           t4, 0x80000000 #start riscv_int_numeric_corner_stream_10
                  li           a6, 0xffffffff
                  li           a3, 0x80000000
                  li           s0, 0x80000000
                  li           t3, 0x0
                  li           t6, 0xffffffff
                  li           a2, 0xffffffff
                  li           t1, 0x80000000
                  li           s11, 0x80000000
                  li           a1, 0x80000000
                  rem          s11, s0, t4
                  nop
                  auipc        t6, 790263
                  mulhsu       a3, t6, a2
                  nop
                  remu         t1, s0, s11
                  addi         t6, s0, 1475
                  add          s0, t6, a2
                  rem          a3, s11, s0
                  lui          t1, 795845
                  nop
                  sub          a3, a2, s0
                  nop
                  nop
                  addi         a3, t6, -1646
                  rem          t4, s11, s11
                  auipc        s11, 105896 #end riscv_int_numeric_corner_stream_10
                  addi         a5, zero, 8 #init loop 0 counter
                  srli         s0, s7, 13
                  sra          t5, s5, s5
                  and          s4, a4, a6
                  addi         s8, zero, 8 #init loop 0 limit
                  lui          t0, 107783
                  srl          s10, t4, a4
                  mulhu        t6, a6, s11
                  sra          a3, a2, t4
                  slti         gp, s6, 857
                  add          s9, t5, t2
                  csrrci       t6, 0x342, 10
main_215_0_t:     auipc        a3, 827681
                  slt          s7, a0, s8
                  csrrwi       s1, 0x342, 6
                  addi         a5, a5, -7 #update loop 0 counter
                  rem          a6, s3, a4
                  csrrsi       a2, 0x301, 0
                  slli         t0, s10, 19
                  bgeu         a5, s8, main_215_0_t #branch for loop 0
                  csrrs        s10, 0x301, zero
                  addi         t3, zero, 10 #init loop 0 counter
                  div          s10, t4, a0
                  mul          s0, a7, s1
                  sub          s8, t1, sp
                  ori          zero, s6, 834
                  srai         t0, a2, 8
                  addi         s6, zero, -16 #init loop 0 limit
                  sub          s4, a2, t3
                  slti         s2, t0, -855
main_217_0_t:     xor          a6, ra, t0
                  addi         t3, t3, -8 #update loop 0 counter
                  andi         ra, t6, 1663
                  srli         s10, s1, 8
                  csrrc        t4, 0x344, ra
                  slt          ra, s6, s3
                  bge          t3, s6, main_217_0_t #branch for loop 0
                  csrrci       zero, 0x342, 7
                  la           ra, region_0+608 #start riscv_load_store_rand_instr_stream_20
                  rem          a3, t6, a1
                  mulhu        s3, gp, a7
                  sb           t3, 9(ra)
                  mulh         gp, s5, s1
                  lhu          s0, -16(ra)
                  mulhu        gp, a6, ra
                  sb           t0, 1(ra)
                  sb           s0, 1(ra)
                  sb           a1, 3(ra)
                  lb           t6, -7(ra)
                  csrrsi       a1, 0x342, 0
                  rem          zero, a1, gp
                  slt          s11, t5, s10
                  sb           gp, -13(ra)
                  csrrsi       a1, 0x342, 0
                  csrrc        t0, 0x301, a0
                  andi         s2, t5, -1919
                  sb           zero, -2(ra)
                  lb           s3, -16(ra)
                  lhu          a6, 16(ra)
                  lbu          s1, 1(ra)
                  csrrwi       s1, 0x342, 26
                  lhu          t6, -10(ra)
                  srli         a6, zero, 2
                  csrrsi       t1, 0x301, 0
                  srl          a3, t3, t3
                  sb           s6, 11(ra)
                  srli         s11, t4, 3
                  sub          a2, a3, s7
                  csrrs        t2, 0x305, zero
                  lb           t5, 13(ra)
                  mul          s5, s2, a3
                  srai         zero, s4, 21
                  lbu          s8, -1(ra)
                  divu         s0, t5, s8
                  lbu          t5, -14(ra)
                  csrrs        t1, 0x343, t4
                  sra          t0, s8, a3
                  div          s11, s1, t1
                  xor          a6, sp, sp
                  lh           s5, 10(ra)
                  addi         s2, tp, 1807
                  div          t1, s2, s2
                  divu         zero, a6, a2
                  mulh         s7, s8, sp
                  andi         a1, a4, 588
                  mulhu        s10, s1, s9
                  lbu          t4, -12(ra) #end riscv_load_store_rand_instr_stream_20
                  li           s0, 0x0 #start riscv_int_numeric_corner_stream_33
                  li           t3, 0x0
                  li           s5, 0x0
                  li           t1, 0x0
                  li           gp, 0xffffffff
                  li           a5, 0xe1b442d7
                  li           a7, 0x0
                  li           s4, 0x3121437d
                  li           t0, 0xffffffff
                  li           a4, 0x80000000
                  auipc        a5, 990904
                  mul          a4, t0, a4
                  divu         a5, s4, s5
                  sub          s0, s5, a4
                  auipc        s5, 226722
                  remu         s0, s5, t3
                  auipc        t1, 16078
                  lui          gp, 664869
                  sub          t3, t3, a4
                  div          t0, s5, a4
                  mulhu        s0, s0, t3
                  auipc        s5, 52613
                  addi         t1, gp, -1563
                  divu         s5, a7, s5
                  mulhu        t1, t3, s0
                  nop #end riscv_int_numeric_corner_stream_33
                  addi         s4, zero, -9 #init loop 1 counter
                  csrrci       s7, 0x300, 0
                  addi         s6, zero, -13 #init loop 1 limit
                  rem          a2, s11, sp
                  divu         a3, s3, a1
main_222_1_t:     or           t5, a7, s10
                  addi         s4, s4, -4 #update loop 1 counter
                  add          a5, t6, s1
                  addi         gp, zero, -4 #init loop 0 counter
                  addi         t4, zero, -18 #init loop 0 limit
                  nop
main_222_0_t:     sltu         a1, s1, a7
                  div          s2, ra, zero
                  xor          t3, s1, t1
                  sll          a7, t4, s11
                  csrrsi       s8, 0x301, 0
                  addi         gp, gp, -7 #update loop 0 counter
                  or           s5, a5, t5
                  beq          gp, t4, main_222_0_t #branch for loop 0
                  and          s2, a0, t4
                  bne          s4, s6, main_222_1_t #branch for loop 1
                  rem          a4, s6, s10
                  li           s10, 0x0 #start riscv_int_numeric_corner_stream_24
                  li           t0, 0x80000000
                  li           gp, 0xffffffff
                  li           s5, 0x3fdae295
                  li           s6, 0x98895d57
                  li           s3, 0x80000000
                  li           a1, 0xffffffff
                  li           ra, 0xffffffff
                  li           t3, 0xffffffff
                  li           s8, 0xffffffff
                  lui          a1, 589454
                  rem          s3, s10, ra
                  sub          s6, s8, s5
                  mulhu        a1, s10, s6
                  div          s10, t3, t3
                  lui          t0, 354871
                  rem          s10, t0, ra
                  mulhsu       s10, s10, gp
                  lui          s6, 814030
                  mulhu        a1, t0, t0
                  lui          s6, 848855
                  rem          t3, s3, t3
                  nop
                  div          s6, gp, s3
                  mulhsu       s8, s8, s6
                  remu         ra, s3, t3
                  nop
                  mulh         t0, gp, s10
                  mulhsu       ra, s5, s3
                  nop
                  mulh         s6, s6, t3
                  divu         t0, s10, a1
                  div          gp, ra, s10
                  remu         s5, s8, t3
                  sub          a1, s10, s10
                  lui          s3, 201923
                  mulhu        s8, ra, a1
                  div          gp, s6, ra
                  div          s3, gp, s8
                  mulhsu       s10, t3, a1 #end riscv_int_numeric_corner_stream_24
                  addi         a5, zero, 1 #init loop 0 counter
                  mulh         gp, a1, zero
                  add          s6, t5, t0
                  xori         s11, s11, -1046
                  csrrw        gp, 0x304, s6
                  slli         s7, a0, 8
                  auipc        s7, 1006966
                  sltiu        ra, s10, 1905
                  mulh         s3, s5, t6
                  mulhsu       t3, zero, s5
                  divu         ra, tp, t3
                  addi         t2, zero, 17 #init loop 0 limit
                  mul          s4, s1, s9
                  and          ra, s0, s1
main_234_0_t:     xori         t6, t5, -745
                  addi         a5, a5, 4 #update loop 0 counter
                  csrrw        s2, 0x304, a2
                  div          zero, a5, s5
                  sra          s9, s8, a0
                  slt          t5, a1, s4
                  xori         s7, s10, -340
                  lui          t4, 1002988
                  sra          s1, s4, s2
                  csrrwi       s4, 0x342, 23
                  sll          t3, a3, s3
                  bltu         a5, t2, main_234_0_t #branch for loop 0
                  sub          s0, s2, a6
                  la           s10, region_1+28712 #start riscv_load_store_rand_instr_stream_12
                  rem          s0, s8, ra
                  lh           t2, -8(s10)
                  divu         s2, tp, s1
                  lhu          t0, 16(s10)
                  mulh         s0, t2, t1
                  sub          ra, zero, zero
                  and          s8, ra, s9
                  sh           s11, -8(s10)
                  lbu          s0, -10(s10)
                  slt          a3, s3, s7
                  csrrci       t4, 0x304, 26
                  slti         zero, t6, 1270
                  lb           t2, -3(s10)
                  sh           a3, 10(s10)
                  lbu          a1, 1(s10)
                  lb           s5, -9(s10)
                  lhu          s1, -2(s10)
                  lb           ra, -5(s10)
                  or           s3, s11, gp
                  add          t6, a4, s6
                  lb           t1, -7(s10)
                  lbu          s11, 4(s10)
                  mulhu        s0, a3, gp
                  sltu         t1, s11, s7
                  lbu          s7, -9(s10)
                  addi         ra, s8, -1473
                  lhu          a2, -12(s10)
                  andi         a3, a7, 2000
                  csrrc        s7, 0x344, s10
                  lbu          zero, -2(s10)
                  andi         s0, s7, -399
                  sw           s6, -16(s10)
                  auipc        s3, 586299
                  slti         s4, a1, -1160
                  lb           ra, -11(s10)
                  addi         a7, gp, 1414
                  csrrwi       ra, 0x301, 13
                  srli         s2, a1, 4
                  slli         t0, s6, 4
                  lb           a6, -1(s10)
                  csrrw        s8, 0x344, s0
                  lb           a4, -12(s10)
                  lb           a5, -13(s10)
                  lhu          s0, 16(s10)
                  sb           t1, 6(s10)
                  sh           s10, 0(s10)
                  lb           a5, -8(s10)
                  lbu          s1, -7(s10)
                  lbu          s5, -8(s10) #end riscv_load_store_rand_instr_stream_12
                  la           a1, region_0+896 #start riscv_hazard_instr_stream_32
                  mulhu        a7, a7, s2
                  lb           a3, -513(a1)
                  addi         a7, a3, 341
                  lh           s2, -312(a1)
                  srl          s2, s1, a4
                  sll          s1, s1, s2
                  lbu          t3, -42(a1)
                  lbu          s2, 24(a1)
                  div          t3, a3, t3
                  sb           a7, -510(a1)
                  slt          s1, a3, t3
                  csrrwi       a7, 0x343, 26
                  csrrs        a4, 0x342, s2
                  sh           a7, 1478(a1)
                  lb           s1, 1298(a1)
                  lhu          a3, 1104(a1)
                  sb           a7, 1063(a1)
                  lb           a4, -361(a1)
                  sb           t3, 270(a1)
                  lb           a7, 165(a1)
                  or           a4, s1, s2
                  lh           s1, 1582(a1)
                  sw           s1, 1480(a1)
                  rem          a7, a4, t3
                  sh           s2, 264(a1)
                  lbu          t3, 1259(a1)
                  sb           a3, 577(a1)
                  slt          a3, s1, s1
                  xor          a3, a3, t3
                  csrrc        s1, 0x344, t3
                  slli         a7, a4, 13
                  srli         s1, t3, 1
                  lb           a3, 2038(a1)
                  slli         t3, a7, 28
                  sb           a4, 2011(a1)
                  lb           s2, 1329(a1)
                  sb           a4, 133(a1)
                  lbu          s2, 639(a1) #end riscv_hazard_instr_stream_32
                  la           a5, region_0+4087 #start riscv_load_store_hazard_instr_stream_12
                  sb           ra, -1896(a5)
                  remu         a4, s2, s8
                  lbu          ra, -410(a5)
                  lhu          t5, -649(a5)
                  lhu          t1, -1453(a5)
                  lbu          zero, -1453(a5)
                  lb           t4, -1453(a5)
                  sb           a1, -1453(a5)
                  sll          s6, s7, s1
                  xori         s8, s6, 65
                  sb           s0, -1120(a5)
                  lbu          s9, -1500(a5)
                  sb           a2, -1500(a5)
                  sltu         s4, t5, gp
                  sb           s3, -733(a5)
                  lbu          ra, -733(a5)
                  lb           s3, -733(a5)
                  mulh         t3, t1, tp
                  sb           s5, -537(a5)
                  lbu          a3, -351(a5)
                  sb           s2, -1528(a5)
                  lw           s5, -283(a5) #end riscv_load_store_hazard_instr_stream_12
main_112:         jal          ra, 3f
0:                jal          s2, 11f
1:                jal          t1, 13f
2:                jal          s0, 12f
3:                jal          t0, 6f
4:                jal          t1, 5f
5:                jal          ra, 2b
6:                jal          t1, 10f
7:                jal          t0, 8f
8:                jal          ra, 1b
9:                jal          ra, 4b
10:               jal          ra, 0b
11:               jal          ra, 9b
12:               jal          ra, 7b
13:               srli         t5, a4, 13
                  la           s3, region_1+43116 #start load_store_instr_stream_0
                  lb           gp, 0(s3)
                  la           s8, region_0+2176 #start load_store_instr_stream_1
                  sb           s9, -1(s3)
                  lbu          s10, -15(s3)
                  lbu          a4, 9(s3)
                  sb           a1, -3(s3)
                  sh           t5, 182(s8)
                  sb           a3, -435(s8)
                  lbu          t0, 10(s3)
                  lh           zero, 1282(s8)
                  lhu          ra, 12(s3)
                  lbu          t5, 242(s8)
                  sh           a0, 2(s3)
                  sh           s1, -1070(s8) #end load_store_instr_stream_1
                  sb           s6, 0(s3) #end load_store_instr_stream_0
main_93:          jal          ra, 18f
0:                jal          ra, 13f
1:                jal          ra, 10f
2:                jal          ra, 16f
3:                jal          t1, 20f
4:                jal          ra, 23f
5:                jal          t0, 0b
6:                jal          ra, 2b
7:                jal          a2, 19f
8:                jal          t1, 5b
9:                jal          ra, 3b
10:               jal          ra, 12f
11:               jal          ra, 15f
12:               jal          a1, 21f
13:               jal          a2, 6b
14:               jal          ra, 9b
15:               jal          ra, 14b
16:               jal          ra, 17f
17:               jal          a1, 24f
18:               jal          t1, 22f
19:               jal          t1, 1b
20:               jal          t1, 8b
21:               jal          t0, 11b
22:               jal          ra, 4b
23:               jal          ra, 7b
24:               divu         gp, ra, a6
                  addi         s1, zero, 9 #init loop 0 counter
                  sltu         s4, a0, s5
                  addi         s2, zero, 9 #init loop 0 limit
                  csrrsi       zero, 0x343, 7
main_200_0_t:     divu         s10, a3, s10
                  andi         s11, a1, -411
                  sub          s6, t2, a2
                  addi         s1, s1, -8 #update loop 0 counter
                  bgeu         s1, s2, main_200_0_t #branch for loop 0
                  andi         t3, gp, 35
                  la           a7, region_1+26309 #start load_store_instr_stream_1
                  la           s11, region_1+47128 #start load_store_instr_stream_2
                  la           s10, region_1+34059 #start load_store_instr_stream_3
                  sw           s9, -204(s11)
                  la           s3, region_1+14661 #start load_store_instr_stream_0
                  lb           zero, 3(s10)
                  lbu          ra, -78(s11)
                  lbu          s2, -1(s10)
                  lb           gp, 74(s11)
                  sh           s2, -1(s10)
                  sb           a7, -12(s10)
                  lh           t2, -105(s3)
                  lw           a2, 183(a7)
                  lh           t4, -27(s3)
                  lh           zero, 111(a7)
                  lb           s8, -88(s11)
                  lw           t1, 147(a7)
                  lbu          t2, -9(s10)
                  lbu          ra, -23(s11)
                  lb           t0, 184(a7)
                  lbu          a2, 171(s11)
                  lb           a3, -117(s3)
                  lbu          t1, 8(s10)
                  lw           s1, 248(s11)
                  lbu          a4, -10(s3)
                  lb           s9, 179(s11)
                  lb           s6, 85(s3)
                  lbu          s8, -4(s10)
                  lb           t3, 6(s10)
                  lw           a2, -112(s11) #end load_store_instr_stream_2
                  sb           gp, -32(a7) #end load_store_instr_stream_1
                  lb           a5, -12(s10) #end load_store_instr_stream_3
                  lb           t5, -156(s3) #end load_store_instr_stream_0
                  la           s5, region_0+1987 #start riscv_load_store_rand_instr_stream_1
                  mulh         s6, s10, t6
                  sll          s2, zero, s0
                  lbu          s7, 123(s5)
                  sub          ra, a2, s1
                  xori         s2, a3, -39
                  sltu         s1, s9, s0
                  xori         s1, t3, -1783
                  sh           s0, -87(s5)
                  lbu          s1, 24(s5)
                  csrrc        t5, 0x300, zero
                  sh           s7, -249(s5)
                  csrrsi       s9, 0x344, 4
                  lh           s6, 191(s5)
                  and          t4, a7, sp
                  lbu          s7, -182(s5)
                  lb           gp, 133(s5)
                  sh           s6, -157(s5)
                  nop
                  lbu          a7, -198(s5)
                  csrrs        s0, 0x343, t1
                  mulh         a7, gp, t0
                  mulhu        s2, a2, s11
                  lbu          s4, -148(s5)
                  mul          s9, a5, t5
                  lb           t5, -104(s5)
                  lb           s7, -155(s5)
                  lhu          a2, 211(s5)
                  slti         a4, a2, 184
                  mulhu        a2, a0, t5
                  div          s4, a3, s11
                  lbu          a4, -154(s5)
                  mulhu        s4, zero, t4
                  addi         t0, t0, 1135
                  lbu          gp, 30(s5)
                  csrrc        t4, 0x342, zero
                  nop
                  lb           a4, 16(s5)
                  sltiu        ra, t0, 1832
                  addi         a4, a3, -1957
                  lb           a2, 94(s5)
                  csrrc        a6, 0x342, zero
                  sb           a3, 198(s5) #end riscv_load_store_rand_instr_stream_1
                  la           gp, region_0+756 #start load_store_instr_stream_1
                  la           a1, region_0+308 #start load_store_instr_stream_3
                  lw           a7, -40(gp)
                  la           t1, region_0+2807 #start load_store_instr_stream_0
                  lbu          t4, 50(gp)
                  la           s10, region_0+1225 #start load_store_instr_stream_2
                  lh           t4, 38(gp)
                  sh           t5, 53(t1)
                  sb           s6, 143(s10)
                  lb           t4, -21(gp)
                  lhu          s3, 93(s10)
                  sb           t3, 11(a1)
                  lbu          s6, 58(s10)
                  lb           s7, 193(t1)
                  lb           s9, -32(gp)
                  sh           a3, -155(t1)
                  lb           t3, 176(s10)
                  lb           s9, 13(gp)
                  lbu          a3, -1(gp)
                  sb           a6, 13(t1)
                  lw           a6, -29(s10)
                  lb           s5, 9(a1)
                  lb           zero, 18(gp)
                  lbu          s6, 47(a1)
                  lb           a7, -198(s10)
                  sw           t6, 8(a1)
                  sh           a2, 28(gp)
                  lb           t2, 214(t1)
                  lbu          t3, 3(a1)
                  lb           t0, -6(a1)
                  lbu          s8, -2(t1)
                  lb           s3, -211(s10)
                  sb           s8, 128(s10)
                  lbu          zero, -61(gp) #end load_store_instr_stream_1
                  sb           s10, 211(s10) #end load_store_instr_stream_2
                  sb           s8, -26(a1) #end load_store_instr_stream_3
                  sb           a0, -82(t1) #end load_store_instr_stream_0
                  la           gp, region_1+16287 #start load_store_instr_stream_1
                  la           t5, region_0+3684 #start load_store_instr_stream_0
                  lbu          a1, -60(gp)
                  lb           s4, 199(t5)
                  lb           s9, 17(t5)
                  lw           s10, 169(gp)
                  lh           s10, 142(t5)
                  lbu          zero, 110(gp)
                  lhu          t0, 154(t5)
                  sh           zero, 119(gp)
                  sh           s8, -176(t5)
                  lb           s0, 99(t5)
                  lbu          a1, -220(gp) #end load_store_instr_stream_1
                  lbu          t3, 148(t5)
                  lbu          zero, -133(t5)
                  lhu          a6, 156(t5)
                  sb           sp, -19(t5) #end load_store_instr_stream_0
                  la           a5, region_0+633 #start riscv_load_store_hazard_instr_stream_2
                  lb           a3, -54(a5)
                  lbu          s0, -45(a5)
                  sb           a6, 19(a5)
                  lbu          s4, -28(a5)
                  csrrc        a3, 0x344, a4
                  lbu          s7, -28(a5)
                  lbu          t1, -45(a5)
                  sub          t1, t6, a3
                  lb           s0, -45(a5)
                  lh           zero, 1(a5)
                  lbu          s3, 1(a5)
                  lbu          t6, 41(a5)
                  sh           t1, 31(a5)
                  lbu          s11, 10(a5)
                  sh           s1, -51(a5)
                  lhu          s2, 35(a5) #end riscv_load_store_hazard_instr_stream_2
                  la           a2, region_1+49330 #start riscv_load_store_hazard_instr_stream_24
                  lb           t0, -7(a2)
                  lbu          zero, -7(a2)
                  lbu          s9, -7(a2)
                  lb           t1, -7(a2)
                  sw           s2, -14(a2)
                  lb           t6, -14(a2)
                  lb           t6, -12(a2)
                  lbu          a3, -7(a2)
                  lw           t4, -14(a2)
                  mulhu        a7, a3, a5
                  sb           s9, 15(a2)
                  lbu          t0, 2(a2)
                  lbu          s10, 2(a2)
                  sb           tp, 3(a2)
                  sb           t6, -4(a2)
                  sh           a6, -4(a2)
                  or           a5, sp, s4
                  mulhsu       s4, s7, a3
                  lh           gp, -4(a2)
                  sw           gp, 10(a2) #end riscv_load_store_hazard_instr_stream_24
                  la           s2, region_1+27566 #start load_store_instr_stream_0
                  la           t6, region_0+981 #start load_store_instr_stream_1
                  lb           s6, 9(s2)
                  lhu          s7, 1661(t6)
                  lh           s11, 709(t6)
                  sb           zero, 5(s2)
                  sh           s11, 1711(t6)
                  sb           ra, 3(s2)
                  sh           s10, 1485(t6)
                  lb           t2, 4(s2)
                  lb           s11, 1562(t6)
                  lb           s7, 15(s2)
                  lb           t5, 3(s2)
                  lhu          a6, 14(s2)
                  lb           s1, -470(t6)
                  lw           t1, 10(s2)
                  sh           ra, -12(s2)
                  sb           s7, 589(t6) #end load_store_instr_stream_1
                  lbu          a4, 1(s2) #end load_store_instr_stream_0
                  la           s5, region_0+2308 #start load_store_instr_stream_0
                  la           t0, region_1+46986 #start load_store_instr_stream_1
                  lhu          a1, -8(s5)
                  sh           a3, -14(s5)
                  lbu          a7, -29(t0)
                  lb           a2, -10(s5)
                  lhu          s6, 2(s5)
                  lbu          s11, -8(t0)
                  lbu          zero, 59(t0)
                  lb           a3, 1(s5)
                  lbu          t6, -5(s5)
                  lbu          t6, -45(t0)
                  lb           a6, 5(s5)
                  lhu          zero, -2(s5)
                  lbu          s2, -10(s5)
                  lh           ra, -34(t0) #end load_store_instr_stream_1
                  sb           a7, 13(s5) #end load_store_instr_stream_0
main_108:         jal          ra, 3f
0:                jal          ra, 5f
1:                jal          t5, 10f
2:                jal          ra, 4f
3:                jal          ra, 8f
4:                jal          t0, 1b
5:                jal          ra, 6f
6:                jal          t1, 7f
7:                jal          t0, 11f
8:                jal          ra, 9f
9:                jal          ra, 2b
10:               jal          ra, 0b
11:               jal          ra, 12f
12:               and          t2, a4, s4
main_118:         jal          ra, 18f
0:                jal          ra, 5f
1:                jal          a4, 12f
2:                jal          s7, 26f
3:                jal          ra, 29f
4:                jal          t0, 14f
5:                jal          s8, 3b
6:                jal          ra, 30f
7:                jal          a3, 8f
8:                jal          ra, 21f
9:                jal          ra, 13f
10:               jal          t0, 22f
11:               jal          s9, 20f
12:               jal          ra, 9b
13:               jal          t5, 4b
14:               jal          ra, 10b
15:               jal          t1, 7b
16:               jal          t1, 17f
17:               jal          t0, 15b
18:               jal          ra, 0b
19:               jal          ra, 23f
20:               jal          ra, 24f
21:               jal          t1, 25f
22:               jal          ra, 16b
23:               jal          ra, 27f
24:               jal          a4, 1b
25:               jal          t1, 19b
26:               jal          ra, 28f
27:               jal          ra, 2b
28:               jal          ra, 6b
29:               jal          gp, 11b
30:               nop
                  la           a7, region_0+2658 #start riscv_hazard_instr_stream_3
                  slli         s8, s1, 23
                  lb           s8, 19(a7)
                  lb           s3, -27(a7)
                  slt          s1, a5, t0
                  sb           s3, 64(a7)
                  lw           a5, 34(a7)
                  lbu          s8, -18(a7)
                  or           s1, t0, s1
                  sb           a5, -33(a7)
                  divu         s3, s1, s8
                  sll          s8, s3, s8
                  sub          a4, a4, a4
                  lbu          s1, -28(a7)
                  csrrw        a4, 0x304, s1
                  csrrwi       a4, 0x342, 30
                  sb           s8, 31(a7)
                  lbu          t0, -15(a7)
                  lbu          s1, -15(a7)
                  csrrw        s8, 0x342, s3
                  sb           a4, -49(a7)
                  sb           s1, -53(a7)
                  rem          a4, s1, t0
                  csrrs        a5, 0x344, t0
                  csrrs        s3, 0x344, s3
                  csrrs        t0, 0x304, t0
                  xor          a5, s1, t0
                  srli         s8, a5, 8
                  sb           a4, -5(a7)
                  rem          s3, s3, t0
                  lb           s8, -25(a7)
                  csrrci       a4, 0x304, 0
                  lbu          t0, 55(a7)
                  rem          s8, s1, s8
                  sb           t0, 53(a7)
                  lw           s8, 42(a7)
                  lbu          a4, -52(a7)
                  sltu         t0, s1, s3
                  sh           s3, 34(a7)
                  sb           a4, 37(a7)
                  and          a4, s1, a5
                  or           a4, a5, a4
                  lui          s8, 998400
                  sb           t0, -3(a7)
                  lb           a4, -43(a7)
                  srl          t0, s1, a5
                  sb           t0, -15(a7)
                  remu         s1, t0, a4
                  lb           s1, 45(a7)
                  lb           t0, -19(a7)
                  lh           s3, -10(a7)
                  sb           s1, -43(a7)
                  lh           s8, -52(a7)
                  lh           s1, -60(a7)
                  lb           t0, -61(a7) #end riscv_hazard_instr_stream_3
                  la           t5, region_1+52215 #start riscv_load_store_hazard_instr_stream_23
                  lbu          a4, 417(t5)
                  lw           a5, 417(t5)
                  lw           s0, -1555(t5)
                  lbu          a1, -1798(t5)
                  remu         s7, s4, a2
                  sh           s11, -519(t5)
                  lw           t4, -519(t5)
                  sb           sp, -2036(t5)
                  csrrs        s3, 0x300, zero
                  srl          s4, s0, a6
                  sb           s8, -76(t5)
                  sw           t2, 1601(t5)
                  nop
                  lbu          s7, -1193(t5)
                  lb           s0, -473(t5)
                  lb           s7, -1606(t5)
                  sb           s10, 1032(t5)
                  sltiu        a3, t0, -1036
                  lbu          s9, 859(t5)
                  lhu          s6, -981(t5) #end riscv_load_store_hazard_instr_stream_23
                  la           s8, region_1+20684 #start riscv_load_store_hazard_instr_stream_10
                  andi         s5, zero, -287
                  csrrwi       zero, 0x301, 29
                  lb           t6, 2(s8)
                  lhu          t4, 2(s8)
                  add          a3, a0, s5
                  sb           t0, 2(s8)
                  add          s1, t4, s7
                  lb           a7, -15(s8)
                  lhu          a5, -6(s8)
                  srai         gp, s6, 27
                  csrrci       s0, 0x344, 0
                  lb           gp, 6(s8)
                  sb           a5, 6(s8)
                  sb           a4, 6(s8)
                  lhu          s0, -12(s8)
                  sh           tp, -12(s8)
                  sw           s4, -12(s8)
                  lb           s7, -12(s8)
                  lb           a6, -12(s8)
                  sh           t2, -12(s8)
                  sb           a0, -11(s8)
                  sb           t2, -11(s8)
                  srli         a3, s3, 22
                  sb           a2, 3(s8) #end riscv_load_store_hazard_instr_stream_10
                  la           a4, region_1+4715 #start riscv_load_store_rand_instr_stream_26
                  lhu          s8, 7(a4)
                  lb           a2, 0(a4)
                  slt          zero, s5, s10
                  xor          s2, s8, t4
                  lb           a7, 12(a4)
                  csrrsi       s8, 0x305, 0
                  sb           a1, 1(a4)
                  csrrc        zero, 0x301, zero
                  srl          t2, t1, a7
                  lh           a3, -11(a4)
                  sh           sp, -13(a4)
                  nop
                  sb           s11, 11(a4)
                  lb           a6, -16(a4)
                  sh           s11, 15(a4)
                  sw           t3, 5(a4)
                  lb           s2, -10(a4)
                  sh           t3, -15(a4)
                  sb           s7, -1(a4)
                  lb           a5, 9(a4)
                  csrrwi       s11, 0x304, 10
                  lb           s10, 11(a4)
                  lb           t0, -2(a4)
                  lh           ra, -5(a4)
                  lb           a5, -9(a4)
                  lb           s5, 4(a4)
                  lb           t5, 6(a4)
                  sb           t4, -11(a4)
                  mulh         t1, a4, t2
                  csrrc        t3, 0x342, a7
                  auipc        a7, 305446
                  lbu          a7, -13(a4)
                  sb           s6, 4(a4)
                  lb           t3, 4(a4)
                  lbu          gp, -7(a4)
                  sb           ra, 4(a4) #end riscv_load_store_rand_instr_stream_26
main_90:          jal          ra, 1f
0:                jal          ra, 3f
1:                jal          s5, 2f
2:                jal          t1, 8f
3:                jal          ra, 5f
4:                jal          t1, 0b
5:                jal          s6, 11f
6:                jal          t0, 4b
7:                jal          ra, 10f
8:                jal          t1, 9f
9:                jal          ra, 7b
10:               jal          ra, 6b
11:               ori          gp, a2, -1214
                  addi         t1, zero, -3 #init loop 0 counter
                  csrrs        t6, 0x305, zero
                  csrrwi       s0, 0x344, 18
                  addi         t4, zero, 11 #init loop 0 limit
                  srl          s9, a2, s1
                  ori          t3, a4, 1082
                  mulhu        a2, a0, t1
main_206_0_t:     slt          s8, a7, t3
                  ori          t2, a2, 786
                  addi         t1, t1, 2 #update loop 0 counter
                  lui          s5, 649306
                  csrrc        ra, 0x343, zero
                  csrrc        s1, 0x300, zero
                  srai         t3, a7, 29
                  slt          s2, s5, s6
                  csrrw        a3, 0x342, t0
                  srai         a2, a3, 28
                  sltiu        s10, s5, -1348
                  csrrci       a1, 0x343, 0
                  mulhu        s7, t4, s5
                  mulhu        gp, tp, s8
                  csrrs        a3, 0x301, a2
                  rem          a5, a3, t6
                  remu         t6, s5, a2
                  mul          ra, t1, s7
                  xori         s6, tp, 1910
                  sll          t5, gp, sp
                  blt          t1, t4, main_206_0_t #branch for loop 0
                  sltiu        t0, s3, 657
                  li           gp, 0xffffffff #start riscv_int_numeric_corner_stream_37
                  li           s9, 0x0
                  li           s10, 0xffffffff
                  li           t4, 0x0
                  li           t1, 0x80000000
                  li           s7, 0x0
                  li           a6, 0x0
                  li           s3, 0xffffffff
                  li           a5, 0x0
                  li           a2, 0xd51a88d9
                  auipc        s9, 176344
                  lui          a2, 910811
                  divu         s9, a6, t4
                  mulh         a6, t4, a5
                  addi         gp, s7, 986
                  lui          a2, 513703
                  add          t4, gp, s7
                  divu         gp, gp, a2
                  sub          gp, a2, t1
                  add          gp, a6, gp
                  rem          s3, a2, s7
                  auipc        a5, 750204
                  divu         a5, a6, s10
                  mulh         t1, s9, gp
                  rem          s3, a6, t4
                  add          s9, gp, s10
                  mul          a6, a5, s7
                  nop
                  auipc        s10, 128846
                  nop #end riscv_int_numeric_corner_stream_37
                  la           s0, region_0+1369 #start riscv_load_store_hazard_instr_stream_0
                  sh           s11, -45(s0)
                  sb           a4, -30(s0)
                  sb           t0, 40(s0)
                  lb           a7, 2(s0)
                  lbu          a2, 2(s0)
                  sb           a6, 2(s0)
                  sb           t2, 2(s0)
                  ori          a6, s3, 1227
                  lbu          a3, 14(s0)
                  sb           s3, 14(s0)
                  nop
                  lui          s5, 246470
                  lb           a1, 14(s0)
                  lbu          s2, -11(s0)
                  lb           s6, -30(s0) #end riscv_load_store_hazard_instr_stream_0
                  la           a4, region_1+32423 #start load_store_instr_stream_1
                  sh           t3, -17(a4)
                  la           s8, region_1+38875 #start load_store_instr_stream_0
                  lb           s6, 91(a4)
                  sb           s6, -222(a4)
                  sb           sp, -39(s8)
                  lh           s2, 149(a4)
                  sb           t3, -16(s8)
                  lb           t5, -84(a4)
                  lb           t0, 38(s8)
                  sb           a7, -197(a4)
                  sb           s2, 62(s8)
                  lb           t6, 40(a4)
                  sb           s0, 12(s8)
                  sb           s8, 62(s8)
                  lhu          t5, -27(a4)
                  lbu          a3, -46(s8)
                  sb           s9, 55(s8)
                  sh           s6, -197(a4) #end load_store_instr_stream_1
                  sb           t5, 59(s8) #end load_store_instr_stream_0
                  la           s2, region_1+28634 #start riscv_hazard_instr_stream_5
                  sh           a1, 42(s2)
                  nop
                  srli         a3, a1, 24
                  lh           a1, 16(s2)
                  add          a3, t3, t2
                  sb           a3, 59(s2)
                  sb           a1, -61(s2)
                  lbu          a3, -25(s2)
                  lui          t2, 130357
                  sb           a3, -39(s2)
                  lbu          a4, -55(s2)
                  sb           a3, 33(s2)
                  lb           t2, 33(s2)
                  sb           a4, -44(s2)
                  sb           a3, 21(s2)
                  sb           a1, 27(s2)
                  lh           t2, -56(s2)
                  sb           a4, 1(s2)
                  srai         s10, t3, 5
                  lbu          t2, 26(s2)
                  mulhsu       a1, a3, a3
                  sb           t2, -64(s2)
                  sb           a3, -4(s2)
                  sw           t2, -58(s2)
                  lb           s10, 17(s2)
                  sw           t3, -42(s2)
                  mul          t2, a4, a1
                  srli         t2, a4, 7
                  mulhsu       t2, a3, s10
                  lh           a4, 24(s2)
                  srl          s10, a3, a3
                  mul          t3, a4, t3
                  lbu          s10, 27(s2)
                  lbu          a3, -41(s2)
                  xor          a3, t3, a3
                  mulhu        a3, t3, t3
                  sltu         t2, s10, s10
                  mul          a3, a4, a4
                  slti         a4, a1, -1848
                  lui          s10, 5597
                  srl          a4, t3, a4
                  lb           a1, 16(s2)
                  mul          a3, a3, a4
                  lb           a4, -13(s2)
                  andi         t3, a3, 308
                  sh           s10, 10(s2)
                  sll          a4, t3, t3
                  lui          a4, 948899
                  mulhu        t2, s10, a4
                  lbu          s10, -32(s2)
                  lb           t2, -37(s2)
                  sra          a1, s10, s10
                  csrrci       t2, 0x305, 0
                  lbu          t3, 57(s2) #end riscv_hazard_instr_stream_5
                  addi         a3, zero, -4 #init loop 1 counter
                  or           a2, s3, s8
                  sra          s7, t3, a0
                  addi         t4, zero, 1 #init loop 1 limit
                  div          a6, ra, a2
                  sltiu        s11, t0, 879
main_235_1_t:     remu         s2, gp, t3
                  mul          t3, a2, ra
                  sub          a4, s9, t4
                  addi         a3, a3, 5 #update loop 1 counter
                  sltu         a7, ra, sp
                  addi         ra, zero, 9 #init loop 0 counter
                  addi         s9, zero, 3 #init loop 0 limit
                  sra          a1, a3, a4
main_235_0_t:     mulhsu       t5, s6, t2
                  csrrwi       s8, 0x304, 12
                  addi         ra, ra, -6 #update loop 0 counter
                  add          s5, t5, a4
                  bne          ra, s9, main_235_0_t #branch for loop 0
                  bne          a3, t4, main_235_1_t #branch for loop 1
                  srai         s5, t4, 6
                  la           t4, region_0+4034 #start load_store_instr_stream_0
                  la           t0, region_1+29022 #start load_store_instr_stream_1
                  sb           t2, -37(t0)
                  lbu          t2, -153(t4)
                  lbu          a1, -163(t4)
                  lb           s2, 31(t0)
                  lh           a6, -82(t4)
                  lb           a1, -220(t4)
                  sw           s6, 26(t0)
                  lhu          a6, 20(t0)
                  lb           a1, 19(t0) #end load_store_instr_stream_1
                  sb           a7, -36(t4)
                  sh           s7, -34(t4) #end load_store_instr_stream_0
                  addi         t1, zero, -1 #init loop 0 counter
                  sub          s3, sp, t4
                  mulhu        zero, t0, tp
                  xor          a3, s9, gp
                  ori          s10, t5, 1092
                  nop
                  csrrw        s8, 0x304, ra
                  csrrci       a2, 0x343, 0
                  xor          a5, t1, a2
                  or           s4, s8, gp
                  addi         s6, zero, -6 #init loop 0 limit
                  csrrs        a3, 0x344, zero
                  slli         t6, s4, 12
main_209_0_t:     add          t5, s3, zero
                  csrrc        t6, 0x344, a5
                  csrrsi       t0, 0x342, 6
                  csrrc        s3, 0x343, zero
                  slti         a5, s1, 263
                  div          zero, t0, t4
                  addi         t1, t1, -9 #update loop 0 counter
                  lui          a1, 474410
                  and          s2, s5, t2
                  xor          a3, t5, gp
                  xor          a5, s1, a5
                  auipc        s7, 915991
                  remu         s1, a1, s0
                  slt          s8, s5, tp
                  bge          t1, s6, main_209_0_t #branch for loop 0
                  auipc        a4, 306270
                  la           s2, region_0+793 #start riscv_hazard_instr_stream_11
                  remu         a6, s10, a2
                  lbu          a6, -110(s2)
                  sb           a6, 104(s2)
                  addi         a2, s5, 1514
                  lbu          a6, -120(s2)
                  sh           s7, 223(s2)
                  sb           s5, -118(s2)
                  sb           s5, 76(s2)
                  sb           gp, -162(s2)
                  lbu          s10, -203(s2)
                  lbu          s7, 225(s2)
                  lhu          gp, -49(s2)
                  sb           s5, -182(s2)
                  sb           s5, 132(s2)
                  add          s10, gp, a2
                  sh           a2, 133(s2)
                  lhu          s10, -91(s2)
                  sb           s7, 26(s2)
                  sll          s10, gp, a6
                  xor          a6, s7, s5
                  lh           s7, -3(s2)
                  lbu          s10, 56(s2)
                  lbu          gp, -113(s2)
                  lb           s5, -100(s2)
                  and          s10, a2, a2
                  lhu          s7, 9(s2)
                  lb           a6, -176(s2)
                  lb           a6, -126(s2)
                  sub          gp, s10, a6
                  or           a2, a2, s7
                  sb           s10, 10(s2)
                  mul          a6, s5, s7
                  sb           s10, -2(s2)
                  lbu          s7, -52(s2)
                  div          gp, a2, s10
                  lb           a2, 54(s2)
                  lb           gp, -143(s2)
                  lhu          a6, -51(s2)
                  lbu          a2, 50(s2)
                  srl          a6, s5, s7
                  sb           s7, -92(s2) #end riscv_hazard_instr_stream_11
main_96:          jal          ra, 22f
0:                jal          ra, 2f
1:                jal          a5, 8f
2:                jal          t1, 25f
3:                jal          ra, 23f
4:                jal          ra, 24f
5:                jal          t0, 9f
6:                jal          ra, 13f
7:                jal          t1, 27f
8:                jal          t2, 16f
9:                jal          ra, 18f
10:               jal          ra, 0b
11:               jal          ra, 12f
12:               jal          t0, 3b
13:               jal          t1, 28f
14:               jal          t1, 17f
15:               jal          s2, 20f
16:               jal          a2, 7b
17:               jal          ra, 1b
18:               jal          ra, 6b
19:               jal          t1, 4b
20:               jal          ra, 19b
21:               jal          s3, 14b
22:               jal          t1, 21b
23:               jal          t0, 5b
24:               jal          ra, 10b
25:               jal          ra, 26f
26:               jal          s8, 11b
27:               jal          t2, 15b
28:               auipc        a1, 608507
                  la           s7, region_0+624 #start riscv_load_store_rand_instr_stream_39
                  csrrw        s0, 0x343, s11
                  sub          a6, t2, s8
                  srl          a2, s10, a1
                  xor          zero, t0, a1
                  sh           s3, -2(s7)
                  sw           sp, -20(s7)
                  slli         t1, t0, 28
                  slti         t0, s9, 1758
                  csrrci       s9, 0x342, 21
                  sb           tp, -16(s7)
                  lh           s10, -14(s7)
                  andi         s4, t2, 421
                  slli         s4, a6, 19
                  lh           t3, 26(s7)
                  slt          s10, sp, s11
                  remu         s3, a7, s4
                  and          s4, gp, sp
                  csrrw        t6, 0x342, zero
                  srli         t2, t0, 11
                  xor          gp, s11, t3
                  srai         s11, t5, 1
                  csrrc        t4, 0x305, zero
                  sub          s6, s5, s9
                  csrrci       a1, 0x304, 13
                  lb           t3, -31(s7)
                  sb           s7, -37(s7)
                  srli         t4, s11, 9
                  lb           s3, 64(s7)
                  slt          t5, t6, t4
                  srl          a2, a1, a4
                  sh           tp, 0(s7)
                  lui          gp, 888228
                  csrrc        s5, 0x304, zero
                  sb           s5, -23(s7) #end riscv_load_store_rand_instr_stream_39
                  la           s3, region_0+2395 #start riscv_load_store_rand_instr_stream_35
                  lb           a2, -1752(s3)
                  csrrc        a1, 0x343, zero
                  sll          t5, t2, t3
                  csrrc        s1, 0x304, s3
                  mul          zero, a0, ra
                  lb           ra, -1570(s3)
                  mulhu        s2, s11, t2
                  csrrsi       a6, 0x300, 0
                  sb           s6, -1980(s3)
                  divu         s2, s4, ra
                  sltu         gp, gp, a2
                  mulh         s9, a7, s1
                  and          s10, ra, s10
                  lhu          s5, 1671(s3)
                  csrrw        t6, 0x342, s1
                  lbu          a7, 1356(s3)
                  mulhu        a6, t0, s8
                  slli         t0, a6, 2
                  sra          s0, s10, a5
                  addi         zero, a6, -1466
                  nop
                  lbu          a2, 29(s3)
                  xor          s7, s2, a3
                  andi         ra, a6, 1293
                  mulhsu       a2, t6, a3
                  lbu          t1, -716(s3)
                  lb           s4, -385(s3)
                  sltiu        t4, s8, 1373
                  sh           s8, -367(s3)
                  lui          a7, 351242
                  lh           t0, 1175(s3)
                  sw           t0, -1583(s3)
                  srai         t2, s5, 22
                  sll          s4, t4, s11
                  sb           s8, -1046(s3)
                  sh           s3, 65(s3)
                  addi         s11, t2, 431
                  srai         t3, s6, 21
                  andi         a2, t5, -792
                  sh           tp, -1183(s3)
                  divu         t6, s3, tp
                  addi         s5, s7, 892
                  lb           s10, -1190(s3)
                  lbu          t1, -42(s3)
                  sra          s11, t6, a7
                  slti         a7, s2, 267
                  lh           a4, -779(s3)
                  lw           s9, -435(s3) #end riscv_load_store_rand_instr_stream_35
                  li           a3, 0xffffffff #start riscv_int_numeric_corner_stream_35
                  li           a4, 0x80000000
                  li           t6, 0xffffffff
                  li           a2, 0x0
                  li           s11, 0xffffffff
                  li           s4, 0x80000000
                  li           s3, 0x460aae91
                  li           s1, 0xffffffff
                  li           t2, 0xffffffff
                  li           a1, 0x80000000
                  auipc        a4, 820548
                  div          s3, s1, a3
                  nop
                  add          s4, a4, a3
                  nop
                  auipc        s3, 602294
                  divu         a4, a2, a3
                  divu         a2, a1, a1
                  mul          a2, s1, a4
                  div          a4, s11, a1
                  div          a3, t2, a3
                  nop
                  nop
                  div          t2, a3, t6
                  lui          a2, 417814
                  addi         a2, s11, 1429
                  addi         a2, a1, 468
                  div          s11, s3, s3
                  div          t2, s1, s4
                  mulh         s4, a1, s3
                  rem          s1, a4, s4
                  mulhu        s3, s11, s1
                  sub          s3, s1, a3
                  lui          a1, 60730
                  addi         a2, a1, -948
                  div          a4, a1, a3
                  nop
                  add          a1, a2, s3
                  divu         t6, t6, t6 #end riscv_int_numeric_corner_stream_35
                  la           a4, region_0+3268 #start load_store_instr_stream_1
                  la           s11, region_0+515 #start load_store_instr_stream_0
                  lbu          t4, 174(a4)
                  sb           a0, -12(s11)
                  lb           a6, 253(a4)
                  sb           a5, 118(a4)
                  lbu          a2, -46(s11)
                  sb           s8, -222(a4)
                  sb           gp, -53(s11)
                  sb           t1, 256(a4)
                  lb           a6, -165(a4)
                  lhu          t1, -51(s11)
                  lhu          a2, -164(a4)
                  lb           s9, 59(s11)
                  sb           a7, -125(a4) #end load_store_instr_stream_1
                  sb           t4, 28(s11)
                  lb           s7, -60(s11) #end load_store_instr_stream_0
                  la           a2, region_0+632 #start riscv_load_store_hazard_instr_stream_38
                  lhu          t5, -6(a2)
                  lb           s6, -6(a2)
                  sh           s11, -6(a2)
                  lb           s9, -6(a2)
                  sb           s3, -16(a2)
                  lhu          s0, -16(a2)
                  lhu          s5, -16(a2)
                  andi         s3, s7, -525
                  sb           t2, -16(a2)
                  sb           tp, -16(a2)
                  lb           a1, 5(a2)
                  sb           s0, 5(a2)
                  lb           s8, 5(a2)
                  lb           s5, 5(a2)
                  lb           s4, 5(a2)
                  lbu          t3, 5(a2)
                  sb           a6, 5(a2)
                  sb           s8, 5(a2)
                  lbu          zero, 5(a2)
                  sb           s5, 5(a2) #end riscv_load_store_hazard_instr_stream_38
                  la           t1, region_1+53146 #start riscv_load_store_hazard_instr_stream_37
                  lbu          gp, 845(t1)
                  divu         s8, s10, a6
                  sb           s11, 845(t1)
                  lb           a2, 845(t1)
                  lbu          s6, 845(t1)
                  lbu          s5, 1091(t1)
                  sb           t5, 1091(t1)
                  lbu          gp, 1091(t1)
                  lbu          a2, 1091(t1)
                  lb           s11, 1091(t1)
                  lbu          a5, 1091(t1)
                  lbu          s8, 1387(t1) #end riscv_load_store_hazard_instr_stream_37
main_104:         jal          ra, 23f
0:                jal          a5, 26f
1:                jal          t1, 9f
2:                jal          t0, 24f
3:                jal          ra, 14f
4:                jal          ra, 21f
5:                jal          ra, 1b
6:                jal          t1, 25f
7:                jal          s5, 0b
8:                jal          gp, 6b
9:                jal          ra, 16f
10:               jal          gp, 2b
11:               jal          ra, 7b
12:               jal          ra, 27f
13:               jal          t1, 11b
14:               jal          s10, 15f
15:               jal          ra, 22f
16:               jal          ra, 4b
17:               jal          gp, 3b
18:               jal          ra, 10b
19:               jal          ra, 12b
20:               jal          t1, 5b
21:               jal          ra, 8b
22:               jal          ra, 20b
23:               jal          ra, 13b
24:               jal          t1, 19b
25:               jal          t1, 18b
26:               jal          a1, 17b
27:               andi         s1, a5, 1510
                  la           t5, region_0+31 #start riscv_hazard_instr_stream_0
                  sh           a3, 1109(t5)
                  lw           s0, 945(t5)
                  csrrw        s1, 0x301, s1
                  lh           a7, 371(t5)
                  sw           a3, 201(t5)
                  lbu          a7, 1169(t5)
                  lbu          a7, 21(t5)
                  lb           s1, 2022(t5)
                  lbu          s6, 1426(t5)
                  sb           s1, 88(t5)
                  rem          s6, a7, s0
                  lui          s1, 59004
                  remu         s6, a7, s0
                  csrrwi       s1, 0x342, 17
                  lhu          s0, 683(t5)
                  sb           s1, 2013(t5)
                  sb           s1, 1843(t5)
                  sltu         s0, a7, a3
                  lbu          a7, 382(t5)
                  csrrwi       a3, 0x344, 3
                  sh           a3, 1467(t5)
                  sltiu        t1, a3, 147
                  lbu          s6, 949(t5)
                  lb           s6, 745(t5)
                  sb           s6, 1602(t5)
                  lui          a3, 305789
                  lb           s1, 1633(t5)
                  sb           s0, 1642(t5)
                  lb           s1, 1216(t5)
                  sub          s0, a7, a7
                  sh           s1, 1039(t5)
                  mul          s1, s6, a7
                  lb           s0, 1187(t5)
                  sb           t1, 1463(t5)
                  lb           t1, 1202(t5)
                  slt          t1, t1, t1
                  lb           s1, 710(t5)
                  lb           a3, 599(t5)
                  lw           a3, 697(t5)
                  lw           s1, 945(t5) #end riscv_hazard_instr_stream_0
                  la           s4, region_1+45109 #start riscv_load_store_rand_instr_stream_2
                  sll          s7, sp, zero
                  csrrs        s8, 0x301, zero
                  sb           s0, 85(s4)
                  addi         a6, s1, -1935
                  csrrc        a5, 0x301, a6
                  lbu          t0, -78(s4)
                  slti         a7, s9, 1368
                  csrrw        a4, 0x343, tp
                  and          a6, a4, s7
                  rem          a2, t2, s4
                  div          t3, t1, s5
                  lb           a1, 144(s4)
                  lbu          t1, 166(s4)
                  sw           tp, -213(s4)
                  sb           s2, 158(s4)
                  slli         t4, zero, 16
                  csrrs        gp, 0x301, a5
                  lbu          s2, -67(s4)
                  lbu          a4, -154(s4)
                  sb           a6, 75(s4)
                  mulhsu       a1, a0, gp
                  remu         gp, s2, s1
                  lb           t4, -146(s4)
                  add          a3, a5, s8
                  sltu         s7, a4, a7
                  lb           t5, -186(s4)
                  lb           a6, 42(s4)
                  sb           a5, 56(s4)
                  lb           s9, 24(s4)
                  sb           s4, 248(s4)
                  xori         t0, a3, 1774
                  csrrc        ra, 0x342, zero
                  srli         t3, ra, 19
                  ori          t4, a7, 1805
                  sll          s0, tp, a6
                  sltiu        a6, s3, -2023
                  slli         ra, a7, 29
                  lb           a7, 180(s4)
                  slli         s5, s0, 13
                  sb           s8, 232(s4)
                  csrrw        a6, 0x342, s4
                  mulhu        s0, t2, s4
                  sll          s2, sp, a6
                  lb           a5, 47(s4)
                  and          t1, zero, a4
                  lbu          a6, -111(s4) #end riscv_load_store_rand_instr_stream_2
                  la           t6, region_1+62789 #start load_store_instr_stream_2
                  la           gp, region_1+2252 #start load_store_instr_stream_1
                  la           a5, region_1+57159 #start load_store_instr_stream_0
                  sb           a5, 1122(t6)
                  lbu          a3, 2(gp)
                  lbu          a2, -369(t6)
                  sh           t4, 8(gp)
                  lb           a6, 667(t6)
                  lhu          s7, 16(gp)
                  lb           s5, -62(a5)
                  lhu          s3, 1079(t6)
                  lbu          s7, -13(gp)
                  lb           s10, -9(gp)
                  lbu          a1, -1310(t6)
                  lbu          t1, 60(a5)
                  sh           s2, 16(gp)
                  lb           t3, -14(gp)
                  sb           s3, -1980(t6)
                  sb           s11, 1760(t6)
                  lbu          s3, -7(gp)
                  lbu          s9, 14(a5)
                  lhu          s6, -499(t6)
                  lbu          s9, -1(gp)
                  lbu          s0, 20(a5)
                  sw           a6, 61(a5)
                  lb           t5, 1747(t6) #end load_store_instr_stream_2
                  lb           t0, -3(gp) #end load_store_instr_stream_1
                  lh           s7, 15(a5) #end load_store_instr_stream_0
                  addi         gp, zero, 7 #init loop 1 counter
                  sltu         s6, t3, a7
                  srli         s0, t0, 17
                  csrrw        t5, 0x344, a4
                  addi         t6, zero, 20 #init loop 1 limit
                  slti         a2, t4, 820
                  csrrsi       t5, 0x304, 27
main_223_1_t:     rem          s1, a7, t4
                  mulhsu       a4, s9, t3
                  addi         gp, gp, 1 #update loop 1 counter
                  addi         t2, zero, 10 #init loop 0 counter
                  srl          s6, s8, zero
                  addi         s8, zero, 6 #init loop 0 limit
main_223_0_t:     and          s10, a3, a7
                  addi         t2, t2, -5 #update loop 0 counter
                  csrrc        s6, 0x344, a2
                  bgeu         t2, s8, main_223_0_t #branch for loop 0
                  rem          t0, sp, sp
                  nop
                  mulhu        s4, s0, s3
                  bltu         gp, t6, main_223_1_t #branch for loop 1
                  mulhu        s4, a4, s5
main_101:         jal          ra, 6f
0:                jal          t1, 11f
1:                jal          ra, 3f
2:                jal          t1, 5f
3:                jal          t1, 4f
4:                jal          t1, 12f
5:                jal          t1, 19f
6:                jal          ra, 7f
7:                jal          s9, 9f
8:                jal          ra, 10f
9:                jal          t1, 0b
10:               jal          t1, 2b
11:               jal          ra, 15f
12:               jal          ra, 13f
13:               jal          ra, 14f
14:               jal          t1, 16f
15:               jal          a5, 17f
16:               jal          s3, 18f
17:               jal          ra, 1b
18:               jal          t1, 8b
19:               auipc        a4, 520839
main_114:         jal          ra, 4f
0:                jal          ra, 24f
1:                jal          s2, 27f
2:                jal          ra, 19f
3:                jal          ra, 20f
4:                jal          ra, 12f
5:                jal          ra, 29f
6:                jal          ra, 9f
7:                jal          s5, 13f
8:                jal          ra, 11f
9:                jal          gp, 28f
10:               jal          t1, 8b
11:               jal          t1, 2b
12:               jal          ra, 7b
13:               jal          s9, 14f
14:               jal          t0, 21f
15:               jal          ra, 18f
16:               jal          ra, 1b
17:               jal          ra, 6b
18:               jal          ra, 16b
19:               jal          t1, 17b
20:               jal          ra, 15b
21:               jal          ra, 23f
22:               jal          t0, 3b
23:               jal          ra, 10b
24:               jal          ra, 22b
25:               jal          ra, 0b
26:               jal          ra, 25b
27:               jal          t1, 5b
28:               jal          t1, 26b
29:               jal          a2, 30f
30:               sltiu        t4, a6, -1893
                  la           s10, region_0+3064 #start load_store_instr_stream_2
                  la           s6, region_0+2740 #start load_store_instr_stream_1
                  la           ra, region_0+2524 #start load_store_instr_stream_0
                  lbu          s2, -15(s6)
                  lbu          s7, 671(s10)
                  lhu          gp, -192(s10)
                  lhu          s1, 42(s6)
                  lbu          zero, 492(s10)
                  lhu          s9, 172(ra)
                  lw           s9, -48(s10)
                  lbu          s9, 51(s6)
                  sw           t4, 920(ra)
                  lb           t4, 13(s6)
                  sb           t6, -1299(s10)
                  sh           a1, -1126(s10)
                  sb           zero, 17(s6)
                  sb           t6, 739(ra)
                  sb           a1, 27(s6)
                  lh           gp, -1204(s10)
                  lb           t6, 44(s6)
                  lb           t5, 49(s6)
                  sh           a6, -1504(ra)
                  lb           a3, -60(s6) #end load_store_instr_stream_1
                  sb           tp, -1170(s10) #end load_store_instr_stream_2
                  lbu          s7, 117(ra) #end load_store_instr_stream_0
main_111:         jal          ra, 16f
0:                jal          ra, 10f
1:                jal          t1, 23f
2:                jal          t1, 14f
3:                jal          t1, 25f
4:                jal          t1, 2b
5:                jal          ra, 13f
6:                jal          ra, 5b
7:                jal          gp, 22f
8:                jal          t1, 20f
9:                jal          a4, 12f
10:               jal          t0, 4b
11:               jal          t0, 8b
12:               jal          ra, 19f
13:               jal          s10, 17f
14:               jal          ra, 7b
15:               jal          t1, 6b
16:               jal          t1, 15b
17:               jal          ra, 9b
18:               jal          ra, 21f
19:               jal          t1, 11b
20:               jal          t0, 24f
21:               jal          ra, 0b
22:               jal          t1, 26f
23:               jal          gp, 3b
24:               jal          ra, 1b
25:               jal          ra, 18b
26:               ori          s0, s1, 1304
                  la           a2, region_0+1794 #start riscv_load_store_rand_instr_stream_21
                  lbu          s7, 25(a2)
                  add          s7, a1, s9
                  lb           a3, -149(a2)
                  lhu          s9, -108(a2)
                  sh           s8, -178(a2)
                  lbu          a1, 171(a2)
                  sb           gp, 207(a2)
                  lb           t1, 244(a2)
                  sra          t4, s7, tp
                  slli         s5, s6, 26
                  csrrsi       s9, 0x305, 0
                  and          t4, a2, s5
                  csrrs        s0, 0x304, zero
                  andi         a6, s2, 448
                  sb           gp, 233(a2)
                  lb           s3, -187(a2)
                  mul          s7, t6, s10
                  csrrwi       s11, 0x304, 3
                  sltiu        a3, tp, -856
                  xor          t3, s6, t4
                  sra          s6, s11, s1
                  lw           zero, 106(a2)
                  slli         a6, a3, 14
                  csrrsi       t4, 0x343, 0
                  csrrsi       gp, 0x304, 8
                  sll          a5, s0, t3
                  lh           t6, 120(a2)
                  mul          s4, s1, t0
                  sb           t6, 89(a2)
                  sb           t6, 55(a2)
                  sw           a7, 210(a2) #end riscv_load_store_rand_instr_stream_21
                  la           a1, region_0+500 #start load_store_instr_stream_1
                  lbu          zero, -2(a1)
                  la           a2, region_0+3616 #start load_store_instr_stream_0
                  sb           t5, -9(a1)
                  sh           zero, 2(a1)
                  sw           a5, -20(a2)
                  lhu          a3, 0(a1)
                  lh           s2, -16(a1)
                  lbu          t4, 13(a1)
                  lh           s6, 12(a1)
                  sb           a7, 235(a2)
                  lbu          s4, -161(a2)
                  sw           a1, 4(a1)
                  sb           t2, 64(a2)
                  sb           s8, 238(a2)
                  lb           t5, 9(a1)
                  sb           s7, 1(a1) #end load_store_instr_stream_1
                  lbu          ra, 53(a2) #end load_store_instr_stream_0
                  la           s8, region_0+1924 #start riscv_load_store_rand_instr_stream_5
                  sw           a0, 12(s8)
                  add          s5, s0, a6
                  nop
                  lhu          t4, -14(s8)
                  sh           sp, -8(s8)
                  divu         s5, a5, s0
                  addi         a1, tp, 435
                  sb           zero, -54(s8)
                  sltu         s10, a4, s0
                  remu         s11, ra, s2
                  add          t3, a4, s0
                  csrrs        s9, 0x300, zero
                  sltiu        a3, a1, 820
                  rem          t2, a7, s1
                  sb           s9, 59(s8)
                  andi         s11, s7, 1289
                  lb           s7, 21(s8)
                  sb           t6, 21(s8)
                  xori         s3, sp, 368
                  sb           s3, -44(s8)
                  csrrci       t2, 0x305, 0
                  rem          a4, t5, t6
                  div          s2, a7, tp
                  lbu          t3, 47(s8)
                  srai         s4, a4, 28
                  div          s2, a4, a4
                  srli         a5, t0, 29
                  slt          t4, tp, tp
                  mulhsu       t1, t3, t3
                  sra          s10, tp, s7
                  slt          t6, a1, t5
                  csrrsi       s6, 0x301, 3
                  sb           a4, -21(s8)
                  sb           t4, -34(s8)
                  sh           t3, 52(s8)
                  lb           s0, -2(s8)
                  lb           a6, 38(s8)
                  slti         s0, s11, 2014
                  lb           s5, 21(s8)
                  mulhsu       s4, s9, s8
                  nop
                  lb           a4, -9(s8)
                  and          s5, s10, s11
                  csrrs        a6, 0x300, zero
                  lb           a5, -34(s8)
                  lhu          s3, 0(s8) #end riscv_load_store_rand_instr_stream_5
                  la           s0, region_1+23508 #start riscv_load_store_rand_instr_stream_7
                  lhu          a5, -64(s0)
                  srai         ra, t1, 15
                  lb           t2, 0(s0)
                  lb           s2, -50(s0)
                  lbu          a6, -47(s0)
                  slli         zero, a5, 20
                  ori          t0, tp, 1084
                  mulhsu       s10, t6, a6
                  lbu          s5, 15(s0)
                  rem          ra, s6, s5
                  lbu          s2, -27(s0)
                  lbu          ra, -53(s0)
                  csrrwi       t6, 0x344, 23
                  lui          s9, 532714
                  mulh         s3, s0, s1
                  sh           s4, 30(s0)
                  sw           s5, 24(s0)
                  lb           a5, -45(s0)
                  lbu          a2, -17(s0)
                  lbu          a4, 37(s0)
                  srli         a1, s9, 8
                  lh           t0, -30(s0)
                  srai         s6, a0, 28
                  sb           t2, 35(s0)
                  sub          s9, s8, s5
                  andi         s7, s2, 31
                  mulhu        a5, gp, s10
                  csrrw        t0, 0x304, sp
                  nop
                  slli         gp, a1, 11
                  lbu          s1, -54(s0)
                  lbu          t4, 8(s0)
                  lhu          zero, 26(s0)
                  remu         s9, s1, s10
                  sb           a6, -17(s0)
                  sb           s9, -51(s0)
                  lb           s3, 51(s0)
                  sra          t5, s9, t6
                  lw           t3, 44(s0)
                  auipc        s8, 203010
                  lbu          s7, 23(s0) #end riscv_load_store_rand_instr_stream_7
                  la           a3, region_0+2914 #start load_store_instr_stream_0
                  la           t1, region_1+51130 #start load_store_instr_stream_1
                  lb           a4, 156(a3)
                  sh           t5, -12(t1)
                  sh           s7, 124(a3)
                  lhu          t6, -6(t1)
                  lh           t6, 156(a3)
                  sh           s7, 16(t1)
                  sw           s5, 230(a3)
                  lbu          t6, 2(t1)
                  lb           t6, 101(a3)
                  sh           s4, -14(t1)
                  lb           a7, 179(a3)
                  lb           t5, 7(t1)
                  lbu          s4, 9(t1)
                  lbu          a2, -13(t1)
                  lbu          t5, 4(t1) #end load_store_instr_stream_1
                  lb           a1, 165(a3) #end load_store_instr_stream_0
                  la           s7, region_0+268 #start load_store_instr_stream_1
                  lb           gp, 101(s7)
                  sb           a2, 154(s7)
                  la           t3, region_1+54588 #start load_store_instr_stream_0
                  lh           s3, -244(t3)
                  lb           t4, 28(t3)
                  sh           a4, 56(s7)
                  sw           ra, 164(t3)
                  lbu          a4, 117(t3)
                  lhu          s3, 100(s7)
                  lh           a1, 252(s7)
                  lw           a1, -136(s7)
                  lbu          t1, 71(t3)
                  lhu          s3, -86(s7)
                  lh           t4, -202(s7) #end load_store_instr_stream_1
                  lh           a2, 138(t3)
                  sh           zero, -68(t3)
                  lb           a3, -231(t3) #end load_store_instr_stream_0
                  la           t3, region_0+2348 #start load_store_instr_stream_1
                  sb           a3, -225(t3)
                  la           s5, region_1+38578 #start load_store_instr_stream_0
                  sb           t1, 141(t3)
                  lh           a4, 146(s5)
                  lbu          zero, 1(t3)
                  lb           a7, 200(s5)
                  lhu          a7, -210(s5)
                  sb           s4, -90(t3)
                  lb           a4, 27(s5)
                  lbu          s2, -55(t3)
                  sb           gp, 217(t3) #end load_store_instr_stream_1
                  lhu          t1, -56(s5)
                  sh           s2, -128(s5) #end load_store_instr_stream_0
                  la           t6, region_0+1763 #start load_store_instr_stream_1
                  sb           s4, -61(t6)
                  la           t0, region_1+45220 #start load_store_instr_stream_0
                  lb           t5, -32(t6)
                  lbu          a3, 33(t0)
                  lhu          s2, -62(t0)
                  lbu          s3, -2(t6)
                  lbu          t4, -55(t6)
                  lb           gp, 55(t0)
                  sb           t0, 43(t6)
                  lbu          s6, -58(t6)
                  sb           s9, -34(t0)
                  lb           t2, 3(t6) #end load_store_instr_stream_1
                  lb           s2, -53(t0)
                  lb           t1, -29(t0) #end load_store_instr_stream_0
                  la           s8, region_0+3184 #start riscv_load_store_hazard_instr_stream_31
                  sll          a1, s8, t1
                  lb           t5, 3(s8)
                  mulhsu       t6, gp, s2
                  lb           a2, 3(s8)
                  sb           t1, 3(s8)
                  lbu          t1, 3(s8)
                  lbu          t3, 3(s8)
                  lbu          s10, 3(s8)
                  lb           s0, 3(s8)
                  sb           ra, 3(s8)
                  lbu          gp, 3(s8)
                  sb           t0, 3(s8)
                  sb           t6, 3(s8)
                  lb           a4, 3(s8) #end riscv_load_store_hazard_instr_stream_31
                  li           s1, 0xffffffff #start riscv_int_numeric_corner_stream_3
                  li           s9, 0x80000000
                  li           s11, 0xe8fb3be3
                  li           s4, 0x0
                  li           a4, 0x80000000
                  li           a1, 0x80000000
                  li           s6, 0xffffffff
                  li           ra, 0x80000000
                  li           a5, 0x0
                  li           s10, 0x80000000
                  remu         a5, a4, s10
                  remu         s4, a4, s11
                  addi         s1, s1, 189
                  mulhu        a5, s6, s4
                  addi         a5, s6, -237
                  addi         a4, s1, 846
                  lui          s10, 331848
                  mulhu        a5, s1, s10
                  nop
                  addi         s11, s9, 1241
                  auipc        s4, 119220
                  lui          a1, 303990
                  divu         a5, s9, s9
                  nop
                  lui          s11, 658734
                  auipc        a5, 56200
                  add          s1, a4, s6
                  add          s4, s4, s11
                  rem          a1, s11, a4
                  nop #end riscv_int_numeric_corner_stream_3
                  la           s9, region_0+3149 #start load_store_instr_stream_4
                  la           gp, region_0+3275 #start load_store_instr_stream_3
                  la           s7, region_0+1135 #start load_store_instr_stream_0
                  la           t2, region_0+2288 #start load_store_instr_stream_1
                  lb           s11, 6(t2)
                  lb           a1, -5(gp)
                  sb           a7, -3(t2)
                  sh           s11, -81(s7)
                  la           s4, region_0+2640 #start load_store_instr_stream_2
                  sb           s5, -7(t2)
                  sb           s6, 16(s9)
                  sb           t0, -166(gp)
                  sb           ra, 40(s9)
                  lb           t0, 219(s4)
                  lbu          s2, -45(t2)
                  sb           a1, -6(s9)
                  sb           t4, -35(s7)
                  sb           a3, 88(gp)
                  sh           sp, -43(gp)
                  lb           s10, 168(gp)
                  sb           s4, 53(t2)
                  lbu          s3, 27(t2)
                  lw           t1, 33(gp)
                  lb           zero, -122(gp)
                  lbu          a6, 37(s9)
                  lbu          a4, 191(s4)
                  lh           t6, -93(s7)
                  lh           t4, -28(t2)
                  lbu          a6, 10(s9) #end load_store_instr_stream_4
                  lb           s0, 182(s4)
                  sw           t2, -55(gp)
                  lw           t3, -92(s4)
                  lbu          t1, 188(s7)
                  lb           s2, -38(t2)
                  sh           s6, 87(gp) #end load_store_instr_stream_3
                  sb           t1, -215(s4) #end load_store_instr_stream_2
                  sb           a5, 3(t2) #end load_store_instr_stream_1
                  lb           t0, 24(s7) #end load_store_instr_stream_0
                  addi         a2, zero, -8 #init loop 0 counter
                  nop
                  mulhsu       s2, a1, a3
                  mulh         s2, a5, s10
                  or           t4, a7, a5
                  slli         s9, zero, 27
                  sra          s5, ra, s1
                  addi         t2, zero, -12 #init loop 0 limit
                  sltiu        t4, a4, 1113
main_239_0_t:     sltu         t3, s0, t4
                  addi         a1, s3, -867
                  sltu         ra, a2, a4
                  xor          t4, a3, t5
                  mulhu        s1, t3, s1
                  or           a1, a5, s5
                  addi         a2, a2, -4 #update loop 0 counter
                  srai         s1, t2, 16
                  bne          a2, t2, main_239_0_t #branch for loop 0
                  divu         s1, ra, s10
                  la           s2, region_1+21946 #start riscv_load_store_rand_instr_stream_31
                  lhu          a7, -2(s2)
                  sh           a4, -14(s2)
                  sb           t3, 9(s2)
                  lb           ra, -3(s2)
                  lhu          s8, -14(s2)
                  sb           s0, -7(s2)
                  srl          s1, a4, t0
                  sub          t5, t6, t1
                  lhu          s0, -2(s2)
                  lb           t4, -1(s2)
                  mulh         a1, tp, gp
                  sb           a2, -8(s2)
                  lbu          ra, 10(s2)
                  lbu          gp, -2(s2)
                  lb           s7, -3(s2)
                  auipc        a1, 438596
                  sll          s3, s11, t5
                  lw           s0, -14(s2)
                  sb           s9, 3(s2)
                  sltu         gp, t1, a2
                  sltu         a7, t6, s0
                  lw           s9, -6(s2)
                  xor          s1, a0, ra
                  lw           s10, 10(s2)
                  srli         ra, sp, 27
                  mulh         t0, s10, t5
                  lhu          t3, -14(s2)
                  lbu          s10, 8(s2)
                  lb           s4, 3(s2)
                  sb           a1, -8(s2)
                  csrrsi       a5, 0x342, 25
                  mulh         s8, a1, ra
                  lbu          s6, -15(s2)
                  and          a3, t6, t0
                  lb           s7, -5(s2)
                  lb           zero, 11(s2)
                  sb           t5, -13(s2)
                  sb           t0, -14(s2)
                  csrrci       s1, 0x301, 0
                  lhu          t2, 14(s2)
                  lbu          t1, 1(s2) #end riscv_load_store_rand_instr_stream_31
                  la           t5, region_0+2999 #start riscv_hazard_instr_stream_23
                  lbu          a6, -62(t5)
                  addi         a5, t6, 1903
                  lbu          s10, 99(t5)
                  mulhsu       t6, a6, a5
                  mulhsu       t6, a1, s10
                  lw           a6, -243(t5)
                  lhu          a1, -93(t5)
                  lbu          a6, 93(t5)
                  csrrci       a1, 0x304, 0
                  csrrsi       a6, 0x342, 0
                  nop
                  lb           a6, -250(t5)
                  mulhu        a5, a5, a6
                  sb           s10, -192(t5)
                  slti         s3, a6, 303
                  rem          t6, a1, a6
                  lbu          t6, -110(t5)
                  add          t6, s10, s3
                  divu         s10, t6, t6
                  csrrci       a1, 0x304, 29
                  csrrwi       a1, 0x342, 27
                  ori          a5, a5, -586
                  lhu          s3, -233(t5)
                  lb           a6, 232(t5)
                  add          a6, t6, a5
                  sb           a1, -253(t5)
                  mulhsu       s10, a5, s10
                  andi         a5, a1, -1436
                  lui          t6, 286851
                  mul          a1, a6, s3
                  xori         s3, a5, -515
                  ori          s10, a5, -291
                  nop
                  srl          t6, a5, a1
                  sub          t6, s3, a5
                  sb           a5, -32(t5)
                  slti         a1, s3, -1821
                  mulhu        s3, t6, a6
                  sb           a6, 178(t5)
                  sltiu        s3, t6, 1765
                  csrrw        s10, 0x343, t6
                  slli         a6, s3, 22
                  sltiu        t6, t6, 895
                  lb           t6, 77(t5) #end riscv_hazard_instr_stream_23
                  li           a2, 0x0 #start riscv_int_numeric_corner_stream_13
                  li           s11, 0x8324bc6e
                  li           t0, 0xffffffff
                  li           s10, 0x0
                  li           s7, 0xd725b6c6
                  li           t5, 0x0
                  li           a6, 0xffffffff
                  li           a1, 0xa06e5eb3
                  li           t1, 0x0
                  li           s0, 0xffffffff
                  addi         s10, t5, -915
                  add          a1, s10, s0
                  auipc        s11, 403404
                  remu         s0, t5, s11
                  divu         s11, a2, a2
                  remu         a2, a2, t5
                  mulhu        t1, a1, s7
                  lui          t5, 169282
                  addi         s11, a1, 906
                  rem          a6, s0, a2
                  rem          a1, s11, a6
                  div          s7, a1, t1
                  divu         t0, a1, a6
                  div          t5, t0, s10
                  add          a6, a2, a2
                  auipc        a1, 631178
                  mulhsu       a2, t0, s7
                  divu         s10, t1, t1
                  auipc        s0, 640428
                  nop
                  lui          a1, 72583 #end riscv_int_numeric_corner_stream_13
                  la           s5, region_1+1786 #start load_store_instr_stream_1
                  la           t6, region_1+21135 #start load_store_instr_stream_0
                  sw           gp, 701(t6)
                  lb           s1, 877(s5)
                  lbu          s4, -791(s5)
                  lh           gp, -484(s5)
                  lbu          a1, -1912(t6)
                  lhu          s3, 396(s5)
                  lbu          s10, 472(t6)
                  lbu          t2, 1145(s5)
                  sb           t2, 167(s5)
                  sb           s11, -566(t6)
                  sh           gp, 1247(t6)
                  lbu          s11, 1928(s5)
                  sb           a2, -1015(s5) #end load_store_instr_stream_1
                  sb           t1, 1099(t6) #end load_store_instr_stream_0
main_107:         jal          ra, 4f
0:                jal          a3, 5f
1:                jal          t1, 0b
2:                jal          s6, 15f
3:                jal          a3, 9f
4:                jal          t2, 13f
5:                jal          ra, 14f
6:                jal          t6, 10f
7:                jal          t1, 12f
8:                jal          ra, 11f
9:                jal          t1, 8b
10:               jal          ra, 2b
11:               jal          ra, 7b
12:               jal          ra, 6b
13:               jal          ra, 1b
14:               jal          gp, 3b
15:               csrrc        s8, 0x344, zero
                  li           t6, 0xffffffff #start riscv_int_numeric_corner_stream_15
                  li           t0, 0x80000000
                  li           s6, 0xffffffff
                  li           a6, 0xffffffff
                  li           s7, 0x80000000
                  li           a2, 0x80000000
                  li           t5, 0x80000000
                  li           s11, 0xffffffff
                  li           t2, 0xffffffff
                  li           s1, 0x0
                  remu         s1, a2, s11
                  add          s1, s7, s11
                  div          a2, t5, a6
                  mulh         t5, t0, t5
                  sub          s11, a2, a2
                  lui          s11, 217513
                  div          s7, s1, t2
                  auipc        t5, 7252
                  mulh         t6, t5, t5
                  mulh         t5, t6, t5
                  auipc        s1, 845642
                  divu         t6, a2, a6
                  mulhu        t2, t5, t6
                  lui          a6, 154243
                  add          t5, s6, t0
                  div          t0, a2, a6
                  rem          a6, s6, t2
                  sub          s1, t6, s7
                  mulh         a2, s11, a2
                  mulhu        t0, a6, t6
                  mulhu        t6, t0, t6
                  rem          t2, t6, t2
                  mul          s11, t2, s1
                  mulhsu       s6, a2, t2 #end riscv_int_numeric_corner_stream_15
                  la           a3, region_1+36168 #start riscv_load_store_hazard_instr_stream_14
                  lbu          t2, 1(a3)
                  sb           s5, 1(a3)
                  lh           s6, -214(a3)
                  lh           a2, -214(a3)
                  sb           gp, 38(a3)
                  lbu          s10, -231(a3)
                  lh           s7, -138(a3)
                  lb           t0, 80(a3)
                  srli         t5, s7, 17
                  lbu          t5, 80(a3)
                  sh           t1, 80(a3)
                  lw           a1, 80(a3)
                  lw           gp, 180(a3)
                  lb           gp, 198(a3)
                  sw           s5, 220(a3)
                  lhu          t2, 220(a3)
                  sb           s10, 9(a3)
                  lbu          s2, 9(a3)
                  lb           s7, 9(a3)
                  xori         t6, s8, 920
                  sb           a7, 9(a3) #end riscv_load_store_hazard_instr_stream_14
                  la           t6, region_0+3822 #start riscv_hazard_instr_stream_20
                  lb           s11, -135(t6)
                  slli         t3, s0, 8
                  lbu          a2, 161(t6)
                  csrrci       a3, 0x300, 0
                  lbu          s6, -152(t6)
                  sb           t3, -4(t6)
                  lb           a3, 39(t6)
                  slli         a2, s11, 3
                  srl          s6, a2, s11
                  sb           a3, 81(t6)
                  lb           s6, -210(t6)
                  csrrs        t3, 0x343, t3
                  sra          t3, s6, s11
                  divu         s11, s11, s11
                  srl          a2, t3, s0
                  mul          t3, s11, s0
                  sltiu        a3, s11, 1977
                  csrrs        a3, 0x304, a3
                  sltu         t3, s11, s6
                  lhu          t3, -140(t6)
                  xor          s6, s11, t3
                  add          s0, s11, s0
                  lhu          a2, 102(t6)
                  ori          s6, s6, -973
                  sltiu        t3, t3, -1146
                  lhu          a3, 158(t6)
                  mulh         t3, s0, s11
                  lw           a3, 114(t6)
                  sub          s11, s6, a2
                  sb           s6, -83(t6)
                  lbu          a3, -228(t6)
                  lh           a2, -66(t6)
                  sll          a3, s11, a3
                  sub          s11, a3, s11
                  lb           a2, 135(t6)
                  lb           a3, -85(t6)
                  csrrci       s6, 0x305, 0
                  csrrci       s11, 0x343, 28
                  csrrwi       s0, 0x342, 28
                  sb           s6, -120(t6)
                  divu         a2, s6, s0
                  remu         s6, a3, a3
                  lw           t3, -174(t6)
                  mul          a2, a3, t3
                  sb           s11, 54(t6) #end riscv_hazard_instr_stream_20
                  la           a5, region_1+211 #start riscv_load_store_rand_instr_stream_0
                  remu         a7, t2, a3
                  csrrc        zero, 0x342, zero
                  lbu          s8, -9(a5)
                  lbu          s8, -16(a5)
                  sb           tp, -16(a5)
                  lb           s10, -5(a5)
                  auipc        t0, 333086
                  sb           s4, -1(a5)
                  sb           t3, 15(a5)
                  xori         a7, a2, 988
                  slli         s4, s3, 30
                  sb           s3, 3(a5)
                  nop
                  mulh         t6, tp, s6
                  lh           s1, 15(a5)
                  csrrw        s11, 0x342, zero
                  sra          s1, a0, s7
                  andi         t3, a7, 1733
                  lb           t6, 16(a5)
                  lbu          s11, -8(a5)
                  lhu          gp, 11(a5)
                  sll          t1, a6, a0
                  or           s8, t1, a7
                  div          zero, a5, s1
                  lbu          s0, -6(a5)
                  srl          a4, a0, a1
                  csrrw        s2, 0x344, a3
                  sub          s1, s2, sp
                  lbu          t6, 6(a5)
                  or           s0, t4, s10
                  lbu          a6, -1(a5)
                  lbu          s11, 4(a5)
                  lb           t1, -8(a5)
                  csrrsi       t0, 0x344, 0
                  sb           a6, 7(a5)
                  srai         s1, s3, 31
                  lhu          s9, -15(a5)
                  lbu          s0, 10(a5)
                  lb           s7, -12(a5)
                  mulhsu       t0, s3, a2
                  lb           s2, -3(a5) #end riscv_load_store_rand_instr_stream_0
                  la           s9, region_1+51895 #start riscv_load_store_hazard_instr_stream_21
                  lbu          s6, 1846(s9)
                  lb           a4, 1846(s9)
                  sb           t3, 1846(s9)
                  lb           t5, -1949(s9)
                  lb           t3, -1949(s9)
                  addi         s0, t4, 250
                  or           s7, t6, s3
                  lbu          s8, 908(s9)
                  lbu          t0, 908(s9)
                  lb           zero, 908(s9)
                  lh           t3, 379(s9)
                  nop
                  srai         s1, t5, 13
                  sh           t2, 379(s9)
                  sb           gp, 1306(s9)
                  sh           t6, -429(s9)
                  addi         a7, a4, 1833
                  lbu          a4, -429(s9)
                  sb           t2, 1222(s9)
                  csrrc        s11, 0x343, s1
                  lbu          t0, 1222(s9)
                  xori         a4, t1, 1135
                  lb           s7, 1222(s9)
                  sb           s4, 1222(s9)
                  lb           a5, 1938(s9)
                  lb           gp, 1354(s9) #end riscv_load_store_hazard_instr_stream_21
                  la           t0, region_1+9280 #start load_store_instr_stream_0
                  la           a7, region_1+11953 #start load_store_instr_stream_2
                  la           s9, region_1+12594 #start load_store_instr_stream_1
                  lw           t1, 934(s9)
                  sb           t5, -195(t0)
                  sb           s9, 81(s9)
                  sb           s11, -109(t0)
                  sb           a3, 991(s9)
                  lb           s3, -7(a7)
                  lhu          s4, 104(t0)
                  sb           s1, -8(a7)
                  sh           ra, 76(s9)
                  lbu          t3, -10(a7)
                  sb           t6, 0(a7)
                  sh           s9, 254(t0)
                  sb           s9, -12(a7) #end load_store_instr_stream_2
                  lbu          s3, 22(t0)
                  lbu          t3, -1923(s9)
                  lb           t5, -5(t0)
                  lbu          s11, -245(t0)
                  lb           a1, 2036(s9) #end load_store_instr_stream_1
                  sb           a5, 78(t0) #end load_store_instr_stream_0
                  addi         s5, zero, 1 #init loop 1 counter
                  divu         a4, t6, a1
                  srli         a6, s2, 15
                  andi         t4, s2, 842
                  addi         a3, zero, 10 #init loop 1 limit
main_208_1_t:     mulhsu       s11, s11, sp
                  div          t3, a2, t3
                  csrrwi       t3, 0x304, 1
                  csrrw        a6, 0x344, a7
                  addi         s5, s5, 2 #update loop 1 counter
                  div          s6, t2, s2
                  sll          s7, a5, t3
                  sll          t3, s7, a4
                  addi         a2, zero, -10 #init loop 0 counter
                  mulh         s8, zero, a2
                  slti         a7, t0, -1355
                  addi         s0, zero, -17 #init loop 0 limit
                  ori          t3, zero, -1434
                  xori         s11, a2, -1329
main_208_0_t:     nop
                  remu         s8, a2, s0
                  addi         a2, a2, -7 #update loop 0 counter
                  csrrwi       s3, 0x343, 22
                  beq          a2, s0, main_208_0_t #branch for loop 0
                  xor          ra, s11, t4
                  mulhsu       t5, zero, t1
                  and          s8, s6, t4
                  bltu         s5, a3, main_208_1_t #branch for loop 1
                  mulhsu       a5, a2, s2
                  li           s2, 0xb15edf94 #start riscv_int_numeric_corner_stream_5
                  li           s8, 0x80000000
                  li           s1, 0xffffffff
                  li           t4, 0x0
                  li           a1, 0x80000000
                  li           t3, 0x80000000
                  li           a3, 0x80000000
                  li           a2, 0x80000000
                  li           gp, 0x0
                  li           t2, 0x80000000
                  lui          gp, 884676
                  mulhu        s1, gp, t3
                  auipc        gp, 7231
                  auipc        s1, 597742
                  divu         a3, a2, s2
                  add          a2, a3, a2
                  nop
                  auipc        t2, 879142
                  lui          a3, 803048
                  add          s2, s1, s1
                  sub          t3, a1, s1
                  lui          s8, 602198
                  lui          a3, 149798
                  mulhu        a3, a1, a2
                  auipc        a3, 782428
                  mulh         s1, s1, s8
                  addi         gp, a1, -1407
                  sub          a1, t4, t4
                  addi         a2, a2, -118 #end riscv_int_numeric_corner_stream_5
                  la           t5, region_1+28473 #start riscv_load_store_rand_instr_stream_28
                  andi         s4, a4, 656
                  slli         s6, s7, 21
                  rem          a4, t3, t5
                  ori          a4, gp, 1331
                  div          s11, s7, t5
                  addi         s4, s11, -137
                  divu         t4, a3, a1
                  sb           t0, 138(t5)
                  lb           s3, -1076(t5)
                  slli         zero, s11, 23
                  auipc        a3, 435114
                  lhu          a3, 1731(t5)
                  lbu          t4, 436(t5)
                  mulhsu       ra, s9, s8
                  lb           t0, -1907(t5)
                  sub          t1, t4, gp
                  lhu          s8, -2001(t5)
                  lb           s4, 2017(t5)
                  div          t2, t3, a5
                  sh           s2, 1181(t5)
                  or           ra, s10, a4
                  add          a1, s2, t1
                  sb           t4, 1533(t5)
                  lhu          ra, -195(t5)
                  divu         t3, s9, s10
                  sh           s11, -1399(t5)
                  lb           t4, -430(t5)
                  csrrci       a5, 0x342, 0
                  csrrc        t1, 0x344, zero
                  nop
                  slti         a6, gp, 323
                  csrrci       s8, 0x305, 0
                  lhu          s9, 1441(t5)
                  div          gp, s10, s1
                  lb           a4, -1211(t5)
                  slt          t2, zero, s7
                  lbu          s2, 504(t5)
                  lb           t0, -1676(t5)
                  slti         s4, ra, 697
                  slli         s7, s3, 30
                  csrrc        s11, 0x301, zero
                  lbu          a7, -688(t5)
                  csrrw        t2, 0x301, t0
                  lhu          s3, -1981(t5)
                  nop
                  sh           a3, -849(t5) #end riscv_load_store_rand_instr_stream_28
                  la           s0, region_0+143 #start riscv_load_store_hazard_instr_stream_7
                  lb           s3, -9(s0)
                  sb           t3, -9(s0)
                  div          s7, a4, t3
                  mul          s9, a0, t3
                  lw           ra, 13(s0)
                  lhu          s4, 13(s0)
                  add          s6, zero, a5
                  lbu          t5, 13(s0)
                  sb           s6, -8(s0)
                  lb           s3, 12(s0)
                  sb           a4, 12(s0)
                  andi         a6, a0, -405
                  sb           t2, -12(s0)
                  lb           gp, -12(s0) #end riscv_load_store_hazard_instr_stream_7
                  la           s2, region_1+29359 #start load_store_instr_stream_2
                  la           s6, region_1+6138 #start load_store_instr_stream_0
                  lh           a4, -238(s6)
                  la           a1, region_1+2796 #start load_store_instr_stream_1
                  lbu          t4, 23(s6)
                  lb           zero, -8(s6)
                  sb           sp, -1313(a1)
                  lhu          t1, -240(s6)
                  lb           gp, 92(s6)
                  lh           t2, -119(s2)
                  sb           t6, -1601(a1)
                  lbu          s4, 113(s6)
                  sb           gp, 96(s2)
                  sw           s7, 1444(a1)
                  lb           s7, 321(a1)
                  sb           a4, -687(a1)
                  lb           t5, -1107(a1)
                  lbu          s10, 220(s2)
                  sw           s9, 170(s6)
                  lb           ra, -170(s2)
                  lb           t4, -88(s2) #end load_store_instr_stream_2
                  lb           s9, -129(a1) #end load_store_instr_stream_1
                  sw           t5, 18(s6) #end load_store_instr_stream_0
                  la           s4, region_1+57922 #start load_store_instr_stream_1
                  lhu          t6, 214(s4)
                  lb           t0, 52(s4)
                  lb           zero, -14(s4)
                  la           s5, region_0+3872 #start load_store_instr_stream_0
                  sw           s9, -122(s4)
                  lb           s6, 213(s5)
                  sb           gp, 183(s4)
                  lh           s6, 76(s5)
                  lh           s7, 186(s5)
                  lb           s7, 139(s4)
                  sb           a7, -77(s5)
                  lbu          a5, -22(s4)
                  sb           a3, -25(s4) #end load_store_instr_stream_1
                  sb           a4, -193(s5) #end load_store_instr_stream_0
                  la           s3, region_0+994 #start riscv_load_store_hazard_instr_stream_28
                  ori          t1, t4, 740
                  lh           s6, -116(s3)
                  lb           t0, -116(s3)
                  ori          a4, s3, -1938
                  sb           s3, 1594(s3)
                  sh           s2, 1594(s3)
                  lw           s1, 1594(s3)
                  lbu          s2, -315(s3)
                  lbu          s2, -315(s3)
                  rem          a7, t2, sp
                  sb           a6, -315(s3)
                  sb           s9, -315(s3)
                  sb           s7, -315(s3)
                  lb           a4, -315(s3)
                  lbu          a5, -315(s3)
                  auipc        t3, 645273
                  sb           s10, 1803(s3)
                  sll          s4, tp, t6
                  lbu          t3, -357(s3)
                  slt          a2, s7, a1
                  sb           s10, 1901(s3) #end riscv_load_store_hazard_instr_stream_28
                  addi         t6, zero, -1 #init loop 0 counter
                  csrrw        s11, 0x342, tp
                  add          t4, a6, t4
                  auipc        t0, 11547
                  mulhsu       s10, a0, s3
                  csrrci       a3, 0x304, 16
                  addi         a5, zero, 15 #init loop 0 limit
main_229_0_t:     nop
                  lui          a2, 75663
                  addi         t6, t6, 2 #update loop 0 counter
                  mulhu        t3, t4, s7
                  xor          a6, t1, s2
                  bltu         t6, a5, main_229_0_t #branch for loop 0
                  lui          a7, 816279
main_115:         jal          ra, 9f
0:                jal          ra, 1f
1:                jal          a1, 5f
2:                jal          t1, 14f
3:                jal          t0, 11f
4:                jal          ra, 15f
5:                jal          t1, 10f
6:                jal          s7, 7f
7:                jal          ra, 3b
8:                jal          ra, 13f
9:                jal          ra, 6b
10:               jal          ra, 2b
11:               jal          t1, 0b
12:               jal          ra, 4b
13:               jal          a4, 12b
14:               jal          ra, 8b
15:               jal          ra, 16f
16:               srai         a3, a0, 20
                  la           t5, region_0+1928 #start riscv_hazard_instr_stream_7
                  sb           s0, 393(t5)
                  sb           s6, 809(t5)
                  xori         s0, s6, 1632
                  csrrci       t3, 0x344, 0
                  addi         a5, t3, -466
                  lhu          s6, -1026(t5)
                  sll          s3, s6, s9
                  slti         s0, s0, -228
                  and          s0, a5, a5
                  srli         s6, a5, 24
                  sll          a5, s0, s3
                  mulh         s9, s6, a5
                  lbu          s9, 485(t5)
                  div          a5, a5, s6
                  sltiu        s3, s9, -1207
                  sb           s0, 432(t5)
                  add          s9, s3, s9
                  lbu          s3, 1489(t5)
                  sh           s3, -1294(t5)
                  and          s6, t3, s0
                  lb           a5, 188(t5)
                  sh           s9, 268(t5)
                  lb           a5, 837(t5)
                  lhu          s9, -1716(t5)
                  sub          s3, s3, s3
                  sb           a5, 12(t5)
                  sh           a5, 1312(t5)
                  xori         s0, s9, -1812
                  sw           s9, -1340(t5)
                  lb           s3, 1657(t5)
                  srai         s3, a5, 10
                  sub          s0, s9, s0
                  lb           s3, -1821(t5)
                  slli         s3, s0, 0
                  rem          s3, s9, t3
                  xor          t3, s0, s3
                  auipc        s9, 329263
                  slti         t3, a5, 1563
                  csrrc        s3, 0x343, s3
                  add          t3, a5, s0
                  lb           s6, -873(t5) #end riscv_hazard_instr_stream_7
                  addi         t4, zero, 8 #init loop 1 counter
                  srli         t0, s4, 15
                  addi         a2, zero, 0 #init loop 1 limit
main_233_1_t:     mul          t1, t6, ra
                  addi         t4, t4, -9 #update loop 1 counter
                  rem          s4, a0, a4
                  addi         s6, zero, -1 #init loop 0 counter
                  sltiu        a5, s7, 1837
                  addi         gp, zero, 8 #init loop 0 limit
main_233_0_t:     sltiu        ra, gp, -96
                  div          a3, t6, s0
                  addi         s6, s6, 9 #update loop 0 counter
                  bne          s6, gp, main_233_0_t #branch for loop 0
                  bge          t4, a2, main_233_1_t #branch for loop 1
                  mulh         a6, t4, s3
main_103:         jal          ra, 11f
0:                jal          t1, 12f
1:                jal          t1, 6f
2:                jal          ra, 1b
3:                jal          t2, 13f
4:                jal          t1, 14f
5:                jal          t1, 10f
6:                jal          ra, 7f
7:                jal          ra, 15f
8:                jal          ra, 5b
9:                jal          ra, 2b
10:               jal          ra, 0b
11:               jal          ra, 8b
12:               jal          t1, 9b
13:               jal          gp, 4b
14:               jal          ra, 16f
15:               jal          ra, 3b
16:               mulhu        t1, s1, s4
                  li           t1, 0xad8286f3 #start riscv_int_numeric_corner_stream_31
                  li           a2, 0xffffffff
                  li           s1, 0xffffffff
                  li           t5, 0x0
                  li           a3, 0x80000000
                  li           a5, 0x80000000
                  li           t6, 0x0
                  li           ra, 0x80000000
                  li           s7, 0x80000000
                  li           t3, 0x80000000
                  mul          ra, t3, t3
                  mul          t3, t6, s1
                  sub          t3, s1, a2
                  sub          s7, t3, s7
                  divu         s1, s1, a5
                  div          t1, a5, s1
                  mulhsu       a5, a2, s7
                  auipc        t1, 903726
                  lui          ra, 159359
                  add          t6, a3, a5
                  add          s1, s7, s7
                  mul          t6, t6, s7
                  addi         t6, t3, -2030
                  addi         t1, t5, 933
                  mulhsu       a3, s1, a2
                  mulhsu       t1, t5, t5
                  add          t6, t1, ra
                  nop
                  remu         s7, a2, ra
                  add          s1, ra, t5
                  mul          a5, a3, s7
                  mulhsu       s7, t6, a5
                  mul          t6, ra, t1
                  add          t1, ra, s7
                  mulhu        t1, a5, t1
                  divu         ra, t5, s1
                  div          a2, a5, s7
                  add          t1, a2, ra #end riscv_int_numeric_corner_stream_31
                  la           a5, region_0+1918 #start riscv_load_store_hazard_instr_stream_11
                  lb           ra, 181(a5)
                  sb           tp, 181(a5)
                  sb           sp, 181(a5)
                  lbu          ra, 181(a5)
                  lbu          s1, 181(a5)
                  sb           zero, 181(a5)
                  sltiu        a6, a7, -11
                  sb           s1, 181(a5)
                  lbu          zero, 181(a5)
                  sb           a4, 181(a5)
                  lb           a2, 181(a5)
                  lbu          a2, -631(a5)
                  lbu          zero, -631(a5)
                  lbu          s2, -631(a5) #end riscv_load_store_hazard_instr_stream_11
                  la           s5, region_0+3969 #start load_store_instr_stream_1
                  la           a3, region_1+46905 #start load_store_instr_stream_0
                  sb           s6, -866(s5)
                  lb           t3, 132(a3)
                  lw           s9, -1641(s5)
                  lbu          t6, 56(s5)
                  lb           s11, -881(s5)
                  lb           s9, -78(a3)
                  sb           t1, -1918(s5)
                  sb           t1, -42(a3)
                  lw           a4, 135(a3)
                  sb           s11, -445(s5)
                  lbu          a7, -246(s5)
                  sb           s8, -1603(s5)
                  sb           s6, 252(a3)
                  sh           s11, -903(s5)
                  sb           t3, -1869(s5) #end load_store_instr_stream_1
                  sb           zero, -127(a3) #end load_store_instr_stream_0
                  la           s7, region_0+693 #start riscv_load_store_rand_instr_stream_23
                  lbu          a3, 3(s7)
                  and          t4, t1, t4
                  sb           s4, 10(s7)
                  sb           t5, 11(s7)
                  lbu          a1, 2(s7)
                  lbu          a6, 10(s7)
                  xori         s6, a1, -96
                  sb           a1, 13(s7)
                  lb           t4, 8(s7)
                  xori         a2, a4, -1469
                  slti         s4, a7, 1557
                  slt          s8, s9, sp
                  lbu          t2, 2(s7)
                  sb           s6, 16(s7)
                  divu         a7, a0, gp
                  srl          s11, s9, s11
                  lbu          a6, -8(s7)
                  or           s2, a6, a7
                  sh           t2, -1(s7)
                  sh           t2, 7(s7)
                  sub          gp, t2, s4
                  srli         s10, s9, 24
                  lb           a1, -12(s7)
                  csrrs        s2, 0x344, zero
                  lbu          a4, -4(s7)
                  csrrw        s5, 0x343, ra
                  sb           a7, 16(s7)
                  lui          a3, 379941
                  lh           t0, -7(s7) #end riscv_load_store_rand_instr_stream_23
                  la           s5, region_0+2581 #start riscv_load_store_rand_instr_stream_33
                  xor          t2, a2, zero
                  csrrc        a7, 0x343, zero
                  addi         t6, gp, 1635
                  lhu          s10, 819(s5)
                  auipc        s1, 422010
                  lbu          t3, 286(s5)
                  slti         s0, t2, -751
                  csrrw        zero, 0x301, t3
                  csrrwi       t1, 0x342, 5
                  csrrw        ra, 0x301, t0
                  and          s1, s8, t6
                  lui          t3, 863900
                  lhu          a3, 549(s5)
                  mul          a5, t3, s6
                  sub          t2, s0, t2
                  nop
                  lh           a3, 1287(s5)
                  addi         a5, t1, -920
                  addi         s3, t0, -1989
                  sb           a0, 794(s5)
                  xor          s9, s6, s10
                  lbu          s2, -662(s5)
                  lbu          t4, -549(s5)
                  lhu          t6, 1109(s5)
                  auipc        a3, 16365
                  remu         a6, ra, a6
                  nop
                  lbu          gp, 808(s5)
                  lh           s8, -2031(s5)
                  lb           a6, -2004(s5)
                  sb           a0, -646(s5)
                  divu         t6, sp, t4
                  addi         s0, a2, 1272
                  lh           s7, 1417(s5)
                  sltu         zero, t3, tp
                  slt          t6, tp, tp
                  lbu          a2, -411(s5)
                  sltiu        t3, s11, 1389
                  lbu          s10, -1115(s5)
                  lhu          s9, -29(s5)
                  sb           s5, 518(s5) #end riscv_load_store_rand_instr_stream_33
                  la           ra, region_0+3603 #start riscv_load_store_hazard_instr_stream_26
                  lh           t6, -99(ra)
                  sb           sp, -99(ra)
                  lw           t4, -99(ra)
                  lbu          s0, -99(ra)
                  lbu          a2, -99(ra)
                  lbu          gp, -99(ra)
                  sb           s9, -99(ra)
                  slt          a4, gp, tp
                  addi         t6, sp, 1086
                  lbu          a3, -99(ra)
                  lw           s11, -99(ra)
                  lw           t4, -99(ra)
                  sh           s4, -99(ra)
                  sb           a2, -99(ra)
                  sw           a5, -99(ra)
                  lhu          s3, -99(ra) #end riscv_load_store_hazard_instr_stream_26
                  addi         s6, zero, -4 #init loop 0 counter
                  and          s11, a2, t4
                  addi         t2, zero, 0 #init loop 0 limit
                  srli         s11, a5, 30
main_201_0_t:     slt          t0, t4, tp
                  srl          zero, a1, a3
                  addi         s6, s6, 3 #update loop 0 counter
                  xor          a5, t5, sp
                  div          t3, s7, a0
                  auipc        t3, 475554
                  add          t1, t1, ra
                  divu         s8, t5, s10
                  csrrsi       a6, 0x304, 30
                  sll          t4, t0, t2
                  remu         s10, a1, s3
                  csrrci       zero, 0x305, 0
                  blt          s6, t2, main_201_0_t #branch for loop 0
                  remu         t6, s0, s1
                  addi         t3, zero, -8 #init loop 1 counter
                  sll          ra, t0, ra
                  addi         a6, zero, 5 #init loop 1 limit
main_227_1_t:     sub          s4, s3, s3
                  rem          s9, a7, ra
                  addi         t3, t3, 1 #update loop 1 counter
                  addi         s2, zero, 10 #init loop 0 counter
                  csrrci       s7, 0x343, 13
                  mulhu        a3, s5, a5
                  addi         s0, zero, 19 #init loop 0 limit
main_227_0_t:     sltu         a7, ra, t1
                  addi         s2, s2, 9 #update loop 0 counter
                  beq          s2, s0, main_227_0_t #branch for loop 0
                  nop
                  andi         s3, a7, -216
                  sll          a1, s6, s7
                  bltu         t3, a6, main_227_1_t #branch for loop 1
                  divu         t2, tp, s10
                  addi         a5, zero, 7 #init loop 1 counter
                  xori         a6, sp, 1758
                  addi         s2, zero, 8 #init loop 1 limit
                  xori         t2, t6, 11
                  csrrc        t0, 0x305, zero
main_212_1_t:     remu         s6, s1, gp
                  addi         a5, a5, 1 #update loop 1 counter
                  mulhu        s1, t5, a7
                  addi         a4, zero, 9 #init loop 0 counter
                  divu         a7, s4, s5
                  addi         s5, zero, -18 #init loop 0 limit
                  andi         a2, sp, 1425
                  sltu         s4, t5, t6
                  slt          a3, s8, s6
main_212_0_t:     mulh         s1, a7, t0
                  srli         s10, s1, 18
                  addi         a4, a4, -9 #update loop 0 counter
                  and          a1, gp, s10
                  or           a6, sp, s1
                  bne          a4, s5, main_212_0_t #branch for loop 0
                  sra          t0, s1, t1
                  add          ra, t5, s0
                  blt          a5, s2, main_212_1_t #branch for loop 1
                  xor          s4, s1, s0
                  la           t1, region_1+65098 #start riscv_load_store_rand_instr_stream_15
                  sb           a3, -47(t1)
                  sb           a5, 185(t1)
                  lb           t3, 24(t1)
                  csrrci       s8, 0x301, 0
                  sb           t0, -195(t1)
                  lbu          a4, -168(t1)
                  lui          s7, 248125
                  andi         a2, t0, -1831
                  mulhsu       ra, s9, s11
                  srai         s9, a4, 8
                  lbu          t5, 237(t1)
                  lb           a1, -21(t1)
                  mulh         t6, a4, s10
                  div          zero, s7, s11
                  lb           t3, -195(t1)
                  mul          a2, s4, ra
                  lb           a5, -62(t1)
                  lbu          t4, -3(t1)
                  and          t6, s8, s7
                  rem          s3, zero, s6
                  divu         s2, s7, s4
                  lui          t5, 836272
                  srl          a3, a6, a0
                  mulhsu       a7, a5, s8
                  lbu          t4, 176(t1)
                  lb           s4, 256(t1) #end riscv_load_store_rand_instr_stream_15
                  la           s10, region_1+24752 #start riscv_hazard_instr_stream_9
                  sb           s2, -15(s10)
                  slli         a4, s8, 1
                  slt          s8, s8, a4
                  divu         s8, a4, s8
                  lb           s2, 7(s10)
                  sub          a2, s3, s2
                  lbu          s3, -1(s10)
                  sltu         a4, a4, s2
                  lb           a4, -11(s10)
                  lh           a2, 4(s10)
                  lb           a2, 9(s10)
                  div          s2, a4, a4
                  sb           a4, 11(s10)
                  nop
                  sb           ra, -9(s10)
                  rem          a2, s2, s2
                  sw           ra, 8(s10)
                  sh           ra, 0(s10)
                  and          a4, s8, s2
                  lbu          a4, -16(s10)
                  nop
                  lb           ra, 16(s10)
                  sltu         ra, ra, a4
                  lbu          ra, 9(s10)
                  csrrw        ra, 0x304, s3
                  mulhsu       s8, s3, a4
                  sb           s2, -5(s10)
                  sub          s3, a4, s3
                  srl          s8, s8, ra
                  mulh         a2, ra, ra
                  sb           ra, -6(s10)
                  csrrsi       s8, 0x300, 0
                  lh           ra, -14(s10)
                  sb           a2, 12(s10)
                  sb           s3, 9(s10)
                  sb           ra, -10(s10)
                  lbu          s3, -16(s10)
                  div          ra, a2, s8
                  slt          s8, s3, s3
                  lb           a4, 13(s10)
                  sb           a4, -3(s10)
                  lbu          ra, 12(s10)
                  csrrc        s2, 0x344, ra
                  rem          a2, s2, s8
                  lbu          s8, -3(s10)
                  addi         s2, s2, 1280
                  sh           ra, 12(s10)
                  or           a4, s3, a4
                  lbu          ra, -6(s10)
                  xor          ra, ra, a2
                  sw           ra, -4(s10) #end riscv_hazard_instr_stream_9
                  la           s10, region_0+3554 #start riscv_load_store_hazard_instr_stream_19
                  lhu          gp, -1218(s10)
                  lw           t2, -1218(s10)
                  sw           s9, -1218(s10)
                  rem          s2, s11, t3
                  and          t5, a7, t3
                  sb           s6, -1205(s10)
                  lbu          a7, -1205(s10)
                  add          gp, s10, tp
                  lh           a6, -848(s10)
                  sh           s7, -848(s10)
                  sh           a2, -848(s10)
                  lhu          s6, -848(s10)
                  lhu          t5, -848(s10)
                  lh           s11, -848(s10)
                  remu         t3, a3, a7
                  slli         s8, a0, 25
                  mul          s6, s5, s11
                  lbu          t5, -848(s10)
                  sh           t5, -1706(s10)
                  sw           t6, -1706(s10) #end riscv_load_store_hazard_instr_stream_19
                  li           s9, 0x0 #start riscv_int_numeric_corner_stream_22
                  li           s7, 0x80000000
                  li           s4, 0x80000000
                  li           s10, 0x0
                  li           s11, 0xffffffff
                  li           t4, 0xffffffff
                  li           s3, 0xffffffff
                  li           s0, 0xf99a7d35
                  li           a3, 0xffffffff
                  li           t0, 0x80000000
                  mul          s4, s7, s4
                  lui          t4, 831279
                  lui          s4, 910125
                  nop
                  add          s3, t4, s3
                  auipc        s3, 735736
                  auipc        s7, 584582
                  mulhsu       s10, s9, s11
                  mul          s11, s3, s4
                  addi         s3, s4, -1051
                  mulh         s0, s9, s4
                  remu         s4, s11, t0
                  mulhsu       s11, s4, s7
                  sub          s4, t0, s3
                  add          t4, s7, t0 #end riscv_int_numeric_corner_stream_22
                  la           a4, region_0+3108 #start riscv_hazard_instr_stream_24
                  lhu          s5, 946(a4)
                  lh           a3, -936(a4)
                  csrrsi       a3, 0x300, 0
                  sb           a3, -1034(a4)
                  sh           s10, 402(a4)
                  mulh         a3, s5, zero
                  sra          s10, s0, s0
                  sb           t2, -1254(a4)
                  sltiu        zero, zero, -995
                  slli         s10, s5, 23
                  sltu         s0, s5, s5
                  or           a3, a3, zero
                  lbu          s10, -1722(a4)
                  add          t2, s5, s10
                  sh           s10, -1936(a4)
                  rem          s5, zero, zero
                  csrrsi       zero, 0x342, 0
                  csrrc        t2, 0x300, zero
                  auipc        s5, 305766
                  mul          s0, a3, s10
                  sb           a3, -1465(a4)
                  sb           a3, 21(a4)
                  sb           s0, -1591(a4)
                  lb           t2, -265(a4)
                  lh           a3, -1924(a4)
                  lbu          s0, -895(a4)
                  lb           zero, -1460(a4)
                  lb           s10, -827(a4)
                  andi         s5, t2, 1736
                  add          a3, s0, s10
                  lb           s5, -426(a4)
                  mulh         s10, zero, s5
                  andi         s5, zero, -608
                  csrrci       s0, 0x342, 6
                  lbu          s5, -1003(a4)
                  sb           t2, 9(a4)
                  sltu         a3, a3, s10
                  lb           a3, -715(a4)
                  lw           s10, -1276(a4)
                  slt          t2, s10, t2
                  lbu          t2, -1021(a4)
                  sw           s10, -168(a4)
                  lui          a3, 233222
                  srl          s5, zero, a3
                  auipc        s0, 848987
                  divu         t2, a3, s10
                  sltiu        s10, t2, -683
                  nop
                  nop
                  slt          a3, s0, a3
                  lb           a3, -1502(a4)
                  lb           s10, -1635(a4)
                  lw           a3, -876(a4)
                  lb           s5, -1159(a4)
                  or           t2, zero, t2
                  sb           t2, -1884(a4) #end riscv_hazard_instr_stream_24
                  la           a4, region_1+40692 #start load_store_instr_stream_1
                  la           a2, region_0+3289 #start load_store_instr_stream_0
                  lbu          s6, 34(a2)
                  lh           t0, -161(a2)
                  lb           t5, 11(a4)
                  lhu          s8, 14(a4)
                  sh           s8, -2(a4)
                  sb           t0, -5(a4)
                  sb           t6, -70(a2)
                  lb           a3, 2(a4)
                  sb           s8, 14(a4)
                  lb           s7, 7(a4)
                  sb           a1, 33(a2)
                  sh           a6, 127(a2)
                  lw           a6, 0(a4) #end load_store_instr_stream_1
                  sb           s3, 134(a2) #end load_store_instr_stream_0
                  addi         s6, zero, 6 #init loop 0 counter
                  ori          s9, zero, 2037
                  divu         s3, s3, s3
                  divu         s11, t5, t5
                  csrrsi       t2, 0x342, 25
                  or           t0, t5, s4
                  sra          a1, t4, a3
                  sll          a5, tp, t3
                  addi         a2, a1, -1488
                  slt          s8, ra, s7
                  xori         s4, t0, 106
                  addi         a6, zero, 20 #init loop 0 limit
                  mulh         s11, t2, zero
main_226_0_t:     xori         a3, a5, -26
                  slli         t3, t2, 16
                  addi         s6, s6, 8 #update loop 0 counter
                  srai         s5, s8, 19
                  slt          a5, sp, tp
                  slti         t4, s0, -1810
                  csrrs        s4, 0x342, t1
                  csrrci       s5, 0x305, 0
                  srl          s1, sp, t0
                  csrrwi       a1, 0x301, 15
                  bltu         s6, a6, main_226_0_t #branch for loop 0
                  sll          s2, zero, a0
                  li           a7, 0xb0666740 #start riscv_int_numeric_corner_stream_4
                  li           t4, 0x80000000
                  li           ra, 0x0
                  li           s9, 0xffffffff
                  li           t5, 0x80000000
                  li           gp, 0x80000000
                  li           s2, 0xffffffff
                  li           a6, 0x2cb75ec5
                  li           s8, 0xffffffff
                  li           s0, 0x150e7c43
                  rem          ra, ra, s8
                  divu         s8, a6, s2
                  divu         s9, s9, s2
                  mulhu        s0, s9, t5
                  lui          a6, 714927
                  div          t4, s9, t5
                  addi         s8, t5, 1374
                  divu         s0, ra, s2
                  remu         t4, s9, s8
                  mul          s2, s2, s8
                  remu         ra, s8, gp
                  divu         s0, s2, s9
                  mul          ra, s2, s2
                  add          a7, t4, s0
                  addi         s2, s8, 1034
                  remu         s9, a6, s0
                  add          gp, s9, s2
                  div          a7, s8, a6
                  mulhsu       gp, s0, a7
                  add          a6, s9, a7 #end riscv_int_numeric_corner_stream_4
                  la           a4, region_0+3664 #start load_store_instr_stream_3
                  la           t4, region_0+1159 #start load_store_instr_stream_2
                  sb           s9, 52(t4)
                  la           t3, region_0+2107 #start load_store_instr_stream_4
                  lb           s4, -20(a4)
                  sw           s10, 13(t3)
                  lh           s10, -43(t4)
                  la           a7, region_0+270 #start load_store_instr_stream_1
                  sb           t1, -4(t3)
                  lbu          a3, -30(t4)
                  la           t6, region_0+533 #start load_store_instr_stream_0
                  sb           s9, -38(a4)
                  sb           ra, 4(t3)
                  lb           s6, 100(t6)
                  sb           s3, 12(t3)
                  lb           s1, 53(a4)
                  sb           t6, -61(t4)
                  sb           s9, 4(t6)
                  sb           s2, 130(a7)
                  sh           s3, 28(a4)
                  lb           s0, 4(t3)
                  lh           a2, -78(a7)
                  sh           s10, 33(t4)
                  lbu          ra, 185(t6)
                  lb           s4, -2(a4)
                  sb           a3, 2(t3) #end load_store_instr_stream_4
                  lb           s5, 38(t6)
                  lb           t5, 50(t4)
                  sb           a2, 69(a7)
                  lh           a6, -23(t6)
                  lhu          a1, 123(t6)
                  lb           s3, 7(a4) #end load_store_instr_stream_3
                  lbu          s0, 42(t4)
                  sh           s3, 104(a7)
                  lb           a3, 54(t4)
                  lh           a6, 166(a7) #end load_store_instr_stream_1
                  lhu          gp, -53(t4) #end load_store_instr_stream_2
                  lb           a2, -96(t6) #end load_store_instr_stream_0
                  la           s5, region_1+13790 #start riscv_load_store_hazard_instr_stream_18
                  sub          a3, a4, t4
                  andi         a7, a5, -154
                  lbu          s1, -9(s5)
                  lb           s6, -9(s5)
                  nop
                  sb           a5, -9(s5)
                  sub          s8, t3, a7
                  lbu          t6, 64(s5)
                  sb           t3, 64(s5)
                  sh           s9, 64(s5)
                  lh           zero, 64(s5)
                  lbu          a1, 64(s5)
                  sh           a0, 64(s5)
                  sub          s6, a7, tp
                  lb           s1, 43(s5)
                  addi         ra, s2, -1209
                  lb           t3, 43(s5)
                  sb           t1, 43(s5)
                  srli         ra, s7, 2
                  lbu          t6, 62(s5)
                  lbu          s3, 62(s5)
                  sw           t1, 62(s5)
                  sb           ra, 62(s5)
                  sw           a4, 62(s5) #end riscv_load_store_hazard_instr_stream_18
                  li           t4, 0x7711edb4 #start riscv_int_numeric_corner_stream_18
                  li           t6, 0xffffffff
                  li           a4, 0xffffffff
                  li           t5, 0x80000000
                  li           s3, 0x0
                  li           gp, 0x498293b5
                  li           t0, 0x22983072
                  li           s8, 0x0
                  li           t2, 0x80000000
                  li           s5, 0x188749c8
                  sub          gp, t4, t5
                  addi         s8, a4, 1659
                  div          t4, s8, t4
                  sub          s8, s3, s5
                  div          s8, a4, t2
                  remu         s5, a4, t6
                  rem          t2, s8, t0
                  nop
                  auipc        t6, 888135
                  div          t5, s8, t5
                  rem          t0, t4, s3
                  auipc        t6, 188206
                  mulh         s3, s3, t4
                  lui          t5, 512649
                  add          s3, t5, t0
                  mulh         t0, t0, s3
                  lui          gp, 1003656
                  addi         s8, t0, 1522
                  divu         a4, a4, s3
                  mul          gp, t4, s3
                  rem          s5, t5, t4
                  auipc        t0, 1000012
                  mulhu        t4, t0, a4
                  divu         a4, t5, t0
                  mulhsu       gp, a4, s8
                  add          t6, s3, gp
                  mul          s5, a4, a4
                  mulhu        t0, a4, t5
                  mulh         t5, s5, t4 #end riscv_int_numeric_corner_stream_18
                  la           t3, region_0+3152 #start riscv_load_store_hazard_instr_stream_16
                  lbu          ra, -107(t3)
                  lb           gp, -107(t3)
                  lb           s0, -107(t3)
                  slli         t2, sp, 0
                  sb           a4, -107(t3)
                  lb           s8, -107(t3)
                  sb           tp, -107(t3)
                  sb           zero, -107(t3)
                  lbu          s7, -203(t3)
                  sb           a5, -203(t3)
                  lb           t5, -203(t3)
                  srai         s4, t1, 4
                  sb           a4, -153(t3) #end riscv_load_store_hazard_instr_stream_16
                  li           a1, 0x3f804ef4 #start riscv_int_numeric_corner_stream_20
                  li           s5, 0xffffffff
                  li           s2, 0x63a28215
                  li           s6, 0x80000000
                  li           a2, 0x2d9d4b61
                  li           t5, 0x80000000
                  li           ra, 0xffffffff
                  li           a7, 0x580744b9
                  li           s7, 0x80000000
                  li           s3, 0x80000000
                  rem          s5, s3, a2
                  sub          a2, a1, s5
                  add          t5, ra, s2
                  mulhu        ra, s5, ra
                  rem          s5, a2, s7
                  addi         a2, a2, 1877
                  rem          s3, a7, a1
                  addi         a7, a7, 1283
                  mul          a2, a1, a1
                  nop
                  addi         s7, a1, -555
                  div          s5, s5, s6
                  addi         s3, s7, -369
                  mul          ra, t5, ra
                  nop
                  mulhu        t5, a1, a2
                  mulh         s2, a1, a1
                  div          a1, s6, a7
                  divu         s2, s3, t5
                  add          s5, ra, a7
                  add          ra, t5, s5
                  auipc        a2, 35764
                  mulhu        s7, ra, s7
                  mulhsu       s2, s6, ra
                  mulhsu       a1, a1, t5
                  lui          s6, 441226
                  nop
                  addi         s3, s2, 1541
                  mulhsu       s2, a7, s6 #end riscv_int_numeric_corner_stream_20
                  la           s10, region_0+1640 #start load_store_instr_stream_1
                  lhu          t2, -230(s10)
                  sb           a7, 218(s10)
                  la           a4, region_1+53086 #start load_store_instr_stream_0
                  lbu          s1, 119(s10)
                  lbu          a2, 177(s10)
                  sb           s3, -26(a4)
                  lbu          a6, 41(a4)
                  lbu          t4, 7(a4)
                  sh           s3, 226(s10)
                  lb           a3, -13(a4)
                  lb           a6, -15(a4)
                  lb           s7, -4(a4)
                  lbu          s8, 149(s10)
                  lbu          t3, -34(a4)
                  sw           s7, -10(a4)
                  lhu          s4, -44(a4)
                  lbu          ra, 45(s10) #end load_store_instr_stream_1
                  lb           a5, -31(a4) #end load_store_instr_stream_0
main_100:         jal          ra, 7f
0:                jal          t2, 3f
1:                jal          ra, 2f
2:                jal          ra, 17f
3:                jal          gp, 9f
4:                jal          a3, 19f
5:                jal          t1, 14f
6:                jal          ra, 4b
7:                jal          ra, 5b
8:                jal          ra, 0b
9:                jal          s0, 13f
10:               jal          t0, 20f
11:               jal          s7, 21f
12:               jal          t3, 8b
13:               jal          t1, 6b
14:               jal          s4, 12b
15:               jal          s11, 10b
16:               jal          a1, 11b
17:               jal          ra, 16b
18:               jal          ra, 1b
19:               jal          ra, 15b
20:               jal          t1, 18b
21:               ori          s3, a2, 1083
                  la           s3, region_0+3325 #start riscv_load_store_hazard_instr_stream_13
                  sb           t3, -6(s3)
                  lhu          s1, -11(s3)
                  lbu          a2, -11(s3)
                  mulhsu       a2, s1, sp
                  lh           a5, -11(s3)
                  lbu          t0, 11(s3)
                  mulh         gp, t4, s7
                  lh           s5, 11(s3)
                  sh           a1, 11(s3)
                  srli         s8, s10, 23
                  lb           s6, 11(s3)
                  sltiu        s10, sp, 1533
                  lhu          a6, -1(s3)
                  sw           a3, -1(s3)
                  lbu          t2, -1(s3)
                  lbu          a3, -1(s3)
                  add          a3, s3, s10
                  srli         t0, a7, 29
                  lb           s11, 2(s3)
                  sb           a4, 2(s3)
                  sb           s1, 2(s3)
                  xori         a6, s6, -1600
                  sb           t1, 2(s3)
                  sb           t3, 2(s3)
                  lb           t1, 2(s3) #end riscv_load_store_hazard_instr_stream_13
                  la           ra, region_0+3874 #start riscv_load_store_hazard_instr_stream_22
                  sb           s0, 201(ra)
                  lbu          s8, 201(ra)
                  lb           s0, 201(ra)
                  lb           a2, 201(ra)
                  lb           t2, 5(ra)
                  lb           a4, 5(ra)
                  slli         t5, s8, 28
                  sub          a2, s7, s9
                  lb           s2, 5(ra)
                  div          t3, s10, s11
                  lbu          a5, -185(ra)
                  lhu          t3, -118(ra)
                  lh           s8, -118(ra)
                  lb           a3, -118(ra)
                  lbu          s9, -27(ra)
                  sb           s2, -11(ra)
                  auipc        zero, 123276
                  lbu          s10, -217(ra)
                  sh           t1, -136(ra)
                  sll          s9, s3, ra
                  sub          a3, t3, a6
                  sltu         t5, s6, s0
                  lb           s0, -171(ra)
                  lb           s4, -171(ra)
                  lb           a6, -171(ra)
                  lh           a1, -136(ra) #end riscv_load_store_hazard_instr_stream_22
                  li           a7, 0x80000000 #start riscv_int_numeric_corner_stream_11
                  li           a1, 0x0
                  li           t2, 0x5872ba7
                  li           t6, 0x89be5b5b
                  li           t3, 0x0
                  li           s4, 0xffffffff
                  li           gp, 0x80000000
                  li           s11, 0x0
                  li           s9, 0x0
                  li           a3, 0x0
                  mulhu        a1, s11, t6
                  auipc        a1, 42302
                  rem          s11, t6, t6
                  mulh         gp, a1, s4
                  remu         s11, a3, a1
                  remu         s4, a7, s9
                  mulhsu       t3, s9, s4
                  mulh         a3, t2, s9
                  auipc        s4, 958214
                  lui          t2, 1000317
                  nop
                  mul          s4, a3, t3
                  mulhsu       t3, t2, s11
                  addi         a1, s11, -296
                  mulhsu       gp, s9, a3 #end riscv_int_numeric_corner_stream_11
main_95:          jal          ra, 16f
0:                jal          ra, 4f
1:                jal          ra, 13f
2:                jal          t1, 8f
3:                jal          ra, 10f
4:                jal          ra, 12f
5:                jal          ra, 17f
6:                jal          t4, 9f
7:                jal          ra, 1b
8:                jal          ra, 3b
9:                jal          t6, 5b
10:               jal          t1, 18f
11:               jal          ra, 22f
12:               jal          ra, 11b
13:               jal          ra, 2b
14:               jal          gp, 21f
15:               jal          t3, 14b
16:               jal          ra, 6b
17:               jal          ra, 19f
18:               jal          gp, 15b
19:               jal          t1, 20f
20:               jal          ra, 7b
21:               jal          ra, 0b
22:               or           s2, t6, s10
                  addi         a3, zero, -10 #init loop 0 counter
                  remu         s3, gp, sp
                  addi         s11, zero, -19 #init loop 0 limit
                  mul          t5, t6, a4
                  xori         s6, t1, -843
                  mulh         s1, t6, s10
main_205_0_t:     slti         s9, t0, 1924
                  csrrw        s7, 0x344, s8
                  addi         a3, a3, -3 #update loop 0 counter
                  auipc        s7, 261768
                  ori          s5, gp, 1815
                  or           t6, t4, a3
                  or           a1, sp, tp
                  div          a2, s9, zero
                  remu         ra, t3, t6
                  bge          a3, s11, main_205_0_t #branch for loop 0
                  slli         s5, s7, 15
                  la           a6, region_1+62807 #start riscv_load_store_rand_instr_stream_25
                  csrrwi       a4, 0x343, 5
                  xor          t3, ra, ra
                  nop
                  sub          t1, t3, s1
                  csrrw        t2, 0x304, t3
                  lb           s0, 54(a6)
                  sb           s9, -62(a6)
                  divu         s2, s6, s5
                  lb           s0, -14(a6)
                  div          s2, s9, a4
                  csrrw        zero, 0x342, sp
                  sb           a2, -20(a6)
                  csrrsi       t0, 0x304, 0
                  div          t0, s1, zero
                  lb           s2, 4(a6)
                  and          a1, a4, a0
                  add          s11, s5, s5
                  lb           a1, -32(a6)
                  lb           a3, 5(a6)
                  sh           s3, -61(a6)
                  lb           t0, -18(a6)
                  csrrwi       a2, 0x304, 19
                  remu         t5, a1, s7
                  mulhu        a4, s11, t3
                  mulhu        s0, t3, t4
                  auipc        s4, 254100
                  lw           t0, -19(a6)
                  csrrci       s5, 0x304, 14
                  lbu          s1, 19(a6)
                  lbu          s8, -2(a6)
                  sb           s10, 3(a6)
                  srli         a2, s10, 6
                  lui          s2, 392235
                  csrrc        a5, 0x300, zero
                  sb           s8, -56(a6)
                  mulhsu       a3, a3, s3
                  csrrc        s9, 0x305, zero
                  slt          a4, ra, a6
                  lb           s7, 20(a6)
                  srli         s7, t5, 3
                  lui          a2, 911151
                  lbu          s8, 46(a6)
                  lbu          s10, -50(a6)
                  srl          t3, s0, a5
                  sh           a2, -1(a6)
                  and          t4, s8, a5
                  slt          s9, s7, a6
                  sw           t5, -27(a6)
                  lbu          zero, -61(a6)
                  sub          s3, s9, sp
                  sh           t2, 41(a6) #end riscv_load_store_rand_instr_stream_25
                  la           s8, region_1+46960 #start riscv_load_store_rand_instr_stream_32
                  lb           t5, -218(s8)
                  add          s10, s9, s10
                  lh           t6, 20(s8)
                  sra          a7, t2, a6
                  andi         t2, tp, -544
                  lb           t3, -79(s8)
                  lhu          s11, -50(s8)
                  lhu          a6, 106(s8)
                  lh           t6, 98(s8)
                  lhu          s7, -162(s8)
                  csrrsi       a1, 0x305, 0
                  lui          s5, 788921
                  csrrci       a3, 0x300, 0
                  addi         s5, s2, 328
                  sb           tp, 205(s8)
                  mulhsu       s5, s8, s0
                  div          t5, s0, s1
                  lh           s4, -60(s8)
                  sb           t5, -148(s8)
                  lb           s5, -159(s8)
                  sb           a4, 235(s8)
                  slli         t0, a1, 1
                  csrrci       a7, 0x304, 11
                  mul          s7, s4, ra
                  sw           t6, -232(s8)
                  div          s0, s10, zero
                  add          t3, gp, s4
                  andi         t4, s10, -376
                  mul          gp, a4, a0
                  mulhu        a6, t4, s10
                  divu         s6, s8, t1
                  lbu          s0, -37(s8)
                  sb           s6, 115(s8)
                  lw           t6, -76(s8)
                  andi         s4, a4, 1197
                  lh           t3, -160(s8)
                  div          t4, s5, s3
                  csrrw        s0, 0x344, a5
                  lh           s9, -176(s8)
                  mulhsu       s10, s5, s11
                  nop
                  lbu          gp, -19(s8)
                  srli         s10, s2, 16
                  lb           a7, -73(s8)
                  csrrw        s9, 0x304, s7
                  lb           t2, 52(s8)
                  sh           s5, 104(s8) #end riscv_load_store_rand_instr_stream_32
                  la           s6, region_0+1013 #start riscv_load_store_rand_instr_stream_16
                  srl          ra, t4, s5
                  div          s11, a1, t1
                  lh           s11, -7(s6)
                  lb           s11, -16(s6)
                  sb           a6, 16(s6)
                  srai         s5, s8, 6
                  lb           a4, -2(s6)
                  srai         a4, s9, 2
                  rem          s11, s6, s8
                  add          ra, a4, a1
                  divu         s4, a1, zero
                  addi         s7, t1, 1095
                  sb           a3, -8(s6)
                  mulhu        a5, a7, zero
                  mulhu        s3, gp, a4
                  lb           s8, 7(s6)
                  rem          s8, s9, ra
                  lbu          s10, 2(s6)
                  lbu          t4, -14(s6)
                  slti         t0, a1, -30
                  csrrc        s0, 0x342, t6
                  div          s2, sp, a0
                  nop
                  mulh         s0, t0, a0
                  mul          s3, gp, t0
                  csrrwi       s9, 0x343, 18
                  mul          a4, a4, s6
                  lh           s7, 1(s6)
                  rem          s4, t4, a0
                  sb           a0, 8(s6)
                  nop
                  sub          s7, ra, t0
                  lbu          s4, 5(s6)
                  lbu          s4, -12(s6)
                  lhu          a3, 15(s6)
                  sb           ra, -2(s6)
                  or           s10, t5, a1
                  or           s7, s10, a7
                  sltiu        s5, a6, 805
                  lbu          t2, -1(s6)
                  csrrw        s2, 0x343, a0
                  or           a6, s7, a4
                  sh           a7, 5(s6)
                  srli         ra, t6, 14
                  lbu          s4, -12(s6)
                  mulh         s7, sp, ra
                  slt          t4, a7, s1
                  lbu          t4, 14(s6)
                  lbu          s1, 10(s6)
                  lb           t5, 6(s6) #end riscv_load_store_rand_instr_stream_16
                  la           t5, region_0+3562 #start load_store_instr_stream_1
                  la           a1, region_1+47349 #start load_store_instr_stream_0
                  lbu          t6, -97(t5)
                  lb           gp, 28(a1)
                  lbu          s7, -35(t5)
                  lbu          t6, -271(t5)
                  lb           a7, -1520(t5)
                  sb           t5, 26(t5)
                  lb           a2, -48(a1)
                  lhu          a5, -556(t5)
                  lbu          s6, -61(a1)
                  lb           zero, -1880(t5)
                  lbu          a5, 16(a1)
                  sb           tp, -446(t5) #end load_store_instr_stream_1
                  lbu          s8, 30(a1)
                  sb           zero, -8(a1) #end load_store_instr_stream_0
                  la           t2, region_0+3592 #start riscv_load_store_hazard_instr_stream_9
                  srl          a5, ra, a6
                  lbu          s8, -12(t2)
                  mulh         s10, t0, s9
                  sb           t2, -12(t2)
                  lw           a3, -12(t2)
                  xor          s8, a2, sp
                  sw           a3, -12(t2)
                  lb           a4, -12(t2)
                  lhu          s6, -12(t2)
                  slti         a2, t3, -631
                  lhu          a6, -12(t2)
                  lw           s7, -12(t2)
                  lb           gp, -12(t2)
                  lb           a2, -7(t2)
                  lb           a4, -7(t2)
                  lbu          a4, -7(t2)
                  lb           a5, -7(t2)
                  lbu          s6, -7(t2)
                  slti         gp, a2, -965
                  sb           t1, -7(t2)
                  lbu          a1, -7(t2)
                  lbu          s3, -7(t2)
                  sh           t4, 14(t2)
                  srl          ra, s4, s6
                  sh           a3, 14(t2) #end riscv_load_store_hazard_instr_stream_9
                  la           a3, region_1+20290 #start riscv_load_store_rand_instr_stream_38
                  sb           sp, -1300(a3)
                  lb           a6, 1187(a3)
                  lbu          a1, 753(a3)
                  slli         s7, t3, 11
                  lw           s10, -878(a3)
                  sb           a2, -1703(a3)
                  lb           s3, 142(a3)
                  sb           a7, -1025(a3)
                  sltiu        t6, a3, -735
                  nop
                  lbu          s5, 313(a3)
                  sb           s3, -594(a3)
                  lbu          a5, -1553(a3)
                  sltiu        ra, t2, 1923
                  srli         s3, s2, 30
                  sw           s10, -1942(a3)
                  slli         a4, a7, 21
                  mul          s5, a7, s5
                  slli         s5, s8, 12
                  remu         s9, a1, s1
                  auipc        t0, 376732
                  xor          s3, s2, t1
                  mulhsu       ra, s10, a3
                  slt          t1, gp, t1
                  ori          s0, s10, 50
                  sb           s2, 1131(a3)
                  ori          a1, a6, -1222
                  lbu          s9, 129(a3)
                  srai         s8, a1, 31
                  sltiu        ra, a6, 1306
                  srl          a5, s10, s7
                  sw           zero, 1010(a3)
                  sra          t3, t0, s8
                  sltu         a5, a7, s2
                  lh           s3, 1882(a3)
                  lb           t2, -1717(a3)
                  divu         a4, s8, a1
                  lb           s1, -757(a3)
                  srl          zero, tp, a7
                  sltiu        t5, a2, -1634
                  lbu          t6, -1852(a3) #end riscv_load_store_rand_instr_stream_38
                  la           s6, region_0+3811 #start riscv_load_store_rand_instr_stream_29
                  remu         s3, t1, t1
                  csrrci       s8, 0x343, 21
                  addi         s2, s3, 634
                  lb           s11, -1158(s6)
                  csrrci       t6, 0x304, 11
                  remu         s4, a3, a7
                  add          t4, s1, s11
                  mulh         s9, t1, s1
                  mulh         s0, s1, a0
                  add          t6, t5, t3
                  slti         t5, t6, -636
                  lb           t6, -1045(s6)
                  xori         t5, a2, 1943
                  lh           s2, -901(s6)
                  sub          a6, s0, s8
                  csrrwi       a3, 0x342, 19
                  lbu          s0, -2012(s6)
                  nop
                  add          s1, t1, s4
                  lb           s9, -1638(s6)
                  lbu          s7, -24(s6)
                  lb           a5, -1901(s6)
                  sra          a4, a0, a7
                  csrrw        ra, 0x343, s6
                  csrrc        t4, 0x301, s4
                  sub          s9, s2, a5
                  or           a4, s11, tp
                  divu         s10, t1, s8
                  nop
                  lhu          s8, -659(s6)
                  csrrw        a7, 0x343, s0
                  andi         s10, zero, 603
                  sh           a7, 221(s6)
                  csrrci       a5, 0x304, 0
                  sll          a5, s6, s6
                  remu         a4, sp, t0
                  sw           t4, -1951(s6)
                  lbu          t2, -1243(s6)
                  lbu          t1, -385(s6) #end riscv_load_store_rand_instr_stream_29
                  la           t2, region_1+20343 #start load_store_instr_stream_0
                  la           t5, region_0+2800 #start load_store_instr_stream_1
                  sb           a7, 49(t5)
                  lbu          s5, -204(t2)
                  lbu          a4, -1791(t2)
                  lh           a7, 8(t5)
                  lb           s0, 31(t5)
                  lbu          s5, 1455(t2)
                  lb           s11, 11(t5)
                  lbu          gp, 43(t5)
                  sb           t4, -705(t2)
                  lbu          s3, -44(t5) #end load_store_instr_stream_1
                  lb           ra, -1542(t2) #end load_store_instr_stream_0
                  la           a2, region_0+3947 #start load_store_instr_stream_0
                  la           t6, region_0+1311 #start load_store_instr_stream_1
                  lb           s0, -2048(a2)
                  lb           t0, 10(a2)
                  lhu          s3, 221(t6)
                  lbu          a6, 36(t6)
                  sh           a7, -1639(a2)
                  lhu          ra, -237(t6)
                  lbu          s0, -1425(a2)
                  lbu          s6, 227(t6)
                  lbu          s7, 226(t6)
                  lhu          a4, -73(a2)
                  sb           s3, 119(a2)
                  lbu          a5, 79(t6)
                  lh           s5, -745(a2)
                  lh           t4, 117(t6)
                  lb           s6, -680(a2)
                  lbu          s11, -127(t6) #end load_store_instr_stream_1
                  lhu          s0, -651(a2) #end load_store_instr_stream_0
                  la           t5, region_1+59553 #start riscv_hazard_instr_stream_39
                  auipc        a4, 814143
                  sb           t2, 16(t5)
                  mulhsu       s7, s8, t2
                  csrrs        s8, 0x343, t2
                  lui          s7, 39164
                  csrrw        s7, 0x304, s8
                  lb           s8, -4(t5)
                  sb           s8, -3(t5)
                  div          t2, s7, t2
                  lb           s1, 6(t5)
                  lb           s8, 14(t5)
                  sb           s1, -16(t5)
                  auipc        s8, 502166
                  mulhsu       a4, s1, s7
                  and          t2, s7, s7
                  lhu          s8, 5(t5)
                  nop
                  lw           a4, 3(t5)
                  and          t2, t2, t2
                  lh           a4, 5(t5)
                  or           s7, t4, s7
                  sra          t4, s7, a4
                  and          s1, a4, a4
                  csrrs        s8, 0x344, s8
                  lb           s7, 10(t5)
                  srai         s7, t4, 0
                  lb           s7, -1(t5)
                  lhu          t4, 1(t5)
                  lbu          a4, -6(t5)
                  lb           s1, -10(t5)
                  lw           t2, -13(t5)
                  lb           s7, -12(t5) #end riscv_hazard_instr_stream_39
                  li           s4, 0x0 #start riscv_int_numeric_corner_stream_2
                  li           ra, 0xffffffff
                  li           t2, 0xefc095a
                  li           s1, 0x39ee21a2
                  li           t0, 0x9e935820
                  li           t5, 0xffffffff
                  li           gp, 0x80000000
                  li           a2, 0x0
                  li           a5, 0xffffffff
                  li           s11, 0x7e1e727b
                  nop
                  div          ra, s4, t2
                  remu         s4, t5, t0
                  remu         ra, t2, a5
                  remu         t2, s11, t5
                  div          a2, s11, a2
                  mulhu        t2, t2, s1
                  div          s1, ra, t0
                  div          s1, s11, t5
                  mulhu        t5, s4, t2
                  auipc        s4, 824972
                  addi         s4, a2, 1182
                  div          a5, ra, s4
                  mulh         a2, a2, t5
                  add          ra, t5, s1
                  add          s4, s4, t2
                  nop
                  mulhu        gp, t5, a2
                  remu         a2, gp, gp
                  rem          t0, t0, t5
                  mulhu        t5, s1, s4
                  rem          ra, a5, gp
                  addi         t5, t5, 914
                  auipc        s1, 417420
                  auipc        ra, 540795
                  rem          a2, s1, t0
                  sub          t5, s11, s11
                  addi         s4, a2, 189 #end riscv_int_numeric_corner_stream_2
                  la           s1, region_0+1789 #start riscv_load_store_rand_instr_stream_30
                  andi         zero, zero, 1116
                  slti         a3, s11, -782
                  lb           a6, -28(s1)
                  xor          s2, s9, t1
                  add          t4, s4, s5
                  lhu          s5, -185(s1)
                  div          s11, s11, s3
                  lb           s5, -143(s1)
                  divu         s2, s6, sp
                  lbu          s7, -88(s1)
                  xor          a6, s7, a5
                  andi         s4, a7, 396
                  mulhu        t4, t3, s5
                  lb           s6, -256(s1)
                  sb           s0, 167(s1)
                  lb           s10, -246(s1)
                  sb           t5, 87(s1)
                  divu         ra, sp, a5
                  lbu          t5, -122(s1)
                  mulhsu       s9, s8, s0
                  sb           a5, 122(s1)
                  lhu          s4, -157(s1)
                  lb           s2, 86(s1)
                  sb           t1, 28(s1)
                  sb           s2, 182(s1)
                  ori          a6, gp, -814
                  sh           a4, -223(s1)
                  lbu          s9, -76(s1) #end riscv_load_store_rand_instr_stream_30
                  la           s2, region_1+5523 #start load_store_instr_stream_2
                  la           t2, region_1+24105 #start load_store_instr_stream_3
                  la           s6, region_1+50069 #start load_store_instr_stream_4
                  la           a3, region_1+58364 #start load_store_instr_stream_1
                  sb           s4, 1877(a3)
                  la           t1, region_1+11766 #start load_store_instr_stream_0
                  sb           zero, -713(a3)
                  lhu          s11, 585(t2)
                  lh           gp, 472(a3)
                  lhu          t5, 54(t1)
                  lhu          t3, 1771(s6)
                  lh           a4, 76(t1)
                  lh           zero, -15(s2)
                  lbu          ra, -747(t2)
                  lbu          t4, -384(t2)
                  lbu          t6, 184(s2)
                  lbu          s0, -1992(t2)
                  sh           zero, -2(t1)
                  lbu          a4, -1267(a3)
                  sb           a3, -1083(t2)
                  sh           a6, -1419(s6)
                  lh           s3, 1367(t2)
                  lhu          s8, 1819(s6)
                  lbu          a4, 1952(t2)
                  sh           a3, -124(t1)
                  lbu          gp, -93(s2)
                  sh           s8, 13(s2)
                  lb           gp, -1870(a3)
                  lhu          s9, -153(s6)
                  lh           ra, 1703(t2)
                  lb           s7, 1728(t2)
                  sb           a0, 1451(a3)
                  sb           gp, 1075(s6)
                  lh           t3, 40(a3)
                  lb           t0, -1735(t2) #end load_store_instr_stream_3
                  lbu          a4, -256(s2)
                  lhu          t3, -244(t1)
                  lbu          s9, -769(a3)
                  lbu          s7, 944(s6)
                  lbu          a4, 169(s2) #end load_store_instr_stream_2
                  lbu          a4, 104(a3) #end load_store_instr_stream_1
                  lbu          a1, 1227(s6) #end load_store_instr_stream_4
                  sb           t3, -71(t1) #end load_store_instr_stream_0
                  addi         s8, zero, 6 #init loop 1 counter
                  slt          ra, a6, t6
                  slti         t5, a6, -545
                  srl          t2, s4, s6
                  addi         s4, zero, -14 #init loop 1 limit
                  slti         s6, t4, 1557
                  csrrci       s3, 0x300, 0
                  mulh         t0, a1, a6
                  or           t2, sp, a7
                  nop
main_213_1_t:     add          t5, a4, s4
                  sltiu        s6, s7, -616
                  mul          a4, a6, s6
                  csrrwi       a1, 0x304, 31
                  addi         gp, a2, 720
                  addi         s8, s8, -2 #update loop 1 counter
                  addi         a2, zero, 3 #init loop 0 counter
                  addi         s7, zero, 10 #init loop 0 limit
                  csrrwi       a6, 0x343, 7
                  add          a1, gp, s1
                  rem          t1, a7, s5
main_213_0_t:     and          s11, s4, tp
                  addi         a2, a2, 7 #update loop 0 counter
                  andi         t1, s1, -212
                  beq          a2, s7, main_213_0_t #branch for loop 0
                  nop
                  lui          a3, 487763
                  rem          s0, t1, t2
                  csrrsi       ra, 0x305, 0
                  mul          a6, a3, a7
                  beq          s8, s4, main_213_1_t #branch for loop 1
                  mulhu        s1, t4, s10
                  la           s8, region_0+911 #start riscv_load_store_rand_instr_stream_18
                  andi         a7, t5, 1435
                  csrrs        ra, 0x343, zero
                  lb           zero, -8(s8)
                  addi         a7, gp, 734
                  rem          t5, t6, t4
                  lbu          t0, -238(s8)
                  div          a6, a3, s2
                  sb           a1, 142(s8)
                  lbu          s11, 190(s8)
                  sb           a4, 182(s8)
                  auipc        a5, 404648
                  sll          s11, a1, t1
                  sb           s2, -132(s8)
                  or           t1, s10, s1
                  srli         s7, s9, 23
                  sb           t1, 105(s8)
                  csrrci       a5, 0x300, 0
                  srli         s10, a4, 5
                  lbu          s7, 73(s8)
                  csrrwi       s10, 0x344, 24
                  lbu          s9, -186(s8)
                  srai         s6, a1, 15
                  lbu          a7, -72(s8)
                  csrrsi       s2, 0x343, 0
                  and          s10, zero, s3
                  lhu          t2, -7(s8)
                  srai         s11, s4, 29
                  slti         a4, s6, -60
                  csrrw        a6, 0x342, gp
                  lbu          a3, 126(s8)
                  lw           a3, -211(s8)
                  srai         s7, ra, 18
                  lbu          a5, -5(s8)
                  sb           s8, 204(s8)
                  ori          s5, s9, 881
                  sb           s7, -190(s8)
                  lbu          s10, -143(s8)
                  sb           s0, -65(s8)
                  csrrci       s9, 0x301, 27
                  addi         s1, t4, -1310
                  lb           ra, 200(s8)
                  lb           t1, 44(s8)
                  sb           s8, -149(s8)
                  lh           s1, 1(s8)
                  or           s2, t3, a4
                  lb           t1, 231(s8)
                  rem          s11, a0, a1
                  and          a6, a5, t4
                  remu         a1, s1, s1
                  srai         s5, t4, 0
                  mulhu        s4, s7, s11
                  xor          s9, s1, s9
                  rem          s2, ra, t0
                  sh           a2, -145(s8)
                  lh           zero, -35(s8) #end riscv_load_store_rand_instr_stream_18
                  la           a2, region_0+2068 #start load_store_instr_stream_1
                  lhu          a3, 710(a2)
                  la           a4, region_1+6430 #start load_store_instr_stream_0
                  lhu          s9, -1730(a2)
                  lb           t3, -1989(a2)
                  sb           gp, -16(a4)
                  lb           s1, -111(a4)
                  lb           t0, 225(a2)
                  lhu          a1, 824(a2)
                  lb           t1, -926(a2)
                  lbu          ra, -164(a4)
                  sb           a0, 251(a2)
                  lbu          t4, 267(a2)
                  sw           t0, 70(a4)
                  lb           a6, -424(a2) #end load_store_instr_stream_1
                  lbu          zero, -148(a4)
                  lb           a1, -94(a4) #end load_store_instr_stream_0
                  la           s6, region_0+460 #start load_store_instr_stream_0
                  lb           t0, -8(s6)
                  lbu          t6, -16(s6)
                  la           a1, region_1+51113 #start load_store_instr_stream_1
                  lbu          s3, 14(a1)
                  lb           a3, 16(s6)
                  sh           t6, -2(s6)
                  lb           a5, -15(a1)
                  sb           t6, 2(s6)
                  sb           s5, -4(a1)
                  lbu          s5, 10(s6)
                  lb           t6, 3(s6)
                  lhu          s2, -7(a1)
                  sb           s8, 14(a1)
                  lb           t0, 15(a1) #end load_store_instr_stream_1
                  lb           a6, 11(s6) #end load_store_instr_stream_0
                  li           s0, 0x80000000 #start riscv_int_numeric_corner_stream_39
                  li           a1, 0x7700b5cd
                  li           s11, 0x6fd3b6c6
                  li           t4, 0x80000000
                  li           t2, 0x80000000
                  li           a3, 0xffffffff
                  li           t3, 0xb907f12b
                  li           s7, 0xa542429e
                  li           a6, 0x80000000
                  li           s10, 0x2501425
                  mul          s7, s0, t2
                  addi         s10, a3, -1289
                  mulh         t4, t3, s7
                  addi         a3, t3, 1589
                  add          s10, t3, s11
                  divu         s10, s0, a6
                  remu         a6, s7, a1
                  mul          a6, a3, a6
                  add          s10, a6, s11
                  divu         t2, s11, s11
                  mulhsu       s7, a3, s0
                  rem          t4, a3, s7
                  add          a1, t3, s10
                  mulhsu       t4, s0, a3
                  add          a1, t4, t2
                  mulh         s0, s7, s10
                  nop
                  mulhsu       s11, s7, t3
                  addi         s10, t3, 897
                  addi         a3, t4, 635
                  mul          s7, a3, s0
                  auipc        t4, 970319
                  auipc        s11, 464487
                  sub          s10, a1, a6
                  nop
                  rem          s7, s11, s11
                  rem          s11, t4, a3 #end riscv_int_numeric_corner_stream_39
                  la           t3, region_1+9448 #start load_store_instr_stream_1
                  lb           s2, 7(t3)
                  la           a2, region_0+1177 #start load_store_instr_stream_0
                  lbu          s11, -5(t3)
                  sh           a1, 301(a2)
                  lhu          s5, -6(t3)
                  lbu          s9, 6(t3)
                  lb           s7, 11(t3)
                  sb           a2, -938(a2)
                  lb           t2, -9(t3)
                  lh           a7, -171(a2)
                  sb           gp, 2(t3)
                  lbu          t0, -410(a2)
                  lhu          a5, -8(t3)
                  lb           a6, -5(t3)
                  lbu          gp, -173(a2)
                  sb           t1, 1(t3) #end load_store_instr_stream_1
                  sh           s2, 1955(a2) #end load_store_instr_stream_0
                  la           a6, region_1+30012 #start riscv_load_store_hazard_instr_stream_25
                  csrrci       a3, 0x343, 0
                  lb           t6, 431(a6)
                  lb           s4, 431(a6)
                  lbu          s0, 431(a6)
                  lbu          s8, 343(a6)
                  sb           t0, -1099(a6)
                  auipc        s3, 51020
                  sb           t1, -1099(a6)
                  srli         t3, t3, 1
                  sb           s5, 1414(a6)
                  sh           s4, 1414(a6)
                  sb           zero, -1770(a6)
                  lh           s0, -1770(a6)
                  lbu          s0, 530(a6)
                  sb           zero, -1273(a6)
                  lh           a1, -260(a6)
                  sltiu        t3, a0, 1673
                  sb           a3, 257(a6)
                  lb           a1, -1605(a6)
                  sh           s0, 1338(a6)
                  srai         t4, a1, 27
                  sb           a6, 1338(a6)
                  sh           t2, 522(a6)
                  lhu          s3, 522(a6)
                  sh           s9, -1850(a6) #end riscv_load_store_hazard_instr_stream_25
                  li           ra, 0x80000000 #start riscv_int_numeric_corner_stream_34
                  li           s8, 0x0
                  li           s9, 0xffffffff
                  li           t3, 0x0
                  li           t1, 0x113ee522
                  li           s0, 0x80000000
                  li           gp, 0xffffffff
                  li           s7, 0x53831ef
                  li           s11, 0x80000000
                  li           t5, 0x0
                  nop
                  auipc        t5, 466182
                  sub          s7, s0, s8
                  add          t1, ra, s11
                  rem          t5, s9, gp
                  mulh         t3, ra, s9
                  remu         gp, t5, s0
                  addi         t5, t5, 280
                  nop
                  div          gp, gp, s0
                  rem          s9, t3, s0
                  mulh         t3, s7, t3
                  rem          s8, s9, ra
                  mulh         t1, gp, s8
                  addi         t5, gp, 2039
                  remu         t1, s8, s9
                  nop
                  sub          s0, ra, t5
                  mulh         s9, gp, s8
                  addi         t3, s0, 479
                  mulhu        s0, gp, ra
                  rem          s9, s8, s7 #end riscv_int_numeric_corner_stream_34
                  la           s1, region_1+5032 #start load_store_instr_stream_0
                  la           a2, region_1+13848 #start load_store_instr_stream_4
                  la           s9, region_1+47956 #start load_store_instr_stream_2
                  la           t0, region_1+55235 #start load_store_instr_stream_1
                  sb           t1, 50(s9)
                  la           s6, region_1+48724 #start load_store_instr_stream_3
                  lb           a7, -38(s9)
                  lb           a6, 12(s9)
                  lhu          s11, 0(s6)
                  lhu          a3, 4(s6)
                  sb           sp, 5(t0)
                  sb           s10, -11(t0)
                  lb           t5, 16(s6)
                  lbu          a1, -1571(a2)
                  sb           a2, 2005(a2)
                  sb           s4, 1753(s1)
                  lb           s4, -10(t0)
                  lh           a6, 1764(s1)
                  lh           zero, -56(s9)
                  lbu          s5, 1116(s1)
                  sh           s1, -14(s6)
                  lb           s7, 766(a2)
                  sh           sp, 1138(a2)
                  sb           t6, 13(s9)
                  sh           s7, 834(s1)
                  lb           s10, -10(s6)
                  sw           a2, 13(t0)
                  lbu          s5, -1593(s1)
                  lb           a5, 3(t0)
                  sb           t4, -5(t0)
                  sh           ra, 1978(s1)
                  sb           s4, -63(s9)
                  sb           a2, 13(s6)
                  lbu          a6, 3(s9) #end load_store_instr_stream_2
                  lbu          ra, 3(t0)
                  lb           s11, 9(s6)
                  lb           t5, -1839(s1)
                  lw           gp, 4(s6)
                  sb           t1, -7(t0)
                  lbu          s5, 645(a2)
                  lb           t6, -6(t0) #end load_store_instr_stream_1
                  lbu          s0, 259(a2)
                  sh           t5, -14(s6) #end load_store_instr_stream_3
                  sb           s3, -1646(a2) #end load_store_instr_stream_4
                  sb           s2, -1465(s1) #end load_store_instr_stream_0
                  addi         t4, zero, 5 #init loop 1 counter
                  addi         ra, zero, 1 #init loop 1 limit
main_232_1_t:     mulh         a3, t4, t6
                  addi         t4, t4, -1 #update loop 1 counter
                  addi         a6, zero, -10 #init loop 0 counter
                  addi         s6, zero, -4 #init loop 0 limit
                  xor          t0, a3, s2
main_232_0_t:     slt          s3, a1, s5
                  addi         a6, a6, 2 #update loop 0 counter
                  bne          a6, s6, main_232_0_t #branch for loop 0
                  bne          t4, ra, main_232_1_t #branch for loop 1
                  csrrw        t2, 0x342, t6
                  la           a6, region_0+2702 #start load_store_instr_stream_1
                  la           s2, region_1+37543 #start load_store_instr_stream_0
                  lb           a5, 229(a6)
                  sb           a1, 231(a6)
                  lbu          a3, -6(s2)
                  lhu          ra, 188(a6)
                  lbu          a5, 100(s2)
                  lh           a3, 229(s2)
                  lbu          gp, 23(a6)
                  lbu          a1, -207(a6)
                  lbu          s10, -51(s2)
                  sb           s3, 83(a6)
                  lh           s8, -105(s2)
                  sw           s10, 154(a6)
                  lbu          s5, -203(a6) #end load_store_instr_stream_1
                  sb           ra, -84(s2) #end load_store_instr_stream_0
                  la           a3, region_1+53278 #start load_store_instr_stream_0
                  lb           s3, 13(a3)
                  la           t6, region_0+2358 #start load_store_instr_stream_1
                  lb           t1, -15(a3)
                  lb           s3, 15(a3)
                  lb           ra, 11(t6)
                  lbu          a4, -13(a3)
                  lb           s4, 13(t6)
                  lb           s5, 11(a3)
                  lbu          s4, -4(t6)
                  lbu          a4, -8(a3)
                  lhu          s2, -14(t6)
                  lbu          s1, -15(a3)
                  sh           s10, 10(t6) #end load_store_instr_stream_1
                  lh           t2, 12(a3)
                  sh           t1, 0(a3)
                  lbu          t5, -11(a3) #end load_store_instr_stream_0
                  la           t6, region_1+36887 #start load_store_instr_stream_0
                  la           gp, region_1+34462 #start load_store_instr_stream_1
                  sw           a6, 193(t6)
                  lbu          t3, -9(gp)
                  lh           t3, -113(t6)
                  lb           t3, 197(t6)
                  lb           t5, -210(t6)
                  sb           a1, 241(t6)
                  lh           t3, 139(t6)
                  lhu          a4, 36(gp)
                  lbu          s11, 29(gp)
                  lbu          s10, 170(t6)
                  sh           s1, 103(t6)
                  lb           s8, 43(gp)
                  sb           a1, 146(t6)
                  sb           a4, 49(gp) #end load_store_instr_stream_1
                  lbu          zero, 22(t6) #end load_store_instr_stream_0
                  la           a4, region_0+2038 #start load_store_instr_stream_0
                  lhu          t1, 8(a4)
                  lb           s0, -8(a4)
                  sh           t1, 8(a4)
                  la           s7, region_1+64799 #start load_store_instr_stream_1
                  sw           s4, -11(s7)
                  lb           t5, -12(a4)
                  lbu          s0, 6(s7)
                  lb           a5, 3(s7)
                  lbu          a5, -3(a4)
                  lhu          zero, -1(s7)
                  lbu          s8, 1(a4)
                  sh           zero, 15(s7)
                  lb           t1, 8(s7)
                  lhu          a6, 12(a4)
                  lw           t3, 13(s7) #end load_store_instr_stream_1
                  lbu          a3, 8(a4) #end load_store_instr_stream_0
                  la           t2, region_1+29012 #start riscv_hazard_instr_stream_2
                  csrrwi       ra, 0x301, 23
                  srl          s10, ra, a4
                  csrrsi       zero, 0x343, 0
                  ori          t4, s10, -2019
                  lbu          ra, 45(t2)
                  or           t0, t4, s10
                  andi         ra, t4, -1482
                  lh           a4, 468(t2)
                  csrrc        ra, 0x301, ra
                  mulhsu       s10, a4, t0
                  sw           ra, 1216(t2)
                  lbu          ra, 1908(t2)
                  lbu          ra, -1262(t2)
                  div          a4, zero, a4
                  csrrwi       t4, 0x301, 28
                  sw           zero, -164(t2)
                  sb           t4, 1489(t2)
                  csrrs        t0, 0x342, zero
                  lb           zero, -1111(t2)
                  mulhu        ra, zero, ra
                  lh           zero, -42(t2)
                  lh           s10, -1598(t2)
                  or           t4, s10, a4
                  or           t4, zero, s10
                  lbu          t0, -38(t2)
                  lui          zero, 543457
                  sb           s10, 241(t2)
                  divu         zero, t0, t0
                  mul          s10, zero, s10
                  lb           ra, -983(t2)
                  csrrsi       t4, 0x342, 0
                  lb           zero, 1173(t2)
                  lh           ra, 610(t2)
                  sra          s10, zero, s10
                  csrrc        s10, 0x305, zero
                  mulh         t4, zero, a4
                  lbu          ra, 1491(t2)
                  div          s10, a4, ra
                  sb           ra, 777(t2)
                  lbu          a4, -1862(t2)
                  lb           t4, -231(t2)
                  sra          s10, t4, t0
                  add          ra, a4, zero
                  remu         ra, a4, t0
                  sb           t0, 1320(t2)
                  andi         ra, t0, 67
                  lb           zero, -1698(t2)
                  mulhsu       zero, a4, a4
                  lhu          a4, -1390(t2)
                  csrrs        zero, 0x300, zero
                  sb           a4, 849(t2) #end riscv_hazard_instr_stream_2
main_81:          jal          ra, 24f
0:                jal          ra, 1f
1:                jal          s7, 25f
2:                jal          s6, 16f
3:                jal          ra, 8f
4:                jal          s5, 23f
5:                jal          t1, 0b
6:                jal          t1, 7f
7:                jal          ra, 10f
8:                jal          ra, 17f
9:                jal          ra, 20f
10:               jal          t3, 4b
11:               jal          t1, 2b
12:               jal          t1, 19f
13:               jal          ra, 18f
14:               jal          ra, 5b
15:               jal          a6, 13b
16:               jal          ra, 14b
17:               jal          t1, 15b
18:               jal          a1, 22f
19:               jal          ra, 9b
20:               jal          ra, 3b
21:               jal          t0, 12b
22:               jal          t1, 11b
23:               jal          s1, 21b
24:               jal          ra, 6b
25:               slti         t0, a2, 1229
                  la           a6, region_0+821 #start riscv_load_store_hazard_instr_stream_8
                  lbu          ra, 622(a6)
                  and          s1, t6, s3
                  addi         s11, a7, -1632
                  sb           a5, 622(a6)
                  lb           s4, 622(a6)
                  csrrwi       zero, 0x301, 17
                  sb           t4, 622(a6)
                  add          s0, t0, s4
                  lb           t5, 622(a6)
                  lb           s5, 622(a6)
                  lb           s9, 622(a6)
                  lb           t5, 622(a6)
                  sb           sp, 622(a6)
                  remu         s0, t6, a5
                  lb           a1, 161(a6)
                  lh           a1, 161(a6)
                  lb           a7, 161(a6) #end riscv_load_store_hazard_instr_stream_8
                  la           s2, region_0+3941 #start riscv_hazard_instr_stream_16
                  addi         zero, s10, -1409
                  lbu          t0, -152(s2)
                  nop
                  slt          t1, zero, t1
                  lb           s10, -46(s2)
                  sltiu        s10, s8, -405
                  divu         s8, s10, zero
                  csrrs        s1, 0x304, zero
                  sb           t1, 104(s2)
                  lb           s10, 40(s2)
                  lb           t1, -49(s2)
                  mul          zero, t0, s10
                  csrrs        s8, 0x301, zero
                  csrrc        t0, 0x304, s10
                  divu         t0, s10, s10
                  lui          s1, 747413
                  andi         s8, t1, -428
                  csrrsi       t1, 0x342, 0
                  csrrc        zero, 0x301, zero
                  addi         t1, zero, 929
                  slt          s8, s1, s1
                  csrrs        s10, 0x342, zero
                  sltiu        s1, s8, -2035
                  sb           s8, -188(s2)
                  lb           s10, -200(s2)
                  lbu          s10, -222(s2)
                  lhu          s1, 69(s2)
                  srai         t0, zero, 12
                  csrrsi       zero, 0x300, 0
                  lhu          s8, -219(s2)
                  sb           zero, 42(s2)
                  remu         zero, zero, s8
                  remu         s1, s1, s10
                  lb           t0, -151(s2)
                  mulh         t0, s1, t0
                  mul          t0, s8, t1
                  and          t1, t0, t1
                  lw           s1, -133(s2)
                  sb           s10, -118(s2)
                  lui          zero, 693197
                  sb           t1, -62(s2) #end riscv_hazard_instr_stream_16
                  la           s7, region_0+2191 #start load_store_instr_stream_1
                  la           t2, region_1+2343 #start load_store_instr_stream_0
                  lw           t5, -3(t2)
                  lb           s11, -12(t2)
                  lb           ra, 364(s7)
                  lb           a2, 2(t2)
                  lb           s2, 434(s7)
                  sb           s10, 6(t2)
                  lbu          t1, 4(t2)
                  lbu          s6, 0(t2)
                  sh           s5, -1287(s7)
                  sb           a4, 1219(s7)
                  sb           a1, -2(t2)
                  lbu          s11, -1166(s7) #end load_store_instr_stream_1
                  lbu          a6, 6(t2) #end load_store_instr_stream_0
                  la           t6, region_0+1359 #start riscv_load_store_hazard_instr_stream_20
                  lbu          t1, 20(t6)
                  lb           gp, 20(t6)
                  sb           t5, 20(t6)
                  lhu          a7, 1(t6)
                  remu         s6, s0, a5
                  sb           s1, 1(t6)
                  lbu          t2, 1(t6)
                  sh           t5, 1(t6)
                  addi         gp, s8, -1074
                  sb           s3, -40(t6)
                  sh           t2, 7(t6)
                  lh           s4, 27(t6)
                  lhu          gp, 27(t6)
                  lhu          s5, 27(t6)
                  lhu          s7, 9(t6)
                  srli         s0, s2, 6
                  lhu          t3, 9(t6)
                  lh           s7, 17(t6)
                  lh           s5, 17(t6)
                  lbu          s0, -45(t6)
                  sb           sp, -45(t6)
                  lh           a5, -45(t6)
                  lh           t0, -45(t6) #end riscv_load_store_hazard_instr_stream_20
                  addi         ra, zero, -8 #init loop 1 counter
                  addi         t3, zero, 7 #init loop 1 limit
                  mul          s8, s11, t6
main_210_1_t:     add          a5, gp, ra
                  divu         a5, s6, s9
                  sltu         s3, a2, a5
                  addi         ra, ra, 6 #update loop 1 counter
                  addi         a6, zero, 4 #init loop 0 counter
                  addi         s1, zero, 16 #init loop 0 limit
                  ori          s3, s5, -1156
                  slti         s4, a5, -352
main_210_0_t:     auipc        s11, 492148
                  sltiu        s8, t1, 1661
                  xor          gp, sp, a1
                  sub          s0, s9, t6
                  slt          t2, s10, s9
                  addi         a6, a6, 7 #update loop 0 counter
                  blt          a6, s1, main_210_0_t #branch for loop 0
                  slt          a3, t0, s6
                  blt          ra, t3, main_210_1_t #branch for loop 1
                  remu         s3, t5, a6
                  li           t0, 0x0 #start riscv_int_numeric_corner_stream_32
                  li           a6, 0x80000000
                  li           s3, 0x80000000
                  li           s0, 0x80000000
                  li           a7, 0x0
                  li           a4, 0x0
                  li           t1, 0x0
                  li           t5, 0xffffffff
                  li           a5, 0x80000000
                  li           s5, 0x0
                  nop
                  rem          s3, s3, t1
                  sub          t5, t0, a5
                  auipc        t1, 126437
                  lui          s0, 74555
                  mul          s5, s5, s0
                  mulhu        a5, a7, t5
                  div          a5, a6, t5
                  divu         a5, s0, a6
                  mul          s0, s3, t1
                  add          a6, t1, t5
                  mulh         s3, t0, a6
                  mulh         a4, t0, s3
                  mul          a5, s5, s0
                  div          t0, a6, t0
                  mulhsu       a4, a6, s0
                  add          a7, a6, t0
                  sub          a4, t5, s0
                  remu         a7, a4, a6
                  div          a4, t0, t1
                  lui          t5, 408438
                  mulhu        a7, s0, s0
                  divu         t5, a5, s5 #end riscv_int_numeric_corner_stream_32
                  la           ra, region_1+32297 #start riscv_load_store_hazard_instr_stream_15
                  sw           gp, -5(ra)
                  sh           ra, 33(ra)
                  sh           s0, 33(ra)
                  and          s6, a3, s3
                  lbu          s10, -31(ra)
                  lhu          t1, -19(ra)
                  sb           a1, -19(ra)
                  lb           a4, 33(ra)
                  lhu          t5, 33(ra)
                  lh           zero, 33(ra)
                  lhu          s10, 33(ra)
                  lh           t3, 33(ra)
                  sb           a7, 33(ra)
                  lh           gp, 33(ra)
                  lbu          t4, -56(ra)
                  lbu          s8, -56(ra)
                  csrrc        s11, 0x342, zero
                  sb           s11, -56(ra)
                  lbu          s6, -56(ra)
                  lbu          s0, -56(ra)
                  sb           s4, -56(ra)
                  sb           s8, -56(ra) #end riscv_load_store_hazard_instr_stream_15
                  la           t1, region_1+2955 #start load_store_instr_stream_3
                  la           a3, region_1+41308 #start load_store_instr_stream_4
                  la           s8, region_1+34348 #start load_store_instr_stream_1
                  sb           gp, 30(t1)
                  la           s2, region_1+59131 #start load_store_instr_stream_2
                  lb           ra, -169(s8)
                  sb           s11, 11(a3)
                  sb           t4, 59(t1)
                  la           t4, region_1+29105 #start load_store_instr_stream_0
                  lbu          s5, -179(s8)
                  sb           t1, -102(t1)
                  lbu          s6, -16(t4)
                  lb           ra, 158(t1)
                  sb           zero, -39(a3)
                  lw           a7, 15(t4)
                  lb           t6, 67(t1)
                  lbu          t6, 119(s8)
                  sb           tp, -742(s2)
                  lbu          a2, -249(s8)
                  lbu          s7, -175(t1)
                  lbu          t5, -243(s8)
                  lb           zero, -9(s8)
                  lb           s11, -1442(s2)
                  lbu          t3, -14(t4)
                  lb           t3, 33(a3)
                  sb           t4, -253(s8)
                  lhu          s1, -3(t4)
                  lbu          s10, 1(a3)
                  sh           a5, -16(s8)
                  sb           s8, -204(s2)
                  lhu          t6, 32(a3)
                  sb           t0, 128(t1)
                  lb           s0, 70(t1)
                  lhu          a2, 108(s8) #end load_store_instr_stream_1
                  sw           s6, -32(a3)
                  sw           sp, 1761(s2)
                  sb           a1, 16(t4)
                  lb           s1, -838(s2) #end load_store_instr_stream_2
                  sb           s9, 146(t1)
                  lb           s11, 48(a3)
                  lh           s9, 231(t1) #end load_store_instr_stream_3
                  sb           a0, -2(t4)
                  lb           s3, 33(a3) #end load_store_instr_stream_4
                  sb           a3, 6(t4) #end load_store_instr_stream_0
                  la           s10, region_0+1792 #start load_store_instr_stream_0
                  la           t2, region_1+45312 #start load_store_instr_stream_1
                  lhu          a1, 752(s10)
                  sb           s0, 3(t2)
                  lbu          t6, -487(s10)
                  lh           t3, -8(t2)
                  lb           t5, -6(t2)
                  sb           ra, 1958(s10)
                  lb           s11, -2(t2)
                  lb           s6, -1079(s10)
                  lh           a1, 6(t2)
                  sb           s6, -9(t2)
                  lb           s7, 5(t2) #end load_store_instr_stream_1
                  lb           s9, -336(s10) #end load_store_instr_stream_0
                  la           a5, region_0+1693 #start riscv_hazard_instr_stream_31
                  lh           ra, 49(a5)
                  sra          s1, s1, a7
                  srl          s1, s7, a7
                  lb           ra, -5(a5)
                  slt          s7, a7, a7
                  lw           a7, -49(a5)
                  xori         ra, s7, -1426
                  lhu          a7, 49(a5)
                  mulh         s1, s7, a4
                  lbu          s7, -7(a5)
                  lbu          s1, -28(a5)
                  lbu          a2, -34(a5)
                  mulhu        a4, s1, ra
                  sb           a7, 46(a5)
                  lhu          s7, 43(a5)
                  lb           s7, -39(a5)
                  sll          a2, ra, a4
                  lb           s1, 0(a5)
                  slli         a2, s7, 23
                  lb           a4, 38(a5)
                  add          a2, a2, a4
                  sb           a2, 61(a5)
                  lb           a4, -30(a5)
                  lb           a4, -12(a5)
                  mul          a4, s7, ra
                  lbu          s1, -52(a5)
                  lb           ra, -54(a5)
                  csrrci       a4, 0x305, 0
                  slti         ra, s7, 216
                  sb           s1, 28(a5)
                  lh           s1, 1(a5)
                  nop
                  lbu          s1, -46(a5)
                  mulhu        s7, a2, s1
                  sra          s1, a2, s1
                  sb           a7, 48(a5)
                  lbu          s1, -34(a5)
                  csrrw        s7, 0x342, a7
                  lh           a2, -19(a5)
                  sb           s7, 30(a5)
                  lui          ra, 901554
                  sw           a4, 55(a5)
                  lb           a4, 16(a5) #end riscv_hazard_instr_stream_31
                  la           a6, region_0+2902 #start riscv_hazard_instr_stream_38
                  and          zero, zero, t6
                  lbu          s2, -69(a6)
                  lb           zero, 252(a6)
                  sb           s2, -175(a6)
                  lbu          s11, -16(a6)
                  sltu         s11, s2, zero
                  lbu          s2, 139(a6)
                  lbu          t1, -33(a6)
                  sb           s11, -18(a6)
                  slt          s11, t1, t6
                  sh           s0, 198(a6)
                  lh           s0, 72(a6)
                  lbu          s11, 31(a6)
                  lw           s0, -62(a6)
                  lb           t1, -139(a6)
                  csrrc        t6, 0x304, t6
                  sb           s11, 150(a6)
                  lh           zero, 248(a6)
                  sb           t6, -203(a6)
                  lbu          s0, -236(a6)
                  or           t6, s11, t1
                  sltu         s11, s2, s0
                  sh           s2, -176(a6)
                  csrrc        s11, 0x344, t1
                  lb           zero, -84(a6)
                  lb           s11, -151(a6)
                  sw           t6, -254(a6)
                  sh           s2, 98(a6)
                  csrrsi       s0, 0x344, 0
                  lw           s0, 126(a6)
                  mulhu        s11, t1, zero
                  csrrsi       zero, 0x300, 0
                  mul          s2, s2, zero
                  lbu          t6, 183(a6)
                  sb           s11, 141(a6)
                  lb           zero, -57(a6)
                  sb           zero, 94(a6)
                  lbu          s2, -61(a6)
                  lb           s0, 247(a6) #end riscv_hazard_instr_stream_38
                  li           s8, 0xffffffff #start riscv_int_numeric_corner_stream_9
                  li           t1, 0x80000000
                  li           s9, 0x80000000
                  li           t4, 0x80000000
                  li           ra, 0x80000000
                  li           s5, 0x80000000
                  li           a2, 0xffffffff
                  li           t5, 0x0
                  li           a4, 0xffffffff
                  li           s7, 0xcb6c3cd
                  add          a4, t1, ra
                  remu         ra, s5, s5
                  auipc        s7, 500405
                  lui          a4, 124501
                  sub          t1, s5, t5
                  div          t1, s5, ra
                  mulhsu       s9, a2, s5
                  div          t4, ra, s8
                  lui          t1, 991089
                  mul          s7, ra, t5
                  mulhsu       ra, a2, ra
                  auipc        s7, 922944
                  mul          s9, s8, t4
                  addi         s5, s5, 942
                  add          t1, t4, s9
                  divu         ra, ra, ra #end riscv_int_numeric_corner_stream_9
                  addi         a2, zero, -6 #init loop 1 counter
                  mulh         zero, a3, s7
                  div          gp, a4, t4
                  addi         t4, zero, 20 #init loop 1 limit
main_238_1_t:     mulhsu       s2, gp, sp
                  csrrsi       a7, 0x343, 0
                  addi         a2, a2, 5 #update loop 1 counter
                  srli         a1, t4, 7
                  addi         ra, zero, -3 #init loop 0 counter
                  addi         a4, zero, -2 #init loop 0 limit
                  divu         s0, s11, t3
main_238_0_t:     xor          s8, s1, s9
                  addi         ra, ra, 5 #update loop 0 counter
                  blt          ra, a4, main_238_0_t #branch for loop 0
                  bltu         a2, t4, main_238_1_t #branch for loop 1
                  csrrwi       s5, 0x343, 30
                  addi         a2, zero, -3 #init loop 0 counter
                  rem          s2, t5, s9
                  slt          s5, s9, a2
                  addi         s11, a3, -640
                  addi         t4, zero, 6 #init loop 0 limit
                  csrrsi       ra, 0x305, 0
                  srai         s6, s0, 28
                  xori         s6, s2, 714
                  srai         a6, s6, 17
                  addi         t6, s8, 83
                  sub          t0, t1, t5
main_224_0_t:     and          s0, s10, tp
                  csrrc        s10, 0x304, zero
                  sltu         s2, a5, s10
                  addi         s6, a5, -1966
                  srai         s5, t5, 13
                  addi         a2, a2, 9 #update loop 0 counter
                  andi         s3, s1, -690
                  sll          s10, t1, s4
                  divu         s1, s7, t1
                  or           s1, zero, zero
                  bne          a2, t4, main_224_0_t #branch for loop 0
                  sltu         s4, gp, s3
                  li           s0, 0x80000000 #start riscv_int_numeric_corner_stream_36
                  li           t2, 0xffffffff
                  li           a4, 0xe38cf8f2
                  li           s2, 0x7b50dc7e
                  li           a5, 0x80000000
                  li           s10, 0xffffffff
                  li           t1, 0x80000000
                  li           s4, 0x80000000
                  li           s3, 0xffffffff
                  li           a7, 0xffffffff
                  remu         t1, s3, s3
                  remu         s4, a7, a7
                  sub          a7, t1, a5
                  lui          s2, 876043
                  sub          s0, t2, s0
                  nop
                  add          s3, t2, s3
                  remu         s0, a5, t2
                  remu         t2, s0, a7
                  nop
                  mulhsu       s3, a5, a7
                  addi         s4, a5, -1889
                  add          t1, s3, s4
                  mulhu        t1, t2, s3
                  remu         a7, s0, s10
                  mulh         s0, a5, s10
                  mulhu        s2, s10, s3
                  mulhu        t1, a5, a4
                  div          a5, s3, s0 #end riscv_int_numeric_corner_stream_36
                  li           t0, 0x4d70ef3c #start riscv_int_numeric_corner_stream_1
                  li           a6, 0x0
                  li           t6, 0x80000000
                  li           s3, 0xffffffff
                  li           s4, 0xffffffff
                  li           s5, 0x9d8b3a6b
                  li           a4, 0x80000000
                  li           t5, 0x0
                  li           a1, 0xffffffff
                  li           s1, 0xffffffff
                  auipc        t6, 698311
                  div          t5, s1, t5
                  mulh         a1, t0, s3
                  mulh         t5, a1, a4
                  mulh         s4, t0, s3
                  divu         s3, s1, s1
                  mulhu        a4, s5, s4
                  mulhu        a4, s3, s1
                  rem          t6, s4, s3
                  add          s5, t0, t5
                  mul          t5, t6, s5
                  mulh         t5, a1, s3
                  divu         s5, a6, a4
                  addi         s5, s4, -744
                  mulh         a6, s5, a6 #end riscv_int_numeric_corner_stream_1
                  la           a5, region_1+2812 #start riscv_load_store_hazard_instr_stream_34
                  lui          a2, 696511
                  lb           a6, 3(a5)
                  lb           s5, 3(a5)
                  lbu          a3, 3(a5)
                  lb           s4, 7(a5)
                  csrrwi       a6, 0x343, 0
                  sb           t1, 7(a5)
                  csrrwi       t5, 0x304, 28
                  lbu          a4, 7(a5)
                  lb           t4, 7(a5)
                  lb           a3, -1(a5)
                  slli         s7, s1, 31
                  mulh         a3, a6, ra
                  lb           s9, -1(a5)
                  lb           a6, -1(a5)
                  sub          s2, a3, a7
                  lbu          s11, -1(a5)
                  sb           s0, -1(a5)
                  lb           a7, -1(a5)
                  and          s0, t6, t4
                  sb           t0, -1(a5)
                  lb           s11, 13(a5) #end riscv_load_store_hazard_instr_stream_34
                  li           s3, 0x9f49a99d #start riscv_int_numeric_corner_stream_6
                  li           t6, 0x0
                  li           s8, 0x80000000
                  li           s10, 0xf4932ee
                  li           t3, 0x0
                  li           s5, 0x0
                  li           s1, 0xffffffff
                  li           s6, 0xffffffff
                  li           s2, 0x24a3c02f
                  li           t2, 0xa799e18e
                  add          s3, s1, s2
                  remu         s6, t2, s5
                  rem          s5, s1, s10
                  mul          s2, t2, s8
                  mul          t3, s8, s5
                  nop
                  sub          t3, s1, t3
                  remu         t2, s8, s10
                  remu         s2, s10, s6
                  add          t2, t2, s10
                  div          s1, s2, t3
                  sub          s3, s3, s6
                  auipc        s10, 994293
                  mulhu        s3, s1, s3
                  divu         s5, s8, t2
                  div          s8, t6, s3
                  rem          s6, s10, s3
                  mul          s2, s1, t2
                  remu         t6, s6, s6 #end riscv_int_numeric_corner_stream_6
main_102:         jal          ra, 16f
0:                jal          t0, 8f
1:                jal          ra, 11f
2:                jal          s6, 0b
3:                jal          t6, 15f
4:                jal          ra, 3b
5:                jal          ra, 2b
6:                jal          ra, 19f
7:                jal          ra, 10f
8:                jal          a2, 13f
9:                jal          t5, 17f
10:               jal          ra, 14f
11:               jal          ra, 9b
12:               jal          t1, 5b
13:               jal          ra, 6b
14:               jal          t4, 12b
15:               jal          s0, 7b
16:               jal          s4, 18f
17:               jal          s10, 4b
18:               jal          ra, 1b
19:               or           s0, gp, s8
                  addi         s5, zero, 8 #init loop 1 counter
                  addi         t2, zero, 17 #init loop 1 limit
main_231_1_t:     sub          s0, a2, a6
                  addi         s5, s5, 7 #update loop 1 counter
                  or           s8, t6, a2
                  addi         s9, zero, -2 #init loop 0 counter
                  slli         a6, s4, 28
                  addi         s4, zero, -4 #init loop 0 limit
main_231_0_t:     sub          t0, ra, zero
                  addi         s9, s9, -1 #update loop 0 counter
                  bge          s9, s4, main_231_0_t #branch for loop 0
                  bltu         s5, t2, main_231_1_t #branch for loop 1
                  rem          s3, a0, t4
                  la           s9, region_1+32056 #start load_store_instr_stream_1
                  la           a3, region_0+3587 #start load_store_instr_stream_0
                  lbu          s7, 3(a3)
                  sb           s0, 654(s9)
                  sb           s8, 11(a3)
                  lh           s11, 478(s9)
                  lbu          s1, -33(a3)
                  lbu          gp, -1835(s9)
                  lh           a7, -1454(s9)
                  sh           s11, 17(a3)
                  lw           ra, 1348(s9) #end load_store_instr_stream_1
                  lb           s8, -53(a3) #end load_store_instr_stream_0
                  la           ra, region_1+17076 #start riscv_load_store_rand_instr_stream_6
                  xor          s0, s1, s1
                  ori          s11, s5, -755
                  lbu          s7, 1699(ra)
                  sh           a6, -1014(ra)
                  sll          gp, ra, s4
                  slti         gp, t3, -135
                  lhu          a7, 548(ra)
                  addi         a2, a3, -1474
                  lbu          a7, -1677(ra)
                  sb           s10, 1203(ra)
                  sll          s0, s0, s3
                  csrrci       t0, 0x344, 0
                  slli         s11, t6, 28
                  csrrc        t2, 0x305, zero
                  sub          t0, ra, sp
                  lhu          s3, 262(ra)
                  or           t4, t3, s5
                  lb           a6, 1293(ra)
                  lb           a4, 1029(ra)
                  ori          t2, sp, -1655
                  lb           t4, -631(ra)
                  sub          s0, sp, tp
                  add          s2, t4, s5
                  lbu          s3, -1922(ra)
                  sw           t4, -1904(ra)
                  sltiu        a1, zero, 369
                  add          s8, t6, s0
                  lbu          t6, 913(ra)
                  sb           s10, -211(ra)
                  nop
                  and          s11, s11, a0
                  lhu          s3, 802(ra)
                  sw           s9, -380(ra)
                  lbu          s8, 573(ra)
                  lbu          t0, -471(ra)
                  div          t2, t2, t4
                  or           s5, a0, ra
                  csrrsi       a2, 0x343, 20
                  mulh         s9, s0, s9
                  sll          s9, a5, a6
                  lhu          a6, 1540(ra)
                  sb           gp, -1284(ra)
                  or           t6, s2, s8
                  lb           s0, 259(ra)
                  lb           s4, -1929(ra)
                  lh           a6, -1506(ra)
                  lbu          t1, 525(ra)
                  srai         t5, a0, 13
                  lhu          a7, 826(ra)
                  csrrc        t3, 0x301, zero
                  sb           s6, -345(ra)
                  sltu         s3, s3, sp
                  lbu          s8, 407(ra)
                  csrrsi       a2, 0x304, 0
                  auipc        a4, 205165
                  sb           a7, 2023(ra) #end riscv_load_store_rand_instr_stream_6
                  addi         a1, zero, -5 #init loop 1 counter
                  mulh         s9, s7, s1
                  csrrci       s3, 0x305, 0
                  addi         s8, zero, -4 #init loop 1 limit
main_236_1_t:     divu         a4, s11, t2
                  addi         a1, a1, 10 #update loop 1 counter
                  srai         t3, s4, 30
                  mulhu        s7, a1, s9
                  addi         t6, zero, 6 #init loop 0 counter
                  addi         s4, zero, -6 #init loop 0 limit
                  srai         gp, s9, 15
                  sub          s5, a3, a0
main_236_0_t:     xori         s2, t5, 1834
                  csrrsi       t0, 0x301, 9
                  sra          s11, s2, s2
                  addi         t6, t6, -6 #update loop 0 counter
                  and          a5, t5, s9
                  beq          t6, s4, main_236_0_t #branch for loop 0
                  sub          s2, t4, s7
                  csrrs        zero, 0x301, t5
                  blt          a1, s8, main_236_1_t #branch for loop 1
                  mulhu        s6, zero, s10
                  la           a3, region_0+3624 #start riscv_hazard_instr_stream_10
                  sh           t4, -34(a3)
                  auipc        s11, 255160
                  lh           s11, 34(a3)
                  sh           a6, 2(a3)
                  mulh         zero, zero, a2
                  lb           s11, 36(a3)
                  sb           t4, -25(a3)
                  lhu          a6, 34(a3)
                  lw           s11, -4(a3)
                  sh           zero, 30(a3)
                  lbu          a2, 13(a3)
                  mulh         s11, zero, s11
                  xori         t4, t4, -632
                  csrrs        t3, 0x304, zero
                  lbu          t3, 38(a3)
                  lb           a2, -19(a3)
                  remu         zero, a6, s11
                  sh           a6, -20(a3)
                  ori          t4, zero, -904
                  ori          t3, a6, 2039
                  sh           zero, -58(a3)
                  lh           zero, 26(a3)
                  sb           t4, 40(a3)
                  sll          zero, zero, zero
                  lhu          a2, 34(a3)
                  lbu          s11, 58(a3)
                  lh           t3, -38(a3)
                  lb           t3, 2(a3)
                  sb           a6, -22(a3)
                  divu         a6, t3, s11
                  csrrwi       t4, 0x301, 14
                  lb           t3, 25(a3)
                  lbu          s11, -9(a3)
                  lbu          a2, 55(a3)
                  lbu          s11, -29(a3)
                  lbu          zero, 46(a3)
                  rem          s11, t4, a2
                  srl          t4, zero, a6
                  csrrci       t3, 0x305, 0
                  srai         s11, zero, 10
                  sb           zero, 43(a3)
                  srli         s11, zero, 6
                  lbu          t4, -7(a3)
                  csrrw        a6, 0x342, a2
                  sb           zero, -50(a3)
                  lb           a6, 54(a3) #end riscv_hazard_instr_stream_10
                  addi         s6, zero, -10 #init loop 1 counter
                  addi         s3, zero, -20 #init loop 1 limit
                  rem          a4, s9, t6
                  sll          t3, s0, ra
                  remu         a7, a2, s8
                  csrrw        s2, 0x344, a1
                  srai         gp, t5, 12
                  and          s1, s5, a0
                  sra          a5, s0, a7
main_225_1_t:     sltiu        s5, a0, 1592
                  addi         s6, s6, -10 #update loop 1 counter
                  and          s2, gp, t1
                  addi         s8, zero, 10 #init loop 0 counter
                  rem          s1, tp, t6
                  addi         s10, zero, 10 #init loop 0 limit
                  sub          t0, a7, zero
                  slli         t6, ra, 18
main_225_0_t:     andi         a4, a6, 1258
                  xori         a4, a5, -360
                  addi         s8, s8, -9 #update loop 0 counter
                  xori         ra, t0, 1256
                  bgeu         s8, s10, main_225_0_t #branch for loop 0
                  sub          a1, t1, s10
                  mulhu        a2, gp, a3
                  srli         ra, t1, 6
                  bne          s6, s3, main_225_1_t #branch for loop 1
                  and          s0, s2, s4
                  la           s9, region_1+46877 #start load_store_instr_stream_1
                  la           s3, region_0+2692 #start load_store_instr_stream_0
                  lb           s10, -2(s9)
                  sb           s3, 191(s3)
                  lh           s11, -246(s3)
                  lbu          ra, -20(s9)
                  sb           t2, -115(s3)
                  sh           s1, 3(s9)
                  lb           gp, 50(s9)
                  lb           zero, -30(s9)
                  lb           s10, -2(s3)
                  lbu          s8, -13(s9) #end load_store_instr_stream_1
                  lbu          s8, -67(s3) #end load_store_instr_stream_0
main_92:          jal          ra, 3f
0:                jal          t1, 22f
1:                jal          ra, 13f
2:                jal          ra, 9f
3:                jal          t1, 7f
4:                jal          t1, 24f
5:                jal          ra, 1b
6:                jal          ra, 23f
7:                jal          ra, 0b
8:                jal          ra, 10f
9:                jal          ra, 16f
10:               jal          t1, 6b
11:               jal          ra, 14f
12:               jal          ra, 4b
13:               jal          t0, 2b
14:               jal          ra, 20f
15:               jal          s7, 21f
16:               jal          ra, 15b
17:               jal          ra, 12b
18:               jal          ra, 17b
19:               jal          s1, 5b
20:               jal          t2, 25f
21:               jal          ra, 18b
22:               jal          ra, 8b
23:               jal          a1, 19b
24:               jal          t1, 11b
25:               jal          t1, 26f
26:               sltiu        t2, zero, -737
main_113:         jal          ra, 10f
0:                jal          ra, 8f
1:                jal          t1, 3f
2:                jal          s11, 0b
3:                jal          t0, 7f
4:                jal          ra, 6f
5:                jal          t0, 11f
6:                jal          ra, 2b
7:                jal          ra, 9f
8:                jal          t1, 1b
9:                jal          t4, 5b
10:               jal          s1, 4b
11:               sra          t1, s3, a1
                  la           s3, region_0+3629 #start load_store_instr_stream_1
                  sb           s3, -96(s3)
                  la           ra, region_1+20660 #start load_store_instr_stream_0
                  lb           s10, 228(s3)
                  lhu          t6, -12(ra)
                  lw           t3, 16(ra)
                  lbu          zero, -15(ra)
                  sw           ra, -33(s3)
                  lh           s1, 55(s3)
                  lb           gp, 15(ra)
                  sb           t1, -211(s3)
                  lbu          s4, -1(ra)
                  sb           a5, 7(ra)
                  lb           s2, -10(ra)
                  lbu          t1, -176(s3) #end load_store_instr_stream_1
                  lbu          s8, 10(ra)
                  sb           t0, 5(ra) #end load_store_instr_stream_0
                  la           a5, region_1+59579 #start riscv_hazard_instr_stream_25
                  lb           s9, 12(a5)
                  lb           s9, -46(a5)
                  lbu          a4, 4(a5)
                  sh           ra, 41(a5)
                  auipc        ra, 558066
                  lbu          a2, 46(a5)
                  lb           a7, -26(a5)
                  sh           t1, -47(a5)
                  lb           t1, -6(a5)
                  csrrs        t1, 0x304, s9
                  mulh         a7, t1, a4
                  sb           ra, -47(a5)
                  sb           s9, -32(a5)
                  lbu          t1, -26(a5)
                  csrrw        ra, 0x304, ra
                  slli         a7, s9, 27
                  lw           t1, -47(a5)
                  lb           a4, 17(a5)
                  slli         s9, t1, 1
                  sub          a4, a2, a7
                  or           a2, a4, t1
                  addi         a7, s9, 487
                  mulhsu       s9, a7, ra
                  or           a2, s9, ra
                  slti         a4, t1, -436
                  lbu          s9, 44(a5)
                  lb           ra, 18(a5)
                  slti         a4, a7, -588
                  sb           t1, -28(a5)
                  sb           a2, -10(a5)
                  sb           t1, -23(a5)
                  add          a2, a4, t1
                  sb           s9, -24(a5)
                  sb           a2, -6(a5)
                  lb           a4, -40(a5)
                  sb           a2, -60(a5)
                  srli         t1, ra, 22
                  nop
                  div          t1, a4, a7
                  sb           a7, -35(a5)
                  lb           ra, 4(a5)
                  sh           a7, -29(a5)
                  rem          s9, t1, s9
                  xor          ra, t1, a4
                  lh           a2, -39(a5)
                  csrrc        ra, 0x343, s9
                  nop
                  andi         a7, a2, 403
                  lbu          a4, -40(a5)
                  lb           s9, 24(a5)
                  sb           s9, -26(a5)
                  and          a7, a7, a7
                  lui          ra, 94439
                  sltiu        s9, a4, 1891
                  nop
                  remu         t1, a4, a2
                  lb           s9, -29(a5) #end riscv_hazard_instr_stream_25
                  li           a4, 0xffffffff #start riscv_int_numeric_corner_stream_7
                  li           s1, 0x85053fb6
                  li           t6, 0x0
                  li           s7, 0x533b7c46
                  li           s8, 0x12feced8
                  li           a6, 0xffffffff
                  li           t3, 0xffffffff
                  li           gp, 0x0
                  li           s6, 0x80000000
                  li           s9, 0xc02cdb0a
                  auipc        s1, 1039542
                  lui          gp, 809823
                  div          s6, s8, a4
                  nop
                  add          a4, s1, s6
                  nop
                  remu         s8, a4, s1
                  addi         gp, gp, -1474
                  divu         s9, a4, s1
                  rem          s9, s8, a4
                  mul          s9, a4, a4
                  addi         s1, t6, -371
                  remu         t6, t6, a6
                  addi         a6, a4, 1494
                  divu         s6, s9, s1
                  remu         s7, t3, gp
                  mulhsu       s9, a4, s6
                  lui          a6, 546783
                  rem          a6, s7, s8
                  add          gp, s7, s6
                  auipc        s1, 592978
                  addi         s7, s6, -157
                  add          t3, t6, t6
                  add          s1, t3, s8
                  auipc        a6, 129390 #end riscv_int_numeric_corner_stream_7
                  la           s5, region_1+19428 #start load_store_instr_stream_1
                  la           a5, region_1+60911 #start load_store_instr_stream_0
                  sh           sp, 50(s5)
                  lw           t6, -8(s5)
                  lh           t2, -15(a5)
                  lb           ra, 50(s5)
                  sb           s5, 9(s5)
                  lb           s1, -6(a5)
                  lb           t6, 6(a5)
                  lhu          t1, 18(s5)
                  lb           a3, 14(a5)
                  sb           t4, 17(s5) #end load_store_instr_stream_1
                  lbu          s11, 15(a5) #end load_store_instr_stream_0
                  la           a2, region_1+6791 #start riscv_hazard_instr_stream_21
                  and          a7, t6, gp
                  srli         t0, t6, 7
                  mul          gp, gp, t6
                  sra          a7, t6, a3
                  csrrci       a3, 0x342, 0
                  addi         t1, t6, 468
                  lbu          a7, 300(a2)
                  sb           t6, -1808(a2)
                  srli         t1, a3, 31
                  ori          t6, gp, 2024
                  lh           t6, -1665(a2)
                  lb           t1, 1279(a2)
                  sltu         t1, a3, t6
                  csrrci       gp, 0x301, 29
                  lb           t6, 49(a2)
                  sb           gp, 554(a2)
                  mulhsu       gp, t1, t1
                  lhu          a3, -1745(a2)
                  csrrwi       a3, 0x344, 29
                  xori         a3, t0, -264
                  sb           gp, -408(a2)
                  lb           t1, -1923(a2)
                  sub          a7, a7, a7
                  slli         gp, t0, 25
                  andi         t0, t1, -1060
                  lb           a3, -719(a2)
                  lw           t1, 1073(a2)
                  csrrc        t1, 0x344, a7
                  lb           t6, -600(a2)
                  lbu          a3, -658(a2)
                  lbu          t1, -600(a2)
                  lbu          t0, 138(a2)
                  csrrc        gp, 0x304, gp
                  lbu          t6, -1673(a2) #end riscv_hazard_instr_stream_21
                  la           s7, region_0+2249 #start riscv_load_store_hazard_instr_stream_33
                  lh           s1, 49(s7)
                  divu         t4, s3, t0
                  lhu          s11, 49(s7)
                  csrrwi       a7, 0x301, 29
                  lh           s10, 49(s7)
                  lbu          t2, 49(s7)
                  sh           s2, 49(s7)
                  lbu          ra, 49(s7)
                  lb           s3, -64(s7)
                  sb           s8, -64(s7)
                  srli         s0, t6, 31
                  lb           a4, 54(s7)
                  lbu          s0, 54(s7)
                  lb           s6, 54(s7)
                  lbu          a4, 54(s7) #end riscv_load_store_hazard_instr_stream_33
                  la           s5, region_0+2090 #start riscv_hazard_instr_stream_29
                  auipc        t6, 935864
                  sb           t6, -40(s5)
                  add          t2, zero, zero
                  lb           t6, 60(s5)
                  addi         t0, t6, 1449
                  slli         a4, t2, 16
                  lb           t0, -112(s5)
                  slt          s11, t0, t2
                  andi         t2, zero, -1001
                  divu         t0, t0, s11
                  lb           t0, 15(s5)
                  lw           t6, 182(s5)
                  sb           t0, -135(s5)
                  csrrci       t6, 0x301, 18
                  sltu         s11, t2, a4
                  lb           s11, -96(s5)
                  sub          t6, t2, zero
                  slt          t2, t2, a4
                  lh           zero, 102(s5)
                  sll          zero, t0, a4
                  srl          s11, s11, s11
                  sb           t6, -72(s5)
                  lbu          zero, -74(s5)
                  lh           t0, 90(s5)
                  div          zero, t6, zero
                  csrrs        s11, 0x304, zero
                  slti         t6, s11, -95
                  sb           t0, 163(s5)
                  xor          t2, t6, t2
                  lbu          t0, -246(s5)
                  mul          zero, t0, zero
                  sltu         t2, zero, t2
                  csrrw        t2, 0x343, a4
                  lbu          t0, -227(s5) #end riscv_hazard_instr_stream_29
                  li           t3, 0xd6515b65 #start riscv_int_numeric_corner_stream_14
                  li           s6, 0x9e3a1c2b
                  li           s7, 0x624c3c79
                  li           gp, 0x2010ad9e
                  li           a1, 0x80000000
                  li           t0, 0x80000000
                  li           a5, 0x0
                  li           s8, 0xffffffff
                  li           t1, 0x80000000
                  li           a3, 0x0
                  rem          s6, a3, s7
                  divu         s6, t1, t1
                  mulh         t1, t0, s6
                  nop
                  div          a1, s6, a5
                  auipc        t3, 742675
                  mul          gp, gp, gp
                  rem          a1, a5, s6
                  divu         t0, a1, t0
                  sub          gp, t0, a5
                  remu         a3, t3, s6
                  sub          s7, a1, a3
                  remu         a3, s7, s8
                  auipc        a3, 419593
                  rem          gp, s6, s8
                  nop
                  rem          t1, t1, a3
                  auipc        a3, 253294
                  auipc        t1, 367174 #end riscv_int_numeric_corner_stream_14
                  la           t4, region_1+13173 #start riscv_hazard_instr_stream_28
                  lbu          ra, 14(t4)
                  sh           ra, -45(t4)
                  auipc        s2, 90146
                  sb           ra, -41(t4)
                  lb           a5, 61(t4)
                  mul          s3, s1, s2
                  lw           s3, 43(t4)
                  sb           s2, 30(t4)
                  add          s2, s0, s0
                  lb           s3, -14(t4)
                  sb           ra, 46(t4)
                  ori          s0, ra, -668
                  lb           s0, -34(t4)
                  remu         s3, ra, s0
                  andi         a5, s3, -362
                  lbu          ra, -13(t4)
                  lbu          a5, -48(t4)
                  slt          s2, s3, s3
                  lb           s1, 42(t4)
                  lw           s3, 35(t4)
                  lbu          s3, 37(t4)
                  lbu          ra, 2(t4)
                  sw           s1, 31(t4)
                  lb           ra, -60(t4)
                  xor          ra, a5, s3
                  mulhsu       s0, ra, s0
                  lh           s0, 23(t4)
                  sb           s3, -52(t4)
                  srli         s1, s1, 16
                  slli         s1, s2, 13
                  nop
                  sb           s2, 33(t4)
                  lb           ra, -15(t4)
                  lbu          s2, 61(t4) #end riscv_hazard_instr_stream_28
main_84:          jal          ra, 0f
0:                jal          a6, 4f
1:                jal          s6, 15f
2:                jal          a1, 18f
3:                jal          s0, 8f
4:                jal          ra, 19f
5:                jal          ra, 10f
6:                jal          ra, 14f
7:                jal          ra, 3b
8:                jal          ra, 17f
9:                jal          t1, 11f
10:               jal          gp, 20f
11:               jal          t1, 13f
12:               jal          t1, 6b
13:               jal          ra, 12b
14:               jal          ra, 2b
15:               jal          ra, 5b
16:               jal          t1, 1b
17:               jal          ra, 16b
18:               jal          t1, 7b
19:               jal          ra, 9b
20:               nop
                  la           a3, region_0+82 #start load_store_instr_stream_0
                  lbu          t1, 148(a3)
                  la           a2, region_1+17699 #start load_store_instr_stream_1
                  lhu          s6, 172(a3)
                  lw           s10, -219(a2)
                  lh           a4, -85(a2)
                  sb           s0, 248(a3)
                  lw           a1, 165(a2)
                  lbu          a4, -11(a2)
                  lbu          s0, 240(a3)
                  sb           t1, -243(a2)
                  lbu          s10, 50(a2) #end load_store_instr_stream_1
                  lb           a6, -13(a3)
                  sb           a1, 185(a3)
                  lb           t0, 91(a3) #end load_store_instr_stream_0
                  la           a4, region_0+2995 #start load_store_instr_stream_1
                  la           ra, region_1+42843 #start load_store_instr_stream_0
                  sb           gp, 503(a4)
                  sb           s3, -1(ra)
                  lb           t3, -1020(a4)
                  lh           t0, -9(ra)
                  sw           a1, -1131(a4)
                  sb           ra, 3(ra)
                  sh           a0, -737(a4)
                  lbu          s7, -6(ra)
                  lb           s2, 68(a4)
                  sb           t6, -1476(a4)
                  lbu          t4, -10(ra)
                  sb           s1, 7(ra)
                  sb           gp, 590(a4)
                  lbu          a7, -1340(a4)
                  sw           t4, -3(ra)
                  sh           s8, -1129(a4)
                  lbu          s2, -12(ra)
                  sb           gp, -6(ra)
                  lbu          s10, -86(a4) #end load_store_instr_stream_1
                  lbu          gp, -4(ra) #end load_store_instr_stream_0
                  la           t2, region_0+2752 #start load_store_instr_stream_1
                  la           s11, region_1+23873 #start load_store_instr_stream_0
                  sh           s11, 634(t2)
                  lbu          a4, -71(s11)
                  sw           t3, 800(t2)
                  lbu          t3, 1240(t2)
                  sh           s10, 110(t2)
                  lbu          s0, -238(s11)
                  lbu          t6, -44(s11)
                  sb           a3, -692(t2)
                  lh           t1, -454(t2)
                  lbu          s10, 196(s11)
                  lbu          a6, -842(t2) #end load_store_instr_stream_1
                  lbu          a4, 148(s11)
                  lbu          s4, 36(s11) #end load_store_instr_stream_0
main_110:         jal          ra, 17f
0:                jal          ra, 2f
1:                jal          ra, 5f
2:                jal          ra, 22f
3:                jal          ra, 8f
4:                jal          ra, 27f
5:                jal          ra, 19f
6:                jal          t1, 7f
7:                jal          t1, 3b
8:                jal          ra, 18f
9:                jal          ra, 11f
10:               jal          ra, 26f
11:               jal          t1, 28f
12:               jal          t1, 23f
13:               jal          t1, 21f
14:               jal          ra, 13b
15:               jal          s0, 10b
16:               jal          ra, 14b
17:               jal          ra, 1b
18:               jal          ra, 12b
19:               jal          ra, 24f
20:               jal          ra, 29f
21:               jal          ra, 9b
22:               jal          s9, 16b
23:               jal          ra, 4b
24:               jal          ra, 0b
25:               jal          ra, 20b
26:               jal          ra, 6b
27:               jal          ra, 25b
28:               jal          ra, 15b
29:               csrrw        t3, 0x301, a7
                  la           s8, region_1+40202 #start riscv_load_store_rand_instr_stream_27
                  lbu          s5, -1225(s8)
                  sw           s0, 1574(s8)
                  slti         t1, a0, -1484
                  sb           a2, -909(s8)
                  lh           s10, -1490(s8)
                  srli         s3, a7, 16
                  sb           s6, 1918(s8)
                  lb           t4, -2041(s8)
                  mulh         a1, s2, s6
                  sb           t6, 13(s8)
                  mul          s1, a4, a2
                  and          s1, a6, sp
                  sub          s11, a7, s11
                  sh           s3, -220(s8)
                  csrrci       s2, 0x301, 0
                  lw           s10, -254(s8)
                  sh           a2, -604(s8)
                  sb           s11, 1725(s8)
                  lb           ra, -1477(s8)
                  sb           t0, 1098(s8)
                  lbu          a4, 1065(s8)
                  lb           zero, 1491(s8)
                  srli         t3, t0, 7
                  lbu          s6, 101(s8)
                  sh           a3, -1940(s8)
                  lhu          s10, 1602(s8)
                  lui          s10, 492260
                  sb           s9, -1695(s8)
                  lb           a1, -1693(s8)
                  lb           t4, 1836(s8)
                  lb           a4, -91(s8)
                  addi         a4, s0, -775
                  lb           a4, 2044(s8)
                  sb           a2, -1378(s8)
                  srai         s7, t4, 26
                  lbu          a6, -1105(s8) #end riscv_load_store_rand_instr_stream_27
                  la           s8, region_1+33137 #start riscv_hazard_instr_stream_22
                  lb           s6, -10(s8)
                  lbu          s2, 2(s8)
                  lb           s2, -14(s8)
                  lui          s5, 758702
                  add          s2, s5, s11
                  csrrc        t6, 0x301, a4
                  lb           s2, 2(s8)
                  andi         s11, s2, -1200
                  sb           s11, 6(s8)
                  lb           s6, 8(s8)
                  slti         s11, s5, -871
                  lb           s2, -15(s8)
                  csrrci       s6, 0x301, 28
                  andi         a4, s5, 1896
                  sw           s2, 15(s8)
                  divu         s6, t6, s5
                  lbu          s11, -8(s8)
                  lhu          s11, 1(s8)
                  lb           s11, -7(s8)
                  nop
                  sb           a4, -15(s8)
                  sb           s11, 6(s8)
                  lbu          a4, 10(s8)
                  sb           s6, 7(s8)
                  mulh         a4, s2, a4
                  lh           s6, 15(s8)
                  lbu          a4, 15(s8)
                  sh           s5, 1(s8)
                  lbu          s2, 2(s8) #end riscv_hazard_instr_stream_22
                  la           a3, region_1+41301 #start riscv_load_store_rand_instr_stream_9
                  mulhu        s11, a7, t4
                  lbu          s6, -11(a3)
                  lb           ra, -12(a3)
                  lbu          s4, 1(a3)
                  or           t6, s9, s1
                  sb           s5, -12(a3)
                  rem          ra, a7, s3
                  lbu          a5, -16(a3)
                  lw           t0, 7(a3)
                  csrrwi       s6, 0x301, 27
                  lb           s8, -16(a3)
                  lhu          zero, 5(a3)
                  csrrwi       t5, 0x344, 15
                  lh           t5, 1(a3)
                  lbu          s2, 4(a3)
                  mulh         a4, s11, s11
                  lb           t0, 9(a3)
                  lb           t3, -8(a3)
                  lbu          t1, -12(a3)
                  slli         zero, s0, 17
                  xor          t0, s2, gp
                  lbu          s1, -6(a3)
                  xor          s10, s8, s11
                  csrrs        s3, 0x305, zero
                  csrrsi       s5, 0x301, 31
                  sb           s7, -10(a3)
                  mulhu        a5, zero, gp
                  sh           s3, 15(a3)
                  lbu          t2, -16(a3)
                  lbu          zero, -2(a3)
                  lhu          t6, 11(a3)
                  lb           s7, 8(a3)
                  auipc        t5, 780371
                  sw           a6, -5(a3)
                  div          a2, a3, s8
                  remu         s8, t2, a0
                  lbu          a5, -14(a3)
                  lh           s0, 5(a3)
                  divu         s8, s8, t5
                  lbu          s4, -14(a3)
                  lbu          t5, 12(a3)
                  ori          s2, t2, -624
                  lbu          s2, 9(a3)
                  lbu          s1, 10(a3)
                  sb           zero, -13(a3)
                  slti         a4, s7, 389
                  sb           s1, 5(a3)
                  csrrci       s3, 0x344, 3
                  lb           s6, -1(a3) #end riscv_load_store_rand_instr_stream_9
                  la           a2, region_0+1537 #start load_store_instr_stream_0
                  la           a7, region_0+572 #start load_store_instr_stream_1
                  sb           a0, -80(a7)
                  sb           a4, -199(a7)
                  lbu          t5, -23(a2)
                  lbu          s8, -29(a7)
                  lbu          a6, -59(a2)
                  lbu          t1, -4(a2)
                  lbu          ra, 229(a7)
                  lhu          s10, 51(a2)
                  lbu          t4, -1(a2)
                  lbu          s10, 52(a2)
                  sw           t6, -176(a7)
                  lbu          s5, 22(a7)
                  sh           s2, 16(a7)
                  lb           ra, 107(a7)
                  sh           s11, 45(a2)
                  sb           s10, -125(a7)
                  lbu          s10, -32(a2)
                  lb           s4, 20(a7) #end load_store_instr_stream_1
                  lbu          a6, -48(a2)
                  lb           zero, -14(a2) #end load_store_instr_stream_0
                  la           s8, region_0+3349 #start riscv_hazard_instr_stream_18
                  and          s7, s7, s1
                  sra          s2, s3, s11
                  csrrsi       s7, 0x301, 1
                  csrrs        s1, 0x344, s7
                  sltu         s11, s3, s5
                  lb           s7, -12(s8)
                  srai         s3, s3, 1
                  nop
                  ori          s7, s5, 1005
                  andi         s7, s11, -910
                  sb           s11, 14(s8)
                  mulhsu       s7, s5, s1
                  sub          s7, s7, s2
                  slt          s2, s7, s7
                  sltiu        s2, s3, -526
                  slt          s7, s11, s3
                  xori         s2, s2, -1370
                  sb           s5, -8(s8)
                  xori         s5, s3, -1749
                  lbu          s3, 12(s8)
                  lb           s11, 9(s8)
                  lb           s1, -12(s8)
                  sh           s7, 3(s8)
                  sb           s7, -11(s8)
                  sb           s11, 7(s8)
                  slli         s3, s7, 0
                  lbu          s11, -11(s8)
                  srl          s11, s1, s2
                  lh           s7, -15(s8)
                  sb           s1, -4(s8)
                  srai         s7, s11, 23
                  mulhsu       s1, s5, s7
                  csrrwi       s11, 0x301, 14
                  mulhsu       s2, s5, s3
                  lb           s5, -6(s8)
                  lb           s2, -8(s8)
                  sb           s1, 0(s8)
                  xor          s3, s2, s3
                  csrrwi       s1, 0x301, 18
                  lh           s3, -5(s8)
                  slti         s11, s5, 688
                  lbu          s7, -5(s8)
                  sb           s11, 0(s8)
                  csrrwi       s3, 0x343, 13
                  mulhsu       s1, s5, s5
                  sb           s3, -6(s8) #end riscv_hazard_instr_stream_18
                  la           s11, region_0+2373 #start load_store_instr_stream_1
                  la           t3, region_1+1133 #start load_store_instr_stream_0
                  lbu          s9, 150(t3)
                  lb           zero, -6(s11)
                  sb           t1, 30(s11)
                  lb           a5, 188(t3)
                  lb           s6, 22(t3)
                  lh           a6, -11(s11)
                  sw           t3, -45(t3)
                  lbu          gp, -51(s11)
                  sb           a2, -12(s11)
                  lbu          t4, 96(t3)
                  sw           s1, -41(s11)
                  lb           s4, 72(t3)
                  sb           s3, -41(s11) #end load_store_instr_stream_1
                  lbu          ra, 193(t3)
                  lb           a7, 34(t3) #end load_store_instr_stream_0
                  la           t0, region_1+14204 #start load_store_instr_stream_3
                  la           s9, region_1+44139 #start load_store_instr_stream_2
                  la           a3, region_1+50321 #start load_store_instr_stream_1
                  sb           t6, -30(a3)
                  la           a5, region_1+19422 #start load_store_instr_stream_0
                  lbu          a4, -55(a5)
                  sh           s9, 53(s9)
                  sb           a6, 192(a3)
                  sb           t5, -10(t0)
                  sb           s10, -234(a3)
                  lb           s4, 30(s9)
                  lb           t6, 24(a5)
                  sb           s0, 8(t0)
                  lw           s11, 8(t0)
                  sb           a7, 3(s9)
                  sb           a0, -39(a5)
                  lh           t4, 63(s9)
                  sb           a3, 37(s9)
                  lbu          s0, -19(a3)
                  lb           s7, 61(s9)
                  lb           s10, 46(a5)
                  lb           a1, -31(a5)
                  lh           ra, 14(t0)
                  lh           t1, -59(s9)
                  lb           gp, 4(s9)
                  lh           s5, -5(s9)
                  sb           t5, -118(a3)
                  lbu          t3, 57(a5)
                  lbu          s1, -68(a3)
                  lbu          s2, 42(s9) #end load_store_instr_stream_2
                  sb           t6, -42(a3)
                  sh           t0, 227(a3)
                  lbu          s0, -13(t0) #end load_store_instr_stream_3
                  lhu          zero, -235(a3) #end load_store_instr_stream_1
                  lbu          s4, -37(a5) #end load_store_instr_stream_0
                  la           a7, region_0+475 #start load_store_instr_stream_1
                  la           s11, region_1+30509 #start load_store_instr_stream_0
                  sh           t0, -205(a7)
                  lhu          t1, -71(s11)
                  sb           s3, 154(a7)
                  sh           s3, 1(s11)
                  lb           s3, -38(a7)
                  lb           s4, 113(s11)
                  sb           a3, 56(a7)
                  sb           a5, -142(a7)
                  lb           t0, -228(s11)
                  lbu          a5, 78(a7)
                  sh           t3, 187(s11)
                  lbu          s1, -215(a7)
                  lbu          a2, 26(a7)
                  lb           t0, 188(a7) #end load_store_instr_stream_1
                  lbu          a1, 52(s11)
                  lh           s7, -131(s11)
                  lh           s4, -195(s11) #end load_store_instr_stream_0
                  li           t1, 0x80000000 #start riscv_int_numeric_corner_stream_29
                  li           ra, 0x0
                  li           s5, 0xffffffff
                  li           s9, 0x80000000
                  li           s1, 0x8a4cd31a
                  li           s2, 0x0
                  li           s0, 0xffffffff
                  li           t3, 0x0
                  li           s8, 0xe6a1ee6c
                  li           a2, 0x0
                  add          t3, t1, s9
                  rem          s5, ra, s2
                  divu         s1, s9, s8
                  divu         t1, s1, s8
                  auipc        ra, 331125
                  mulhu        s0, s8, t1
                  div          t1, s8, s5
                  mulh         s0, s1, s0
                  div          s5, a2, t1
                  rem          s0, s0, s2
                  addi         s9, s2, -127
                  rem          s9, a2, s5
                  auipc        s1, 606071
                  lui          t3, 555791
                  div          s8, a2, s1
                  addi         t3, s1, -2035
                  mulhsu       s5, s2, s0
                  remu         s8, t3, t1
                  lui          s9, 184457
                  nop
                  mulh         s5, ra, t1
                  divu         s9, s0, s5
                  mul          s1, s1, s5 #end riscv_int_numeric_corner_stream_29
                  la           t5, region_1+32665 #start load_store_instr_stream_3
                  la           s4, region_1+65388 #start load_store_instr_stream_2
                  la           a5, region_1+11712 #start load_store_instr_stream_1
                  la           t4, region_1+20321 #start load_store_instr_stream_0
                  sh           s0, -38(s4)
                  sb           t6, 26(a5)
                  sh           a2, 6(s4)
                  sb           tp, 120(t5)
                  sb           gp, -1976(t5)
                  lh           s10, 549(t5)
                  sw           s5, -421(t4)
                  sb           s9, -50(a5)
                  lhu          a7, -60(s4)
                  lbu          a2, 1860(t5)
                  sh           s2, 1399(t4)
                  lbu          t3, -1006(t4)
                  lbu          t2, -1131(t5)
                  lbu          s7, -23(s4)
                  lb           s0, -8(a5)
                  lbu          s2, -13(s4)
                  lbu          s11, 22(a5)
                  lbu          s7, 45(s4)
                  sb           t1, -332(t5)
                  lw           s8, -8(a5)
                  lh           t6, -1077(t5)
                  sb           s6, -53(s4)
                  sb           gp, -22(a5)
                  sh           a3, -615(t4)
                  lb           s1, 25(s4)
                  sh           sp, -2025(t5)
                  lb           a3, -61(a5)
                  sb           s3, -36(s4)
                  lb           t1, 796(t4)
                  lbu          ra, 14(s4) #end load_store_instr_stream_2
                  lb           s10, -941(t5) #end load_store_instr_stream_3
                  sb           t2, -13(a5) #end load_store_instr_stream_1
                  lhu          s7, 1251(t4) #end load_store_instr_stream_0
                  addi         ra, zero, 4 #init loop 1 counter
                  lui          zero, 374689
                  csrrw        s10, 0x342, s3
                  xori         t6, t4, 487
                  addi         t5, zero, 17 #init loop 1 limit
                  ori          s7, s4, -1571
main_216_1_t:     and          a2, t2, s4
                  mul          a2, s1, s10
                  addi         ra, ra, 9 #update loop 1 counter
                  srl          t3, a3, s6
                  addi         s6, zero, -8 #init loop 0 counter
                  addi         t2, zero, -14 #init loop 0 limit
                  nop
main_216_0_t:     slt          a3, ra, sp
                  csrrwi       t1, 0x304, 23
                  addi         s6, s6, -6 #update loop 0 counter
                  sltu         a6, s3, s4
                  srli         s0, zero, 22
                  bne          s6, t2, main_216_0_t #branch for loop 0
                  blt          ra, t5, main_216_1_t #branch for loop 1
                  xori         t1, s2, -1709
                  la           s0, region_1+27210 #start riscv_load_store_rand_instr_stream_4
                  xor          t4, t0, zero
                  sb           s4, -1501(s0)
                  and          s7, s7, s9
                  sh           ra, -472(s0)
                  lh           a7, 670(s0)
                  sltu         s3, t1, a0
                  lbu          s4, -1697(s0)
                  sw           a5, 1518(s0)
                  lbu          t0, 307(s0)
                  lb           t3, 493(s0)
                  lbu          t4, -785(s0)
                  xor          s3, t6, a5
                  srai         s11, t3, 26
                  lh           s1, 646(s0)
                  slti         t4, t1, 847
                  lbu          zero, -1484(s0)
                  mulhu        t3, a0, s9
                  mulhsu       a5, s5, gp
                  ori          a1, t3, -1879
                  lhu          a6, 542(s0)
                  lbu          s9, 859(s0)
                  lbu          zero, -207(s0)
                  and          t3, a7, a7
                  lui          a3, 24334
                  srai         s8, s11, 6
                  lbu          a7, 1095(s0) #end riscv_load_store_rand_instr_stream_4
                  la           s10, region_0+1207 #start riscv_hazard_instr_stream_15
                  sb           zero, -63(s10)
                  xor          s3, s2, t6
                  csrrc        t6, 0x301, zero
                  lhu          t6, -47(s10)
                  lhu          s1, 51(s10)
                  csrrc        s1, 0x301, zero
                  lh           t6, 5(s10)
                  lbu          t3, 0(s10)
                  nop
                  sb           t3, -60(s10)
                  sh           s1, -57(s10)
                  lbu          t3, 44(s10)
                  sb           s1, -40(s10)
                  ori          s2, t6, 1973
                  lb           s2, 34(s10)
                  sb           s1, 14(s10)
                  sltu         s2, zero, t6
                  lbu          zero, -40(s10)
                  lbu          zero, 8(s10)
                  addi         s1, s2, -674
                  csrrwi       s3, 0x344, 12
                  slt          s2, t3, zero
                  srli         t6, t6, 8
                  lbu          t6, 53(s10)
                  sb           t6, 8(s10)
                  andi         zero, s2, 981
                  sub          s3, s1, t6
                  sb           t6, 42(s10) #end riscv_hazard_instr_stream_15
main_119:         jal          ra, 3f
0:                jal          t0, 9f
1:                jal          ra, 22f
2:                jal          ra, 4f
3:                jal          ra, 15f
4:                jal          a1, 20f
5:                jal          t0, 12f
6:                jal          ra, 17f
7:                jal          ra, 19f
8:                jal          s5, 11f
9:                jal          s6, 7b
10:               jal          ra, 5b
11:               jal          t1, 6b
12:               jal          s10, 18f
13:               jal          ra, 23f
14:               jal          ra, 16f
15:               jal          ra, 24f
16:               jal          ra, 25f
17:               jal          s9, 14b
18:               jal          ra, 8b
19:               jal          t0, 10b
20:               jal          t1, 0b
21:               jal          gp, 1b
22:               jal          ra, 13b
23:               jal          t0, 2b
24:               jal          ra, 21b
25:               addi         t5, a1, 1688
                  la           t6, region_1+30021 #start riscv_hazard_instr_stream_34
                  lui          gp, 235345
                  sb           a4, 81(t6)
                  mulhsu       s5, gp, gp
                  lbu          gp, -1316(t6)
                  and          a4, s5, t0
                  sll          t0, zero, a4
                  srli         gp, a4, 10
                  srai         zero, a4, 7
                  mulhu        t0, zero, zero
                  slt          a4, zero, gp
                  divu         a4, s5, a4
                  sb           t0, -794(t6)
                  csrrsi       zero, 0x344, 0
                  lw           t0, -685(t6)
                  sb           gp, -1257(t6)
                  nop
                  slti         s4, zero, 1513
                  sll          s4, t0, gp
                  slti         s4, gp, 485
                  andi         t0, s5, -392
                  div          a4, s4, a4
                  or           gp, s4, a4
                  andi         s4, t0, 1048
                  mul          t0, s5, s5
                  addi         s4, t0, -548
                  srai         t0, gp, 19
                  slli         a4, t0, 6
                  lb           s4, 1222(t6)
                  xor          a4, gp, gp
                  lbu          gp, -379(t6)
                  addi         a4, t0, 712
                  csrrsi       zero, 0x343, 0
                  lbu          zero, 434(t6)
                  auipc        s4, 328186
                  sra          zero, s5, s5
                  sb           gp, -1521(t6)
                  remu         a4, t0, s5
                  lb           zero, 172(t6)
                  xori         zero, s5, -1977
                  csrrs        t0, 0x301, s5
                  sh           t0, -985(t6) #end riscv_hazard_instr_stream_34
                  la           s10, region_1+25767 #start riscv_load_store_rand_instr_stream_8
                  sub          t2, a1, s8
                  csrrsi       s3, 0x300, 0
                  ori          a3, t0, 771
                  sb           a6, -1(s10)
                  lui          a5, 741770
                  divu         a1, tp, s5
                  and          t3, t5, a7
                  lh           s9, 11(s10)
                  lhu          a5, -7(s10)
                  auipc        zero, 115214
                  lhu          zero, -5(s10)
                  csrrs        a1, 0x300, zero
                  lbu          a7, 14(s10)
                  and          t4, a7, t4
                  sra          s8, t4, zero
                  lhu          s1, 7(s10)
                  lb           a7, 9(s10)
                  add          a6, sp, a6
                  sltiu        s3, t4, 1040
                  lw           t4, 9(s10)
                  csrrs        s3, 0x300, zero
                  mulhsu       t1, tp, s9
                  sb           t4, 7(s10)
                  lb           s4, 12(s10)
                  sb           t3, 4(s10)
                  rem          t0, a5, s4
                  csrrwi       s1, 0x343, 3
                  and          a4, gp, s2
                  mulhsu       s0, s3, s10
                  sltu         s11, t6, a5
                  auipc        s5, 887463
                  ori          s11, t0, 935
                  lbu          s3, 8(s10)
                  lbu          s11, 2(s10)
                  auipc        s5, 44810
                  xor          t4, s3, a6
                  sh           t5, 9(s10)
                  lhu          s1, -11(s10)
                  div          a6, t0, a5
                  lb           a2, 1(s10)
                  sb           s1, -13(s10)
                  sh           a3, -13(s10)
                  lh           a2, 7(s10)
                  lbu          s3, 6(s10)
                  sub          s4, s1, s7
                  lb           t4, 5(s10)
                  sll          a4, a2, a3
                  sb           a7, -4(s10)
                  sb           ra, 12(s10)
                  lui          s7, 576311
                  xori         t2, s8, 936
                  lb           s2, 14(s10)
                  sh           s1, -5(s10) #end riscv_load_store_rand_instr_stream_8
                  la           a7, region_1+21372 #start riscv_hazard_instr_stream_35
                  sb           t3, -72(a7)
                  lb           t2, -651(a7)
                  add          t2, s4, a1
                  lbu          s4, 558(a7)
                  auipc        s7, 119714
                  sra          t2, a1, s7
                  remu         a1, t2, t3
                  xori         t3, t3, -2031
                  lb           t2, 1461(a7)
                  csrrsi       t3, 0x342, 30
                  sll          t3, a1, s0
                  sub          a1, t2, s0
                  lbu          t2, -787(a7)
                  lb           s0, 279(a7)
                  lb           s7, 390(a7)
                  sb           s7, -750(a7)
                  sltu         s4, t3, t3
                  sb           t3, -1226(a7)
                  sb           a1, 1751(a7)
                  lh           t2, 608(a7)
                  xor          s4, s0, s4
                  lbu          s0, 1311(a7)
                  sb           t2, 191(a7)
                  lh           t3, 574(a7)
                  add          t3, s4, s4
                  lbu          t3, 707(a7)
                  csrrc        s4, 0x343, s0
                  lh           s4, -1718(a7)
                  lb           s0, -359(a7)
                  lb           s7, -263(a7)
                  lbu          t2, -1318(a7)
                  sb           s4, -825(a7)
                  sh           a1, 1864(a7)
                  csrrwi       t3, 0x343, 26
                  lui          t3, 915478
                  nop
                  sw           s7, 1696(a7) #end riscv_hazard_instr_stream_35
                  la           a3, region_1+5836 #start load_store_instr_stream_1
                  la           t6, region_1+53038 #start load_store_instr_stream_2
                  la           s3, region_1+3128 #start load_store_instr_stream_0
                  sb           s1, 198(a3)
                  lhu          t5, -140(t6)
                  lbu          s2, 29(t6)
                  sb           s7, -102(a3)
                  lb           a5, -33(a3)
                  lh           t2, 212(t6)
                  sb           a0, 42(s3)
                  lb           s0, -181(t6)
                  lbu          s11, -217(a3)
                  sb           a6, 97(a3)
                  lb           gp, -72(a3)
                  lb           a5, 81(t6)
                  sw           a7, -48(s3)
                  sb           gp, -69(s3)
                  lbu          a5, 125(s3)
                  lbu          s4, -167(t6)
                  lb           t0, -222(s3)
                  lw           s10, 150(t6) #end load_store_instr_stream_2
                  sb           t4, 194(a3)
                  lbu          zero, -175(a3) #end load_store_instr_stream_1
                  sw           ra, -128(s3) #end load_store_instr_stream_0
                  la           a5, region_1+55153 #start riscv_load_store_hazard_instr_stream_17
                  csrrs        t4, 0x300, zero
                  nop
                  lb           s1, -10(a5)
                  sb           s7, 1099(a5)
                  sh           t0, 1099(a5)
                  xori         s11, s11, 1363
                  sb           s3, 1099(a5)
                  sb           a0, 1099(a5)
                  lbu          a1, 1870(a5)
                  ori          s4, s0, -1126
                  lbu          s6, 1992(a5)
                  sb           t0, 1992(a5)
                  mulhu        s2, s11, s2
                  remu         s0, s3, s11
                  sb           s5, 1992(a5)
                  sb           a4, 1992(a5)
                  div          a2, s9, s7
                  lbu          gp, 1992(a5) #end riscv_load_store_hazard_instr_stream_17
                  addi         ra, zero, 8 #init loop 1 counter
                  auipc        gp, 749658
                  slt          t5, a1, s1
                  addi         a2, zero, 8 #init loop 1 limit
                  ori          t4, s8, -1735
                  xor          a1, s2, a2
                  csrrc        s0, 0x343, zero
main_220_1_t:     xori         a5, ra, 882
                  csrrci       gp, 0x342, 9
                  csrrwi       s8, 0x301, 20
                  mulhu        zero, t4, tp
                  divu         s1, a5, tp
                  srai         t3, t3, 16
                  mulhsu       t2, s2, t2
                  addi         ra, ra, -7 #update loop 1 counter
                  and          s5, a1, a5
                  addi         t1, zero, -3 #init loop 0 counter
                  sra          s5, a1, t4
                  mulhsu       t3, s10, a5
                  rem          a1, s6, a0
                  csrrci       t3, 0x300, 0
                  addi         a6, zero, 18 #init loop 0 limit
                  srl          s4, a0, gp
main_220_0_t:     sltiu        a1, t2, -1767
                  addi         t1, t1, 3 #update loop 0 counter
                  bne          t1, a6, main_220_0_t #branch for loop 0
                  div          s11, t6, ra
                  rem          s7, s0, a7
                  or           a1, a1, tp
                  mul          t4, s7, t5
                  auipc        s9, 922482
                  remu         s3, t6, s11
                  mul          t6, ra, s9
                  bgeu         ra, a2, main_220_1_t #branch for loop 1
                  csrrs        zero, 0x344, t6
                  la           s4, region_1+46753 #start riscv_load_store_hazard_instr_stream_36
                  lb           a4, 34(s4)
                  andi         a4, s10, -1739
                  sb           gp, 1(s4)
                  lh           a2, 1(s4)
                  lb           zero, 1(s4)
                  sb           a6, 1(s4)
                  lb           a4, 1(s4)
                  lbu          s7, 1(s4)
                  sb           s7, 1(s4)
                  xor          a1, t5, t6
                  lhu          s1, 1(s4)
                  lb           a3, -46(s4)
                  lb           a1, -46(s4)
                  lb           s0, -46(s4)
                  lh           a6, -23(s4)
                  sb           s6, -23(s4) #end riscv_load_store_hazard_instr_stream_36
                  addi         s11, zero, -1 #init loop 1 counter
                  rem          a4, a3, a4
                  auipc        a6, 854485
                  sub          gp, t5, s9
                  addi         a7, zero, -15 #init loop 1 limit
main_221_1_t:     auipc        s5, 48768
                  addi         s11, s11, -7 #update loop 1 counter
                  mulhsu       s7, s4, zero
                  addi         t5, zero, 4 #init loop 0 counter
                  mulhu        t3, a6, a3
                  addi         t1, zero, 13 #init loop 0 limit
                  ori          s10, ra, -1402
                  auipc        s2, 228498
                  mul          a1, a6, a2
main_221_0_t:     div          a6, t6, s1
                  addi         t5, t5, 9 #update loop 0 counter
                  sra          s10, s4, t1
                  beq          t5, t1, main_221_0_t #branch for loop 0
                  srai         a5, t0, 11
                  beq          s11, a7, main_221_1_t #branch for loop 1
                  csrrwi       s9, 0x343, 27
main_87:          jal          ra, 15f
0:                jal          ra, 13f
1:                jal          t3, 11f
2:                jal          gp, 9f
3:                jal          t0, 10f
4:                jal          t1, 6f
5:                jal          t1, 12f
6:                jal          ra, 19f
7:                jal          t2, 17f
8:                jal          ra, 7b
9:                jal          ra, 14f
10:               jal          ra, 1b
11:               jal          ra, 8b
12:               jal          s1, 4b
13:               jal          t1, 3b
14:               jal          s7, 5b
15:               jal          s11, 0b
16:               jal          t1, 18f
17:               jal          s8, 16b
18:               jal          ra, 2b
19:               div          gp, s3, sp
                  la           t6, region_0+350 #start riscv_load_store_hazard_instr_stream_30
                  lbu          gp, 1130(t6)
                  mulhu        t0, t6, s10
                  lhu          a2, 1380(t6)
                  lb           a1, 1380(t6)
                  lh           t5, 1112(t6)
                  sltu         ra, t3, t0
                  sb           s5, 1637(t6)
                  lbu          s1, 1637(t6)
                  sb           t6, 1637(t6)
                  lbu          s9, 1637(t6)
                  andi         s5, s5, 1410
                  sh           tp, 792(t6)
                  lbu          s9, -23(t6)
                  lhu          s5, 56(t6)
                  sltiu        ra, s2, -1112
                  sh           s2, 1754(t6)
                  lb           t0, 1754(t6)
                  lhu          s9, 1754(t6)
                  lbu          s7, 137(t6)
                  nop
                  sb           s6, 137(t6)
                  sb           tp, 137(t6)
                  lb           t4, 263(t6)
                  sh           s9, 1874(t6) #end riscv_load_store_hazard_instr_stream_30
                  la           s9, region_0+2367 #start riscv_load_store_rand_instr_stream_10
                  add          gp, s4, a0
                  lb           a5, -46(s9)
                  andi         gp, t2, -287
                  sh           s0, 19(s9)
                  lb           t2, -46(s9)
                  lb           t0, 46(s9)
                  csrrsi       s10, 0x344, 12
                  lbu          t6, 46(s9)
                  lhu          s11, -63(s9)
                  srai         s3, s5, 29
                  xori         a3, a2, 200
                  sra          s5, t6, a0
                  div          t4, a4, s2
                  csrrc        t2, 0x304, a1
                  mulhsu       s5, s2, a2
                  auipc        a7, 955912
                  rem          t0, t3, t5
                  add          s5, s6, t4
                  slli         s6, t6, 3
                  sh           s0, -43(s9)
                  remu         a1, ra, t4
                  or           a1, sp, s8
                  and          gp, s7, a6
                  sltiu        t4, s10, 1830
                  xor          gp, t0, sp
                  csrrc        t2, 0x342, a1
                  div          s4, s7, ra
                  lbu          s3, -40(s9)
                  sb           ra, 56(s9)
                  sll          s6, s6, s3
                  csrrci       gp, 0x343, 14
                  lhu          s5, 7(s9)
                  srl          t5, s6, s2
                  srli         zero, a4, 10
                  lw           t3, -11(s9) #end riscv_load_store_rand_instr_stream_10
main_80:          jal          ra, 10f
0:                jal          ra, 13f
1:                jal          t1, 5f
2:                jal          ra, 11f
3:                jal          s2, 1b
4:                jal          a3, 14f
5:                jal          ra, 0b
6:                jal          ra, 7f
7:                jal          ra, 2b
8:                jal          t1, 6b
9:                jal          t1, 15f
10:               jal          t0, 9b
11:               jal          t5, 12f
12:               jal          ra, 16f
13:               jal          t1, 8b
14:               jal          ra, 3b
15:               jal          ra, 4b
16:               sll          a2, t3, t0
                  li           s9, 0xbb507ed2 #start riscv_int_numeric_corner_stream_12
                  li           s11, 0x8eaf892a
                  li           t3, 0xff7690ed
                  li           s8, 0x80000000
                  li           a5, 0x98a5ba55
                  li           t4, 0xffffffff
                  li           a7, 0xc86727bb
                  li           s4, 0x0
                  li           t2, 0xffffffff
                  li           s5, 0x80000000
                  mul          t2, t2, s11
                  mul          t2, t3, t3
                  nop
                  mulh         s8, s5, s9
                  sub          t4, s4, s9
                  mulhsu       t4, a7, a5
                  nop
                  divu         t3, t4, t4
                  nop
                  sub          t3, s5, t2
                  mul          a5, t3, a5
                  add          t4, s5, s5
                  divu         t4, a7, a5
                  mulhu        s11, a7, t4
                  mulhsu       s8, s5, t2
                  nop
                  div          a7, s9, s4
                  mulhu        t4, a7, a5
                  mulhsu       s11, s11, a7
                  sub          s9, s9, a5 #end riscv_int_numeric_corner_stream_12
                  la           a2, region_0+3143 #start load_store_instr_stream_1
                  sh           a0, -29(a2)
                  la           s2, region_1+14492 #start load_store_instr_stream_0
                  lb           t4, -509(s2)
                  lb           s6, 1980(s2)
                  sb           s0, 1922(s2)
                  lh           a4, 59(a2)
                  lb           t0, 16(a2)
                  lb           s3, -32(a2)
                  lbu          a3, 737(s2)
                  lb           s4, -28(a2)
                  lh           gp, -2042(s2)
                  lbu          t1, -26(a2) #end load_store_instr_stream_1
                  lbu          s6, 840(s2)
                  lb           t5, -562(s2)
                  sb           s0, -1695(s2)
                  sb           tp, 1830(s2)
                  lhu          a7, -1542(s2) #end load_store_instr_stream_0
                  li           t5, 0x80000000 #start riscv_int_numeric_corner_stream_25
                  li           t4, 0x80000000
                  li           t6, 0x80000000
                  li           s5, 0x80000000
                  li           s0, 0xffffffff
                  li           a6, 0x2416b48f
                  li           a7, 0xffffffff
                  li           gp, 0x80000000
                  li           t3, 0x0
                  li           t0, 0xffffffff
                  divu         t6, s0, a6
                  divu         a7, s5, t5
                  auipc        t0, 504093
                  auipc        gp, 895318
                  mul          gp, t6, s5
                  divu         t0, t0, s0
                  remu         t0, t0, t0
                  add          t5, t4, t3
                  lui          a6, 683095
                  lui          a7, 559959
                  nop
                  addi         a6, gp, -1810
                  addi         gp, t4, 1249
                  add          t3, s5, s0
                  mulhu        s5, s0, t0
                  sub          s5, t0, s0
                  mul          t0, s0, gp
                  rem          t3, t6, s5
                  nop
                  mul          gp, gp, t0
                  mulhu        t5, a7, s5
                  mulhu        s5, s5, t5
                  divu         t5, t5, s5
                  add          a6, t6, t5
                  nop
                  add          a6, t6, s0
                  div          t4, t6, gp
                  nop
                  sub          t6, t4, t0 #end riscv_int_numeric_corner_stream_25
                  la           a6, region_0+449 #start riscv_hazard_instr_stream_37
                  srli         t4, s7, 8
                  lbu          t4, 136(a6)
                  rem          a2, s4, t4
                  sltu         t4, s7, t4
                  csrrsi       a2, 0x342, 16
                  mulhu        s6, s7, s2
                  csrrsi       a2, 0x304, 0
                  sltiu        s7, s2, 358
                  lh           s7, 47(a6)
                  lb           s2, -236(a6)
                  auipc        s4, 417265
                  lh           t4, -19(a6)
                  ori          s6, s4, 538
                  mul          t4, s2, s7
                  sb           s7, 216(a6)
                  sb           s6, 66(a6)
                  sh           s7, -115(a6)
                  sra          s7, s2, s7
                  srl          s6, s6, s6
                  lui          a2, 348392
                  lhu          t4, 17(a6)
                  slt          a2, s4, t4
                  sltiu        a2, t4, 1776
                  lbu          a2, -120(a6)
                  sub          s4, s2, a2
                  mulhsu       s6, s6, t4
                  sh           s4, 45(a6)
                  csrrw        s4, 0x343, t4
                  sra          s2, a2, a2
                  addi         s2, s4, -1045
                  lh           s7, 231(a6)
                  sh           s6, 105(a6)
                  lbu          s7, 114(a6)
                  and          s7, s4, s4
                  lb           s2, -136(a6)
                  div          a2, s6, s6
                  srl          s4, s4, s4
                  sub          s2, s6, s6
                  lb           s2, 84(a6)
                  lbu          s4, 190(a6)
                  lb           a2, 255(a6)
                  lbu          a2, -36(a6)
                  lbu          a2, 246(a6) #end riscv_hazard_instr_stream_37
                  la           t3, region_1+43008 #start riscv_load_store_hazard_instr_stream_3
                  sb           t6, -13(t3)
                  lbu          s7, -55(t3)
                  lb           a6, -55(t3)
                  lhu          s1, 54(t3)
                  lb           s3, 54(t3)
                  lbu          s1, 54(t3)
                  sb           zero, 54(t3)
                  lbu          s7, 59(t3)
                  addi         t2, s7, -1119
                  sb           s6, 59(t3)
                  lb           s9, 59(t3)
                  csrrc        t4, 0x305, zero
                  mul          a5, s10, a1
                  lhu          ra, -24(t3)
                  lbu          s6, 34(t3)
                  nop
                  sh           s1, 34(t3) #end riscv_load_store_hazard_instr_stream_3
main_91:          jal          ra, 2f
0:                jal          gp, 10f
1:                jal          t1, 15f
2:                jal          ra, 18f
3:                jal          s6, 4f
4:                jal          ra, 16f
5:                jal          a1, 7f
6:                jal          ra, 0b
7:                jal          s5, 19f
8:                jal          t1, 14f
9:                jal          a5, 11f
10:               jal          ra, 17f
11:               jal          t1, 12f
12:               jal          ra, 20f
13:               jal          ra, 21f
14:               jal          t0, 1b
15:               jal          ra, 13b
16:               jal          ra, 8b
17:               jal          t1, 3b
18:               jal          t1, 5b
19:               jal          s2, 9b
20:               jal          s3, 6b
21:               lui          ra, 516661
                  addi         t2, zero, -7 #init loop 0 counter
                  slli         zero, s11, 25
                  andi         a5, tp, 2036
                  slti         s9, s2, -807
                  mulh         t5, a6, t3
                  slt          s1, s11, t1
                  addi         a7, zero, 11 #init loop 0 limit
                  mulhsu       t6, s7, zero
                  sub          s5, s11, t3
main_204_0_t:     mul          a6, s5, a3
                  sub          a5, a4, s3
                  addi         t2, t2, 6 #update loop 0 counter
                  mul          a3, t0, ra
                  blt          t2, a7, main_204_0_t #branch for loop 0
                  or           s6, a4, s6
                  la           s10, region_1+63033 #start riscv_hazard_instr_stream_36
                  ori          zero, s11, 482
                  lb           a1, 15(s10)
                  mulh         a6, a4, zero
                  sb           a1, 0(s10)
                  lh           t0, 13(s10)
                  sb           a1, 7(s10)
                  lbu          a6, 13(s10)
                  csrrs        a4, 0x343, zero
                  addi         a6, a6, -546
                  add          a6, t0, s11
                  sw           zero, 15(s10)
                  lhu          a1, 11(s10)
                  sb           a1, -8(s10)
                  csrrci       a6, 0x305, 0
                  lhu          a4, 1(s10)
                  slt          zero, a1, a1
                  lbu          s11, 15(s10)
                  csrrc        t0, 0x342, zero
                  lw           a1, -9(s10)
                  sb           a6, -12(s10)
                  lbu          t0, -14(s10)
                  lbu          s11, 6(s10)
                  divu         t0, a4, a4
                  or           a6, a4, a6
                  lbu          s11, -6(s10)
                  lb           s11, -2(s10)
                  sb           a6, -6(s10)
                  srai         t0, a1, 7
                  sb           a4, -14(s10)
                  lbu          a4, -8(s10)
                  lbu          zero, 3(s10) #end riscv_hazard_instr_stream_36
                  la           a4, region_0+441 #start riscv_load_store_rand_instr_stream_3
                  sb           t5, -2(a4)
                  lbu          t2, -2(a4)
                  sb           s8, 10(a4)
                  and          s3, s2, t6
                  csrrs        s3, 0x301, s5
                  and          s6, s10, t1
                  lb           s8, -8(a4)
                  lb           s7, 10(a4)
                  sb           s2, -16(a4)
                  sw           s4, 7(a4)
                  csrrc        s8, 0x301, gp
                  lbu          s6, 16(a4)
                  nop
                  lbu          a5, 8(a4)
                  or           s9, a4, a5
                  xori         a1, s0, 951
                  lb           a3, -10(a4)
                  srai         t3, gp, 23
                  sub          s3, a0, sp
                  lb           s5, -15(a4)
                  sb           t5, -9(a4)
                  sh           s2, 15(a4)
                  divu         ra, t5, gp
                  divu         a5, a4, a3
                  lb           t5, -6(a4)
                  lh           a2, 13(a4)
                  sb           s11, -16(a4)
                  mulhsu       a7, s4, s3
                  sll          t2, s11, t1
                  sb           t6, 4(a4)
                  sw           tp, 7(a4)
                  lbu          s6, -12(a4)
                  ori          t1, t4, 1386
                  mulhsu       t3, s4, a1
                  lbu          s10, -8(a4)
                  sb           s2, 14(a4)
                  lb           s4, -4(a4)
                  lbu          t2, 8(a4)
                  sub          s7, a4, a0
                  lw           s1, 11(a4)
                  lb           t3, 14(a4)
                  csrrc        s0, 0x344, zero
                  lbu          s4, 8(a4)
                  sh           t4, -11(a4)
                  lbu          t2, -11(a4)
                  slli         t4, s11, 22
                  lbu          a2, 0(a4)
                  sb           a0, 4(a4) #end riscv_load_store_rand_instr_stream_3
                  li           a4, 0x80000000 #start riscv_int_numeric_corner_stream_17
                  li           a2, 0xffffffff
                  li           t2, 0x8daf1549
                  li           s4, 0x9e39a646
                  li           s1, 0x80000000
                  li           t4, 0xffffffff
                  li           ra, 0x80000000
                  li           a1, 0x1171b8a8
                  li           t1, 0x0
                  li           s10, 0x80000000
                  rem          s10, t1, s4
                  mulhu        s4, a2, s4
                  mulhsu       s4, s1, s10
                  sub          t1, a1, t4
                  mul          a1, t1, a1
                  divu         s10, t2, a4
                  div          s10, t2, a2
                  mulh         a4, a1, t4
                  mulh         a4, s10, t1
                  add          t1, t4, a2
                  lui          t2, 707358
                  mul          t2, t4, a2
                  rem          a1, s4, s4
                  divu         t1, s10, a2
                  addi         t2, t4, -271
                  div          s4, t2, s4
                  mulhsu       t4, a1, t2
                  remu         t1, t1, s10
                  div          a4, ra, t1
                  mulhu        t1, s10, ra
                  lui          t1, 605907 #end riscv_int_numeric_corner_stream_17
                  la           a3, region_0+2141 #start load_store_instr_stream_3
                  la           s11, region_0+1137 #start load_store_instr_stream_2
                  sw           a4, 191(a3)
                  la           a4, region_0+1522 #start load_store_instr_stream_1
                  la           t0, region_0+1610 #start load_store_instr_stream_0
                  lbu          a7, -10(s11)
                  lb           s3, 237(a4)
                  lb           s8, -119(a3)
                  sw           a2, 3(s11)
                  lbu          gp, -38(a4)
                  lbu          s5, 7(t0)
                  sb           s4, -77(a4)
                  lbu          s5, -15(t0)
                  sb           t0, -69(a4)
                  lh           a1, -212(a4)
                  sb           tp, 237(a4)
                  lhu          s7, -5(s11)
                  lw           s8, 14(t0)
                  lb           gp, 33(a4)
                  sb           t6, -4(s11)
                  lbu          a6, 14(s11)
                  sb           t5, 150(a4)
                  sb           s1, -54(a3)
                  lb           s9, -41(a4)
                  lbu          a6, 16(s11)
                  lhu          a6, -9(s11)
                  lb           t6, -154(a3)
                  lbu          s7, 11(t0)
                  lb           s4, -16(s11) #end load_store_instr_stream_2
                  sh           s7, 22(a4) #end load_store_instr_stream_1
                  sb           a1, -156(a3) #end load_store_instr_stream_3
                  sb           tp, -8(t0) #end load_store_instr_stream_0
                  la           t3, region_0+16 #start load_store_instr_stream_1
                  lb           t1, 1499(t3)
                  la           a7, region_1+18350 #start load_store_instr_stream_0
                  lh           a5, 1410(t3)
                  lb           s10, 32(a7)
                  lb           t1, -48(a7)
                  lb           s6, 1812(t3)
                  lbu          a6, 35(a7)
                  lb           s6, 971(t3)
                  sb           s5, 30(a7)
                  lw           t1, 388(t3)
                  lb           a2, -13(a7)
                  lbu          ra, 1575(t3)
                  sb           t6, 563(t3)
                  lbu          s5, 29(t3) #end load_store_instr_stream_1
                  sb           a0, 40(a7) #end load_store_instr_stream_0
                  la           s1, region_1+64732 #start riscv_load_store_hazard_instr_stream_32
                  lbu          a2, 179(s1)
                  csrrs        t3, 0x301, zero
                  lb           s7, -105(s1)
                  lbu          t0, 234(s1)
                  sh           sp, 234(s1)
                  lw           a6, -124(s1)
                  lhu          t3, -124(s1)
                  lb           s2, -124(s1)
                  lhu          t4, -124(s1)
                  div          a6, s2, a0
                  lb           s10, -124(s1)
                  lhu          gp, -122(s1)
                  lhu          s9, -122(s1)
                  lbu          t5, -122(s1)
                  lbu          gp, -122(s1)
                  lh           a6, -122(s1)
                  divu         s4, s5, a2
                  xori         s10, s3, 1306
                  sb           s2, -122(s1)
                  lh           s2, -196(s1)
                  lh           s9, -196(s1)
                  sw           t4, -196(s1)
                  lbu          t2, -196(s1) #end riscv_load_store_hazard_instr_stream_32
                  addi         s6, zero, -8 #init loop 1 counter
                  csrrsi       s2, 0x305, 0
                  addi         s11, zero, -17 #init loop 1 limit
                  remu         gp, s5, tp
main_207_1_t:     xor          zero, a4, t5
                  csrrc        s7, 0x301, s9
                  sll          s9, s3, s5
                  addi         s6, s6, -9 #update loop 1 counter
                  addi         a4, zero, -3 #init loop 0 counter
                  csrrci       s9, 0x304, 12
                  addi         a1, zero, 17 #init loop 0 limit
main_207_0_t:     sub          a6, s6, sp
                  addi         a4, a4, 4 #update loop 0 counter
                  srli         s2, t2, 5
                  beq          a4, a1, main_207_0_t #branch for loop 0
                  beq          s6, s11, main_207_1_t #branch for loop 1
                  csrrwi       a5, 0x304, 11
                  la           s2, region_1+64959 #start riscv_hazard_instr_stream_30
                  lbu          s9, 5(s2)
                  ori          t3, a6, 1482
                  sw           a6, -3(s2)
                  sb           a6, 3(s2)
                  lh           t3, -15(s2)
                  lbu          s6, 2(s2)
                  lb           a6, -14(s2)
                  sltiu        t2, s6, -605
                  lbu          t2, 1(s2)
                  lbu          s6, 5(s2)
                  csrrs        t2, 0x343, s6
                  lb           a4, 3(s2)
                  lb           a6, -4(s2)
                  sh           s6, -13(s2)
                  mulhsu       t3, t3, s9
                  xor          s9, a4, s9
                  sb           a6, 5(s2)
                  slti         s6, a4, -1153
                  sb           t3, -14(s2)
                  mul          s6, a6, t2
                  slt          t3, a4, s6
                  slt          s9, a6, t2
                  slli         a4, s9, 4
                  lb           s6, 16(s2)
                  nop
                  srli         a6, a4, 18
                  slt          s9, s9, a4
                  mulhu        s6, t3, a6
                  lhu          a4, 5(s2)
                  csrrci       s6, 0x344, 0
                  lb           t2, -5(s2)
                  sb           a6, 4(s2)
                  lbu          t2, -9(s2)
                  divu         s6, s6, a6
                  lb           s6, -14(s2)
                  lbu          s9, 6(s2)
                  lb           t2, -16(s2)
                  lhu          a4, 11(s2)
                  sb           t3, 5(s2)
                  lw           s9, 9(s2)
                  sh           a6, -9(s2)
                  addi         t2, a6, 393
                  csrrs        a4, 0x342, a6
                  lb           s6, 13(s2)
                  srai         s6, a4, 10
                  lb           a6, -14(s2)
                  csrrwi       t2, 0x343, 25
                  lb           t3, -2(s2)
                  lh           t3, -9(s2)
                  nop
                  rem          s6, a4, s6
                  lbu          s6, 16(s2) #end riscv_hazard_instr_stream_30
                  la           a6, region_0+408 #start riscv_load_store_rand_instr_stream_22
                  sb           s5, -19(a6)
                  csrrsi       t0, 0x344, 0
                  lb           t6, 1626(a6)
                  csrrsi       s3, 0x301, 0
                  slti         s8, t3, 687
                  csrrwi       s10, 0x343, 22
                  and          a2, a5, s1
                  slt          a4, t3, s8
                  lh           t2, 690(a6)
                  sb           ra, 1599(a6)
                  sra          s1, tp, a6
                  mulhu        t1, t0, s4
                  divu         s2, s7, s5
                  sb           s6, 1294(a6)
                  lhu          a4, 172(a6)
                  lb           zero, 17(a6)
                  sb           s8, 510(a6)
                  lhu          t1, 726(a6)
                  lhu          s5, 1500(a6)
                  mulh         s9, sp, tp
                  divu         t1, a7, s6
                  sltiu        s10, zero, 514
                  lui          a1, 953289
                  lh           t0, -376(a6)
                  sw           t6, 404(a6)
                  srli         s3, t1, 26
                  lbu          a1, 553(a6)
                  addi         s11, a0, -1486
                  csrrc        s2, 0x300, zero
                  lbu          a3, 657(a6)
                  sb           a6, 143(a6)
                  sltu         s0, a1, a4
                  lbu          gp, 295(a6)
                  mulh         a1, zero, s5
                  sra          s3, t6, t6
                  csrrc        s8, 0x344, a5
                  sb           a2, 1699(a6)
                  andi         t4, a7, -895
                  sb           a0, 1382(a6)
                  srai         ra, gp, 7
                  csrrw        s9, 0x343, t5
                  mul          a3, s6, t0
                  lw           ra, 936(a6)
                  sw           tp, 1984(a6) #end riscv_load_store_rand_instr_stream_22
                  li           t0, 0x755ab041 #start riscv_int_numeric_corner_stream_30
                  li           s7, 0x0
                  li           t5, 0x5b704c9d
                  li           t2, 0x9b835773
                  li           s10, 0xffffffff
                  li           t3, 0xffffffff
                  li           a1, 0x0
                  li           a6, 0x80000000
                  li           t1, 0x80000000
                  li           a5, 0x20c6112f
                  add          a6, t2, s7
                  mulhu        t5, t0, s7
                  mulhu        a5, a6, a5
                  nop
                  divu         t3, a5, a6
                  mul          a6, t3, s10
                  addi         t3, a5, -1279
                  auipc        t0, 1023770
                  mulh         a6, a5, t1
                  sub          s7, t2, s7
                  sub          t2, t0, s7
                  auipc        t5, 502100
                  sub          a1, a6, s7
                  auipc        t0, 715133
                  addi         s7, t5, -77
                  mulh         a5, t1, a5
                  divu         a6, t0, a5
                  auipc        a5, 983852
                  rem          t0, t0, s10
                  divu         t3, s10, t5 #end riscv_int_numeric_corner_stream_30
                  la           s0, region_0+3580 #start riscv_hazard_instr_stream_14
                  lui          zero, 972792
                  lbu          a5, -59(s0)
                  srli         a6, s4, 4
                  slti         a5, t4, 1302
                  mulh         gp, t4, gp
                  auipc        a5, 344273
                  add          a6, t4, zero
                  lbu          gp, 22(s0)
                  lb           a5, -54(s0)
                  sb           a6, 50(s0)
                  lb           t4, 12(s0)
                  div          zero, gp, a6
                  addi         a6, s4, 1575
                  lb           a5, 16(s0)
                  lb           s4, 33(s0)
                  lw           zero, 40(s0)
                  sra          s4, zero, gp
                  slti         zero, s4, 864
                  srai         gp, a6, 21
                  csrrw        t4, 0x344, a5
                  auipc        zero, 718583
                  sb           a6, -48(s0)
                  srli         t4, a6, 2
                  slt          gp, s4, gp
                  sltiu        t4, s4, 1342
                  csrrc        a5, 0x344, a6
                  sh           a5, -42(s0) #end riscv_hazard_instr_stream_14
                  la           t0, region_0+3662 #start load_store_instr_stream_0
                  lb           s11, -7(t0)
                  lb           s11, -11(t0)
                  la           a1, region_1+49295 #start load_store_instr_stream_1
                  lbu          t2, 51(a1)
                  sh           s5, -8(t0)
                  lbu          a5, 60(a1)
                  sb           t4, -13(t0)
                  lhu          zero, 15(a1)
                  lbu          s4, -13(t0)
                  sb           s6, 64(a1)
                  lh           t1, 16(t0)
                  lb           s10, -4(t0)
                  lh           s3, 35(a1)
                  lbu          s1, -32(a1)
                  lb           a2, -5(t0)
                  sb           t1, 45(a1)
                  sh           a4, -21(a1)
                  sb           s2, -30(a1) #end load_store_instr_stream_1
                  sb           t3, -4(t0)
                  lhu          s5, 2(t0) #end load_store_instr_stream_0
main_106:         jal          ra, 7f
0:                jal          ra, 4f
1:                jal          ra, 24f
2:                jal          t4, 5f
3:                jal          t1, 16f
4:                jal          ra, 9f
5:                jal          ra, 20f
6:                jal          gp, 3b
7:                jal          s10, 12f
8:                jal          s6, 11f
9:                jal          t1, 22f
10:               jal          s8, 18f
11:               jal          ra, 10b
12:               jal          ra, 25f
13:               jal          ra, 8b
14:               jal          s9, 15f
15:               jal          ra, 13b
16:               jal          t1, 21f
17:               jal          t0, 19f
18:               jal          t1, 1b
19:               jal          ra, 26f
20:               jal          ra, 14b
21:               jal          t1, 23f
22:               jal          ra, 6b
23:               jal          ra, 17b
24:               jal          t1, 0b
25:               jal          ra, 2b
26:               srai         s5, s7, 19
                  li           gp, 0x0 #start riscv_int_numeric_corner_stream_21
                  li           t2, 0x80000000
                  li           a6, 0x0
                  li           a5, 0xffffffff
                  li           s9, 0x535a5b9
                  li           s11, 0x80000000
                  li           t6, 0x1807f3d4
                  li           t3, 0xffffffff
                  li           s7, 0x80000000
                  li           t1, 0x0
                  lui          t3, 354392
                  add          a6, a5, a5
                  remu         t6, t2, s11
                  sub          t3, gp, gp
                  div          t3, t1, t2
                  mulhu        s7, t2, t6
                  addi         a5, a5, 314
                  mulh         t1, t2, a6
                  nop
                  remu         t2, t1, t3
                  mulhu        t6, a6, gp
                  div          s9, a6, t6
                  add          gp, a5, t2
                  mul          s9, s11, a5
                  addi         s11, s9, 402
                  addi         t1, gp, -1139
                  mulhu        t2, a5, t1
                  remu         a6, gp, t2
                  mulhu        s7, gp, a5
                  mulhsu       s11, a5, t1
                  lui          s9, 928414 #end riscv_int_numeric_corner_stream_21
                  la           s0, region_0+196 #start riscv_hazard_instr_stream_1
                  sltu         s11, s3, t5
                  sw           s2, -32(s0)
                  srl          t5, s3, s3
                  auipc        a7, 930669
                  lhu          t5, 12(s0)
                  lb           s2, -23(s0)
                  mul          a3, a7, s3
                  sb           s11, -61(s0)
                  mulh         s2, s11, s11
                  sra          s2, a3, s3
                  sltu         a3, s2, s2
                  add          s3, s2, s3
                  csrrci       s2, 0x344, 0
                  lbu          t5, -63(s0)
                  lb           s2, 53(s0)
                  lbu          s11, -15(s0)
                  sll          t5, a7, s11
                  sll          s11, s2, s3
                  nop
                  mulhsu       t5, s3, s11
                  slli         t5, s3, 14
                  sb           s2, -52(s0)
                  sb           s11, -34(s0)
                  auipc        s2, 252232
                  addi         t5, s2, 1932
                  lbu          s11, -54(s0)
                  lb           t5, 62(s0)
                  sb           s11, 22(s0)
                  lhu          s3, 50(s0)
                  csrrc        t5, 0x304, s3
                  lb           a3, 11(s0)
                  lb           a3, 21(s0)
                  mulhu        a3, s2, t5
                  slti         a3, t5, 1705
                  auipc        s11, 724204
                  remu         s2, a7, a3
                  mul          t5, s3, a3
                  nop
                  sb           s11, 2(s0)
                  slti         s3, s3, -1195
                  divu         t5, s11, s3
                  csrrw        t5, 0x343, s2
                  lhu          s2, 60(s0)
                  lb           a3, -47(s0)
                  lw           s2, -24(s0)
                  lbu          a3, -20(s0) #end riscv_hazard_instr_stream_1
main_117:         jal          ra, 10f
0:                jal          t0, 9f
1:                jal          ra, 19f
2:                jal          t2, 0b
3:                jal          t1, 5f
4:                jal          ra, 20f
5:                jal          ra, 17f
6:                jal          ra, 11f
7:                jal          ra, 15f
8:                jal          ra, 12f
9:                jal          ra, 7b
10:               jal          ra, 1b
11:               jal          ra, 8b
12:               jal          s2, 18f
13:               jal          t1, 6b
14:               jal          ra, 3b
15:               jal          s2, 16f
16:               jal          ra, 4b
17:               jal          t1, 13b
18:               jal          s5, 2b
19:               jal          ra, 14b
20:               csrrw        s3, 0x301, a5
main_109:         jal          ra, 13f
0:                jal          ra, 4f
1:                jal          ra, 3f
2:                jal          t4, 12f
3:                jal          ra, 9f
4:                jal          t1, 11f
5:                jal          gp, 16f
6:                jal          s9, 2b
7:                jal          t0, 5b
8:                jal          t0, 1b
9:                jal          ra, 10f
10:               jal          ra, 15f
11:               jal          a1, 8b
12:               jal          ra, 0b
13:               jal          ra, 6b
14:               jal          ra, 7b
15:               jal          ra, 14b
16:               jal          t1, 17f
17:               xor          t3, t4, a5
                  la           a7, region_1+52574 #start load_store_instr_stream_3
                  la           s11, region_1+20867 #start load_store_instr_stream_1
                  la           s10, region_1+26506 #start load_store_instr_stream_0
                  lbu          t4, -7(s11)
                  la           gp, region_1+36428 #start load_store_instr_stream_2
                  lb           t4, -34(s10)
                  sb           s4, 4(s11)
                  lw           zero, -199(s11)
                  sh           a0, 10(a7)
                  lbu          ra, 9(a7)
                  sb           s1, 1501(s10)
                  sh           t1, 1634(s10)
                  sb           a5, 207(s11)
                  sb           a2, -250(s11)
                  lb           s3, -1279(s10)
                  lw           s5, -16(gp)
                  sb           t0, 13(a7)
                  lb           s4, -49(a7)
                  sb           t3, -254(s11)
                  lbu          t1, -759(s10)
                  sb           s3, -822(s10)
                  sb           a3, 55(a7)
                  lb           ra, 13(gp)
                  lbu          a4, 10(gp)
                  sb           s11, 63(a7)
                  lh           t1, 25(s11)
                  lbu          a1, -15(gp)
                  lb           t5, -29(a7) #end load_store_instr_stream_3
                  lw           s7, 109(s11)
                  lbu          s1, -555(s10)
                  lb           s2, 182(s11) #end load_store_instr_stream_1
                  lbu          a3, 15(gp) #end load_store_instr_stream_2
                  lb           s1, -1752(s10) #end load_store_instr_stream_0
                  la           t6, region_1+10174 #start load_store_instr_stream_0
                  lb           gp, -1(t6)
                  la           t5, region_1+6321 #start load_store_instr_stream_1
                  lb           a2, 21(t5)
                  lb           s5, 19(t6)
                  lb           t2, 25(t6)
                  lbu          s0, 29(t5)
                  lb           t0, -6(t6)
                  sh           a2, 35(t5)
                  sb           s7, 8(t6)
                  sh           s2, 37(t5)
                  lhu          t0, 10(t6)
                  sb           t5, -4(t5) #end load_store_instr_stream_1
                  lb           a1, 29(t6) #end load_store_instr_stream_0
                  la           s6, region_1+19672 #start riscv_hazard_instr_stream_19
                  lhu          s1, -548(s6)
                  csrrc        a5, 0x342, s1
                  lhu          s7, -1742(s6)
                  srl          a5, s1, t5
                  auipc        a3, 33397
                  xor          a3, s7, a5
                  lbu          s7, -511(s6)
                  sh           s4, 224(s6)
                  sltu         s7, t5, t5
                  sh           t5, -654(s6)
                  lh           a5, -424(s6)
                  lb           a5, -73(s6)
                  ori          a3, a5, -57
                  lb           a3, 518(s6)
                  auipc        a5, 457116
                  sb           a5, 1582(s6)
                  sb           t5, -1866(s6)
                  lbu          a5, -241(s6)
                  mul          s7, t5, a3
                  sb           s4, -363(s6)
                  xori         s4, a3, 490
                  lui          s7, 1021735
                  sb           t5, 1238(s6)
                  sll          s7, s4, s7
                  lh           a5, 1028(s6)
                  lhu          a5, -738(s6)
                  xori         s1, a3, -1945
                  srli         t5, a5, 0
                  sub          a5, a3, a5
                  lb           s1, 381(s6) #end riscv_hazard_instr_stream_19
                  li           t1, 0x0 #start riscv_int_numeric_corner_stream_38
                  li           s5, 0x80000000
                  li           t6, 0x6f2405f9
                  li           ra, 0x80000000
                  li           s4, 0x0
                  li           t2, 0xffffffff
                  li           s11, 0x11ad4119
                  li           a5, 0xffffffff
                  li           s8, 0x80000000
                  li           t3, 0x0
                  divu         a5, a5, ra
                  lui          ra, 413018
                  add          t1, s11, a5
                  addi         t6, t3, -157
                  add          t2, t1, ra
                  remu         s11, ra, a5
                  mulhsu       t3, s8, s8
                  nop
                  lui          s11, 261757
                  div          t2, s4, t1
                  mulhu        t6, s11, s4
                  add          t2, t2, s4
                  remu         t1, ra, t1
                  mul          ra, s8, a5
                  add          a5, t1, s11
                  divu         a5, t3, s4
                  div          s11, t2, t2
                  rem          s11, s8, s4
                  div          t3, t3, s8
                  mulhu        t1, a5, s11
                  mulh         s8, s11, t2
                  mulhsu       t6, t6, t2
                  lui          s11, 288141
                  addi         t2, s11, -13 #end riscv_int_numeric_corner_stream_38
0:                csrrs        s6, 0x342, s5
1:                addi         s4, s3, -1180
2:                slti         s2, a2, 852
3:                slli         s8, t4, 23
4:                csrrc        a1, 0x300, zero
5:                xori         a7, a1, -278
6:                bltu         t0, t5, 8f
7:                xori         zero, t2, -1611
8:                lui          zero, 999338
9:                sll          s0, a1, s1
10:               sltiu        s2, s0, 663
11:               srai         a1, s7, 0
12:               remu         s2, t4, t5
13:               xor          a5, t2, s0
14:               slti         a2, s0, 1155
15:               bge          a3, t1, 17f
16:               rem          a6, s3, s2
17:               slli         a1, s11, 22
18:               csrrci       s1, 0x343, 27
19:               sub          t4, s8, s8
20:               slt          s0, t4, ra
21:               ori          zero, t4, -1614
22:               sra          s0, s3, s2
23:               sltu         s8, s7, a3
24:               sltiu        a1, s11, 493
25:               blt          ra, s2, 34f
26:               ori          a3, s1, 1883
27:               csrrsi       t1, 0x300, 0
28:               add          a1, a6, t1
29:               addi         s6, t0, -170
30:               xor          s4, s4, a7
31:               blt          zero, a4, 42f
32:               remu         gp, t0, t6
33:               sub          s4, zero, t3
34:               ori          a3, t3, 1047
35:               beq          s9, t1, 55f
36:               and          a7, zero, a0
37:               bge          a4, t5, 57f
38:               lui          a1, 236682
39:               or           a7, zero, tp
40:               beq          a0, s7, 45f
41:               addi         t1, s8, 1777
42:               addi         a3, a1, 1221
43:               ori          s9, ra, 395
44:               divu         zero, t4, sp
45:               mulh         s5, gp, s1
46:               mulhu        s7, s5, s9
47:               slli         a4, a3, 26
48:               sltiu        a1, s2, -1159
49:               mulh         s6, t2, s7
50:               auipc        s6, 815314
51:               csrrci       s6, 0x300, 0
52:               sll          ra, tp, t0
53:               mulh         s6, s6, s11
54:               remu         s4, t4, tp
55:               beq          t1, zero, 71f
56:               csrrsi       zero, 0x344, 12
57:               divu         s8, s7, tp
58:               beq          sp, s11, 78f
59:               xor          a6, s2, t4
60:               ori          s6, tp, 1112
61:               blt          a4, a2, 71f
62:               mul          t0, a2, ra
63:               srli         a6, t2, 5
64:               slti         s0, s10, -1436
65:               slli         s11, t1, 7
66:               lui          s4, 460950
67:               slti         t5, t3, -509
68:               addi         t1, a4, -1289
69:               and          t0, t3, zero
                  la           s2, region_0+113 #start riscv_load_store_rand_instr_stream_19
                  or           s11, a5, s1
                  sltiu        a6, s2, 1730
                  rem          a6, a0, s7
                  slli         t5, t4, 31
                  lbu          t0, 1292(s2)
                  divu         a3, gp, s4
                  lb           t1, 1782(s2)
                  lui          gp, 952200
                  csrrs        s1, 0x305, zero
                  sra          s1, s3, a7
                  xor          s7, sp, s4
                  mulh         t1, a2, s0
                  mulhu        s8, sp, s5
                  sb           a4, 591(s2)
                  mulh         t0, s7, a6
                  mul          t2, t3, a5
                  srl          s8, s9, t3
                  lbu          s8, 960(s2)
                  lhu          a4, 647(s2)
                  sra          s1, s10, zero
                  mulhu        t6, a0, s4
                  sb           s9, 664(s2)
                  divu         t1, tp, s2
                  xor          t3, s8, s7
                  rem          zero, a3, s10
                  ori          s1, a3, -443
                  csrrw        s4, 0x304, s3
                  srai         a6, t0, 2
                  sub          t5, t3, a4
                  sb           sp, 541(s2)
                  mulhu        a1, t1, a0
                  mulhsu       t6, t4, a7
                  sub          s10, s7, a5
                  mul          t3, ra, s8
                  lh           s0, 129(s2)
                  lbu          t4, 1020(s2)
                  lb           s1, 436(s2)
                  div          gp, s0, s11
                  nop
                  xor          s6, a1, s9
                  lhu          s7, 1719(s2) #end riscv_load_store_rand_instr_stream_19
70:               sub          s4, tp, a6
71:               srl          a5, s0, s3
72:               div          a3, s0, a3
73:               beq          a2, s4, 75f
74:               nop
75:               csrrw        a1, 0x304, s7
76:               slti         s7, a6, 2028
77:               bltu         s9, s3, 93f
78:               rem          a7, s7, a7
79:               beq          a2, a3, 97f
80:               csrrw        t5, 0x304, a3
81:               rem          s4, s5, t5
82:               csrrwi       zero, 0x342, 8
83:               sub          s2, a7, s3
84:               bne          a5, s2, 91f
85:               rem          a1, t5, s3
86:               addi         a1, s8, 1981
87:               srli         a7, s6, 24
88:               srl          a5, ra, t0
89:               csrrw        s5, 0x342, s6
90:               slt          a7, s9, zero
91:               sub          s11, t0, a6
92:               xor          zero, s3, t2
93:               mulhu        ra, t3, a3
94:               slti         s2, a0, -169
95:               srli         s11, t5, 7
96:               mulhu        s3, a2, a4
97:               csrrwi       a3, 0x301, 30
98:               csrrs        zero, 0x305, zero
99:               xori         a3, sp, -1619
100:              rem          a7, a0, t1
101:              lui          gp, 807249
102:              sltiu        s1, zero, 1801
103:              bltu         sp, ra, 120f
104:              csrrc        s8, 0x343, s8
105:              auipc        s7, 1007253
106:              csrrw        s4, 0x304, ra
107:              sub          zero, s3, a0
108:              xori         s6, t0, -1096
109:              beq          t1, t1, 110f
110:              bltu         t6, s10, 127f
111:              blt          a5, s1, 113f
112:              xori         s9, t2, -1139
113:              csrrsi       t5, 0x343, 0
114:              srli         s9, s1, 5
115:              sll          zero, s8, t6
116:              csrrc        s1, 0x343, s6
117:              xor          a3, s8, t2
118:              or           a7, gp, s11
119:              lui          s3, 669400
120:              rem          s7, zero, zero
121:              andi         a2, zero, 995
122:              slt          a4, s2, zero
123:              rem          a3, s3, s11
124:              csrrs        a6, 0x342, zero
125:              srl          s8, gp, s2
126:              mulhu        t5, t1, s2
127:              add          a7, s0, s2
128:              sltiu        s9, a0, 1080
129:              sub          a5, s6, s0
130:              sub          t3, s3, s5
131:              slt          t5, t6, a5
132:              and          a6, s0, s11
133:              csrrs        a5, 0x342, zero
134:              divu         s4, a2, t4
135:              csrrci       s2, 0x301, 0
136:              bne          t1, s5, 149f
137:              div          a6, t5, zero
138:              blt          t0, t2, 147f
139:              mulhsu       t3, a7, t3
140:              divu         s1, zero, a0
141:              lui          s6, 917221
142:              mulhsu       a1, a3, t1
143:              beq          s7, a5, 144f
144:              lui          s10, 211868
145:              mulh         t2, s9, sp
146:              csrrci       a4, 0x304, 0
147:              csrrwi       gp, 0x342, 27
148:              andi         a1, a7, 1221
149:              slt          s11, gp, s3
150:              rem          a6, t3, a6
151:              csrrw        a5, 0x344, s5
152:              slli         t4, ra, 20
153:              sra          s2, tp, s6
154:              bge          a2, s11, 172f
155:              mulhu        ra, s2, ra
156:              lui          t3, 661826
157:              remu         s2, sp, s4
158:              csrrci       s11, 0x342, 0
159:              addi         s8, a7, 707
160:              xori         t1, zero, -1990
161:              sll          s4, sp, a4
162:              nop
163:              slti         s6, ra, -691
164:              auipc        s2, 495984
165:              bgeu         s10, s0, 185f
166:              blt          s1, s2, 175f
167:              lui          s10, 905307
168:              bne          t3, s5, 169f
169:              sltiu        t5, s6, -370
170:              auipc        s8, 925925
171:              ori          s5, s7, 1654
172:              csrrs        t1, 0x300, zero
173:              slli         s6, zero, 14
174:              beq          t3, a2, 192f
175:              add          t4, t1, t5
176:              nop
177:              xor          ra, s9, t0
178:              bne          a3, sp, 194f
179:              srai         t3, s5, 24
180:              rem          a2, s3, t1
181:              mul          t6, a6, a4
182:              slt          zero, t2, t4
183:              addi         s10, t0, 1357
184:              srai         a7, a3, 8
185:              sub          t4, s6, s0
186:              slt          s6, s0, a2
187:              xor          a5, s7, s11
188:              mul          t1, zero, t4
189:              srl          s9, s5, a0
190:              csrrci       a3, 0x344, 0
191:              mulhu        s6, a4, a1
192:              add          a6, s6, s11
193:              nop
194:              sltiu        s6, t6, -1466
195:              nop
196:              beq          t6, sp, 209f
197:              sltu         s1, s11, s2
198:              add          t1, s10, s8
199:              xori         a3, t1, 1787
200:              rem          s1, a7, a7
201:              sltiu        s0, t1, 1098
202:              csrrwi       gp, 0x344, 25
203:              add          a5, ra, a6
204:              blt          t2, t0, 208f
205:              srl          s6, a2, a5
206:              csrrc        s6, 0x304, zero
207:              bltu         s4, s1, 209f
208:              blt          a4, a0, 210f
209:              ori          t3, zero, 119
210:              rem          t5, s7, s9
211:              csrrsi       a5, 0x305, 0
212:              slli         a2, a3, 6
213:              mul          s8, s4, s11
214:              mulhu        a4, s1, gp
215:              csrrsi       s0, 0x300, 0
216:              slt          a3, t1, s7
217:              or           zero, a5, s10
218:              sltu         a1, t3, s3
219:              addi         s8, a6, 971
220:              mulhu        a5, a5, sp
221:              auipc        s4, 300691
222:              sub          t4, s2, a4
223:              nop
224:              lui          s0, 734461
225:              blt          s11, s1, 238f
226:              addi         a5, a1, -869
227:              andi         t0, s0, -1503
228:              sltiu        s4, t6, 1413
229:              slli         ra, s1, 21
230:              remu         s11, s9, s4
231:              sltiu        s1, a3, -1890
232:              and          a6, sp, tp
233:              ori          s1, s5, 1837
234:              slti         gp, t1, -1896
235:              ori          s3, s2, 1683
236:              sltiu        t2, s5, 1570
237:              and          a1, a1, a4
238:              csrrw        s9, 0x342, s11
239:              slt          t4, s6, zero
240:              mulhu        s5, sp, s4
241:              addi         s9, a7, 1510
242:              mulhu        a6, s3, t2
243:              srai         s1, s10, 7
244:              sll          s0, a3, t5
245:              bne          a6, s7, 247f
246:              csrrc        s7, 0x304, ra
247:              csrrw        a5, 0x304, s10
248:              auipc        s1, 666795
249:              addi         a2, t2, -1362
250:              mul          t6, s11, t5
251:              bne          ra, t0, 268f
252:              remu         t5, gp, t3
253:              sub          s2, t0, s1
254:              bge          a2, zero, 258f
255:              and          a2, a5, s8
256:              bne          t6, sp, 272f
257:              bltu         a6, t4, 258f
258:              srai         s7, s2, 28
259:              beq          gp, s6, 264f
260:              xori         t6, t2, 909
261:              sltiu        t1, s4, 100
262:              slt          s2, a3, a4
263:              or           s3, a7, a1
264:              csrrc        t3, 0x344, s0
265:              slli         a4, t2, 12
266:              csrrs        a4, 0x344, a1
267:              nop
268:              slti         t2, s10, -310
269:              csrrc        t5, 0x342, s6
270:              srai         t0, s2, 22
271:              and          a3, s0, tp
272:              sll          s7, s7, t5
273:              slli         s1, t6, 9
274:              mul          s9, t5, s0
275:              mul          s3, s2, s10
276:              div          s6, a7, sp
277:              div          t5, s10, t5
278:              or           s0, a6, s2
279:              csrrc        s1, 0x300, zero
280:              lui          s0, 585117
281:              sltu         t4, t3, a2
282:              bne          s6, t6, 302f
283:              sub          t1, t6, s5
284:              ori          zero, a1, -645
285:              sll          t2, s0, s8
286:              addi         s10, s9, 792
287:              csrrci       s7, 0x300, 0
288:              sll          t0, t3, s2
289:              rem          s1, t1, s9
290:              csrrwi       s8, 0x342, 18
291:              csrrw        a3, 0x344, t5
292:              slt          s2, sp, s5
293:              slli         zero, a7, 23
294:              addi         s2, sp, -615
295:              rem          t0, sp, s11
296:              beq          t4, a0, 314f
297:              srl          s8, a2, a4
298:              csrrwi       s8, 0x343, 21
299:              xor          s7, t0, s1
300:              divu         s11, s6, s11
301:              csrrw        s10, 0x342, a3
302:              bltu         s10, a3, 318f
303:              csrrsi       s0, 0x344, 6
                  la           s9, region_1+39646 #start load_store_instr_stream_0
                  la           s4, region_1+29487 #start load_store_instr_stream_1
                  sb           zero, -28(s4)
                  lw           t1, -2(s9)
                  lh           s2, 49(s4)
                  lb           a4, 1(s9)
                  lb           gp, -40(s4)
                  sb           a4, -9(s9)
                  lbu          s11, 41(s4)
                  lb           t3, -30(s4)
                  lhu          t3, 7(s4)
                  lbu          s0, -3(s9)
                  lbu          t1, -1(s9)
                  lb           s6, 18(s4) #end load_store_instr_stream_1
                  sb           s5, -7(s9) #end load_store_instr_stream_0
304:              xor          s4, gp, zero
305:              bne          s5, a7, 314f
306:              bne          a6, a7, 313f
307:              csrrwi       a2, 0x343, 25
308:              bge          s5, s9, 309f
309:              sub          a7, s9, t5
310:              mulhsu       s11, s6, s5
311:              andi         s6, t4, 1880
312:              div          s5, a7, s5
313:              auipc        t3, 599411
314:              rem          s4, t2, ra
315:              auipc        a3, 141259
316:              lui          gp, 997916
317:              csrrw        s0, 0x343, t0
318:              srl          s8, s8, a4
319:              nop
320:              slli         s0, s9, 15
321:              slli         s6, t6, 24
322:              csrrs        s9, 0x344, t2
323:              bgeu         tp, a2, 336f
324:              sltu         s11, t6, s10
325:              add          s9, a5, a3
326:              bgeu         a5, a6, 346f
327:              div          gp, zero, s2
328:              xori         s4, s3, -1638
329:              csrrwi       t1, 0x342, 19
330:              divu         s6, s5, s8
331:              sltiu        t6, gp, -1625
332:              bgeu         tp, t6, 352f
333:              andi         a1, s2, -2018
334:              sra          s10, a3, s2
335:              sltiu        s0, a2, 1084
336:              slti         s8, s2, 1842
337:              div          a3, t3, s5
338:              mulh         t3, s10, s0
339:              div          a5, s7, t3
340:              xori         a3, s4, -834
341:              srai         s9, s0, 11
342:              srai         t5, s7, 13
343:              srli         s7, a2, 25
344:              sltu         t0, s4, t2
345:              csrrsi       a7, 0x300, 0
346:              srai         s11, sp, 14
347:              slti         s9, s6, 698
348:              bltu         s9, s5, 357f
349:              csrrci       a4, 0x344, 0
350:              div          t3, zero, s0
351:              mulhu        a6, sp, gp
352:              mulhsu       t5, s11, s6
353:              bne          a0, s1, 363f
354:              mulh         ra, t4, s7
355:              ori          a6, t4, -975
356:              srl          s11, ra, s5
357:              add          s6, a4, s10
358:              and          s6, s4, t0
359:              mulhu        s1, s11, s5
360:              add          s0, s11, t5
361:              xor          s10, a3, zero
362:              rem          s0, s4, s9
363:              srai         t5, s0, 28
364:              mul          a6, s10, s8
365:              csrrs        s5, 0x342, zero
366:              mul          a3, a0, s0
367:              mulhsu       s1, t1, s8
368:              srai         s10, a1, 17
369:              bge          t1, a2, 371f
370:              bgeu         tp, s4, 388f
371:              blt          tp, s3, 382f
372:              bgeu         s11, s5, 373f
373:              csrrc        s6, 0x342, zero
374:              divu         t4, a4, sp
375:              csrrci       t0, 0x344, 0
376:              sra          t3, s7, s2
377:              csrrci       a5, 0x344, 21
378:              div          s1, t3, t0
379:              auipc        t2, 216102
380:              lui          s10, 450077
381:              srl          a4, gp, s7
382:              nop
383:              xori         s8, a1, -1834
384:              sltu         a4, gp, s11
385:              mulhsu       t3, t5, a1
386:              slt          t3, a1, a1
387:              slt          gp, s7, t4
388:              div          a3, zero, s10
389:              slli         t2, s4, 17
390:              srl          t1, s5, s6
391:              mulhu        s6, s1, a1
392:              or           s11, s3, tp
393:              add          s4, a7, s9
394:              mul          a7, s9, t1
395:              blt          s2, s7, 415f
396:              div          t5, a4, s8
397:              ori          s7, a7, -1308
398:              csrrs        s3, 0x305, zero
399:              rem          zero, tp, tp
400:              mulh         s5, t0, s6
401:              sub          s9, s7, t1
402:              srl          s8, s0, a4
403:              remu         t1, s0, s11
404:              mul          s3, s1, s6
405:              csrrw        t4, 0x344, a4
406:              srli         s7, a5, 5
407:              ori          a2, t5, -483
408:              ori          a4, a1, 685
409:              mul          a5, a7, a6
410:              bne          t1, a2, 419f
411:              sra          s8, t0, s9
412:              sra          t3, t0, a3
413:              andi         a6, zero, -1417
414:              bltu         s7, s0, 416f
415:              beq          a0, a2, 417f
416:              bgeu         t4, sp, 433f
417:              slli         s1, t4, 28
418:              csrrc        s1, 0x342, tp
419:              sub          s5, sp, s0
420:              rem          t5, a3, t0
421:              slt          a5, s10, t0
422:              srli         t3, a5, 11
423:              csrrci       ra, 0x342, 11
424:              xori         t2, t0, -163
425:              mulhu        a4, ra, s3
426:              ori          s5, a1, -1984
427:              div          t1, t6, t3
428:              addi         a5, s3, 1477
429:              bne          s5, a5, 445f
430:              div          t1, t5, tp
431:              csrrci       t4, 0x342, 0
432:              sltiu        s4, a3, 648
433:              bgeu         a2, a5, 451f
434:              csrrs        s9, 0x342, zero
435:              bgeu         tp, a5, 446f
436:              divu         a6, gp, s0
437:              rem          a1, t0, tp
438:              mulhu        s5, t1, s3
439:              mulhu        s2, a0, a2
440:              sub          s9, t4, s6
441:              bltu         a2, s1, 446f
442:              slli         s10, s11, 25
443:              mul          t2, t1, a0
444:              csrrs        t0, 0x305, zero
445:              csrrwi       t0, 0x343, 7
446:              bgeu         a4, s8, 448f
447:              csrrw        t3, 0x301, a3
448:              ori          a6, s8, -1849
449:              csrrwi       t1, 0x304, 22
450:              srai         zero, s0, 10
451:              mul          a5, s0, tp
452:              xor          s0, a7, zero
453:              mulhsu       t2, a7, zero
454:              srai         t0, s5, 21
455:              srai         s6, gp, 16
456:              divu         a6, a7, t2
457:              csrrsi       a7, 0x300, 0
458:              xor          a2, s3, s0
459:              bltu         s0, t2, 475f
460:              sltiu        t6, a7, 14
461:              andi         t3, ra, -283
462:              csrrw        s8, 0x301, t5
463:              slti         s10, a3, 210
464:              slt          gp, s4, a4
465:              remu         a6, t1, s0
466:              srl          t3, s8, s8
467:              bne          tp, s1, 483f
468:              csrrc        s4, 0x342, s1
469:              csrrwi       a2, 0x343, 31
470:              remu         ra, s10, s11
471:              sub          ra, zero, gp
472:              or           ra, a6, s0
473:              slt          a4, s3, t1
474:              csrrc        a2, 0x301, a0
475:              andi         a2, s3, -33
476:              csrrwi       a4, 0x343, 15
477:              csrrc        a1, 0x344, zero
478:              csrrs        s7, 0x304, a0
479:              csrrw        s3, 0x344, a1
480:              sll          gp, s9, s1
481:              mulhsu       a3, s8, zero
482:              mulhsu       t6, ra, s10
483:              srl          ra, tp, a0
484:              bne          s4, s11, 504f
485:              csrrwi       t6, 0x343, 9
486:              bltu         t5, s10, 495f
487:              csrrs        s3, 0x344, zero
488:              slli         s2, t5, 29
489:              slli         s2, s7, 10
490:              remu         t6, t4, tp
491:              ori          s7, gp, 14
492:              csrrci       a5, 0x304, 0
493:              and          a3, s4, a0
494:              divu         s1, gp, t4
495:              bne          s3, s5, 513f
496:              slt          s0, t6, t3
497:              divu         t2, a4, s7
498:              srai         gp, t4, 23
499:              mulhsu       a1, a5, a3
500:              rem          t0, tp, t4
501:              rem          a7, sp, s7
502:              div          zero, s7, a6
503:              mul          t6, s7, t4
504:              add          s1, a4, s10
505:              srai         a2, a4, 28
506:              slti         s0, s2, -1015
507:              or           s1, s0, s8
508:              sra          a1, a0, s9
509:              bne          a1, t0, 511f
510:              div          t6, a3, a5
511:              ori          zero, s6, -425
512:              mulhu        t6, s2, a0
513:              srai         a6, s11, 10
514:              bne          a4, s5, 531f
515:              divu         s2, t5, gp
516:              addi         s8, gp, -1863
517:              div          t1, zero, s2
518:              csrrs        ra, 0x305, zero
519:              remu         zero, s6, tp
520:              nop
521:              sll          a5, a4, ra
522:              srai         a5, a3, 22
523:              sll          s7, s1, s3
524:              addi         s11, s4, 124
525:              ori          t0, t0, -61
526:              mul          s3, ra, t4
527:              xor          a3, a1, a2
528:              mulh         gp, a4, a6
529:              nop
530:              add          s9, a3, a1
531:              addi         s10, s9, 2033
532:              beq          a7, s1, 534f
533:              srai         t4, a0, 24
534:              sra          t3, s8, a5
535:              sra          a6, a4, t2
                  la           a6, region_1+7718 #start riscv_hazard_instr_stream_6
                  sub          a5, s7, s7
                  slt          a5, a5, zero
                  add          s7, s7, s6
                  lbu          a5, 3(a6)
                  sh           t1, -48(a6)
                  sb           s6, -9(a6)
                  sh           s7, -52(a6)
                  andi         s7, a2, 1989
                  srl          s7, t1, a2
                  csrrsi       s6, 0x305, 0
                  lbu          s6, -53(a6)
                  csrrc        t1, 0x304, a2
                  sltiu        s7, s6, -1610
                  lh           s7, -20(a6)
                  srl          t1, s6, a2
                  and          a5, s7, t1
                  csrrw        t1, 0x301, zero
                  sltu         a5, a5, a5
                  sra          a2, a5, a2
                  sb           a2, -47(a6)
                  xori         s7, s6, -1664
                  slti         s6, t1, 1295
                  add          t1, a5, zero
                  sub          s7, a5, s6
                  sh           s6, 14(a6)
                  add          zero, t1, a2
                  slli         a5, a5, 6
                  lbu          a5, -29(a6)
                  lb           s7, -37(a6)
                  sltiu        t1, a2, -1966
                  sb           s7, -24(a6)
                  mul          a5, zero, a2
                  lbu          zero, -21(a6)
                  csrrc        zero, 0x343, t1
                  sb           zero, -19(a6)
                  xor          zero, zero, s6
                  lh           a2, -6(a6)
                  lw           s6, 50(a6)
                  remu         t1, a2, s7
                  sw           a2, 18(a6) #end riscv_hazard_instr_stream_6
536:              sll          a4, t0, t2
537:              srl          gp, a4, s1
538:              blt          zero, s10, 558f
539:              slt          s0, zero, tp
540:              add          s7, tp, t5
541:              mul          s8, a0, s11
542:              remu         t1, a7, s3
543:              or           s10, s6, a1
544:              bgeu         a7, s5, 564f
545:              mulhu        a2, a7, s6
546:              sltiu        t4, a7, 1950
547:              bne          a2, s5, 548f
548:              divu         s8, t6, tp
549:              div          s3, zero, a4
550:              xor          t3, a6, s9
551:              lui          a4, 999256
552:              ori          s6, s4, 1841
553:              xor          zero, tp, s6
554:              bge          s3, zero, 570f
555:              nop
556:              lui          a5, 423055
557:              xor          s8, a2, t1
558:              slli         a5, a2, 12
559:              divu         t2, sp, s10
560:              mulhu        a2, zero, a1
561:              add          zero, a3, gp
562:              bltu         s9, t3, 580f
563:              blt          tp, a7, 576f
564:              bgeu         a2, a5, 568f
565:              csrrci       s11, 0x304, 12
566:              auipc        s4, 731399
567:              divu         t0, s11, s2
568:              mul          s9, s0, a0
569:              ori          s7, a6, -968
570:              or           s0, gp, s4
571:              sra          s10, s11, s9
572:              blt          s1, a0, 590f
573:              csrrs        s1, 0x305, zero
574:              xori         s0, s2, 1747
575:              lui          a4, 426231
576:              rem          a1, a5, a3
577:              csrrci       t6, 0x301, 0
578:              xori         a1, a1, -792
579:              remu         gp, s4, s7
580:              bgeu         a4, t6, 582f
581:              csrrwi       a3, 0x343, 15
582:              bne          s7, s2, 583f
583:              divu         s7, s10, a7
584:              div          gp, t4, s7
585:              divu         t1, t1, s1
586:              srai         s9, s7, 12
587:              xor          a7, a5, a7
588:              div          s7, s11, a0
589:              auipc        s7, 574376
590:              bne          s5, sp, 599f
591:              divu         s8, a3, a6
592:              csrrsi       s8, 0x301, 14
593:              nop
594:              csrrc        a7, 0x342, s5
595:              bltu         s7, a3, 608f
596:              slli         gp, a7, 6
597:              sltiu        t1, t0, 1345
598:              add          t6, s3, t0
599:              csrrw        s9, 0x343, t5
600:              blt          s1, t3, 609f
601:              mulhu        a5, a5, t4
602:              csrrc        s4, 0x343, zero
603:              div          s0, a7, a5
604:              sltiu        s7, zero, -856
605:              rem          s9, s8, t4
606:              slti         t5, t6, -237
607:              blt          tp, s11, 627f
608:              divu         s6, t6, a3
609:              ori          a1, a3, -1359
610:              remu         s8, a2, a3
611:              mul          a2, a0, s6
612:              csrrc        s0, 0x305, zero
613:              add          s4, s5, a1
614:              srl          s11, t0, s6
615:              mulh         a1, t6, s4
616:              srli         s2, s1, 24
617:              sll          s10, s0, t4
618:              slt          s3, s7, a6
619:              bge          t4, s8, 636f
620:              slli         s10, t6, 12
621:              ori          a3, s6, -941
622:              srai         s10, gp, 6
623:              ori          s6, a5, 450
624:              xori         t4, s5, -1253
625:              beq          a7, t5, 635f
626:              andi         t6, a5, -1014
627:              csrrw        t6, 0x301, s1
628:              xor          zero, t6, t2
629:              csrrsi       a3, 0x305, 0
630:              remu         s11, s11, t1
631:              bltu         a7, s3, 633f
632:              slli         a6, t2, 16
633:              csrrsi       zero, 0x301, 0
634:              csrrs        t6, 0x300, zero
635:              bne          t3, a0, 642f
636:              csrrsi       a7, 0x343, 0
                  la           t5, region_1+36639 #start riscv_load_store_hazard_instr_stream_1
                  lbu          a3, 10(t5)
                  lbu          s3, 10(t5)
                  lw           s2, 1(t5)
                  sh           a7, 1(t5)
                  sb           s10, -15(t5)
                  sw           s9, -15(t5)
                  lb           ra, 15(t5)
                  sb           s8, 13(t5)
                  sw           a1, 13(t5)
                  lhu          t4, 13(t5)
                  sb           t0, -4(t5)
                  lb           s10, -4(t5)
                  srli         t2, t3, 31
                  lb           s7, 12(t5)
                  sb           gp, 12(t5)
                  lb           s0, 3(t5)
                  sb           zero, 12(t5)
                  lbu          a4, -6(t5)
                  lbu          a4, -8(t5) #end riscv_load_store_hazard_instr_stream_1
637:              mulhsu       t5, t0, a2
638:              srl          t6, s8, s0
639:              sll          t2, a0, t1
640:              blt          gp, tp, 641f
641:              lui          s7, 305033
642:              rem          zero, a4, t5
643:              blt          zero, s9, 659f
644:              andi         a6, s9, -755
645:              sltiu        t3, tp, 2025
646:              divu         t5, a5, s3
647:              slt          a5, t1, s9
648:              mulhu        s7, t2, t6
649:              srl          a2, a3, t4
650:              csrrc        t6, 0x344, zero
651:              and          a1, ra, s0
652:              add          s1, s8, s8
653:              bge          s8, s0, 655f
654:              bne          a3, a7, 656f
655:              ori          ra, a6, -724
656:              rem          a7, s7, t1
657:              xor          a2, zero, zero
658:              mulhsu       s7, t6, a7
659:              divu         a4, a3, gp
660:              blt          t1, s1, 662f
661:              sra          s5, s0, s11
662:              beq          s11, s1, 675f
663:              bne          s9, sp, 679f
664:              mulh         s6, t6, zero
665:              andi         a2, s0, 2027
666:              bgeu         a5, a3, 683f
667:              or           a3, s10, t3
668:              csrrwi       t3, 0x343, 10
669:              sra          s11, s2, tp
670:              bne          t4, gp, 690f
671:              sub          s1, s8, a0
672:              srl          gp, s11, a5
673:              mul          t4, t0, a1
674:              or           ra, zero, s1
675:              sltu         s7, s10, s8
676:              divu         t5, a3, s9
677:              lui          s0, 279158
678:              csrrwi       s7, 0x304, 3
679:              and          a3, t0, s3
680:              csrrw        t0, 0x342, s9
681:              lui          t4, 807479
682:              add          s11, t0, a2
683:              csrrw        t1, 0x342, a3
684:              sub          s5, s0, s4
685:              csrrw        t2, 0x342, t3
686:              slt          a6, s8, ra
687:              csrrwi       s11, 0x343, 14
688:              bge          s2, sp, 693f
689:              blt          a6, a3, 696f
690:              bgeu         s6, ra, 706f
691:              srli         s4, s5, 10
692:              mul          t0, s5, a4
693:              sltu         a5, tp, t4
694:              sltiu        t2, s6, 497
695:              blt          a1, s7, 704f
696:              lui          s0, 109847
697:              mulhsu       a2, a5, a2
698:              csrrw        a6, 0x343, a5
699:              mulhu        s7, a6, a1
700:              mulhsu       t4, s1, sp
701:              bne          s7, a0, 721f
702:              bltu         a4, s11, 704f
703:              or           a7, s8, gp
704:              sll          a6, gp, s8
705:              slti         a4, t2, -1767
706:              csrrwi       t0, 0x343, 3
707:              auipc        s1, 433280
708:              bne          t3, s0, 728f
709:              nop
710:              csrrci       s9, 0x304, 0
711:              bne          s11, s5, 721f
712:              slt          t4, t1, s6
713:              blt          t1, t3, 731f
714:              blt          s8, t0, 727f
715:              bge          s5, t1, 724f
716:              srli         s8, a5, 6
717:              bgeu         a3, a0, 734f
718:              srl          ra, a2, a4
719:              blt          a2, a3, 723f
720:              or           ra, zero, s11
721:              mulhsu       gp, s1, s10
722:              sltiu        s9, a5, -1395
723:              auipc        gp, 600748
724:              slli         a5, gp, 16
725:              ori          a6, sp, 649
726:              csrrsi       t5, 0x344, 0
727:              or           s2, a0, a7
728:              mul          t3, s7, a0
729:              xori         zero, a1, -647
730:              sll          a7, t5, s9
main_105:         jal          ra, 2f
0:                jal          t0, 16f
1:                jal          ra, 5f
2:                jal          s5, 1b
3:                jal          t1, 10f
4:                jal          ra, 7f
5:                jal          t0, 12f
6:                jal          ra, 11f
7:                jal          t1, 9f
8:                jal          ra, 21f
9:                jal          ra, 15f
10:               jal          ra, 14f
11:               jal          ra, 18f
12:               jal          t1, 8b
13:               jal          ra, 19f
14:               jal          s7, 20f
15:               jal          ra, 0b
16:               jal          ra, 13b
17:               jal          ra, 4b
18:               jal          t1, 17b
19:               jal          s2, 3b
20:               jal          ra, 22f
21:               jal          t1, 6b
22:               sub          a6, a2, a6
731:              and          t1, s1, s3
732:              bne          tp, a5, 741f
733:              srai         s6, s5, 3
734:              bge          tp, s1, 735f
735:              csrrci       a3, 0x300, 0
736:              addi         a4, t1, 1529
737:              csrrs        a6, 0x343, s4
738:              mulhsu       s3, a4, s6
739:              srai         ra, t5, 12
740:              csrrw        t1, 0x344, t2
741:              nop
742:              blt          t3, t0, 743f
743:              csrrwi       a5, 0x342, 31
744:              bgeu         s8, s0, 746f
745:              csrrw        s2, 0x342, s10
746:              bltu         s9, gp, 764f
747:              sra          a7, t1, zero
748:              csrrc        t3, 0x342, zero
749:              mulh         s2, s6, a6
750:              lui          a4, 339101
751:              sltiu        s7, a2, -1580
752:              csrrw        s11, 0x343, t6
753:              bne          t6, t3, 773f
754:              srl          s4, zero, a3
755:              div          s8, sp, s6
756:              divu         s4, zero, s5
757:              lui          a2, 445364
758:              csrrwi       s8, 0x304, 17
759:              csrrc        gp, 0x304, s0
760:              and          s6, a4, s0
761:              bltu         zero, t3, 762f
762:              andi         t0, t3, 1213
763:              sll          s2, s7, t0
764:              div          s9, t2, a5
765:              auipc        s3, 1042916
766:              xori         a3, s10, 1030
767:              sll          t4, s10, a6
768:              rem          t3, t0, t5
769:              mulhsu       a4, s2, t2
770:              srl          s1, t4, gp
771:              add          s11, s3, ra
772:              mulhu        a1, t1, s5
773:              xor          s10, s2, t2
774:              lui          t5, 90944
775:              lui          s4, 667502
776:              slt          ra, t0, t6
777:              bne          a6, a6, 788f
778:              mulhsu       t5, a6, t3
779:              or           zero, t1, s6
780:              nop
781:              beq          s10, a0, 799f
782:              srai         s5, s0, 27
783:              auipc        t1, 358140
784:              csrrci       a4, 0x304, 0
785:              andi         s6, s5, -582
786:              csrrw        a3, 0x304, tp
787:              slt          s2, t4, s6
788:              sra          t1, t0, zero
789:              mulhsu       s0, t0, a6
790:              mulhsu       a6, s7, s3
791:              xor          t5, a6, a7
792:              bgeu         t3, t0, 805f
793:              rem          ra, s10, s5
794:              bgeu         s11, s10, 811f
795:              div          t1, t2, a5
796:              slt          a2, s6, s5
797:              srl          s6, gp, s11
798:              remu         a1, s9, gp
799:              csrrci       t6, 0x344, 1
800:              bne          s11, s3, 801f
801:              bgeu         s1, a6, 810f
802:              addi         t2, s6, -1488
803:              srli         zero, a3, 31
804:              srl          a4, a1, s6
805:              srli         s6, a6, 1
806:              add          s1, t6, s5
807:              auipc        s5, 385779
808:              slli         s4, s6, 27
809:              lui          s1, 701053
810:              srli         t6, s2, 8
811:              xori         s9, s6, -507
812:              blt          a2, t5, 823f
813:              csrrci       s3, 0x343, 16
814:              mul          ra, t3, s5
815:              ori          t5, s0, -1657
816:              lui          t6, 565449
817:              csrrwi       s1, 0x344, 13
818:              sll          t6, sp, ra
819:              sra          zero, t0, t0
820:              bgeu         s6, s2, 830f
821:              and          s8, a6, a3
822:              bgeu         s11, s3, 838f
823:              blt          s5, tp, 836f
824:              divu         a7, s3, t4
825:              srli         t0, a5, 1
826:              or           t2, tp, s7
827:              and          gp, a4, t6
828:              bne          a4, a7, 837f
829:              remu         a1, s9, zero
830:              beq          s11, t2, 832f
831:              bltu         tp, t4, 836f
832:              sub          a2, t2, a5
833:              sltiu        zero, s3, -829
834:              csrrci       t4, 0x300, 0
835:              csrrw        s1, 0x301, s7
836:              mul          t6, s2, s1
837:              bgeu         sp, a2, 839f
838:              or           s3, tp, s4
839:              div          s7, a4, a6
840:              xor          s11, t4, a4
841:              srai         s5, gp, 25
842:              addi         gp, t5, 241
843:              sltu         zero, a2, s5
844:              mul          t3, s5, a0
845:              and          s1, s11, s7
846:              csrrs        s6, 0x304, zero
847:              bgeu         zero, s8, 849f
848:              csrrs        t5, 0x305, zero
849:              bne          s8, s10, 865f
850:              bge          s6, s6, 870f
851:              bne          ra, s1, 868f
852:              mulhu        a1, a2, a2
853:              srli         a7, tp, 27
854:              blt          gp, s1, 863f
855:              bge          s11, ra, 859f
856:              sra          a5, gp, s10
857:              sra          a6, t6, zero
858:              blt          a1, s4, 874f
859:              csrrw        s8, 0x304, s3
860:              remu         s5, s2, s1
861:              add          t0, s8, a1
862:              mul          s2, a2, s3
863:              andi         s4, t1, 684
864:              mulhu        a5, a1, s2
865:              sra          s2, t6, s7
866:              xori         s11, a7, 2026
867:              blt          s11, s3, 869f
868:              csrrwi       s0, 0x304, 20
869:              lui          t5, 579571
870:              xori         ra, a4, 644
871:              blt          ra, s5, 873f
872:              addi         a1, sp, -699
873:              andi         s10, a2, 1226
874:              bge          a5, t2, 894f
875:              addi         ra, s7, 1785
876:              andi         s9, a1, -85
877:              sll          s10, sp, gp
878:              slli         t1, s4, 27
879:              ori          t2, t0, -1861
880:              andi         a1, t4, -1789
881:              sltu         s6, a6, s8
882:              andi         a7, s10, -1560
883:              sll          gp, a2, gp
884:              ori          t5, s2, -372
885:              slt          s7, t5, a0
886:              andi         ra, t0, -876
887:              bne          t4, a4, 905f
888:              divu         t3, t2, s9
889:              bge          t6, zero, 890f
890:              sra          s9, a4, a0
891:              remu         a7, s10, a5
892:              ori          gp, s10, -1888
893:              srai         t5, zero, 14
894:              ori          s5, s7, -227
895:              csrrci       a4, 0x342, 4
896:              bltu         t0, s4, 897f
897:              mul          t4, s3, s1
898:              mulhu        a6, s3, t5
899:              andi         zero, s8, 420
900:              slti         t6, s11, 898
901:              add          s0, t0, s8
902:              addi         t4, t0, -1841
903:              divu         s10, a4, a7
904:              remu         s0, a6, zero
905:              beq          s11, s10, 925f
906:              or           s2, s5, s9
907:              csrrci       t5, 0x344, 0
908:              csrrw        s6, 0x344, a4
909:              addi         t2, gp, -663
910:              srli         s0, s3, 25
911:              remu         zero, s7, s5
912:              andi         ra, t2, -1158
913:              slt          a6, s2, s3
914:              rem          a5, s3, t0
915:              nop
916:              div          a1, t0, s1
917:              srli         s0, t3, 19
918:              csrrc        s0, 0x305, zero
919:              bgeu         s8, s6, 926f
920:              sub          a1, tp, a5
921:              mul          s9, sp, a2
922:              beq          s9, a7, 942f
923:              csrrw        t5, 0x304, t4
924:              bne          zero, t1, 942f
925:              bltu         s9, s8, 943f
926:              csrrsi       t2, 0x344, 0
927:              rem          t3, a6, s1
928:              remu         a2, a3, t6
929:              slli         a4, gp, 18
930:              srli         s5, t1, 13
931:              andi         t4, s3, 1450
932:              lui          s1, 491646
933:              srl          zero, t4, a3
934:              csrrc        a6, 0x301, t6
935:              sltiu        s9, zero, -188
936:              sra          t1, t2, gp
937:              divu         a4, s0, a3
938:              bgeu         s3, s2, 949f
                  la           a5, region_1+55907 #start load_store_instr_stream_1
                  la           t2, region_0+2993 #start load_store_instr_stream_0
                  lh           t4, 1(a5)
                  sb           s3, -791(t2)
                  lbu          s5, -18(a5)
                  lh           s0, 433(t2)
                  lbu          s5, 11(a5)
                  lbu          s3, -62(a5)
                  lhu          s3, 953(t2)
                  sb           s5, -53(a5)
                  lb           s5, -845(t2)
                  sb           sp, -32(a5) #end load_store_instr_stream_1
                  sb           zero, -441(t2)
                  lbu          s2, 398(t2) #end load_store_instr_stream_0
939:              rem          a4, a1, t3
940:              bge          s2, t1, 960f
941:              csrrw        s5, 0x343, a3
942:              slli         gp, s10, 17
943:              srli         gp, gp, 27
944:              sra          gp, t1, s1
945:              sub          s10, a7, s4
946:              csrrs        s11, 0x304, zero
947:              sltu         t0, s7, t2
948:              slli         a4, t4, 10
949:              ori          s7, s5, 86
950:              xor          s9, t4, tp
951:              xori         s6, s3, 1362
952:              lui          zero, 607922
953:              mulhsu       a3, t5, a4
954:              slti         t5, s0, 1655
955:              sra          t1, s9, s1
956:              sra          t6, a5, t6
957:              sltiu        a6, a2, 1456
958:              csrrc        zero, 0x300, zero
959:              mulhsu       zero, t4, s1
960:              xori         a5, a1, 1171
961:              sub          s6, t0, t5
962:              andi         s4, a0, -1095
963:              lui          s5, 41008
964:              slt          s10, s8, a2
965:              sra          t6, s6, a6
966:              mul          s5, zero, a7
967:              divu         s2, ra, t4
968:              div          s3, s9, s3
969:              divu         a2, a0, s3
970:              csrrwi       a5, 0x343, 6
971:              and          a4, s0, t6
972:              bne          a0, a6, 974f
973:              xori         gp, a5, -342
974:              rem          s5, s8, a3
975:              lui          s3, 815392
976:              blt          s9, a7, 993f
977:              slti         t1, s8, -2024
978:              csrrsi       t2, 0x305, 0
979:              sra          ra, gp, t1
980:              csrrc        ra, 0x342, zero
981:              sltiu        t2, zero, 1213
982:              divu         a2, a4, sp
983:              csrrw        a1, 0x344, zero
984:              srli         s9, a3, 3
985:              slt          t0, t2, a7
986:              csrrwi       t2, 0x343, 7
987:              rem          t6, a5, t0
988:              auipc        t6, 987358
989:              addi         a7, s5, 1683
990:              andi         a1, s3, -109
991:              sll          t5, s10, t6
992:              andi         s7, s6, 1748
993:              srli         a7, s3, 8
994:              csrrs        a1, 0x305, zero
995:              div          a3, a0, sp
996:              sub          gp, t0, a1
997:              mulh         t2, t0, a0
998:              sltu         a5, s10, s0
999:              slli         s1, s10, 10
1000:             mulhsu       s9, gp, s10
1001:             remu         a6, tp, t4
1002:             remu         s4, t4, s2
1003:             or           s6, t4, a7
1004:             sltu         ra, t0, a0
1005:             sra          s1, t5, s11
1006:             auipc        s6, 416811
1007:             bge          t0, s3, 1017f
1008:             or           ra, s4, a5
1009:             auipc        a6, 578231
1010:             csrrci       zero, 0x300, 0
1011:             csrrw        s7, 0x301, a4
1012:             beq          s2, s0, 1032f
1013:             sra          s9, s10, s3
1014:             bltu         t6, gp, 1015f
1015:             lui          t3, 447530
1016:             and          a7, ra, s2
1017:             or           a5, s10, s10
1018:             xor          gp, t0, s8
1019:             slt          t5, a0, sp
1020:             bne          gp, s2, 1021f
1021:             srli         s9, s7, 9
1022:             slti         t4, zero, 1371
1023:             ori          t0, a0, -141
1024:             csrrs        s11, 0x343, zero
1025:             xor          s8, t3, s8
1026:             rem          s3, a5, s0
1027:             remu         s5, a6, zero
1028:             or           s1, s4, s5
1029:             sra          gp, t2, s10
1030:             slli         s9, s2, 30
1031:             or           t3, s9, a6
1032:             bne          tp, s10, 1050f
1033:             divu         a3, s1, tp
1034:             bne          t6, t4, 1051f
1035:             srli         t5, ra, 12
1036:             beq          tp, s6, 1052f
1037:             blt          t3, a1, 1039f
1038:             andi         t5, a0, -1984
1039:             sll          t5, s0, s0
1040:             lui          s3, 37584
1041:             csrrci       t1, 0x343, 30
1042:             srli         zero, t5, 8
1043:             csrrsi       t1, 0x342, 0
1044:             divu         s10, s3, t0
1045:             slt          s10, s0, s3
1046:             csrrs        t4, 0x344, zero
1047:             csrrwi       s7, 0x343, 13
1048:             bltu         t2, a4, 1053f
1049:             sub          zero, a2, gp
1050:             bgeu         a3, t0, 1052f
1051:             sub          a1, t3, tp
1052:             blt          t0, t1, 1065f
1053:             sltiu        t4, t6, 1180
1054:             csrrci       s3, 0x300, 0
1055:             mulhsu       zero, a6, s4
1056:             sra          s0, a5, a6
1057:             ori          s0, a4, 1560
1058:             srl          s9, s4, a6
1059:             beq          gp, a1, 1079f
1060:             sub          a3, s4, s11
1061:             csrrci       t2, 0x344, 0
1062:             slt          s8, s2, s4
1063:             add          zero, a4, t3
1064:             slt          t6, tp, t1
1065:             slli         s11, s2, 18
1066:             csrrc        s1, 0x304, zero
1067:             remu         s1, s0, s6
1068:             mulh         a3, zero, a2
1069:             divu         t3, a0, s2
1070:             mulhu        t1, a4, t4
1071:             mulh         s7, a0, a7
1072:             xori         s0, t3, -564
1073:             rem          a1, t3, zero
1074:             srli         s4, s10, 31
1075:             blt          s5, s10, 1091f
1076:             ori          s1, a7, 967
1077:             bltu         s0, s2, 1086f
1078:             csrrw        t1, 0x343, gp
1079:             csrrci       t0, 0x343, 2
1080:             slt          s7, gp, a5
1081:             bgeu         a1, t4, 1094f
1082:             blt          a2, t5, 1091f
1083:             addi         a6, a4, 1452
1084:             sltiu        s11, sp, 453
1085:             csrrsi       zero, 0x342, 0
1086:             srli         s7, a0, 11
1087:             beq          s1, s11, 1105f
1088:             and          s8, a1, s8
1089:             bne          t3, a4, 1093f
1090:             csrrc        t4, 0x342, zero
1091:             sll          t5, s8, s10
1092:             add          s3, tp, a3
1093:             mulhu        t5, zero, t3
1094:             add          s9, t4, a2
1095:             csrrw        s7, 0x342, s10
1096:             andi         t0, a3, 1854
1097:             slti         a2, t6, 1253
1098:             auipc        t5, 31176
1099:             sltu         s9, s9, s1
1100:             srl          s1, a3, s11
1101:             auipc        a6, 880293
1102:             nop
1103:             slti         ra, s6, -1700
1104:             rem          gp, t0, s8
1105:             add          s1, tp, t6
1106:             sra          s5, s0, t6
1107:             srli         s7, a1, 12
1108:             divu         s1, s11, tp
1109:             xor          a1, s3, s4
1110:             remu         t2, t0, zero
1111:             csrrwi       a2, 0x344, 23
1112:             xor          a4, s3, gp
1113:             csrrc        s3, 0x301, zero
1114:             sltu         s5, gp, a2
1115:             mul          a4, a0, s10
1116:             beq          gp, a5, 1117f
1117:             add          t2, s11, t1
1118:             sra          a7, s11, zero
1119:             div          s11, t4, t3
1120:             srli         a1, s1, 19
1121:             mul          t4, t3, s7
1122:             lui          t5, 772240
1123:             sra          a5, s0, a5
1124:             bgeu         a0, a4, 1142f
1125:             sra          ra, ra, a7
1126:             srl          ra, zero, zero
1127:             mulhsu       ra, s7, t0
1128:             bne          t2, a0, 1137f
1129:             lui          s2, 341665
1130:             csrrs        ra, 0x344, zero
1131:             lui          zero, 154708
1132:             and          s5, s6, zero
1133:             nop
1134:             slli         t5, zero, 22
1135:             beq          sp, s4, 1151f
1136:             xori         s9, sp, -442
1137:             slti         t5, s3, 1048
1138:             slti         a5, s8, 590
1139:             sltu         t3, a4, a4
1140:             and          s10, s11, s8
1141:             mul          t6, a6, sp
1142:             div          s2, s6, s7
1143:             sltiu        a1, a6, 846
1144:             sltiu        t4, s7, 1727
1145:             mulhsu       t5, a2, s5
1146:             srl          s1, t1, a0
1147:             sra          s6, t5, a1
1148:             bltu         s10, a6, 1168f
1149:             mulh         s10, a3, s4
1150:             bge          tp, t5, 1152f
1151:             csrrs        t2, 0x344, gp
1152:             remu         s8, s10, a0
1153:             sltu         zero, zero, zero
1154:             bgeu         s8, s0, 1156f
1155:             mulhsu       a7, t3, s7
1156:             ori          a6, a1, -1238
1157:             rem          s6, a7, s11
1158:             slti         s5, zero, -262
1159:             csrrwi       a3, 0x343, 6
1160:             rem          t2, s7, s10
1161:             blt          s10, ra, 1168f
1162:             sltiu        s7, a4, 494
1163:             blt          ra, s3, 1164f
1164:             sll          a4, ra, t6
1165:             slli         a6, s7, 10
1166:             xor          s5, t2, s1
1167:             andi         s3, a4, 1621
1168:             srai         s2, a6, 11
1169:             slt          a4, t5, t5
1170:             beq          gp, s0, 1188f
1171:             rem          t2, tp, s4
1172:             and          zero, s5, a6
1173:             and          gp, a3, s0
1174:             blt          gp, sp, 1183f
1175:             srli         t3, t2, 7
1176:             csrrsi       t2, 0x342, 0
1177:             auipc        a3, 630492
1178:             mul          s4, a0, t1
1179:             bltu         a5, a0, 1197f
1180:             mulhsu       t5, ra, s11
1181:             csrrsi       s3, 0x301, 14
1182:             mul          gp, s6, s0
1183:             srl          s11, s11, s7
1184:             mulhu        s11, s3, t3
1185:             srl          s4, s1, s11
1186:             divu         ra, sp, t2
1187:             or           s3, a7, a0
1188:             div          t5, t4, t2
1189:             sra          a1, t0, s2
1190:             and          a7, gp, a6
1191:             mulh         s3, t1, tp
1192:             sltiu        gp, sp, 1391
1193:             csrrsi       s11, 0x301, 12
1194:             beq          s4, s5, 1203f
1195:             rem          s3, a4, s10
1196:             csrrci       s5, 0x342, 0
1197:             bltu         s11, s6, 1208f
1198:             addi         s10, a4, 367
1199:             xor          a2, s0, s8
1200:             csrrw        s1, 0x304, a3
1201:             csrrc        a1, 0x342, ra
1202:             bge          s7, s3, 1204f
1203:             rem          t1, s5, s3
1204:             slti         t1, t3, 170
1205:             mulh         a6, s8, s10
1206:             divu         a4, s11, a5
1207:             csrrci       s7, 0x343, 16
1208:             slli         s11, s5, 17
1209:             andi         a6, t6, -701
1210:             slti         t3, t0, -1334
1211:             slti         ra, s0, 1585
1212:             bltu         s6, t2, 1232f
1213:             csrrci       t6, 0x343, 0
1214:             addi         gp, a6, -315
1215:             csrrc        gp, 0x301, s0
1216:             csrrs        t4, 0x301, s1
1217:             csrrwi       s0, 0x304, 25
1218:             bgeu         a7, zero, 1220f
1219:             or           s9, t4, s7
1220:             mulhu        a5, s6, t1
1221:             mulhu        s9, ra, t4
1222:             csrrw        a1, 0x304, s8
1223:             nop
1224:             andi         s1, t0, 1300
1225:             csrrc        s5, 0x344, s4
1226:             csrrw        t1, 0x304, s7
1227:             mulhu        s4, s1, a5
1228:             bge          a4, a1, 1248f
1229:             bge          s0, a6, 1239f
1230:             csrrci       a3, 0x305, 0
1231:             csrrwi       s8, 0x304, 3
1232:             remu         s0, t5, t3
1233:             andi         s9, s11, -49
1234:             sll          t5, gp, s10
1235:             auipc        s11, 955453
1236:             divu         t6, ra, a3
1237:             sll          t6, ra, a5
1238:             slli         gp, a6, 16
1239:             mulh         gp, s1, a2
1240:             sub          a2, s11, t2
1241:             addi         a6, t1, -787
1242:             csrrc        s5, 0x304, s1
1243:             bge          a1, a1, 1259f
1244:             addi         t2, t3, -987
1245:             srai         a4, t5, 17
1246:             lui          a7, 380457
1247:             bltu         s4, t6, 1249f
1248:             sll          t3, s2, s1
1249:             csrrw        a3, 0x342, s8
1250:             xori         s8, t1, 1914
1251:             sltiu        a1, t0, 1867
1252:             ori          s8, zero, 1322
1253:             sll          t4, s10, gp
1254:             srli         s2, a3, 15
1255:             srli         s6, t2, 14
1256:             nop
1257:             and          s4, s2, a3
1258:             bltu         a6, t1, 1271f
1259:             bge          t6, s2, 1260f
1260:             sll          a7, t4, s2
1261:             rem          s4, a1, s11
1262:             nop
1263:             csrrc        t5, 0x304, zero
1264:             mulhsu       t6, a1, s8
1265:             and          t0, t0, s2
1266:             csrrs        s5, 0x300, zero
1267:             div          a7, a5, s5
1268:             addi         t5, t3, -336
1269:             csrrw        s9, 0x342, s10
1270:             sra          a7, t5, a6
1271:             and          s7, a5, t2
1272:             andi         a3, s8, -442
1273:             mul          ra, gp, s0
1274:             auipc        t6, 359361
1275:             xor          s1, a7, s11
1276:             csrrw        s8, 0x301, s8
1277:             mul          s6, t5, a7
1278:             bltu         s4, a7, 1287f
1279:             bgeu         s7, s10, 1299f
1280:             csrrc        a6, 0x343, s6
1281:             ori          a7, t0, -1393
1282:             divu         s8, ra, s9
1283:             csrrc        s6, 0x305, zero
1284:             mulh         gp, t1, a7
1285:             div          t5, a0, t0
1286:             div          a3, sp, s10
1287:             remu         s9, s7, t6
1288:             bgeu         t5, a6, 1308f
1289:             auipc        s4, 201278
1290:             bge          s10, sp, 1291f
1291:             mulhsu       t3, a3, a2
1292:             srl          s1, a1, s5
1293:             csrrsi       zero, 0x343, 0
1294:             csrrsi       zero, 0x304, 0
1295:             bne          s6, a1, 1302f
1296:             blt          s5, s3, 1298f
1297:             and          s10, ra, s5
1298:             csrrsi       a2, 0x342, 0
1299:             srai         a4, a2, 16
1300:             remu         a1, s2, t6
1301:             and          zero, t4, s2
1302:             beq          a2, s0, 1304f
1303:             csrrwi       a1, 0x343, 14
1304:             addi         s2, t6, -360
1305:             bltu         s8, s6, 1321f
1306:             sltu         a1, s5, s6
1307:             slti         a6, a5, -287
1308:             mul          zero, s2, a1
1309:             rem          a1, s1, s9
1310:             srl          s5, s11, s8
1311:             div          s0, s2, s0
1312:             addi         t1, s10, 1084
1313:             nop
1314:             rem          s8, a0, s7
1315:             andi         t1, t0, -1894
1316:             auipc        t5, 1039581
1317:             and          s1, zero, gp
1318:             mulhu        gp, t0, s5
1319:             divu         s10, t4, t3
1320:             andi         s5, a2, 1010
1321:             csrrwi       s0, 0x344, 16
1322:             or           t3, s3, a7
1323:             bge          t4, tp, 1341f
1324:             csrrci       s8, 0x344, 12
1325:             sltiu        t5, a6, 468
1326:             auipc        t6, 641225
1327:             bne          t5, s2, 1343f
1328:             beq          t3, a0, 1345f
1329:             divu         t6, s10, a4
1330:             slli         ra, s0, 26
1331:             mul          gp, s4, s0
1332:             bltu         sp, t2, 1337f
1333:             divu         a6, s4, t4
1334:             bltu         t5, a2, 1338f
1335:             sub          s2, s5, a0
1336:             bge          a5, s4, 1349f
1337:             csrrs        s1, 0x305, zero
1338:             sub          s8, t6, a7
1339:             csrrwi       s11, 0x304, 1
1340:             and          a7, sp, s2
1341:             or           zero, a7, a3
1342:             div          s1, s9, sp
1343:             xor          t1, a5, zero
1344:             bgeu         ra, s6, 1361f
1345:             slti         s3, a3, 53
1346:             nop
1347:             lui          s7, 115268
1348:             slli         a5, t0, 4
1349:             bltu         a5, s7, 1367f
1350:             and          s1, a0, a7
1351:             csrrci       t1, 0x305, 0
1352:             srai         a1, t4, 13
1353:             lui          t1, 955336
1354:             sra          a5, s9, ra
1355:             sll          a6, a2, a5
1356:             mulhsu       a3, s9, s10
1357:             mulhu        a1, s7, a5
1358:             or           t6, t6, s2
1359:             slli         s8, t2, 27
1360:             sltiu        s0, a3, -1498
1361:             srl          a2, a5, s2
1362:             bltu         ra, a0, 1373f
1363:             sltiu        s11, a2, -1428
1364:             srai         t0, a4, 14
1365:             xori         ra, s4, 387
1366:             mulh         ra, zero, t3
1367:             srli         s6, s4, 25
1368:             mulhu        s2, t0, t4
1369:             or           s4, a2, sp
1370:             bge          a2, s3, 1387f
1371:             srl          t5, t1, t6
1372:             bne          s10, a4, 1385f
1373:             add          s7, s7, a2
1374:             add          gp, sp, a4
1375:             slt          s1, t4, a7
1376:             divu         s11, s5, s6
1377:             lui          t4, 402938
1378:             mulh         a3, a6, t4
1379:             auipc        t0, 656258
1380:             addi         t1, a7, 1398
1381:             sll          a2, a7, s7
1382:             csrrwi       a1, 0x342, 26
1383:             csrrwi       s6, 0x344, 1
1384:             slti         s3, s10, 1702
1385:             addi         a5, tp, -24
1386:             sra          a3, a6, a4
1387:             remu         zero, a6, t0
1388:             csrrwi       s11, 0x342, 29
1389:             sra          t3, a1, a4
1390:             bge          a6, a7, 1392f
1391:             csrrwi       a4, 0x343, 18
1392:             div          t2, a7, s9
1393:             mulh         a7, a5, s6
1394:             csrrwi       s7, 0x304, 5
1395:             blt          t4, sp, 1415f
1396:             bgeu         s4, t4, 1406f
1397:             blt          s2, s8, 1417f
1398:             sltu         a7, s6, s5
1399:             csrrci       s2, 0x342, 0
1400:             csrrw        zero, 0x343, s1
1401:             csrrs        a6, 0x300, zero
1402:             blt          s9, a2, 1415f
1403:             add          t5, s11, a6
1404:             addi         s10, s7, 1330
1405:             rem          a6, a7, s6
1406:             or           zero, s5, t6
1407:             csrrsi       s2, 0x304, 27
1408:             srai         t0, s5, 13
1409:             bgeu         s3, s4, 1416f
1410:             auipc        s2, 394660
1411:             slti         gp, s2, 436
1412:             bltu         a2, s8, 1429f
1413:             csrrwi       s4, 0x342, 31
1414:             sll          t2, s11, a7
1415:             csrrci       s10, 0x305, 0
1416:             ori          s8, s9, 1374
1417:             xori         a5, t5, -759
1418:             slti         a3, a7, 1748
1419:             slti         t3, s9, 1330
1420:             srai         s11, s8, 15
1421:             andi         s7, s0, -724
1422:             mulhsu       t5, s0, s7
1423:             or           a2, t6, t3
1424:             andi         s7, s7, -804
1425:             ori          a4, s11, 884
1426:             lui          t4, 476427
1427:             or           s3, s8, s7
1428:             csrrsi       a1, 0x342, 14
1429:             bge          a7, gp, 1447f
1430:             csrrsi       a7, 0x301, 16
1431:             nop
1432:             csrrsi       t5, 0x342, 0
1433:             srli         a5, t2, 28
1434:             srl          s6, s9, t3
1435:             csrrc        a2, 0x301, zero
1436:             div          a6, s2, s10
1437:             or           a3, s7, t4
1438:             sra          s11, tp, a1
1439:             slti         a7, s7, -1169
1440:             sltiu        s5, s3, -478
1441:             csrrw        t5, 0x342, s0
1442:             ori          t1, gp, 1158
1443:             slt          s7, s8, a2
1444:             addi         a5, zero, -69
1445:             srai         a7, tp, 8
1446:             sra          s7, t1, gp
1447:             srli         a1, a6, 27
1448:             xori         t3, a0, -1700
1449:             div          s10, s8, t4
1450:             sll          s7, a6, a7
1451:             sll          t6, t0, s7
1452:             auipc        t5, 266040
1453:             nop
1454:             sll          t5, s4, s7
1455:             mul          t6, s7, s3
1456:             sltiu        t3, a1, 1536
1457:             mulhsu       s1, a1, s8
1458:             sltu         a2, a6, s2
1459:             rem          a4, zero, a3
1460:             ori          a3, s0, -535
1461:             add          t5, t1, s4
1462:             blt          s7, ra, 1464f
1463:             nop
1464:             srl          s2, s10, a2
1465:             mulh         s11, t1, t5
1466:             xori         s1, s3, 38
1467:             lui          a7, 539129
1468:             sltiu        a4, a1, -248
1469:             and          s11, t2, t1
1470:             slti         s3, gp, -1132
1471:             blt          a7, s7, 1480f
1472:             mulhu        a6, s6, s9
1473:             srli         ra, a7, 16
1474:             addi         a5, tp, 521
1475:             sll          s6, s6, s7
1476:             slti         s8, t6, -1384
1477:             csrrci       a5, 0x301, 17
1478:             slti         s5, s6, -728
1479:             sub          a4, ra, s10
1480:             csrrci       t4, 0x343, 15
1481:             bgeu         ra, s5, 1497f
1482:             csrrsi       a1, 0x301, 20
1483:             srai         s8, t3, 11
1484:             slt          s9, a6, t6
1485:             srai         t1, a3, 21
1486:             bne          s9, t3, 1491f
1487:             sra          t0, s6, s0
1488:             remu         s9, t6, tp
1489:             mulh         s5, s1, t6
1490:             slti         gp, s1, -1428
1491:             bne          zero, s4, 1492f
1492:             addi         s10, s7, 1332
1493:             slt          t3, s1, t5
1494:             srli         a4, s3, 12
1495:             addi         t5, gp, -34
1496:             and          a5, s0, t1
1497:             bge          zero, a3, 1498f
1498:             sltiu        s2, a1, 1738
1499:             sltu         gp, s11, t1
1500:             sra          s6, s3, a0
1501:             lui          s1, 731129
1502:             bne          t1, a1, 1503f
1503:             slt          s0, s10, a6
1504:             beq          a2, s4, 1506f
1505:             csrrsi       t5, 0x344, 0
1506:             csrrs        a6, 0x300, zero
1507:             div          s10, t6, s0
1508:             andi         s2, ra, 1853
1509:             divu         ra, t5, s8
1510:             mulhu        s2, s4, t0
1511:             divu         s0, a2, s3
1512:             srli         a7, a4, 9
1513:             bge          s2, a5, 1522f
1514:             srli         t0, s9, 5
1515:             xor          t3, tp, ra
1516:             mulhsu       s6, t3, a6
1517:             andi         s10, a1, -1654
1518:             srli         t2, t2, 30
1519:             bge          sp, s2, 1523f
1520:             beq          s10, a1, 1536f
1521:             sltiu        s3, gp, -283
1522:             csrrci       zero, 0x342, 1
1523:             sub          s9, s5, s9
1524:             slli         t6, s7, 20
1525:             sll          gp, s1, ra
1526:             divu         s10, a7, t0
1527:             csrrc        s5, 0x344, t6
1528:             csrrci       ra, 0x342, 0
1529:             mul          t0, s7, s9
1530:             or           zero, t6, s1
1531:             csrrsi       a7, 0x343, 2
1532:             csrrs        s2, 0x304, a6
1533:             beq          a1, a5, 1535f
1534:             csrrc        s9, 0x301, zero
1535:             bne          t3, s1, 1555f
1536:             slli         t0, zero, 3
1537:             xor          t1, s8, s3
1538:             csrrwi       s4, 0x342, 3
1539:             mulh         t1, s0, s8
1540:             ori          a3, t0, -438
1541:             lui          s5, 479262
1542:             addi         zero, s10, -772
1543:             sll          a2, a5, t5
1544:             bgeu         s4, t4, 1560f
1545:             rem          s1, s7, s0
1546:             srli         s5, s1, 21
1547:             bne          sp, s6, 1556f
1548:             ori          zero, t6, -199
1549:             mulhsu       t3, t6, a5
1550:             remu         a3, t4, s6
1551:             csrrs        a5, 0x304, tp
1552:             sltu         t1, sp, s2
1553:             remu         s8, s11, tp
1554:             mul          t6, a3, a7
1555:             andi         a5, a7, 1693
1556:             sra          s9, t2, t4
1557:             csrrs        a1, 0x300, zero
1558:             mulhsu       s0, sp, s1
1559:             bgeu         s7, s9, 1579f
1560:             srli         a2, sp, 24
1561:             beq          gp, s9, 1563f
1562:             bltu         a3, s8, 1580f
1563:             beq          sp, s0, 1572f
1564:             sltu         t0, ra, ra
1565:             slli         s6, t3, 26
1566:             addi         t2, a4, -1417
1567:             srl          ra, gp, gp
1568:             csrrs        s8, 0x304, t3
1569:             rem          t0, tp, s5
1570:             srai         s7, ra, 7
1571:             beq          s7, s4, 1572f
1572:             srai         t4, a5, 29
1573:             blt          s8, zero, 1583f
1574:             mulhsu       t1, s4, s1
1575:             csrrs        a6, 0x300, zero
1576:             csrrc        t6, 0x305, zero
1577:             andi         gp, t6, -1849
1578:             sltu         t3, t3, s7
1579:             blt          s6, a0, 1581f
1580:             beq          s4, sp, 1600f
1581:             mulhu        t0, a1, t5
1582:             div          s9, s9, a2
1583:             csrrci       s11, 0x304, 0
1584:             sll          s2, a3, s0
1585:             remu         s9, t6, t5
1586:             xori         a7, s10, -1841
1587:             sra          t5, a0, t4
1588:             or           s3, s10, s11
1589:             csrrs        a4, 0x304, zero
1590:             xor          gp, s10, sp
1591:             xori         s7, s6, 822
1592:             mulhu        s0, s8, a7
1593:             bgeu         a5, s2, 1613f
1594:             nop
1595:             addi         a6, s6, 1923
1596:             csrrw        s8, 0x304, s4
1597:             rem          s5, t4, s7
1598:             xori         t3, t0, 1705
1599:             csrrwi       s4, 0x344, 19
1600:             divu         s11, tp, t5
1601:             andi         a6, s2, -1467
1602:             andi         s7, a1, -1059
1603:             and          a1, a7, s5
1604:             bltu         t6, s0, 1605f
1605:             lui          a1, 1800
1606:             sltiu        gp, tp, 1436
1607:             ori          ra, t5, 904
1608:             nop
1609:             div          t1, sp, t3
1610:             sltiu        a3, a5, 851
1611:             rem          t3, a6, t2
1612:             srl          a2, sp, tp
1613:             mulhu        s8, s6, s2
1614:             srl          s6, s1, s9
1615:             bne          a0, t1, 1626f
1616:             mulhsu       s6, a6, s10
1617:             div          s8, s11, a2
1618:             addi         s4, a0, -1543
1619:             bgeu         s2, t0, 1636f
1620:             csrrwi       gp, 0x344, 8
1621:             bne          sp, s7, 1638f
1622:             srl          s10, s3, a3
1623:             sra          s4, a3, t1
1624:             bne          s2, a3, 1633f
1625:             srli         s6, t6, 21
1626:             divu         ra, t2, s10
1627:             mulhsu       t6, t0, t2
1628:             xori         s4, t5, 661
1629:             mul          s9, s6, s3
1630:             sll          s10, tp, t2
1631:             mul          s6, s2, s8
1632:             xor          s6, t0, t0
1633:             blt          t6, sp, 1637f
1634:             ori          t4, s1, -410
1635:             csrrw        a3, 0x343, s4
1636:             lui          a7, 321666
1637:             sltiu        s8, gp, -729
1638:             mulhu        s3, a4, s5
1639:             csrrsi       s4, 0x342, 0
1640:             bltu         a7, s2, 1658f
1641:             srai         s11, s11, 18
1642:             slti         a7, a2, -1594
1643:             xori         a4, a7, 2007
1644:             lui          a3, 956799
1645:             sltiu        s7, s7, 1568
1646:             sra          s1, tp, t0
1647:             bne          t3, s4, 1667f
1648:             csrrw        gp, 0x344, s6
1649:             sub          a4, t3, gp
1650:             srl          a5, a4, t0
1651:             blt          s7, t3, 1653f
1652:             blt          a1, t3, 1668f
1653:             sltu         a6, t3, a2
1654:             mulhsu       zero, a0, a2
1655:             bgeu         s6, s2, 1673f
1656:             sub          s3, t2, sp
1657:             slt          s11, s9, a3
1658:             bne          s8, a6, 1660f
1659:             srli         s5, t1, 22
1660:             nop
1661:             and          s8, a2, a7
1662:             blt          gp, a5, 1678f
1663:             mulhu        a2, a6, t6
1664:             bne          s6, s10, 1671f
1665:             bge          s3, t1, 1678f
1666:             csrrc        ra, 0x300, zero
1667:             slli         s0, a4, 22
1668:             andi         s8, s6, 1675
1669:             beq          t6, a2, 1678f
1670:             mulh         s0, t0, t3
1671:             lui          a2, 854187
1672:             remu         a4, s1, t4
1673:             blt          a4, s0, 1689f
1674:             xori         s1, s0, -1839
1675:             bne          s6, gp, 1693f
1676:             remu         s6, s0, s7
1677:             bge          s1, a3, 1682f
1678:             sra          a6, a6, s11
1679:             mul          s2, s2, t0
1680:             mulhsu       s2, a6, s1
1681:             xor          s11, a7, a0
1682:             auipc        t5, 281295
1683:             bge          a1, t5, 1703f
1684:             beq          s6, s7, 1685f
1685:             divu         a7, s5, t6
1686:             sll          zero, t1, s6
1687:             mulh         a6, zero, a2
1688:             srai         a6, s5, 3
1689:             div          t3, t1, t1
1690:             ori          s3, a6, -745
1691:             div          a6, ra, s2
1692:             bgeu         ra, tp, 1705f
1693:             lui          a6, 440850
1694:             csrrwi       s5, 0x344, 11
1695:             nop
1696:             auipc        t0, 456318
1697:             and          ra, s9, s0
1698:             rem          t5, t0, s8
1699:             csrrci       s2, 0x301, 0
1700:             bge          zero, zero, 1702f
1701:             bge          zero, t4, 1703f
1702:             divu         s4, t0, a2
1703:             srl          s6, s0, tp
1704:             mulhsu       s11, s0, t6
1705:             div          t4, a1, t1
1706:             xor          s3, s1, s0
1707:             bgeu         s2, s9, 1724f
1708:             srli         a4, s11, 26
1709:             sub          s1, tp, s7
1710:             srli         a7, a1, 27
1711:             lui          s8, 256886
1712:             mulhsu       s0, t3, t2
1713:             csrrs        a7, 0x304, s9
1714:             mulh         a5, ra, s7
1715:             mulh         t5, ra, t3
1716:             xori         a6, s3, -1136
1717:             auipc        t2, 151496
1718:             auipc        a7, 549099
1719:             srl          a2, s3, s0
1720:             lui          t5, 817189
1721:             and          s5, a0, ra
1722:             sltu         t3, t6, a6
1723:             lui          gp, 989482
1724:             csrrc        a6, 0x342, zero
1725:             mul          s3, tp, t3
1726:             auipc        a5, 567753
1727:             csrrsi       a1, 0x343, 0
1728:             bltu         gp, t0, 1741f
1729:             sra          a3, s2, s0
1730:             mul          s8, s4, a5
1731:             mulhsu       s7, a1, s0
1732:             csrrw        s2, 0x301, t3
1733:             xor          s4, s11, s6
1734:             slti         s5, t1, -203
1735:             or           s11, t4, t4
1736:             blt          s9, a1, 1745f
1737:             mulhu        s11, a7, sp
1738:             sltu         s8, a1, t3
1739:             sra          s0, sp, s3
1740:             blt          s5, t0, 1741f
1741:             or           s0, s11, t4
1742:             add          s9, zero, t4
1743:             slt          t3, t5, s2
1744:             divu         s2, a4, t0
1745:             csrrci       a3, 0x301, 3
1746:             xori         t2, sp, -1566
1747:             lui          a7, 141280
1748:             bne          s4, s1, 1755f
1749:             or           t2, t3, s3
1750:             nop
1751:             csrrs        s10, 0x304, zero
1752:             bge          s3, s4, 1770f
1753:             bgeu         t4, s7, 1755f
1754:             beq          ra, t3, 1767f
1755:             csrrc        s9, 0x300, zero
1756:             srl          gp, gp, s1
1757:             csrrwi       s11, 0x343, 10
1758:             srl          s4, s5, gp
1759:             add          s1, a0, a0
1760:             srl          a5, a5, s7
1761:             csrrc        a4, 0x304, zero
1762:             csrrsi       t4, 0x305, 0
1763:             mulhsu       t4, s4, a5
1764:             xor          gp, t6, t0
1765:             srli         ra, s6, 1
1766:             bge          s4, t0, 1777f
1767:             sltiu        t2, s2, -1464
1768:             srai         s2, t0, 3
1769:             srl          s1, a3, a6
1770:             mulhsu       t5, s2, s6
1771:             sra          ra, a4, s10
1772:             addi         t4, sp, 614
1773:             bne          t2, s11, 1791f
1774:             csrrs        t1, 0x301, s7
1775:             mulhu        t6, s4, a0
1776:             bne          s1, a1, 1792f
1777:             slti         a5, s1, -339
1778:             sltiu        s2, a6, -887
1779:             csrrs        gp, 0x342, a2
1780:             or           s1, s5, s6
1781:             add          t0, a6, s5
1782:             csrrw        s9, 0x301, s0
1783:             csrrsi       s5, 0x344, 22
1784:             remu         a5, ra, s1
1785:             mul          s7, a4, t1
1786:             srl          s5, s1, s4
1787:             bne          t0, a1, 1789f
1788:             beq          t3, s11, 1805f
1789:             blt          a4, a0, 1809f
1790:             divu         ra, sp, a1
1791:             sub          s2, a0, s3
1792:             sub          t4, s10, s4
1793:             sub          t2, s8, a6
1794:             slli         a1, t4, 4
1795:             mulhu        a1, s4, s2
1796:             csrrsi       s4, 0x305, 0
1797:             xori         t6, t4, -1822
1798:             slt          a2, tp, s11
1799:             divu         ra, s1, s1
1800:             sll          s5, s7, s9
1801:             divu         s0, s9, a1
1802:             blt          a2, s4, 1820f
1803:             rem          t2, s11, zero
1804:             csrrsi       s1, 0x300, 0
1805:             csrrc        s1, 0x343, a0
1806:             auipc        t3, 195420
1807:             mul          a4, a0, a6
1808:             or           t3, s1, t4
1809:             sub          a4, s6, gp
1810:             csrrwi       t2, 0x301, 11
1811:             srai         a4, a6, 6
1812:             srli         s11, s3, 23
1813:             bge          a0, s1, 1823f
1814:             sltu         t6, a3, sp
1815:             addi         s1, t4, 1039
1816:             addi         s8, s1, -1255
1817:             csrrc        a2, 0x344, s4
1818:             add          t2, s9, a2
1819:             xor          a6, a1, s11
1820:             csrrc        gp, 0x300, zero
1821:             slti         s2, s7, -1733
1822:             csrrsi       t3, 0x304, 0
1823:             slli         s5, s7, 26
1824:             remu         a7, s8, ra
1825:             slti         t5, t3, -1501
1826:             sltu         a1, t0, a1
1827:             divu         t4, a1, zero
1828:             bge          tp, a3, 1832f
1829:             blt          t2, a5, 1845f
1830:             lui          s9, 820221
1831:             sltiu        t2, a7, -1327
1832:             xor          s3, t2, t6
1833:             srai         a4, a6, 25
1834:             csrrci       s0, 0x301, 3
1835:             div          t0, s7, t3
1836:             csrrw        a3, 0x343, a4
1837:             srli         t2, t1, 11
1838:             csrrw        t5, 0x344, a7
1839:             div          s11, s5, t2
1840:             srai         s6, s5, 1
1841:             div          t6, s10, s6
1842:             remu         s8, sp, ra
1843:             slt          s7, s0, s6
1844:             mulhsu       s10, ra, ra
1845:             sll          a1, s0, s9
1846:             bne          a5, s11, 1855f
1847:             add          s11, s0, tp
1848:             sub          t0, zero, s4
1849:             bltu         a2, s7, 1865f
1850:             xori         t3, t6, -219
1851:             divu         s11, s8, t1
1852:             csrrwi       a5, 0x344, 29
1853:             xori         s2, a3, -29
1854:             mulhsu       s5, s10, t1
1855:             blt          s10, a3, 1860f
1856:             xori         t1, sp, 754
1857:             beq          t2, s11, 1858f
1858:             blt          t0, s4, 1860f
1859:             srl          s10, s0, s9
1860:             mulhu        t5, sp, s7
1861:             srl          t6, t2, a0
1862:             sltu         a5, a1, s0
1863:             or           t2, s7, s8
1864:             slli         a5, s9, 2
1865:             slli         s6, t3, 18
1866:             csrrsi       t0, 0x344, 0
1867:             sltu         ra, s0, a6
1868:             csrrw        s8, 0x343, a5
1869:             mulhsu       t4, s3, s4
1870:             csrrci       a6, 0x305, 0
1871:             nop
1872:             lui          a7, 188324
1873:             sra          s5, s11, a7
1874:             div          t6, t6, a4
1875:             xori         s1, t0, -1475
1876:             remu         t1, s7, s3
1877:             mul          zero, t2, t0
1878:             bgeu         s1, t5, 1898f
1879:             srl          t0, s9, a1
1880:             srai         a6, a5, 21
1881:             csrrwi       a7, 0x342, 3
1882:             slli         a3, a3, 16
1883:             bltu         s9, s8, 1885f
1884:             add          a1, s9, t3
1885:             csrrwi       s9, 0x304, 9
1886:             sltu         a4, a1, t5
1887:             slti         s7, zero, -1422
1888:             or           s8, s7, s5
1889:             rem          s0, s11, s7
1890:             remu         gp, s11, s3
1891:             slli         a7, t4, 15
1892:             srl          s2, s1, s10
1893:             beq          s0, s2, 1902f
1894:             mul          s4, tp, a3
1895:             bgeu         gp, t2, 1915f
1896:             sltiu        ra, a4, 1081
1897:             xori         t5, a6, -970
1898:             sltu         s2, a1, a3
1899:             ori          s1, a4, 286
1900:             csrrwi       s0, 0x304, 6
1901:             srai         ra, a3, 23
1902:             sra          gp, a5, s11
1903:             auipc        s7, 400797
1904:             csrrw        s7, 0x342, a1
1905:             ori          s9, a2, -1737
1906:             sub          s5, t4, t3
1907:             ori          a5, s8, -1146
1908:             or           t1, a1, a0
1909:             sll          zero, t1, s10
1910:             slti         t5, t6, -283
1911:             blt          t6, s10, 1931f
1912:             andi         a6, s1, -366
1913:             or           s3, tp, a6
1914:             csrrc        gp, 0x300, zero
1915:             srli         t4, s8, 18
1916:             xor          a4, zero, s8
1917:             mulhu        s3, s9, s8
1918:             sltu         a7, s10, s10
1919:             add          a5, zero, gp
1920:             rem          a2, a6, s9
1921:             sll          s7, sp, t4
1922:             blt          s0, sp, 1923f
1923:             auipc        a7, 735849
1924:             and          t4, s2, s11
1925:             andi         s2, t1, 589
1926:             and          t6, a4, s1
1927:             csrrsi       a1, 0x305, 0
1928:             sra          t6, s5, sp
1929:             sltiu        t3, t3, 734
1930:             mulh         s11, t2, s9
1931:             slt          s3, a3, s1
1932:             sltu         t4, s9, s3
1933:             mulhu        ra, s6, a1
1934:             andi         gp, t6, -609
1935:             and          t0, s7, s4
1936:             mulhu        s10, s7, tp
1937:             remu         t6, s2, gp
1938:             srai         s0, s1, 28
1939:             sltiu        s6, t5, 1153
1940:             slli         s3, s7, 29
1941:             and          s1, t6, s5
1942:             csrrw        s1, 0x343, s7
1943:             bne          t3, t4, 1945f
1944:             mulh         t2, s11, a3
1945:             or           t3, a2, s3
1946:             bgeu         t2, sp, 1955f
1947:             xor          a7, a5, a0
1948:             csrrsi       gp, 0x300, 0
1949:             rem          s1, a5, s7
1950:             blt          a7, a0, 1967f
1951:             mulh         t2, s4, tp
1952:             add          a6, a3, t1
1953:             sltu         zero, ra, s2
1954:             sltu         s9, t2, s10
1955:             srli         t3, tp, 12
1956:             div          s8, s2, s11
1957:             add          s9, s8, t0
1958:             slti         s10, t2, 1711
1959:             srl          s5, t6, a5
1960:             remu         a7, gp, t6
1961:             mul          s10, sp, s6
1962:             csrrwi       a7, 0x343, 20
1963:             bgeu         s7, s7, 1976f
1964:             csrrc        t5, 0x304, zero
1965:             addi         s2, s7, 822
1966:             slt          s4, t1, a2
1967:             div          s9, a5, s10
1968:             ori          s8, t4, 1344
1969:             remu         t0, s9, s5
1970:             bltu         s1, s3, 1972f
1971:             csrrci       s7, 0x300, 0
1972:             and          s11, t0, s9
1973:             lui          s6, 729556
1974:             divu         s6, zero, s11
1975:             nop
1976:             rem          s2, a3, s0
1977:             add          zero, s5, a1
1978:             lui          s4, 148203
1979:             div          t1, t4, zero
1980:             andi         s8, a4, -547
1981:             bge          t6, t4, 2001f
1982:             remu         a7, a0, s10
1983:             mulhu        a1, a1, s4
1984:             csrrc        ra, 0x301, zero
1985:             bge          a0, t3, 1986f
1986:             sub          s7, s11, s7
1987:             remu         a6, a6, a6
1988:             ori          s7, a1, -243
1989:             sltu         s4, s2, s11
1990:             add          t5, s5, s0
1991:             srli         s6, gp, 19
1992:             slt          zero, tp, t5
1993:             xor          s5, s8, a3
1994:             xori         s11, s8, 523
1995:             remu         s7, s0, t4
1996:             auipc        t3, 832494
1997:             ori          s7, s8, -151
1998:             or           s1, a3, s7
1999:             lui          a7, 299242
2000:             add          s0, a2, t1
2001:             bltu         t4, gp, 2019f
2002:             sub          t1, zero, s11
2003:             bne          gp, s4, 2008f
2004:             bne          t6, a4, 2024f
2005:             add          a3, a5, t5
2006:             ori          a3, gp, 415
2007:             sltiu        s6, a4, -855
2008:             csrrwi       gp, 0x342, 8
2009:             auipc        s8, 564875
2010:             bne          t3, s6, 2019f
2011:             srl          a2, t1, t6
2012:             srai         t3, t3, 27
                  li           s8, 0x0 #start riscv_int_numeric_corner_stream_8
                  li           ra, 0x80000000
                  li           s9, 0x0
                  li           a7, 0x5d5d81c2
                  li           t6, 0xfdd0b102
                  li           a6, 0x0
                  li           s4, 0xffffffff
                  li           s5, 0x1d06022b
                  li           s11, 0x0
                  li           s7, 0x0
                  nop
                  mul          s11, a7, s4
                  mul          a6, s11, s5
                  remu         s9, s7, a7
                  addi         t6, a6, -586
                  addi         s4, ra, -1934
                  mul          s8, s9, s11
                  addi         s4, s5, 1853
                  nop
                  mulh         s8, s9, s11
                  lui          s5, 645302
                  addi         s11, a6, -2022
                  mulhsu       ra, ra, s7
                  auipc        ra, 352516
                  mulh         s8, ra, s5
                  add          s8, s4, t6
                  mulhsu       s5, s4, t6
                  sub          s7, s9, a7
                  lui          a6, 581503
                  mulhu        s8, s7, s4
                  nop #end riscv_int_numeric_corner_stream_8
2013:             add          t5, sp, s7
2014:             beq          a2, a3, 2023f
2015:             beq          s7, tp, 2016f
2016:             csrrs        s6, 0x301, zero
2017:             csrrci       gp, 0x305, 0
2018:             srli         zero, t1, 28
2019:             auipc        s0, 1542
2020:             andi         a4, ra, -788
2021:             mul          s11, zero, tp
2022:             nop
2023:             auipc        t4, 891060
2024:             div          s9, t5, ra
2025:             add          s4, a1, s3
2026:             divu         s11, s4, sp
2027:             slli         t1, ra, 8
2028:             remu         t3, t5, zero
2029:             or           s0, s10, a5
2030:             blt          t0, s6, 2032f
2031:             srl          zero, gp, s2
2032:             sltu         s5, a4, s8
2033:             and          s5, t3, t1
2034:             xor          s4, t6, t1
2035:             andi         s1, s3, -223
2036:             beq          s9, s2, 2054f
2037:             sll          a7, s3, t3
2038:             sll          s8, s4, s2
2039:             sll          s11, a0, s4
2040:             addi         s9, s9, -669
2041:             rem          s8, gp, s11
2042:             sub          s1, sp, zero
2043:             csrrwi       t5, 0x301, 24
2044:             beq          t1, t2, 2064f
                  li           s11, 0xffffffff #start riscv_int_numeric_corner_stream_0
                  li           a6, 0xffffffff
                  li           a4, 0x0
                  li           gp, 0x0
                  li           t3, 0xffffffff
                  li           s3, 0xfce4dbef
                  li           s8, 0xffffffff
                  li           a7, 0x80000000
                  li           a5, 0x0
                  li           s5, 0x0
                  mul          s3, s5, t3
                  divu         gp, a7, gp
                  mulhu        s3, s5, s3
                  sub          a7, gp, s8
                  mul          s11, a5, a4
                  divu         s5, a7, t3
                  nop
                  auipc        a7, 564794
                  mulhsu       s8, a5, t3
                  add          s3, gp, a7
                  mulhsu       t3, t3, a7
                  rem          s8, s3, a4
                  nop
                  addi         s11, s3, 35
                  remu         a6, s11, s3
                  mulhu        s11, s3, a4
                  divu         a5, a6, s5
                  mulhu        a7, s8, a7
                  mulhsu       t3, a7, gp
                  mul          s5, a5, s3
                  nop
                  nop
                  mulhu        a7, a7, gp
                  nop #end riscv_int_numeric_corner_stream_0
2045:             remu         a6, s4, a1
2046:             csrrsi       t1, 0x305, 0
2047:             add          t3, a1, t4
2048:             mulhu        s4, s5, a6
2049:             sll          a6, s9, t0
2050:             xor          s11, gp, ra
2051:             csrrc        s7, 0x304, t3
2052:             mulhsu       s6, a0, s5
2053:             sll          s6, s1, a7
2054:             slli         s4, tp, 0
2055:             csrrw        a6, 0x301, t6
2056:             sll          s9, s4, s11
2057:             and          s6, s1, t1
2058:             csrrci       a6, 0x343, 2
2059:             beq          a7, t2, 2069f
2060:             sltiu        t3, a6, -80
2061:             remu         s10, s7, tp
2062:             nop
2063:             csrrsi       a3, 0x342, 15
2064:             blt          t4, a1, 2065f
2065:             mul          t0, s7, sp
2066:             lui          t0, 412338
2067:             srli         t2, a3, 26
2068:             blt          t1, a0, 2070f
2069:             mulhu        s10, t5, a4
2070:             remu         s4, s3, a5
2071:             and          s9, t3, s6
2072:             sra          s2, a1, a3
2073:             andi         t6, a1, 1071
2074:             bgeu         s2, s11, 2085f
2075:             srli         s9, tp, 3
2076:             sll          s9, s4, a7
2077:             blt          a7, a1, 2081f
2078:             bge          a0, t0, 2096f
2079:             csrrs        zero, 0x304, zero
2080:             csrrs        t5, 0x300, zero
2081:             sra          s7, t4, s1
2082:             xori         ra, sp, 341
2083:             sltu         t5, t0, s11
2084:             csrrs        t1, 0x301, sp
2085:             sra          s1, t0, t0
2086:             rem          t3, a1, sp
2087:             mul          t1, zero, a2
2088:             ori          s5, a6, 1108
2089:             csrrw        s3, 0x301, s0
2090:             slt          t0, s11, t0
2091:             sra          s7, a2, a0
2092:             div          t6, sp, s4
2093:             csrrc        s5, 0x304, zero
2094:             csrrw        s9, 0x304, t6
2095:             add          s2, a6, s2
2096:             bne          t4, a7, 2098f
2097:             divu         s4, s7, a2
2098:             srai         s2, s11, 26
2099:             mulh         s6, gp, s5
2100:             xori         gp, a1, 1583
2101:             srli         t1, a7, 4
2102:             srai         s2, s3, 18
2103:             and          a6, s10, t1
2104:             csrrci       a2, 0x305, 0
2105:             sltu         s5, s1, t4
2106:             csrrw        s3, 0x304, a6
2107:             rem          a3, s1, t0
2108:             srai         t0, a3, 16
2109:             srl          zero, s4, s9
2110:             andi         s9, gp, -618
2111:             csrrw        a1, 0x344, s0
2112:             divu         s9, t3, s11
2113:             or           a6, a7, t2
2114:             csrrw        s9, 0x344, s2
2115:             mulhu        a4, s7, ra
2116:             rem          zero, s5, s1
2117:             csrrwi       s8, 0x342, 3
2118:             add          a7, t4, a1
2119:             mulhu        a1, a2, s1
2120:             slti         a1, s3, 167
2121:             csrrsi       a4, 0x301, 0
2122:             bltu         s7, s3, 2138f
2123:             xori         s8, ra, -819
2124:             remu         a4, a5, tp
2125:             bgeu         a0, s2, 2142f
2126:             andi         s3, gp, 591
2127:             csrrw        s4, 0x304, a0
2128:             lui          gp, 835022
2129:             slli         s9, a0, 17
2130:             auipc        zero, 912990
2131:             slti         a1, t5, 1183
2132:             bgeu         a2, a5, 2139f
2133:             lui          s6, 121762
2134:             sll          a1, sp, s5
2135:             remu         s10, a5, t1
2136:             mulh         t0, s6, t2
2137:             slli         s4, t2, 5
2138:             remu         s5, s8, sp
2139:             sltiu        a6, gp, 178
2140:             mulh         s5, a1, a1
2141:             csrrs        s4, 0x300, zero
2142:             csrrw        a4, 0x301, s10
2143:             srai         t4, s3, 29
2144:             sltu         s1, a5, s10
2145:             auipc        s9, 275011
2146:             mulhsu       s1, s8, zero
2147:             mul          a7, a6, s10
2148:             nop
2149:             rem          s11, a7, t1
2150:             bge          gp, s7, 2163f
2151:             slti         s6, a2, -2042
2152:             add          s10, t2, s3
2153:             andi         s8, s0, 264
2154:             bgeu         s0, s1, 2174f
2155:             mulh         s9, t3, s11
2156:             mulhsu       a4, a6, t4
2157:             lui          t5, 788652
2158:             mulhsu       s8, s11, s10
2159:             slt          a3, s1, s8
2160:             csrrs        a1, 0x342, zero
2161:             xor          s8, sp, a3
2162:             auipc        gp, 1009351
2163:             csrrs        t5, 0x344, a1
2164:             or           a7, t5, s10
2165:             ori          t1, a5, 1911
2166:             div          s2, a3, a5
2167:             andi         s9, a4, 53
2168:             xor          a5, t1, ra
2169:             bne          t0, s0, 2185f
2170:             or           s9, gp, s0
2171:             srai         s6, t0, 12
2172:             csrrs        ra, 0x304, zero
2173:             bne          a2, sp, 2189f
2174:             mul          a2, zero, s5
2175:             srl          s1, ra, s3
2176:             csrrc        s0, 0x342, zero
2177:             blt          ra, t3, 2179f
2178:             divu         a6, t2, a0
2179:             slt          a7, t3, a2
2180:             csrrs        t4, 0x342, zero
2181:             slti         t2, s7, 886
2182:             and          a1, t6, a3
2183:             add          a2, zero, a1
2184:             srli         s8, a3, 30
2185:             auipc        s7, 999233
2186:             mulhu        ra, t1, a2
2187:             lui          t1, 489683
2188:             mulhu        a7, t4, a0
2189:             div          s10, s11, t6
2190:             remu         t6, s11, t2
2191:             addi         a2, gp, -1282
2192:             srli         s6, a1, 22
2193:             xor          t2, s9, s8
2194:             and          t1, s4, zero
2195:             lui          t4, 662047
2196:             srl          s3, tp, a3
2197:             slt          s8, s3, t1
2198:             csrrc        a7, 0x300, zero
2199:             remu         a7, s3, s9
2200:             mulhsu       s9, t2, a3
2201:             csrrci       s1, 0x344, 0
2202:             nop
2203:             csrrci       a1, 0x300, 0
2204:             xor          s6, t1, a5
2205:             mulhsu       s5, s0, t5
2206:             divu         a5, a5, a7
2207:             mulh         s2, s10, s3
2208:             csrrw        t1, 0x304, ra
2209:             addi         s10, s8, -840
2210:             nop
2211:             divu         t2, s2, s11
2212:             bne          s0, a2, 2230f
2213:             csrrw        s9, 0x344, s4
2214:             or           a3, s9, t6
2215:             bne          a1, a1, 2233f
2216:             sltiu        s7, t1, -801
2217:             sra          a6, a2, a5
2218:             slli         a6, s1, 0
2219:             csrrw        a7, 0x301, t6
2220:             csrrw        s9, 0x344, a3
2221:             divu         s6, sp, a5
2222:             csrrs        t0, 0x344, a4
2223:             andi         s4, gp, 848
2224:             sll          s3, a1, s4
2225:             csrrwi       t3, 0x304, 12
2226:             blt          zero, zero, 2246f
2227:             sra          a7, a3, s0
2228:             mulh         a5, s6, s9
2229:             sltu         a4, a6, s11
2230:             mulhsu       gp, tp, a6
2231:             sltiu        t4, s5, 795
2232:             sltu         s0, s7, s8
2233:             mulh         t6, gp, t5
2234:             lui          a2, 90850
2235:             csrrs        t2, 0x344, zero
2236:             sltiu        s9, a4, 1804
2237:             csrrci       t4, 0x344, 1
2238:             mulhsu       s4, s11, s4
2239:             remu         ra, sp, a0
2240:             divu         t2, sp, a3
2241:             bge          gp, s8, 2242f
2242:             slti         a2, a6, 1423
2243:             addi         s11, s1, -1279
2244:             csrrsi       t2, 0x304, 0
2245:             csrrs        t4, 0x344, zero
2246:             blt          tp, ra, 2248f
2247:             lui          a4, 505523
2248:             mul          a7, a1, a5
2249:             beq          a7, t6, 2269f
2250:             srai         s4, t3, 3
2251:             sub          t1, s3, a7
2252:             mulhsu       s11, s2, s4
2253:             lui          s4, 283042
2254:             sll          s8, s5, a4
2255:             div          a3, a6, s11
2256:             mul          a1, t2, s8
2257:             and          a1, t6, t0
2258:             addi         a6, s3, -898
2259:             div          s4, s8, a5
2260:             csrrwi       t2, 0x343, 29
2261:             csrrwi       s11, 0x344, 8
2262:             remu         s3, gp, t3
2263:             csrrc        a4, 0x344, zero
2264:             mulhsu       t4, a6, s9
2265:             bge          tp, gp, 2266f
2266:             slt          t4, sp, a3
2267:             xor          s11, s5, sp
2268:             blt          a0, tp, 2277f
2269:             or           t6, a0, s4
2270:             addi         gp, s5, 1997
2271:             or           t5, a6, s8
2272:             sltiu        s9, t0, -643
2273:             divu         a4, t0, s0
2274:             csrrsi       s0, 0x300, 0
2275:             mul          t6, a7, t0
2276:             beq          t4, s4, 2285f
2277:             srli         s8, ra, 10
2278:             ori          a1, a5, -5
2279:             divu         t1, s10, s6
2280:             xor          t4, s7, a4
2281:             beq          s4, t3, 2286f
2282:             ori          a3, a2, 282
2283:             csrrc        gp, 0x300, zero
2284:             mulh         ra, a1, s6
2285:             nop
2286:             sub          a7, t0, tp
2287:             divu         s2, a2, a2
2288:             addi         a5, a6, 463
2289:             andi         t4, s1, 1949
2290:             sll          zero, tp, a1
2291:             csrrc        ra, 0x300, zero
2292:             bltu         s8, a5, 2294f
2293:             sub          a4, zero, s9
2294:             remu         s0, t6, a1
2295:             sra          s4, a5, t5
2296:             add          gp, sp, tp
2297:             slti         a7, t3, 947
2298:             sra          s8, tp, s4
2299:             csrrsi       a4, 0x305, 0
2300:             mulhu        s5, t3, t5
2301:             csrrw        a5, 0x304, t2
2302:             slti         s7, s8, 1090
2303:             mul          a4, s0, t2
2304:             sra          s4, a1, t2
2305:             csrrc        a2, 0x301, s10
2306:             blt          s0, a3, 2316f
2307:             ori          s0, a5, -1605
2308:             add          s6, s2, t2
2309:             sll          a4, a6, zero
2310:             srli         t3, t1, 17
2311:             sll          t2, s0, s2
2312:             ori          a4, s4, -17
2313:             auipc        s1, 360529
2314:             and          s7, s0, a5
2315:             slt          t6, s11, a4
2316:             bne          s7, a3, 2333f
2317:             lui          t5, 692459
2318:             csrrs        t5, 0x301, s0
2319:             sltu         t2, a2, s6
2320:             and          t0, a7, a0
2321:             rem          s11, s7, t0
2322:             csrrwi       s3, 0x304, 17
2323:             bne          s3, t3, 2339f
2324:             srl          t5, t3, a3
2325:             xor          t0, a0, t2
2326:             and          s8, a1, t2
2327:             sra          a5, s3, s2
2328:             div          s0, s1, t6
2329:             mulh         s0, tp, s4
2330:             sltiu        t6, s1, -908
2331:             remu         zero, s1, t4
2332:             addi         t3, t2, -478
2333:             blt          s5, t2, 2335f
2334:             sra          t3, s2, t2
2335:             csrrw        t1, 0x342, s11
2336:             csrrwi       s4, 0x344, 1
2337:             sll          s11, t2, s3
2338:             or           s5, a0, s0
2339:             and          a5, t6, t5
2340:             addi         zero, a4, 1638
2341:             csrrw        s1, 0x301, s8
2342:             sra          s1, s5, s5
2343:             andi         t3, s5, 451
2344:             beq          s9, t1, 2353f
2345:             sra          ra, s2, s2
2346:             xori         s11, t1, 1042
2347:             srai         s4, s6, 24
2348:             auipc        a2, 58906
2349:             xor          s4, s8, zero
2350:             csrrc        s9, 0x342, s10
2351:             csrrs        t1, 0x344, t5
2352:             rem          s5, s5, s5
2353:             or           t2, a6, a2
2354:             csrrwi       s0, 0x301, 12
2355:             remu         s11, s9, a5
2356:             csrrsi       s3, 0x301, 6
2357:             div          s0, t3, s5
2358:             mulhu        s4, a7, t4
2359:             slli         s3, t1, 19
2360:             srl          s2, t6, s1
2361:             csrrsi       a6, 0x344, 26
2362:             csrrw        t1, 0x344, t5
2363:             sltiu        a2, ra, 160
2364:             mulh         a5, a0, a6
2365:             mulh         t1, t2, t6
2366:             sub          s8, gp, t3
2367:             srl          t3, a4, a7
2368:             nop
2369:             srai         t1, a1, 14
2370:             csrrw        t3, 0x342, t6
2371:             bgeu         tp, t5, 2373f
2372:             sub          zero, ra, gp
2373:             divu         a4, s0, s5
2374:             addi         gp, s9, 1045
2375:             sltiu        gp, s3, 265
2376:             and          s0, s0, t2
2377:             xor          s5, s0, s8
2378:             auipc        a4, 558923
2379:             srl          t6, a6, s4
2380:             slli         s1, t0, 27
2381:             xor          s11, t6, t1
2382:             srai         s0, s11, 2
2383:             beq          a4, s0, 2396f
2384:             bgeu         s6, s5, 2388f
2385:             mulh         ra, t0, a1
2386:             lui          a7, 731652
2387:             and          t5, t2, gp
2388:             slti         a5, t3, -337
2389:             sub          t2, a0, s11
2390:             div          t5, zero, a1
2391:             csrrs        a5, 0x305, zero
2392:             bltu         s5, s2, 2393f
2393:             csrrci       s6, 0x343, 4
2394:             sltiu        a7, t1, 420
2395:             xor          a1, tp, a7
2396:             xori         a5, t5, -1282
2397:             bltu         a6, t1, 2417f
2398:             andi         s9, a5, -798
2399:             bgeu         s5, t0, 2410f
2400:             csrrsi       a1, 0x342, 25
2401:             slti         s5, t3, 1204
2402:             xor          t5, s9, s4
2403:             srl          t0, sp, t2
2404:             csrrci       s5, 0x304, 2
2405:             auipc        s5, 658707
2406:             csrrsi       s2, 0x342, 0
2407:             csrrc        s10, 0x300, zero
2408:             srl          s0, a2, t6
2409:             csrrs        s6, 0x342, sp
2410:             remu         a1, a3, zero
2411:             or           t2, s0, a4
2412:             csrrwi       s8, 0x343, 17
2413:             or           s11, t5, sp
2414:             csrrsi       t3, 0x305, 0
2415:             or           a5, t0, t0
2416:             srai         a6, a6, 27
2417:             div          a6, a2, s3
2418:             csrrwi       a4, 0x342, 1
2419:             add          s1, t0, s11
2420:             andi         s9, a4, 398
2421:             divu         t4, gp, t2
2422:             csrrw        s4, 0x301, t0
2423:             mul          s3, t5, t6
2424:             mulh         s1, s4, a0
2425:             div          t4, ra, t1
2426:             beq          a2, s3, 2446f
2427:             rem          t0, a3, t1
2428:             mul          zero, tp, a0
2429:             xori         s0, t4, 1780
2430:             srl          s7, a3, t2
2431:             xori         s1, s1, -1179
2432:             xori         t6, s1, -1165
2433:             csrrs        a1, 0x343, a0
2434:             and          t5, a6, t2
2435:             csrrc        s4, 0x301, zero
2436:             slt          s10, a6, s3
2437:             mulhu        t1, t1, a3
2438:             bltu         s11, a4, 2455f
2439:             bltu         gp, t5, 2446f
2440:             beq          s11, t2, 2456f
2441:             addi         a1, t2, 914
2442:             add          zero, a2, gp
2443:             divu         a1, zero, a6
2444:             bltu         t5, a0, 2457f
2445:             mulhu        a4, a6, s9
2446:             mulhu        t4, s0, s1
2447:             mulhsu       s1, s8, s6
2448:             csrrsi       t5, 0x342, 0
2449:             nop
2450:             bne          s11, s6, 2466f
2451:             slti         s9, a0, 292
2452:             slti         zero, s11, 1510
2453:             mulhsu       ra, t0, a7
2454:             sll          t0, t2, t5
2455:             sltu         t0, t6, tp
2456:             remu         s9, t2, sp
2457:             bltu         t3, t0, 2475f
2458:             srai         t2, s6, 25
2459:             mulh         t6, a1, s11
2460:             csrrci       a7, 0x300, 0
2461:             mulhsu       t6, s4, sp
2462:             mulhu        s5, t4, a0
2463:             and          a2, s7, gp
2464:             beq          a7, a0, 2466f
2465:             rem          t1, tp, t1
2466:             bgeu         t3, tp, 2477f
2467:             csrrsi       zero, 0x304, 3
2468:             bltu         s1, a7, 2472f
2469:             slti         s11, s5, -838
2470:             sll          s7, s7, s7
2471:             mul          s11, a4, a4
2472:             srli         zero, t2, 24
2473:             add          a2, a3, a7
2474:             rem          a4, t5, s2
2475:             or           t4, t1, s11
2476:             lui          s4, 122038
2477:             bltu         zero, a5, 2486f
2478:             and          a4, t4, ra
2479:             bltu         t0, a6, 2499f
2480:             csrrsi       s3, 0x305, 0
2481:             srli         ra, s9, 14
2482:             or           t1, s4, s10
2483:             remu         t1, s3, s1
2484:             sra          ra, sp, tp
2485:             bltu         t3, s7, 2487f
2486:             mul          s8, a4, zero
2487:             sltu         s11, t6, t5
2488:             sra          s4, ra, s4
2489:             add          t3, s7, a5
2490:             sll          gp, zero, t2
2491:             csrrci       zero, 0x342, 8
2492:             lui          s0, 144775
2493:             div          s4, s0, s10
2494:             andi         gp, ra, -653
2495:             xor          a2, s7, s10
2496:             mulhsu       s5, zero, a1
2497:             mulh         ra, a2, sp
2498:             srli         s3, a2, 18
2499:             andi         t6, zero, 1891
2500:             slti         s11, a0, 493
2501:             csrrwi       a7, 0x344, 16
2502:             mulh         s1, a3, s10
2503:             sltu         a5, a1, a7
2504:             mulhsu       s1, s4, ra
2505:             add          s7, a5, t6
2506:             sub          s0, t5, tp
2507:             csrrw        s0, 0x301, gp
2508:             csrrci       s0, 0x305, 0
2509:             srli         t0, t1, 2
2510:             srli         t6, s5, 19
2511:             nop
2512:             srl          s6, a7, ra
2513:             srai         s0, t4, 29
2514:             sra          s7, s11, s7
2515:             sltu         t6, t2, s11
2516:             xori         a5, t5, 1907
2517:             rem          a7, t1, s0
2518:             divu         zero, sp, a5
2519:             ori          s0, a1, -126
2520:             srli         s8, a7, 17
2521:             xori         a4, s3, -411
2522:             csrrs        s8, 0x304, a0
2523:             slti         s0, ra, 1275
2524:             lui          t2, 245122
2525:             sll          t6, sp, t0
2526:             csrrc        s7, 0x304, gp
2527:             csrrw        s2, 0x342, a6
2528:             mulh         s1, s8, s1
2529:             div          s8, s7, t1
2530:             mul          t6, a5, t1
2531:             srai         t5, s6, 30
2532:             srli         s9, gp, 7
2533:             rem          t2, s11, s4
2534:             remu         s6, t4, s1
2535:             auipc        a2, 225652
2536:             csrrwi       a3, 0x343, 11
2537:             remu         s2, a6, a1
2538:             srl          s7, s0, t1
2539:             divu         a6, t1, s8
2540:             srl          a3, t3, tp
2541:             csrrc        s0, 0x343, zero
2542:             srai         a3, a0, 23
2543:             andi         t6, gp, 1679
2544:             lui          s2, 58315
2545:             csrrci       a5, 0x344, 25
2546:             slt          t5, t5, a2
2547:             slti         s9, a4, 1645
2548:             srai         a3, s10, 7
2549:             andi         t5, a1, 2018
2550:             rem          s5, t3, t0
2551:             add          s8, a5, a1
2552:             remu         s3, s0, s8
2553:             sub          zero, s1, a0
2554:             add          s4, s11, a6
2555:             add          a3, t4, a5
2556:             and          t4, a0, a2
2557:             addi         s5, t5, 1521
2558:             csrrsi       s3, 0x343, 15
2559:             auipc        a5, 563066
2560:             remu         s7, s1, s4
2561:             rem          a6, s7, a5
2562:             remu         s7, s4, s11
2563:             div          a4, s3, a3
2564:             bltu         s6, s8, 2580f
2565:             bne          s2, a2, 2572f
2566:             csrrsi       a4, 0x304, 0
2567:             lui          s2, 235023
2568:             bge          s2, gp, 2570f
2569:             mul          a7, s8, a4
2570:             auipc        t2, 416909
2571:             csrrw        gp, 0x343, a0
2572:             csrrci       t2, 0x300, 0
2573:             or           t6, s9, t2
2574:             csrrs        s3, 0x300, zero
2575:             mulhu        s10, s8, a6
2576:             sra          s6, a4, a1
2577:             rem          s6, t4, t3
2578:             bge          t3, s4, 2579f
2579:             divu         s0, t2, ra
2580:             csrrs        t2, 0x304, s6
2581:             remu         t5, s11, s5
2582:             beq          a6, t1, 2602f
2583:             andi         t0, s6, -1714
2584:             div          s4, s10, a5
2585:             div          s6, a5, a0
2586:             bltu         a5, tp, 2604f
2587:             mul          t2, ra, s3
2588:             blt          tp, s7, 2604f
2589:             csrrc        a7, 0x304, zero
2590:             addi         a3, s3, 1729
2591:             lui          t5, 725989
2592:             ori          a2, zero, -1337
2593:             sra          s8, s10, ra
2594:             csrrwi       s2, 0x342, 10
2595:             sll          a3, a5, s4
2596:             csrrci       s6, 0x300, 0
2597:             csrrci       s6, 0x342, 0
2598:             ori          a6, a5, 455
2599:             mul          t2, zero, s0
2600:             blt          s7, a3, 2613f
2601:             csrrci       s2, 0x300, 0
2602:             addi         t0, a6, -1600
2603:             csrrsi       a6, 0x342, 1
2604:             sll          t3, a5, s11
2605:             mulhu        s7, s5, t4
2606:             sub          t1, s5, t1
2607:             xor          t5, a5, s10
2608:             mulh         t3, s9, sp
2609:             csrrsi       t5, 0x342, 9
2610:             mulhsu       s4, gp, t1
2611:             mulhu        t3, t1, t1
2612:             blt          s8, a4, 2621f
2613:             csrrc        a2, 0x305, zero
2614:             csrrw        s10, 0x344, s5
2615:             andi         s1, t6, 1395
2616:             bge          a2, t5, 2629f
2617:             and          t0, s0, s7
2618:             blt          tp, ra, 2636f
2619:             csrrc        t1, 0x305, zero
2620:             blt          a3, ra, 2636f
2621:             csrrsi       a3, 0x304, 8
2622:             andi         s2, s3, -171
2623:             divu         s6, s2, s11
2624:             mulh         t6, sp, s10
2625:             mulhsu       a7, s5, t5
2626:             xori         a1, gp, 277
2627:             sltu         ra, s9, a4
2628:             csrrs        s8, 0x343, a7
2629:             and          t5, s11, s2
2630:             srai         t6, a3, 22
2631:             csrrwi       a3, 0x344, 2
2632:             auipc        a5, 192969
2633:             divu         s10, s11, a7
2634:             csrrsi       s0, 0x301, 14
2635:             csrrci       t3, 0x342, 17
2636:             ori          t0, s6, -586
2637:             bge          a3, s0, 2639f
2638:             remu         s8, sp, s0
2639:             xor          t0, a0, ra
2640:             and          t3, sp, t0
2641:             sltiu        s7, a3, -906
2642:             sll          ra, t6, a3
2643:             mulhsu       gp, a7, gp
2644:             ori          t0, s1, 408
2645:             beq          ra, t5, 2647f
2646:             slli         s6, s0, 22
2647:             auipc        a4, 969832
2648:             add          zero, t2, s5
2649:             mulhu        s2, t6, t6
2650:             add          s3, a0, s4
2651:             csrrci       ra, 0x342, 24
2652:             csrrwi       s8, 0x342, 2
2653:             or           t6, s1, a1
2654:             sltu         t3, t3, t1
2655:             mulhsu       a3, t1, t2
2656:             sltiu        s7, s2, 887
2657:             csrrw        a3, 0x344, s7
2658:             slti         a6, t3, 1338
2659:             srai         a7, t0, 4
2660:             rem          a1, s0, s1
2661:             csrrci       t4, 0x304, 0
2662:             slli         t2, s7, 20
2663:             xori         s2, t1, 833
2664:             ori          a4, s4, -166
2665:             add          ra, t5, t0
2666:             auipc        s6, 915416
2667:             mulhsu       t4, s0, s8
2668:             mulhsu       t2, a0, s0
2669:             addi         s10, t3, 110
2670:             bge          s8, t0, 2671f
2671:             auipc        t6, 350671
2672:             csrrsi       s11, 0x344, 13
2673:             csrrsi       t3, 0x304, 0
2674:             sltu         s2, s3, t3
2675:             sub          s1, s6, t2
main_99:          jal          ra, 3f
0:                jal          t1, 5f
1:                jal          s3, 10f
2:                jal          ra, 0b
3:                jal          a6, 7f
4:                jal          t1, 11f
5:                jal          ra, 1b
6:                jal          ra, 8f
7:                jal          gp, 9f
8:                jal          a5, 2b
9:                jal          a2, 6b
10:               jal          ra, 4b
11:               jal          t1, 12f
12:               sll          a4, a3, s4
2676:             mul          s10, ra, s0
2677:             bge          t2, a4, 2695f
2678:             ori          s3, t4, 139
2679:             divu         s9, tp, t3
2680:             sra          s4, s5, t0
2681:             sll          t1, s2, tp
2682:             or           s8, a4, t4
2683:             mulh         a6, s3, a5
2684:             csrrs        s8, 0x301, s9
2685:             mulhu        t0, t4, s6
2686:             and          t2, t4, tp
2687:             mulh         a7, gp, a7
2688:             rem          ra, s6, s7
2689:             addi         a2, s7, 526
2690:             blt          t2, s8, 2710f
2691:             andi         t4, a0, 501
2692:             csrrci       zero, 0x342, 0
2693:             remu         t3, s10, s8
2694:             sltu         s1, s8, a2
2695:             csrrw        a4, 0x344, s8
2696:             auipc        gp, 878636
2697:             blt          a0, a3, 2714f
2698:             and          t1, t2, s1
2699:             rem          zero, s0, t1
2700:             or           s4, s11, a7
2701:             div          a1, a2, s9
2702:             or           s1, s3, s3
2703:             addi         a5, s8, -1415
2704:             mulhu        s1, t6, a1
2705:             and          zero, a5, t0
2706:             ori          s8, t6, -1528
2707:             and          s5, t0, s2
2708:             slli         s6, s1, 20
2709:             slti         s7, s7, 430
2710:             rem          s4, s0, s9
2711:             csrrci       t5, 0x344, 0
2712:             div          t2, a3, t1
2713:             mulhsu       s3, sp, a0
2714:             nop
2715:             addi         s2, s4, -37
2716:             nop
2717:             csrrw        s5, 0x342, a1
2718:             csrrs        a1, 0x301, a1
2719:             bgeu         tp, a0, 2728f
2720:             or           s0, s11, s4
2721:             csrrw        s3, 0x301, a0
2722:             srli         a4, s0, 28
2723:             sra          s0, a2, t6
2724:             csrrci       s8, 0x305, 0
2725:             add          s6, a5, s7
2726:             csrrw        zero, 0x344, s7
2727:             and          a3, s6, s9
2728:             bne          a1, s2, 2738f
2729:             srai         a2, s8, 0
2730:             mul          s1, t1, a6
2731:             mulh         s4, t5, s8
2732:             srli         a2, s5, 5
2733:             srl          t2, a7, s5
2734:             mulh         a5, s11, gp
2735:             ori          s2, ra, 250
2736:             csrrwi       s1, 0x301, 3
2737:             csrrwi       s8, 0x344, 8
2738:             xori         a5, t1, 57
2739:             auipc        s3, 164205
2740:             remu         t6, t1, s1
2741:             mulh         t6, sp, a3
2742:             mulhu        s0, s11, s6
2743:             csrrci       gp, 0x342, 18
2744:             bge          s1, sp, 2761f
2745:             addi         s1, s10, 242
2746:             csrrci       a1, 0x304, 0
2747:             bge          t6, s1, 2752f
2748:             csrrc        t5, 0x342, s0
2749:             div          s11, s4, s11
2750:             and          zero, a3, s0
2751:             sltiu        a2, t5, 1840
2752:             auipc        t0, 557474
2753:             auipc        s9, 730700
2754:             remu         s10, t1, a0
2755:             nop
2756:             andi         s9, a0, 915
2757:             sll          a2, s10, ra
2758:             remu         t6, t3, ra
2759:             remu         t6, s1, s2
2760:             ori          s1, s9, 1369
2761:             mulhsu       t4, t1, s1
2762:             auipc        t0, 246665
2763:             beq          t1, s7, 2783f
2764:             blt          s3, s10, 2766f
2765:             bne          a1, s0, 2766f
2766:             rem          s9, t5, s1
2767:             slti         a1, zero, 1744
2768:             sltiu        s8, s8, 1855
2769:             remu         t0, tp, a3
2770:             rem          ra, s4, s10
2771:             csrrw        a3, 0x343, s6
2772:             srl          s6, t0, s6
2773:             xor          s11, s5, t5
2774:             slti         s1, s8, 1980
2775:             slti         s0, t1, 23
2776:             bge          a5, zero, 2777f
2777:             slt          t0, s6, sp
2778:             bge          gp, a7, 2787f
2779:             srai         a4, t4, 22
2780:             bgeu         s6, t0, 2789f
2781:             or           s2, t3, s10
2782:             lui          s5, 776438
2783:             slli         a6, t2, 8
2784:             lui          gp, 822750
2785:             sll          t3, a1, sp
2786:             divu         s1, s0, t1
2787:             mul          s11, s11, a1
2788:             srai         s0, a3, 8
2789:             remu         t0, s11, t1
2790:             sub          s6, t5, t3
2791:             bge          a5, t3, 2793f
2792:             xor          s6, s8, s5
2793:             sra          s4, a0, t4
2794:             beq          t4, s4, 2811f
2795:             blt          t3, a0, 2811f
2796:             sltu         s4, s11, t4
2797:             rem          a2, a6, s1
2798:             mulhsu       s1, a6, s8
2799:             sub          s1, s4, sp
2800:             srli         t2, s3, 26
2801:             addi         t3, s7, 1712
2802:             mul          a4, s3, s10
2803:             rem          t3, gp, s2
2804:             auipc        s10, 270639
2805:             xor          s1, s4, t5
2806:             srli         t3, ra, 20
2807:             bgeu         s10, a0, 2827f
2808:             slti         a2, zero, 1827
2809:             rem          s3, s3, t2
2810:             csrrwi       a3, 0x301, 2
2811:             ori          s0, tp, -207
2812:             srli         ra, a0, 30
2813:             remu         s4, t2, s3
2814:             rem          a2, s9, s5
2815:             or           s4, a1, a3
2816:             bgeu         t3, t3, 2832f
2817:             srli         t5, s10, 14
2818:             beq          s0, zero, 2831f
2819:             csrrwi       t3, 0x301, 7
2820:             bgeu         sp, s2, 2837f
2821:             srai         t1, s4, 16
2822:             remu         t2, a2, zero
2823:             mul          s5, t3, s0
2824:             beq          s8, gp, 2831f
2825:             sll          gp, a6, a1
2826:             sra          s0, s9, t5
2827:             csrrs        s9, 0x343, s6
2828:             or           s11, a4, s4
2829:             sra          t0, s7, s7
2830:             srli         s3, t2, 10
2831:             divu         t5, a7, a2
2832:             slt          s3, s5, s6
2833:             remu         s6, s9, a2
2834:             csrrc        s8, 0x344, s4
2835:             ori          s10, ra, 980
2836:             srai         a7, s6, 11
2837:             divu         a1, s0, sp
2838:             sltiu        s5, t6, 1658
2839:             srl          s1, s6, a4
2840:             bne          a7, s4, 2858f
2841:             blt          t6, gp, 2850f
2842:             bgeu         a3, a2, 2853f
2843:             slli         gp, s10, 21
2844:             or           s7, a3, s1
2845:             sub          t4, zero, a6
2846:             mulhsu       a7, zero, t3
2847:             remu         s2, sp, s8
2848:             mulhsu       s11, t4, s0
2849:             sll          t4, t5, s9
2850:             bge          t2, a6, 2866f
2851:             or           s3, t4, s1
2852:             csrrwi       gp, 0x304, 6
2853:             divu         t5, s11, s4
2854:             lui          a4, 573641
2855:             mulhu        ra, s11, sp
2856:             csrrw        gp, 0x344, a5
2857:             and          t2, tp, t4
2858:             bltu         s11, s5, 2859f
2859:             blt          t1, a7, 2879f
2860:             div          zero, s10, tp
2861:             ori          t2, t1, 377
2862:             and          zero, s0, t2
2863:             csrrwi       s8, 0x342, 24
2864:             addi         a5, s0, 319
2865:             sltiu        t2, t4, 1228
2866:             xori         a6, s1, 1934
2867:             slli         t1, s1, 1
2868:             auipc        a7, 652513
2869:             bgeu         s7, s7, 2870f
2870:             beq          s6, tp, 2872f
2871:             mulh         t1, t1, s7
2872:             slli         a3, a2, 26
2873:             mul          t5, s4, sp
2874:             sltiu        s8, t4, 1825
2875:             xor          t4, t1, t2
2876:             srli         t4, t2, 3
2877:             csrrwi       ra, 0x344, 23
2878:             slt          ra, a0, a5
2879:             slt          s3, t6, gp
2880:             csrrci       t5, 0x305, 0
2881:             xor          gp, t3, s2
2882:             csrrw        s1, 0x301, t0
2883:             sltiu        a2, s4, 1888
2884:             ori          s0, s4, -723
2885:             bne          ra, t2, 2890f
2886:             bltu         t6, t5, 2899f
2887:             csrrs        a2, 0x343, t6
2888:             andi         a2, a4, 475
2889:             mulhsu       a7, s1, t6
2890:             bge          s9, sp, 2894f
2891:             addi         t0, s11, 1091
2892:             bne          t6, s6, 2894f
2893:             csrrci       a2, 0x305, 0
2894:             srli         a5, s10, 2
2895:             mulhsu       t6, t2, s11
2896:             rem          t5, s2, t5
2897:             addi         a2, a3, -1254
2898:             xori         s7, s3, 970
2899:             bgeu         gp, s0, 2901f
2900:             nop
2901:             divu         a7, t3, t6
2902:             slti         s4, sp, -486
2903:             nop
2904:             mulhsu       s1, sp, a1
2905:             slt          t6, a3, t0
2906:             div          t3, tp, a5
2907:             and          a3, s7, a6
2908:             rem          a1, a1, sp
2909:             ori          t4, s1, -803
2910:             add          t2, s4, s3
2911:             srl          ra, s7, a7
2912:             sltu         s7, s0, t4
2913:             mulh         ra, a4, s4
2914:             sll          t2, gp, s6
2915:             rem          t2, s6, s4
2916:             csrrc        s0, 0x305, zero
2917:             csrrci       s6, 0x305, 0
2918:             csrrsi       s10, 0x344, 16
2919:             auipc        s4, 723328
2920:             mulhsu       a5, s11, sp
2921:             ori          s11, s6, -1574
2922:             srli         s9, sp, 21
2923:             sub          a6, a7, a7
2924:             xori         a4, a4, 504
2925:             bge          zero, ra, 2943f
2926:             mulh         t4, a3, zero
2927:             addi         s3, s11, 993
2928:             slti         t1, t1, 1150
2929:             div          s3, a1, t2
2930:             bgeu         a2, s5, 2932f
2931:             sra          a7, s2, t1
2932:             andi         a5, a4, -1139
2933:             addi         a4, a6, 1020
2934:             bgeu         sp, s3, 2954f
2935:             or           s3, s6, s8
2936:             sll          t1, gp, t4
2937:             srai         t6, a4, 0
2938:             csrrc        a1, 0x343, s4
2939:             srli         t5, zero, 11
2940:             andi         a2, a7, -1078
2941:             add          t2, t1, s0
2942:             div          t6, a2, s5
2943:             srli         s6, s7, 9
2944:             remu         a3, t6, a2
2945:             sub          zero, gp, t2
2946:             ori          t0, t6, 1614
2947:             rem          s0, a7, ra
2948:             csrrs        s1, 0x305, zero
2949:             csrrwi       s2, 0x344, 20
2950:             xor          t1, t4, a1
2951:             mulh         a7, s4, s5
2952:             mulh         a7, s5, t0
2953:             csrrwi       a5, 0x344, 31
2954:             ori          zero, s8, 332
2955:             lui          s2, 638158
                  srli         t5, zero, 11
                  andi         a2, a7, -1078
                  add          t2, t1, s0
                  div          t6, a2, s5
                  srli         s6, s7, 9
                  remu         a3, t6, a2
                  sub          zero, gp, t2
                  ori          t0, t6, 1614
                  rem          s0, a7, ra

2956:             csrrw        t2, 0x344, s8
2957:             andi         a2, s0, -406
2958:             sltu         t2, a0, a7
2959:             slti         t0, gp, -454
2960:             divu         a2, ra, s6
2961:             divu         t6, a5, s0
2962:             csrrsi       s2, 0x305, 0
2963:             csrrwi       a2, 0x343, 14
2964:             slti         s2, s7, -496
2965:             blt          s6, t1, 2975f
2966:             auipc        a4, 640211
2967:             srl          a7, a6, t6
2968:             remu         t1, s11, a0
2969:             add          a5, t1, a7
2970:             sltiu        a1, a1, 1402
2971:             andi         a1, t5, 292
2972:             beq          s7, a7, 2990f
2973:             csrrwi       s0, 0x342, 6
2974:             sltu         t2, s4, s5
2975:             srai         a1, t4, 28
2976:             csrrc        t1, 0x343, a7
2977:             andi         gp, s11, -714
2978:             bltu         a2, t4, 2998f
2979:             mul          a6, s8, t5
2980:             rem          gp, zero, a2
2981:             sra          a4, s3, s10
2982:             bne          s6, s8, 2984f
2983:             csrrwi       t0, 0x304, 29
2984:             add          t5, a6, t6
2985:             ori          a6, s9, -563
2986:             remu         s0, a3, s6
2987:             sub          s4, s11, a5
2988:             csrrci       a5, 0x342, 0
2989:             csrrsi       s5, 0x344, 0
2990:             srl          s5, s0, t2
2991:             mulhsu       s4, t5, s2
2992:             bge          a1, t5, 2994f
2993:             sll          t4, s7, a2
2994:             sra          a3, t6, a6
2995:             bgeu         t5, s11, 3000f
2996:             bge          t4, s2, 2997f
2997:             csrrw        s10, 0x344, s8
2998:             csrrc        s10, 0x343, zero
2999:             sra          s3, t6, s1
3000:             csrrci       s8, 0x300, 0
3001:             slti         s0, gp, 766
3002:             csrrsi       s2, 0x304, 21
3003:             srli         t5, a2, 5
3004:             sltiu        s1, t4, -1555
3005:             andi         a2, a2, 372
3006:             csrrc        a3, 0x343, s3
3007:             csrrwi       a4, 0x343, 21
3008:             addi         s9, s11, 506
3009:             srai         s11, a2, 9
3010:             bgeu         s0, a7, 3030f
3011:             nop
3012:             csrrci       a6, 0x300, 0
3013:             slli         s9, a5, 29
3014:             srl          t4, s8, s3
3015:             srl          s10, t2, tp
3016:             sltiu        s10, tp, 887
3017:             csrrsi       gp, 0x301, 0
3018:             csrrwi       s6, 0x343, 29
3019:             bgeu         t6, s11, 3032f
3020:             lui          t0, 992502
3021:             sra          t5, a7, tp
3022:             blt          a1, s0, 3039f
3023:             mulhu        a5, s6, t2
3024:             xor          s1, t2, t1
3025:             andi         s11, a1, -602
3026:             blt          t0, s1, 3042f
3027:             mul          t5, tp, t0
3028:             bgeu         a4, ra, 3046f
3029:             slt          s3, s3, t4
3030:             sra          zero, t3, s11
3031:             slt          t1, gp, s0
3032:             nop
3033:             slli         t4, t6, 13
3034:             xori         s6, a1, 1626
3035:             xori         t6, zero, 1247
3036:             rem          a7, s6, s9
3037:             bge          s9, t5, 3057f
3038:             lui          s0, 708897
3039:             or           s7, a3, s1
3040:             or           s7, s11, a2
3041:             csrrwi       a4, 0x342, 13
3042:             and          s9, a6, a6
3043:             srai         s0, t1, 29
3044:             nop
3045:             slt          t6, t0, t0
3046:             sra          a4, ra, a3
3047:             sltu         a7, s3, tp
3048:             slli         t5, gp, 13
3049:             bne          s5, a1, 3059f
3050:             mulh         ra, t5, s0
3051:             srl          a3, tp, a2
3052:             srl          s10, s2, s1
3053:             auipc        s1, 407312
3054:             divu         a2, a3, tp
3055:             remu         a4, tp, ra
3056:             xor          s7, a5, t1
3057:             lui          ra, 332404
3058:             and          t6, t1, s8
3059:             sra          s11, a0, a5
3060:             sub          s0, s0, t1
3061:             bne          s4, s4, 3062f
3062:             div          a6, s0, gp
3063:             addi         t3, a4, -670
3064:             and          t5, s8, s4
3065:             sltiu        s6, s3, 680
3066:             csrrw        a6, 0x304, s2
3067:             csrrwi       a3, 0x301, 20
3068:             csrrs        s3, 0x342, a7
3069:             bgeu         s2, t5, 3080f
3070:             xori         a3, t2, -1519
3071:             divu         s8, s4, s7
3072:             slt          s9, s6, a0
3073:             slti         s10, s8, 1727
3074:             blt          a2, t0, 3090f
3075:             bge          s7, s3, 3084f
3076:             xori         t3, a1, 1643
3077:             rem          s5, zero, a4
3078:             sltu         a2, s4, a1
3079:             srli         t4, s4, 7
3080:             sltu         s3, gp, t2
3081:             xor          t6, a6, t0
3082:             bltu         a4, t4, 3100f
3083:             ori          t3, a5, -2011
3084:             and          ra, a0, a4
3085:             slti         t2, t6, 1
3086:             bgeu         s11, gp, 3090f
3087:             sll          a2, zero, t4
3088:             nop
3089:             beq          s7, t6, 3107f
3090:             sll          s7, a1, t5
3091:             mul          s11, a3, t1
3092:             mul          s4, a3, t3
3093:             slti         t4, s11, -1203
3094:             mulh         a1, a7, s8
3095:             slti         t3, t3, 266
3096:             addi         s3, tp, -335
3097:             csrrs        s4, 0x300, zero
3098:             blt          s3, s8, 3118f
3099:             sltu         a4, t3, s2
3100:             andi         s7, t6, -1178
3101:             srli         gp, s7, 17
3102:             srl          s2, a6, a4
3103:             srl          ra, s4, s10
3104:             div          s8, s8, a1
3105:             remu         t3, s9, ra
3106:             sltiu        a5, a4, 1343
3107:             xor          t1, s0, a3
3108:             csrrci       s9, 0x300, 0
3109:             beq          s6, s9, 3111f
3110:             csrrs        gp, 0x301, zero
3111:             ori          s9, a1, 1619
3112:             lui          s6, 524764
3113:             xor          t4, ra, s11
3114:             and          ra, tp, s9
3115:             mulhsu       t5, s3, sp
3116:             mul          s10, sp, t2
3117:             auipc        s2, 835831
3118:             bne          a1, s11, 3127f
3119:             add          t5, tp, t4
3120:             nop
3121:             bne          a5, t1, 3134f
3122:             mulhsu       a4, s1, a0
3123:             lui          s0, 513288
3124:             add          s5, sp, t6
3125:             bge          a4, s3, 3127f
3126:             lui          a4, 503796
3127:             slt          ra, a5, a6
3128:             blt          t4, gp, 3145f
3129:             csrrci       s1, 0x343, 17
3130:             mulhu        s4, s9, ra
3131:             srli         a5, a2, 7
3132:             rem          t6, s9, t0
3133:             lui          t2, 847911
3134:             mul          t5, a2, t4
3135:             csrrs        s2, 0x344, s0
3136:             slli         t3, s7, 27
3137:             sra          t1, a7, s9
3138:             xori         s9, a1, 1573
3139:             ori          s1, t1, 520
3140:             bltu         a0, a7, 3141f
3141:             lui          s5, 32066
3142:             div          s1, ra, s2
3143:             divu         t4, t1, s6
3144:             sltu         t4, a6, tp
3145:             addi         s4, s4, 442
3146:             srai         a5, s0, 26
3147:             csrrc        t6, 0x304, zero
3148:             add          zero, t2, gp
3149:             srai         t6, s0, 19
3150:             nop
3151:             sub          s5, t2, sp
3152:             addi         gp, t1, 33
3153:             ori          a1, s0, -1513
3154:             srai         s5, s8, 2
3155:             remu         a5, s7, ra
3156:             slti         s0, a0, -377
3157:             mulhsu       s6, t0, tp
3158:             csrrsi       s3, 0x304, 0
3159:             divu         s5, a6, s9
3160:             srl          ra, sp, a4
3161:             add          a4, t3, s0
3162:             nop
3163:             beq          s11, s6, 3172f
3164:             xori         s11, a7, 1986
3165:             mulhu        s10, t3, a6
3166:             bge          t1, a1, 3182f
3167:             csrrw        t0, 0x342, gp
3168:             bgeu         t3, t3, 3170f
3169:             xori         zero, s10, 1506
3170:             srai         t6, s10, 17
3171:             bne          s11, tp, 3178f
3172:             sub          s1, sp, a0
3173:             sll          t4, t4, s3
3174:             csrrwi       a7, 0x301, 14
3175:             srli         t4, a5, 1
3176:             xori         s7, a7, -1441
3177:             slli         a3, zero, 12
3178:             divu         ra, a2, a2
3179:             xor          s11, s1, t5
3180:             srl          s7, s1, ra
3181:             ori          s6, a3, 902
3182:             xor          t4, a7, t0
3183:             andi         t2, s2, 2015
3184:             csrrs        t5, 0x342, zero
3185:             sll          t3, t2, t6
3186:             mulh         a3, t4, sp
3187:             csrrci       s4, 0x344, 16
3188:             sll          t0, s7, t3
3189:             csrrsi       a7, 0x300, 0
3190:             div          s7, s7, zero
3191:             nop
3192:             bltu         s7, s8, 3212f
3193:             srli         s2, t2, 20
3194:             mulhsu       t2, s9, a3
3195:             divu         a5, tp, a3
3196:             nop
3197:             andi         s7, a2, -1341
3198:             lui          s1, 524088
                  la           gp, region_1+57837 #start riscv_load_store_rand_instr_stream_13
                  lbu          s2, 899(gp)
                  andi         s8, s4, -1378
                  div          s3, a7, a5
                  lh           a3, -2003(gp)
                  remu         s9, t3, s1
                  lhu          s4, -1065(gp)
                  or           t6, t6, s2
                  lb           s1, -1745(gp)
                  lui          zero, 115017
                  lbu          s4, -154(gp)
                  lbu          s6, -790(gp)
                  lbu          s6, 1339(gp)
                  sb           a7, -335(gp)
                  sh           a0, 531(gp)
                  lb           zero, 1554(gp)
                  xor          a1, t0, s1
                  xori         a2, s5, -313
                  div          s7, a6, a2
                  csrrsi       s6, 0x343, 11
                  csrrw        zero, 0x301, t1
                  sb           t4, -1702(gp)
                  ori          s3, t0, -196
                  sb           s9, -581(gp)
                  slt          s0, a2, s6
                  xor          a4, gp, a0
                  csrrwi       t4, 0x343, 0
                  lh           s11, -717(gp)
                  lbu          t3, 556(gp)
                  sw           zero, 1603(gp)
                  lbu          s2, -356(gp)
                  sb           s5, 80(gp)
                  sb           t3, -1374(gp)
                  lb           s3, -1718(gp) #end riscv_load_store_rand_instr_stream_13
3199:             andi         s2, a0, -1128
3200:             srl          zero, s4, t0
3201:             srai         t4, a4, 3
3202:             mulh         t4, t3, s11
3203:             or           a2, ra, t1
3204:             bne          s8, s7, 3222f
3205:             xori         t4, a2, -683
3206:             xori         s9, gp, 547
3207:             addi         a3, sp, -1321
3208:             nop
3209:             srli         t3, sp, 17
3210:             bge          zero, s11, 3212f
3211:             csrrsi       s8, 0x344, 20
3212:             auipc        s7, 453363
3213:             sub          a2, gp, s1
3214:             bltu         zero, t3, 3230f
3215:             srli         ra, a2, 24
3216:             srli         a7, gp, 23
3217:             srli         s1, a4, 8
3218:             bgeu         s2, a0, 3227f
3219:             slt          gp, zero, a2
3220:             srl          t6, a0, tp
3221:             or           a7, s5, s4
3222:             mul          s10, s10, gp
3223:             xor          s9, s11, gp
3224:             andi         a3, a5, 1794
3225:             or           s1, tp, s2
3226:             andi         a4, gp, -1482
3227:             slti         a1, a1, 1610
3228:             csrrsi       s3, 0x343, 6
3229:             slti         s3, s9, 951
3230:             sltiu        s6, a0, -954
3231:             beq          a0, t6, 3247f
3232:             add          a1, a0, s5
3233:             xor          t6, a1, a2
3234:             bltu         s4, s8, 3254f
3235:             and          a3, s4, s8
3236:             nop
3237:             xor          s4, t0, t6
3238:             xor          t5, s3, s0
3239:             xori         s9, t0, 1550
3240:             beq          a5, a4, 3260f
3241:             nop
3242:             andi         gp, s11, -584
3243:             bltu         s10, t6, 3253f
3244:             rem          t4, s6, t0
3245:             mul          a5, a7, s11
3246:             div          a7, t3, ra
3247:             rem          zero, a4, a2
3248:             srai         s1, s4, 18
3249:             csrrc        a4, 0x343, s7
3250:             slt          zero, s0, s4
3251:             or           t6, a4, s2
3252:             auipc        a5, 409517
3253:             csrrsi       t6, 0x301, 0
3254:             srl          t5, zero, a0
3255:             remu         t1, s10, a7
3256:             or           t3, s7, a6
3257:             bne          t2, gp, 3258f
3258:             sra          a3, t5, a0
3259:             or           gp, a4, a5
3260:             auipc        a4, 820645
3261:             ori          a2, gp, 141
3262:             andi         zero, a2, -1110
3263:             xori         t1, s2, 305
3264:             div          a1, t5, zero
3265:             bne          s8, a2, 3267f
3266:             mul          a4, s8, gp
3267:             and          t1, s10, s11
3268:             xori         t5, a4, 1748
3269:             and          s2, t5, s8
3270:             sltiu        a6, s9, 736
3271:             divu         ra, s5, sp
3272:             and          t1, a4, a0
3273:             mul          s9, a7, s5
3274:             or           zero, t2, sp
3275:             bge          zero, a5, 3277f
3276:             sltiu        s6, s9, -277
3277:             csrrwi       ra, 0x343, 1
3278:             nop
3279:             bge          s11, t1, 3299f
3280:             sra          s1, a4, a0
3281:             csrrw        ra, 0x342, s3
3282:             slli         s5, s6, 3
3283:             csrrwi       s4, 0x342, 3
3284:             bgeu         t4, sp, 3302f
3285:             csrrw        zero, 0x344, s3
3286:             div          a7, t0, t5
3287:             blt          sp, t4, 3298f
3288:             sra          zero, s3, a6
3289:             bne          t1, s4, 3291f
3290:             bge          t1, t6, 3291f
3291:             slli         t2, s4, 1
3292:             nop
3293:             or           a2, s1, s11
3294:             xor          t5, a3, s8
3295:             ori          s5, s8, -910
3296:             and          s1, s0, a1
                  addi         a1, zero, -7 #init loop 0 counter
                  sra          a4, s3, ra
                  slti         a5, ra, -1062
                  srai         t3, t4, 14
                  csrrw        s3, 0x342, s0
                  slti         s3, zero, 1281
                  addi         s11, zero, -9 #init loop 0 limit
                  auipc        t6, 382529
                  csrrsi       t4, 0x343, 26
main_211_0_t:     mulhsu       s5, a0, sp
                  remu         a2, s9, a4
                  or           a3, s4, a4
                  csrrw        s5, 0x301, s7
                  csrrwi       s5, 0x301, 2
                  addi         a1, a1, -1 #update loop 0 counter
                  nop
                  csrrw        gp, 0x301, s10
                  mulhu        a3, t5, tp
                  mulhsu       t1, a4, s11
                  xori         t1, a7, 19
                  add          s7, s7, gp
                  csrrc        s6, 0x343, zero
                  div          t1, t3, ra
                  xor          t6, t5, ra
                  rem          zero, s8, s5
                  csrrs        t6, 0x343, zero
                  beq          a1, s11, main_211_0_t #branch for loop 0
                  sra          t3, a2, s10
3297:             slti         s10, a4, -1385
3298:             srl          a4, sp, s2
3299:             sltiu        s3, ra, 475
3300:             mulh         a4, a0, s7
3301:             or           t0, s3, s0
3302:             sub          a7, a3, s7
3303:             auipc        t0, 9729
3304:             csrrs        t1, 0x343, zero
3305:             mulhu        s6, s7, zero
3306:             sra          s4, t2, a2
3307:             divu         s2, a6, a7
3308:             srai         a5, sp, 6
3309:             srai         s8, s11, 28
3310:             lui          t4, 579417
3311:             andi         s5, t4, 203
3312:             csrrw        t6, 0x344, t1
                  la           a6, region_0+808 #start riscv_load_store_rand_instr_stream_37
                  lb           t0, -3(a6)
                  lbu          t2, 42(a6)
                  csrrsi       t2, 0x300, 0
                  sb           s2, 45(a6)
                  sb           ra, 45(a6)
                  lbu          t5, 53(a6)
                  sltiu        zero, s5, 1521
                  and          t1, zero, a7
                  xor          a5, gp, a7
                  or           t2, a2, s0
                  sw           s6, 48(a6)
                  rem          a7, t1, t2
                  div          t6, t1, s1
                  andi         s1, t5, -1858
                  lhu          t3, 20(a6)
                  csrrwi       s10, 0x342, 7
                  rem          t6, a6, s5
                  ori          s0, s6, -532
                  csrrci       t2, 0x304, 5
                  xori         s10, t0, 783
                  lbu          zero, -17(a6)
                  sh           s10, 44(a6)
                  csrrc        a1, 0x305, zero
                  lb           t2, -39(a6)
                  lbu          s3, 7(a6)
                  sra          s11, s9, s5
                  mulhu        ra, a2, s6
                  slti         t1, a0, -1569
                  slli         t4, t4, 20
                  sb           a7, -7(a6)
                  mulh         a7, t0, t4
                  lbu          s9, 25(a6)
                  lhu          s1, 10(a6)
                  sh           s6, -64(a6)
                  lb           zero, 59(a6)
                  sll          s6, t2, s5
                  remu         s3, t6, s3
                  or           s0, tp, s3
                  sb           s9, -1(a6)
                  mulhsu       t5, a6, a6
                  sll          s2, a6, s5
                  lhu          s10, 58(a6)
                  lbu          zero, -15(a6)
                  lbu          s5, 38(a6)
                  csrrsi       t0, 0x300, 0
                  csrrci       t2, 0x342, 0
                  mulhu        s4, t1, s2
                  sb           gp, -11(a6)
                  divu         s11, zero, gp
                  lui          a3, 576525
                  csrrci       s7, 0x304, 25
                  lbu          s2, 25(a6)
                  sh           gp, -8(a6) #end riscv_load_store_rand_instr_stream_37
3313:             sra          a3, t4, ra
3314:             xori         zero, s7, 1462
3315:             slt          t6, t2, a7
3316:             nop
3317:             slti         s2, a4, -1226
3318:             bltu         sp, a0, 3335f
3319:             sub          s8, a7, a0
3320:             sra          s8, t1, s0
3321:             sltiu        s5, s4, -2040
3322:             sltiu        s10, s5, 531
3323:             bge          s5, sp, 3327f
3324:             xor          s0, s2, ra
3325:             slli         s9, a1, 15
3326:             srli         s0, t4, 14
3327:             add          a5, t5, t4
3328:             slti         a5, s9, -1472
3329:             slti         t6, sp, 582
3330:             bne          a3, s5, 3350f
3331:             slt          a6, sp, s8
3332:             addi         s2, a4, 673
3333:             mul          s0, t6, s0
                  la           s1, region_1+13667 #start load_store_instr_stream_2
                  la           s4, region_1+15344 #start load_store_instr_stream_0
                  lb           zero, -50(s4)
                  lh           a1, -60(s4)
                  lbu          zero, 26(s1)
                  lbu          a5, -41(s4)
                  lbu          ra, -56(s1)
                  la           s2, region_1+11782 #start load_store_instr_stream_3
                  la           t3, region_1+33833 #start load_store_instr_stream_1
                  lh           s5, 1530(s2)
                  sh           s9, 51(s1)
                  sb           t1, -1284(s2)
                  lw           s5, 131(t3)
                  lbu          t5, -24(s1)
                  lbu          zero, 149(t3)
                  lhu          t4, -446(s2)
                  lb           s10, -23(s4)
                  sb           s8, 43(s4)
                  sb           s0, -16(s1)
                  lh           s9, 1126(s2)
                  lb           zero, 45(s1)
                  sb           a5, -18(s1)
                  lbu          t0, 130(t3)
                  lbu          t6, 1798(s2)
                  lhu          t6, 55(t3)
                  sh           a5, 19(s1)
                  lb           a7, 12(s1)
                  lbu          s8, 27(s4)
                  lhu          s8, 19(s1) #end load_store_instr_stream_2
                  lbu          t2, -1637(s2) #end load_store_instr_stream_3
                  lb           a6, -144(t3) #end load_store_instr_stream_1
                  sb           sp, 41(s4) #end load_store_instr_stream_0
3334:             sll          t6, s7, tp
3335:             auipc        a4, 595697
3336:             slt          a1, s4, s8
3337:             add          a4, s7, s10
3338:             ori          a2, s10, -294
3339:             srli         a7, s6, 28
3340:             mulh         s3, t0, a6
3341:             slti         a1, a6, 1053
3342:             rem          s1, sp, a4
3343:             csrrc        s6, 0x343, s10
3344:             srl          s5, s2, s2
3345:             bltu         a5, a6, 3354f
3346:             auipc        t0, 267059
3347:             nop
3348:             srli         s3, sp, 0
3349:             slti         t0, a3, 918
3350:             sra          zero, s10, s7
3351:             csrrsi       a5, 0x304, 14
3352:             mulhu        s7, t2, ra
3353:             slt          t6, s7, s3
3354:             mul          t2, a4, sp
3355:             sltu         t1, a6, s11
3356:             csrrwi       a3, 0x301, 0
3357:             rem          s2, s1, s8
3358:             slti         s1, s6, -1458
3359:             divu         s10, s6, t4
3360:             bgeu         s3, s0, 3365f
3361:             mul          s3, t6, gp
3362:             and          gp, s6, s9
3363:             bltu         t1, s7, 3372f
3364:             bgeu         s4, a5, 3377f
3365:             slt          s1, a6, a2
3366:             ori          s1, ra, -1575
3367:             or           a6, s1, a5
3368:             blt          s6, s7, 3369f
3369:             and          gp, t3, s5
3370:             nop
3371:             mulh         s1, s6, s3
3372:             csrrwi       s4, 0x342, 5
3373:             slli         a3, zero, 23
3374:             mulhsu       t6, a1, a2
3375:             remu         t1, t2, t0
3376:             ori          s0, s8, 1411
3377:             sltiu        s2, a3, 1769
3378:             csrrw        s1, 0x344, s3
3379:             slt          t4, gp, s8
3380:             div          t2, s9, s3
main_88:          jal          ra, 23f
0:                jal          s1, 14f
1:                jal          ra, 8f
2:                jal          t0, 5f
3:                jal          ra, 0b
4:                jal          t4, 17f
5:                jal          ra, 12f
6:                jal          t1, 16f
7:                jal          s7, 22f
8:                jal          ra, 11f
9:                jal          ra, 7b
10:               jal          ra, 1b
11:               jal          ra, 18f
12:               jal          t3, 9b
13:               jal          ra, 2b
14:               jal          s9, 6b
15:               jal          t0, 4b
16:               jal          ra, 21f
17:               jal          ra, 10b
18:               jal          s9, 3b
19:               jal          ra, 13b
20:               jal          ra, 19b
21:               jal          ra, 24f
22:               jal          ra, 15b
23:               jal          a4, 20b
24:               srli         s4, a5, 18
3381:             andi         a6, a4, -870
3382:             slli         t4, s11, 22
3383:             addi         s10, s9, 1454
3384:             andi         s9, a3, 178
3385:             bltu         gp, s9, 3403f
3386:             or           a7, s9, s1
3387:             csrrs        s8, 0x343, a0
3388:             slt          s7, a6, a2
3389:             lui          s4, 95010
3390:             mul          s6, a0, s5
3391:             divu         t2, a5, t5
3392:             csrrci       s9, 0x344, 0
3393:             nop
3394:             divu         gp, tp, s2
3395:             andi         s1, t2, -754
3396:             ori          s2, s4, 155
3397:             beq          a5, t1, 3404f
3398:             add          s5, s8, tp
3399:             bge          s6, a1, 3415f
3400:             csrrc        t2, 0x344, sp
3401:             sltiu        s2, s6, 808
3402:             xori         zero, s3, 431
3403:             srl          s8, s8, t1
3404:             bne          s0, s2, 3417f
3405:             sltu         a5, sp, t6
3406:             remu         s6, a5, s10
3407:             nop
3408:             mulhu        a1, t2, s10
3409:             sltu         t0, a6, s10
3410:             bne          a6, t3, 3427f
3411:             sra          s10, sp, s9
3412:             ori          s0, a6, -1370
3413:             ori          s8, t0, -463
3414:             nop
3415:             slli         ra, a3, 31
3416:             csrrci       s7, 0x304, 26
3417:             rem          a5, a2, s7
3418:             beq          s4, tp, 3420f
3419:             xori         t3, a3, -1698
3420:             bltu         s4, a3, 3440f
3421:             div          t5, t3, a6
3422:             ori          t3, s3, -1919
3423:             divu         s4, zero, t3
3424:             csrrsi       s10, 0x344, 0
3425:             sub          a5, s6, ra
3426:             csrrci       t5, 0x300, 0
3427:             rem          s7, a4, a2
3428:             slli         t3, gp, 14
3429:             sll          gp, t3, s2
3430:             addi         a1, gp, 957
3431:             srli         s8, s4, 8
3432:             divu         t6, t3, t6
3433:             bge          a5, gp, 3443f
3434:             csrrc        a1, 0x300, zero
3435:             csrrc        t3, 0x300, zero
3436:             divu         s4, s8, t3
3437:             ori          s8, t1, 676
3438:             auipc        s10, 386560
3439:             ori          t0, a4, 683
3440:             slli         a4, s7, 20
3441:             srai         s4, gp, 28
3442:             addi         t5, a2, 93
3443:             addi         s1, a7, 1345
3444:             mulhu        s4, t2, a1
3445:             addi         s9, a5, -1979
3446:             csrrsi       a7, 0x300, 0
3447:             srai         t0, s11, 21
3448:             addi         s0, a5, 635
3449:             sll          ra, a0, a2
3450:             sll          s2, t2, t4
3451:             nop
3452:             auipc        a2, 1045427
3453:             mulhu        zero, ra, sp
3454:             bge          s7, ra, 3455f
3455:             divu         t3, s1, ra
3456:             csrrci       s0, 0x344, 0
3457:             rem          a1, a3, s7
3458:             or           s9, t2, s2
3459:             div          s5, sp, s9
3460:             or           s1, t6, a2
3461:             divu         ra, ra, a1
3462:             mul          ra, tp, s11
3463:             mul          t0, a4, t2
3464:             sll          t3, s3, a7
3465:             slt          t5, t3, s6
3466:             csrrw        a6, 0x301, t6
3467:             sub          gp, t3, t3
3468:             rem          a4, s6, s11
3469:             csrrsi       a1, 0x300, 0
3470:             mulhsu       a5, tp, tp
3471:             bge          t2, ra, 3489f
3472:             auipc        a2, 743056
3473:             sltiu        a1, a4, 748
3474:             bltu         s6, t1, 3487f
3475:             bltu         t2, t0, 3482f
3476:             bgeu         s1, a1, 3485f
3477:             csrrsi       t5, 0x304, 0
3478:             add          s9, s4, a5
3479:             sra          gp, t5, s6
3480:             srl          s5, s10, zero
3481:             blt          t0, sp, 3483f
3482:             div          t5, s11, s0
3483:             csrrc        a3, 0x344, t4
                  li           s6, 0xd4be2fdf #start riscv_int_numeric_corner_stream_23
                  li           t0, 0x3e8dac77
                  li           s7, 0x0
                  li           ra, 0x0
                  li           a1, 0x0
                  li           a7, 0xffffffff
                  li           s0, 0x0
                  li           s3, 0x80000000
                  li           a2, 0xffffffff
                  li           t2, 0x80000000
                  lui          a7, 1044018
                  sub          s6, s7, s3
                  mul          s3, a1, s0
                  lui          s6, 429304
                  rem          t2, a7, t2
                  sub          ra, a2, s7
                  mulhsu       t0, s0, s3
                  sub          s0, s6, s7
                  div          s3, a7, s6
                  nop
                  mulh         t2, a7, ra
                  mul          s7, s6, s6
                  remu         t2, t0, s3
                  rem          t0, s0, s0
                  mul          s0, s6, s7
                  mul          s3, a1, a1
                  divu         s3, s3, t0
                  addi         s6, s6, -660
                  addi         s0, ra, 893
                  mulhsu       t0, s7, a1
                  lui          t0, 508433
                  nop
                  sub          a1, a2, a1
                  div          s6, t2, s6
                  rem          s6, s7, a1
                  addi         s6, a7, 0
                  div          s3, s3, a1
                  lui          a1, 863272
                  auipc        s7, 290949 #end riscv_int_numeric_corner_stream_23
3484:             div          s10, t6, a6
3485:             and          t5, s6, ra
3486:             addi         s6, s7, -1081
3487:             sll          s2, s3, a5
3488:             mul          s7, a6, a4
3489:             csrrw        s5, 0x342, t5
3490:             mulhu        a6, a6, s4
3491:             sll          t2, s8, s0
3492:             auipc        t1, 763389
3493:             ori          a3, a0, 374
3494:             sub          gp, a6, s3
3495:             csrrw        t1, 0x343, s6
3496:             blt          t5, sp, 3498f
3497:             sub          a1, s11, s3
3498:             or           t3, a2, s6
3499:             and          t6, s1, sp
3500:             srl          ra, s2, gp
3501:             srl          s8, t3, gp
3502:             xor          a2, s2, t4
3503:             csrrs        s10, 0x300, zero
3504:             srl          s5, a6, ra
3505:             lui          s1, 908260
3506:             addi         t6, ra, 1348
3507:             auipc        s9, 773987
3508:             bge          s0, s5, 3510f
3509:             lui          s11, 382643
3510:             xori         s3, t4, -1197
3511:             csrrc        s9, 0x342, zero
3512:             sltu         s0, s9, s9
3513:             sub          s2, t5, s2
3514:             and          t1, t3, t1
3515:             addi         s2, s5, 1651
3516:             blt          t4, s8, 3527f
3517:             rem          s4, t2, a0
3518:             csrrw        t1, 0x304, s0
3519:             xori         s11, a6, -1929
3520:             mul          t2, tp, s2
3521:             divu         s4, t4, s0
3522:             rem          s9, t1, a3
3523:             mulh         gp, s5, s11
3524:             srai         a1, a3, 20
3525:             csrrc        zero, 0x305, zero
3526:             blt          a4, s6, 3546f
3527:             andi         t5, s11, -383
3528:             sltiu        a4, t5, 599
3529:             bne          s10, s7, 3546f
3530:             srli         s8, sp, 23
3531:             slti         a5, t3, -911
3532:             slli         t0, s11, 25
3533:             nop
3534:             remu         a5, s9, s1
3535:             bgeu         s2, ra, 3536f
3536:             csrrc        s3, 0x304, t3
3537:             add          s5, t4, a1
3538:             slti         s2, a2, 1392
3539:             or           s3, a2, s10
3540:             mulhsu       t2, a4, ra
3541:             remu         t5, t6, s8
3542:             csrrs        a3, 0x344, zero
3543:             beq          s2, gp, 3552f
3544:             addi         a4, sp, -1422
3545:             sltiu        s3, zero, -1053
3546:             divu         a4, sp, t1
3547:             xor          t4, s6, a4
3548:             csrrsi       a4, 0x300, 0
3549:             srai         t3, t0, 1
3550:             mulh         a6, zero, s2
3551:             lui          s0, 994775
3552:             or           s4, a6, s9
3553:             and          s9, a2, t4
3554:             slt          s4, t5, a0
3555:             slli         t6, s6, 28
3556:             srli         a6, sp, 5
3557:             sub          s10, t4, s4
3558:             slti         s11, s7, -630
3559:             add          t6, s4, zero
3560:             csrrs        t2, 0x343, s1
3561:             slt          a6, t5, s1
3562:             divu         s6, s11, t2
3563:             sub          a1, s1, zero
3564:             sltu         zero, s3, a0
3565:             xori         a4, a6, -1263
3566:             auipc        s8, 220660
3567:             rem          s0, s6, a3
3568:             bltu         s2, s6, 3570f
3569:             sll          s0, t4, gp
3570:             addi         a7, s10, 1161
3571:             lui          s6, 252457
3572:             bgeu         t4, a1, 3581f
3573:             rem          a6, s2, sp
3574:             slli         s5, t4, 7
3575:             slti         a6, s8, -42
3576:             csrrsi       s9, 0x344, 0
3577:             mulhu        t6, tp, t6
3578:             sra          t4, s6, s10
3579:             rem          s11, s11, s3
3580:             divu         t2, t3, s1
3581:             bne          s1, a3, 3597f
3582:             mul          a7, zero, s9
3583:             ori          s6, t1, 1440
3584:             slti         a4, zero, -995
3585:             blt          t6, t2, 3605f
3586:             remu         s1, t2, a0
3587:             bne          s9, t2, 3603f
3588:             addi         a6, a2, 1916
3589:             csrrc        s11, 0x304, zero
3590:             slli         a6, a4, 19
3591:             mulh         s5, a6, s4
3592:             srl          t1, s7, s7
3593:             srl          s6, s2, a6
3594:             slti         s0, s5, -875
3595:             div          t0, zero, t4
3596:             beq          s9, s4, 3616f
3597:             slt          s2, a7, a7
3598:             div          t0, a3, t5
3599:             srai         zero, t3, 12
3600:             srl          t0, sp, s9
3601:             nop
3602:             bltu         s2, s9, 3620f
3603:             rem          t6, a4, ra
3604:             bne          ra, ra, 3608f
3605:             or           ra, a1, s8
3606:             sltiu        s1, s4, -1859
3607:             divu         t4, zero, a3
3608:             sub          t4, tp, gp
3609:             csrrwi       t1, 0x344, 23
3610:             bge          s1, a3, 3612f
3611:             xor          s4, a0, s9
3612:             csrrs        s0, 0x343, zero
3613:             auipc        s3, 169688
3614:             xor          s4, t3, t3
3615:             bne          t4, tp, 3616f
3616:             addi         t2, s10, 107
3617:             remu         s7, ra, s8
3618:             mulhu        zero, s4, s11
3619:             mul          s2, s5, tp
3620:             divu         s9, a1, t6
3621:             csrrwi       s9, 0x343, 21
3622:             or           t3, s6, s2
3623:             divu         s5, s8, s8
3624:             and          a2, a6, ra
3625:             auipc        t1, 659748
3626:             csrrs        t5, 0x344, s1
3627:             csrrci       s7, 0x305, 0
3628:             csrrs        t5, 0x304, t2
3629:             auipc        s1, 175168
3630:             bltu         t6, s11, 3643f
3631:             mulhu        s1, a2, zero
3632:             or           a6, a2, s10
3633:             lui          t2, 581296
3634:             srl          ra, a5, sp
3635:             blt          a7, t5, 3652f
3636:             sltiu        s1, s8, -536
3637:             xori         t2, t6, -1494
3638:             bgeu         gp, s6, 3654f
                  la           gp, region_0+69 #start load_store_instr_stream_0
                  la           t2, region_1+2968 #start load_store_instr_stream_1
                  lbu          a5, -121(t2)
                  lh           s5, 7(gp)
                  lb           a3, 91(gp)
                  lhu          a7, -278(t2)
                  lbu          s7, 169(t2)
                  lhu          a1, -1630(t2)
                  lhu          s8, 205(gp)
                  lbu          a1, 114(gp)
                  lbu          t3, -42(gp)
                  lw           zero, 2008(t2)
                  lb           t6, 116(gp)
                  sb           t1, 1281(t2)
                  lh           s1, -5(gp)
                  lbu          s4, 233(gp)
                  lbu          s7, 1001(t2) #end load_store_instr_stream_1
                  lb           s10, 92(gp)
                  sb           gp, 121(gp) #end load_store_instr_stream_0
3639:             slli         s4, t0, 7
3640:             csrrwi       t4, 0x344, 0
3641:             slti         a5, s8, 1927
3642:             add          a3, t2, ra
3643:             sra          a6, t4, s5
3644:             slt          a6, t4, s7
3645:             sra          t6, s7, t2
3646:             sra          s8, s11, s7
3647:             remu         s2, s1, s6
3648:             ori          t0, sp, 191
3649:             auipc        t0, 863747
3650:             mulhsu       t3, t0, s6
3651:             bge          s3, gp, 3669f
3652:             or           a7, t4, zero
3653:             andi         gp, ra, 249
3654:             andi         a6, a4, 1630
3655:             mul          ra, ra, a2
3656:             xori         ra, s4, 406
3657:             andi         s11, s4, -1326
3658:             addi         s3, s10, -1914
3659:             beq          a7, s0, 3664f
3660:             csrrc        t1, 0x342, zero
3661:             ori          s0, a7, -1630
3662:             sll          gp, a0, t1
3663:             sra          gp, a0, a3
3664:             sll          s9, t1, s5
3665:             srl          s2, gp, s11
3666:             mul          a5, t3, a0
3667:             rem          t5, a0, s5
3668:             csrrci       a4, 0x342, 1
3669:             addi         s8, zero, 62
3670:             csrrc        s3, 0x344, s1
3671:             slt          s8, t5, t6
3672:             slt          s10, a3, a6
3673:             srai         a7, ra, 15
3674:             blt          t1, ra, 3683f
3675:             addi         s6, s7, -288
3676:             slti         t2, ra, -1171
3677:             srai         a4, t4, 14
3678:             sltu         a6, a1, s9
3679:             mulh         s2, s3, s7
3680:             bltu         ra, a5, 3693f
3681:             sltu         gp, a1, a4
3682:             csrrwi       t5, 0x304, 12
3683:             mulhsu       s0, gp, s2
3684:             sub          a3, gp, s5
3685:             xori         s4, s2, 273
3686:             xor          s9, s11, zero
3687:             auipc        t3, 789681
3688:             csrrw        s7, 0x301, s3
3689:             xori         ra, s11, 251
3690:             sltiu        ra, t2, -1735
3691:             auipc        t5, 849747
3692:             rem          s9, s0, s4
3693:             mul          a2, s8, a1
3694:             mulhu        t0, t6, ra
3695:             sll          t0, s8, s11
3696:             csrrw        ra, 0x342, s9
3697:             sltu         a4, a0, tp
3698:             auipc        s10, 680102
3699:             sll          t1, a0, sp
3700:             nop
3701:             csrrc        a4, 0x343, zero
3702:             sll          gp, s10, a1
3703:             auipc        s9, 519224
3704:             auipc        ra, 420439
3705:             bge          s2, s2, 3707f
3706:             mulh         a4, ra, a2
3707:             xor          s7, a1, t0
3708:             bne          s8, t0, 3715f
3709:             or           s3, s10, s2
3710:             and          ra, s1, t3
3711:             xor          s4, a2, a6
3712:             sub          s11, s1, a0
3713:             csrrwi       s5, 0x344, 11
3714:             bltu         a2, a6, 3727f
3715:             mulh         t6, ra, s2
3716:             slli         s3, a5, 29
3717:             addi         t3, ra, -1563
3718:             slti         a2, a4, -895
3719:             add          t2, s5, s7
3720:             andi         a6, gp, 526
3721:             bltu         t4, s5, 3722f
3722:             sub          gp, s6, gp
3723:             bltu         t2, s1, 3741f
3724:             addi         gp, a0, -1820
3725:             bne          s3, t3, 3730f
3726:             sltu         s11, s11, gp
3727:             or           s2, s5, sp
3728:             add          s1, a0, s11
3729:             bge          s1, zero, 3745f
3730:             csrrci       a6, 0x304, 12
3731:             divu         s11, t6, s9
3732:             sltiu        t0, a1, 1317
3733:             sll          s1, ra, a4
3734:             auipc        a2, 669340
3735:             divu         a3, a7, t0
3736:             nop
3737:             addi         s8, s11, -1317
3738:             or           a5, s0, t0
3739:             andi         s11, a6, -280
3740:             auipc        s8, 552240
3741:             bge          t3, s1, 3761f
3742:             bgeu         zero, s0, 3753f
3743:             csrrci       s2, 0x342, 1
3744:             remu         s7, tp, a7
3745:             nop
3746:             slt          a5, s8, s0
3747:             bge          a3, t4, 3757f
3748:             csrrci       t4, 0x301, 9
3749:             or           a4, a6, a6
3750:             beq          sp, t0, 3751f
3751:             add          t1, s9, a0
3752:             blt          t4, s9, 3772f
3753:             bltu         s2, s6, 3769f
3754:             bltu         sp, a5, 3774f
3755:             add          zero, t2, a0
3756:             csrrw        a5, 0x343, t4
3757:             blt          s5, tp, 3759f
3758:             andi         s5, gp, 994
3759:             rem          a5, s0, gp
3760:             sra          s9, a1, s1
3761:             slti         a6, a5, -1073
3762:             sub          t6, t6, a7
3763:             bgeu         s7, s10, 3779f
3764:             sltu         a6, s1, s6
3765:             mulh         s1, s7, t4
3766:             xor          s6, t3, s6
3767:             sltiu        a3, a7, 1341
3768:             slt          s3, a6, t4
3769:             sub          s11, a4, s8
3770:             bge          gp, zero, 3788f
3771:             csrrwi       t1, 0x344, 25
3772:             remu         a7, s5, t1
3773:             srai         s2, tp, 1
                  la           t2, region_0+3361 #start riscv_load_store_hazard_instr_stream_35
                  lbu          a5, -64(t2)
                  lb           t5, 12(t2)
                  sb           gp, -45(t2)
                  lhu          s2, -45(t2)
                  slti         s1, a0, -578
                  auipc        s8, 1013884
                  div          s4, t2, t3
                  mulhsu       zero, a0, s6
                  xor          s9, s3, t6
                  lw           a5, -1(t2)
                  lh           ra, -1(t2)
                  sh           s7, -1(t2)
                  lbu          t3, -18(t2)
                  lbu          t3, -18(t2)
                  mulhsu       t1, s5, s5
                  sw           s0, 55(t2) #end riscv_load_store_hazard_instr_stream_35
3774:             blt          s4, a7, 3791f
3775:             bltu         gp, s3, 3777f
3776:             xori         t2, s8, 1182
3777:             bgeu         ra, a4, 3795f
3778:             mul          t2, t0, t1
3779:             mul          t2, s7, s7
3780:             bltu         t2, gp, 3781f
3781:             xor          s7, t3, a6
3782:             mulh         s0, ra, a2
3783:             addi         s8, sp, 452
3784:             mul          a3, s6, gp
3785:             or           a5, sp, t0
3786:             or           s11, s3, sp
3787:             sub          a4, s11, t5
3788:             csrrsi       gp, 0x305, 0
3789:             bne          s2, a2, 3806f
3790:             csrrci       t4, 0x304, 0
3791:             srl          s7, s1, s4
3792:             bgeu         t0, t1, 3794f
3793:             divu         a6, s6, t1
3794:             csrrci       ra, 0x343, 0
3795:             blt          t0, sp, 3815f
3796:             addi         s9, t1, 345
3797:             csrrsi       a3, 0x300, 0
3798:             bge          s11, zero, 3807f
3799:             sra          zero, s11, t3
3800:             bgeu         sp, sp, 3804f
3801:             srl          s1, t2, a1
3802:             srli         s10, a3, 14
3803:             andi         a5, s8, -1343
3804:             bne          t0, tp, 3813f
3805:             and          s0, s1, s2
3806:             sub          ra, s5, t1
3807:             csrrw        a5, 0x301, s11
3808:             bltu         a0, s3, 3810f
3809:             mulhsu       s8, t3, a6
3810:             mulh         t1, s10, s9
3811:             xor          s1, s11, s3
3812:             srli         a5, t4, 2
3813:             divu         t1, t0, gp
3814:             and          s0, a7, t5
3815:             csrrc        a5, 0x301, zero
3816:             mulh         s8, s9, s8
3817:             remu         s7, tp, a5
3818:             or           a2, a4, a6
3819:             srli         s9, s8, 25
3820:             div          zero, t2, s11
3821:             csrrci       s1, 0x344, 0
3822:             csrrsi       a5, 0x343, 0
3823:             nop
3824:             csrrci       a7, 0x301, 0
3825:             sra          s6, gp, a1
3826:             div          t6, a5, a4
3827:             mulhu        a4, a6, a1
3828:             srli         s1, s1, 8
3829:             sltu         t6, a3, s6
3830:             sll          t4, s11, s8
3831:             xor          s1, s5, tp
3832:             andi         s10, a2, 175
3833:             srai         t2, t1, 31
3834:             div          a4, t2, s7
3835:             auipc        t2, 871506
3836:             nop
3837:             and          zero, a3, s7
3838:             xori         t6, t0, 51
3839:             srai         s9, a3, 21
3840:             mulhu        t0, t0, gp
3841:             bne          t0, a7, 3861f
3842:             nop
3843:             ori          s4, a1, -1580
3844:             csrrsi       a3, 0x342, 24
3845:             csrrc        a7, 0x305, zero
3846:             mul          t4, a2, t4
3847:             nop
3848:             bgeu         t6, s7, 3850f
3849:             blt          s2, s5, 3867f
3850:             div          s11, s5, a2
3851:             rem          zero, s10, a2
3852:             csrrsi       s2, 0x344, 0
3853:             csrrci       s0, 0x343, 0
3854:             mulhu        t4, gp, a0
3855:             csrrc        s11, 0x304, s2
3856:             ori          a7, t5, -1327
                  la           a6, region_1+4470 #start riscv_load_store_hazard_instr_stream_39
                  sb           s3, 27(a6)
                  lbu          s0, -55(a6)
                  sltiu        s11, a1, -346
                  lbu          a4, -55(a6)
                  lb           s11, -55(a6)
                  lbu          s4, 61(a6)
                  lbu          s7, 61(a6)
                  lb           t6, 61(a6)
                  lhu          s2, 36(a6)
                  csrrc        a4, 0x344, sp
                  sb           t6, 36(a6)
                  lb           t2, 17(a6)
                  sb           gp, 17(a6)
                  sb           tp, 17(a6)
                  lbu          a1, 17(a6)
                  lb           s10, -61(a6)
                  csrrc        zero, 0x342, zero
                  lb           t4, -61(a6)
                  lbu          t5, -61(a6)
                  sb           s8, -45(a6) #end riscv_load_store_hazard_instr_stream_39
3857:             and          s1, a4, a3
3858:             bne          s0, a7, 3874f
3859:             mul          a3, s11, s6
3860:             csrrw        a1, 0x344, s1
3861:             csrrc        s4, 0x342, s7
3862:             bne          a4, ra, 3878f
3863:             srli         a2, a3, 25
3864:             ori          s8, t0, 1387
3865:             csrrwi       t0, 0x342, 1
3866:             add          a7, s8, s7
3867:             remu         s9, t3, tp
3868:             or           t1, t0, a6
3869:             srai         a2, t5, 19
3870:             bge          a6, s5, 3890f
3871:             csrrc        s6, 0x304, zero
3872:             csrrs        s4, 0x300, zero
3873:             sltiu        a2, t4, -663
3874:             bgeu         s0, a1, 3881f
3875:             srli         s5, t5, 21
3876:             auipc        s11, 452109
3877:             or           t2, t5, t6
3878:             sra          t1, t6, gp
3879:             lui          s9, 409022
3880:             div          s5, s2, s7
3881:             sltiu        t5, a3, 111
3882:             sub          s1, gp, s7
3883:             slli         s7, sp, 12
3884:             mulh         s11, a3, t4
3885:             sub          t2, s8, t2
3886:             srl          s6, s0, a3
3887:             andi         a7, s7, 1419
3888:             bge          t3, s9, 3897f
3889:             andi         s1, s0, 1392
3890:             xor          t4, ra, zero
3891:             bgeu         s8, a4, 3904f
3892:             sra          t5, s7, t4
3893:             div          a6, t4, s9
3894:             csrrsi       t3, 0x301, 21
3895:             csrrs        a3, 0x344, zero
3896:             csrrwi       t0, 0x344, 3
3897:             blt          ra, s9, 3915f
3898:             nop
3899:             csrrc        a5, 0x301, gp
3900:             nop
3901:             csrrw        s0, 0x301, t4
3902:             mulhu        zero, zero, a3
3903:             lui          ra, 752045
3904:             sltu         s8, a4, a1
3905:             add          a1, s6, s2
3906:             rem          s7, t3, a1
3907:             csrrw        s5, 0x344, sp
3908:             slt          t0, s1, t6
3909:             srli         s0, a7, 18
3910:             or           t2, a3, t0
3911:             divu         s6, a0, a4
3912:             srl          t0, s11, t0
3913:             csrrw        t2, 0x301, s6
3914:             srli         t2, tp, 6
3915:             div          s5, s7, tp
3916:             divu         t0, gp, zero
3917:             rem          zero, s5, t2
3918:             addi         t6, s1, 1330
3919:             mul          ra, t1, s7
3920:             srli         t1, t0, 11
3921:             bne          a1, s1, 3934f
3922:             add          gp, s11, a3
3923:             sltiu        t5, a5, -748
3924:             rem          s2, a0, a5
3925:             or           s0, a4, sp
3926:             xori         t3, s8, -2005
3927:             srl          a3, s0, s11
3928:             mulhsu       s0, gp, zero
3929:             lui          a2, 993927
3930:             add          s4, tp, s11
3931:             mulhsu       t5, t6, sp
3932:             bge          t1, zero, 3941f
3933:             blt          s8, s1, 3934f
3934:             srai         t0, t6, 1
3935:             srli         zero, ra, 28
3936:             mulh         t6, t5, s6
3937:             bge          s11, a6, 3941f
3938:             bgeu         a0, ra, 3958f
3939:             slli         a5, a3, 14
3940:             nop
3941:             csrrs        gp, 0x344, zero
3942:             rem          a1, t5, a4
3943:             beq          s7, t3, 3945f
3944:             bgeu         t4, tp, 3962f
3945:             lui          a3, 145297
3946:             sub          a5, a7, a6
3947:             mul          t5, a3, zero
3948:             mul          s8, s1, s7
3949:             beq          ra, t6, 3966f
3950:             srl          s11, a0, a6
3951:             mulhsu       t0, a5, s11
3952:             div          s1, s5, a7
3953:             slti         t2, s9, -1749
3954:             addi         a7, s0, 1140
3955:             xori         s7, s9, -1978
3956:             slli         zero, a4, 2
3957:             sub          t2, t4, a2
3958:             auipc        t0, 153264
3959:             mulhu        s11, gp, sp
3960:             andi         s10, s3, 1669
3961:             srli         t5, t3, 28
3962:             xori         a2, s1, -1731
3963:             sltiu        s8, s6, 57
3964:             or           s3, ra, a3
3965:             sltu         s11, s10, s11
3966:             mulhsu       a6, s3, t0
3967:             mulhsu       a2, gp, s2
3968:             andi         t1, a6, -268
3969:             or           s10, a6, s8
3970:             mul          a1, zero, t0
3971:             div          s4, zero, a0
3972:             slli         a1, zero, 12
3973:             nop
3974:             mulhsu       a1, s6, s3
3975:             xor          s6, a6, s2
3976:             or           a4, a5, t2
3977:             div          t0, ra, s5
3978:             nop
3979:             andi         s4, s5, -97
3980:             csrrs        s0, 0x304, gp
3981:             csrrc        t4, 0x300, zero
3982:             slti         a1, s11, -1656
3983:             bgeu         gp, ra, 3994f
3984:             lui          a7, 430900
3985:             sra          s8, a4, s0
3986:             mulhsu       s4, s7, t6
3987:             sra          t3, a5, gp
3988:             mulhsu       s10, zero, a3
3989:             rem          s5, s0, t6
3990:             slti         gp, ra, -1586
3991:             csrrs        s0, 0x301, zero
3992:             andi         t3, s5, 479
3993:             lui          a6, 529117
3994:             sll          s7, gp, s1
3995:             mulhu        t4, s2, a3
3996:             rem          s8, s10, s9
3997:             addi         s11, s8, -1395
3998:             sub          s6, s0, t6
3999:             srli         s9, sp, 15
4000:             addi         a5, a0, 520
4001:             bltu         s8, s11, 4003f
4002:             mul          t5, sp, t3
4003:             div          gp, s2, zero
4004:             bne          s11, a7, 4006f
4005:             auipc        s8, 641673
4006:             and          zero, sp, a2
4007:             lui          s5, 448042
4008:             csrrwi       t4, 0x342, 9
4009:             addi         s6, a6, -2038
4010:             beq          s4, s1, 4011f
4011:             slli         s7, t4, 1
4012:             sub          t4, ra, gp
4013:             csrrci       zero, 0x304, 0
4014:             sltu         s6, s11, a7
4015:             sltiu        t3, a0, -705
4016:             mulhu        a6, s9, s4
4017:             bne          s6, a4, 4037f
4018:             csrrs        t0, 0x342, zero
4019:             sltu         s4, a2, a0
4020:             mulhsu       t1, a1, t0
4021:             rem          a2, s0, s5
4022:             auipc        a7, 839
4023:             slti         s4, gp, 540
4024:             mul          t6, a3, sp
4025:             sltiu        s3, tp, 387
4026:             mulhu        s4, s11, s2
4027:             csrrc        a2, 0x301, zero
4028:             div          s6, t3, s8
4029:             csrrc        t5, 0x300, zero
4030:             srl          s6, t2, s9
4031:             slt          s0, s6, tp
4032:             rem          t1, a5, t5
4033:             remu         a1, a6, a6
4034:             xor          a4, s1, t2
4035:             nop
4036:             slli         s1, a2, 8
4037:             csrrw        a3, 0x304, s7
4038:             bge          a6, t2, 4054f
4039:             mulh         s2, ra, sp
4040:             blt          t6, s6, 4042f
4041:             csrrci       a3, 0x304, 15
4042:             nop
4043:             sltu         t0, t5, a0
4044:             csrrwi       a4, 0x344, 29
4045:             andi         zero, s3, 1205
4046:             sra          a4, zero, t6
4047:             beq          a5, s7, 4056f
4048:             lui          s5, 105028
4049:             slt          t5, s4, a7
4050:             divu         s1, sp, zero
4051:             bgeu         s6, tp, 4052f
4052:             div          s1, s3, gp
4053:             mul          a7, t3, a7
4054:             slti         s11, ra, 16
4055:             andi         a5, s1, 2026
4056:             bge          sp, t2, 4061f
4057:             mulhu        zero, t6, s5
4058:             sltiu        t0, a2, -1359
4059:             sltu         s7, s4, ra
4060:             bge          a4, zero, 4077f
4061:             addi         a2, t2, -759
4062:             divu         s6, a5, a5
4063:             sltu         s6, a2, t1
4064:             divu         ra, a2, a2
4065:             xori         t6, t2, -1248
4066:             csrrsi       s7, 0x305, 0
4067:             div          a3, s3, a0
4068:             bge          s11, s2, 4078f
4069:             add          s9, t5, s9
4070:             ori          a1, a4, -1194
4071:             addi         t4, a6, -1546
4072:             auipc        a7, 65760
4073:             csrrsi       s8, 0x301, 15
4074:             csrrc        s11, 0x342, zero
                  la           s1, region_1+17316 #start riscv_load_store_rand_instr_stream_17
                  lbu          a4, 10(s1)
                  addi         t2, t3, -573
                  sb           a3, 5(s1)
                  sw           s1, -24(s1)
                  sb           a5, 51(s1)
                  lbu          s9, -47(s1)
                  slti         zero, tp, -425
                  lb           zero, 59(s1)
                  lh           t4, 48(s1)
                  lh           t1, 54(s1)
                  lbu          s11, 7(s1)
                  sb           t2, -41(s1)
                  lb           s4, 3(s1)
                  lbu          t2, 29(s1)
                  mulhu        a6, t5, s10
                  srai         s5, a3, 27
                  slli         s5, a7, 5
                  sb           sp, 30(s1)
                  auipc        s8, 1027591
                  add          s3, s0, t1
                  lb           s9, -59(s1)
                  sb           t1, 35(s1)
                  lh           s3, 32(s1)
                  lh           t2, 42(s1)
                  slt          s4, gp, s6
                  sll          s8, s6, a0
                  sltu         s4, a2, s11
                  sb           a4, -36(s1)
                  csrrc        t5, 0x300, zero
                  andi         a5, s5, 1609
                  sb           tp, 41(s1)
                  srl          s8, ra, a1
                  csrrwi       s4, 0x304, 13
                  csrrs        t0, 0x343, zero
                  csrrc        t5, 0x343, tp
                  div          t3, t2, t3
                  mulhsu       a3, a6, s0
                  add          a1, s3, a4
                  sb           a7, -34(s1)
                  nop
                  lb           s0, 20(s1)
                  sltiu        s2, a3, -381
                  lb           s2, 39(s1)
                  auipc        a3, 156666
                  sb           gp, -47(s1) #end riscv_load_store_rand_instr_stream_17
4075:             or           s5, a7, t5
4076:             divu         a5, s0, s7
4077:             lui          s1, 746314
4078:             andi         s3, t0, 223
4079:             remu         a1, a6, s2
4080:             andi         gp, sp, -1427
4081:             rem          s0, s2, s5
4082:             sltu         s11, zero, t2
4083:             sll          s8, t3, a6
4084:             nop
4085:             or           a6, a3, s6
4086:             srli         s8, s7, 7
4087:             mul          s9, a6, a6
4088:             ori          s7, s5, 1421
4089:             mulh         t5, zero, gp
4090:             csrrc        a2, 0x300, zero
4091:             srl          ra, sp, a7
4092:             bge          s5, a1, 4093f
4093:             bgeu         s11, s3, 4113f
4094:             csrrw        zero, 0x344, a7
4095:             csrrwi       s6, 0x342, 4
4096:             bge          s0, a5, 4112f
4097:             bltu         s10, s9, 4108f
4098:             add          s8, a5, zero
4099:             sub          t5, s3, t4
4100:             andi         s8, a5, -336
4101:             rem          s0, a4, a5
4102:             bne          t3, ra, 4104f
4103:             mul          s4, t4, s10
4104:             xori         a4, s8, 473
4105:             csrrc        t6, 0x344, s7
4106:             sltiu        s11, t4, -1387
4107:             csrrs        s8, 0x304, a5
4108:             csrrc        a4, 0x343, s3
4109:             slti         t4, s5, -1461
4110:             rem          t1, a0, s11
4111:             nop
4112:             and          s8, a3, s6
4113:             csrrsi       s1, 0x301, 0
4114:             blt          gp, s10, 4123f
4115:             blt          a1, s10, 4133f
4116:             divu         t5, s7, s7
4117:             slt          s9, s3, a6
4118:             bltu         t3, a6, 4138f
4119:             srai         a7, s9, 10
4120:             andi         t0, gp, 876
4121:             csrrs        t5, 0x343, s7
4122:             slti         a1, a3, 627
4123:             div          s0, gp, sp
4124:             srli         t6, s9, 0
4125:             beq          a6, s9, 4132f
4126:             mul          t0, s6, s10
4127:             xor          t6, gp, s6
4128:             lui          t2, 698860
4129:             csrrs        s10, 0x300, zero
4130:             auipc        gp, 1005058
4131:             mulh         s4, t5, t0
4132:             bge          s10, a6, 4145f
4133:             ori          t1, a1, 43
4134:             div          t1, s1, t4
4135:             mulhsu       t0, a0, t2
4136:             srli         a2, a7, 0
4137:             slli         s9, t6, 16
4138:             csrrci       t5, 0x305, 0
4139:             slt          zero, s9, a5
4140:             mulh         s4, s10, a0
4141:             slt          s8, s9, s9
4142:             sltu         a6, t2, s0
4143:             xori         t5, t3, -1347
4144:             or           t1, a4, gp
4145:             div          s10, a7, a1
4146:             srai         zero, s8, 17
4147:             mulh         t3, s3, t0
4148:             srai         s10, zero, 15
4149:             csrrwi       s4, 0x344, 25
4150:             srai         s1, s8, 3
4151:             and          s10, zero, t4
4152:             csrrs        a7, 0x301, t2
4153:             sltu         t3, t0, a4
4154:             sub          zero, t1, a5
4155:             sub          s1, zero, a6
4156:             bge          zero, ra, 4158f
4157:             xori         a5, s3, -705
4158:             bgeu         t5, a0, 4159f
4159:             rem          s8, t1, gp
4160:             xori         a6, t5, 1034
4161:             blt          t6, gp, 4162f
4162:             andi         s10, t3, 1339
4163:             nop
4164:             mul          a2, a0, s7
4165:             srl          t1, s5, t4
4166:             bne          a2, gp, 4168f
4167:             sub          a5, gp, a6
4168:             sll          zero, s4, a3
4169:             csrrw        a3, 0x343, a3
4170:             csrrci       s2, 0x300, 0
4171:             lui          s10, 715035
4172:             divu         s3, s8, a0
4173:             csrrs        s8, 0x304, s11
4174:             bltu         a6, s11, 4178f
4175:             beq          s11, gp, 4188f
4176:             auipc        s0, 504789
4177:             or           t6, sp, ra
4178:             xori         a5, t2, 1637
4179:             bge          t6, t5, 4199f
4180:             ori          a1, s11, 437
4181:             bge          sp, a0, 4183f
4182:             csrrc        s6, 0x343, zero
4183:             bgeu         a7, s8, 4203f
4184:             addi         s7, t2, 1741
4185:             divu         t1, s11, a3
4186:             and          gp, s4, s10
4187:             csrrw        t0, 0x301, a2
4188:             remu         t6, s11, tp
4189:             div          s2, zero, s0
4190:             csrrs        t5, 0x304, zero
4191:             csrrci       s0, 0x304, 0
4192:             sra          s0, t4, a3
4193:             mulhsu       gp, sp, s7
4194:             add          s11, a4, s9
4195:             sltu         a3, a4, a7
4196:             lui          t6, 225221
4197:             srai         a1, ra, 30
4198:             csrrc        a1, 0x343, zero
4199:             mulhu        gp, a1, t3
4200:             csrrc        t3, 0x300, zero
4201:             srli         a3, a3, 25
4202:             xori         a2, a7, 1279
4203:             csrrc        a3, 0x305, zero
4204:             addi         t2, a7, 1944
4205:             nop
4206:             srai         a1, t6, 31
4207:             csrrsi       s8, 0x343, 0
4208:             csrrsi       t3, 0x344, 0
4209:             srl          a6, s2, a6
4210:             nop
4211:             mulhsu       t6, s2, s6
4212:             ori          t0, a7, 1849
4213:             beq          s2, a2, 4231f
4214:             divu         a5, s1, s6
4215:             auipc        t1, 970422
4216:             nop
4217:             slt          a6, ra, s5
4218:             remu         a1, tp, s11
4219:             divu         a3, t3, t5
4220:             lui          ra, 726468
4221:             divu         gp, t2, s4
4222:             srai         s7, a4, 22
4223:             srai         t0, t4, 9
4224:             sub          t3, t5, s1
4225:             sll          a6, t0, tp
4226:             bge          gp, s8, 4228f
4227:             csrrci       t3, 0x344, 0
4228:             xori         s7, a1, 410
4229:             or           a6, t2, s4
4230:             sub          a6, gp, t3
4231:             mulh         t4, s3, s1
4232:             lui          s1, 368744
4233:             rem          s5, s1, t6
4234:             xori         a1, s6, 1333
4235:             sll          s9, a0, s1
4236:             andi         s10, s8, -1729
4237:             bge          t1, gp, 4255f
4238:             xori         s6, a6, -1479
4239:             sll          t0, t6, a6
4240:             mul          s4, s7, t3
4241:             csrrwi       a5, 0x301, 0
4242:             mulhsu       s8, t2, s10
4243:             slti         a2, t6, 2017
4244:             beq          a3, sp, 4253f
4245:             csrrw        s5, 0x304, a6
4246:             blt          s6, s6, 4262f
4247:             ori          s11, s1, -969
4248:             csrrsi       t5, 0x343, 29
4249:             bgeu         s5, s10, 4266f
4250:             remu         s10, sp, gp
4251:             div          a6, s2, zero
4252:             srl          t1, s7, s5
4253:             csrrci       a3, 0x300, 0
4254:             srl          s0, ra, t1
4255:             slt          t0, t0, s10
4256:             add          s7, a5, t4
4257:             csrrci       t3, 0x343, 4
4258:             csrrw        s9, 0x344, a1
4259:             bltu         t1, a1, 4276f
4260:             csrrc        t4, 0x305, zero
4261:             mul          a7, s10, a1
4262:             mulh         a5, s4, a0
4263:             sub          t4, s2, s6
4264:             sll          a7, s10, gp
4265:             srl          s0, t5, s5
4266:             csrrc        s2, 0x304, zero
4267:             bltu         s9, t0, 4272f
4268:             remu         s11, a0, s7
4269:             beq          s8, a4, 4278f
4270:             blt          t2, a2, 4280f
4271:             ori          s8, gp, 1959
4272:             ori          s8, a0, 1567
4273:             bge          t2, t4, 4289f
4274:             sll          a6, s7, a4
4275:             sll          a5, a1, s11
4276:             sra          s5, s8, tp
4277:             remu         a2, t4, a5
4278:             blt          tp, s9, 4294f
4279:             srai         s8, a6, 5
4280:             sltiu        gp, a4, 223
4281:             sltiu        t0, s11, -1839
4282:             xor          gp, ra, a5
4283:             slli         a4, t4, 5
4284:             blt          a0, sp, 4302f
4285:             sltu         t4, gp, a1
4286:             sltu         a7, t5, s9
4287:             mul          ra, s10, s3
4288:             addi         t2, a0, -1795
4289:             bgeu         s2, t4, 4302f
4290:             slti         t5, s6, -1677
4291:             csrrw        s10, 0x342, a5
4292:             lui          s9, 747452
4293:             addi         t0, s7, 1516
4294:             rem          s7, tp, s4
4295:             csrrsi       t5, 0x344, 8
4296:             srai         s0, a7, 26
4297:             and          zero, s11, tp
4298:             mulhu        t2, t6, s0
4299:             sltiu        t2, s8, -875
4300:             blt          s5, s8, 4320f
4301:             add          s10, s2, a7
4302:             remu         s7, t6, s2
4303:             nop
4304:             or           a2, a0, s7
4305:             csrrc        t3, 0x305, zero
4306:             srl          t3, s5, s9
4307:             divu         a1, t1, s1
4308:             divu         s0, t4, tp
4309:             divu         t0, a3, a4
4310:             divu         s7, tp, s6
4311:             xori         s6, zero, 236
4312:             and          a7, s5, s10
4313:             srai         ra, gp, 5
4314:             andi         s1, gp, -560
4315:             mulhsu       a2, t3, t4
4316:             srli         a4, t2, 25
4317:             csrrsi       ra, 0x301, 9
4318:             slt          s3, ra, sp
4319:             srli         a5, a2, 8
4320:             blt          t4, tp, 4337f
4321:             div          s8, s4, t1
4322:             add          ra, a5, t5
4323:             bne          t4, tp, 4340f
4324:             add          zero, s9, t5
4325:             csrrsi       t3, 0x344, 0
4326:             csrrs        gp, 0x344, zero
4327:             div          t0, t5, a0
4328:             xori         a2, s3, -413
4329:             add          s10, s11, a6
4330:             andi         t4, s2, 1989
4331:             srli         a4, s10, 17
4332:             mulh         t2, t2, s9
4333:             xori         zero, s0, 56
4334:             sll          s8, a6, zero
4335:             csrrc        a5, 0x300, zero
4336:             ori          a3, a1, 485
4337:             addi         t1, a0, -782
4338:             mulhsu       a6, t1, s0
4339:             and          s8, t3, s10
4340:             and          t6, a6, a0
4341:             srai         s8, s4, 20
4342:             remu         gp, s11, t6
4343:             beq          a6, s6, 4352f
4344:             sub          a1, t0, t0
4345:             csrrsi       t5, 0x301, 0
4346:             divu         t1, s6, t2
4347:             mulhsu       t0, sp, s3
4348:             csrrwi       s5, 0x304, 25
4349:             sub          s0, sp, t6
4350:             sltiu        t3, t5, -628
4351:             csrrwi       ra, 0x304, 14
4352:             slti         s11, s10, 1380
4353:             csrrwi       ra, 0x304, 21
4354:             sltiu        a5, gp, 1079
4355:             csrrwi       t5, 0x343, 7
4356:             auipc        t3, 424594
4357:             csrrwi       t2, 0x344, 15
4358:             xori         a2, s4, -409
4359:             csrrw        a5, 0x342, t1
4360:             csrrwi       t0, 0x342, 4
4361:             and          t4, a0, a1
4362:             mulhu        gp, t4, t2
4363:             andi         ra, s3, -739
4364:             sub          s3, a5, t6
4365:             bge          t5, s2, 4370f
4366:             lui          a1, 406046
4367:             sll          a7, s5, sp
4368:             auipc        s8, 633245
4369:             auipc        s9, 235992
4370:             slti         zero, s1, -1162
4371:             bge          a7, s7, 4391f
4372:             remu         a1, sp, t0
4373:             ori          s1, a6, -1786
4374:             mulh         a7, a2, t5
4375:             ori          a7, s9, 2013
4376:             and          a3, a3, s10
4377:             divu         s10, sp, a7
4378:             xor          a7, a2, t2
4379:             sll          ra, t2, a1
4380:             beq          s2, zero, 4381f
4381:             nop
4382:             add          t4, s0, a7
4383:             addi         gp, t4, 1714
4384:             csrrwi       a6, 0x342, 6
4385:             sltu         a1, s6, zero
4386:             ori          s8, a3, -1142
4387:             mulhsu       zero, a7, a2
4388:             csrrw        a5, 0x344, s7
4389:             srli         s7, a5, 11
4390:             lui          a4, 512722
4391:             nop
4392:             slt          a2, t2, t1
4393:             sub          s4, t0, zero
4394:             rem          s7, ra, sp
4395:             auipc        a2, 307420
4396:             bne          sp, s5, 4397f
4397:             sltu         t4, s0, s6
4398:             csrrw        a5, 0x342, gp
4399:             rem          ra, t4, a7
4400:             bne          gp, ra, 4416f
4401:             sra          t4, t1, zero
4402:             srai         t4, s6, 12
4403:             csrrwi       t4, 0x344, 22
4404:             remu         s6, t2, s1
4405:             csrrwi       t6, 0x342, 12
4406:             addi         t4, s3, 1987
4407:             lui          t4, 251298
4408:             mul          s9, a2, a1
4409:             csrrsi       ra, 0x300, 0
4410:             beq          gp, a2, 4417f
4411:             div          a6, s4, s1
4412:             csrrs        zero, 0x301, s3
4413:             csrrs        t5, 0x305, zero
4414:             xori         s0, t6, 873
4415:             sub          s1, a2, s4
4416:             div          s6, a5, t0
4417:             auipc        ra, 329144
4418:             addi         s5, t1, -690
4419:             bne          ra, tp, 4429f
4420:             sltu         t3, s8, s1
4421:             sll          s4, tp, a1
4422:             sltu         s3, s5, s8
4423:             csrrsi       s8, 0x301, 0
4424:             div          s10, s7, t3
4425:             add          s5, s6, a1
4426:             bge          s3, t3, 4428f
4427:             andi         s3, a1, 12
4428:             sra          t6, a6, t0
4429:             mulhsu       s2, t1, tp
4430:             and          t0, t2, s1
4431:             add          a5, s9, t2
4432:             bltu         s8, t0, 4448f
4433:             srli         s0, s6, 0
4434:             csrrsi       a5, 0x305, 0
4435:             slli         t2, s0, 1
4436:             csrrci       s10, 0x301, 9
4437:             csrrwi       s2, 0x344, 28
4438:             srl          zero, t2, t5
4439:             csrrw        t1, 0x342, s7
4440:             div          s10, t1, t1
4441:             csrrwi       zero, 0x304, 9
4442:             remu         s0, a5, t2
4443:             csrrc        gp, 0x342, s6
4444:             mulhu        s3, s10, s0
4445:             csrrci       t0, 0x342, 0
4446:             bgeu         gp, s1, 4464f
4447:             divu         a7, a2, tp
4448:             csrrwi       s0, 0x344, 23
4449:             and          t4, s0, s0
4450:             bne          a6, s6, 4468f
4451:             sltu         a2, a5, sp
4452:             andi         t6, s10, 1405
4453:             csrrsi       t4, 0x342, 0
4454:             remu         a3, a5, a4
4455:             nop
4456:             sltiu        a5, a5, 204
4457:             csrrsi       a3, 0x342, 0
4458:             mulhu        a5, a0, t0
4459:             xor          s4, t6, s11
4460:             csrrc        a7, 0x305, zero
4461:             mulhu        s9, s2, t0
4462:             csrrw        s11, 0x304, t6
4463:             div          s6, s8, tp
4464:             slt          zero, ra, tp
4465:             sltu         t3, a5, s7
4466:             xor          a1, a0, s10
4467:             csrrw        s9, 0x343, t3
4468:             bltu         s9, a0, 4470f
4469:             xor          gp, s4, t5
4470:             divu         a2, t4, t2
4471:             csrrci       a6, 0x304, 13
4472:             sub          s3, s5, s2
4473:             sll          s10, a1, s8
4474:             andi         s5, t5, 205
4475:             bne          a1, a2, 4488f
4476:             ori          s8, s5, 932
4477:             sltu         t4, s9, t1
4478:             auipc        s0, 861684
4479:             csrrs        s3, 0x344, t0
4480:             or           a1, ra, a2
4481:             blt          a4, a6, 4501f
4482:             sltiu        t0, tp, 1558
4483:             csrrs        a6, 0x344, zero
4484:             slli         s9, t5, 8
4485:             slli         s11, a0, 30
4486:             mulhsu       s5, s0, s4
4487:             srl          t5, s11, a0
4488:             sra          t3, t4, gp
4489:             csrrc        s7, 0x304, a7
4490:             srl          s3, a1, sp
4491:             xori         s11, s2, -845
4492:             bltu         t1, s1, 4512f
4493:             auipc        a2, 249857
4494:             sra          a7, s11, s11
4495:             add          t3, t0, s2
4496:             lui          a5, 694699
4497:             beq          s8, a3, 4506f
4498:             nop
4499:             div          zero, s2, s3
4500:             addi         s8, a5, 1392
4501:             divu         t1, a6, s3
4502:             or           s8, t3, s1
4503:             bgeu         t1, t0, 4505f
4504:             mulh         a6, s7, zero
4505:             mul          s9, t0, s4
4506:             xori         t3, s8, -275
4507:             addi         s2, t1, -1359
4508:             slt          a5, a6, s1
4509:             srl          s3, a7, s8
4510:             div          t2, sp, s5
4511:             csrrs        s8, 0x305, zero
4512:             beq          t4, gp, 4523f
4513:             or           ra, a0, a1
4514:             srai         t3, a0, 9
4515:             csrrs        a1, 0x343, a0
4516:             srl          gp, t5, a6
4517:             sra          s1, t5, s10
4518:             xor          s3, sp, a0
4519:             sltiu        a1, s6, 1178
4520:             slt          s6, t2, a6
4521:             beq          t3, s7, 4523f
4522:             addi         s9, t3, -169
4523:             andi         s0, t3, -1233
4524:             srli         t3, a1, 22
4525:             csrrwi       s8, 0x344, 16
4526:             sub          a2, t6, t4
4527:             xori         a5, s11, 1372
4528:             sra          s8, s7, sp
4529:             mulh         a1, s1, s2
4530:             csrrs        s2, 0x300, zero
4531:             add          a3, s5, s7
4532:             sltiu        s10, s2, 865
4533:             sltu         t2, s6, sp
4534:             bltu         a1, t5, 4535f
4535:             srai         s10, s4, 14
4536:             slli         s9, t2, 25
4537:             csrrsi       s4, 0x300, 0
4538:             addi         s3, s5, -694
4539:             sll          a3, t0, s9
4540:             csrrw        t5, 0x304, t1
4541:             csrrs        t3, 0x300, zero
4542:             bgeu         a7, s10, 4546f
4543:             blt          t1, t2, 4545f
4544:             blt          s0, a7, 4553f
4545:             beq          a5, a3, 4563f
4546:             ori          s8, s0, -1077
4547:             csrrwi       s0, 0x343, 12
4548:             sll          s1, s11, s10
4549:             divu         s1, a0, s6
4550:             rem          s7, s0, ra
4551:             bgeu         zero, a7, 4553f
4552:             bltu         a2, s9, 4570f
4553:             xori         s7, s10, -1241
4554:             or           a4, a5, s9
4555:             nop
4556:             add          s2, gp, t3
4557:             or           s6, a0, s8
4558:             beq          a2, s3, 4569f
4559:             sra          a7, s1, s6
4560:             bgeu         a4, s0, 4576f
4561:             addi         s10, a0, -1679
4562:             mulhsu       a5, s3, a1
4563:             bltu         t6, t6, 4568f
4564:             sra          t0, a6, s4
4565:             addi         s4, s1, -26
4566:             sub          t3, s4, s7
4567:             srli         s5, s7, 19
4568:             slti         s7, s4, 535
4569:             csrrw        t0, 0x342, zero
4570:             add          t3, s9, a7
4571:             csrrsi       s6, 0x304, 6
4572:             mulhsu       t0, t6, gp
4573:             mulh         ra, zero, a1
4574:             csrrsi       a4, 0x301, 28
4575:             srai         s0, s11, 20
4576:             csrrs        s6, 0x344, zero
4577:             rem          s0, tp, s10
4578:             xori         t5, zero, 1965
4579:             bltu         zero, sp, 4595f
4580:             sltu         t0, s9, t4
4581:             beq          s9, s1, 4594f
4582:             mulhu        a2, s6, t2
4583:             slli         ra, t0, 18
4584:             mulhu        t6, a2, a0
4585:             slti         t5, zero, -357
4586:             csrrsi       ra, 0x305, 0
4587:             mulhsu       a5, s9, a1
4588:             mul          s1, sp, s1
4589:             mulhsu       zero, zero, s3
4590:             csrrs        s11, 0x305, zero
4591:             add          ra, s6, sp
4592:             ori          a4, t2, 1825
4593:             csrrc        a4, 0x304, zero
4594:             slli         zero, a7, 0
4595:             csrrs        s4, 0x300, zero
4596:             sltiu        gp, s0, 1628
4597:             bge          s11, t2, 4606f
4598:             csrrc        s1, 0x301, zero
4599:             xori         a5, s10, 254
4600:             srl          t5, a1, t4
4601:             add          t6, s1, t0
4602:             divu         a6, t1, s2
4603:             auipc        t1, 737219
4604:             xori         zero, tp, 36
4605:             mulhsu       t1, tp, s4
4606:             mul          ra, t0, a4
4607:             sltiu        a1, a7, 1110
4608:             nop
4609:             csrrwi       a5, 0x304, 5
4610:             srli         a2, s3, 3
4611:             nop
4612:             rem          t2, tp, a6
4613:             mulh         t2, s7, a4
4614:             xor          a6, a5, ra
4615:             xor          a5, ra, t4
4616:             csrrwi       a3, 0x301, 10
4617:             mul          t3, ra, s0
4618:             lui          zero, 942226
4619:             csrrs        a1, 0x304, s6
4620:             mulhu        gp, gp, sp
4621:             csrrci       s5, 0x304, 0
4622:             csrrsi       s11, 0x301, 14
4623:             mulh         t6, s6, t2
4624:             mulhu        s2, t2, a1
4625:             lui          a3, 687457
4626:             csrrci       a4, 0x304, 0
4627:             blt          ra, zero, 4643f
4628:             divu         a1, t0, s11
4629:             bltu         s7, t4, 4631f
4630:             andi         s11, s11, 1749
4631:             auipc        t3, 959917
4632:             sll          a6, s1, t0
4633:             div          t2, s6, a4
4634:             div          s11, t6, s1
4635:             rem          a2, a0, s10
4636:             csrrs        s10, 0x300, zero
4637:             srl          a5, s4, a5
4638:             csrrw        s11, 0x343, t5
4639:             auipc        gp, 732837
4640:             sltu         s4, a5, s3
4641:             csrrw        t2, 0x343, a1
4642:             auipc        gp, 542516
4643:             auipc        s10, 281188
4644:             srli         s5, s2, 27
4645:             csrrsi       ra, 0x300, 0
4646:             addi         a2, t4, 326
4647:             sltiu        a6, a6, 1155
4648:             auipc        s6, 1047118
4649:             remu         s2, t3, t6
4650:             csrrc        s5, 0x301, zero
4651:             slt          a1, t3, gp
4652:             slli         t2, gp, 15
4653:             slti         a7, gp, -1078
4654:             remu         a4, s5, t0
4655:             ori          a6, a0, -803
4656:             xor          a4, s6, a3
4657:             slti         t5, s2, 26
4658:             mulhu        a2, s5, sp
4659:             add          gp, s6, s4
4660:             bge          t3, a1, 4661f
4661:             slt          a3, t4, a0
4662:             sltiu        s3, s4, -456
4663:             div          ra, t5, a1
4664:             mulhsu       a7, s1, s11
4665:             or           a6, s6, zero
4666:             slti         gp, t3, 807
4667:             srai         s7, t4, 19
4668:             mulhsu       t4, s0, a1
4669:             sub          a2, tp, a6
4670:             csrrw        s7, 0x342, a2
4671:             bltu         s11, s2, 4672f
4672:             csrrs        s4, 0x300, zero
4673:             bltu         s3, t6, 4690f
4674:             bltu         t4, t2, 4694f
4675:             bge          t6, zero, 4693f
4676:             sra          s3, a5, t0
4677:             remu         a1, a7, s6
4678:             sra          s3, s2, s8
4679:             mulh         s9, a3, s9
4680:             addi         t4, a1, 1810
4681:             slti         s5, t1, 1333
4682:             remu         t2, s1, tp
4683:             sll          s1, s1, t2
4684:             sra          t0, t3, gp
4685:             remu         a1, a7, s10
4686:             mulhsu       a1, s9, s9
4687:             blt          s11, a1, 4707f
4688:             mulhsu       s11, a0, t2
4689:             bltu         a1, t6, 4698f
4690:             csrrc        a4, 0x300, zero
4691:             slli         t5, t3, 1
4692:             sub          a1, a6, t6
4693:             sll          a4, s1, a5
4694:             or           a4, s10, a1
4695:             csrrc        zero, 0x304, zero
4696:             csrrc        t0, 0x342, zero
4697:             addi         s1, t5, -1669
4698:             sltu         s8, a3, s4
4699:             nop
4700:             andi         s10, gp, 616
4701:             div          s1, t5, sp
4702:             nop
4703:             csrrw        s8, 0x344, s9
4704:             add          a6, s4, s3
4705:             or           s3, s4, t3
4706:             csrrsi       a7, 0x304, 0
4707:             xor          s2, a1, s10
4708:             divu         s6, sp, a0
4709:             divu         t1, s5, gp
4710:             div          a1, sp, gp
4711:             sltu         s7, t0, a6
4712:             nop
4713:             mulhu        s1, t2, zero
4714:             lui          a1, 1007923
4715:             ori          s3, s2, -991
4716:             sltu         s6, s6, zero
4717:             mulh         a4, t0, s0
4718:             xori         t0, t5, 1433
4719:             addi         zero, a6, 1386
4720:             sll          a3, a2, s7
4721:             csrrci       a5, 0x342, 3
                  li           s2, 0xffffffff #start riscv_int_numeric_corner_stream_19
                  li           s3, 0x0
                  li           s8, 0xffffffff
                  li           s9, 0x0
                  li           s1, 0xd2c391ec
                  li           s7, 0x2fc7905f
                  li           s11, 0x80000000
                  li           a5, 0x0
                  li           t6, 0xffffffff
                  li           s5, 0x0
                  remu         s9, s3, s3
                  addi         s3, a5, 1034
                  mulh         s1, a5, s8
                  auipc        s8, 21780
                  mulhu        s2, s3, s9
                  nop
                  nop
                  mulhsu       s7, a5, s1
                  nop
                  mulhu        s3, s8, s11
                  remu         s5, s1, s8
                  mulhu        a5, s1, s11
                  addi         a5, s9, 1488
                  auipc        s5, 624684
                  nop
                  divu         s3, a5, t6
                  mulhu        s8, s9, s11 #end riscv_int_numeric_corner_stream_19
4722:             sltiu        a4, a7, 421
4723:             csrrwi       s3, 0x343, 5
4724:             addi         a4, t4, 1483
4725:             remu         a2, s3, a7
4726:             add          t3, s9, a3
4727:             xori         a1, s1, 1081
4728:             csrrsi       s2, 0x343, 31
4729:             csrrci       a5, 0x301, 5
4730:             rem          a2, zero, t1
4731:             mul          s2, a3, tp
4732:             and          t5, ra, a4
4733:             blt          t2, a4, 4753f
4734:             mul          s9, t0, zero
4735:             srai         a4, s10, 21
4736:             addi         s9, s11, 1304
4737:             csrrc        t2, 0x301, a1
4738:             bne          t5, s2, 4745f
4739:             sltiu        t3, t0, -808
4740:             srl          a5, zero, s11
4741:             sub          t5, t2, t4
4742:             andi         t1, a1, -1289
4743:             div          s10, gp, t3
4744:             remu         a5, a5, s11
4745:             srl          s5, gp, s3
4746:             bltu         sp, gp, 4748f
4747:             auipc        a5, 515886
4748:             csrrwi       s11, 0x342, 26
4749:             sll          t3, sp, a7
4750:             slli         a5, s9, 14
4751:             mulhu        a5, s11, a0
4752:             sltu         zero, t5, t3
4753:             bne          tp, s2, 4763f
4754:             sltu         gp, a5, t0
4755:             xori         a7, t2, 1390
4756:             add          s1, tp, s3
4757:             mulhu        zero, s7, t2
4758:             beq          s3, ra, 4775f
4759:             srli         s2, a3, 0
4760:             slt          a1, t2, s9
4761:             slt          a3, zero, t2
4762:             csrrsi       t5, 0x342, 16
4763:             div          s8, a1, s5
4764:             csrrc        t3, 0x300, zero
4765:             bgeu         ra, s10, 4778f
4766:             addi         s8, a5, 1652
4767:             sll          t1, a3, t2
4768:             csrrc        s7, 0x344, s7
4769:             bltu         a3, t5, 4771f
4770:             bgeu         sp, a1, 4774f
4771:             or           s8, s0, ra
4772:             auipc        t6, 315076
4773:             mulh         a1, s7, t1
4774:             xor          s2, a0, a7
4775:             bltu         zero, s1, 4784f
4776:             slti         s9, zero, 1979
4777:             nop
4778:             mulhu        a4, t3, zero
4779:             slti         zero, a7, 2020
4780:             and          s5, t0, a1
4781:             sltu         s0, a4, t4
4782:             add          ra, s9, s8
4783:             xori         s9, t1, 836
4784:             sltu         t2, t5, s10
4785:             add          s11, a3, s4
4786:             srl          a6, zero, a1
4787:             mulhsu       s3, ra, s9
4788:             divu         a1, zero, a2
4789:             srli         s2, a1, 22
4790:             bgeu         s3, a1, 4791f
4791:             csrrsi       a5, 0x300, 0
4792:             csrrw        s7, 0x304, s9
4793:             csrrs        s8, 0x344, zero
4794:             add          s3, s11, tp
4795:             xori         t6, sp, 1384
4796:             lui          a7, 500754
4797:             csrrs        a6, 0x344, zero
4798:             sll          t3, zero, s8
4799:             csrrs        t5, 0x343, zero
4800:             remu         s3, sp, tp
4801:             or           s11, a1, a5
4802:             sub          s8, a7, s6
4803:             sltu         t5, s3, a1
4804:             slli         t4, a3, 9
4805:             bge          gp, s4, 4807f
4806:             ori          a7, s7, 994
4807:             div          t1, t2, s5
4808:             sltu         s1, s1, s7
4809:             rem          t3, a7, s2
4810:             ori          s5, s9, 1200
4811:             add          t6, s8, s1
4812:             add          s3, t0, sp
4813:             srai         t1, s0, 1
4814:             rem          s0, a0, a7
4815:             xor          a4, s1, s0
4816:             addi         s2, a6, -2007
4817:             srai         s2, sp, 9
4818:             andi         s11, s11, 235
4819:             csrrw        s7, 0x343, t0
4820:             csrrci       s3, 0x305, 0
4821:             xor          s10, s2, t1
4822:             sub          a3, t2, s10
4823:             ori          s8, t2, -981
4824:             ori          s9, s5, 1552
4825:             blt          t5, t3, 4845f
4826:             bge          s11, a6, 4828f
4827:             srai         s0, s0, 13
4828:             andi         s10, a6, 484
4829:             csrrwi       s3, 0x301, 23
4830:             csrrw        zero, 0x301, a1
4831:             csrrwi       s3, 0x343, 30
4832:             csrrwi       a4, 0x304, 9
4833:             beq          a5, s4, 4849f
4834:             sra          t2, a1, a7
4835:             srli         s10, t3, 22
4836:             bne          t3, a0, 4849f
4837:             sll          s3, s2, t4
4838:             auipc        s8, 114780
4839:             div          s6, a5, s8
4840:             csrrsi       gp, 0x301, 5
4841:             slli         s3, t5, 26
4842:             bge          a6, a4, 4843f
4843:             slt          s0, s11, s4
4844:             srai         s7, s1, 19
4845:             mul          s10, ra, a7
4846:             addi         t5, s10, 469
4847:             bne          t6, a0, 4854f
4848:             csrrc        t6, 0x300, zero
4849:             csrrci       s3, 0x344, 0
4850:             slti         a5, s10, -170
4851:             slti         s9, s10, -2025
4852:             nop
4853:             add          a3, gp, t4
4854:             mulh         ra, a5, a3
4855:             lui          s4, 280859
4856:             and          s7, a7, t1
4857:             or           a7, a4, a6
4858:             bge          a7, s2, 4860f
4859:             bgeu         a2, a6, 4875f
4860:             addi         s10, a3, -1840
4861:             csrrw        t2, 0x343, a3
4862:             srli         t4, s7, 1
4863:             and          s3, tp, s1
4864:             sra          t6, s8, a0
4865:             slli         a2, s10, 9
4866:             bltu         s1, s0, 4886f
4867:             nop
4868:             mulhu        t5, a5, t0
4869:             mul          t6, a0, a4
4870:             bne          a5, t3, 4883f
4871:             mulhu        t4, s1, t6
4872:             csrrsi       a1, 0x304, 0
4873:             sub          a7, a1, sp
4874:             add          a2, t2, s5
4875:             csrrc        s9, 0x304, zero
4876:             sub          s8, tp, t2
4877:             slti         t4, s10, -2
4878:             srai         gp, s11, 28
4879:             rem          t3, a5, s8
4880:             nop
4881:             sub          a6, s7, sp
4882:             bne          a3, s10, 4887f
4883:             andi         s0, a1, -1478
4884:             auipc        zero, 764805
4885:             divu         a2, a7, s0
4886:             mulh         t2, s9, tp
4887:             ori          s3, s1, -1046
4888:             ori          zero, s9, 1727
4889:             remu         s0, a1, s7
4890:             csrrs        gp, 0x305, zero
4891:             sltiu        ra, a5, -1462
4892:             csrrc        ra, 0x343, a2
4893:             sll          a5, s4, s8
4894:             andi         s2, s10, 1759
4895:             xori         s10, s8, -489
4896:             bge          a7, a5, 4914f
4897:             sltu         t6, s8, s2
4898:             sub          s4, a6, s5
4899:             csrrwi       s8, 0x304, 8
4900:             and          t2, gp, a5
4901:             mul          a7, s2, tp
4902:             bne          s0, s3, 4911f
4903:             srai         a7, t0, 27
4904:             xori         t1, ra, -123
4905:             sub          s4, t6, s3
4906:             beq          s10, a6, 4908f
4907:             csrrw        t6, 0x344, s9
4908:             sltiu        s7, a1, -262
4909:             bge          t4, gp, 4929f
4910:             ori          a6, s11, -248
4911:             sra          s3, a0, gp
4912:             slti         s5, s0, 214
4913:             rem          t5, s2, a6
4914:             sltu         s4, t4, a1
4915:             xor          s9, s7, t2
4916:             mul          s9, s3, ra
4917:             sll          a3, s4, tp
4918:             csrrc        s0, 0x304, zero
4919:             mul          s11, sp, t2
4920:             csrrwi       a1, 0x343, 2
4921:             bgeu         a0, t4, 4925f
4922:             nop
4923:             or           gp, s1, t4
4924:             bgeu         a5, tp, 4944f
4925:             csrrs        s6, 0x344, zero
4926:             nop
4927:             beq          s2, ra, 4928f
4928:             bgeu         s6, s2, 4944f
4929:             and          t2, s0, s2
4930:             bgeu         s0, s11, 4948f
4931:             sub          s7, s6, s2
4932:             mul          a1, t2, zero
4933:             mulh         a4, s3, s3
4934:             bge          a7, t4, 4951f
4935:             bne          t1, t2, 4945f
4936:             addi         s11, tp, 1633
4937:             xori         s10, s9, 1552
4938:             csrrsi       t5, 0x344, 0
4939:             addi         a4, a6, -1109
4940:             bne          s3, sp, 4957f
4941:             or           a2, s4, t5
4942:             andi         a4, s0, -87
4943:             bgeu         s6, gp, 4954f
4944:             slli         a3, s5, 13
4945:             auipc        s2, 14686
4946:             slli         t0, s2, 2
4947:             nop
4948:             bne          s11, t1, 4950f
4949:             csrrwi       zero, 0x301, 9
4950:             mulhsu       s9, gp, s11
4951:             csrrs        a5, 0x300, zero
4952:             csrrci       zero, 0x342, 23
4953:             blt          a4, s11, 4955f
4954:             div          s3, t5, a0
4955:             sra          t6, s5, a0
4956:             divu         s2, a5, s9
4957:             xor          s8, s8, s9
4958:             lui          gp, 863460
main_82:          jal          ra, 23f
0:                jal          ra, 16f
1:                jal          ra, 17f
2:                jal          ra, 19f
3:                jal          ra, 4f
4:                jal          s8, 13f
5:                jal          ra, 11f
6:                jal          ra, 20f
7:                jal          ra, 21f
8:                jal          t0, 15f
9:                jal          ra, 24f
10:               jal          t1, 12f
11:               jal          ra, 18f
12:               jal          gp, 22f
13:               jal          ra, 14f
14:               jal          ra, 2b
15:               jal          ra, 0b
16:               jal          ra, 5b
17:               jal          ra, 3b
18:               jal          t6, 9b
19:               jal          s11, 6b
20:               jal          a2, 10b
21:               jal          t1, 1b
22:               jal          t1, 25f
23:               jal          a1, 8b
24:               jal          t1, 7b
25:               xor          ra, zero, zero
4959:             mulhu        a7, t0, s11
4960:             auipc        a3, 626936
4961:             sltu         s7, s0, t4
4962:             divu         s8, a4, s2
4963:             sltiu        a4, s5, -961
4964:             csrrsi       zero, 0x344, 1
4965:             lui          a6, 332542
4966:             sll          a1, zero, a6
4967:             xor          s5, sp, t4
4968:             slti         s2, t3, -1259
4969:             bgeu         gp, t3, 4978f
4970:             srl          a1, t6, ra
4971:             ori          s10, a0, 234
4972:             nop
4973:             sll          ra, t6, s7
4974:             ori          t4, a3, 171
4975:             sltiu        gp, t2, 1557
4976:             sra          a2, t0, a2
4977:             or           ra, s8, t4
4978:             bgeu         a5, a6, 4998f
4979:             xor          t3, s11, a4
4980:             csrrci       t2, 0x344, 0
4981:             slti         a7, s8, -1738
4982:             csrrsi       a1, 0x301, 0
4983:             add          s2, s1, s0
4984:             sltu         s7, a4, t2
4985:             auipc        s1, 460637
4986:             mulh         t0, sp, a1
4987:             sltu         a4, t4, t3
4988:             div          a3, t2, a4
4989:             rem          s5, a3, a0
4990:             csrrw        s1, 0x301, s7
4991:             bne          a0, gp, 4992f
4992:             csrrw        a2, 0x344, a0
4993:             mulh         t5, a6, t0
4994:             sra          s10, a0, t4
4995:             bltu         a7, t4, 5004f
4996:             beq          s2, a1, 5014f
4997:             auipc        gp, 551318
4998:             srai         zero, a1, 28
4999:             csrrs        s1, 0x342, zero
5000:             slli         a1, a5, 10
5001:             sltiu        s2, s1, -1683
5002:             srai         ra, s3, 28
5003:             andi         s4, ra, 197
5004:             add          t3, t4, zero
5005:             csrrwi       a5, 0x344, 22
5006:             csrrwi       t5, 0x343, 1
5007:             mulhsu       s5, t4, t2
5008:             mulhsu       s10, ra, s3
5009:             divu         a4, s3, a3
5010:             mulh         zero, s7, gp
5011:             beq          t2, s7, 5024f
5012:             sra          t4, t1, gp
5013:             mul          ra, s4, a0
5014:             nop
5015:             mulhsu       s6, s5, a7
5016:             bne          s8, sp, 5025f
5017:             csrrsi       t2, 0x301, 26
5018:             xori         t2, t4, -306
5019:             and          gp, s5, a4
5020:             div          ra, gp, a2
5021:             remu         t2, s4, t5
5022:             sub          a2, ra, a4
5023:             sltu         s2, gp, t0
5024:             sltiu        ra, s2, -743
5025:             ori          s5, s7, -1615
5026:             and          a6, s4, s7
5027:             xor          a7, s11, a0
5028:             mul          a6, gp, t6
5029:             rem          a2, s10, s1
5030:             csrrsi       a7, 0x300, 0
5031:             bgeu         a6, t4, 5047f
5032:             mulhsu       s2, t5, t3
5033:             and          a4, t1, gp
5034:             addi         s8, a5, -1560
5035:             remu         t1, a6, t2
5036:             slt          a5, sp, s1
5037:             csrrsi       s3, 0x305, 0
5038:             csrrci       t0, 0x300, 0
5039:             sub          t5, s9, a0
5040:             bgeu         a3, ra, 5056f
5041:             srl          s7, t5, t5
5042:             sub          a2, a3, s11
5043:             slt          a1, s9, a5
5044:             beq          zero, a0, 5046f
5045:             srai         a2, s2, 3
5046:             mulhu        s2, s2, s0
5047:             sltiu        a7, s0, -1414
5048:             srl          a2, s9, t0
5049:             srl          s4, s5, s0
5050:             and          s0, ra, s8
5051:             divu         gp, t5, t1
5052:             and          zero, t3, a7
5053:             mulh         s0, t3, t5
5054:             sltu         a5, s10, a6
5055:             slti         s8, t4, -1837
5056:             bge          s2, t0, 5063f
5057:             remu         a2, s10, a6
5058:             mul          s10, s8, a4
5059:             sltiu        a3, t3, -639
5060:             csrrsi       t4, 0x344, 0
5061:             ori          s7, a1, -1791
5062:             slt          a7, a2, a7
5063:             bltu         s4, t6, 5064f
5064:             csrrs        s1, 0x304, zero
5065:             sll          t4, s3, a3
5066:             sra          a5, s0, s8
5067:             mulhsu       s7, a6, s6
5068:             bltu         t1, s4, 5079f
5069:             lui          t6, 773072
5070:             slti         s7, s10, 314
5071:             addi         s2, s10, 1638
5072:             div          gp, s1, sp
5073:             csrrsi       s2, 0x343, 20
5074:             ori          t6, a6, -372
5075:             srl          zero, s5, tp
5076:             sltu         s3, s1, tp
5077:             sltu         t2, s5, t5
5078:             rem          s4, s4, s9
5079:             sll          a2, s11, s2
5080:             slt          s9, a6, a1
5081:             bltu         gp, a1, 5099f
5082:             csrrs        a3, 0x342, zero
5083:             slt          s9, s9, t1
5084:             add          a4, a0, s2
5085:             sra          t1, s0, s4
5086:             slt          a7, sp, a7
5087:             slli         t0, t1, 16
5088:             ori          s11, t5, -789
5089:             srli         gp, s0, 25
5090:             sll          s4, t4, gp
5091:             srai         s0, a5, 26
5092:             slti         a3, t5, -457
5093:             srli         s10, gp, 6
5094:             mulhu        s2, a0, a5
5095:             xori         s3, a4, 708
5096:             csrrc        s4, 0x343, s3
5097:             or           t0, s7, a4
5098:             remu         s9, tp, zero
5099:             mulhsu       t2, s3, t5
5100:             xor          ra, a7, tp
5101:             ori          t6, a1, -769
5102:             div          s1, t5, a5
5103:             sll          t6, t5, a7
5104:             mul          s0, s10, a4
5105:             remu         s8, a5, a3
5106:             csrrci       a1, 0x300, 0
5107:             sltu         ra, s4, s10
5108:             bge          t4, s7, 5128f
5109:             bgeu         s0, a5, 5111f
5110:             mul          s6, ra, s0
5111:             mulh         t3, t5, a5
5112:             xor          gp, s11, s0
5113:             sra          a3, s5, zero
5114:             mulh         a6, a7, a5
5115:             csrrs        s9, 0x342, s10
5116:             or           t2, s11, a5
5117:             add          t3, a0, t0
5118:             slti         t5, t1, -586
5119:             xori         s6, s4, -1520
5120:             srl          a7, a2, a3
5121:             bge          s1, s1, 5125f
5122:             bltu         t4, a4, 5140f
5123:             andi         gp, a7, 1082
5124:             sub          s2, s1, zero
5125:             csrrs        zero, 0x342, a6
5126:             sltiu        s3, sp, 417
5127:             andi         s5, a0, 409
5128:             mul          s1, a7, s6
5129:             add          t5, s11, s11
5130:             mulhu        a3, s3, a1
5131:             slt          t2, s11, t6
5132:             csrrw        s1, 0x344, zero
5133:             mulhu        t1, a1, s8
5134:             mulh         a5, s2, a6
5135:             sltiu        t2, a2, 933
5136:             slti         s0, s4, 801
5137:             nop
5138:             bne          a4, s7, 5147f
5139:             sub          s10, a3, t6
5140:             xori         a5, a1, -242
5141:             slti         s1, t6, 316
5142:             bge          sp, s10, 5144f
5143:             srl          t3, a1, t2
5144:             csrrci       ra, 0x342, 0
5145:             csrrs        s5, 0x342, a1
5146:             beq          t0, zero, 5166f
5147:             bgeu         s6, t2, 5156f
5148:             divu         s10, t0, zero
5149:             sltu         s2, s11, s7
5150:             srli         a5, t1, 10
5151:             divu         a5, sp, s0
5152:             rem          t5, t6, sp
5153:             csrrs        s11, 0x301, t0
5154:             bge          s2, a2, 5156f
5155:             lui          zero, 497750
5156:             csrrs        s10, 0x300, zero
5157:             sra          a5, gp, t6
5158:             csrrsi       s11, 0x300, 0
                  la           s4, region_0+2024 #start load_store_instr_stream_0
                  la           t6, region_0+1869 #start load_store_instr_stream_1
                  lh           s10, 1465(t6)
                  lw           s7, -1417(t6)
                  lbu          s11, 880(t6)
                  lbu          gp, -1528(t6)
                  lb           s5, -156(s4)
                  lb           s5, -86(s4)
                  sh           s4, 671(t6)
                  lb           t1, -1394(t6)
                  lb           s6, 1798(t6) #end load_store_instr_stream_1
                  lh           s3, 1436(s4)
                  lhu          t3, -442(s4)
                  lbu          a1, 1659(s4) #end load_store_instr_stream_0
5159:             bge          s7, a7, 5161f
5160:             csrrsi       s11, 0x304, 0
5161:             lui          s6, 345012
5162:             add          s7, s6, a2
5163:             csrrsi       t5, 0x344, 0
5164:             bgeu         s5, s1, 5184f
5165:             slti         a2, s3, -17
5166:             and          s2, s1, a0
5167:             srl          s1, t6, a3
5168:             xor          a3, a7, s8
5169:             addi         ra, s3, -1988
5170:             sltu         a7, a0, s3
5171:             mul          s3, s3, a4
5172:             auipc        t5, 41997
5173:             sub          s6, s1, gp
5174:             csrrci       s11, 0x300, 0
5175:             slt          t3, a3, t1
5176:             csrrc        s7, 0x304, zero
5177:             mulhsu       zero, s7, s2
5178:             xor          s2, a0, a5
5179:             slli         a1, s2, 16
5180:             and          t2, a6, a7
5181:             xor          t2, s6, s11
5182:             sub          s8, s3, t2
5183:             bne          a4, s7, 5200f
5184:             addi         a7, s3, -534
5185:             slti         t2, s10, -939
5186:             csrrc        a5, 0x342, s10
5187:             srai         a3, a6, 30
5188:             mulhu        t3, gp, zero
5189:             remu         s2, s2, s3
5190:             div          t3, zero, s7
5191:             slti         t6, sp, -1182
5192:             csrrs        s2, 0x300, zero
5193:             xor          gp, a4, a1
5194:             div          s4, t4, s4
5195:             add          zero, sp, zero
5196:             add          t0, t6, sp
5197:             csrrc        s8, 0x300, zero
5198:             and          s5, a4, s1
5199:             lui          s11, 283079
5200:             sltu         s5, t3, a6
5201:             mulhu        s7, zero, s8
5202:             ori          zero, a1, 507
5203:             andi         t3, s5, 922
5204:             sltu         a5, s5, a4
5205:             blt          s9, s6, 5223f
5206:             rem          s4, t2, s5
5207:             remu         a3, a2, a2
5208:             sll          a3, ra, a6
5209:             csrrs        t3, 0x300, zero
5210:             csrrwi       s11, 0x301, 16
5211:             sub          t3, t4, ra
5212:             mulhsu       a2, t2, a3
5213:             mul          ra, a2, t2
5214:             div          s8, tp, t6
5215:             sll          s6, zero, s3
5216:             csrrsi       gp, 0x344, 0
5217:             slti         s7, t5, -523
5218:             beq          t2, t2, 5238f
5219:             srai         s7, tp, 31
5220:             divu         t1, t6, t6
5221:             xori         a5, s9, 1704
5222:             bne          s4, a0, 5235f
5223:             sltiu        zero, tp, 1748
5224:             sltiu        s4, s2, 1684
5225:             csrrs        s7, 0x304, s7
5226:             xor          a4, a0, t5
5227:             bge          t6, t5, 5237f
5228:             ori          s9, s9, -238
5229:             blt          sp, a3, 5245f
5230:             slt          s10, s1, t6
5231:             sll          s2, s4, ra
5232:             nop
5233:             sll          s4, s4, ra
5234:             div          t0, s11, s0
5235:             csrrci       s0, 0x305, 0
5236:             nop
5237:             and          s1, t5, s4
5238:             sub          s11, s11, zero
5239:             mul          t6, s9, t4
5240:             sra          a1, a0, s5
5241:             addi         s11, a5, -1419
5242:             srai         a1, t2, 9
5243:             csrrc        a6, 0x304, a0
5244:             mulh         a2, s0, a0
5245:             srl          a5, s2, s8
5246:             sll          s4, a0, s9
5247:             div          s3, a2, s1
5248:             sub          s4, ra, t4
5249:             srai         t0, t6, 26
5250:             srl          t2, t5, sp
5251:             csrrw        a5, 0x301, a2
5252:             slti         s7, s9, 904
5253:             divu         t2, a5, s1
5254:             bltu         ra, a0, 5271f
5255:             csrrwi       t4, 0x342, 29
5256:             sub          s3, s6, s1
5257:             slti         t0, a3, -1226
5258:             bgeu         s5, a5, 5259f
5259:             srl          a7, a1, zero
5260:             lui          t1, 711311
5261:             lui          t6, 409501
5262:             bltu         sp, t2, 5263f
5263:             sra          s0, s2, s3
5264:             srai         t0, a7, 0
5265:             bne          t5, s10, 5270f
5266:             beq          a3, t6, 5275f
5267:             csrrw        a1, 0x304, a0
5268:             csrrwi       a4, 0x304, 11
5269:             csrrsi       t0, 0x301, 0
5270:             sltiu        t0, t6, -699
5271:             srli         s4, tp, 23
5272:             div          a5, tp, a0
5273:             auipc        t2, 865295
5274:             csrrwi       s11, 0x343, 25
5275:             bne          a6, s9, 5295f
5276:             blt          t5, a6, 5294f
5277:             xori         gp, gp, 67
5278:             rem          zero, s9, a0
5279:             and          s2, t6, s4
5280:             slt          ra, s6, s7
5281:             sltiu        s9, t2, 649
5282:             xor          s7, t6, s1
5283:             slt          a3, s0, s9
5284:             nop
5285:             csrrci       t6, 0x344, 0
5286:             and          a4, tp, tp
5287:             slt          s0, t5, s5
5288:             add          ra, s9, s1
5289:             csrrs        s11, 0x304, zero
5290:             nop
5291:             xori         s10, t4, 156
5292:             auipc        s0, 678016
5293:             csrrwi       a7, 0x342, 24
5294:             srai         s10, t5, 18
5295:             csrrc        s6, 0x344, zero
5296:             lui          a1, 1023283
5297:             srli         ra, t4, 29
5298:             nop
5299:             blt          a7, gp, 5308f
5300:             ori          s6, a1, 1998
5301:             mulh         a4, s3, a1
5302:             mulh         s10, ra, ra
5303:             xori         s2, sp, 1546
5304:             blt          a0, s4, 5320f
5305:             slti         s10, a0, 1576
5306:             mulh         zero, a3, s9
5307:             sra          t3, tp, s6
5308:             ori          s0, s1, 1332
5309:             mulhsu       zero, t0, s11
5310:             xori         t6, ra, -799
5311:             bne          a1, t2, 5324f
5312:             csrrsi       a4, 0x305, 0
5313:             srli         zero, t5, 9
5314:             csrrwi       t3, 0x344, 1
5315:             nop
5316:             addi         s8, sp, 576
5317:             rem          s11, t6, s11
5318:             sltu         t4, s4, s0
5319:             divu         zero, s8, t3
5320:             srl          s6, a2, a3
5321:             xori         t5, ra, -1468
5322:             nop
5323:             slti         t6, zero, 354
5324:             csrrci       t0, 0x344, 0
5325:             sltiu        s6, t4, 851
5326:             csrrci       t2, 0x300, 0
5327:             auipc        s1, 146579
5328:             slt          s10, s9, s11
5329:             beq          s10, t3, 5347f
5330:             add          s2, s0, t2
5331:             blt          t3, s4, 5333f
5332:             auipc        t2, 465516
5333:             bltu         tp, gp, 5334f
5334:             srai         gp, a6, 31
5335:             xori         s11, t2, 263
5336:             bne          s1, a7, 5356f
5337:             add          t5, t6, gp
5338:             bge          s5, sp, 5354f
5339:             csrrw        ra, 0x344, a7
5340:             srl          s2, t0, s10
5341:             csrrc        gp, 0x343, t2
5342:             bge          s6, s7, 5352f
5343:             nop
5344:             sra          s9, a0, t6
5345:             sub          a4, t5, zero
5346:             blt          s7, gp, 5348f
5347:             sub          gp, ra, s3
5348:             mulhsu       s6, s3, s6
5349:             mul          t1, tp, s3
5350:             sub          t4, s2, zero
5351:             sltiu        s0, t6, -776
5352:             or           a2, s11, s3
5353:             lui          s9, 466536
5354:             remu         zero, tp, s7
5355:             mulhu        a5, s4, t5
5356:             div          a5, a6, t0
5357:             srl          s2, s0, gp
5358:             rem          a2, t4, s6
5359:             csrrwi       a3, 0x344, 18
5360:             xori         zero, t0, -1798
5361:             srli         s7, t4, 19
5362:             lui          a5, 83068
5363:             xori         t4, s2, -1042
5364:             sltiu        s7, s7, 698
5365:             xor          a1, s3, s1
5366:             or           s9, t3, sp
5367:             srl          a7, a6, s6
5368:             sltu         s2, gp, gp
5369:             nop
5370:             bne          ra, s3, 5372f
5371:             csrrwi       a7, 0x343, 8
5372:             mul          t6, t0, s1
5373:             mulhu        s7, a4, s5
5374:             mulhu        t2, s8, a1
5375:             sltiu        s2, s2, 2021
5376:             slli         a3, a5, 29
5377:             srl          s4, t2, a7
5378:             mulh         s10, s6, t6
5379:             divu         a7, s6, s11
5380:             csrrs        t1, 0x344, a2
5381:             mulhu        s5, t6, tp
5382:             sltiu        s10, t1, -113
5383:             bge          s8, a2, 5399f
5384:             ori          s6, s0, -958
5385:             sltu         ra, tp, t5
5386:             div          gp, t3, ra
5387:             mulhu        t1, s11, t0
5388:             slt          s1, a1, t0
5389:             srl          a6, gp, t4
5390:             bge          a7, t1, 5397f
5391:             csrrci       t5, 0x343, 0
5392:             sltiu        s0, s1, 1468
5393:             slti         t1, s8, 1777
5394:             csrrci       s9, 0x343, 0
5395:             mulhu        s6, a2, s11
5396:             sltu         t5, tp, a1
5397:             csrrsi       s5, 0x342, 0
5398:             csrrci       t3, 0x301, 0
5399:             csrrs        ra, 0x342, s10
5400:             bge          s7, a6, 5418f
5401:             sll          a4, gp, a1
5402:             div          s2, gp, t6
5403:             slti         a6, s10, 1913
5404:             auipc        t1, 38502
5405:             sub          gp, t4, a5
5406:             sub          a3, t4, s7
5407:             csrrc        gp, 0x300, zero
5408:             sra          s3, a0, s2
5409:             mulhsu       s8, s0, s0
5410:             mulh         s3, a7, a3
5411:             sra          a3, t0, s0
5412:             mulhu        s7, a0, tp
5413:             srai         t4, s9, 22
5414:             slt          t2, a6, s3
5415:             slt          s7, t1, ra
5416:             rem          a2, t0, t2
5417:             xor          s0, s4, a5
5418:             srai         t4, gp, 10
5419:             sub          a3, a1, a4
5420:             mulh         a2, a3, ra
5421:             mulhu        s2, s7, ra
5422:             blt          t4, a6, 5427f
5423:             sltu         s8, s8, tp
5424:             srai         s8, a5, 21
5425:             bgeu         t0, s10, 5427f
5426:             and          a1, a4, s3
5427:             xori         s6, sp, -1821
5428:             sra          s7, s2, s9
5429:             sra          s8, s1, zero
5430:             sll          a4, t1, t2
5431:             srli         t6, a3, 18
5432:             or           t0, a3, s5
5433:             csrrs        a2, 0x342, ra
5434:             sltu         s11, ra, t6
5435:             bne          t2, s5, 5436f
5436:             csrrsi       s4, 0x343, 0
5437:             div          zero, s1, t2
5438:             sll          s8, a2, s6
5439:             csrrw        zero, 0x342, s6
5440:             nop
5441:             beq          sp, s6, 5445f
5442:             srli         a4, t4, 8
5443:             mulh         a7, a5, s10
5444:             csrrw        s5, 0x344, t4
5445:             mulhsu       s10, t2, s9
5446:             bge          s10, s3, 5459f
5447:             slli         a1, zero, 25
5448:             addi         t2, a4, -1701
5449:             mulhsu       a7, s9, tp
5450:             csrrs        s6, 0x300, zero
5451:             mul          s2, t3, a5
5452:             auipc        gp, 538187
                  li           s0, 0x80000000 #start riscv_int_numeric_corner_stream_16
                  li           t6, 0x80000000
                  li           s1, 0xfca7e6bb
                  li           a4, 0xffffffff
                  li           s3, 0xffffffff
                  li           t1, 0xffffffff
                  li           t4, 0x4eec9540
                  li           ra, 0x80000000
                  li           s5, 0x60f7e12a
                  li           s6, 0xffffffff
                  add          t4, s3, t6
                  rem          t4, s0, s6
                  mulh         s5, s5, t6
                  mulhu        t4, t1, a4
                  div          ra, s6, s0
                  divu         t4, t6, ra
                  addi         ra, s1, -886
                  sub          s0, t1, s5
                  rem          s6, s5, s3
                  div          ra, t1, t4
                  div          t6, t6, t1
                  mulhsu       t6, t1, a4
                  divu         s6, s6, t6
                  add          t4, ra, s5
                  sub          ra, s6, s5
                  addi         a4, t4, -617
                  mulh         t6, s3, a4
                  mul          t4, ra, t4
                  auipc        s6, 130039
                  divu         ra, s3, t6
                  mulhu        s0, t6, s6
                  remu         a4, s0, t1
                  divu         a4, t1, t4 #end riscv_int_numeric_corner_stream_16
5453:             mulh         t3, a5, ra
5454:             and          s10, gp, s7
5455:             mul          a6, t5, zero
5456:             bne          sp, s8, 5467f
5457:             rem          s2, a5, gp
5458:             or           s6, s6, a3
5459:             or           s8, gp, t3
5460:             srli         a1, t6, 26
5461:             slt          s1, s6, t0
5462:             sll          a4, s10, s9
5463:             csrrw        gp, 0x301, a0
5464:             bgeu         a7, t5, 5484f
5465:             sltiu        a3, s2, -1164
5466:             csrrc        s7, 0x343, s8
5467:             mulh         a6, a1, a6
5468:             remu         s4, tp, a7
5469:             csrrs        s10, 0x300, zero
5470:             beq          s2, t1, 5487f
5471:             mulhsu       ra, a5, t1
5472:             bne          t3, gp, 5492f
5473:             or           s4, a1, t3
5474:             srai         s7, s3, 16
5475:             sll          s6, s6, s1
5476:             and          t1, a4, t3
5477:             andi         s1, t6, -1527
5478:             lui          a2, 830663
5479:             bltu         a5, s5, 5480f
5480:             add          s11, s11, t3
5481:             slti         ra, s7, 260
5482:             auipc        s4, 531893
5483:             nop
5484:             mul          s11, t1, s0
5485:             mulh         s6, ra, t0
5486:             sltu         s3, a4, s9
5487:             csrrc        a4, 0x342, s10
5488:             remu         t1, a7, s7
5489:             sltu         t1, s2, a1
5490:             rem          a3, a3, s0
5491:             sll          s4, a0, t4
5492:             add          a5, s5, a0
5493:             or           a1, s5, s2
5494:             mulhu        t4, a2, s5
5495:             mulhu        s10, a0, a6
5496:             mul          s5, a0, a1
5497:             lui          a6, 452761
5498:             sra          a1, s11, s3
5499:             sra          a7, t5, tp
5500:             mulhsu       a4, s6, t6
5501:             xori         a7, t2, -108
5502:             addi         s0, s3, -556
5503:             csrrc        t5, 0x342, zero
5504:             beq          ra, a0, 5513f
5505:             sltiu        a6, s6, 950
5506:             csrrs        s7, 0x343, s1
5507:             slti         a1, t2, -290
5508:             and          s10, s9, sp
5509:             mulhsu       s10, a1, a7
5510:             csrrsi       a4, 0x301, 23
5511:             csrrc        t4, 0x304, zero
5512:             addi         s8, gp, -904
5513:             csrrc        a2, 0x305, zero
5514:             add          gp, a0, s4
5515:             sub          s3, a7, a1
5516:             addi         s10, t5, 635
5517:             sub          s3, s2, a1
5518:             sltiu        ra, s3, 1362
5519:             srl          s2, t2, tp
5520:             add          t1, a1, s3
5521:             mulhu        a7, t5, a7
5522:             add          s3, s0, t4
5523:             remu         s5, s8, s1
5524:             sltiu        s5, a4, -1873
5525:             andi         s7, t1, 5
5526:             mulhsu       a3, s6, t6
5527:             mulhsu       s6, a4, zero
5528:             csrrs        gp, 0x301, zero
5529:             xor          t2, a6, a4
5530:             ori          s3, s4, 1250
5531:             slli         t4, s8, 17
5532:             xori         a2, a0, 1537
5533:             csrrci       s10, 0x304, 20
5534:             xor          a1, t5, s6
5535:             csrrci       t5, 0x304, 25
5536:             srli         s6, t5, 13
5537:             csrrsi       t4, 0x344, 0
5538:             sub          t2, tp, a7
5539:             and          t4, s4, s3
5540:             sra          gp, a4, tp
5541:             add          t6, a0, t3
5542:             blt          a6, a7, 5559f
5543:             slt          s6, s7, a7
5544:             bgeu         s3, a3, 5546f
5545:             and          s4, tp, s11
5546:             bne          t4, t4, 5563f
5547:             slti         s2, a5, -210
5548:             slt          a1, sp, s4
5549:             lui          s5, 53144
5550:             csrrw        s5, 0x344, s10
5551:             div          a7, s10, a3
5552:             srl          a3, tp, s10
5553:             xor          ra, s11, s8
5554:             and          s4, s7, s1
5555:             slt          s0, s8, t4
5556:             auipc        t5, 842364
5557:             nop
5558:             csrrw        s9, 0x301, s0
5559:             sra          s8, s0, t1
5560:             addi         s10, a5, -2001
5561:             add          s2, a5, a6
5562:             div          s9, a1, s8
5563:             bgeu         s1, a7, 5583f
5564:             csrrw        s0, 0x342, s6
5565:             andi         a3, s10, -1776
5566:             slli         t0, s2, 5
5567:             bgeu         a5, t3, 5572f
5568:             addi         a7, t5, 1051
5569:             mul          t1, tp, gp
                  li           ra, 0x0 #start riscv_int_numeric_corner_stream_27
                  li           a3, 0x66f2c72f
                  li           s4, 0x3acb8ceb
                  li           t3, 0x0
                  li           s5, 0x80000000
                  li           t6, 0x0
                  li           gp, 0xffffffff
                  li           a7, 0x80000000
                  li           a6, 0x80000000
                  li           t4, 0x0
                  div          ra, t3, gp
                  addi         t4, a6, -377
                  rem          a3, s4, a6
                  mulh         a6, s4, a7
                  mulhu        t6, t3, t3
                  mulh         a3, a7, ra
                  sub          t4, t4, t6
                  mulhsu       a7, gp, s4
                  add          a6, s4, ra
                  mul          a7, a6, t3
                  auipc        gp, 437622
                  mulhsu       a3, s4, s5
                  rem          ra, a3, a7
                  div          a3, a6, a6
                  auipc        ra, 838443
                  addi         a3, t4, 1658
                  addi         a7, a6, 424 #end riscv_int_numeric_corner_stream_27
5570:             beq          s0, a1, 5572f
5571:             bgeu         zero, s3, 5582f
5572:             mul          zero, a3, a2
5573:             lui          t6, 281285
5574:             divu         a4, t4, a7
5575:             csrrw        s10, 0x301, a5
5576:             csrrs        a6, 0x301, zero
5577:             xori         t1, t6, 504
5578:             rem          s3, s8, sp
5579:             mul          a6, s7, s8
5580:             mul          s4, a1, s7
5581:             csrrsi       a3, 0x343, 0
5582:             csrrc        s6, 0x344, zero
5583:             sub          gp, a0, s11
5584:             bge          a3, a5, 5597f
5585:             add          a5, s0, a4
5586:             csrrs        t6, 0x301, t4
5587:             bltu         zero, s8, 5603f
5588:             csrrc        ra, 0x305, zero
5589:             blt          s6, s5, 5607f
5590:             remu         gp, t1, s2
5591:             sub          t6, s11, a5
5592:             srai         a4, s2, 1
5593:             or           s3, s6, s7
5594:             beq          a2, gp, 5595f
5595:             csrrsi       s2, 0x301, 18
5596:             sltu         zero, a4, gp
5597:             bltu         s8, s2, 5615f
5598:             andi         a6, zero, -144
5599:             beq          t6, t3, 5617f
5600:             csrrwi       t4, 0x344, 2
5601:             bltu         s5, s6, 5621f
5602:             xori         t3, s2, -2031
5603:             slt          s6, zero, a5
5604:             mulhu        t4, t5, a3
5605:             slt          s10, sp, s7
5606:             rem          t4, t2, t0
5607:             mulh         s5, t5, t5
5608:             remu         zero, s2, s4
5609:             srli         s6, s4, 17
5610:             xori         s0, s8, -1338
5611:             nop
5612:             mul          s5, a7, s0
5613:             xor          t6, a7, tp
5614:             beq          zero, ra, 5616f
5615:             bne          s9, gp, 5624f
5616:             bge          a2, gp, 5632f
5617:             bge          t2, s3, 5619f
5618:             csrrci       s0, 0x301, 0
5619:             mul          s4, t6, a4
5620:             or           a4, s7, tp
5621:             blt          t4, tp, 5623f
5622:             ori          s4, sp, 967
5623:             slli         s9, s0, 12
5624:             lui          t2, 867626
5625:             lui          t4, 157683
5626:             mul          s8, t3, s5
5627:             csrrsi       ra, 0x343, 0
5628:             divu         gp, t5, s8
5629:             ori          t4, t2, -1121
5630:             mulh         a6, a0, s6
5631:             andi         s4, t2, 1400
5632:             srli         t4, t4, 27
5633:             beq          ra, s6, 5635f
5634:             slti         s7, s6, 133
5635:             bltu         a2, s3, 5648f
5636:             mul          s2, sp, s8
5637:             srli         a2, a4, 28
5638:             sltiu        s11, s1, -1235
5639:             srl          a1, t6, s5
5640:             bltu         s2, t6, 5650f
5641:             divu         s7, t2, a5
5642:             beq          a1, t4, 5662f
5643:             and          s11, s3, zero
5644:             mul          s1, a7, s7
5645:             blt          a4, s11, 5665f
5646:             srl          t1, a7, a0
5647:             and          s4, zero, a7
5648:             or           a5, a2, s4
5649:             slt          s6, t2, s4
5650:             slti         t6, a6, 86
5651:             addi         t4, s6, 247
5652:             sltiu        s3, zero, -1552
5653:             bgeu         a3, s1, 5670f
5654:             srl          t4, s8, ra
5655:             ori          s8, s2, -1467
5656:             remu         a3, t1, s3
5657:             mulh         a6, t6, a0
5658:             beq          t4, t2, 5662f
5659:             csrrs        s6, 0x344, zero
5660:             bgeu         s5, a0, 5661f
5661:             mulh         t3, s10, ra
5662:             bne          t4, t3, 5669f
5663:             and          s6, s4, a2
5664:             blt          ra, a7, 5673f
5665:             beq          t1, a4, 5666f
5666:             and          s7, s4, s10
5667:             csrrs        t5, 0x342, zero
5668:             csrrs        s7, 0x304, s1
5669:             beq          s11, t4, 5678f
5670:             xori         s5, t4, 259
5671:             auipc        s9, 244016
5672:             csrrc        zero, 0x343, zero
5673:             add          a4, a6, a0
5674:             remu         s6, a1, s9
5675:             bltu         a6, s7, 5691f
5676:             mulhsu       s0, s0, a7
5677:             div          ra, s7, a5
5678:             xori         t4, a3, 1246
5679:             mulh         t6, s6, gp
5680:             bne          a7, s5, 5681f
5681:             xor          a6, tp, t5
5682:             csrrci       s1, 0x304, 0
5683:             csrrsi       s5, 0x304, 0
5684:             slti         ra, s1, -1444
5685:             csrrci       t5, 0x304, 25
5686:             andi         s5, a5, 929
5687:             bge          t5, a1, 5705f
5688:             csrrsi       t1, 0x300, 0
5689:             srli         a3, a7, 15
5690:             nop
5691:             auipc        s11, 576818
5692:             andi         a3, t2, -1108
5693:             or           a1, s8, gp
5694:             div          t2, s1, s7
5695:             srli         a3, s2, 19
5696:             sltu         t3, tp, s4
5697:             addi         s6, a7, 1084
5698:             sltiu        t1, t6, 844
5699:             nop
5700:             slli         a5, tp, 13
5701:             bne          s1, s3, 5719f
5702:             sub          t6, s7, s10
5703:             beq          a7, tp, 5723f
5704:             csrrs        s0, 0x301, a1
5705:             sll          t4, t6, s2
5706:             mulhu        t0, s1, t1
5707:             nop
5708:             rem          t1, a6, gp
5709:             bne          t1, s5, 5710f
5710:             srli         t0, gp, 10
5711:             slt          t3, ra, s10
5712:             andi         s6, sp, 1831
5713:             andi         a7, s6, 1404
5714:             addi         t4, s8, -1924
5715:             xor          s9, s8, s9
5716:             remu         t5, t1, a1
5717:             sll          a2, s9, tp
5718:             and          s2, s10, s3
5719:             mul          a5, t4, ra
5720:             csrrc        s7, 0x343, a5
5721:             slli         s3, a1, 30
5722:             sll          a3, a5, a1
5723:             blt          a6, s5, 5736f
5724:             bgeu         s0, s7, 5737f
5725:             csrrsi       s9, 0x343, 17
5726:             sll          a6, t2, sp
5727:             sltu         s9, a2, ra
5728:             mulhsu       t3, ra, a1
5729:             srai         s0, s9, 7
5730:             or           s7, a4, s7
5731:             srli         a5, s3, 0
5732:             add          a7, a4, s11
5733:             nop
5734:             xori         s6, t3, -311
5735:             xor          a2, ra, ra
5736:             mulhu        gp, t2, gp
5737:             srl          a3, s0, a4
5738:             nop
5739:             lui          t3, 731282
5740:             srl          a7, s6, a5
5741:             andi         t0, s4, 388
5742:             xori         s5, s6, 875
5743:             mulh         gp, t2, t1
5744:             nop
5745:             csrrsi       a3, 0x343, 0
5746:             mul          s11, t4, s9
5747:             addi         s0, ra, 1025
5748:             andi         a4, tp, 1131
5749:             csrrs        s11, 0x344, s11
5750:             slti         t3, a1, 1324
5751:             csrrwi       ra, 0x304, 18
5752:             mulhu        s5, s7, gp
5753:             sltu         a2, t0, zero
5754:             csrrs        t6, 0x301, zero
5755:             nop
5756:             slt          t3, s0, a7
5757:             srai         a1, a1, 6
5758:             mulhu        t0, t0, t1
5759:             auipc        t0, 515478
5760:             div          s6, t5, t0
5761:             rem          t0, s6, tp
5762:             slti         s9, a6, -688
5763:             lui          s4, 745834
5764:             div          a6, s3, a2
5765:             nop
5766:             andi         zero, s4, -560
5767:             sll          s7, t6, t2
5768:             csrrci       a6, 0x304, 0
5769:             mul          s7, s1, t5
5770:             mulhu        s8, a4, a1
5771:             srl          s0, s4, zero
5772:             andi         s2, s2, -1172
5773:             csrrwi       a1, 0x304, 0
5774:             nop
5775:             srl          s11, s11, s2
5776:             xor          a3, t5, t2
5777:             mulh         s8, ra, a5
5778:             and          s6, zero, a6
5779:             csrrw        s1, 0x343, t4
5780:             xori         t4, t4, 396
5781:             xori         a1, t4, 943
5782:             sub          t4, s8, s5
5783:             sltu         a3, s6, s3
5784:             andi         s3, t1, -95
5785:             xori         a7, a6, 211
5786:             csrrc        s4, 0x301, zero
5787:             srli         s1, t4, 6
5788:             mulh         a4, t1, s1
5789:             bne          zero, t5, 5805f
5790:             srli         t5, s5, 15
5791:             addi         t0, t5, 1848
5792:             sll          s10, s6, gp
5793:             andi         ra, t1, -1462
5794:             xori         ra, a7, 398
5795:             rem          s11, t1, s8
5796:             beq          t2, a4, 5805f
5797:             sll          s3, s7, s11
5798:             csrrci       s8, 0x342, 0
5799:             xori         t0, s2, -570
5800:             slli         a5, sp, 26
5801:             addi         s9, a5, 474
5802:             mulh         a6, t6, t1
5803:             mulhsu       s9, a2, a2
5804:             sra          s8, a3, s1
5805:             slt          a6, t6, s1
5806:             srai         s1, s3, 0
5807:             bne          a3, a5, 5816f
5808:             mulhsu       t3, t2, t5
5809:             csrrwi       s7, 0x344, 30
5810:             sub          ra, t6, t1
5811:             add          s4, s11, t2
5812:             slti         s7, s7, -482
5813:             addi         s3, a1, 1944
5814:             addi         ra, ra, -1739
5815:             mul          a1, tp, t4
5816:             divu         t3, s5, sp
5817:             slli         s2, zero, 19
5818:             nop
5819:             nop
5820:             slli         s11, t1, 18
5821:             csrrs        t6, 0x304, zero
5822:             ori          s0, a2, 256
5823:             slti         s1, zero, 1238
5824:             csrrci       gp, 0x343, 7
5825:             beq          s11, ra, 5845f
5826:             sub          a3, tp, t6
5827:             csrrci       a3, 0x342, 0
5828:             sll          a6, a5, a7
5829:             beq          ra, s2, 5846f
5830:             sll          s11, s3, a7
5831:             sra          s7, s4, s10
5832:             bgeu         s11, s10, 5849f
5833:             auipc        t2, 866436
5834:             div          s0, t2, s10
5835:             nop
5836:             sll          s0, t3, s1
5837:             lui          s2, 769297
5838:             slli         t3, a1, 13
5839:             rem          a2, t5, a6
5840:             remu         t6, zero, t4
5841:             blt          a0, tp, 5843f
5842:             csrrsi       s0, 0x300, 0
5843:             bgeu         s10, tp, 5859f
5844:             remu         a6, a0, t1
5845:             csrrci       t4, 0x301, 0
5846:             nop
5847:             csrrc        zero, 0x305, zero
5848:             slli         s9, a4, 15
5849:             csrrw        s5, 0x344, t0
5850:             auipc        t2, 638042
5851:             divu         s3, s3, s11
5852:             slli         a3, s2, 10
5853:             addi         a2, a5, -967
5854:             remu         s6, a6, t3
5855:             nop
5856:             bltu         s9, a6, 5860f
5857:             bgeu         t3, t3, 5868f
5858:             csrrw        t4, 0x301, s5
5859:             auipc        zero, 377664
5860:             mulh         s9, t5, s4
5861:             csrrci       a6, 0x342, 0
5862:             csrrs        gp, 0x342, zero
5863:             mulhsu       s3, s1, sp
5864:             bne          t4, t2, 5866f
5865:             ori          s9, s8, -1215
5866:             bgeu         s7, tp, 5868f
5867:             bge          s3, t3, 5869f
5868:             csrrw        s0, 0x342, gp
5869:             sub          a2, zero, s5
5870:             mulhu        t1, s7, s0
5871:             or           a5, s9, t3
5872:             lui          s2, 745511
5873:             auipc        a4, 419445
5874:             andi         t6, s9, 2007
5875:             xori         t3, t6, -1171
5876:             csrrci       s7, 0x304, 0
5877:             andi         s7, a4, -1682
5878:             bne          sp, zero, 5898f
5879:             csrrc        s4, 0x342, zero
5880:             remu         a1, a1, ra
5881:             sll          t5, s5, s11
5882:             sltu         s9, s7, tp
5883:             and          s7, s5, zero
5884:             bge          s1, s0, 5900f
5885:             mulh         t1, t0, s5
5886:             bne          sp, a7, 5895f
5887:             csrrci       a5, 0x344, 0
5888:             srli         t1, a6, 21
5889:             blt          a5, a7, 5896f
5890:             csrrs        t3, 0x343, zero
5891:             mul          a3, t3, t0
5892:             bge          t2, s4, 5912f
5893:             xor          t1, sp, t4
5894:             csrrw        ra, 0x301, s5
5895:             csrrs        s11, 0x300, zero
5896:             mul          s0, s10, a0
5897:             beq          s9, s4, 5915f
5898:             auipc        a4, 1031000
5899:             mul          t5, t6, a7
5900:             andi         t2, t2, -1985
5901:             csrrci       zero, 0x301, 0
5902:             mul          t4, s3, a0
5903:             csrrw        t1, 0x304, zero
5904:             sltu         t4, zero, s11
5905:             slli         gp, s6, 7
5906:             blt          s3, t3, 5911f
5907:             auipc        zero, 194269
5908:             csrrc        s1, 0x343, zero
5909:             csrrwi       s10, 0x301, 4
5910:             xor          a1, sp, t4
5911:             add          s5, gp, s1
5912:             slt          s7, t3, s7
5913:             blt          s0, s10, 5914f
5914:             bne          s5, t1, 5924f
5915:             divu         ra, sp, tp
5916:             divu         t5, a5, zero
5917:             bltu         a4, sp, 5919f
5918:             mulhsu       s8, a6, s4
5919:             or           a2, sp, s3
5920:             bltu         t5, ra, 5933f
5921:             bgeu         sp, zero, 5938f
5922:             add          s11, a3, ra
5923:             auipc        s2, 817165
5924:             mulhu        t5, s7, a0
5925:             sltiu        a4, s3, -903
5926:             slt          gp, s0, a1
5927:             and          s6, t0, s6
5928:             sltiu        a1, t2, 1573
5929:             rem          s4, s5, s2
5930:             csrrsi       a1, 0x300, 0
5931:             sltiu        s0, t5, -537
5932:             srai         a2, s6, 8
5933:             sltiu        s2, s9, -527
5934:             rem          a7, a5, s9
5935:             addi         s2, t4, 701
5936:             slli         s3, gp, 26
5937:             divu         s4, t0, s7
5938:             remu         t2, a3, s0
5939:             csrrci       a5, 0x300, 0
5940:             add          s10, s1, sp
5941:             ori          a5, a3, 1301
5942:             add          a6, t1, s11
5943:             mulh         t2, tp, a6
5944:             slt          s0, s11, s10
5945:             sltu         s1, zero, s6
5946:             and          s1, gp, a4
5947:             csrrs        a7, 0x301, zero
5948:             mulhsu       s8, a2, s0
5949:             slli         s1, s1, 11
5950:             mulhu        s8, s2, s1
5951:             blt          s0, sp, 5967f
5952:             srai         s2, t4, 6
5953:             auipc        t5, 307808
5954:             bgeu         a5, a2, 5972f
5955:             ori          t0, s3, 1619
5956:             sltiu        s6, s7, -1653
5957:             srai         a1, a0, 12
5958:             or           t3, a7, s8
5959:             add          s5, t4, s6
5960:             bge          s5, s10, 5978f
5961:             auipc        t4, 442188
5962:             srl          s5, s11, a5
5963:             mulhu        t3, t6, t4
5964:             bgeu         s9, tp, 5981f
5965:             rem          s6, a3, s5
5966:             csrrc        t4, 0x344, zero
5967:             srai         s1, s7, 8
5968:             lui          t1, 968914
5969:             bne          s11, tp, 5985f
5970:             srli         s1, a1, 9
5971:             slli         a6, a6, 11
5972:             mulhsu       a2, s10, t3
5973:             csrrs        s11, 0x343, s9
5974:             addi         s4, a2, 277
5975:             srl          s6, a0, a2
5976:             csrrwi       a1, 0x342, 14
5977:             csrrc        s6, 0x301, a2
5978:             rem          s3, t6, s1
5979:             sltiu        s1, s2, 916
5980:             auipc        t3, 509480
5981:             sltu         a1, s7, t3
5982:             remu         gp, sp, a3
5983:             mulh         t1, a1, s0
5984:             mulhu        s9, s2, sp
5985:             auipc        t3, 652882
5986:             csrrwi       a5, 0x301, 28
5987:             lui          a7, 1039120
5988:             csrrsi       s9, 0x305, 0
5989:             rem          a2, s6, ra
5990:             srai         s10, a5, 31
5991:             sltu         s1, t1, t5
5992:             csrrs        s8, 0x344, zero
5993:             sltu         s6, s0, a1
5994:             or           zero, s7, sp
5995:             lui          s5, 528085
5996:             divu         s5, t3, s3
5997:             csrrw        a7, 0x343, ra
5998:             blt          a5, a5, 6018f
5999:             auipc        a7, 939942
6000:             and          s9, sp, a2
6001:             bge          a0, s11, 6003f
6002:             csrrw        zero, 0x304, a7
6003:             lui          t5, 394292
6004:             slti         s11, sp, -1174
6005:             add          a7, s10, s1
6006:             mul          ra, a1, t3
6007:             xor          a1, t5, s7
6008:             ori          t5, a3, 1674
6009:             mulhu        s8, s6, t5
6010:             slti         t0, gp, 1581
6011:             beq          a1, s8, 6021f
6012:             div          a2, s10, a2
6013:             remu         t6, a3, ra
6014:             bne          s10, s4, 6019f
6015:             beq          sp, s6, 6024f
6016:             mul          s8, sp, a0
6017:             rem          s6, s2, a4
6018:             srai         s4, a1, 1
6019:             divu         a6, t0, s5
6020:             csrrc        s1, 0x305, zero
6021:             csrrsi       s7, 0x342, 0
6022:             sltu         t3, a5, t3
6023:             csrrw        t5, 0x301, s10
6024:             xori         s7, s11, -483
6025:             div          a1, a5, ra
6026:             csrrwi       t5, 0x343, 30
6027:             blt          ra, t3, 6029f
6028:             nop
6029:             or           a2, t0, t3
6030:             csrrci       a7, 0x301, 23
6031:             beq          s0, a4, 6032f
6032:             sll          ra, a1, a7
6033:             mulhu        s1, ra, s4
6034:             sub          s1, s4, t2
6035:             beq          sp, s2, 6055f
6036:             ori          s9, s10, 1318
6037:             srl          s3, s2, a5
6038:             sltu         a7, t6, a4
6039:             mulhsu       s7, s6, t0
6040:             sll          a1, t1, s1
6041:             srai         s1, a2, 1
6042:             blt          s6, t3, 6043f
6043:             remu         t2, t4, ra
6044:             bgeu         t4, t0, 6064f
6045:             sra          s6, a4, a6
6046:             add          t1, s6, s2
6047:             srai         s5, a4, 7
6048:             nop
6049:             slli         s6, gp, 9
6050:             bltu         tp, zero, 6054f
6051:             csrrc        t1, 0x305, zero
6052:             xor          a4, t3, a5
6053:             lui          t5, 1014884
6054:             rem          s2, s11, zero
6055:             div          a3, a3, s4
6056:             csrrsi       s8, 0x301, 17
6057:             auipc        s8, 683123
6058:             sra          s4, ra, t5
6059:             andi         s7, t4, -1896
6060:             ori          a2, a5, 1752
6061:             slti         zero, t0, -1997
6062:             beq          ra, a7, 6063f
6063:             csrrs        gp, 0x343, zero
6064:             sltu         a1, s4, s9
6065:             srai         t4, zero, 6
6066:             bge          t2, s11, 6073f
6067:             ori          gp, a6, -1032
6068:             csrrwi       a4, 0x301, 8
6069:             beq          t6, zero, 6089f
6070:             csrrs        t2, 0x300, zero
6071:             or           s0, t0, t5
6072:             sub          s5, t2, s3
6073:             csrrci       a5, 0x343, 20
6074:             nop
6075:             srai         s11, t0, 16
6076:             addi         t0, t4, 406
6077:             add          s0, tp, t5
6078:             srli         t5, s4, 11
6079:             srai         s3, s2, 18
6080:             lui          s1, 578566
6081:             xori         s8, a7, 840
6082:             csrrsi       t2, 0x300, 0
6083:             sll          t3, s5, a2
6084:             bgeu         s10, s5, 6102f
6085:             andi         a3, s8, -633
6086:             div          a1, t6, s4
6087:             sll          t1, s6, a5
6088:             or           s11, s8, s3
6089:             bne          s5, s6, 6091f
6090:             csrrsi       t0, 0x301, 27
6091:             csrrc        ra, 0x344, s5
6092:             csrrw        s10, 0x343, t6
6093:             srli         a4, a5, 20
6094:             slti         s7, t2, -743
6095:             slti         s8, zero, -1344
6096:             bne          t0, tp, 6098f
6097:             andi         s7, s9, 25
6098:             div          s5, a0, tp
6099:             sra          s11, zero, a6
6100:             ori          t1, s8, 1048
6101:             srl          a1, t0, s9
6102:             mulhu        t2, s2, tp
6103:             csrrwi       t4, 0x343, 16
6104:             csrrs        t3, 0x343, zero
6105:             beq          sp, a7, 6107f
6106:             srai         s5, s2, 16
6107:             csrrs        t2, 0x343, zero
6108:             sub          a3, s3, s3
6109:             csrrsi       s1, 0x304, 0
6110:             auipc        s3, 534787
6111:             rem          a3, s10, s1
6112:             andi         a6, s2, 1840
6113:             sltiu        s11, t2, 1815
6114:             rem          t0, s4, a2
6115:             mulh         s3, s3, a2
6116:             bltu         ra, s8, 6132f
6117:             auipc        s1, 796660
6118:             xor          s8, gp, tp
6119:             slt          a3, t1, s0
6120:             andi         a6, s0, -964
6121:             auipc        gp, 203079
6122:             mulhsu       s5, sp, a7
6123:             and          a6, gp, gp
6124:             bge          t4, s0, 6133f
6125:             remu         t6, s11, t0
6126:             csrrc        a7, 0x300, zero
6127:             auipc        t2, 437241
6128:             ori          t5, t3, -1624
6129:             rem          t1, zero, a2
6130:             csrrsi       s5, 0x300, 0
6131:             srai         t4, a2, 19
6132:             blt          a3, s7, 6141f
6133:             nop
6134:             bltu         s6, t2, 6147f
6135:             remu         ra, s6, t2
6136:             csrrsi       a6, 0x301, 24
6137:             andi         s10, s8, -686
6138:             div          s8, s4, s4
6139:             srl          a1, s7, s9
6140:             sll          a5, s7, s8
6141:             csrrci       s4, 0x301, 0
6142:             slti         t3, a2, 1992
6143:             csrrc        t4, 0x301, zero
6144:             remu         a2, s2, s1
6145:             add          a6, a2, s1
6146:             or           t6, a0, t4
6147:             bltu         ra, s0, 6158f
6148:             add          s11, s4, sp
6149:             xor          s10, t0, a2
6150:             nop
6151:             divu         gp, s6, s11
6152:             bge          tp, s0, 6162f
6153:             csrrc        t1, 0x304, s8
6154:             srai         s4, a2, 18
6155:             csrrwi       a5, 0x304, 20
6156:             bne          s10, zero, 6172f
6157:             csrrsi       t3, 0x304, 0
6158:             srl          a5, s5, t3
6159:             divu         t2, t2, s7
6160:             csrrci       s6, 0x300, 0
6161:             bgeu         s8, a2, 6179f
6162:             sra          s5, tp, a3
6163:             csrrci       s3, 0x304, 17
6164:             xori         t6, t4, -2032
6165:             csrrsi       s9, 0x344, 29
6166:             bge          s11, gp, 6184f
6167:             bltu         s11, s9, 6180f
6168:             addi         s6, a0, 1932
6169:             auipc        a2, 153904
6170:             csrrw        s11, 0x344, s2
6171:             csrrs        a4, 0x344, a2
6172:             div          a5, s1, sp
6173:             mulhsu       s6, s11, a4
6174:             slli         s0, t4, 6
6175:             bgeu         t6, a3, 6177f
6176:             mulhsu       s6, t2, zero
6177:             lui          s5, 489879
6178:             slt          a5, tp, a3
6179:             lui          t0, 376344
6180:             csrrsi       zero, 0x343, 10
6181:             csrrw        s0, 0x342, a6
6182:             xori         s11, t3, 970
6183:             andi         s5, s10, 1127
6184:             slti         ra, s6, -2035
6185:             mulhu        s2, s9, sp
6186:             srl          a2, t4, s5
6187:             div          a1, s1, s11
6188:             beq          t4, s11, 6189f
6189:             beq          zero, s4, 6209f
6190:             csrrs        a4, 0x342, zero
6191:             bge          s10, t0, 6211f
6192:             divu         t3, ra, a6
6193:             bgeu         t5, s6, 6210f
6194:             srl          s11, sp, a6
6195:             csrrw        a5, 0x304, t2
6196:             slti         a1, a5, -369
6197:             csrrwi       ra, 0x304, 23
6198:             sltu         t1, s5, t1
6199:             srl          t1, ra, a2
6200:             sltu         a4, t0, a4
6201:             slt          s11, s9, t1
6202:             andi         t2, ra, -417
6203:             sub          s7, a7, ra
6204:             slli         t5, s2, 18
6205:             mulhu        s1, s4, a3
6206:             bgeu         a6, sp, 6219f
6207:             and          a7, s8, s8
6208:             and          s11, s4, t5
6209:             srli         ra, sp, 10
6210:             rem          gp, t4, zero
6211:             rem          t5, t2, tp
6212:             and          s2, s5, s11
6213:             nop
6214:             csrrw        s7, 0x301, a6
6215:             slli         a3, t5, 0
6216:             sltiu        a2, gp, -1164
6217:             sltu         s1, a6, sp
6218:             rem          s6, s1, t4
6219:             rem          s3, a6, s5
6220:             sll          s9, s5, zero
6221:             csrrci       t5, 0x342, 10
6222:             bge          a4, a1, 6224f
6223:             mulhu        s5, sp, s3
6224:             rem          t3, a6, s9
6225:             sll          t6, a6, t3
6226:             lui          t5, 795249
6227:             csrrsi       t3, 0x300, 0
6228:             mulh         s2, a5, a4
6229:             andi         s5, a6, 1077
6230:             csrrw        s4, 0x343, s10
6231:             rem          t4, sp, ra
6232:             ori          s3, s9, 1934
6233:             slti         a2, a2, -207
6234:             ori          a7, s5, 1441
6235:             mulhu        s10, t0, gp
6236:             sra          s10, s7, s6
6237:             sltu         s2, zero, zero
6238:             remu         a7, zero, s8
6239:             sltu         s3, s7, a3
6240:             xor          t1, a6, s11
6241:             divu         s1, a2, s1
6242:             blt          s3, zero, 6251f
6243:             nop
6244:             ori          a5, a2, 1591
6245:             lui          a1, 424638
6246:             slt          s7, t4, s2
6247:             csrrs        s9, 0x342, a5
6248:             csrrw        a3, 0x304, s10
6249:             bgeu         t1, s0, 6253f
6250:             slli         a7, tp, 28
6251:             div          s6, s6, gp
6252:             csrrsi       a5, 0x300, 0
6253:             ori          a3, s6, 234
6254:             blt          s5, zero, 6274f
6255:             csrrci       s0, 0x301, 19
6256:             mulhu        s4, s6, s6
6257:             xori         s5, a1, -1621
6258:             lui          s8, 818963
6259:             div          t3, t2, gp
6260:             bltu         t5, tp, 6276f
6261:             and          s10, a4, ra
6262:             slt          s5, s11, s3
6263:             auipc        a3, 132579
6264:             lui          t2, 883959
6265:             div          s10, t5, s10
6266:             mul          s2, tp, s1
6267:             sltu         t6, ra, s5
6268:             bne          t1, s6, 6273f
6269:             mulh         s10, s0, zero
6270:             mulhsu       a6, s10, s11
6271:             xor          t6, s0, t6
6272:             srl          a6, s5, a7
6273:             bne          s0, a0, 6289f
6274:             and          s4, s3, a2
6275:             sltiu        s7, s4, 984
6276:             div          s4, s5, s10
6277:             bne          gp, s4, 6284f
6278:             sub          s9, a1, s1
6279:             bne          s0, t0, 6299f
6280:             srli         a3, s5, 29
6281:             sub          s7, a2, s11
6282:             csrrs        s5, 0x343, zero
6283:             mulhu        zero, s3, a0
6284:             sub          s0, s1, a0
6285:             bltu         gp, s5, 6294f
6286:             bne          t2, a6, 6288f
6287:             bltu         ra, t0, 6289f
6288:             slti         s0, t3, -1032
6289:             blt          t1, s3, 6307f
6290:             andi         t2, a7, 398
6291:             blt          a1, s7, 6308f
6292:             mulhsu       s6, s11, t1
6293:             beq          a5, t0, 6294f
6294:             div          t5, t3, s7
6295:             remu         s5, a3, t2
6296:             slli         s2, a2, 4
6297:             mul          s4, gp, s4
6298:             andi         t1, s0, -1265
6299:             csrrsi       a4, 0x301, 0
6300:             mulh         s0, gp, tp
6301:             sltu         t5, t5, a4
6302:             bgeu         a7, zero, 6311f
6303:             nop
6304:             sltiu        s0, s3, -195
6305:             xori         s11, s4, -499
6306:             rem          s7, ra, s7
6307:             sll          t6, t1, s5
6308:             bgeu         s0, a4, 6319f
6309:             srai         t2, a7, 17
6310:             csrrs        a5, 0x344, a0
6311:             bge          s9, zero, 6313f
6312:             sll          zero, s7, s6
6313:             remu         s7, a7, a5
6314:             csrrs        s9, 0x301, zero
6315:             csrrci       t4, 0x342, 0
6316:             csrrs        s5, 0x304, zero
6317:             mul          t6, ra, zero
6318:             sub          s2, a6, sp
6319:             srli         t4, s7, 25
6320:             blt          t3, a5, 6321f
6321:             blt          zero, zero, 6339f
6322:             andi         s5, a0, 608
6323:             csrrsi       s8, 0x344, 0
6324:             srai         a6, a0, 22
6325:             sltiu        a7, s5, -69
6326:             sll          s1, s1, s6
6327:             beq          t6, tp, 6328f
6328:             sltu         s9, s11, s0
6329:             sub          ra, t4, s5
6330:             mul          a6, t2, s3
6331:             nop
6332:             nop
6333:             srl          t0, s11, sp
6334:             remu         zero, t3, a7
6335:             sra          s6, s0, t2
6336:             slt          t0, t0, a4
6337:             auipc        s4, 479607
6338:             andi         a7, s10, -455
6339:             blt          a0, s9, 6355f
6340:             csrrs        s4, 0x300, zero
6341:             remu         t0, ra, s7
6342:             mulhsu       t0, s3, a7
6343:             auipc        s6, 248275
6344:             and          a6, a7, sp
6345:             addi         a3, a7, 788
6346:             div          s11, s11, tp
6347:             divu         s3, t3, t0
6348:             slli         t4, s6, 29
6349:             srl          s11, s7, s11
6350:             slti         t5, a7, -1453
6351:             sltu         t6, tp, s10
6352:             sltu         s9, s10, a6
6353:             bgeu         a0, a2, 6366f
6354:             or           s3, s6, s6
6355:             rem          gp, t2, a0
6356:             auipc        s8, 479356
6357:             csrrsi       s7, 0x344, 21
6358:             remu         t3, t0, a5
6359:             nop
6360:             slli         a1, gp, 7
6361:             srli         s6, s4, 22
6362:             mul          a6, t2, s1
6363:             bltu         ra, a3, 6379f
6364:             xori         t5, s0, -1751
6365:             mulh         s7, gp, a1
6366:             and          s1, s3, s2
6367:             srai         s1, t3, 17
6368:             auipc        s6, 917393
6369:             sub          t1, a3, t6
6370:             sra          a5, a0, s4
6371:             mulhu        s7, s6, s5
6372:             csrrs        a6, 0x342, zero
6373:             srai         s2, t0, 5
6374:             bge          a3, t0, 6375f
6375:             mulh         s4, t1, ra
6376:             blt          t6, s5, 6387f
6377:             bge          a4, s10, 6379f
6378:             mul          s2, t6, s5
6379:             add          t4, tp, t2
6380:             bge          t2, a7, 6384f
6381:             csrrci       s7, 0x304, 0
6382:             auipc        a7, 154396
6383:             csrrc        s4, 0x304, a3
6384:             xor          ra, s1, a4
6385:             bltu         s9, t0, 6401f
6386:             csrrs        t4, 0x344, t3
6387:             mulh         a6, s3, t6
6388:             lui          s11, 484644
6389:             bge          a2, s7, 6396f
6390:             slli         s0, a4, 21
6391:             xori         a1, t1, -1789
6392:             csrrc        s5, 0x343, a4
6393:             mulhu        t4, zero, s7
6394:             xori         zero, s6, 1022
6395:             slt          a1, t4, s6
6396:             csrrsi       s2, 0x343, 11
6397:             andi         t5, t3, 808
6398:             srli         s7, t2, 15
6399:             add          t1, t2, s6
6400:             csrrw        a5, 0x342, gp
6401:             csrrs        s3, 0x301, zero
6402:             bltu         t2, s9, 6420f
6403:             csrrw        a5, 0x342, a4
6404:             mul          t3, a6, s1
6405:             and          s0, t2, tp
6406:             div          s8, a1, a4
6407:             sltiu        s2, s8, -561
6408:             bge          s2, t4, 6409f
6409:             slti         s0, s1, -1015
6410:             sll          s0, a2, t5
6411:             remu         s11, s10, s8
6412:             xori         s7, a3, 1655
6413:             blt          s1, t4, 6422f
6414:             add          t6, a0, s5
6415:             bge          gp, s4, 6424f
6416:             rem          a3, tp, s0
6417:             csrrs        a3, 0x301, s7
6418:             blt          t4, t1, 6420f
6419:             csrrsi       s9, 0x343, 0
6420:             xor          a7, a3, s8
6421:             blt          sp, s0, 6431f
6422:             divu         t2, s7, s9
6423:             slti         a4, ra, 1974
6424:             addi         ra, sp, 1260
6425:             andi         gp, s5, 1303
6426:             csrrc        s10, 0x301, a3
6427:             addi         a6, a2, 1202
6428:             csrrwi       t5, 0x342, 16
6429:             sub          t0, t5, s5
6430:             srl          s1, s0, t2
6431:             addi         t4, s3, -534
6432:             bge          a4, zero, 6449f
6433:             mulhsu       s10, a2, a7
6434:             mulhu        a2, a4, tp
6435:             add          t3, t1, a5
6436:             addi         a7, s1, 1886
6437:             add          s7, gp, t1
6438:             sltiu        zero, a6, -1488
6439:             mulh         t4, a6, t3
6440:             ori          t3, sp, 366
6441:             csrrs        a4, 0x344, zero
6442:             mulhu        s9, s11, s2
6443:             sra          s3, t2, a6
6444:             andi         s9, s9, -1562
6445:             beq          s4, a6, 6458f
6446:             rem          s6, a3, zero
6447:             slt          s8, t2, gp
6448:             and          a4, gp, s0
6449:             csrrc        s3, 0x304, s6
6450:             sltu         a2, s8, t2
6451:             sltiu        a7, a6, -451
6452:             andi         s11, a4, 1334
6453:             sltu         zero, a5, a2
6454:             csrrsi       s7, 0x343, 16
6455:             srai         s4, t1, 27
6456:             or           ra, t5, t2
6457:             slti         s6, ra, -478
6458:             div          s8, sp, s5
6459:             andi         zero, s1, -1683
6460:             mul          t2, s3, a4
6461:             sra          ra, a2, s10
6462:             ori          s2, a3, 2034
6463:             and          s3, t2, a7
6464:             sub          ra, gp, s4
6465:             csrrwi       s4, 0x344, 10
6466:             csrrw        a3, 0x343, a7
6467:             addi         s8, s9, 445
6468:             div          a5, s9, a5
6469:             mulh         t1, s8, s11
6470:             mulhsu       t5, t2, s8
6471:             auipc        t6, 626193
6472:             csrrwi       t4, 0x344, 8
6473:             bne          sp, t6, 6475f
6474:             beq          t2, t4, 6479f
6475:             divu         s3, s1, s6
6476:             sub          s6, a7, s8
6477:             xor          t4, s4, t4
6478:             mul          t1, a1, tp
6479:             csrrci       s0, 0x301, 7
6480:             slt          t4, zero, s4
6481:             auipc        s5, 636117
6482:             sltu         t4, t1, sp
6483:             xori         t5, s4, 1399
6484:             srl          s5, a1, t1
6485:             blt          gp, a0, 6502f
6486:             csrrci       ra, 0x343, 25
6487:             xori         gp, a5, 1639
6488:             sra          a7, sp, t2
6489:             sltu         t6, s8, gp
6490:             mul          a6, s9, a4
6491:             sltu         s8, t6, s7
6492:             lui          s11, 98288
6493:             divu         s8, s6, a3
6494:             addi         s4, s7, -61
6495:             sll          a4, a6, t0
6496:             andi         s8, a6, -1688
6497:             xori         t1, s9, -890
6498:             bge          t2, t0, 6516f
6499:             blt          s5, t1, 6508f
6500:             xor          zero, s5, s5
6501:             add          t4, t3, s4
6502:             sltu         gp, t3, s3
6503:             mulhu        t1, a7, zero
6504:             div          t3, t4, t6
6505:             mul          t4, a5, s8
6506:             bge          s11, a2, 6526f
6507:             bgeu         a3, a0, 6509f
6508:             csrrwi       s1, 0x342, 14
6509:             add          a5, a6, sp
6510:             and          t5, t4, s5
6511:             csrrw        a2, 0x343, t1
6512:             csrrwi       a6, 0x343, 22
6513:             slti         s9, s7, 672
6514:             rem          t4, a4, s0
6515:             sub          ra, a6, s5
6516:             mulh         s0, s2, s8
6517:             and          t1, zero, s8
6518:             srai         t4, t2, 10
6519:             slt          s11, t0, s3
6520:             csrrci       ra, 0x344, 0
6521:             srai         s10, a5, 26
6522:             sll          a1, t2, sp
6523:             mulhsu       a4, a7, t2
6524:             or           a3, s10, a3
6525:             or           t2, s11, s9
6526:             ori          zero, a7, -1863
6527:             srl          t3, sp, s1
6528:             remu         s1, a1, t3
6529:             beq          t4, ra, 6549f
6530:             mulhsu       a2, a0, a6
6531:             mulh         a4, sp, sp
6532:             srl          s4, tp, t4
6533:             csrrci       s9, 0x305, 0
6534:             sltiu        s5, s3, -871
6535:             addi         s1, sp, 213
6536:             divu         s0, gp, s8
6537:             sll          t1, t1, a4
6538:             srl          s2, s11, a4
6539:             mulhsu       a2, a7, sp
6540:             divu         s2, t2, a1
6541:             sltiu        zero, s11, -470
6542:             or           t1, a3, a0
6543:             xor          zero, s4, sp
6544:             sub          s5, s11, s9
6545:             mul          a5, s6, a7
6546:             auipc        s5, 869181
6547:             bne          t0, s6, 6549f
6548:             xori         s9, s5, -1940
6549:             csrrwi       s7, 0x344, 25
6550:             mulhu        s3, a2, zero
6551:             sub          a1, s5, a2
6552:             divu         s1, s10, a1
6553:             xor          s2, a5, a5
6554:             bne          zero, t6, 6574f
6555:             csrrwi       ra, 0x344, 10
6556:             bge          t2, a1, 6576f
6557:             srl          s1, t6, tp
6558:             bgeu         a2, a4, 6574f
6559:             srli         a7, t5, 19
6560:             blt          t5, s11, 6578f
6561:             divu         t1, s11, sp
6562:             mulh         ra, s1, zero
6563:             csrrsi       s9, 0x304, 19
6564:             sll          ra, a5, tp
6565:             bne          s1, s4, 6567f
6566:             auipc        s7, 277386
6567:             csrrw        s10, 0x301, s11
6568:             beq          s4, t4, 6569f
6569:             csrrwi       t6, 0x304, 12
6570:             mulhsu       s5, a2, s9
6571:             sltiu        s1, s8, -642
6572:             bltu         a4, s11, 6574f
6573:             add          s9, zero, a5
6574:             div          s11, s8, t3
6575:             xori         a4, a1, 727
6576:             srli         a2, a7, 24
6577:             sltiu        a2, tp, -1365
6578:             srli         s3, a2, 29
6579:             sll          s2, a7, s0
6580:             sra          s11, s10, a7
6581:             and          s10, s8, s8
6582:             add          a6, t5, a0
6583:             bgeu         ra, t6, 6587f
6584:             and          a3, s4, s5
6585:             ori          s1, gp, 1671
6586:             mulhsu       t5, gp, s4
6587:             or           s3, t0, s3
6588:             mulhsu       t4, sp, s0
6589:             and          a2, s10, s6
6590:             add          a5, t1, a6
6591:             slti         s1, s3, 1207
6592:             slt          gp, t2, a0
6593:             nop
6594:             ori          s5, zero, 1694
6595:             and          a1, s0, s1
6596:             sub          a7, s11, s0
6597:             auipc        s4, 414225
6598:             remu         a1, a5, s10
6599:             ori          zero, gp, -655
6600:             srai         s4, s9, 15
6601:             or           s3, s4, s9
6602:             srli         a6, s8, 1
6603:             slti         s2, t3, 67
6604:             slli         t0, t3, 22
6605:             div          t2, t1, s4
6606:             div          a3, s9, a5
6607:             slli         s10, t2, 25
6608:             csrrw        a4, 0x304, t5
6609:             sub          t2, a3, a1
6610:             mul          s11, a4, a3
6611:             srai         t0, s7, 11
6612:             bge          s6, ra, 6630f
6613:             csrrci       s11, 0x301, 0
6614:             csrrw        a6, 0x301, s2
6615:             beq          s11, t2, 6632f
6616:             slli         a6, s11, 21
6617:             csrrci       s5, 0x305, 0
6618:             and          s6, t6, s6
6619:             or           s2, a1, a4
6620:             csrrs        s4, 0x301, zero
6621:             xori         a3, s5, 1799
6622:             sltiu        a3, ra, -1327
6623:             sltu         a6, s6, t0
6624:             xor          s8, s9, a2
6625:             rem          s2, sp, s10
6626:             blt          a3, sp, 6644f
6627:             mul          s9, s7, t1
6628:             srl          t3, s2, t0
6629:             auipc        s10, 748492
6630:             nop
6631:             bgeu         s9, a4, 6640f
6632:             slti         t0, t3, 524
6633:             bne          s3, t6, 6653f
6634:             addi         a6, s0, -208
6635:             slti         t4, a6, -1937
6636:             lui          t1, 338315
6637:             csrrw        a6, 0x342, s4
6638:             sra          a7, s1, s4
6639:             div          s6, t6, t0
6640:             bge          a4, s6, 6653f
6641:             mulhu        s10, zero, s6
6642:             add          s4, s7, a1
6643:             csrrc        s3, 0x301, s3
6644:             bne          t1, ra, 6649f
6645:             mulhu        zero, s11, a1
6646:             divu         zero, s0, s1
6647:             mulhu        s10, a1, t4
6648:             csrrc        a1, 0x301, t6
6649:             bltu         a1, a7, 6662f
6650:             srl          gp, s0, s11
6651:             sltu         t0, t4, s2
6652:             nop
6653:             sra          t2, a7, t5
6654:             srli         a5, tp, 26
6655:             sll          t0, s11, zero
6656:             sra          a2, s7, t4
6657:             srai         a6, s7, 29
6658:             beq          s2, a4, 6669f
6659:             auipc        ra, 656460
6660:             ori          a6, a1, 173
6661:             slli         s11, s2, 21
6662:             mul          s10, a2, a7
6663:             bgeu         t1, a3, 6683f
6664:             csrrs        s7, 0x343, zero
6665:             bne          a4, t2, 6681f
6666:             mulhsu       a3, t0, tp
6667:             ori          t5, tp, -1949
6668:             add          t3, a0, a1
6669:             csrrc        s11, 0x301, zero
6670:             sra          s8, a5, a3
6671:             mulhsu       s11, t6, s8
6672:             csrrw        s9, 0x301, s9
6673:             csrrsi       a2, 0x305, 0
6674:             bltu         s10, t3, 6676f
6675:             csrrc        s11, 0x305, zero
6676:             csrrsi       a5, 0x304, 17
6677:             bne          ra, s10, 6684f
6678:             divu         a2, tp, sp
6679:             mul          ra, t0, s4
6680:             csrrs        s3, 0x344, t1
6681:             auipc        a4, 40960
6682:             xori         zero, s2, -1057
6683:             slt          a2, s0, s2
6684:             andi         s1, t5, -1068
6685:             bltu         s2, tp, 6686f
6686:             bltu         t5, s6, 6695f
6687:             andi         s1, sp, 555
6688:             sltiu        t3, s6, -1984
6689:             auipc        ra, 626752
6690:             sltu         zero, t6, a0
6691:             bgeu         t3, s6, 6707f
6692:             sltiu        s5, s10, -1097
6693:             mulhu        s4, t3, t1
6694:             csrrc        a6, 0x300, zero
6695:             or           a2, t0, tp
6696:             sll          ra, ra, a4
6697:             andi         t1, s3, -248
6698:             add          s0, t3, a1
6699:             srli         a6, t3, 11
6700:             sltu         t2, ra, t5
6701:             csrrsi       a6, 0x344, 6
6702:             add          ra, t0, a4
6703:             mulhsu       a6, a2, a0
6704:             div          s6, tp, a3
6705:             andi         s7, tp, -142
6706:             sltu         s6, a4, a5
6707:             mulh         s0, a0, s9
6708:             csrrc        a2, 0x301, s1
6709:             csrrw        s11, 0x344, s11
6710:             bge          s3, s7, 6712f
6711:             csrrw        a4, 0x343, t3
6712:             add          ra, t0, gp
6713:             lui          s10, 462356
6714:             xori         a2, t1, -1287
6715:             xor          t3, t4, gp
6716:             lui          t6, 2073
6717:             mulhu        s1, ra, a6
6718:             auipc        t6, 748827
6719:             mulhsu       ra, s11, s9
6720:             mulhu        s2, t6, t2
6721:             sltu         s5, gp, s9
6722:             blt          t3, gp, 6739f
6723:             srai         t5, a3, 8
6724:             csrrsi       t2, 0x344, 0
6725:             csrrsi       s11, 0x301, 3
6726:             bge          gp, ra, 6736f
6727:             nop
6728:             div          t2, s4, ra
6729:             blt          s7, zero, 6731f
6730:             beq          t1, s5, 6739f
6731:             add          ra, s5, s6
6732:             mul          s9, s4, t0
6733:             blt          s10, a5, 6753f
6734:             andi         zero, s8, 1887
6735:             mulhsu       s4, a6, t2
6736:             bge          t4, a4, 6737f
6737:             csrrsi       t5, 0x344, 0
6738:             mulhu        s0, a5, s5
6739:             blt          zero, t3, 6759f
6740:             csrrc        a5, 0x301, zero
6741:             slt          a3, gp, s10
6742:             csrrsi       s1, 0x300, 0
6743:             bgeu         a6, t2, 6752f
6744:             slti         t5, s7, -931
6745:             rem          t4, t3, a0
6746:             rem          s9, s2, s6
6747:             csrrsi       t5, 0x301, 12
6748:             sub          s9, s2, s11
6749:             bne          t6, t2, 6754f
6750:             sra          s7, gp, zero
6751:             nop
6752:             or           a2, a0, gp
6753:             bge          s0, s0, 6760f
6754:             addi         t4, sp, -1891
6755:             bgeu         a2, t6, 6773f
6756:             csrrwi       ra, 0x342, 16
6757:             divu         zero, t2, sp
6758:             csrrs        ra, 0x305, zero
6759:             mulh         a5, s9, a6
6760:             div          s8, s10, t2
6761:             xori         s2, a0, 1528
6762:             addi         s5, s10, -241
6763:             blt          zero, t4, 6781f
6764:             sll          t2, t4, a1
6765:             srl          gp, t0, a6
6766:             srl          gp, a0, t0
6767:             sra          t2, t0, t2
6768:             addi         a6, s2, -113
6769:             slli         a7, s5, 13
6770:             mulhsu       a6, a0, a6
6771:             csrrci       s1, 0x342, 0
6772:             div          s6, a1, t4
6773:             csrrw        t5, 0x342, gp
6774:             or           gp, t5, s5
6775:             div          a3, s1, s8
6776:             mulhsu       s10, a1, s7
6777:             csrrci       a4, 0x342, 0
6778:             and          t4, t1, t3
6779:             sub          ra, zero, s8
6780:             csrrs        a3, 0x343, zero
6781:             csrrw        s3, 0x342, s9
6782:             bge          t6, a7, 6783f
6783:             nop
6784:             srai         t1, s8, 0
6785:             blt          s7, s7, 6794f
6786:             nop
6787:             sltiu        t0, t4, -855
6788:             srl          s7, t2, a2
6789:             andi         s4, s3, -1956
6790:             slt          t4, a4, t5
6791:             beq          t2, s4, 6795f
6792:             or           a4, s10, zero
6793:             mulhu        s4, s8, s2
6794:             div          zero, a6, s4
6795:             srl          s5, a3, s4
6796:             mul          s7, t4, t4
6797:             auipc        t0, 74356
6798:             remu         a5, s11, s0
6799:             sltu         t0, s11, a2
6800:             and          s0, t0, s2
6801:             slli         s9, a7, 24
6802:             remu         s7, ra, t0
6803:             andi         t6, t2, -1811
6804:             bgeu         s1, a5, 6806f
6805:             rem          t3, t2, t4
6806:             csrrs        t4, 0x342, a2
6807:             csrrwi       s4, 0x304, 26
6808:             rem          a6, s8, s6
6809:             csrrwi       s2, 0x344, 8
6810:             nop
6811:             divu         s8, t0, s8
6812:             blt          t3, s10, 6814f
6813:             csrrsi       zero, 0x342, 20
6814:             srai         zero, a5, 21
6815:             lui          s3, 657254
6816:             mulhsu       s10, gp, s0
6817:             blt          a0, gp, 6837f
6818:             beq          s10, a6, 6835f
6819:             mul          s6, t5, s9
6820:             andi         s10, t5, 449
6821:             sltu         a3, t6, t1
6822:             sltu         s10, t5, s4
6823:             xor          zero, t2, s10
6824:             slli         s10, tp, 10
6825:             and          s7, t2, t2
6826:             remu         s7, a4, a2
6827:             xor          s10, a2, a6
6828:             blt          s4, sp, 6846f
6829:             rem          s9, s7, a1
6830:             bgeu         s9, a5, 6832f
6831:             ori          s9, a1, 502
6832:             csrrc        a3, 0x305, zero
6833:             andi         gp, sp, -1612
6834:             remu         s5, t3, s7
6835:             csrrs        a1, 0x342, zero
6836:             mul          gp, a6, a6
6837:             div          t1, a0, t0
6838:             blt          a1, a5, 6840f
6839:             slt          t4, s0, a4
6840:             mulh         a4, s3, zero
6841:             divu         t0, a2, s7
6842:             sll          t2, ra, a6
6843:             csrrc        a7, 0x300, zero
6844:             mul          t6, s8, a4
6845:             csrrc        t4, 0x304, zero
6846:             rem          a5, s9, s11
6847:             sra          a1, s9, s7
6848:             bltu         a1, s4, 6858f
6849:             csrrwi       a7, 0x344, 15
6850:             sub          s7, s7, s0
6851:             nop
6852:             sra          s3, a2, s2
6853:             or           ra, s11, s9
6854:             csrrsi       s9, 0x301, 27
                  sub          s7, s7, s0
                  nop
                  sra          s3, a2, s2
                  or           ra, s11, s9
6855:             csrrsi       s4, 0x344, 30
6856:             divu         s5, sp, sp
6857:             auipc        t3, 935591
6858:             lui          t5, 852897
6859:             bge          s6, s2, 6872f
6860:             srl          a2, s5, t6
6861:             remu         s10, t4, a5
6862:             xor          zero, s10, s0
6863:             csrrwi       a3, 0x304, 15
6864:             csrrci       t2, 0x344, 0
6865:             slt          a7, a7, a3
6866:             csrrsi       ra, 0x305, 0
6867:             bltu         a4, sp, 6880f
6868:             add          a2, a1, s5
6869:             srli         s3, s5, 1
6870:             mulh         t5, sp, s10
6871:             csrrwi       zero, 0x301, 12
6872:             srli         s11, s10, 7
6873:             divu         t3, s7, s3
6874:             srl          s9, t5, s10
6875:             lui          a5, 677698
6876:             csrrs        s0, 0x342, s4
6877:             or           s10, a2, a1
6878:             slt          s2, a6, a0
6879:             mulhu        s2, s10, a2
6880:             srli         a6, a0, 8
6881:             csrrs        a6, 0x301, zero
6882:             csrrw        s8, 0x343, t6
6883:             slt          s5, s4, ra
6884:             bge          t2, t1, 6904f
6885:             srl          gp, t1, s7
6886:             csrrs        s9, 0x343, zero
6887:             srli         t5, s1, 26
6888:             div          t6, a6, a7
6889:             bne          ra, s3, 6909f
6890:             bge          a2, s9, 6892f
6891:             blt          s11, a5, 6907f
6892:             csrrc        a3, 0x304, s11
6893:             sltu         zero, zero, s5
6894:             srai         s3, tp, 17
6895:             srli         a4, a5, 11
6896:             bne          s0, s6, 6897f
6897:             sll          s8, s1, t5
6898:             auipc        a6, 642951
6899:             beq          s0, s3, 6916f
6900:             mulhu        s9, t1, a7
6901:             slli         t0, s8, 8
6902:             mulh         a7, s3, s8
6903:             div          s11, ra, s7
6904:             beq          s6, s1, 6905f
6905:             beq          s4, s4, 6916f
6906:             csrrc        s3, 0x300, zero
6907:             csrrci       s1, 0x301, 0
6908:             ori          t5, t3, -62
6909:             divu         gp, t6, ra
6910:             bge          a5, gp, 6926f
6911:             bgeu         a7, t5, 6920f
6912:             add          s9, tp, sp
6913:             csrrw        s11, 0x304, a2
6914:             csrrs        s9, 0x304, zero
6915:             srl          t0, s5, t5
6916:             beq          t0, t6, 6932f
6917:             and          a7, t3, t0
6918:             bne          zero, t5, 6938f
6919:             bltu         s0, t4, 6939f
6920:             beq          t5, s0, 6938f
6921:             or           a2, s5, s1
6922:             slt          t4, t4, s11
6923:             slt          gp, a2, s10
6924:             or           a5, s0, s4
6925:             blt          zero, a3, 6942f
6926:             sltiu        t5, a3, -1570
6927:             divu         t1, s7, t4
6928:             lui          s1, 74397
6929:             sub          a7, s9, a0
6930:             srl          s5, gp, a4
6931:             addi         s5, s4, -826
6932:             ori          s0, t0, 1476
6933:             beq          a1, a1, 6937f
6934:             and          t6, t2, s1
6935:             slt          t2, s4, s11
6936:             mulhsu       s7, a5, s5
6937:             lui          s4, 375082
6938:             add          t1, a2, a2
6939:             sltiu        a3, s6, -1874
6940:             sltiu        s8, t0, -1838
6941:             or           gp, t1, gp
6942:             div          t6, a5, s11
6943:             csrrc        t4, 0x300, zero
6944:             csrrs        s6, 0x342, zero
6945:             auipc        t6, 338042
6946:             srl          s5, gp, s4
6947:             bgeu         s5, t3, 6965f
6948:             auipc        t3, 340479
6949:             and          s6, zero, a1
6950:             ori          s6, t0, 477
6951:             mulhsu       t1, t3, t5
6952:             rem          t0, tp, s4
6953:             and          a6, a1, t2
6954:             csrrw        s4, 0x342, a3
6955:             div          s10, s1, a6
6956:             addi         s4, t5, -2040
6957:             bltu         a2, a7, 6970f
6958:             xori         s4, s1, 430
6959:             sltiu        s1, a0, -1422
6960:             bne          tp, s3, 6961f
6961:             sll          ra, t6, s2
6962:             xori         gp, s9, -1264
6963:             andi         s1, s4, 1315
6964:             csrrci       a3, 0x342, 0
6965:             ori          s5, a1, -803
6966:             and          s10, a2, a2
6967:             srl          ra, s5, s2
6968:             andi         t6, s10, 2015
6969:             auipc        s11, 288816
6970:             xori         t6, s8, 570
6971:             slt          t2, s10, a7
6972:             blt          t3, a5, 6981f
6973:             bltu         a2, tp, 6982f
6974:             mulhsu       t3, a1, a5
6975:             divu         t6, s8, tp
6976:             remu         s3, a2, a2
6977:             csrrsi       t5, 0x344, 0
6978:             div          s11, s3, s0
6979:             bne          a6, t3, 6981f
6980:             xor          a6, s8, t4
6981:             lui          gp, 946753
6982:             sub          a5, s0, s11
6983:             add          s7, a0, s6
6984:             divu         zero, t4, s2
6985:             slti         ra, t2, 1285
6986:             mulh         a6, s3, s1
6987:             slt          s11, s5, s3
6988:             bltu         s4, s3, 6995f
6989:             sltiu        a6, s1, -1290
6990:             ori          a1, s5, -1717
6991:             mulh         a1, sp, t5
6992:             blt          s0, s0, 7003f
6993:             sltiu        t3, s11, -1468
6994:             mul          s10, s11, s3
6995:             csrrci       s8, 0x343, 20
6996:             nop
6997:             or           s8, s7, ra
6998:             slt          s8, s3, a2
6999:             csrrwi       a1, 0x342, 14
7000:             auipc        zero, 312828
7001:             csrrci       a3, 0x342, 11
7002:             srli         t6, t2, 1
7003:             mul          a1, t3, s8
7004:             sub          t1, s1, tp
7005:             andi         s11, a2, -1200
7006:             sub          gp, s10, s2
7007:             beq          a3, s10, 7023f
7008:             addi         a6, s7, -551
7009:             csrrs        s1, 0x344, zero
7010:             lui          gp, 299671
7011:             srli         a2, tp, 3
7012:             lui          zero, 236756
7013:             or           t0, s0, a3
7014:             bge          s5, t5, 7016f
7015:             bgeu         a5, s3, 7031f
7016:             srli         s6, t1, 7
7017:             sub          zero, s1, a2
7018:             sll          a6, t2, ra
7019:             srl          a7, s5, a3
7020:             csrrwi       t5, 0x301, 30
7021:             xori         a1, t3, -494
7022:             rem          t5, s1, s0
7023:             mulhu        s9, t5, s2
7024:             ori          s2, s7, 411
7025:             csrrc        s5, 0x301, zero
7026:             csrrs        s3, 0x342, zero
7027:             xor          zero, zero, a6
7028:             mulh         ra, t3, a0
7029:             rem          s4, a1, t0
7030:             and          a1, s7, t5
7031:             csrrw        s5, 0x344, a1
7032:             andi         t0, sp, 879
7033:             sll          s5, gp, s6
7034:             and          gp, t3, s2
7035:             bne          t2, t2, 7053f
7036:             csrrc        a2, 0x342, t5
7037:             csrrci       s8, 0x305, 0
7038:             addi         a1, s2, -1253
7039:             blt          s11, t5, 7049f
7040:             blt          s9, s2, 7049f
7041:             slt          a5, t0, a5
7042:             slt          a2, gp, s10
7043:             blt          a4, s11, 7045f
7044:             add          a3, zero, a3
7045:             sra          t5, s10, s8
7046:             or           s3, s4, a0
7047:             div          a3, t2, a0
7048:             xori         t0, a6, -1407
7049:             beq          gp, a3, 7051f
7050:             srl          t3, s1, a5
7051:             xor          s11, s5, a0
7052:             xori         ra, a2, -639
7053:             csrrsi       s6, 0x342, 0
7054:             bne          zero, s4, 7074f
7055:             auipc        t3, 893022
7056:             and          a7, t4, t3
7057:             mul          ra, t0, a0
7058:             or           s6, a2, a6
7059:             blt          s8, s8, 7061f
7060:             csrrsi       t5, 0x305, 0
7061:             blt          s3, t5, 7081f
7062:             sub          t0, zero, a0
7063:             csrrci       zero, 0x343, 0
7064:             xori         s7, s10, 427
7065:             xori         s2, t1, -1771
7066:             mulh         s10, t0, zero
7067:             srli         t1, s7, 7
7068:             sll          s3, a6, s2
7069:             remu         ra, s0, a0
7070:             csrrw        a7, 0x344, tp
7071:             bltu         a6, t5, 7072f
7072:             blt          s6, s8, 7092f
7073:             mul          s3, s9, t4
7074:             srli         s1, s6, 21
7075:             bne          s3, a3, 7092f
7076:             sltiu        s3, s1, 1558
7077:             csrrwi       s2, 0x342, 0
7078:             beq          s10, sp, 7094f
7079:             add          a7, sp, a4
7080:             mulhsu       ra, s5, sp
7081:             sra          a3, s2, tp
7082:             sll          a6, s0, a7
7083:             bltu         ra, s11, 7096f
7084:             srli         a2, a3, 17
7085:             bgeu         s2, sp, 7090f
7086:             lui          s10, 473954
7087:             addi         gp, tp, 1261
7088:             csrrwi       s6, 0x301, 20
7089:             slli         s3, a5, 8
7090:             csrrwi       s5, 0x342, 31
7091:             csrrci       t0, 0x343, 0
7092:             mulh         t1, s0, s5
7093:             beq          s4, t1, 7094f
7094:             csrrsi       t2, 0x301, 10
7095:             bge          a7, a3, 7115f
7096:             bgeu         s11, t1, 7113f
7097:             and          t2, a7, s4
7098:             slt          t0, a6, t1
7099:             srli         ra, s8, 22
7100:             sltiu        t2, s10, 339
7101:             sll          s8, a7, s0
7102:             sltu         s5, a3, s11
7103:             sltu         t6, t2, a3
7104:             divu         a2, t6, t1
7105:             csrrsi       s9, 0x305, 0
7106:             sra          s2, t6, s5
7107:             csrrsi       a4, 0x304, 0
7108:             csrrw        a5, 0x342, gp
7109:             csrrw        t4, 0x344, s9
7110:             blt          gp, a3, 7120f
7111:             divu         s8, t5, t4
7112:             mulhu        t2, tp, a7
7113:             slt          t1, a6, t3
7114:             add          a5, a0, t4
7115:             mulhsu       s6, s3, t1
7116:             remu         t1, s4, s2
7117:             or           t6, s9, s1
7118:             slt          t6, s8, zero
7119:             slti         a6, t5, -825
7120:             srai         gp, s8, 28
7121:             sra          t0, a1, t0
7122:             mul          t6, ra, a3
7123:             xor          s8, zero, t4
7124:             add          s8, s4, s9
7125:             csrrw        t0, 0x342, a4
7126:             srai         a7, a2, 19
7127:             csrrwi       s0, 0x304, 7
7128:             mul          t6, s3, a4
7129:             bgeu         a6, ra, 7142f
7130:             slt          t6, t3, s2
7131:             sltiu        t2, s4, 905
7132:             nop
7133:             slt          a3, tp, a1
7134:             beq          a3, s0, 7152f
7135:             add          s9, a5, s7
7136:             lui          a6, 561820
7137:             mulhu        s3, t0, zero
7138:             bne          t5, ra, 7158f
7139:             auipc        s8, 717129
7140:             srai         a1, zero, 11
7141:             ori          t0, s4, -331
7142:             srli         a1, a7, 24
7143:             sra          s6, s2, ra
7144:             csrrc        a2, 0x344, zero
7145:             mulh         s3, sp, zero
7146:             sra          ra, s10, a3
7147:             srai         a7, s10, 18
7148:             csrrsi       s0, 0x304, 7
7149:             slti         a5, a3, -1905
7150:             mul          a3, a0, t2
7151:             bgeu         a5, s5, 7169f
7152:             rem          s10, t1, s5
7153:             mulhsu       s6, t5, t6
7154:             beq          a3, a5, 7174f
7155:             csrrw        t1, 0x344, a3
7156:             xori         s6, s1, 649
7157:             sub          s4, s10, gp
7158:             andi         zero, t5, -744
7159:             sltu         t6, a3, t0
7160:             sub          a3, s0, zero
7161:             mulh         s10, s6, s9
7162:             rem          a5, a4, a2
7163:             bgeu         s7, gp, 7164f
7164:             mulh         t0, a7, t2
7165:             csrrsi       a1, 0x304, 0
7166:             remu         zero, a6, t3
7167:             beq          a0, t0, 7185f
7168:             andi         a1, a1, -1249
7169:             mulhu        s7, a5, a2
7170:             bltu         a1, t3, 7175f
7171:             or           gp, s4, ra
7172:             srli         s3, a3, 7
7173:             bne          a4, s4, 7175f
7174:             slli         s3, a6, 22
7175:             rem          zero, a4, tp
7176:             srli         s9, a3, 29
7177:             csrrs        t5, 0x305, zero
7178:             addi         t4, zero, 646
7179:             blt          a2, a0, 7192f
7180:             csrrci       t6, 0x344, 0
7181:             csrrw        s7, 0x301, t3
7182:             nop
7183:             csrrci       a2, 0x342, 23
7184:             xor          a6, t0, a6
7185:             csrrwi       t5, 0x301, 3
7186:             sll          s5, t5, s7
7187:             sltu         a7, a2, s10
7188:             addi         gp, s8, 790
7189:             sra          s10, a7, a7
7190:             slli         t1, tp, 27
7191:             sltu         zero, a6, t2
7192:             csrrc        gp, 0x344, zero
7193:             mulh         t5, ra, s5
7194:             lui          s7, 73999
7195:             mulh         s5, t2, t4
7196:             sll          a3, s7, a1
                  la           s8, region_0+2417 #start riscv_load_store_rand_instr_stream_14
                  srl          s1, s0, t1
                  sub          a5, gp, t4
                  lui          s6, 633962
                  lh           t1, -53(s8)
                  slli         zero, s9, 26
                  lb           t5, -27(s8)
                  mulhu        t6, gp, a7
                  lb           s0, 55(s8)
                  lh           t3, 55(s8)
                  lb           s1, -60(s8)
                  sb           t1, 38(s8)
                  sb           a5, 53(s8)
                  sltu         zero, a0, s10
                  ori          t6, t3, -1133
                  sw           gp, 35(s8)
                  rem          t4, tp, a0
                  mul          s9, a4, a5
                  srl          zero, s2, a6
                  rem          s11, s5, s4
                  csrrw        a6, 0x344, s2
                  rem          t6, a1, a6
                  sb           a0, 18(s8)
                  sb           s7, -52(s8)
                  csrrwi       a2, 0x301, 3
                  sb           a1, -34(s8)
                  sb           s10, -14(s8)
                  lb           t2, -21(s8)
                  or           s7, gp, t6
                  rem          t1, a6, s4
                  lb           s3, -23(s8)
                  lb           s2, 46(s8)
                  addi         a6, ra, 66
                  lh           ra, -37(s8)
                  lb           a4, 10(s8)
                  srl          a4, a5, s7
                  slli         s0, s10, 17
                  sb           s2, 32(s8)
                  lb           zero, -31(s8)
                  sh           a2, 61(s8)
                  lw           zero, 31(s8) #end riscv_load_store_rand_instr_stream_14
7197:             srli         t4, s0, 1
7198:             xori         ra, s1, -434
7199:             auipc        s5, 509828
7200:             mulhu        s2, s9, s8
7201:             sra          t3, s3, t2
7202:             bne          a5, s10, 7204f
7203:             ori          s10, s2, -742
7204:             auipc        t2, 133623
7205:             sltiu        t5, t4, -1289
7206:             mulhsu       s2, s6, t3
7207:             ori          t0, t2, -1995
7208:             xori         s6, t0, -1538
7209:             sub          s0, s7, t6
7210:             csrrwi       t0, 0x342, 12
7211:             sub          a4, ra, s1
7212:             mul          s6, a4, s9
7213:             mulhsu       gp, s9, a1
7214:             srli         a6, t0, 11
7215:             mulh         s8, s5, s1
7216:             ori          t3, t0, 1012
7217:             or           t3, t2, s8
7218:             srli         t6, t4, 21
7219:             lui          a7, 640456
7220:             csrrs        s0, 0x301, zero
7221:             csrrci       a7, 0x305, 0
7222:             csrrw        s10, 0x304, t0
7223:             bne          a7, a4, 7232f
7224:             auipc        s4, 118741
7225:             csrrs        s1, 0x344, zero
7226:             csrrc        s1, 0x305, zero
7227:             bne          a5, s9, 7247f
7228:             and          a2, t2, s9
7229:             csrrc        t2, 0x305, zero
7230:             mulhu        s3, a6, gp
7231:             bne          a1, gp, 7238f
7232:             sll          t4, zero, s9
7233:             sltiu        a6, a0, 413
7234:             blt          s0, s3, 7250f
7235:             andi         zero, s0, 1154
7236:             csrrc        s5, 0x342, zero
7237:             div          s1, s7, t4
7238:             bne          s11, s8, 7242f
7239:             mulhsu       a1, s7, s11
7240:             sub          s3, t5, t5
7241:             divu         t5, s11, s3
7242:             and          a1, t0, sp
7243:             blt          s3, s3, 7245f
7244:             srai         s3, t5, 10
7245:             xori         s1, t6, 1008
                  la           a2, region_0+1885 #start load_store_instr_stream_2
                  sb           s8, 36(a2)
                  la           ra, region_0+289 #start load_store_instr_stream_0
                  lbu          s2, -38(a2)
                  la           t6, region_0+174 #start load_store_instr_stream_3
                  lhu          a6, -23(a2)
                  sb           s0, 114(ra)
                  la           s4, region_0+1192 #start load_store_instr_stream_1
                  lbu          a1, -54(a2)
                  sb           s0, 143(t6)
                  sh           a4, -223(ra)
                  sh           s3, -180(s4)
                  lb           s8, -73(t6)
                  lb           gp, 72(ra)
                  sw           zero, 95(ra)
                  lb           a6, -27(s4)
                  lb           s2, -130(t6)
                  lbu          t4, -170(ra)
                  lh           a3, 192(s4)
                  lbu          t4, 150(ra)
                  lbu          gp, 31(t6)
                  sb           gp, 97(s4)
                  lb           a3, -121(t6) #end load_store_instr_stream_3
                  lbu          s10, -176(ra)
                  lb           a4, -225(s4) #end load_store_instr_stream_1
                  lw           gp, 15(a2) #end load_store_instr_stream_2
                  sb           a7, -244(ra) #end load_store_instr_stream_0
7246:             csrrs        zero, 0x344, a1
7247:             nop
7248:             slti         ra, a4, 350
7249:             mul          s0, t2, t5
7250:             bltu         gp, s3, 7266f
7251:             ori          a1, a2, -76
7252:             xor          s4, gp, s9
7253:             slti         s11, gp, 1099
7254:             bltu         s0, t1, 7271f
7255:             auipc        a1, 317010
7256:             divu         t5, gp, a2
7257:             srl          s8, s10, s0
7258:             slt          a4, tp, t2
7259:             srl          t6, s11, s3
7260:             bgeu         a5, s9, 7261f
7261:             slli         s9, gp, 19
7262:             mulhsu       t3, a5, s10
7263:             remu         gp, s2, s1
7264:             csrrsi       s2, 0x300, 0
7265:             beq          ra, t5, 7266f
7266:             mulhu        s0, a5, t2
7267:             andi         a5, s4, 1324
7268:             auipc        a5, 750834
7269:             srli         zero, a6, 22
7270:             lui          t0, 622378
7271:             sll          a6, s1, t3
7272:             sll          t3, t5, t3
7273:             andi         t3, a3, -1838
7274:             div          s8, t5, s8
7275:             lui          a4, 660213
7276:             rem          ra, ra, a2
7277:             sub          gp, a1, t1
7278:             slli         s1, gp, 20
7279:             addi         s11, t4, 1889
7280:             srl          a4, t6, a7
7281:             xor          a1, a2, gp
7282:             bge          a3, a6, 7284f
7283:             srl          t6, a2, sp
7284:             srai         a2, tp, 2
7285:             beq          t3, a7, 7294f
7286:             andi         s7, t3, 885
7287:             csrrs        zero, 0x305, zero
7288:             bge          s7, t2, 7299f
7289:             sra          gp, t6, gp
7290:             addi         a5, ra, -201
7291:             csrrc        s2, 0x300, zero
7292:             addi         s10, s8, 1470
7293:             andi         t1, t2, -780
7294:             mulhsu       a2, t0, t5
7295:             bltu         s7, t5, 7304f
7296:             csrrwi       s9, 0x344, 4
7297:             bltu         zero, t1, 7299f
7298:             srli         t5, gp, 11
7299:             sltu         a5, a6, a5
7300:             csrrw        s6, 0x342, a3
7301:             xori         t4, s7, 559
7302:             slti         s10, s0, -91
7303:             csrrc        a6, 0x304, s6
7304:             csrrw        s9, 0x344, t6
7305:             add          s3, a2, s10
7306:             nop
7307:             csrrci       t2, 0x343, 1
7308:             xori         s11, s2, 1906
7309:             xori         a4, zero, 709
7310:             nop
7311:             bgeu         s9, a6, 7327f
7312:             lui          t2, 968616
7313:             xori         s7, tp, 626
7314:             sltu         a1, ra, s1
7315:             andi         gp, s7, -964
7316:             srai         a3, t0, 16
7317:             bltu         s8, s4, 7319f
7318:             sll          s3, a3, a4
7319:             ori          t2, a5, -483
7320:             mulh         s9, gp, s0
7321:             srli         t4, t0, 25
7322:             blt          a0, a2, 7340f
7323:             auipc        a2, 622698
7324:             mul          s2, t1, s7
7325:             csrrs        t5, 0x300, zero
7326:             xori         a3, ra, 156
7327:             csrrw        s3, 0x301, s0
7328:             sra          t4, tp, a4
7329:             sra          ra, t3, s6
7330:             nop
7331:             sll          s1, t0, a3
7332:             csrrw        ra, 0x344, sp
7333:             mulh         s9, a4, t5
7334:             xori         ra, sp, 1100
7335:             bge          zero, a2, 7355f
7336:             add          gp, s8, a5
7337:             bne          a6, s6, 7357f
7338:             bltu         t5, s11, 7339f
7339:             div          t2, t5, a2
7340:             addi         s5, sp, 1633
7341:             rem          a6, t6, sp
7342:             mulh         s1, s1, zero
7343:             divu         s11, s5, s3
7344:             ori          t4, a6, -1394
7345:             mulh         s7, s2, tp
7346:             and          t0, t0, t0
7347:             xori         s3, s0, -800
7348:             remu         a7, a3, zero
7349:             ori          t0, t1, -1895
7350:             slli         s3, s5, 18
7351:             mul          t6, s3, s3
7352:             slli         a5, t6, 20
7353:             sltu         s3, s2, t1
7354:             nop
7355:             remu         s6, s2, s10
7356:             nop
main_97:          jal          ra, 5f
0:                jal          t1, 6f
1:                jal          s2, 16f
2:                jal          ra, 15f
3:                jal          a5, 0b
4:                jal          ra, 19f
5:                jal          s5, 21f
6:                jal          a5, 1b
7:                jal          t1, 2b
8:                jal          t3, 11f
9:                jal          a3, 14f
10:               jal          ra, 9b
11:               jal          ra, 7b
12:               jal          ra, 17f
13:               jal          t1, 18f
14:               jal          ra, 3b
15:               jal          a1, 20f
16:               jal          t1, 13b
17:               jal          s6, 8b
18:               jal          a1, 12b
19:               jal          t2, 22f
20:               jal          gp, 4b
21:               jal          ra, 10b
22:               sra          s6, s9, t4
7357:             csrrci       a1, 0x304, 0
7358:             remu         a3, gp, a6
7359:             lui          t2, 262010
7360:             nop
7361:             bgeu         a2, t0, 7370f
7362:             addi         t2, a1, -1
7363:             mulhsu       t5, s11, a6
7364:             srai         a2, a6, 14
7365:             xor          a5, s6, a0
7366:             add          a4, t1, s6
7367:             xor          a7, zero, t4
7368:             csrrsi       zero, 0x344, 0
7369:             sub          a6, s8, t4
7370:             add          s7, a4, zero
7371:             csrrci       s4, 0x301, 9
7372:             xor          s5, a3, a5
7373:             sub          a3, s6, t1
7374:             sltu         t3, t4, t0
7375:             slt          s7, a0, gp
7376:             ori          zero, zero, 571
7377:             mulhsu       gp, zero, t3
7378:             csrrs        a6, 0x343, zero
7379:             rem          a1, t3, a3
7380:             blt          s8, a3, 7400f
7381:             nop
7382:             beq          t1, s3, 7384f
7383:             sub          s7, gp, a4
7384:             csrrci       s0, 0x304, 21
7385:             bne          a0, t4, 7387f
7386:             slli         t1, s2, 3
7387:             csrrsi       s10, 0x300, 0
7388:             srai         t0, s2, 17
7389:             sltu         ra, tp, s3
7390:             add          s11, s10, s5
7391:             addi         a3, a1, -1968
7392:             beq          a7, s6, 7412f
7393:             sltu         s0, t2, s11
7394:             bgeu         s3, s4, 7412f
7395:             mul          s10, a6, s8
7396:             remu         zero, s6, ra
7397:             mulhsu       gp, a3, a5
7398:             add          t2, s0, a0
7399:             lui          a2, 251410
7400:             csrrci       s3, 0x300, 0
7401:             sra          s2, s7, s1
7402:             or           a2, a2, a4
7403:             bgeu         s6, a1, 7420f
7404:             slli         s6, s4, 24
7405:             sub          a6, t0, a4
7406:             csrrsi       a2, 0x300, 0
7407:             sltiu        t1, s10, 1215
7408:             auipc        t0, 530689
7409:             slti         zero, s3, 1743
7410:             bgeu         s3, ra, 7419f
7411:             mulh         t6, a3, t6
7412:             mulhsu       a3, a6, tp
7413:             or           s8, s5, s8
7414:             divu         t0, a0, s6
7415:             nop
7416:             csrrsi       t1, 0x343, 0
7417:             add          gp, a5, a4
7418:             csrrci       s4, 0x300, 0
7419:             csrrci       s1, 0x344, 17
7420:             csrrci       a1, 0x344, 0
7421:             sra          zero, s5, t6
7422:             div          s10, s9, s10
7423:             remu         a5, zero, t1
7424:             blt          s8, s10, 7434f
7425:             auipc        gp, 137465
7426:             bltu         s0, a2, 7437f
7427:             beq          t0, sp, 7440f
7428:             auipc        t5, 764972
7429:             and          s2, t3, t1
7430:             sra          t6, t5, ra
7431:             divu         t4, a2, t3
7432:             auipc        ra, 734466
7433:             csrrs        s10, 0x300, zero
7434:             remu         s1, s8, s9
7435:             xor          s10, s1, a4
7436:             sub          s4, tp, a1
7437:             mul          ra, a7, s9
7438:             bltu         ra, t4, 7454f
7439:             slli         s9, ra, 26
7440:             srai         a2, a3, 17
7441:             divu         t5, t1, t4
7442:             slt          s5, t6, s0
7443:             sub          a4, a0, t1
7444:             mulhu        s7, s7, t0
7445:             remu         s3, a5, a3
7446:             ori          a5, t3, 1978
7447:             srl          s2, t0, s5
7448:             sub          s3, t6, s9
7449:             srai         a6, s9, 10
7450:             beq          s5, s3, 7452f
7451:             sltiu        ra, s1, 129
7452:             mulh         a6, s2, a7
7453:             remu         s8, a3, a2
7454:             srai         t0, t1, 0
7455:             sltu         s6, t6, s7
7456:             auipc        t6, 861790
7457:             srl          gp, a5, s10
7458:             add          a3, s6, a5
7459:             sltu         s6, a6, a1
7460:             beq          s11, s2, 7461f
7461:             mulhsu       a7, s4, s3
7462:             lui          s10, 599926
7463:             csrrs        s1, 0x300, zero
7464:             xori         a3, s5, -1555
7465:             slt          a1, s9, s10
7466:             remu         s5, s1, a3
7467:             nop
7468:             sub          s4, ra, s10
7469:             div          a6, a1, s1
7470:             sra          t5, ra, s8
7471:             sll          a6, sp, s9
7472:             addi         gp, zero, 1024
7473:             lui          s0, 191313
7474:             div          t5, zero, a1
7475:             mul          s6, a1, s0
7476:             slti         a4, s0, -1419
7477:             remu         ra, t5, sp
7478:             slli         a4, s5, 26
7479:             sltu         s7, a0, tp
7480:             sll          t3, s0, s1
7481:             sub          t3, t6, a5
7482:             remu         s1, a3, ra
7483:             remu         t1, s1, a6
7484:             blt          t3, a0, 7489f
7485:             xori         t1, ra, -1638
7486:             div          a7, zero, s7
7487:             csrrs        t4, 0x305, zero
7488:             blt          a7, s10, 7501f
7489:             slti         s8, a4, -1262
7490:             mulhsu       ra, a6, a0
7491:             mulh         a4, sp, t0
7492:             srli         s11, s4, 23
7493:             nop
7494:             csrrci       s1, 0x300, 0
7495:             srl          t0, s10, s6
7496:             csrrw        t1, 0x304, t3
7497:             bltu         a1, s0, 7498f
7498:             xori         s5, s2, -1165
7499:             div          t2, a5, a6
7500:             remu         a4, s3, sp
7501:             bgeu         s0, s6, 7517f
7502:             sra          t0, s0, gp
7503:             csrrc        s5, 0x305, zero
7504:             nop
7505:             mulh         ra, gp, s4
7506:             auipc        a3, 88798
7507:             addi         ra, t3, -422
7508:             addi         a1, s0, -804
7509:             sra          s11, s8, s5
7510:             rem          t6, ra, zero
7511:             srl          a3, s2, s7
7512:             sra          s6, s1, t5
7513:             nop
7514:             blt          gp, s3, 7518f
7515:             mulhsu       t5, gp, ra
7516:             sub          t0, a5, a0
7517:             mulhu        a4, t1, gp
7518:             mulhsu       t1, zero, t1
7519:             slt          s4, a3, s6
7520:             or           s6, a4, s0
7521:             slt          a2, t4, t1
7522:             bgeu         zero, a5, 7531f
7523:             sltu         s0, s4, gp
7524:             and          s3, a7, a7
7525:             csrrs        a3, 0x342, zero
7526:             remu         zero, tp, a7
7527:             bltu         sp, t1, 7545f
7528:             addi         s7, sp, 1666
7529:             csrrwi       a4, 0x343, 30
7530:             sra          s3, s11, a0
7531:             rem          s3, t2, ra
7532:             div          a3, s10, t3
7533:             slti         t2, t2, 457
7534:             addi         s6, gp, 1259
7535:             sll          s7, s2, s10
7536:             div          t3, s3, t5
7537:             nop
7538:             addi         s11, s9, 1507
7539:             remu         t6, t0, tp
7540:             sltu         t6, s8, s2
7541:             slli         s0, t5, 12
7542:             sll          t0, s8, ra
7543:             mul          a3, a0, a5
7544:             csrrwi       t6, 0x304, 4
7545:             slti         gp, sp, 736
7546:             sra          s6, a2, s11
7547:             auipc        s1, 815105
7548:             rem          ra, t3, s5
7549:             csrrc        t0, 0x342, s7
7550:             srl          s9, s8, a6
7551:             mul          s8, t5, ra
7552:             sltu         t0, a0, t6
7553:             beq          s1, t3, 7555f
7554:             sra          a7, t5, s9
7555:             nop
7556:             mulhu        a1, t3, a0
7557:             xor          s7, s8, a3
7558:             bne          s10, a1, 7574f
7559:             slt          t1, t3, a5
7560:             mul          t2, t4, a3
7561:             srai         t0, s8, 0
7562:             mulhsu       t0, s6, a4
7563:             csrrwi       s8, 0x342, 8
7564:             csrrw        a5, 0x304, s1
7565:             bne          s3, sp, 7572f
7566:             csrrw        s3, 0x344, t4
7567:             add          s6, a3, s8
7568:             sll          t4, a4, a7
7569:             auipc        s11, 933275
7570:             divu         t1, s10, a0
7571:             xori         s7, sp, 1799
7572:             slli         a3, a6, 18
7573:             xor          s1, s9, a7
7574:             mul          t0, s1, a6
7575:             divu         s7, a1, s3
7576:             sltu         zero, s4, t1
7577:             mulhu        ra, t6, a0
7578:             div          a4, a0, a4
7579:             csrrsi       s0, 0x342, 8
7580:             addi         t6, t5, 1129
7581:             mulhsu       t4, t5, a3
7582:             or           t6, a0, s0
7583:             bltu         s6, a6, 7600f
7584:             divu         t5, a3, a3
7585:             bge          a3, s5, 7603f
7586:             rem          a1, s5, s0
7587:             nop
7588:             rem          a1, zero, t6
7589:             bge          a7, t6, 7606f
7590:             beq          s8, t6, 7597f
7591:             mulhsu       t3, t5, s6
7592:             mulh         t3, s8, s11
7593:             remu         t6, a7, s1
7594:             sltu         t4, a7, a0
7595:             sll          zero, s6, a2
7596:             slt          t5, t5, tp
7597:             lui          s8, 172639
7598:             andi         a3, a1, -1651
7599:             srli         t5, a4, 26
7600:             sltu         s7, a3, s4
7601:             sub          a3, a2, a1
7602:             add          t2, s2, s6
7603:             csrrs        a2, 0x342, zero
7604:             blt          s5, t0, 7617f
7605:             sltu         a3, t6, a7
7606:             bgeu         s4, t6, 7608f
7607:             rem          a6, s1, s11
7608:             beq          s6, t4, 7628f
7609:             blt          a4, s5, 7611f
7610:             remu         t5, s11, s1
7611:             srli         t0, a5, 3
7612:             csrrs        a3, 0x300, zero
7613:             slli         gp, s3, 2
7614:             bge          a6, t6, 7616f
7615:             rem          ra, t0, s5
7616:             sltu         a5, s0, s10
7617:             mulhsu       s6, a2, a4
7618:             csrrc        t1, 0x304, zero
7619:             and          t1, sp, t0
7620:             csrrw        s3, 0x343, s6
7621:             addi         t2, t3, 1655
7622:             mulhsu       t1, a3, a5
7623:             mulhu        zero, a6, s7
7624:             bltu         a0, t0, 7637f
7625:             blt          a1, s2, 7636f
7626:             bne          s6, t5, 7627f
7627:             ori          a2, s8, 253
7628:             srai         s4, a1, 11
7629:             remu         a2, a7, s8
7630:             csrrci       a2, 0x344, 9
7631:             sra          a3, s4, a4
7632:             remu         s9, s7, t4
7633:             ori          zero, t3, -2004
7634:             xor          t6, t0, s7
7635:             sll          s3, a5, a2
7636:             andi         s4, a1, -1850
7637:             srai         t2, sp, 7
7638:             bge          s7, ra, 7656f
7639:             andi         ra, s3, 345
7640:             sltu         s0, a6, t6
7641:             mulhsu       s3, gp, s0
7642:             ori          s0, s0, -1502
7643:             xori         s5, a3, -362
7644:             csrrs        t3, 0x344, zero
7645:             sll          a2, s8, ra
7646:             slt          s0, s1, t3
7647:             csrrw        zero, 0x301, s5
7648:             remu         s8, a4, t2
7649:             srl          ra, s10, t4
7650:             xor          s9, s6, t5
7651:             sll          s8, a5, a5
7652:             blt          t6, ra, 7672f
7653:             srl          a2, ra, t4
7654:             sll          t2, s6, t3
7655:             sub          t1, s0, s3
7656:             sll          t5, s2, t1
7657:             bne          s8, s6, 7673f
7658:             csrrsi       t0, 0x300, 0
7659:             bge          s3, s1, 7668f
7660:             addi         a1, s1, 1336
7661:             slt          ra, s11, a4
7662:             ori          s5, ra, -1915
7663:             slti         a5, s10, 200
7664:             sll          zero, s8, a0
7665:             and          t1, t6, ra
7666:             bne          s10, t4, 7683f
7667:             srai         t2, t5, 4
7668:             srli         s10, s7, 0
7669:             beq          s6, s7, 7689f
7670:             lui          t3, 678606
7671:             csrrsi       a7, 0x305, 0
7672:             lui          s3, 935960
7673:             sra          a4, s11, t0
7674:             addi         ra, a7, 1078
7675:             remu         t3, s1, t0
7676:             bgeu         s5, a5, 7692f
7677:             xor          s6, s6, s0
7678:             sra          ra, a2, t4
7679:             divu         s7, s11, s5
7680:             andi         ra, t6, -1584
7681:             sltiu        ra, a2, 1532
7682:             sltu         a5, zero, sp
7683:             sra          a7, a3, tp
7684:             and          s3, t6, s1
7685:             beq          a7, t4, 7686f
7686:             mulhsu       a2, s5, a2
7687:             and          s6, t0, s8
7688:             div          t0, s6, a5
7689:             csrrw        s7, 0x344, a0
7690:             mulh         s1, a6, a5
7691:             rem          s6, s8, t2
7692:             bne          s8, a7, 7696f
7693:             or           a3, t3, s10
7694:             csrrs        t2, 0x344, s9
7695:             beq          s6, t0, 7711f
7696:             xori         t5, s5, 1832
7697:             xori         s4, s2, 1887
7698:             xor          a2, ra, t0
7699:             sltu         s4, s0, a0
7700:             csrrs        s9, 0x305, zero
7701:             slli         s8, zero, 30
7702:             and          a6, s6, s7
7703:             andi         s11, a2, -1883
7704:             div          t1, s0, a5
7705:             srl          a6, s2, t1
7706:             mul          s1, a6, s7
7707:             csrrs        t4, 0x305, zero
7708:             addi         a4, a4, 1627
7709:             srai         s11, s11, 3
7710:             csrrs        a7, 0x305, zero
7711:             csrrs        a1, 0x305, zero
7712:             slt          t0, a5, s8
7713:             csrrci       t4, 0x301, 0
7714:             csrrwi       s5, 0x343, 5
7715:             bgeu         s9, t5, 7724f
7716:             rem          t2, a5, s6
7717:             mulh         s0, tp, t2
7718:             nop
7719:             slt          a7, s3, s1
7720:             auipc        t2, 391869
7721:             auipc        t1, 243816
7722:             mul          s2, s0, s6
7723:             remu         a3, s5, s3
7724:             remu         s10, a7, s4
7725:             csrrc        a5, 0x304, s9
7726:             bltu         t4, s8, 7727f
7727:             bne          s11, s1, 7745f
7728:             ori          s4, a2, -967
7729:             csrrsi       s11, 0x343, 12
7730:             csrrwi       t4, 0x342, 4
7731:             slt          s0, s5, s7
7732:             lui          t6, 297238
7733:             slt          zero, gp, a5
7734:             sltiu        a5, tp, 368
7735:             csrrsi       s4, 0x304, 0
7736:             or           gp, a6, s2
7737:             sltiu        a6, t5, -1208
7738:             addi         a5, t5, -1555
7739:             ori          t3, t1, -1962
7740:             csrrwi       t2, 0x343, 8
7741:             lui          s8, 54546
7742:             or           t5, tp, a1
7743:             csrrs        a2, 0x304, zero
7744:             remu         s10, t5, zero
7745:             bge          s4, a0, 7765f
7746:             sltu         t0, zero, s3
7747:             mulhu        s3, t1, s10
7748:             beq          tp, ra, 7758f
7749:             beq          zero, a1, 7751f
7750:             bgeu         s11, a7, 7755f
7751:             andi         gp, tp, 506
7752:             sll          s10, s1, a0
                  la           a2, region_0+1951 #start load_store_instr_stream_1
                  la           a5, region_0+2059 #start load_store_instr_stream_0
                  sb           s7, 224(a5)
                  lh           t2, 75(a5)
                  lb           s7, 106(a2)
                  lb           t1, -228(a2)
                  sb           s5, -58(a5)
                  lbu          t2, 170(a2)
                  lbu          t5, -18(a5)
                  lh           s11, -73(a5)
                  lh           t0, 79(a5)
                  lh           s11, 25(a2)
                  sb           s8, -110(a5)
                  lb           a7, -57(a2)
                  lb           s2, -174(a5)
                  sb           sp, 192(a2) #end load_store_instr_stream_1
                  lb           s5, 0(a5) #end load_store_instr_stream_0
7753:             div          a7, s5, s10
7754:             sltu         a4, a2, t4
7755:             mulh         s0, a2, t2
7756:             and          s1, t6, s8
7757:             andi         a7, a5, 1158
7758:             sra          a3, t6, s3
7759:             slti         gp, a3, -766
7760:             add          t2, s8, s9
7761:             csrrc        s4, 0x305, zero
7762:             bne          t0, s4, 7771f
7763:             ori          a6, a6, 703
7764:             auipc        a7, 1029773
7765:             mulhu        t0, t2, gp
7766:             csrrwi       a3, 0x342, 0
7767:             bge          a7, s4, 7769f
7768:             bne          a1, t6, 7786f
7769:             sltiu        s7, zero, -947
7770:             remu         a1, s7, s3
7771:             slt          t2, a0, t0
7772:             csrrc        s11, 0x300, zero
7773:             rem          a6, gp, s3
7774:             sltiu        t0, s9, 253
7775:             bltu         t1, a1, 7788f
7776:             csrrsi       s0, 0x300, 0
7777:             slli         a5, s9, 15
7778:             bne          gp, t5, 7796f
7779:             addi         t5, a3, -137
7780:             lui          a4, 863297
7781:             bge          s9, s2, 7783f
7782:             slli         t4, a1, 7
7783:             and          s7, s4, a0
7784:             srl          s4, tp, a6
7785:             sltiu        a6, s7, 441
7786:             csrrsi       s5, 0x342, 24
7787:             csrrci       s1, 0x300, 0
7788:             mulhu        s5, s9, a3
7789:             csrrci       t6, 0x344, 0
7790:             csrrw        a6, 0x344, s5
7791:             andi         s2, s0, -967
7792:             sll          s4, s5, a1
7793:             bgeu         s10, t2, 7813f
7794:             mul          t1, s9, s0
7795:             csrrsi       t6, 0x300, 0
7796:             addi         s3, tp, 1852
7797:             csrrsi       a7, 0x342, 0
7798:             csrrci       a3, 0x343, 3
7799:             csrrci       s5, 0x343, 0
7800:             csrrc        a7, 0x344, s1
7801:             sub          t1, t2, s0
7802:             bltu         a5, a3, 7815f
7803:             remu         s3, s1, s3
7804:             xori         a3, t0, -2012
7805:             sltu         a3, s11, t1
7806:             slt          ra, s2, s1
7807:             bgeu         t4, a5, 7811f
7808:             slli         s7, sp, 17
7809:             bgeu         t5, t4, 7826f
7810:             srai         a7, s7, 25
7811:             srl          a6, a7, s0
7812:             ori          s6, a4, 629
7813:             andi         s5, s8, 188
7814:             remu         a5, t4, a3
7815:             nop
7816:             csrrsi       s1, 0x344, 26
7817:             lui          gp, 568059
7818:             sub          t1, t4, s3
7819:             bge          a7, gp, 7835f
7820:             csrrsi       s7, 0x344, 22
7821:             mulh         a6, s5, t4
7822:             andi         s4, s3, 1293
7823:             xor          s11, s5, s1
7824:             add          ra, s4, a2
7825:             andi         t6, sp, 2033
7826:             xor          zero, t1, a1
7827:             sltu         s1, a4, s2
7828:             csrrci       a7, 0x343, 2
7829:             bgeu         sp, s8, 7831f
7830:             mulhsu       s4, ra, a6
7831:             sltu         t3, s10, ra
7832:             add          s2, t4, s1
7833:             mulhsu       zero, s9, zero
7834:             bge          s2, s11, 7835f
7835:             bgeu         a1, tp, 7846f
7836:             srli         s5, s3, 7
7837:             bltu         sp, s4, 7846f
7838:             sltiu        s9, t2, 1555
7839:             ori          s7, s8, 1761
7840:             blt          t3, ra, 7860f
7841:             csrrwi       t1, 0x304, 8
7842:             sltu         a2, t0, s10
7843:             bltu         s7, a2, 7850f
7844:             slli         t1, s10, 21
7845:             bge          tp, s3, 7847f
7846:             srai         ra, s10, 22
7847:             csrrci       s1, 0x342, 30
7848:             bltu         a7, a1, 7850f
7849:             andi         s8, t5, 864
7850:             csrrsi       s0, 0x305, 0
7851:             sra          s7, s7, s4
7852:             csrrwi       t2, 0x342, 5
7853:             rem          s10, s0, a0
7854:             csrrc        ra, 0x342, s8
7855:             mul          t0, t4, t6
7856:             srli         zero, s9, 19
7857:             rem          s1, s4, t1
7858:             sll          s6, s8, s0
7859:             divu         gp, sp, a3
7860:             mulhsu       zero, s9, s0
7861:             div          a3, tp, a3
7862:             slli         t1, s3, 16
7863:             csrrc        a6, 0x305, zero
7864:             sltiu        ra, a0, -1074
7865:             addi         s2, tp, -1662
7866:             xor          s9, t3, t4
7867:             sub          s8, t4, s9
7868:             add          a5, t3, a4
7869:             csrrc        a2, 0x342, s10
7870:             sub          a5, t2, s4
7871:             blt          a7, a1, 7880f
7872:             srai         a1, ra, 6
7873:             csrrs        s10, 0x304, s0
7874:             bge          a7, s11, 7890f
7875:             bltu         s4, s0, 7876f
7876:             mulhsu       t0, t1, s9
7877:             mulhu        a2, sp, ra
7878:             sltu         t3, t6, s3
7879:             blt          a7, t4, 7888f
7880:             bgeu         s7, a3, 7900f
7881:             addi         a4, s5, 895
7882:             slt          s3, s6, a5
7883:             nop
7884:             csrrs        t6, 0x304, a4
7885:             lui          a5, 496704
7886:             remu         a6, s11, s7
7887:             add          a1, t2, t1
7888:             add          ra, s9, s10
7889:             bne          a5, s5, 7894f
7890:             srli         s4, t3, 10
7891:             ori          s3, t0, 963
7892:             csrrs        s1, 0x344, zero
7893:             slt          s4, t3, s10
7894:             srai         s4, t1, 20
7895:             nop
7896:             or           s10, t0, a3
7897:             nop
7898:             nop
7899:             beq          s2, s9, 7900f
7900:             sra          s0, ra, s4
7901:             mulhu        t2, t4, s2
7902:             bgeu         a1, s7, 7912f
7903:             bne          a7, s6, 7919f
7904:             mul          t5, t1, ra
7905:             bne          t2, s11, 7922f
7906:             add          a7, t3, t4
7907:             blt          t5, t4, 7909f
7908:             csrrs        s4, 0x343, s0
7909:             mulhsu       zero, sp, zero
7910:             slli         t0, sp, 19
7911:             slt          s8, t3, a6
7912:             csrrs        t4, 0x344, zero
7913:             csrrs        s5, 0x301, s2
7914:             lui          s2, 939423
7915:             csrrsi       t1, 0x344, 0
7916:             andi         a6, s1, -1883
7917:             addi         a4, t4, 1680
7918:             andi         a7, a7, 258
7919:             bne          a0, t1, 7939f
7920:             xori         s1, s4, -1731
7921:             mulh         s9, t6, s4
7922:             mulh         s0, zero, s9
7923:             srai         t6, s4, 17
7924:             sltu         gp, a2, ra
7925:             csrrs        s11, 0x300, zero
7926:             slti         t6, s8, 677
7927:             lui          gp, 271177
7928:             beq          t0, a0, 7946f
7929:             divu         a3, s2, tp
7930:             sub          a3, s6, a2
7931:             slli         t2, t2, 5
7932:             slli         s10, s4, 25
7933:             srai         t4, a1, 1
7934:             remu         a2, t5, t2
7935:             auipc        gp, 366712
7936:             remu         s11, t4, a6
7937:             xori         a7, s0, -625
7938:             sub          zero, a1, s2
7939:             sltu         t3, a2, s6
7940:             remu         t5, s8, s10
7941:             bne          sp, s10, 7957f
7942:             ori          t1, s3, -1847
7943:             bgeu         a6, t0, 7945f
7944:             csrrs        s8, 0x300, zero
7945:             lui          a7, 434519
7946:             csrrwi       s2, 0x301, 5
7947:             and          t0, t5, a2
7948:             csrrs        s0, 0x342, zero
7949:             andi         s5, t5, -1535
7950:             nop
7951:             xor          t2, s10, sp
7952:             or           a2, s3, a4
7953:             mulhu        t4, a6, s9
7954:             add          s0, a0, tp
7955:             csrrsi       s5, 0x301, 0
7956:             sltiu        t3, s2, -1627
7957:             bne          s0, ra, 7962f
7958:             bge          a4, t0, 7974f
7959:             remu         s1, gp, a0
7960:             srl          t0, s5, s2
7961:             sra          t3, a1, gp
7962:             beq          tp, sp, 7964f
7963:             auipc        gp, 395449
7964:             srli         s4, s3, 8
7965:             bne          sp, a1, 7983f
7966:             sub          t4, t6, a1
7967:             mulh         t2, s4, a2
7968:             sltiu        s7, ra, 1875
7969:             lui          a4, 487340
7970:             srai         s7, t1, 22
7971:             or           t5, a6, a0
7972:             rem          a7, s5, a6
7973:             sub          t3, s9, s5
7974:             blt          s2, a3, 7987f
7975:             sltu         s7, t6, s5
7976:             mulhsu       s5, s8, t3
7977:             xor          gp, a2, t6
7978:             andi         s11, a5, -529
7979:             slti         zero, t0, -653
7980:             ori          s10, s4, 491
7981:             nop
7982:             lui          a4, 120351
7983:             csrrc        s5, 0x344, zero
7984:             nop
7985:             and          a6, s10, t5
7986:             or           a4, t0, a4
7987:             ori          t6, s8, -559
7988:             bgeu         a7, zero, 7995f
7989:             bgeu         a5, s7, 8007f
7990:             blt          gp, s11, 7992f
7991:             addi         s10, t4, 648
7992:             xor          s4, t6, zero
7993:             divu         s1, a1, zero
7994:             addi         s3, a5, 984
7995:             csrrc        ra, 0x305, zero
7996:             divu         gp, t6, tp
7997:             csrrs        t4, 0x301, zero
7998:             bge          tp, s9, 8018f
7999:             blt          s5, gp, 8012f
8000:             andi         s10, a0, -132
8001:             slli         a6, s10, 10
8002:             slti         a4, t4, 1945
8003:             csrrs        a7, 0x343, a1
8004:             or           s2, t2, ra
8005:             ori          ra, t6, 653
8006:             add          s3, s10, ra
8007:             mul          s0, a3, s4
8008:             beq          a6, s0, 8028f
8009:             divu         zero, s8, ra
8010:             beq          t5, s2, 8011f
8011:             slli         s5, ra, 10
8012:             csrrs        a3, 0x300, zero
8013:             sltiu        s11, t4, 768
8014:             ori          s9, s4, -636
8015:             mulh         s4, s7, tp
8016:             div          s6, a2, s10
8017:             srl          t0, s7, s1
8018:             bgeu         t3, a1, 8020f
8019:             slt          a3, s3, s11
8020:             addi         t3, sp, 1430
8021:             csrrc        t2, 0x301, zero
8022:             bgeu         s5, ra, 8033f
8023:             sub          s11, zero, s11
8024:             srli         a4, ra, 23
8025:             bge          a5, zero, 8034f
8026:             mulh         ra, gp, ra
8027:             bne          a7, s7, 8043f
8028:             slli         zero, t4, 16
8029:             beq          t3, s10, 8031f
                  la           t6, region_0+3354 #start load_store_instr_stream_1
                  la           t0, region_0+2477 #start load_store_instr_stream_0
                  lbu          s2, 837(t0)
                  sb           t5, 37(t6)
                  lbu          s5, 52(t6)
                  lbu          t1, -1354(t0)
                  sb           t0, 47(t6)
                  sb           a6, -182(t0)
                  sb           t0, 462(t0)
                  lhu          gp, 20(t6)
                  lb           a1, -204(t0)
                  lb           s11, 50(t6)
                  sb           s8, -41(t6)
                  lbu          gp, -1012(t0)
                  lbu          s11, 683(t0)
                  lb           a1, -41(t6)
                  lh           t2, -42(t6)
                  sb           s4, -157(t0)
                  sh           tp, -1603(t0)
                  sh           s3, -62(t6) #end load_store_instr_stream_1
                  lbu          s8, -118(t0) #end load_store_instr_stream_0
8030:             rem          a3, a2, s2
8031:             ori          t2, t0, -445
8032:             auipc        s3, 438206
8033:             or           s9, s8, t2
8034:             andi         s7, t6, -88
8035:             remu         s11, t2, t4
8036:             nop
8037:             div          s7, a0, ra
8038:             srl          a5, t6, s6
8039:             mulhsu       s6, t2, tp
8040:             sltu         s4, t2, t3
8041:             sll          s4, a5, a7
8042:             bne          a6, s1, 8060f
8043:             srli         s7, s1, 9
8044:             andi         t5, ra, 1291
8045:             and          s7, sp, a3
8046:             sll          s6, ra, s9
8047:             srai         t5, a3, 26
8048:             nop
8049:             mulhu        s4, s5, a4
8050:             csrrw        gp, 0x301, t1
8051:             div          ra, gp, s7
8052:             csrrw        t4, 0x301, tp
8053:             auipc        t3, 323905
8054:             sub          s0, t4, tp
8055:             slti         t0, a1, 1310
8056:             auipc        zero, 597702
8057:             beq          a0, t3, 8077f
8058:             auipc        s9, 657788
8059:             lui          a4, 574458
8060:             bne          a5, t6, 8077f
8061:             csrrw        s3, 0x301, a4
8062:             xor          s1, a4, tp
8063:             srai         s3, sp, 16
8064:             div          t1, s0, a6
8065:             divu         a1, t6, sp
8066:             nop
8067:             ori          a5, a2, 797
8068:             or           s11, gp, t4
8069:             csrrwi       s4, 0x301, 10
8070:             mul          s3, zero, ra
8071:             or           a2, gp, s7
8072:             remu         ra, s11, s9
8073:             mulhsu       t1, s9, sp
8074:             bltu         a6, s6, 8075f
8075:             sltu         a4, gp, t3
8076:             csrrc        t2, 0x300, zero
8077:             bgeu         t2, a5, 8078f
8078:             bge          tp, s4, 8087f
8079:             or           zero, t6, ra
8080:             blt          a7, t6, 8084f
8081:             csrrwi       s1, 0x301, 12
8082:             csrrci       s8, 0x305, 0
8083:             xor          a5, a5, s7
8084:             srli         a7, s6, 9
8085:             xor          a6, a6, t5
8086:             or           s11, a1, s0
8087:             slli         s3, sp, 31
8088:             csrrw        gp, 0x304, s11
8089:             sltu         s3, t4, s3
8090:             csrrs        a4, 0x304, s3
8091:             csrrsi       t1, 0x300, 0
8092:             bge          t2, s10, 8112f
8093:             csrrc        s11, 0x342, a0
8094:             nop
8095:             add          s8, ra, tp
8096:             nop
8097:             mulh         s6, s7, zero
8098:             beq          tp, t3, 8107f
8099:             rem          s2, a2, t0
8100:             csrrsi       s3, 0x301, 18
8101:             blt          s1, s0, 8118f
8102:             bge          a5, s2, 8112f
8103:             bne          t6, s7, 8116f
8104:             xori         gp, s3, 827
8105:             bne          s11, t5, 8107f
8106:             nop
8107:             auipc        t1, 186805
8108:             xor          s0, tp, a7
8109:             or           t3, s0, t6
8110:             mul          t1, s11, t1
8111:             sltu         a3, ra, a5
8112:             lui          ra, 989902
8113:             slt          a6, t4, a7
8114:             auipc        zero, 81903
8115:             sltiu        t2, t0, 861
8116:             bge          t4, zero, 8136f
8117:             mulh         s6, s0, t0
8118:             csrrci       s5, 0x344, 9
8119:             bgeu         a4, zero, 8129f
8120:             srai         a7, a2, 15
8121:             auipc        s8, 185478
8122:             sltu         s5, a7, t2
8123:             rem          s1, s8, tp
8124:             sra          t0, ra, gp
8125:             div          s0, s1, s7
8126:             csrrsi       a3, 0x342, 0
8127:             auipc        s9, 432340
8128:             or           t3, a4, s1
8129:             lui          t2, 111719
8130:             slli         t0, a7, 12
8131:             bltu         s3, s5, 8147f
8132:             csrrc        a6, 0x300, zero
8133:             csrrsi       ra, 0x343, 0
8134:             and          s11, t3, t3
8135:             sra          a4, s1, s1
8136:             beq          t3, s3, 8152f
8137:             srli         t6, t2, 11
8138:             add          s4, s2, t4
8139:             srli         s6, s2, 25
8140:             divu         a7, s6, t2
8141:             slti         t2, t6, 83
8142:             xor          ra, gp, gp
8143:             mulh         zero, s10, t3
8144:             slt          gp, t1, t6
8145:             rem          t0, a5, sp
8146:             bgeu         t4, a2, 8164f
8147:             remu         t4, t5, s3
8148:             mul          t6, a5, t3
8149:             slti         t3, s9, -117
8150:             csrrwi       s7, 0x304, 10
8151:             bltu         s11, a3, 8153f
8152:             csrrc        t4, 0x304, s1
8153:             div          a2, t1, s0
8154:             add          ra, t3, s2
8155:             srai         a2, t2, 18
8156:             bltu         t6, s9, 8157f
8157:             csrrs        a3, 0x305, zero
8158:             srl          ra, a6, t4
8159:             csrrci       zero, 0x344, 0
8160:             csrrs        s9, 0x343, s10
8161:             bne          a5, s0, 8172f
8162:             beq          s3, s8, 8182f
8163:             divu         a1, a7, s9
8164:             slli         zero, a1, 24
8165:             blt          a5, a3, 8172f
8166:             auipc        a4, 825241
8167:             csrrsi       s1, 0x301, 12
8168:             csrrs        s8, 0x301, s7
8169:             csrrci       t0, 0x305, 0
8170:             csrrsi       t3, 0x343, 9
8171:             csrrw        s6, 0x344, sp
8172:             srl          t1, t0, t5
8173:             bgeu         t2, t4, 8175f
                  la           s11, region_0+108 #start riscv_hazard_instr_stream_12
                  auipc        s10, 297157
                  sb           s10, 215(s11)
                  lbu          s6, 750(s11)
                  sb           a4, 1122(s11)
                  sb           t0, 550(s11)
                  sb           s6, 509(s11)
                  csrrs        t0, 0x342, s10
                  slti         a1, a1, 1612
                  lb           a4, -56(s11)
                  sltu         a2, a2, a4
                  srai         a1, a4, 29
                  sb           t0, 1151(s11)
                  auipc        s6, 794672
                  csrrs        a4, 0x342, s6
                  lh           t0, 1404(s11)
                  sh           s6, 1266(s11)
                  sll          s6, a1, t0
                  nop
                  sb           a1, 869(s11)
                  mulhsu       t0, s6, a1
                  sra          t0, a1, s10
                  lbu          t0, 610(s11)
                  sh           s6, 1332(s11)
                  lh           s10, 1666(s11)
                  lb           a2, 275(s11)
                  or           s6, a4, a2
                  sll          s10, s10, a2
                  sltu         a4, a1, a4
                  sltiu        s6, s10, 470
                  sltu         a4, s10, s10
                  rem          s10, a1, a1
                  sb           a2, 315(s11) #end riscv_hazard_instr_stream_12
8174:             bge          s0, tp, 8175f
8175:             slt          s1, t6, a2
8176:             rem          a5, t3, t0
8177:             csrrw        s10, 0x344, s11                
                  mulhsu       t0, s6, a1
                  sra          t0, a1, s10
                  lbu          t0, 610(s11)
                  sh           s6, 1332(s11)
                  lh           s10, 1666(s11)
                  lb           a2, 275(s11)
                  or           s6, a4, a2
                  sll          s10, s10, a2
                  sltu         a4, a1, a4
                  sltiu        s6, s10, 470
8178:             csrrc        s0, 0x344, zero
8179:             auipc        ra, 339622
8180:             and          ra, gp, a3
8181:             bgeu         s1, t0, 8190f
8182:             slt          a3, sp, t5
8183:             slli         s3, t3, 21
                  la           s6, region_1+52521 #start load_store_instr_stream_0
                  lbu          s2, 53(s6)
                  lb           s9, 60(s6)
                  la           s1, region_1+59620 #start load_store_instr_stream_1
                  lbu          a3, 22(s6)
                  sh           a5, -53(s6)
                  lbu          t4, -1555(s1)
                  lb           t1, -49(s6)
                  sh           a2, -1088(s1)
                  lh           s11, -18(s1)
                  lb           ra, -52(s6)
                  lbu          gp, 1305(s1)
                  sb           a3, 22(s6)
                  lb           t0, -710(s1)
                  lb           t6, -1417(s1) #end load_store_instr_stream_1
                  lb           t4, 64(s6) #end load_store_instr_stream_0
8184:             or           t1, s0, s4
8185:             srli         t1, s3, 23
8186:             sltu         s10, sp, s11
8187:             csrrwi       s8, 0x344, 4
8188:             sub          a3, s11, a3
8189:             remu         a7, s4, a5
8190:             divu         s3, s11, a5
8191:             and          a7, s3, sp
8192:             nop
8193:             lui          a1, 700694
8194:             mulhu        a4, a6, a3
8195:             auipc        ra, 945368
8196:             mulh         zero, s11, tp
8197:             addi         s8, s10, 221
8198:             srl          gp, gp, s8
8199:             add          t0, s3, s10
8200:             divu         t5, s3, gp
8201:             csrrwi       t0, 0x304, 31
8202:             csrrc        s0, 0x300, zero
8203:             srl          s2, t4, a0
8204:             csrrc        t1, 0x300, zero
8205:             div          t3, a4, a7
8206:             divu         t5, s6, a7
8207:             and          zero, t6, t0
8208:             slli         a4, zero, 26
8209:             slli         t0, ra, 23
8210:             beq          sp, s5, 8227f
8211:             or           t0, gp, s5
8212:             mulhsu       a6, a3, a6
8213:             bltu         s5, s11, 8230f
8214:             csrrc        t1, 0x305, zero
8215:             mulhu        s11, sp, s11
8216:             bgeu         s1, t1, 8225f
8217:             mulh         s10, s6, s11
8218:             beq          a6, ra, 8231f
8219:             csrrc        s10, 0x300, zero
8220:             auipc        s10, 568898
8221:             divu         t6, s4, s11
8222:             bltu         s4, t6, 8226f
8223:             slli         s6, s2, 18
8224:             bltu         a5, zero, 8233f
8225:             csrrs        t2, 0x300, zero
8226:             remu         a5, t2, s9
8227:             xori         a5, s6, -1333
8228:             mulhu        s11, a2, s2
8229:             csrrci       s6, 0x342, 0
8230:             bge          a6, t5, 8231f
8231:             mulh         s2, a6, s7
8232:             sltu         s4, s9, t4
8233:             bgeu         a1, s8, 8235f
8234:             csrrs        s5, 0x344, zero
8235:             srl          s10, s5, t0
8236:             bne          a1, a7, 8238f
8237:             add          a1, a2, s10
8238:             div          a3, s6, a1
8239:             mulh         a1, sp, a2
8240:             auipc        s5, 83927
8241:             remu         t1, t3, a3
8242:             and          a1, s7, a4
8243:             sltu         s6, s1, a2
8244:             rem          gp, a0, s2
8245:             andi         a3, s9, -1313
8246:             and          s3, s9, a5
8247:             srai         s7, a5, 4
8248:             div          s8, a1, t2
8249:             ori          a5, s8, -1593
8250:             slti         ra, ra, 1697
8251:             nop
8252:             div          s5, a0, s0
8253:             lui          t6, 480404
8254:             xori         t5, a6, -1793
8255:             csrrwi       s9, 0x342, 5
8256:             ori          s6, zero, 1978
8257:             or           a6, s3, a1
8258:             beq          t1, s6, 8276f
8259:             bgeu         s6, t0, 8279f
8260:             sra          s0, s10, a4
8261:             auipc        t5, 1043923
8262:             srli         s1, s1, 27
8263:             bge          s3, s1, 8281f
8264:             bgeu         s10, t5, 8280f
8265:             csrrwi       a5, 0x343, 30
8266:             bltu         s3, a0, 8271f
8267:             csrrw        t0, 0x344, sp
8268:             divu         a3, a0, s6
8269:             mul          s5, s6, s5
8270:             blt          t4, t4, 8290f
8271:             bge          t4, zero, 8275f
8272:             nop
8273:             xor          s8, s9, gp
8274:             bgeu         t3, a7, 8292f
8275:             srli         zero, t2, 8
8276:             sll          s7, s8, t6
8277:             csrrwi       s1, 0x301, 18
8278:             andi         s2, a1, 1301
8279:             csrrci       s10, 0x342, 4
8280:             csrrw        a5, 0x342, s2
8281:             lui          s11, 964392
8282:             remu         a4, s1, t1
8283:             xor          a3, s4, s1
8284:             mulhu        s5, t1, s5
8285:             nop
8286:             csrrsi       a4, 0x342, 0
8287:             sltu         a2, t3, s1
8288:             div          t6, t5, s3
8289:             srl          t6, s11, a3
8290:             slti         ra, t6, 2032
8291:             csrrc        zero, 0x344, zero
8292:             remu         a2, a0, s9
8293:             sub          s7, t5, t1
8294:             auipc        gp, 69327
8295:             sra          a5, s8, t1
8296:             blt          a6, t0, 8306f
8297:             csrrsi       a5, 0x344, 0
                  la           s4, region_1+8426 #start riscv_hazard_instr_stream_8
                  sh           s8, 1740(s4)
                  csrrsi       s10, 0x304, 0
                  csrrw        t2, 0x304, s2
                  sub          a4, s2, a4
                  sw           s2, -766(s4)
                  csrrw        a4, 0x343, a5
                  sub          s8, a4, a4
                  sb           t2, 1140(s4)
                  nop
                  slti         a5, s8, -1970
                  mulh         a5, a4, s2
                  srai         a5, a5, 20
                  sll          a5, s2, s2
                  srai         s10, s10, 15
                  xor          s8, a5, s8
                  andi         s10, s2, 936
                  srai         a5, a5, 17
                  csrrwi       a4, 0x342, 0
                  csrrs        t2, 0x342, s8
                  mulh         t2, a4, s2
                  sw           a4, 546(s4)
                  addi         s8, s10, 1989
                  sb           s8, -1382(s4)
                  lbu          s2, 1300(s4)
                  lb           a4, -797(s4)
                  xor          s8, a5, a4
                  sb           s8, 1347(s4)
                  andi         s2, s8, -1230
                  slt          s2, a4, s10
                  csrrwi       s2, 0x344, 23
                  csrrw        s10, 0x304, t2
                  ori          a4, s8, -413
                  sll          a4, a4, s10
                  ori          s2, t2, 1547
                  sub          a5, s10, t2
                  sb           s10, 1521(s4)
                  csrrw        s2, 0x344, s8
                  csrrs        a5, 0x301, s2
                  lbu          a4, -1037(s4) #end riscv_hazard_instr_stream_8
8298:             mulhsu       s1, gp, a3
8299:             add          s9, s7, a2
8300:             lui          s11, 256940
8301:             srai         s2, s3, 8
8302:             beq          t2, a1, 8319f
8303:             mulh         s9, a6, tp
8304:             mulhsu       s5, t4, a1
8305:             remu         s7, t2, a4
8306:             addi         s4, s6, 1865
8307:             andi         s3, a3, -194
8308:             add          t1, t5, s3
8309:             slt          s11, s11, a6
8310:             mulhsu       a6, a2, s6
8311:             mulhsu       ra, t1, t2
8312:             slti         t1, t2, -1378
8313:             lui          ra, 727055
8314:             beq          t1, t5, 8332f
8315:             divu         t2, s1, s8
8316:             bne          s3, t0, 8334f
8317:             csrrci       s2, 0x301, 6
8318:             slt          s4, t6, a2
8319:             mulhu        t0, s2, a3
8320:             bne          a2, a0, 8322f
8321:             csrrw        a2, 0x304, a3
8322:             blt          s1, s6, 8331f
8323:             sll          t2, t4, s0
8324:             csrrc        zero, 0x305, zero
8325:             sltiu        s10, s0, -653
8326:             nop
8327:             mul          s3, a1, s4
8328:             addi         s4, s6, -864
8329:             bne          tp, t6, 8330f
8330:             csrrw        s3, 0x343, a7
8331:             beq          s5, zero, 8336f
8332:             mulhu        s5, ra, s9
8333:             nop
8334:             divu         s2, a4, a3
8335:             xori         t5, a3, 1321
8336:             srl          t3, a7, s5
8337:             mul          s9, a2, a2
8338:             lui          s11, 410543
8339:             and          s2, a0, t2
8340:             csrrwi       s5, 0x304, 13
8341:             or           a6, gp, s4
8342:             sltu         s3, s7, gp               
                  mulhu        s5, ra, s9
                  nop
                  divu         s2, a4, a3
                  xori         t5, a3, 1321
                  srl          t3, a7, s5
                  mul          s9, a2, a2
                  lui          s11, 410543
                  and          s2, a0, t2

8343:             csrrw        a4, 0x344, sp
8344:             bltu         gp, s8, 8357f
main_94:          jal          ra, 5f
0:                jal          s3, 9f
1:                jal          gp, 7f
2:                jal          ra, 3f
3:                jal          t1, 0b
4:                jal          t0, 10f
5:                jal          gp, 6f
6:                jal          t1, 8f
7:                jal          t1, 4b
8:                jal          s8, 2b
9:                jal          ra, 1b
10:               addi         s0, s4, 218
8345:             xor          a2, a6, t5
8346:             divu         t6, s7, s0
8347:             csrrwi       t4, 0x301, 11
8348:             ori          s1, s11, -1100
8349:             bge          s8, ra, 8350f
8350:             blt          s7, s6, 8370f
8351:             andi         s8, s10, -900
8352:             remu         t1, s3, s10
8353:             csrrsi       s4, 0x344, 0
8354:             sub          a2, a6, t2
8355:             xori         s11, ra, 1151
8356:             andi         s6, s5, 260
8357:             xor          a2, a6, t5
                  divu         t6, s7, s0
                  andi         s8, s10, -900
                  remu         t1, s3, s10
                  sub          a2, a6, t2
                  xori         s11, ra, 1151
                  andi         s6, s5, 260
                  csrrc        s9, 0x344, t1
8358:             mul          a5, t6, a0
8359:             bgeu         s7, s4, 8368f
8360:             sltiu        ra, t2, 14
8361:             and          gp, s10, tp
8362:             bltu         tp, gp, 8364f
8363:             csrrw        t4, 0x344, s1
8364:             csrrc        s4, 0x305, zero
8365:             nop
8366:             sltu         s2, s8, s0
8367:             divu         t4, s8, s1
8368:             sltiu        t2, a5, 579
8369:             auipc        s1, 898662
8370:             auipc        s2, 1009022
8371:             sub          s8, s1, t0
8372:             csrrwi       a3, 0x343, 11
8373:             srli         s4, a4, 30
8374:             srl          a4, tp, s4
8375:             srai         a5, a7, 30
8376:             sltiu        s2, s9, 139
8377:             slt          s1, sp, a7
8378:             beq          s1, s4, 8395f
8379:             csrrw        a2, 0x301, a5
8380:             srai         s5, ra, 16
8381:             sub          s6, s9, zero
8382:             div          t3, tp, s5
8383:             and          s7, s10, tp
8384:             and          zero, t6, zero
8385:             div          a4, t3, t5
8386:             rem          t2, s0, s1
8387:             srl          s7, t5, a4
8388:             add          t1, s8, a0
8389:             lui          t3, 368698
8390:             auipc        t6, 294986
8391:             csrrsi       gp, 0x343, 12
8392:             auipc        a7, 838808
8393:             sub          s5, t6, a3
8394:             rem          t6, s0, a3
8395:             xori         zero, a3, 1746
8396:             beq          tp, s10, 8412f
8397:             sltu         a5, s2, t5
8398:             csrrs        s10, 0x342, zero
8399:             mulhsu       t1, s1, a0
8400:             addi         s7, s10, -535
8401:             sltiu        t2, a6, 1487
8402:             mulhu        a6, a4, t3
8403:             slti         a1, tp, 1377
8404:             xori         a2, s1, 971
8405:             xor          a4, s10, s0
8406:             bgeu         t6, sp, 8407f
8407:             bltu         a1, s4, 8427f
8408:             xori         ra, t2, -1756
8409:             andi         s3, a4, 1561
8410:             mul          s11, s4, s11
8411:             add          t3, a2, t1
8412:             slti         s5, zero, -1875
8413:             or           a6, t0, s0
8414:             csrrs        t2, 0x343, zero
8415:             addi         s3, t2, -816
8416:             blt          s5, s5, 8425f
8417:             and          t6, s2, a7
8418:             auipc        s3, 814269
8419:             addi         s8, a4, 180
8420:             xori         t2, gp, -1753
8421:             andi         a3, t4, 781
8422:             csrrci       s11, 0x305, 0
8423:             add          s0, a4, s0
8424:             remu         t1, sp, t3
8425:             sll          s5, a4, a2
8426:             andi         a3, a1, -1978
8427:             csrrc        a4, 0x343, zero
8428:             addi         t3, s3, -496
8429:             csrrwi       s0, 0x304, 10
8430:             csrrci       s11, 0x300, 0
8431:             or           s7, s6, zero
8432:             nop
8433:             bge          sp, a6, 8435f
8434:             auipc        t5, 460779
8435:             bne          gp, s0, 8442f
8436:             srai         s1, s2, 16
8437:             rem          a5, a0, t6
8438:             sltu         s3, a0, s0
8439:             divu         a7, zero, s5
8440:             lui          a4, 753846
8441:             mulhu        s7, a4, ra
8442:             sra          s1, gp, sp
8443:             mulh         a3, t6, a1
8444:             sll          t4, t4, s0
8445:             csrrsi       t2, 0x301, 25
8446:             blt          s6, a6, 8462f
8447:             sltu         a1, gp, s11
8448:             csrrci       a1, 0x342, 0
8449:             mulhu        s4, s8, s2
8450:             sltu         t5, s4, s11
8451:             beq          s0, s2, 8471f
8452:             remu         a7, sp, s11
8453:             andi         a4, a5, 1362
8454:             nop
                  addi         a3, zero, 4 #init loop 0 counter
                  nop
                  addi         t3, zero, 16 #init loop 0 limit
                  srli         s10, t0, 13
main_218_0_t:     nop
                  addi         a3, a3, 6 #update loop 0 counter
                  bltu         a3, t3, main_218_0_t #branch for loop 0
                  sltiu        zero, s1, -1262
8455:             mul          s0, a6, s3
8456:             divu         a7, s10, s11
8457:             csrrw        a1, 0x342, s5
8458:             csrrwi       gp, 0x304, 0
8459:             sltu         s9, a5, s2
8460:             xori         a2, a5, 1498
8461:             xor          a2, a1, a1
8462:             and          s11, s10, t3
8463:             lui          t5, 901885
8464:             add          s11, a6, a5
8465:             csrrs        a3, 0x300, zero
8466:             sra          a7, t2, s0
8467:             mul          a5, s11, t6
8468:             sll          s11, s6, s8
8469:             slli         a2, s1, 31
8470:             slli         zero, s1, 6
8471:             add          a1, ra, s10
8472:             mulh         t1, tp, a4
8473:             csrrw        s8, 0x301, a1
8474:             and          a4, s9, a5
8475:             blt          a5, s8, 8495f
8476:             sra          ra, t1, t4
8477:             csrrsi       t2, 0x301, 27
8478:             slli         t2, t6, 7
8479:             and          gp, zero, s10
8480:             srl          gp, sp, s5
8481:             csrrci       a4, 0x342, 0
8482:             sll          a3, t0, a6
8483:             slli         a4, s9, 25
8484:             rem          a1, a1, t4
8485:             csrrw        a6, 0x301, s3
8486:             add          gp, s5, t3
8487:             addi         s11, gp, -1468
8488:             mulhsu       s4, a4, ra
8489:             bltu         t5, a5, 8505f
8490:             csrrci       t4, 0x300, 0
8491:             add          a1, a3, s0
8492:             sll          s4, a2, tp
8493:             csrrsi       a6, 0x343, 15
8494:             sltu         t5, t1, tp
8495:             lui          a3, 1012541
8496:             slti         zero, t2, 1731
8497:             andi         s2, s9, 179
8498:             sll          s9, s6, t6
8499:             sltiu        t6, t4, 26
8500:             ori          gp, s1, -1019
8501:             addi         s10, a3, -1418
8502:             mul          s5, s3, s9
8503:             remu         s9, s3, a4
8504:             bgeu         s9, tp, 8515f
8505:             csrrc        s8, 0x305, zero
8506:             sll          t4, a1, s5
8507:             sltiu        s1, s9, -1072
8508:             csrrw        t0, 0x304, t1
8509:             bgeu         gp, t1, 8511f
8510:             csrrci       a5, 0x301, 29
8511:             xor          s4, gp, t0
8512:             mulhu        a3, a7, s7
8513:             mulhu        s6, s10, t6
8514:             lui          t6, 497370
8515:             mulhsu       t5, gp, t1
8516:             csrrs        gp, 0x342, t4
8517:             csrrwi       s11, 0x304, 24
8518:             mulhu        s8, a2, t2
8519:             slti         t3, s2, -1971
8520:             sub          a7, ra, a5
8521:             csrrs        s5, 0x344, zero
8522:             beq          s10, t0, 8524f
8523:             bgeu         s4, a3, 8536f
8524:             srl          gp, t4, s3
8525:             or           s4, a2, t2
8526:             remu         t0, a3, sp
8527:             divu         t2, s9, s8
8528:             or           t5, t6, t3
8529:             slti         a4, zero, 508
8530:             mulhu        t4, a1, s5
8531:             andi         s1, s10, -257
8532:             slli         s4, s7, 28
8533:             csrrs        a6, 0x304, zero
8534:             xori         gp, s2, -741
8535:             bge          a4, s9, 8546f
8536:             xor          a4, a4, s8
8537:             srl          a1, gp, t5
8538:             remu         t4, t3, zero
8539:             csrrc        a3, 0x304, s7
8540:             csrrw        ra, 0x301, t5
8541:             and          s6, a7, sp
8542:             rem          t0, t2, a5
8543:             bgeu         a4, tp, 8552f
8544:             nop
8545:             divu         gp, zero, a0
8546:             or           s7, a5, a3
8547:             rem          t3, a4, sp
8548:             srai         t1, t4, 21
8549:             bgeu         gp, a5, 8553f
8550:             srli         a5, tp, 10
8551:             sub          t1, s9, s4
8552:             csrrs        s8, 0x301, s4
8553:             addi         a7, s7, 350
                  la           ra, region_0+2041 #start riscv_load_store_hazard_instr_stream_5
                  lbu          a1, 335(ra)
                  lh           s1, -851(ra)
                  lbu          t5, 418(ra)
                  remu         s9, a3, gp
                  sb           t5, 1396(ra)
                  lb           a1, -1630(ra)
                  lhu          a4, -1419(ra)
                  sb           a5, -1811(ra)
                  sb           s1, -1811(ra)
                  lbu          s11, -1126(ra)
                  lbu          a7, -1790(ra)
                  lbu          a1, 1150(ra)
                  sub          s2, a0, s11
                  sb           a3, -792(ra)
                  sb           s2, -792(ra)
                  lb           t4, 1954(ra)
                  sb           a2, -666(ra)
                  sh           a1, 705(ra)
                  lb           a2, -1318(ra) #end riscv_load_store_hazard_instr_stream_5
8554:             mulhsu       a4, t3, t1
8555:             csrrc        s0, 0x343, t5
8556:             lui          s10, 399141
8557:             srli         s3, a0, 31
8558:             blt          a7, s2, 8576f
8559:             add          t5, t6, t0
8560:             and          s6, t6, s9
8561:             xori         a1, t1, -1078
8562:             remu         s0, s8, t2
8563:             bne          t5, s5, 8565f
8564:             sub          t2, a4, t0
8565:             csrrc        s10, 0x304, zero
8566:             slt          a4, s2, t2
8567:             sra          s9, a6, t3
8568:             andi         s2, t5, -1678
8569:             div          s4, s1, tp
8570:             mulhu        s0, s4, gp
8571:             ori          s1, s10, -774
8572:             xori         s2, s2, 937
8573:             add          a4, a5, s2
8574:             srli         s7, a1, 13
8575:             and          s1, s2, s4
8576:             addi         a5, a2, 204
8577:             remu         a5, a2, s2
8578:             nop
8579:             and          t0, a1, s0
8580:             csrrs        s9, 0x342, zero
8581:             remu         a1, t6, s6
8582:             and          s3, s11, s7
8583:             xori         t2, a2, -1366
8584:             csrrc        zero, 0x300, zero
8585:             remu         s1, t2, a6
8586:             lui          t0, 672983
8587:             bgeu         tp, s0, 8607f
8588:             csrrci       t2, 0x342, 5
8589:             sll          s0, a7, s11
8590:             xori         s10, s3, -1034
8591:             bne          a5, t0, 8593f
8592:             slli         a2, t2, 6
8593:             blt          a4, s0, 8595f
8594:             slti         a5, a5, 1490
8595:             mul          ra, s6, zero
8596:             add          s8, t5, s6
8597:             csrrs        gp, 0x300, zero
8598:             or           t1, a4, a7
8599:             slti         s9, s7, -1993
8600:             bgeu         s1, t1, 8605f
8601:             ori          t5, t2, -981
8602:             csrrs        gp, 0x301, s0
8603:             csrrsi       a5, 0x342, 0
8604:             remu         s11, t2, s8
8605:             mulh         a2, a6, a5
8606:             beq          s11, a1, 8623f
8607:             csrrs        s2, 0x344, zero
8608:             rem          s6, a2, s7
8609:             rem          a1, s0, t3
8610:             divu         s11, a5, s3
8611:             sltu         s11, t0, t5
8612:             blt          s0, s10, 8621f
8613:             bltu         s4, a2, 8614f
8614:             blt          tp, t2, 8616f
8615:             addi         s7, a2, -1259
8616:             sltu         s9, t3, a3
8617:             nop
8618:             csrrwi       s7, 0x344, 6
8619:             bgeu         a3, t1, 8632f
8620:             mulh         t4, s11, t6
8621:             csrrsi       s9, 0x304, 18
8622:             xor          s2, zero, s9
8623:             csrrsi       zero, 0x301, 0
8624:             srl          t0, a4, t4
8625:             bne          a6, sp, 8626f
8626:             ori          s10, s3, 123
8627:             mul          a6, s3, t5
8628:             bne          s8, s10, 8637f
8629:             bne          s5, t4, 8646f
8630:             blt          a2, s0, 8640f
8631:             srl          ra, ra, t4
8632:             div          s2, t6, s6
8633:             add          t1, s6, a0
8634:             csrrci       s5, 0x305, 0
8635:             mulh         s11, t0, s2
8636:             sra          s8, tp, a7
8637:             andi         s9, tp, -394
8638:             mulhu        a6, s3, t0
8639:             xori         s4, s7, 1690
8640:             csrrsi       s10, 0x301, 0
8641:             xori         a3, zero, -362
8642:             rem          s9, a4, a6
8643:             or           t1, a5, s10
8644:             ori          a1, zero, 1297
8645:             ori          s6, t0, 747
8646:             srai         s1, t2, 24
8647:             lui          t6, 429907
8648:             csrrci       s0, 0x301, 0
8649:             sltu         a6, t0, t3
8650:             mulhsu       a1, s9, zero
8651:             srai         t3, a5, 13
8652:             mul          s3, a2, s7
8653:             nop
8654:             csrrw        zero, 0x344, gp
8655:             csrrsi       s3, 0x301, 0
8656:             sll          s3, a3, s0
8657:             csrrsi       s6, 0x344, 16
8658:             rem          a7, a4, t1
8659:             sll          s10, tp, a3
8660:             divu         s10, t4, a2
8661:             add          a3, t5, t1
8662:             div          s5, s3, a7
8663:             addi         s9, s7, 419
8664:             srl          a1, t3, s6
8665:             mulh         s5, sp, s4
8666:             sll          t0, s9, a2
8667:             bge          s1, t4, 8687f
8668:             srai         s4, s0, 30
8669:             blt          a7, s11, 8685f
8670:             andi         t0, a6, -95
8671:             ori          a4, s1, 2015
8672:             slt          s2, s3, s4
8673:             bgeu         t6, zero, 8689f
8674:             sll          gp, s7, t5
8675:             csrrs        s9, 0x344, s10
8676:             srli         t1, a4, 0
8677:             xori         a2, s7, -1916
8678:             sub          t6, s11, t5
8679:             sll          t0, t3, zero
8680:             bge          s6, s8, 8696f
8681:             csrrc        t0, 0x300, zero
8682:             srai         a2, a7, 9
8683:             div          s6, t3, a3
8684:             csrrci       a1, 0x304, 9
8685:             addi         s5, tp, 1582
8686:             csrrs        s0, 0x305, zero
8687:             mulhsu       ra, s8, sp
8688:             csrrw        t5, 0x304, t6
8689:             ori          s0, a1, 539
8690:             srai         s10, s6, 15
8691:             xori         a6, t2, 1362
8692:             and          a3, sp, t4
8693:             beq          s1, a6, 8700f
8694:             slt          s2, zero, a3
8695:             csrrw        a6, 0x342, s5
8696:             addi         t2, t5, -1631
8697:             srl          s6, a7, tp
8698:             slt          s3, a6, s8
8699:             csrrs        a7, 0x344, zero
8700:             and          s11, a6, sp
8701:             bltu         tp, ra, 8719f
8702:             beq          t4, a5, 8715f
8703:             sub          s2, s3, t0
8704:             csrrsi       gp, 0x304, 21
8705:             mulhsu       a6, t3, t0
8706:             divu         ra, t4, s8
8707:             mul          s2, t5, s11
8708:             srli         s5, a2, 25
8709:             sltiu        a2, a3, -1639
8710:             csrrw        t4, 0x343, zero
8711:             ori          t2, t0, -1535
8712:             mul          s8, s1, s0
8713:             csrrwi       t2, 0x301, 27
8714:             mulhsu       s2, t4, a6
8715:             auipc        t1, 712836
8716:             beq          s3, s2, 8736f
8717:             csrrc        s0, 0x344, zero
8718:             xori         s4, t1, -163
8719:             sltiu        t5, s0, -1875
8720:             csrrci       t4, 0x343, 0
8721:             sra          s9, s3, gp
8722:             mulhsu       t3, s7, ra
8723:             bltu         a4, a6, 8724f
8724:             sub          s4, a0, t3
8725:             srai         a4, zero, 19
8726:             blt          s0, t3, 8728f
8727:             lui          s10, 723158
8728:             mulhsu       s4, sp, a3
8729:             bne          a5, zero, 8749f
8730:             beq          s1, s3, 8748f
8731:             slli         t5, s10, 29
8732:             xori         t1, s11, 1521
8733:             xori         s8, a2, 1079
8734:             beq          t6, a0, 8754f
8735:             sltu         t1, a0, gp
8736:             and          zero, sp, s2
8737:             slli         s7, a0, 11
8738:             div          a7, t2, a6
8739:             addi         t4, s6, 1914
8740:             rem          s4, a0, t6
8741:             andi         s4, gp, 1399
8742:             add          ra, t4, s4
8743:             mulhsu       zero, s4, t5
8744:             sltu         t3, s4, s3
8745:             mulhsu       s3, a3, zero
8746:             bgeu         t5, a1, 8762f
8747:             mulh         s7, a1, a0
8748:             mul          a2, t3, a1
8749:             mulhsu       s5, s0, s8
8750:             xor          a1, a0, a5
8751:             add          s9, a1, zero
8752:             mulhu        t6, s9, s6
8753:             csrrci       a3, 0x342, 0
8754:             or           a1, s7, s9
8755:             lui          s9, 243949
8756:             srl          s11, a1, a3
8757:             remu         a3, t1, sp
8758:             xori         t1, s9, 210
8759:             mulhsu       s5, t5, sp
8760:             srli         s7, s2, 27
8761:             auipc        t2, 189910
8762:             csrrwi       a5, 0x344, 16
8763:             sub          ra, s10, a2
8764:             remu         t3, a7, a3
8765:             csrrs        s1, 0x305, zero
8766:             mulhsu       ra, a1, s1
8767:             auipc        t2, 1006815
8768:             blt          t2, a6, 8775f
8769:             divu         s3, t1, a5
8770:             srl          a4, ra, a5
8771:             lui          t6, 20637
8772:             addi         s10, s7, -1870
8773:             slt          t1, s4, s8
8774:             bge          s4, s10, 8783f
8775:             mul          s11, s3, a4
8776:             csrrs        s1, 0x301, zero
8777:             slt          t1, s8, s0
8778:             div          s2, t0, a3
8779:             sltiu        zero, zero, -1375
8780:             beq          a7, ra, 8800f
8781:             srl          a7, s2, s1
8782:             and          s0, t5, t4
8783:             csrrw        t2, 0x343, s1
8784:             mulhsu       s8, a0, t6
8785:             divu         t0, s3, s1
8786:             lui          s3, 837295
8787:             and          t0, s6, a3
8788:             mulhu        a6, s7, s5
8789:             bgeu         gp, t0, 8806f
8790:             sltu         s1, s1, a4
8791:             csrrc        s0, 0x344, zero
8792:             rem          s9, ra, t2
8793:             xori         s0, a0, -1249
8794:             addi         t0, t5, -1204
8795:             nop
8796:             div          zero, s8, s9
8797:             ori          t0, a7, 1220
8798:             xor          s8, a0, t3
8799:             slt          a5, a5, t3
8800:             slti         t6, t5, 930
8801:             lui          s4, 701815
8802:             nop
8803:             sltu         a3, a5, a5
8804:             sra          s7, s6, t5
8805:             add          t5, s0, gp
8806:             rem          s6, t3, s5
8807:             andi         s4, s11, 788
8808:             srai         t1, s2, 12
8809:             and          t1, tp, a6
8810:             xori         a3, s6, -387
8811:             slli         s7, s8, 18
8812:             bltu         a6, a3, 8816f
8813:             or           ra, a2, s8
8814:             mul          ra, zero, s0
8815:             csrrc        s4, 0x343, t0
8816:             and          ra, ra, a0
8817:             addi         t5, sp, 2036
8818:             sltu         a5, s5, a0
8819:             nop
8820:             xori         s11, a7, 1417
8821:             srai         t3, a4, 22
8822:             bge          zero, s0, 8824f
8823:             csrrci       a7, 0x304, 3
8824:             slt          s10, t5, zero
8825:             xori         s4, a1, -337
8826:             xor          t2, a1, gp
8827:             blt          t2, s3, 8843f
8828:             csrrs        t6, 0x343, zero
8829:             ori          s5, s3, -1508
8830:             slli         a2, ra, 19
8831:             bge          a3, a6, 8849f
8832:             srl          s9, a0, t3
8833:             csrrw        a1, 0x301, s11
8834:             sltiu        s0, s9, -1374
8835:             mulhsu       s9, t0, s7
8836:             ori          s0, s8, 1827
8837:             auipc        s11, 423909
8838:             div          t6, s10, t1
8839:             div          a6, s2, t4
8840:             bge          t0, gp, 8842f
8841:             ori          a7, s3, -697
8842:             auipc        s2, 906567
8843:             bne          sp, a5, 8844f
8844:             srai         s7, a7, 12
8845:             sra          t6, t1, s6
8846:             nop
8847:             xori         s3, gp, -2016
8848:             remu         t0, t0, a7
8849:             csrrs        t2, 0x342, zero
8850:             bne          s1, t3, 8867f
8851:             and          t1, s1, s1
8852:             xori         s7, s1, 1439
8853:             sltiu        t4, s4, 349
8854:             bne          gp, t3, 8874f
8855:             slti         s4, s10, 1332
8856:             bge          s6, t2, 8876f
8857:             add          s6, t3, s3
8858:             ori          a3, s2, -1882
8859:             csrrw        ra, 0x344, s11
8860:             srl          t0, ra, s3
8861:             divu         a3, s8, s10
8862:             mulhsu       s4, a3, s1
8863:             div          s6, s1, s11
8864:             csrrsi       s3, 0x305, 0
8865:             csrrci       s11, 0x344, 25
8866:             ori          s9, a2, 1293
8867:             csrrc        s10, 0x304, t0
8868:             srai         zero, s11, 20
8869:             nop
8870:             lui          s6, 250063
8871:             remu         a5, s1, a3
8872:             xor          s6, gp, a0
8873:             srl          a6, s5, s9
8874:             mulhu        a5, a7, a4
8875:             lui          s8, 301459
8876:             csrrw        s4, 0x342, t6
8877:             and          s6, s1, t5
8878:             srai         t4, s5, 12
8879:             csrrw        t5, 0x304, t2
8880:             blt          a4, a3, 8881f
8881:             mul          gp, t4, t5
8882:             mulhu        a1, a2, a1
8883:             bge          a7, sp, 8885f
8884:             div          t0, gp, s1
8885:             remu         a6, zero, a1
8886:             blt          s0, a3, 8899f
8887:             remu         s3, zero, s4
8888:             addi         t0, a7, -344
8889:             srli         s5, a6, 17
8890:             csrrs        a6, 0x300, zero
8891:             csrrci       s4, 0x343, 15
8892:             csrrsi       t0, 0x305, 0
8893:             sub          zero, ra, s7
8894:             sltiu        a5, gp, 1106
8895:             sltu         a4, gp, zero
8896:             mulhsu       ra, a4, a5
8897:             rem          s5, t1, a3
8898:             csrrw        gp, 0x304, s5
8899:             csrrs        s11, 0x301, s10
8900:             csrrsi       t6, 0x304, 25
8901:             slti         t6, a4, 660
8902:             srli         t5, s3, 20
8903:             csrrsi       ra, 0x304, 0
8904:             csrrsi       t2, 0x300, 0
8905:             slli         t2, t3, 28
8906:             or           s0, a1, a7
8907:             add          s8, a5, a5
8908:             slli         s4, s4, 0
8909:             nop
8910:             bge          ra, sp, 8919f
8911:             bltu         s5, t0, 8912f
8912:             div          s5, t0, t2
8913:             sll          s6, t5, t6
8914:             srli         t4, a4, 17
8915:             auipc        s3, 550257
8916:             xori         s6, a4, -1330
8917:             ori          a1, a0, -931
8918:             slli         a7, s4, 19
8919:             addi         t0, sp, 82
8920:             csrrs        t5, 0x344, t5
8921:             lui          t0, 632215
8922:             rem          s6, a7, zero
8923:             blt          s4, zero, 8928f
8924:             sub          s0, s9, a5
8925:             andi         s1, gp, 1804
8926:             add          t5, t3, a4
8927:             csrrw        s10, 0x301, t0
8928:             bgeu         t2, s0, 8939f
8929:             sub          t5, s5, gp
8930:             sra          s2, s3, a7
8931:             mulhu        s4, t3, gp
8932:             csrrw        s10, 0x301, s8
8933:             div          s10, t0, a2
8934:             csrrc        s1, 0x305, zero
8935:             bltu         s7, s0, 8945f
8936:             mul          s0, s5, zero
8937:             and          a3, a3, s7
8938:             csrrs        a2, 0x305, zero
8939:             sltiu        s2, s9, 1779
8940:             srl          zero, a2, t5
8941:             csrrc        gp, 0x343, zero
8942:             csrrsi       ra, 0x343, 21
8943:             mulhu        zero, a4, s10
8944:             remu         s10, s9, t1
8945:             and          s3, t1, gp
8946:             sll          s3, t1, s1
8947:             csrrc        s10, 0x301, zero
8948:             add          s4, sp, a2
8949:             add          ra, s8, t0
8950:             lui          s11, 756514
8951:             xori         t4, s6, 1964
8952:             xor          t2, s6, s2
8953:             beq          t1, a4, 8955f
8954:             andi         t3, t4, 1316
8955:             addi         t6, t2, -1229
8956:             bltu         t1, a2, 8974f
8957:             csrrsi       s3, 0x343, 20
8958:             srli         a7, a2, 21
8959:             lui          a2, 823006
8960:             nop
8961:             csrrci       t2, 0x343, 16
8962:             auipc        a3, 205059
8963:             and          a6, t4, s3
8964:             xor          t1, t1, zero
8965:             slt          s0, t4, ra
8966:             xor          s6, t3, s10
8967:             bne          a1, zero, 8985f
8968:             sltiu        s0, s4, -830
8969:             mulh         s6, s8, s3
8970:             or           s3, a4, t3
8971:             remu         t2, s0, s2
                  la           a3, region_0+3529 #start load_store_instr_stream_0
                  lh           s2, -3(a3)
                  la           s11, region_1+38407 #start load_store_instr_stream_1
                  lb           a4, -9(s11)
                  lb           s0, 8(s11)
                  sh           s11, -9(a3)
                  lw           a1, -5(a3)
                  lh           s1, 7(s11)
                  lbu          a6, -11(a3)
                  lh           t6, 1(a3)
                  lb           s9, -15(s11)
                  lb           a2, -6(s11) #end load_store_instr_stream_1
                  lbu          a1, -16(a3) #end load_store_instr_stream_0
8972:             xori         zero, t4, -108
8973:             slt          zero, t0, s6
8974:             slli         t6, t4, 11
8975:             beq          a0, s7, 8977f
8976:             or           s2, s0, s9
8977:             slt          gp, a6, a4
8978:             csrrsi       s4, 0x300, 0
8979:             add          s4, a6, a1
8980:             srl          t0, s2, s7
8981:             csrrw        a4, 0x343, s4
8982:             sra          a5, a4, gp
8983:             slt          ra, s6, a0
8984:             andi         t0, s1, -1751
8985:             mulh         a3, s8, s1
8986:             srli         ra, a4, 2
8987:             xor          s2, s1, sp
8988:             sltu         a4, a0, ra
8989:             or           t2, s1, s10
8990:             srli         s0, t6, 28
8991:             rem          s6, t6, t5
8992:             bgeu         s6, a7, 9008f
8993:             csrrw        t6, 0x301, s1
8994:             remu         a5, s7, sp
8995:             srli         s11, s10, 5
8996:             slti         a1, t1, 891
8997:             sra          t4, a7, tp
8998:             divu         s0, a0, a7
8999:             csrrw        a4, 0x343, t0
9000:             slti         s1, t3, 947
9001:             bne          s0, t0, 9010f
9002:             bge          a6, t0, 9015f
9003:             xori         s6, sp, -472
9004:             csrrci       s2, 0x301, 0
9005:             mulh         s0, s3, t4
9006:             addi         t5, a3, -1935
9007:             rem          s0, t6, s2
9008:             auipc        a6, 661379
9009:             mulh         s4, s11, s9
9010:             and          s1, a7, gp
9011:             ori          s5, s10, 668
9012:             xor          s0, a3, s3
9013:             mul          s1, s5, s0
9014:             andi         a6, a5, 1403
9015:             mulhsu       s9, sp, s7
9016:             xori         s6, gp, 948
9017:             div          t2, ra, s11
9018:             bge          s0, s2, 9028f
9019:             csrrci       a2, 0x305, 0
9020:             and          t0, s10, zero
9021:             beq          sp, s1, 9030f
9022:             csrrsi       gp, 0x305, 0
9023:             bne          tp, s2, 9043f
9024:             sltiu        s4, zero, 39
9025:             xor          s11, a7, s1
9026:             divu         t2, a0, s6
9027:             sltiu        t3, a7, -2027
9028:             mulhsu       s3, a6, s9
9029:             sra          s7, s8, a2
9030:             mulhsu       a7, s3, a1
9031:             sll          s7, s8, tp
9032:             mul          zero, t5, s1
9033:             slli         s2, a4, 4
9034:             slt          zero, sp, s6
9035:             xor          t3, t0, a5
9036:             mulhu        s3, a6, a5
9037:             srli         t0, t1, 20
9038:             mul          s6, t3, t4
9039:             div          a6, a1, s7
9040:             bge          gp, s9, 9053f
9041:             bne          tp, s10, 9045f
9042:             slli         s4, s2, 13
9043:             rem          t2, a2, s8
9044:             blt          t5, t0, 9060f
9045:             slt          a1, sp, tp
9046:             csrrw        t3, 0x304, s1
9047:             srl          zero, s11, a6
9048:             sll          s2, s8, s6
9049:             csrrs        s3, 0x301, s2
9050:             or           t2, a5, s0
9051:             rem          t5, s7, t1
9052:             andi         a5, a0, -870
9053:             csrrsi       s5, 0x304, 0
9054:             srl          s10, s0, a2
9055:             or           s2, a5, a1
9056:             nop
9057:             auipc        a4, 920734
9058:             beq          sp, t3, 9067f
9059:             mulh         zero, a3, s10
9060:             sltiu        s9, a3, 1840
9061:             bge          t1, s9, 9072f
9062:             and          a4, s3, s7
9063:             or           a1, a3, s4
9064:             addi         a2, a6, 554
9065:             csrrsi       t0, 0x343, 13
9066:             srai         s11, gp, 4
9067:             mulhsu       s10, s1, s9
9068:             andi         gp, zero, -82
9069:             slti         a1, s3, -236
9070:             sltu         s2, t1, s2
9071:             csrrw        t6, 0x343, s1
9072:             slti         t6, s5, -1425
9073:             slli         t4, tp, 17
9074:             csrrsi       t4, 0x301, 19
9075:             srl          s3, s3, t5
9076:             bgeu         t6, s10, 9092f
9077:             and          t4, gp, s6
9078:             bge          t2, s2, 9095f
9079:             andi         s11, a5, 765
9080:             sltu         s11, a2, s4
9081:             sub          s2, s6, t5
9082:             sub          a4, a6, s9
9083:             csrrc        a5, 0x305, zero
9084:             csrrw        t4, 0x343, t2
9085:             andi         s0, s3, 322
9086:             sra          zero, s9, tp
9087:             or           t4, s2, zero
9088:             srai         a4, t4, 19
9089:             sltu         ra, s4, s5
9090:             remu         t0, s10, s5
9091:             blt          t5, t6, 9109f
9092:             remu         a1, s8, s4
9093:             bgeu         zero, sp, 9106f
9094:             csrrs        a6, 0x344, zero
9095:             divu         s4, s3, s9
9096:             andi         s7, t2, 1223
9097:             csrrsi       a3, 0x344, 30
9098:             mulhu        s3, s8, s10
9099:             csrrsi       s9, 0x304, 0
9100:             srl          s4, t4, t6
9101:             blt          s8, t1, 9121f
9102:             lui          t5, 520064
9103:             bltu         zero, a4, 9121f
9104:             sltu         t5, t6, t4
9105:             sub          a2, s0, s6
9106:             nop
9107:             mulh         t6, s11, t4
9108:             and          s6, s6, a6
9109:             srli         a6, t1, 17
9110:             nop
9111:             csrrsi       s7, 0x300, 0
9112:             srli         a5, zero, 0
9113:             csrrc        s9, 0x344, s11
9114:             bgeu         s11, s5, 9134f
9115:             bltu         t3, s1, 9117f
9116:             add          s4, s6, ra
9117:             csrrci       a5, 0x304, 0
9118:             csrrwi       s10, 0x343, 30
9119:             xor          a6, s1, t6
9120:             xor          s1, s9, t4
9121:             divu         t3, a1, zero
9122:             xor          s10, t1, a4
9123:             sll          a3, gp, t0
9124:             div          t2, t1, a4
9125:             csrrci       s10, 0x300, 0
9126:             srai         t0, a6, 20
9127:             xor          t1, s5, t6
9128:             add          s4, t0, t4
9129:             bgeu         t6, t3, 9138f
9130:             csrrs        a7, 0x344, s8
9131:             blt          a2, t1, 9136f
9132:             auipc        s10, 606372
9133:             nop
9134:             sltu         s3, tp, a4
9135:             lui          gp, 783309
9136:             sra          gp, a6, s7
9137:             lui          t4, 59795
9138:             mulhu        s0, a7, a6
9139:             srl          t5, t0, a1
9140:             and          t4, s5, s2
9141:             divu         a6, a3, s5
9142:             srai         s7, a3, 10
9143:             remu         ra, a5, s6
9144:             slti         t2, gp, -413
9145:             mulhu        s7, s5, zero
9146:             csrrw        s4, 0x344, s0
9147:             addi         t2, s3, 829
9148:             lui          a6, 841295
9149:             csrrci       t1, 0x342, 16
9150:             xor          a4, a0, t4
9151:             sra          s8, sp, sp
9152:             csrrci       s9, 0x301, 0
9153:             sll          a7, t1, s0
9154:             bge          s4, t5, 9155f
9155:             sub          gp, sp, s10
9156:             bne          tp, t4, 9158f
9157:             srl          s3, zero, a0
9158:             slli         s5, t6, 3
9159:             bne          a4, tp, 9160f
9160:             csrrsi       gp, 0x301, 10
9161:             srli         s3, s9, 19
9162:             csrrs        zero, 0x304, zero
9163:             bge          s8, zero, 9165f
9164:             nop
9165:             bge          t4, gp, 9183f
9166:             csrrwi       t1, 0x344, 31
9167:             blt          s3, a0, 9184f
9168:             srli         s10, s7, 14
9169:             srl          s1, s4, a1
9170:             bge          gp, t4, 9172f
9171:             mulhsu       s4, s1, s1
9172:             andi         a5, a5, 90
9173:             srli         t6, gp, 18
9174:             andi         a1, s9, 1525
9175:             csrrwi       t0, 0x343, 7
9176:             remu         a6, a0, s3
9177:             csrrsi       s3, 0x305, 0
9178:             mulhsu       a7, t0, s7
9179:             slti         a6, s9, -1496
9180:             auipc        s0, 133490
9181:             csrrs        t6, 0x343, zero
9182:             bge          sp, s9, 9198f
9183:             sra          a1, a7, s3
9184:             ori          s4, s1, -1377
9185:             bgeu         t5, a3, 9186f
9186:             slli         s2, t4, 8
9187:             lui          a7, 377955
9188:             sll          s0, s10, ra
9189:             csrrc        t3, 0x304, s8
9190:             csrrw        a4, 0x301, s11
9191:             slli         t0, a7, 15
9192:             csrrsi       a5, 0x342, 30
9193:             bgeu         s6, s7, 9195f
9194:             andi         s2, a2, 717
9195:             csrrs        t6, 0x300, zero
9196:             sra          s11, sp, a2
9197:             mulhu        s10, gp, a7
9198:             csrrw        a7, 0x342, t0
9199:             lui          s9, 103339
9200:             div          t0, s8, s0
9201:             csrrc        ra, 0x304, sp
9202:             srli         s7, a1, 2
9203:             rem          ra, s6, s1
9204:             mulh         s8, s3, a1
9205:             sltiu        t3, t4, -1063
9206:             mulhsu       a3, a7, a1
9207:             slt          a1, s9, s0
9208:             andi         s8, s5, -1482
9209:             sltu         a3, a3, s1
9210:             sltiu        s10, s10, 1201
9211:             xori         a1, s3, 921
9212:             sub          t3, s1, s3
9213:             csrrc        gp, 0x344, zero
9214:             auipc        s5, 494882
9215:             add          t4, a5, s7
9216:             and          s6, t4, s11
9217:             csrrwi       t3, 0x344, 12
9218:             csrrci       a3, 0x343, 0
9219:             csrrw        a2, 0x343, a6
9220:             bltu         a7, s3, 9227f
9221:             csrrci       a5, 0x304, 0
9222:             srai         a3, t3, 8
9223:             bge          gp, t4, 9243f
9224:             srli         a1, t4, 16
9225:             sltiu        s1, s3, -1266
9226:             csrrw        s6, 0x343, s11
9227:             csrrw        t5, 0x344, t4
9228:             beq          a3, tp, 9245f
9229:             beq          s5, zero, 9230f
9230:             nop
9231:             and          s5, sp, sp
9232:             sll          a4, t1, t3
9233:             csrrwi       s0, 0x301, 23
9234:             csrrw        t6, 0x301, s10
9235:             lui          s2, 153273
9236:             div          gp, a3, s11
9237:             beq          sp, t3, 9254f
9238:             bgeu         a2, t6, 9258f
9239:             csrrsi       s5, 0x301, 1
9240:             mul          a4, a6, tp
9241:             csrrci       s8, 0x344, 0
9242:             divu         s1, s7, a0
9243:             add          s11, tp, s6
9244:             slt          s8, t2, ra
9245:             csrrw        t6, 0x304, t1
9246:             bltu         t6, s10, 9247f
9247:             sra          s11, s4, s10
9248:             bge          a1, gp, 9259f
9249:             lui          a5, 635228
9250:             lui          zero, 528269
9251:             mulhsu       a7, tp, t2
9252:             blt          a7, a6, 9254f
9253:             sub          ra, zero, t6
9254:             sra          a3, s3, t1
9255:             mulh         a5, s9, tp
9256:             sub          a3, a4, s9
9257:             csrrc        s9, 0x343, zero
9258:             sll          s9, s8, a5
9259:             mulhu        t3, a5, a0
9260:             csrrci       a7, 0x305, 0
9261:             csrrsi       a4, 0x305, 0
9262:             srl          a4, a7, gp
9263:             ori          a6, t5, 1887
9264:             lui          a1, 24235
9265:             or           a1, t1, t0
9266:             xor          t4, s3, s0
9267:             and          s9, t6, s6
9268:             csrrs        s7, 0x344, zero
9269:             mulhsu       t2, t0, s2
9270:             srl          s10, s3, tp
9271:             nop
9272:             mulh         a1, t3, s1
9273:             csrrsi       t6, 0x300, 0
9274:             srl          t3, t6, s7
9275:             bge          gp, s6, 9276f
9276:             srai         t4, s11, 25
9277:             csrrc        s5, 0x304, zero
9278:             slt          ra, t5, s9
9279:             andi         t2, s3, 1791
9280:             mulh         zero, t5, a5
9281:             nop
9282:             mulhsu       a4, t3, s5
9283:             addi         s5, s7, -1947
9284:             bge          ra, a1, 9304f
9285:             mulh         gp, s8, t4
9286:             bge          t2, tp, 9304f
9287:             xori         a7, s3, -1426
9288:             slli         s5, tp, 8
9289:             rem          s4, s10, t0
9290:             sll          ra, a1, t6
9291:             rem          s0, t5, s8
9292:             csrrs        a2, 0x301, zero
9293:             bgeu         zero, s0, 9295f
9294:             mul          a4, t5, s5
9295:             srli         ra, t2, 21
                  la           s4, region_0+1488 #start load_store_instr_stream_0
                  la           ra, region_0+1371 #start load_store_instr_stream_2
                  lb           a3, 5(s4)
                  la           a6, region_0+1799 #start load_store_instr_stream_1
                  sb           t3, 1106(ra)
                  lbu          t0, 10(s4)
                  sb           s11, 1996(ra)
                  sb           zero, 5(s4)
                  sb           gp, 12(a6)
                  lh           zero, 609(ra)
                  lbu          t6, -12(a6)
                  sb           a1, -4(a6)
                  lb           a7, 11(s4)
                  lbu          a2, -802(ra)
                  lb           s11, 1704(ra)
                  sh           s9, -7(a6)
                  lb           t3, -11(s4)
                  sh           s5, 559(ra)
                  lh           s1, 2(s4)
                  sb           s11, 7(a6) #end load_store_instr_stream_1
                  sb           s6, -7(s4)
                  lb           t1, 1960(ra) #end load_store_instr_stream_2
                  lbu          a4, -6(s4) #end load_store_instr_stream_0
9296:             slli         zero, t4, 24
9297:             csrrci       s3, 0x342, 26
9298:             csrrs        t6, 0x342, zero
9299:             slli         zero, t2, 14
9300:             mulhu        t1, s5, a3
9301:             nop
9302:             csrrci       gp, 0x304, 11
9303:             xori         a5, s0, -840
9304:             bge          s7, a5, 9311f
9305:             rem          s6, a2, a0
9306:             add          s11, sp, a4
9307:             slt          s9, t1, s2
9308:             nop
9309:             remu         s7, s11, t2
9310:             xori         t5, s4, -1014
9311:             sltu         a2, s8, a4
9312:             ori          t3, s3, 1846
9313:             bltu         t5, tp, 9329f
9314:             xor          s0, s0, s9
9315:             bge          a3, tp, 9331f
9316:             mulhu        t3, s9, s8
9317:             csrrsi       s0, 0x300, 0
9318:             and          s2, s9, a4
9319:             sltiu        a2, tp, -249
9320:             divu         zero, t3, s2
9321:             sll          a3, a4, a7
9322:             srai         s6, tp, 7
9323:             mulhsu       ra, a0, s7
9324:             mulhsu       s10, s2, s11
9325:             or           s2, a1, a0
9326:             xor          a2, a1, s7
9327:             beq          t1, s5, 9343f
9328:             csrrsi       gp, 0x300, 0
9329:             beq          t3, t3, 9349f
9330:             srai         t4, t5, 31
9331:             auipc        a7, 233546
9332:             slt          gp, t1, a2
9333:             and          a3, a5, s6
9334:             nop
9335:             xor          s11, s3, t6
9336:             csrrsi       a7, 0x300, 0
9337:             csrrwi       t5, 0x342, 21
9338:             sra          a7, a0, a7
9339:             sltiu        a7, a0, 58
9340:             sltiu        t0, sp, -1860
9341:             csrrsi       a4, 0x301, 0
9342:             xor          s3, t5, sp
9343:             mul          a1, sp, a2
9344:             csrrw        t6, 0x342, s5
9345:             sll          s4, a2, t0
9346:             and          t2, t1, t6
9347:             ori          zero, s5, -693
9348:             bne          s11, s1, 9352f
9349:             add          s3, s8, tp
9350:             sll          t2, s1, s7
9351:             mul          s7, t5, a0
9352:             lui          gp, 663579
9353:             bgeu         a5, t6, 9371f
9354:             mulhsu       a1, t1, s0
9355:             ori          s3, tp, -990
9356:             csrrsi       t6, 0x304, 0
9357:             bne          t2, s1, 9366f
9358:             lui          s11, 804554
9359:             sll          s8, s10, s2
9360:             mul          a7, s5, a3
9361:             remu         s7, gp, s3
9362:             sltu         s10, s9, a3
9363:             xor          s7, s3, s5
9364:             bgeu         s1, t2, 9373f
9365:             nop
9366:             mulh         s2, t0, s6
9367:             srai         t3, t2, 13
9368:             srl          zero, gp, t6
9369:             bge          t1, a4, 9371f
9370:             srli         t4, a1, 15
9371:             remu         t0, t0, tp
9372:             bltu         s10, t6, 9392f
9373:             bgeu         ra, zero, 9386f
9374:             mul          t4, a6, a7
9375:             bne          t6, t5, 9384f
9376:             auipc        s6, 722601
9377:             blt          a0, t5, 9395f
9378:             xori         zero, s5, -234
9379:             srli         t2, a6, 13
9380:             mulh         s0, gp, a0
9381:             srl          s11, s5, a2
9382:             addi         s1, gp, 1894
9383:             addi         gp, zero, -809
9384:             divu         gp, a6, a0
9385:             bgeu         a4, s3, 9390f
9386:             slli         s9, s11, 10
9387:             andi         a5, s7, -1441
9388:             auipc        s7, 127439
9389:             and          s10, gp, a3
9390:             ori          a7, s6, 485
9391:             beq          gp, t2, 9393f
9392:             sltu         s4, s8, a7
9393:             bgeu         t0, zero, 9403f
9394:             blt          s7, a6, 9396f
9395:             csrrs        t0, 0x344, zero
9396:             andi         s8, s1, 1549
9397:             andi         s4, sp, -1706
9398:             csrrs        t4, 0x301, a4
9399:             or           s11, tp, t0
9400:             mul          t3, s4, a4
9401:             srai         s8, s6, 21
9402:             bgeu         s2, s10, 9415f
9403:             mulhu        s0, s5, s8
9404:             add          s7, s2, a1
9405:             or           a6, a0, a6
9406:             addi         t2, s5, 1857
9407:             slli         s10, s3, 24
9408:             slti         t5, a4, -1520
9409:             sll          s0, tp, s7
9410:             csrrw        t1, 0x342, a6
9411:             mulh         t4, t4, s0
9412:             and          t6, t6, sp
9413:             csrrsi       t0, 0x300, 0
9414:             bgeu         s9, a4, 9423f
9415:             auipc        a5, 23661
9416:             slli         a4, s0, 2
9417:             add          s4, t2, a3
9418:             div          a3, t2, t1
9419:             or           t1, t6, s9
9420:             sltu         zero, a7, zero
9421:             slti         t0, a3, -707
9422:             csrrw        t6, 0x344, zero
9423:             sltiu        s2, s9, 150
9424:             or           s3, t2, tp
9425:             or           t5, t2, s4
9426:             mulh         s9, s6, a7
9427:             csrrci       zero, 0x300, 0
9428:             csrrsi       zero, 0x305, 0
9429:             lui          t4, 671901
9430:             slt          a7, t3, s11
9431:             srai         t6, tp, 13
9432:             ori          t3, zero, -1593
9433:             addi         s3, ra, -1807
9434:             csrrwi       gp, 0x343, 4
9435:             blt          s5, s8, 9455f
9436:             csrrsi       s2, 0x305, 0
9437:             slti         s8, a7, 1105
9438:             slti         a6, s1, -277
9439:             csrrwi       t0, 0x344, 31
9440:             auipc        s5, 13459
9441:             and          gp, t6, ra
9442:             srai         ra, t6, 28
9443:             andi         s8, gp, 391
9444:             remu         a4, t6, s11
9445:             bne          t3, t4, 9458f
9446:             srl          s8, t3, tp
9447:             addi         s0, a1, 1499
9448:             sltu         a1, sp, t0
9449:             sltu         s1, a4, s5
9450:             sub          s3, a1, a6
9451:             mulh         a2, a0, s6
9452:             csrrci       s5, 0x342, 22
9453:             rem          s2, s10, s10
9454:             addi         s5, a6, -1173
9455:             divu         t0, t1, s10
9456:             csrrw        t5, 0x344, s4
9457:             sra          t4, s2, s3
9458:             csrrw        t4, 0x342, sp
9459:             addi         s10, s4, -1938
9460:             csrrsi       s11, 0x344, 15
9461:             bltu         a4, sp, 9479f
9462:             sltu         s1, a5, t4
9463:             nop
9464:             slt          s2, s11, s0
9465:             csrrc        gp, 0x343, s0
9466:             mulh         s7, ra, a1
9467:             ori          s2, s4, -327
9468:             andi         s10, zero, 906
9469:             beq          a5, s6, 9482f
9470:             sra          ra, gp, s0
9471:             sltu         t4, a3, s6
9472:             sltu         gp, t3, s10
9473:             beq          t5, a6, 9489f
9474:             srl          t0, s11, a7
9475:             csrrci       gp, 0x342, 0
9476:             csrrw        s2, 0x301, s8
9477:             or           ra, s0, t1
9478:             slli         a3, t4, 17
9479:             srli         s3, s9, 16
9480:             or           zero, s11, s5
9481:             mul          s11, a3, sp
9482:             lui          a4, 655181
9483:             srli         s5, tp, 8
9484:             divu         t6, t2, a3
9485:             slli         s11, a5, 24
9486:             and          zero, t6, a2
9487:             xor          s3, s7, a6
9488:             bne          t6, a7, 9497f
9489:             slt          a6, s4, t5
9490:             andi         t2, s5, -435
9491:             or           t4, t1, a0
9492:             xor          s3, sp, t0
9493:             sltu         s5, ra, t2
9494:             bne          tp, a6, 9495f
9495:             lui          t3, 26695
9496:             remu         s1, t0, a5
9497:             addi         s0, t3, 591
9498:             lui          s9, 642503
9499:             srli         t6, a6, 18
9500:             div          s7, ra, s10
9501:             slt          s5, a3, s2
9502:             csrrsi       t2, 0x300, 0
9503:             csrrs        s5, 0x300, zero
9504:             sltiu        s10, a5, -1090
9505:             srai         s1, a2, 2
9506:             xor          a7, zero, a1
9507:             ori          t4, a5, 895
9508:             slli         a4, a6, 7
9509:             mul          t4, sp, a6
9510:             slt          a4, a0, t2
9511:             csrrs        t0, 0x343, zero
9512:             addi         t5, t5, -661
9513:             addi         a2, s9, 683
9514:             remu         a3, t2, a6
9515:             auipc        a2, 880147
9516:             sltiu        s1, s11, 295
9517:             csrrc        a1, 0x342, a0
9518:             xori         t6, s6, 480
9519:             csrrw        a3, 0x304, a2
9520:             bltu         a5, a3, 9522f
9521:             slli         t4, t5, 8
9522:             div          s11, s6, t6
9523:             xori         a2, s9, 1916
9524:             blt          a6, s1, 9541f
9525:             slt          s0, t5, a1
9526:             bltu         s7, a7, 9531f
9527:             remu         a4, ra, gp
9528:             mulhu        t4, s4, s9
9529:             csrrci       zero, 0x305, 0
9530:             mulhsu       s11, a3, t5
9531:             div          s5, a1, t4
9532:             blt          t3, a5, 9542f
9533:             add          s11, a1, t0
9534:             bltu         t4, s8, 9541f
9535:             sltiu        a4, s2, -643
9536:             srli         a5, t1, 29
9537:             addi         s4, t2, -1016
9538:             csrrc        s9, 0x304, zero
9539:             bltu         s0, s2, 9557f
9540:             auipc        s3, 90611
9541:             auipc        s3, 28943
9542:             divu         t6, s2, t3
9543:             mulhu        t4, t1, a1
9544:             and          gp, a4, s3
9545:             nop
9546:             csrrci       zero, 0x343, 5
9547:             and          t3, s0, t2
9548:             remu         s1, a6, gp
9549:             lui          s4, 597747
9550:             slli         gp, s11, 6
9551:             csrrwi       s0, 0x343, 15
9552:             divu         s0, s8, ra
9553:             csrrwi       t3, 0x343, 17
9554:             add          s11, s4, t2
9555:             sra          a5, a1, a0
9556:             sltu         a6, a4, a5
9557:             csrrsi       a6, 0x300, 0
9558:             mulhu        a6, t2, tp
9559:             csrrci       a6, 0x305, 0
9560:             nop
9561:             bge          s10, a0, 9578f
9562:             csrrw        s4, 0x344, t1
9563:             slt          s11, t5, t3
9564:             and          zero, s9, t0
9565:             div          a4, s3, t2
9566:             blt          a3, s4, 9568f
9567:             mulhsu       s8, s6, s0
9568:             sra          t1, t6, a4
9569:             mulh         s0, a7, zero
9570:             csrrs        a4, 0x301, zero
9571:             sub          s8, s4, a4
9572:             add          ra, gp, a7
9573:             sltu         s11, s4, a2
9574:             beq          t2, gp, 9575f
9575:             csrrwi       t1, 0x344, 8
9576:             and          a3, ra, a3
9577:             sub          s5, s1, s3
9578:             rem          s2, a2, a7
9579:             beq          s4, t3, 9590f
9580:             srli         s6, ra, 28
9581:             add          a5, ra, s7
9582:             slt          s4, a4, a2
9583:             mul          a4, t6, tp
9584:             bge          a4, s6, 9588f
9585:             xori         s10, gp, -452
9586:             lui          t1, 481525
9587:             sltiu        s4, a2, -744
9588:             bge          a5, tp, 9590f
9589:             lui          s4, 322175
9590:             and          s2, a3, s1
9591:             srai         a7, t0, 14
9592:             sub          s9, t6, s6
9593:             csrrs        t3, 0x305, zero
9594:             ori          t1, s5, 639
9595:             auipc        a7, 7202
9596:             xor          t3, t2, a4
9597:             or           ra, s8, s10
9598:             bltu         t0, t1, 9618f
9599:             or           s7, t3, s2
9600:             andi         s7, s8, 715
9601:             srl          s8, s7, t3
9602:             srai         a7, s2, 11
9603:             lui          a1, 114091
9604:             lui          t0, 954937
9605:             slti         zero, s4, 1048
9606:             beq          t0, s7, 9626f
9607:             sltiu        a5, tp, -14
9608:             sltu         a2, s5, t6
9609:             sub          gp, zero, a2
9610:             addi         s5, s0, 660
9611:             csrrs        s3, 0x304, t1
9612:             xor          ra, s0, s5
9613:             xori         t3, s1, 1283
9614:             sub          gp, s10, a4
9615:             sll          a4, a1, t5
9616:             mul          t4, s2, s6
9617:             bgeu         zero, a3, 9633f
9618:             csrrw        s1, 0x304, s6
9619:             mul          t1, s3, t2
9620:             slli         t1, a7, 26
9621:             csrrw        t3, 0x344, a6
9622:             andi         s5, t2, -821
9623:             sltiu        s0, gp, -1311
9624:             srai         s2, sp, 4
9625:             sltiu        t5, s2, 569
9626:             add          a3, a4, t0
9627:             addi         a4, s1, 1250
9628:             nop
9629:             andi         a5, a5, -1085
9630:             bne          gp, t0, 9631f
9631:             xori         t6, zero, -1267
9632:             mulh         s11, s2, s7
9633:             lui          t4, 668714
9634:             xori         t0, ra, 943
9635:             xor          a6, t3, t3
9636:             csrrwi       a1, 0x342, 18
9637:             slti         s7, t0, -1085
9638:             remu         a5, s0, a2
9639:             mulhu        s3, sp, a5
9640:             lui          s3, 468485
9641:             csrrc        s6, 0x343, a0
9642:             bltu         s6, t6, 9644f
9643:             csrrsi       s10, 0x343, 0
9644:             sll          s8, a1, s11
9645:             bge          t1, gp, 9654f
9646:             csrrsi       s8, 0x301, 22
9647:             slti         s1, s3, -85
9648:             bge          s0, a4, 9668f
9649:             xor          t2, s2, a1
9650:             and          s2, t2, ra
9651:             nop
9652:             csrrsi       s8, 0x343, 0
9653:             bne          t6, a1, 9671f
9654:             add          t6, a6, t0
9655:             remu         a3, a4, s4
9656:             beq          sp, s0, 9658f
9657:             and          s6, t4, s0
9658:             lui          a7, 606666
9659:             auipc        t3, 476920
9660:             sub          a3, s8, s5
9661:             xor          s10, t2, s0
9662:             xori         s11, s10, -65
9663:             xor          s1, t4, a1
9664:             divu         ra, s3, a5
9665:             div          a2, gp, a2
9666:             div          t1, a2, s7
9667:             beq          a3, tp, 9683f
9668:             add          s2, s8, a1
9669:             xor          s11, s4, sp
9670:             srai         a5, a4, 23
9671:             bltu         s8, s11, 9687f
9672:             slti         t0, s9, 666
9673:             rem          a7, tp, gp
9674:             and          ra, ra, s3
9675:             blt          t6, t4, 9677f
9676:             and          s5, s11, t0
9677:             sll          s7, t1, tp
9678:             srai         s11, s11, 19
9679:             bne          s10, s11, 9699f
9680:             mul          a7, t5, a0
9681:             mulhsu       ra, a7, t3
9682:             csrrs        gp, 0x343, zero
9683:             csrrsi       gp, 0x300, 0
9684:             remu         t4, a4, zero
9685:             xor          a3, a5, s6
9686:             bltu         a4, t5, 9693f
9687:             sltiu        s10, t1, -1517
9688:             ori          a7, t5, 1132
9689:             sltiu        a2, s7, 444
9690:             srai         ra, gp, 0
9691:             xori         s3, t2, 1487
9692:             sltu         t3, sp, s10
9693:             ori          t2, s4, 999
9694:             beq          s9, s10, 9699f
9695:             mul          s5, a0, s8
9696:             blt          a4, s7, 9709f
9697:             lui          s11, 893910
9698:             rem          zero, s4, zero
9699:             slt          s11, a2, a5
9700:             csrrwi       t2, 0x301, 21
9701:             sltu         s9, a6, s9
9702:             divu         a4, zero, t6
9703:             sltu         s2, a4, s4
9704:             xor          s8, a5, s4
9705:             auipc        s10, 148602
9706:             add          s3, a6, zero
9707:             ori          s3, gp, 1717
9708:             rem          a1, gp, a1
9709:             bgeu         tp, gp, 9727f
9710:             mulhu        a1, zero, s5
9711:             andi         t6, s3, -1895
9712:             rem          s3, s9, t3
9713:             srl          zero, t5, t3
9714:             divu         t2, zero, zero
9715:             sll          zero, t1, t6
9716:             mul          s4, t6, s0
9717:             bltu         a7, s2, 9721f
9718:             ori          s0, s8, 588
9719:             csrrci       a3, 0x343, 0
9720:             xor          a6, a3, a4
9721:             bge          s7, s11, 9738f
9722:             xor          s6, s4, a6
9723:             sltu         t3, a5, t0
9724:             blt          a4, t1, 9725f
9725:             sltiu        t6, s0, -1707
9726:             xor          zero, s2, s5
9727:             remu         a2, s3, gp
9728:             sll          a7, s3, a0
9729:             remu         t6, s3, t4
9730:             mulhu        a5, s2, zero
9731:             mulhu        t5, a7, a4
9732:             srl          s7, ra, a4
9733:             mulhsu       ra, s4, a3
9734:             beq          s3, a3, 9754f
9735:             csrrs        zero, 0x343, a5
9736:             auipc        s9, 19457
9737:             beq          zero, t3, 9747f
9738:             lui          t6, 297927
9739:             mulhu        ra, t3, s4
9740:             sltu         t6, gp, s11
9741:             csrrci       a2, 0x342, 17
9742:             mulhu        s1, tp, s10
9743:             xori         zero, s1, -374
9744:             mulhu        s0, s9, a3
9745:             csrrs        s11, 0x300, zero
9746:             mulhsu       t1, a7, s3
9747:             mul          a6, s6, a5
9748:             slti         t6, s7, 1664
9749:             blt          a5, s11, 9750f
9750:             csrrc        ra, 0x343, t3
9751:             and          s0, t2, a3
9752:             beq          tp, s7, 9754f
9753:             bgeu         t4, t0, 9755f
9754:             csrrc        a3, 0x301, s10
9755:             div          s10, ra, t3
9756:             add          s7, a4, a4
9757:             div          s2, a4, s7
9758:             remu         a4, a1, s11
9759:             nop
9760:             mulh         t5, ra, s7
9761:             srl          a1, s9, a0
9762:             or           zero, a4, s1
9763:             remu         s1, s9, gp
9764:             rem          s11, t4, tp
9765:             mulhsu       t3, s10, a7
9766:             divu         s7, ra, s4
9767:             sra          a2, a4, a0
9768:             mulhsu       t0, a5, s0
9769:             lui          t5, 319664
9770:             beq          zero, s10, 9772f
9771:             addi         zero, t2, 7
9772:             csrrw        s2, 0x301, tp
9773:             bgeu         a7, s5, 9786f
9774:             andi         t2, s11, -612
9775:             bne          t6, t1, 9792f
9776:             sll          t4, t6, s6
9777:             nop
9778:             andi         a1, a5, -1496
9779:             divu         s0, zero, t3
9780:             sltiu        ra, t1, 1408
9781:             bne          t1, t4, 9801f
9782:             sltiu        a3, a1, -1570
9783:             csrrwi       s4, 0x342, 16
9784:             csrrc        a3, 0x344, zero
9785:             sltiu        s2, zero, -1298
9786:             csrrsi       t4, 0x300, 0
9787:             srl          t1, s1, t5
9788:             srli         ra, gp, 16
9789:             beq          s7, sp, 9798f
9790:             csrrc        t4, 0x304, a5
9791:             slti         s8, t1, -471
9792:             csrrw        t1, 0x301, s10
9793:             addi         s6, a7, 293
9794:             xori         a4, s4, -1300
9795:             csrrsi       ra, 0x343, 22
9796:             sra          s2, t1, t5
9797:             csrrs        a6, 0x342, zero
9798:             slti         s9, a5, -1860
9799:             mul          s3, a1, a7
9800:             add          s3, a1, t0
9801:             csrrw        t0, 0x344, s10
9802:             add          t1, s11, s4
9803:             csrrc        zero, 0x343, a0
9804:             csrrc        s5, 0x343, zero
9805:             csrrs        zero, 0x304, a4
9806:             csrrs        a3, 0x305, zero
9807:             blt          s10, a7, 9827f
9808:             srli         s10, s3, 1
9809:             srai         a3, t5, 30
9810:             addi         s10, s5, -1079
9811:             srai         s0, s8, 22
9812:             beq          ra, a4, 9828f
9813:             sltiu        s4, t4, 867
9814:             csrrwi       t6, 0x344, 20
9815:             csrrw        t2, 0x342, t4
9816:             sll          ra, sp, sp
9817:             divu         s6, s8, a1
9818:             lui          a1, 419872
9819:             srli         t2, sp, 2
9820:             divu         ra, s6, gp
9821:             andi         s6, a7, 1739
9822:             slli         s5, a1, 20
9823:             add          t1, t6, a4
9824:             nop
9825:             csrrw        s7, 0x304, a4
9826:             sltu         a6, t1, s7
9827:             mulh         zero, t4, sp
9828:             blt          tp, a0, 9846f
9829:             sra          a3, tp, tp
9830:             csrrw        s10, 0x343, ra
9831:             add          s1, s1, s4
9832:             bne          tp, tp, 9841f
9833:             remu         s2, s7, ra
9834:             remu         t3, a4, sp
9835:             auipc        a2, 584380
9836:             srl          s11, a4, a4
9837:             slt          t1, s11, s10
9838:             slli         a5, zero, 2
9839:             addi         zero, s6, -1999
9840:             beq          s7, a3, 9856f
9841:             mulhsu       s10, sp, s1
9842:             and          a4, a5, s4
9843:             sll          s3, a6, s5
9844:             blt          s2, s10, 9862f
9845:             bne          a5, gp, 9856f
9846:             srl          a7, t1, s11
9847:             srai         s6, s0, 21
9848:             lui          s2, 990450
9849:             srai         t6, gp, 9
9850:             xori         ra, s1, -1912
9851:             mulhsu       a7, t5, s6
9852:             rem          s0, s5, s5
9853:             bne          s1, a3, 9854f
9854:             bge          a0, s3, 9856f
9855:             mul          a4, s1, t2
9856:             and          s3, s2, zero
9857:             remu         a4, s1, s7
9858:             srli         a7, s6, 19
9859:             rem          zero, t6, t6
9860:             bne          t5, gp, 9869f
9861:             srl          s3, t0, s1
9862:             sltu         s0, s6, s6
9863:             divu         gp, s8, s1
9864:             csrrc        a1, 0x305, zero
9865:             auipc        s8, 589306
9866:             bge          ra, a4, 9870f
9867:             or           zero, a3, a6
9868:             csrrs        t5, 0x301, a3
9869:             and          s9, s3, t4
9870:             csrrw        t0, 0x343, s4
9871:             ori          s1, t3, -494
9872:             csrrs        s6, 0x343, zero
9873:             add          t0, s5, a5
9874:             rem          t3, ra, s6
9875:             beq          s0, s2, 9895f
9876:             nop
9877:             mulh         a7, s2, s0
9878:             beq          t4, s6, 9879f
9879:             slti         t2, t4, -824
9880:             srl          a6, s0, s0
9881:             srli         a6, a6, 10
9882:             sll          ra, t6, ra
9883:             blt          s5, s1, 9890f
9884:             bgeu         s5, s1, 9897f
9885:             nop
9886:             lui          s4, 317200
9887:             mulh         s8, t2, s7
9888:             srai         s1, a1, 20
9889:             bge          gp, a0, 9891f
9890:             remu         s8, a5, a7
9891:             and          s4, s6, s10
9892:             add          t0, s9, s5
9893:             slli         t4, t3, 2
9894:             ori          gp, sp, 488
9895:             srai         t1, s1, 12
9896:             csrrwi       s3, 0x304, 14
9897:             slli         s9, t4, 3
9898:             mulh         s8, s5, s4
9899:             andi         s7, t3, -588
9900:             sltiu        s3, s11, -1810
9901:             bltu         t1, zero, 9912f
9902:             csrrsi       s6, 0x343, 0
9903:             xori         s3, s10, -111
9904:             ori          a4, sp, 1194
9905:             slli         zero, sp, 0
9906:             nop
9907:             csrrw        t2, 0x304, a2
9908:             csrrci       a1, 0x305, 0
9909:             and          s1, s6, a6
9910:             bgeu         a0, s0, 9928f
9911:             sll          s9, a7, a5
9912:             xor          s3, s4, t0
9913:             or           s6, a3, s3
9914:             addi         a1, s4, -1957
9915:             mulhsu       s1, a6, s5
9916:             addi         s10, zero, -28
9917:             lui          a6, 870576
9918:             xor          a2, s6, t3
9919:             srl          a1, s9, s3
9920:             or           a3, a3, ra
9921:             bltu         zero, ra, 9939f
9922:             or           a4, t0, s3
9923:             or           s4, s2, a3
9924:             slti         s6, a5, 738
9925:             auipc        t2, 953980
9926:             bge          a5, s9, 9928f
9927:             auipc        ra, 565905
9928:             sra          s7, s0, a2
9929:             bge          a5, a5, 9942f
9930:             auipc        a3, 460150
9931:             remu         t1, s3, gp
9932:             srl          ra, t3, a5
9933:             mulh         a6, t2, t2
9934:             mulhsu       t2, t2, t3
9935:             xori         a5, s7, 81
9936:             nop
9937:             sltiu        a7, s9, -1621
9938:             bge          a2, s9, 9948f
9939:             csrrwi       a3, 0x301, 1
9940:             lui          s3, 297383
9941:             srai         s3, s10, 26
9942:             and          a1, a3, s6
9943:             srli         a2, s10, 15
9944:             bgeu         s2, ra, 9953f
9945:             csrrs        a6, 0x301, a0
9946:             mulh         s0, t6, t4
9947:             nop
9948:             remu         t3, t4, a1
9949:             srl          gp, a2, ra
9950:             mulhu        s6, s2, zero
9951:             beq          t3, a6, 9956f
9952:             bne          s1, s6, 9954f
9953:             sub          s9, tp, a5
9954:             remu         t2, s11, a3
9955:             bge          s5, t4, 9973f
9956:             csrrs        ra, 0x343, zero
9957:             ori          a7, a3, 1210
9958:             blt          gp, a2, 9974f
9959:             mul          s9, s8, zero
9960:             div          gp, zero, a2
9961:             slti         a7, s3, 469
9962:             nop
9963:             slli         s4, s10, 8
9964:             and          a3, s8, a2
9965:             bgeu         s8, ra, 9974f
9966:             srl          zero, t0, a7
9967:             add          s3, s0, a2
9968:             bgeu         a3, s2, 9969f
9969:             mulh         t2, s5, zero
9970:             srai         a6, s1, 23
9971:             mulh         zero, s8, s1
9972:             beq          s6, a4, 9988f
9973:             bgeu         gp, s6, 9993f
9974:             sra          t4, tp, s11
9975:             xor          s0, s10, s4
                  addi         a7, zero, 3 #init loop 0 counter
                  andi         a5, t4, -956
                  andi         a6, gp, 1489
                  addi         s8, zero, 19 #init loop 0 limit
                  srli         t5, tp, 22
main_202_0_t:     or           gp, a6, a5
                  div          t5, a1, s5
                  addi         a7, a7, 8 #update loop 0 counter
                  auipc        s11, 29582
                  sll          t6, s2, a7
                  blt          a7, s8, main_202_0_t #branch for loop 0
                  csrrs        t1, 0x344, a5
9976:             nop
9977:             csrrci       s1, 0x342, 0
9978:             csrrci       ra, 0x343, 0
9979:             nop
9980:             bne          s5, s2, 9999f
9981:             srli         t0, t6, 25
9982:             csrrc        t5, 0x344, zero
9983:             csrrs        gp, 0x300, zero
9984:             csrrc        s2, 0x344, zero
9985:             lui          a7, 1035890
9986:             rem          t0, a7, s6
9987:             rem          t1, t3, tp
9988:             and          s3, s0, s1
9989:             ori          s5, s0, 1893
9990:             remu         t4, tp, a3
9991:             rem          s10, s11, a3
9992:             bne          a0, s0, 9994f
9993:             andi         a1, a0, 1255
9994:             remu         a3, a2, a1
9995:             slti         t1, s0, -601
9996:             bgeu         t4, a7, 9998f
9997:             divu         zero, s10, t6
9998:             andi         s6, s4, 1397
9999:             auipc        s3, 629099
                  la x10, test_done
                  jalr x0, x10, 0
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

