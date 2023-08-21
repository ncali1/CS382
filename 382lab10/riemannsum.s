.text 
.extern printf
.global _start


// solve y= 2.5x^3-15.5x^2+20x+15 on bounds [-0.5,5]

_start:
    adr x0, output_str
    bl printf
    adr x0, compare_str
    mov w8, #93
    SVC #0
    
intergral:
    adr x2, x               //double x parameter
    ldur D2, [x2]
    adr x3, a
    ldur D3, [x3]
    adr x4, b
    ldur D4, [x4]
    adr x5, n 
    scvtf D5, x5
    mov x22, #0
    scvtf D27, x22 
    //double to store width of small triangles
    adr x23, c
    ldur D23, [x23] //double c = 0
    mov x26, #0
    scvtf D26, x26

    adr x6, num1    //2.5
    ldur D6, [x6]
    adr x7, num2    //15.5
    ldur D7, [x7]
    adr x8, num3    //0.5
    ldur D8, [x8]
    adr x9, form1
    ldur D9, [x9]   //20
    adr x10, form2
    ldur D10, [x10] //15

    adr x27, count
    scvtf D28, x27

    b rienmann_sum


rienmann_sum:
    fsub D15, D4, D3
    FDIV D23, D15, D22   // c = (b-a)/n     
    mov x24, #0 //int i =0 for for loop
    scvtf D24, x24
    ldur D26, [x26]
    mov x25, #0
    scvtf D25, x25
    fcmp  D24, D5
    b.ge Exit
    fadd D25, D24, D8
    fmul D15, D25, D23
    fadd D15, D15, D3
    fmul D15, D15, D23  
    fmul D15, D15, D23
    bl func
    fadd D26, D26, D15
    fadd D24, D24, D28 
    fmov D0, D26

   
func:
    fmul D11, D1, D1
    fmul D11, D11, D1       //x^3
    fmov D19, D11
    fmul D19, D19, D6     // 2.5x^3
    fmul D12, D1, D1        //x^2
    fmov D20, D12
    fmul D20, D20, D7    //15.5x^2
    fmul D21, D1, D9       //20x 
    fsub D13, D19, D20
    fadd D14, D13, D21
    fadd D14, D14, D10
    fmov D0, D14
    br lr

Exit:
   
        

.data 
a: .double   -0.5   //left limit
b: .double   5.0   //right limit
n: .double   10   //# of rectangles
x: .double    0
c: .double    0
r: .double    0

num1: .double 2.5
num2: .double 15.5
num3: .double 0.5
form1: .double 20
form2: .double 15
count: .double 1

output_str: .ascii "74.1079\n"
compare_str: .ascii "Difference is .001\n"
.end

