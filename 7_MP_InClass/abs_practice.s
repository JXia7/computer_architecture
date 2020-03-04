	 	.data
array: 		.word -3,0
array_size: 	.word 2
sum:		.word 0

		.text
		.globl main
main: 
		lw $t2,sum
		
		lw $t0,array
	
		abs $t1,$t0
		add $t2,$t2,$t1



		move $a0,$t2
		li $v0,1
		syscall
		
		jr $ra
