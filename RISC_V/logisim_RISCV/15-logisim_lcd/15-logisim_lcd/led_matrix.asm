li t0,31
li s10,0
li s11,1
loop:
  addi s10,s10,1
  bne s10,t0,loop

li s10,0
slli s11,s11,1
beqz s11,reset
jal loop
reset:
  li s11,1
  jal loop