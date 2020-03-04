    .data
min:       .word 1
max:       .word 10
num:       .word 8     # I'd recommend trying different values
                       # for this variable when testing.
msgintro:  .asciiz "Guess must be a hexadecimal number between "
msgand:    .asciiz " and "
msgend:    .asciiz "\nEnter your guess (or nothing to quit).\n"
msgnl:     .asciiz "\n"
msgwin:    .asciiz "Got it!"
msghigh:   .asciiz "Guess is too high."
msglow:    .asciiz "Guess is too low."

	   .align 2

    .text
    .globl main
main:
    ##################
    # YOUR CODE HERE #
    ##################

    # Step 1: Build prompt.
	subi $sp,$sp,80
	sw $ra,76($sp)
	
	# translate int min to hex min,
	# then storing in 16($sp).
	lw $a0,min
	la $a1,68($sp) # buffer in 68($sp)
	jal itoax
	
	# get the start addr of msgintro + min
	la $a0,msgintro
	la $a1,68($sp)
	jal strdup2
	
	move $a0,$v0
	la $a1,msgand
	jal strdup2
	
	sw $v0,16($sp) # 16($sp): "Guess must be a hexadecimal number between 1"
	
	lw $a0,max
	la $a1,60($sp) # buffer in 60($sp)
	jal itoax
	
	lw $a0,16($sp)
	la $a1,60($sp)
	jal strdup2
	
	move $a0,$v0
	la $a1,msgend
	jal strdup2
	
	sw $v0,16($sp)
	
	# move $a0,$v0
	# jal PrintString

    # Step 2: Repeatedly use GetGuess to get a guess
    # from the user and report if it is too high, too
    # low, or correct.

.MainLoop:
	lw $a0,16($sp)
	lw $a1,min
	lw $a2,max
	jal GetGuess
	
	move $t0,$v0 #$v0 contains the number of input
	
	li $t1,-1
	beq $t0,$t1,.Lreturn
	
	lw $t2,num
	beq $t0,$t2,.LprintWin
	bgt $t0,$t2,.LprintHigh	
	blt $t0,$t2,.LprintLow
	
.LprintLow:
	la $a0,msglow
	jal PrintString	
	b .MainLoop
	
.LprintHigh:
	la $a0,msghigh
	jal PrintString
	b .MainLoop

.LprintWin:
	la $a0,msgwin
	jal PrintString
	b .MainEnd
	
.Lreturn:
	li $v0,-1
.MainEnd:

	lw $ra,76($sp)
	addi $sp,$sp,80
	jr $ra
	
################################
# GetGuess
################################
    .data
invalid:    .asciiz "Not a valid hexadecimal number"
badrange:   .asciiz "Guess not in range"

	    .align 2

    .text
    .globl  GetGuess
# 
# int GetGuess(char * question, int min, int max)
# -----
# This is your function from assignment 5. It repeatedly
# asks the user for a guess until the guess is a valid
# hexadecimal number between min and max.
GetGuess:
    
    ###################################
    # YOUR CODE FROM ASMT 5 HERE      #
    ###################################    
	subi $sp,$sp,64
	sw $ra,60($sp)
	sw $a0,64($sp) # prompt
	sw $a1,56($sp) # min
	sw $a2,52($sp) # max
	
.WhileLoop:
	lw $a0,64($sp) # prompt
	la $a1,32($sp) # buffer (the addr of the read)
	li $a2,16      # max_bytes
	jal InputConsoleString
	
	# if bytes_read == 0
	la $a0,32($sp)
	jal strlen
	beqz $v0,.Return
	
	# status
	la $a0,16($sp) # the addr of theguess
	la $a1,32($sp) # the bytes_read
	jal axtoi
	
	# if status != 1
	li $t0,1
	bne $v0,$t0,.Lif_PrintInvalid
	b .Lelse_KeepGo
	
.Lif_PrintInvalid:
	la $a0,invalid
	jal PrintString
	j .WhileLoop	
	
.Lelse_KeepGo:	
	# if theguess < min || theguess > max
	lw $t0,16($sp)
	lw $t1,56($sp) # min
	lw $t2,52($sp) # max
	blt $t0,$t1,.PrintBadRange
	bgt $t0,$t2,.PrintBadRange
	
	# return theguess
	lw $v0,16($sp)
	b .End
	
.PrintBadRange:
	la $a0,badrange
	jal PrintString
	j .WhileLoop
	
.Return:
	li $v0,-1		

.End:
	lw $ra,60($sp)
	addi $sp,$sp,64

    jr      $ra

###################################
#     OTHER HELPER FUNCTIONS      #
###################################

#
# char * strdup2 (char * str1, char * str2)
# -----
# strdup2 takes two strings, allocates new space big enough to hold 
# of them concatenated (str1 followed by str2), then copies each 
# string to the new space and returns a pointer to the result.
#
# strdup2 assumes neither str1 no str2 is NULL AND that malloc
# returns a valid pointer.
    .globl  strdup2
strdup2:
    # $ra   at 28($sp)
    # len1  at 24($sp)
    # len2  at 20($sp)
    # new   at 16($sp)
    sub     $sp,$sp,32
    sw      $ra,28($sp)
    
    # save $a0,$a1
    # str1  at 32($sp)
    # str2  at 36($sp)
    sw      $a0,32($sp)
    sw      $a1,36($sp)
    
    # get the lengths of each string 
    jal     strlen
    sw      $v0,24($sp)

    lw      $a0,36($sp)
    jal     strlen
    sw      $v0,20($sp)

    # allocate space for the new concatenated string 
    add     $a0,$v0,1
    lw      $t0,24($sp)
    add     $a0,$a0,$t0
    jal     malloc
    
    sw      $v0,16($sp)

    # copy each to the new area 
    move    $a0,$v0
    lw      $a1,32($sp)
    jal     strcpy

    lw      $a0,16($sp)
    lw      $t0,24($sp)
    add     $a0,$a0,$t0
    lw      $a1,36($sp)
    jal     strcpy

    # return the new string
    lw      $v0,16($sp)
    lw      $ra,28($sp)
    add     $sp,$sp,32
    jr      $ra

    .include  "./util.s"
