.data 
a: .word 1,2,3,4
b: .word 1,2,3,4
c: .word 0

.text
ldr r3,=a
ldr r4,=b
ldr r5,=c
mov r6,#0        ;counter
    
    loop:
    ldr r0,[r3],#4
    ldr r1,[r4],#4

    mov r2,#0
    add r6,r6,#1
    
    
    mla r2,r0,r1,r2
    cmp r6,#4
    bne loop
str r2,[r5]