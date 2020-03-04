	.data
favorite_vegetable:	.asciiz "broccoli"
			.align 2

	.text
	.globl main
main:
	# load address of beginning of string
	la	$t0, favorite_vegetable	
Lloop_begin:
	# load current character, check for null
	lb	$t1, ($t0)
	beqz	$t1, Lloop_end

	# advance character by 1 (in a register)
	addi	$t1, $t1, 1
	
	# save that change in RAM
	sb	$t1, ($t0)
	
	# increment address
	addi	$t0, $t0, 1
	
	# loop back
	b	Lloop_begin

Lloop_end:
	
	# print resulting string
	la	$a0, favorite_vegetable
	li	$v0, 4
	syscall
	
	jr	$ra