li gp,0
li t0,10
li s10,0
mv gp,t0
loop:
 addi gp,gp,-1
 bnez gp,loop
mv gp,t0
addi s10,s10,1
jal loop