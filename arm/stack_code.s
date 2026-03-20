 .data
f:      .word 0
.text
ldr r4,=f
mov r0,#1
mov r1,#2
mov r2,#3
mov r3,#4

bl example
str r0,[r4]
swi 0x011

example:
    sub r13, r13, #12
    str r5,[r13,#0]
    str r6,[r13,#4]
    str r7,[r13,#8]
    add r5,r0,r1
    add r6,r2,r3
    sub r7,r5,r6
    mov r0,r7

    ldr r5,[r13,#0]
    ldr r6,[r13,#4]
    ldr r7,[r13,#8]
    add r13, r13, #12
    mov pc ,lr


