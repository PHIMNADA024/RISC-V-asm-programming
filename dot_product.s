.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
dotproduct: .string "The dot product is: "
newline: .string "\n"

.text
main:

    addi x5, x0, 0 # let x5 be i and set it to 0
    addi x6, x0, 0 # let x6 be sop and set it to 0
    
    la x7, a # loading the address of a to x7
    la x8, b # loading the address of b to x8

loop1:

    addi x9, x0, 5 # set x9 to 5
    bge x5, x9, exit1 # check if i >= 5, if so go to exit1
    slli x18, x5, 2 # set x18 to i*4
    add x19, x18, x7 # add i*4 to the base address of a and put it to x19
    add x20, x18, x8 # add i*4 to the base address of b and put it to x20
    lw x21, 0(x19) # a[i]
    lw x22, 0(x20) # b[i]
    mul x23, x21, x22 # a[i] * b[i]
    add x6, x6, x23 # sop += a[i] * b[i]
    addi x5, x5, 1 # i++
    j loop1
    
exit1:

    addi a0, x0, 4 # print_string
    la a1, dotproduct
    ecall
    
    addi a0, x0, 1 # print_int
    add a1, x0, x6 # print(sop)
    ecall
    
    addi a0, x0, 4 # print_string
    la a1, newline
    ecall
    
    addi a0, x0, 10 # exit
    ecall
    