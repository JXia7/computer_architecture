		.include "./util.s"
		
		.data
prompt:		.asciiz "Enter a string: "
prefix:		.asciiz "You typed: "
		.align 2

		# $a0 string_to_modify
		# $a1 max_bytes
	
		.text
		
generate_echo_string:
		subi $sp,$sp,64
		sw $ra,60($sp)
		sw $a0,64($sp)	 # store string_to_modify in 60($sp)
		#sw $a1,52($sp)   # store max_bytes in 52($sp)
		#sw $s0,48($sp)
		
		
		# put \0 at the end of string_to_modify 
		# la $t0,($a0)
		# add $t0,$t0,$a1
		# sb $zero,($t0)
		sb $zero,55($sp)
		
		# get prefix length
		la $a0,prefix
		jal strlen
		sw $v0,56($sp) # store prefix_len to 52($sp)
		
		# strncpy
		la $a0,16($sp)
		la $a1,prefix
		li $a2,39
		jal strncpy
		
		lw $t0,56($sp)
		li $t1,40
		bge $t0,$t1,.End
		
		la $a0,prompt
		la $a1,16($sp)
		lw $t0,56($sp)
		add $a1,$a1,$t0
		li $a2,40
		sub $a2,$a2,$t0
		jal InputConsoleString
		
.End:
		la $a0,16($sp)
		jal PrintString
		
		lw $ra,60($sp)
		addi $sp,$sp,64
		jr $ra		

		.data
greeting:	.asciiz "Hi there!"
# max_bytes:	.word 32
		
		.text
		.globl main
main:
		subi $sp,$sp,20
		sw $ra,16($sp)
		
		la $a0,greeting
		# lw $a1,max_bytes
		jal generate_echo_string
		
		lw $ra,16($sp)
		addi $sp,$sp,20
		jr $ra


