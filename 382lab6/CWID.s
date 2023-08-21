.text
.global _start
#.extern printf


_start:
	mov x2, #8
	mov x3, #0
	mov x4, #0
	ldr x5, =array
	bl loop
	
	
loop:
	cmp x3, x2
	beq Exit
	lsl x10, x3, #3 
	add x10, x10, x5
	ldr x9, [x10, #0]
	add x3, x3, #1
	add x4, x4, x9
	bl loop
	
Exit:
	adr x0, msg
	mov x1, x4
	bl printf
	mov x0, #0
	mov w8, #93
	SVC #0


.data
array: .quad 1, 0, 4, 5, 3, 5, 0, 5	
msg: .ascii "%d\n\0"
