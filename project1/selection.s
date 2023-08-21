.text
.extern printf
.global _start

_start:
    adr x27, a
    mov x20, #8 /*size*/
    bl sort1
    bl printarray
	mov x0, #0
	mov w8, #93
	SVC #0

sort1: /*outer for loop */
    sub sp, sp, #8
    stur LR, [sp, #0]
    mov x19, #0 /*int i = 0 */
    bigloop:
    cmp x19, x26 /* i < size - 1 */
    sub x20, x20, #1 /*size - 1 */
    mov x26, x20
    b.ge Exit
    b sort2
    add x4, x4 ,x27
    mov x22, #0 /*min index */
    mov x22, x19
    add x19, x19, #1 /*i++ */
    B bigloop
    ldur LR, [sp, #0]
    add sp, sp, #8    

sort2: /*inner for loop */
    sub sp, sp, #8
    stur LR, [sp, #0]
    mov x29, x19
    mov x21, #0 /*int j*/
    smallerloop: 
    add x21, x19, #1 /*j = i + 1 */
    cmp x21, x20 /* j < size */
    b.ge Exit
    ldr x9, [x21, #0]
    ldr x10, [x22, #0]
    cmp x9, x10 
    b.ge Exit
    mov x22, x21
    bl L1
    add x21, x21, #1
    b smallerloop
    ldur LR, [sp, #0]
    add sp, sp, #8

L1:
    sub sp, sp, #8
    stur LR, [sp, #0]
    lsl x10, x22, #3
    lsl x9, x21, #3
    bl swap
    ldur LR, [sp, #0]
    add sp, sp, #8
    br LR

swap: /* swap &a[min index] and &a[i] */
    sub sp, sp, #8
    stur LR, [sp]
    ldur x9 ,[x27, #0]
    ldur x10,[x27, #0]
    stur x9 ,[x27, #0]
    stur x10,[x27, #0]
    ldur LR, [sp]
    add sp, sp, #8
    br LR

printarray:     /*for loop to print all the elements in the array */
    sub sp, sp, #8
    stur LR, [sp]
    loop:
    cmp x19, x20
    b.gt Exit
    lsl x25, x19, #3
    add x25, x25, x27
    ldr x1, [x25, #0]
    ldr x0, =m
    bl printf
    add x19, x19, #1 /* i++ */
    b loop
    ldur LR, [sp]
    add sp,sp, #8
    br LR
Exit:
    ldur LR, [sp, #0]
    add sp, sp, #8
    br LR

.data
a: .dword 4, 6, 8, 1, 10, 7, 11, 56, 100
m: .ascii "%d\n\0"

