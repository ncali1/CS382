.text
.global _start


_start:
    adr x20, input_str
    mov x19, #10 // for mul and udiv
    mov x21, #0
    b read
    
read:
    mov x0, #0
    mov x1, x20
    mov x2, #1
    mov w8, #63
    SVC #0                       //read function 
    ldur x29, [x20]            
    cmp x29, #10                  //compares to newline
    b.eq convert
    sub x29, x29, #48
    mul x21, x21, x19
    add x21, x21, x29
    b read                  

convert:            //converts char in given string to int
    mul x22, x21, x21
    adr x23, output_str
    mov x7, #0
    b modulo

modulo:
    udiv x24, x22, x19          // divide by 10
    sub x22, x22, x19
    mul x27, x24, x22
    add x27, x27, #48
    add x25, x7, x23
    stur x28, [x25]
    add x7, x7, #1
    cbz x24, Exit
    mov x22, x24
    b modulo

Exit:
    mov x29, #0

write:
    sub x19, x7, x29
    add x22, x19, x23
    mov x0, #1                      //fd == 1
    mov x1, x22
    mov x2, #1 
    mov w8, #64
    SVC #0
    add x29, x29, #1
    cmp x29, x7
    b.le write
    adr x20, new
    mov x0, #1
    mov x1, x20
    mov x2, #1
    mov w8, #64
    SVC #0
    mov x0, #0
    mov w8, #93
    SVC #0

.data
    new: .string "\n"

.bss
    input_str: .string ""
    output_str: .string ""
.end