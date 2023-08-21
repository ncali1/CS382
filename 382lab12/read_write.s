.text
.global _start

_start:
    adr x19, x
    mov x22, #10 // for mul and udiv
    mov x23, #0 
    b read
    
read:
    mov x0, #0
    mov x1, x19
    mov x2, #1 
    mov w8, #63
    SVC #0                           //read function 
    ldur x20, [x19] 
    cmp x20, #10                     //compares to newline
    b.eq convert 
    sub x20, x20, #48 
    mul x23, x23, x22
    add x23, x23, x20
    b read 

convert:                    //converts char in given string to int
    mul x24, x23, x23
    adr x26, squared
    mov x27, #0
    b modulo

modulo:                     //modulo divsion
    udiv x25, x24, x22                  //divide by 10
    msub x29, x25, x22, x24 
    add x29, x29, #48 
    add x21, x27, x26
    stur x29, [x21]
    add x27, x27, #1
    cbz x25, exit
    mov x24, x25
    b modulo

exit:
    mov x20, #0
write:
    sub x22, x27, x20
    add x24, x22, x26
    mov x0, #1                               // fd == 1
    mov x1, x24 
    mov x2, #1 
    mov w8, #64
    SVC #0 
    add x20, x20, #1
    cmp x20, x27
    b.le write
    adr x19, new
    mov x0, #1
    mov x1, x19 
    mov x2, #1
    mov w8, #64
    SVC #0                              // write function
    mov x0, #0
    mov w8, #93
    SVC #0                               // exit function

.data
    new: .string "\n"

.bss
    x: .string ""
    squared: .string ""
.end    