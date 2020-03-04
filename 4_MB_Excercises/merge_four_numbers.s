.data
	a: .byte 1
	b: .byte 2
	c: .byte 4
	d: .byte 8

.text
.globl main
main:
	lb $t0, a
	lb $t1, b
	lb $t2, c
	lb $t3, d
	
	sll $a0, $t0, 0
	sll $a0, $a0, 8
	add $a0, $a0, $t1
	
	sll $a0, $a0, 8
	add $a0, $a0, $t2
	
	sll $a0, $a0, 8
	add $a0, $a0, $t3
	
	li $v0, 1
	syscall
	
	jr $ra
	
