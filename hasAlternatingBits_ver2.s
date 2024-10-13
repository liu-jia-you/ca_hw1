.data
n0: .word 5
n1: .word 7
n2: .word 11
endl: .string "\n"
f: .string "false\n"
t: .string "true\n"

.text
    la t0, n0
    li t1, 3

my_clz:
    lw t2, 0(t0)
    li a0, 0 # count=0
    li s1, 31 # i=31
    li s0, 0 # bit i
loop:
    li s2, 1 # s2=1U
    sll s3, s2, s1 # s3=1U<<i
    and s4, t2, s3 # x&(1U<<i)
    bne s4, zero, hasAlternatingBits
    addi a0, a0, 1 # count++
    addi s1, s1, -1 # --i
    sll s3, s2, s1 # s3=1U<<i
    and s4, t2, s3 # x&(1U<<i)
    bne s4, zero, hasAlternatingBits
    addi a0, a0, 1 # count++
    addi s1, s1, -1 # --i
    sll s3, s2, s1 # s3=1U<<i
    and s4, t2, s3 # x&(1U<<i)
    bne s4, zero, hasAlternatingBits
    addi a0, a0, 1 # count++
    addi s1, s1, -1 # --isll s3, s2, s1 # s3=1U<<i
    and s4, t2, s3 # x&(1U<<i)
    bne s4, zero, hasAlternatingBits
    addi a0, a0, 1 # count++
    addi s1, s1, -1 # --i
    bge s1, zero, loop

hasAlternatingBits:
    li s5, 31
    sub s5, s5, a0 # total=31-a0
    ble s5, zero, tend
    
bitloop:
    srl s6, t2, s0 # s6=n>>i
    addi s11, s0, 1
    srl s7, t2, s11 # s7=n>>(i+1)
    andi s8, s6, 1 
    andi s9, s7, 1 
    beq s8, s9, end
    addi s0, s0, 1 # i++
    blt s0, s5, bitloop
    
tend:
    mv a0, t2
    li a7, 1
    ecall
    la a0, t
    li a7, 4
    ecall
    addi t0, t0, 4
    addi t1, t1, -1
    bne t1, zero, my_clz
    li a7, 10
    ecall
end:
    mv a0, t2
    li a7, 1
    ecall
    la a0, f
    li a7, 4
    ecall
    addi t0, t0, 4
    addi t1, t1, -1
    bne t1, zero, my_clz
    li a7, 10
    ecall
