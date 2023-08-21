.text
.extern printf
.global _start

_start:
adr x15, a
adr x16, b
adr x0, message

ldr x1, [x15]
ldr x2, [x16]

add x18, x2, x1
subs x18, x18, #14
cbnz x18, L1
mov x18, #3
mov x1, x18
B L2

L1:
mov x19, #2
mov x18, #0
sub x18, x18, x19
mov x1, x18
B L2


L2:
BL printf
mov x0, #0
mov w8, #93
SVC #0


.data
a: .quad 9
b: .quad 5
message: .ascii "Value of c: %d\n"

.end
