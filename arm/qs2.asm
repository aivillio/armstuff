.data
    balances: .word 1000, 2500, 1500, 4000, 3000
    size:     .word 5

.text
main:
    la t0, balances
    lw t1, size
    
    li t2, 0            # Index i = 0
    li t3, 0            # Total Balance = 0
    li t4, 0            # Max Balance = 0

loop_bank:
    bge t2, t1, update_bonus
    
    slli t5, t2, 2      # Offset
    add t6, t0, t5      # Current address
    lw s1, 0(t6)        # Load balance
    
    add t3, t3, s1      # Add to total
    
    # Find Max
    ble s1, t4, not_max
    mv t4, s1           # Update max
not_max:
    addi t2, t2, 1
    j loop_bank

update_bonus:
    li t2, 0            # Reset index for bonus application
    li s4, 5            # Multiplier
    li s5, 100          # Divisor

bonus_loop:
    bge t2, t1, end_b
    
    slli t5, t2, 2
    add t6, t0, t5
    lw s1, 0(t6)
    
    # Calculate 5% bonus: (Value * 5) / 100
    mul s6, s1, s4
    div s6, s6, s5
    add s1, s1, s6      # Add bonus back to original
    
    sw s1, 0(t6)        # Store updated balance back in array
    
    addi t2, t2, 1
    j bonus_loop

end_b:
    # Final Results:
    # t3 = Total, t4 = Max, Array 'balances' contains updated values
    li a7, 10
    ecall