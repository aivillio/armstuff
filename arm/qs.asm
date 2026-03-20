.data
    flights: .word 45, 60, 38, 72, 55, 68, 50
    n:       .word 7

.text
main:
    la t0, flights      # Load address of array
    lw t1, n            # Load N 
    
    li t2, 0            # Index i = 0
    li t3, 0            # Total Sum = 0
    li t4, 2147483647   # Min Value (Start at Max Int)

loop1:
    bge t2, t1, calc_avg # If i >= N, exit loop
    
    slli t5, t2, 2      # t5 = i * 4
    add t6, t0, t5      # Address of flights[i]
    lw s1, 0(t6)        # Load flights[i] into s1
    
    add t3, t3, s1      # total = total + flights[i]
    
    # Check Minimum
    bge s1, t4, skip_min
    mv t4, s1           # Update min if s1 < t4
skip_min:
    addi t2, t2, 1    
    j loop1

calc_avg:
    div s2, t3, t1      # Average = Total / N
    
    # Count hours below average
    li t2, 0            # Reset index i = 0
    li s3, 0            # Count = 0

loop2:
    bge t2, t1, end_a
    
    slli t5, t2, 2
    add t6, t0, t5
    lw s1, 0(t6)
    
    bge s1, s2, skip_count # If flights[i] >= average, skip
    addi s3, s3, 1         # count++
skip_count:
    addi t2, t2, 1
    j loop2

end_a:
     
    # t3 = Total, s2 = Average, s3 = Count < Avg, t4 = Min
    li a7, 10           # Exit syscall
    ecall