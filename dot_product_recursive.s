.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
dotproduct: .string "The dot product is: "
newline: .string "\n"

.text
main:
    la a0, a # load address of array a
    la a1, b # load address of array b
    addi a2, x0, 5 # set size to 5
    
    jal dot_product_recursive
    
    mv t0, a0
    
    addi a0, x0, 4 # print_string
    la a1, dotproduct
    ecall

    addi a0, x0, 1 # print_int
    add a1, x0, t0 # print result
    ecall
    
    addi a0, x0, 4 # print_string
    la a1, newline
    ecall
    
    addi a0, x0, 10 # exit
    ecall

dot_product_recursive:

    # base case
    addi t0, x0, 1 # t0 = 1
    beq a2, t0, exit_base_case # if size == 1, Exit base case
    
    # recursive case
    addi sp, sp, -4
    sw ra, 0(sp) # storing the ra value on to the stack
    
    # store address of a, b
    addi sp, sp, -8
    sw a0, 0(sp)
    sw a1, 4(sp)
    
    # dot_product_recursive(a+1, b+1, size-1)
    addi a0, a0, 4
    addi a1, a1, 4
    addi a2, a2, -1
    jal dot_product_recursive
    
    mv t2, a0
    
    # load address of a, b
    lw a0, 0(sp)
    lw a1, 4(sp)
    addi sp, sp, 8
    
    # a[0]*b[0]
    lw t0, 0(a0)
    lw t1, 0(a1)
    mul t3, t0, t1
    
    # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1)
    add a0, t3, t2
    
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra
    
exit_base_case:
    lw t0, 0(a0) # load address of a to t0
    lw t1, 0(a1) # load address of a to t1
    mul a0, t0, t1
    jr ra
