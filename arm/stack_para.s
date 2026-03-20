.data
f: word 0

.text
mov r4,=f
mov r0,#1
mov r1,#2
mov r2 ,#3
mov r3,#4

sub r13,r13,#16
str r0,[r13,#12]
str r1,[r13,#8]
str r2,[r13,#4]
str r3,[r13,#0]

bl example

example:
ldr r5,[r13,#0]
ldr r6,[r13,#4]
ldr r7,[r13,#8]
ldr r8,[r13,#12]



