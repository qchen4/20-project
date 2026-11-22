gen_instr_beg:    nop
19:               sll          zero, s1, s0
                  slli         s9, zero, 27
                  srl          s3, s3, a4
                  sra          a6, t1, a3
20:               srai         gp, t3, 16
                  srli         s3, s3, 27
                  slli         a5, t6, 17
                  lui          zero, 81544
21:               srai         t5, t3, 21
                  srai         tp, ra, 8
                  srl          s3, a4, s10
                  ori          s9, t6, 77
22:               la           t0, region_0+140
                  sll          a6, t2, s10
                  srl          a2, a2, s2
                  srl          a5, a4, a5
                  lb           s5, 57(t0)
23:               la           a2, region_0+3899
                  sll          s11, t3, a6
                  srai         s5, a2, 7
                  srl          a1, s6, a1
                  sb           s9, -29(a2)
24:               sll          s10, s5, ra
                  srl          ra, a4, s9
                  sll          t3, s7, t4
                  sltu         t3, a2, s3
25:               sll          s8, t5, s9
                  srl          t1, a3, s3
                  sra          a6, t3, sp
26:               srl          ra, t0, s2
                  sll          a6, s6, t2
                  srai         a1, t5, 17
                  divu         a1, s6, tp
27:               srl          s4, t4, s2
                  srai         s4, t3, 4
                  sll          a5, s10, s10
                  mulhsu       ra, s5, tp
28:               srl          s2, t0, s11
                  srl          s8, a5, s8
                  auipc        a6, 215585
                  sll          t4, t3, s5
29:               sll          t0, s8, t0
                  slli         s11, t2, 1
                  lui          tp, 692591
                  lui          s2, 331215
30:               slli         t2, s11, 26
                  sra          s3, s2, s3
                  lui          ra, 785767
                  xor          t4, a7, t5
gen_instr_end:    nop

