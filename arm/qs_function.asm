.data
    flights: .word 45, 60, 38, 72, 55, 68, 50
    n:       .word 7

.text
main:
    la a0, flights      # a0 = array address
    lw a1, n            # a1 = array length
    jal ra, analyze_flights
    
    
    # a0 = total sum, a1 = average, a2 = min value, a3 = count below average
    li a7, 10           # Exit syscall
    ecall


analyze_flights:
  
    li t3, 0            # t3 = Total Sum
    li t4, 2147483647   # t4 = Min Value
    li t2, 0            # t2 = Index i
    
    # Calculate total and minimum
loop1:
    bge t2, a1, calc_avg # If i >= N, go to calc_avg
    
    slli t5, t2, 2      
    add t6, a0, t5      
    lw s1, 0(t6)        
    
    add t3, t3, s1      # total += array[i]
    
    # Check if minimum
    bge s1, t4, skip_min
    mv t4, s1           # Update min
skip_min:
    addi t2, t2, 1      # i++
    j loop1

calc_avg:
    div s2, t3, a1      # s2 = average
    
    # Count values below average
    li t2, 0            # Reset index i = 0
    li s3, 0            # s3 = count

loop2:
    bge t2, a1, end_function
    
    slli t5, t2, 2
    add t6, a0, t5
    lw s1, 0(t6)
    
    bge s1, s2, skip_count # If array[i] >= average, skip
    addi s3, s3, 1         # count++
skip_count:
    addi t2, t2, 1
    j loop2

end_function:
   
    mv a0, t3           # a0 = total
    mv a1, s2           # a1 = average
    mv a2, t4           # a2 = min
    mv a3, s3           # a3 = count below average
    jr ra               # Return to caller
