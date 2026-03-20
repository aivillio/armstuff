.data
balances:   .word 1000, 2500, 750, 3200, 1800
newline:    .string "\n"
space:      .string " "
msg_total:  .string "Total Balance: "
msg_max:    .string "Max Balance: "
msg_updated:.string "Updated Balances: "

.text
.globl main

main:
    lui   t0, %hi(balances)
    addi  t0, t0, %lo(balances)

    addi  t1, x0, 0
    lw    t2, 0(t0)
    addi  t3, x0, 0
    addi  t4, x0, 5

loop1:
    bge   t3, t4, end_loop1

    addi  t5, x0, 4
    mul   t6, t3, t5
    add   t6, t0, t6
    lw    t5, 0(t6)

    add   t1, t1, t5

    ble   t5, t2, skip_max
    addi  t2, t5, 0
skip_max:

    addi  t3, t3, 1
    jal   x0, loop1
end_loop1:

    lui   a0, %hi(msg_total)
    addi  a0, a0, %lo(msg_total)
    addi  a7, x0, 4
    ecall

    addi  a0, t1, 0
    addi  a7, x0, 1
    ecall

    lui   a0, %hi(newline)
    addi  a0, a0, %lo(newline)
    addi  a7, x0, 4
    ecall

    lui   a0, %hi(msg_max)
    addi  a0, a0, %lo(msg_max)
    addi  a7, x0, 4
    ecall

    addi  a0, t2, 0
    addi  a7, x0, 1
    ecall

    lui   a0, %hi(newline)
    addi  a0, a0, %lo(newline)
    addi  a7, x0, 4
    ecall

    lui   a0, %hi(msg_updated)
    addi  a0, a0, %lo(msg_updated)
    addi  a7, x0, 4
    ecall

    addi  t3, x0, 0

loop2:
    bge   t3, t4, end_loop2

    addi  t5, x0, 4
    mul   t6, t3, t5
    add   t6, t0, t6
    lw    t5, 0(t6)

    addi  t1, x0, 5
    mul   t1, t5, t1
    addi  a1, x0, 100
    div   t1, t1, a1

    add   t5, t5, t1
    sw    t5, 0(t6)

    addi  a0, t5, 0
    addi  a7, x0, 1
    ecall

    lui   a0, %hi(space)
    addi  a0, a0, %lo(space)
    addi  a7, x0, 4
    ecall

    addi  t3, t3, 1
    jal   x0, loop2
end_loop2:

    lui   a0, %hi(newline)
    addi  a0, a0, %lo(newline)
    addi  a7, x0, 4
    ecall

    addi  a7, x0, 10
    ecall