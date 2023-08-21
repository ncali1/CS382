.text
.global _start
.extern printf


//use tylers provided c code as a benchmark to construct my program
_start:
    adr X19, N
    ldr X19, [X19]                          //N 
    adr X20, x
    adr X21, y
    mov X22, #0                             //i
    mov X23, #1                             //j
    adr X24, z
    ldr D27, [X24]                         //max difference
    adr X25, min
    ldr D28, [X25]                         //min difference
    b loop1

loop1:
    cmp X22, X19
    b.ge print
    ldr D19, [X20, X22, LSL 3]             //x[i]
    ldr D20, [X21, X22, LSL 3]             //y[i]
    bl loop2
    add X22, X22, #1
    add X23, X22, #1
    b loop1

loop2:
    cmp X23, X19
    b.ge exit
    ldr D22, [X20, X23, LSL 3]              //x[j]
    ldr D23, [X21, X23, LSL 3]              //y[j]
    fsub D25, D22, D19                      //x[i] - x[j]
    fmul D25, D25, D25                      //(x[i] - x[j])^2 
    fsub D26, D23, D20                      //y[i] - y[j]
    fmul D26, D26, D26                      //(y[i] - y[j])^2 
    fadd D29, D25, D26                      //d = (x[i] - x[j])^2 + (y[i] - y[j])^2 
    fcmp D29, D27 
    b.lt L1 
    fmov D27, D29 
    fmov D11, D22 
    fmov D12, D23 
    fmov D13, D19 
    fmov D14, D20                         //if (d > max)
L2:
    fcmp D29, D28 
    add X23, X23, #1
    b.ge loop2 
    fmov D28, D29 
    fmov D15, D22 
    fmov D16, D23 
    fmov D17, D19 
    fmov D18, D20 
    
L1:
    fcmp D29, D28 
    b.gt L2 
    fmov D28, D29 
    fmov D15, D22 
    fmov D16, D23 
    fmov D17, D19 
    fmov D18, D20                           //if(d < min)
    b L2
    
exit:
    br lr
    
print:
    adr x0, small
    fmov D0, D17
    fmov D1, D18
    fmov D2, D15
    fmov D3, D16
    bl printf                               //smallest
    adr x0, large
    fmov D0, D13
    fmov D1, D14
    fmov D2, D11
    fmov D3, D12
    bl printf                               //largest
    mov   X0, #0
    mov   W8, #93
    SVC   #0  
    
.data
    N: .dword 8
    x: .double 0.0, 0.4140, 1.4949, 5.0014, 6.5163, 3.9303, 8.4813, 2.6505
    y: .double 0.0, 3.9862, 6.1488, 1.047, 4.6102, 1.4057, 5.0371, 4.1196
    z: .double 0
    min: .double 100000000
    small: .ascii "The minimum distance between points is between points (%lf, %lf) and (%lf, %lf)\n\0"
    large: .ascii "The largest distance between points is between points (%lf, %lf) and (%lf, %lf)\n\0"
