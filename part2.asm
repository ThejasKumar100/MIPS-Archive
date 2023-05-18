#Thejaswin Kumaran
#TXK210042
#CS 2340-501

#Nhut Nguyen
#HW 3 - Part 2

.data 

initialPrompt:  .asciiz     "\nGive me a number between 1 and 10 (0 to stop): "
secondPrompt: .asciiz     "The count down of integers from "
secondPrompt2: .asciiz     " is: "
itrPrompt: .asciiz 	"ITERATIVE: "
recPrompt: .asciiz	"RECURSIVE: "
spacePrompt: .asciiz	" "
endPrompt: .asciiz	"\n<<<Ending Program>>>"
newLinePrompt: .asciiz "\n"

.text	#---Part 1---------------------------------------------------------------------

reAsk:
#Asks for a value 0-10:
la $a0, initialPrompt
li $v0, 4
syscall

#Stores input value
li $v0, 5
syscall
move $t0, $v0 #Storing input in $t0

beq $t0, $zero, end

la $a0, secondPrompt
li $v0, 4
syscall

li $v0, 1 #Printing out the value of a register
move $a0, $t0
syscall

la $a0, secondPrompt2
li $v0, 4
syscall

la $a0, newLinePrompt
li $v0, 4
syscall

#D


la $a0, itrPrompt
li $v0, 4
syscall

move $t3, $t0
move $t4, $t0
#loop:
itr_countdown:
li $v0, 1 
move $a0, $t0	#Prints value in $t0
syscall

la $a0, spacePrompt
li $v0, 4
syscall

addi $t0, $t0, -1

blt $t0, $zero, recSection
#j loop
jal itr_countdown



recSection:
la $a0, newLinePrompt
li $v0, 4
syscall

la $a0, recPrompt
li $v0, 4
syscall

move $t0, $t3

rec_countdown:
li $sp, -8    #Allocates memory for return adresses in the stack
sw $ra, 4($sp)
sw $t0, 0($sp)

blt $t0, $s0, reAsk

li $v0, 1    #Prints values
move $a0, $t0
syscall

la $a0, spacePrompt    #Print space to parse values
li $v0, 4
syscall

addi $t0, $t0, -1
jal rec_countdown


end:
li $v0, 10
syscall
