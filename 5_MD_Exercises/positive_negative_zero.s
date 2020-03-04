.data
    prompt: .asciiz "Enter number: "
    positive_s: .asciiz "positive"
    negative_s: .asciiz "negative"
    zero_s: .asciiz "zero"

.text
.globl main
main:
    la $a0,prompt
    li $v0,4
    syscall
    
    li $v0,5
    syscall
    
    bgtz $v0,positive
    bltz $v0,negative
    j zero
    
    positive: la $a0,positive_s
        j end
    negative: la $a0,negative_s
        j end
    zero: la $a0,zero_s
    
    end:
    	li $v0,4
    	syscall

    jr $ra
