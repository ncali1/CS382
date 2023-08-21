.text
.extern printf
.global _start


_start:
	adr x4, n
	mov x0, #7
	bl maxVal
	ldr x0, =msg
	bl printf
	mov x0, #0
	mov w8, #93
	SVC #0
maxVal:
	sub sp, sp, #16
	str LR, [sp, #8]
	str x0, [sp, #0]
	cmp x0, #1
	bgt Else
	ldr x1, [x4, #0]
	add sp, sp, #16
	br LR
Else:
	sub x0, x0, #1
	bl maxVal
	ldr x0, [sp, #0]
	ldr LR, [sp, #8]
	add sp, sp, #16
	add x4, x4, #8
	ldr x2, [x4, #0]
	cmp x2, x1
	bge Exit
	br LR
Exit:
	mov x1, x2
	br LR


.data
n: .dword 4, 5, 3, 6, 2, 7, 10 
msg: .ascii "Max value of array: %d\n\0"
.end
