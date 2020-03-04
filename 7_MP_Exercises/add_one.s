	.data
number: .word 9

	.text
	.globl main
main:
	lw $a0,number
	jal add_one
	
	move $a0,$v0
	li $v0,1
	syscall
	
	li $v0,10
	syscall
	
add_one:
	addi $v0,$a0,1
	jr $ra