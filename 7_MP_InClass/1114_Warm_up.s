.include "./util.s"

# warm up
# ------------------------------
# write a function that accept
# a string as an argument. It
# should print that string with
# two stars on either side.
#
# so, if you give the function
# the string "hello", it should
# print "**hello**".

	.data
stars:	.asciiz "**"
	.align 2
	
	.text

print_with_stars:
	subi $sp,$sp,60
	sw $ra,56($sp)
	sw $a0,60($sp)
	
	la $a0,16($sp)
	la $a1,stars
	li $a2,2
	jal strncpy
	
	la $a0,18($sp)
	lw $a1,60($sp)
	li $a2,35
	jal strncpy
	
	# final[37] = "\0"
	sb $zero,53($sp) # 53 = 16 + 37
	
	la $a0,16($sp)
	jal strlen
	
	la $a0,16($sp)
	add $a0,$a0,$v0
	la $a1,stars
	li $a2,3
	jal strncpy
	
	la $a0,16($sp)
	jal PrintString
	
	lw $ra,56($sp)
	addi $sp,$sp,60
	jr $ra
	
	.data
greeting:	.asciiz "hello"
long_greeting:	.asciiz "hellohellohellohellohello"


	.text
	.globl main
main:
	subi $sp,$sp,20
	sw $ra,16($sp)
	
	la $a0,greeting
	jal print_with_stars
	
	la $a0,util_s_newline
	jal PrintString
	
	la $a0,long_greeting
	jal print_with_stars
	
	lw $ra,16($sp)
	addi $sp,$sp,20
	jr $ra
