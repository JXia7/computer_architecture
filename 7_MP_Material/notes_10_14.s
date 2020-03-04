# Warm-Up
# -------
# Write a function that accepts
# a string as an argument. It
# should print that string with
# two stars on either side.
#
# So, if you give the function
# the string "hello", it should
# print "**hello**".
# -------------------------------
# char *stars = "**";
#
# void print_with_stars(char *starter)
# {
#     int len;
#     char final[40];
#     strncpy(final, stars, 2);
#     strncpy(final + 2, starter, 35);
#     final[37] = '\0';
#     len = strlen(final);
#     strncpy(final + len, stars, 3);
#     PrintString(final);
# }


.include "./util.s"

	.data
stars:	.asciiz "**"
	.align 2

	.text

print_with_stars:
	subi	$sp, $sp, 60
	sw	$ra, 56($sp)
	sw	$a0, 60($sp)
	
	la	$a0, 16($sp)
	la	$a1, stars
	li	$a2, 2
	jal	strncpy
	
	la	$a0, 18($sp)
	lw	$a1, 60($sp)
	li	$a2, 35
	jal	strncpy
	
	# final[37] = '\0'
	# 53 = 16 + 37
	sb	$zero, 53($sp)
	
	la	$a0, 16($sp)
	jal	strlen
	
	la	$a0, 16($sp)
	add	$a0, $a0, $v0
	la	$a1, stars
	li	$a2, 3
	jal	strncpy
	
	la	$a0, 16($sp)
	jal	PrintString
	
	lw	$ra, 56($sp)
	addi	$sp, $sp, 60
	jr	$ra
	
	.data
greeting:	.asciiz "hello"
long_greeting:	.asciiz "hellohellohellohellohellohellohellohellohellohellohellohello"

	.text
	.globl main
main:
	subi	$sp, $sp, 20
	sw	$ra, 16($sp)
	
	la	$a0, greeting
	jal	print_with_stars
	
	la	$a0, util_s_newline
	jal	PrintString
	
	la	$a0, long_greeting
	jal	print_with_stars
	
	lw	$ra, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra