.data
prompt: .asciiz "Enter number: "
output: .asciiz "Sum of numbers: "

.text
.globl main
main:

la $a0, prompt
li $v0, 4
syscall

li $v0, 5
syscall

addi $t0, $v0, 0

la $a0, prompt
li $v0, 4
syscall

li $v0, 5
syscall

add $t0, $v0, $t0

#la $a0, output
#li $v0, 4
#syscall

addi $a0, $t0, 0
li $v0, 1
syscall

jr $ra
