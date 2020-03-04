#######################
# Variables
#######################
	.data
arr:	.word 10, -5, 2, 0, 20, 21, -7, 8, 2
Nelems:	.word 9
num:	.word 2
min:	.word 0
max:	.word 10

s_array:	.asciiz "Array:\n-----\n"
s_newline:	.asciiz "\n"
s_result:	.asciiz "Result:\n-----\n"

	.text
	.globl main
main:

	#############################
	# Setup (don't worry about
	# this code)
	#############################
	addiu	$sp, $sp, -20
	sw		$ra, 16($sp)
	
	#############################
	# Your code here...
	#############################
	
	
	
	

	#############################
	# This code outputs the array.
	#
	la		$a0, s_array
	li		$v0, 4
	syscall

	li		$t0, 0
	la		$t1, arr
	lw		$t2, Nelems
Larr_output_begin:
	beq 	$t0, $t2, Larr_output_done
	sll		$t3, $t0, 2
	add		$t4, $t3, $t1

	lw		$a0, 0($t4)
	li		$v0, 1
	syscall

	la		$a0, s_newline
	li		$v0, 4
	syscall

	addi	$t0, $t0, 1
	b		Larr_output_begin
	
Larr_output_done:

	la		$a0, s_newline
	li		$v0, 4
	syscall
	
	##############################
	# This code outputs the
	# result, assuming you left
	# it in $t7.
	la		$a0, s_result
	li		$v0, 4
	syscall

	move	$a0, $t7
	li		$v0, 1
	syscall

	la		$a0, s_newline
	li		$v0, 4
	syscall
	
	#############################
	# Cleanup (don't worry about
	# this code)
	#############################
	lw		$ra, 16($sp)
	addiu	$sp, $sp, 20
	jr		$ra
