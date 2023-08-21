.text
.extern printf
.extern scanf
.global _start

_start:
    adr x0, scanf_str
    adr x1, s
    bl scanf
    
    ldr x1, =s
    ldur x1, [x1, #0]
    

    bl binary_search

    

	mov x0, #0
	mov w8, #93
	SVC #0


binary_search:
    adr x27, a
    mov x20, #9 /*size*/
    mov x19, #0 /*int left */
    mov x22, #0 /* int right */
    sub x22, x20, #1 /*right = n - 1 */
    search:
        cmp x19, x22                  /* while (left -right <= 0 */
        b.gt Fail                   /*loop condition not met */
        sub x23, x22, x19            /*right - left */
        lsr x23, x23, #1            /*do divison of mid */
        add x23, x23, x19           /* left + (right - left)/2 */
        lsl x25, x23, #3
        add x25, x25, x27
        ldr x24, [x25, #0]          /*ldr offset and load array[m]*/
        cmp x24, x21                /*compares to user input */
        b.eq L1                     /*handles if they are equal */
        b.gt L2                     /*handles if it is less than */
        sub x22, x23, #1             /* right = mid - 1 */
        b search
        br LR
    L1:
        bl Pass
    L2: 
        add x19, x23, #1              /*left = mid + 1 */
        br LR



Pass:
    mov x1, x23
    adr x0, print_str
    bl printf
    mov x0, #0
    mov w8, #93
    SVC #0

Fail:
    adr x0, error_str
    bl printf
    mov x0, #0
    mov w8, #93
    SVC #0

.data
a: .dword 1, 4, 6, 7, 8, 10, 11, 56, 100
s: .space 80
scanf_str: .ascii "%ld\0"
print_str: .ascii "Element is present at index %ld\n\0"
error_str: .ascii "%ld not found\n\0"

