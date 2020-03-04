	 	.data
array: 		.word 0,3,-4,0,-3
array_size: 	.word 5
sum:		.word 0

		.text
		.globl main
main: 
		li $t4,0 # make zero
		lw $t2,sum
		
		la $t0,array
		lw $t1,array_size
		
		sll $t1,$t1,2
		add $t1,$t1,$t0
		
	Lbegin:
		bge $t0,$t1,Lend
		lw $t3,($t0)
		
		bgt $t4,$t3,Lif # if 0 > $t3, $t3 = |$t3|
		b Lelse
		
	Lif:
		abs $t5,$t3
		add $t2,$t2,$t5
		b Lexit
	Lelse:
		add $t2,$t2,$t3
	Lexit:
		
		addi $t0,$t0,4
		b Lbegin
		
	Lend:
	
		move $a0,$t2
		li $v0,1
		syscall
		
		jr $ra
