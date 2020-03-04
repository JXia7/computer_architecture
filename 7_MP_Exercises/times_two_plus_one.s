	.data
number: .word -3

	.text
	.globl main
main:
	lw $a0,number
	jal times_two_plus_one
	
	move $a0,$v0
	li $v0,1
	syscall
	
	li $v0,10
	syscall
	
times_two_plus_one:
	subi $sp,$sp,20
	sw $ra,16($sp)
	sw $a0,20($sp)
	
	lw $a0,20($sp)
	jal multiply_by_two
	
	add $a0,$zero,$v0
	jal add_one
	
	lw $ra,16($sp)
	addi $sp,$sp,20
	jr $ra
	
add_one:
	addi $v0,$a0,1
	jr $ra

multiply_by_two:
	sll $v0,$a0,1
	jr $ra