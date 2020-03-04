	 	.data
array: 		.word 0,-3
array_size: 	.word 2
count:		.word 0

		.text
		.globl main
main: 
		lw $t2,count
		
		la $t0,array
		lw $t1,array_size
		
		sll $t1,$t1,2
		add $t1,$t1,$t0
		
	Lbegin:
		bge $t0,$t1,Lend
		lw $t3,($t0)
		
		beqz $t3,Lif
		b Lexit
		
	Lif:
		addi $t2,$t2,1
	Lexit:
		
		addi $t0,$t0,4
		b Lbegin
		
	Lend:
	
		move $a0,$t2
		li $v0,1
		syscall
		
		jr $ra
			
