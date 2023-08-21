.text 
.extern printf
.global _start


start:
    adr x22, coeff // array
    adr x19, x
    adr x5, a
    adr x6, b
    bl bisection_method
    

bisection_method:
    LDUR D19, [x19]
    LDUR D5, [x5]
    LDUR D6, [x6]
    adr x20, c
    LDUR D20, [x20]
    adr x21, epilson
    LDUR D21, [x21]
    mov x7, #2
    scvtf D7, x7
    bl bisection
    bl polynomial


    horner_method:
    //sets the polynomial equation needed to be used in bisection
    mov x23, #1 // counter for horners
    adr x1, lim
    lsl x9, x23, #3
    add x9, x9, x22
    ldr x10, [x22, #0] 
    mov x24, x10
    cmp x23, x1
    b.ge Exit
    add x19, x19, x10
    mul x24, x24, x19
    mov x0, x24
    add x23, x23, #1
    

    bisection:
    // does bisection method
    bl horners_method
    b.le Exit
    fmov D20, D5
    fsub D6, D6, D5
    fcmp D6, D21
    b.le Exit
    fadd D5, D5, D6
    fdiv D20, D5, D7                //finds midpoint
    bl polynomial
    b.ne Exit 
    fmul 







Exit:













.data
//put array in as normal
coeff:  .double 0.2, 1.9, -0.3, 3.1, 0.2

x:  .double 0
a:  .double 0
b:  .double 0
c:  .double 0
epilson: .double 0.01
lim: .dword 0
N:      .dword 4


    


