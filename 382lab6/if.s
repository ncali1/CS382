.text
.extern printf
.global _start

_start:
adr x15, i
adr x16, f
adr x17, g
ldr x20, [x15, #0]
ldr x21, [x16, #0]
ldr x22, [x17, #0]
sub x20, x20, #4
cbnz x20, Else
add x19, x22, #1
B Exit

Else:
sub x19, x22, #2
BL Exit



Exit:
adr x0, message
mov x1, x19 
BL printf
mov x0, #0
mov w8, #93
SVC #0

.data
i: .quad 6
f: .quad 4
g: .quad 10
message: .ascii "Value of f: %d\n\0"

.end
