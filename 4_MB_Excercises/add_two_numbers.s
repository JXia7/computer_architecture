.data
	x: .word 5
	y: .word 10
.text
.globl main
main:
	lw $t0, x($zero)
	lw $t1, y($zero)
	
	add $t2, $t0, $t1
	
	li $v0, 1
	add $a0, $zero, $t2
	syscall
	jr $ra