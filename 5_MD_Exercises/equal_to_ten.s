.data
    prompt: .asciiz "Enter number: "
    output: .asciiz "Ten!"
.text
.globl main
main:
    la $a0,prompt
    li $v0,4
    syscall
    
    li $v0,5
    syscall
    
    li $t0,10
    bne $v0,$t0,end
    
    la $a0,output
    li $v0,4
    syscall
    
    end:

    jr $ra

