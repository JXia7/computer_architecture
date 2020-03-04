	
print_countdown:
	subi $sp,$sp,20
	sw $ra,16($sp)
	bltz $a0,.Lprint_countdown_return
	
	sw $a0,20($sp)
	# move $a0,$a0 (no op) 
	jal PrintInteger
	
	lw $a0,20($sp)
	subi $a0,$a0,1
	jal print_countdown
	
.Lprint_countdown_return
	lw $ra,16($sp)
	addi $sp,$sp,20
	jr $ra
		
