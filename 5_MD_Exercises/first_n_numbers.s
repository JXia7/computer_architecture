.data
    prompt: .asciiz "Enter number: "
    prompt1: .asciiz "\n "

.text
.globl main
main:
    li $v0,4
    la $a0,prompt
    syscall
    
    li $v0,5
    syscall
    
    move $s0,$v0,
    
    li $t0,1
    loop:
        li $v0,1
        move $a0,$t0
        syscall
        
        li $v0,4
        la $a0,prompt1
        syscall
        
        add $t0,$t0,1
        
        ble $t0,$s0,loop

    jr $ra
