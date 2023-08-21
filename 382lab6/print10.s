.text
.global _start
#.extern printf

_start:
mov x2, #10
mov x3, #0
mov x1, #0 
bl loop

loop:
cmp x3, x2
beq Exit
add x3, x3, #1
add x1, x1, x3
bl loop


Exit:
adr x0, msg
bl printf
mov x0, #0
mov w8, #93
SVC #0



.data
x: .quad 0
y: .quad 0
z: .quad 10
msg: .ascii "Sum: %d\n\0"

.end


	
