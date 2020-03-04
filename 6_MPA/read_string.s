	.data
greeting:	.asciiz "Nice to meet you, "
		.align 2
greeting_end:	.asciiz "!\n"
		.align 2
user_name:	.space 40
		.align 2

	.text
	.globl main
main:
	# read string from user
	la	$a0, user_name
	li	$a1, 40
	li	$v0, 8
	syscall
	
	# get rid of newline
	la	$t0, user_name
	li	$t1, '\n'
Lloop_begin:
	lb	$t2, ($t0)
	beq	$t2, $t1, Lloop_end
	beqz	$t2, Lloop_end

	addi	$t0, $t0, 1
	b	Lloop_begin
	
Lloop_end:
	sb	$zero, ($t0)
	
	# print initial greeting
	la	$a0, greeting
	li	$v0, 4
	syscall
	
	# print user name
	la	$a0, user_name
	li	$v0, 4
	syscall
	
	# print greeting end
	la	$a0, greeting_end
	li	$v0, 4
	syscall
	
	jr	$ra