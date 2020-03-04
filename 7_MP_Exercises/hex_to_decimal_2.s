		.include "./util.s"
		
		.data
my_string:	.space 40
prompt:		.asciiz "Enter a hexadecimal number: "
error:		.asciiz "Invalid hexadecimal number.\n"

		.text
		.globl main
main:
		subi $sp,$sp,24
		sw $ra,20($sp)	
Lwhile:		
		la $a0,prompt
		la $a1,my_string
		li $a2,40
		jal InputConsoleString
		
		la $a0,16($sp)
		la $a1,my_string
		jal axtoi
		
		lw $a0,16($sp)
		beqz $a0,Lif
		b Lelse
		
Lif:
		la $a0,error
		jal PrintString
		j Lwhile
Lelse:	
		jal PrintInteger
		b Lend

Lend:	
		lw $ra,20($sp)
		addi $sp,$sp,24
		jr $ra
