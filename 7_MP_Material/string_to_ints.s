	.data
prompt:	.asciiz "Enter string: "

	.text
	.globl main
main:
	subi	$sp, $sp, 44
	sw	$ra, 40($sp)
	sw	$s0, 36($sp)
	
	la	$a0, prompt
	addi	$a1, $sp, 16
	li	$a2, 20
	jal	InputConsoleString
	
	addi	$s0, $sp, 16
Lloop_begin:
	lb	$t1, ($s0)
	beqz	$t1, Lloop_end
	
	move	$a0, $t1
	jal	PrintInteger
	
	la	$a0, util_s_newline
	jal	PrintString

	addi	$s0, $s0, 1
	b	Lloop_begin
Lloop_end:
	lw	$s0, 36($sp)
	lw	$ra, 40($sp)
	addi	$sp, $sp, 44
	jr	$ra

.include "./util.s"