# C code
# ------
#
# char * secret_word = "hello";
# char * message = "Enter guess: ";
#
# int main()
# {
#	char input[20];
# 	int equal;
#
#	// outer loop
# 	while (1)	# while (true)
# 	{
#		equal = 1;
# 		InputConsoleString(message, input, 20);
#		char * cur_guess = input;
#		char * cur_secret = secret_word;
#
#		// inner loop
#		while (1)
#		{
#			if (*cur_guess != *cur_secret)
#			{
#				equal = 0;
#				break;
#			}
#			if (*cur_guess == '\0')
#			{
#				break;
#			}
#			cur_guess++;
#			cur_secret++;
#		}
#
#		if (equal == 1)
#		{
#			break;
#		}
# 	}
# }

	.data
secret_word:	.asciiz "hello"
message:	.asciiz "Enter guess: "

	.text
	.globl main
main:
	# setup
	subi	$sp, $sp, 44
	sw	$ra, 40($sp)
	sw	$s0, 36($sp)
	
Louter_loop_begin:
	li	$s0, 1		# equal = 1; (***)
	
	la	$a0, message
	la	$a1, 16($sp)	# addi	$a1, $sp, 16
	li	$a2, 20
	jal	InputConsoleString
	
	la	$t1, 16($sp)		# $t1 = input (or &input[0])
	la	$t2, secret_word	# $t2 = secret_word (or &secret_word[0])
	
Linner_loop_begin:
	lb	$t3, ($t1)	# *cur_guess
	lb	$t4, ($t2)	# *cur_secret
	beq	$t3, $t4, Lif_equal	# if (*cur_guess == *cur_secret)
	li	$s0, 0		# equal = 0;
	b	Linner_loop_end	# break;

Lif_equal:
	beqz	$t3, Linner_loop_end	# if (*cur_guess == '\0') break;
	addi	$t1, $t1, 1		# cur_guess++;
	addi	$t2, $t2, 1		# cur_secret++;
	b	Linner_loop_begin

Linner_loop_end:
	li	$t5, 1
	# beq	$s0, $t5, Louter_loop_end	# if (equal == 1) break;
	# b	Louter_loop_begin
	
	bne	$s0, $t5, Louter_loop_begin

Louter_loop_end:
	
	# cleanup
	lw	$s0, 36($sp)
	lw	$ra, 40($sp)
	addi	$sp, $sp, 44
	jr	$ra

	.include "./util.s"





