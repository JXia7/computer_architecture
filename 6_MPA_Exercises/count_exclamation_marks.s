		.data 
sentence:	.asciiz "Hello! Nice to meet you! My name is MIPS."

		.text
		.globl main
main:
		li $t2,0  # count
		li $t3,33 # !
		
		la $t4,sentence
		
	Lbegin:
		add $t5,$t4,$t0
		lb $t6,($t5)  # sentence
		
		beqz $t6,Lend
		
		beq $t6,$t3,Lif
		b Lexit
		
	Lif:
		addi $t2,$t2,1
	Lexit:
	
		addi $t0,$t0,1
		b Lbegin	
	Lend:
	
		move $a0,$t2
		li $v0,1
		syscall
		
		jr $ra
