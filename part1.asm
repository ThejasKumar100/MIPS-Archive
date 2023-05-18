#Thejaswin Kumaran
#TXK210042
#CS 2340-501

#Nhut Nguyen
#HW 3 - Part 1

.data 

initialPrompt:  .asciiz     "Please enter a number between 0 and 100. Enter 0 to stop the program. \n"
invalidPrompt: .asciiz     "Error: The number you entered invalid because it is outside the set range."
sumPrompt: .asciiz     "The double sum of integers from 0 to "
sumPrompt2: .asciiz     " is: "
endPrompt: .asciiz	"\n\n<<<Ending Program>>>"

ary: .word 100 #Allocates 100 BYTES (32 * 100 BITES) of memory for an array

.text	#---Part 1---------------------------------------------------------------------

#Asks for a value 0-100:
la $a0, initialPrompt #Gives the address of the prompt
li $v0, 4
syscall

#Stores input value
li $v0, 5
syscall
move $t0, $v0 #Storing input in $t0

#Checks if the input is out of range
li $s1, 101
bge $t0, $s1, invalid
beq $t0, $zero, end


add $t1, $t0, $t0
li $t2, 0
la $s2, ary
sw $t2, ($s2)

#Then-while loop
loop:
addi $t2, $t2, 2
addi $s2, $s2, 4
add $t4, $t4, $t2

bgt $t2, $t1, ongoing
sw $t2, ($s2)
lw $t3, ($s2)


j loop


ongoing:	#Resumes the code


li $v0, 4
la $a0, sumPrompt
syscall

#Prints out the value of a register($t0)
li $v0, 1
move $a0, $t0
syscall

li $v0, 4
la $a0, sumPrompt2
syscall


sub $t4, $t4, $t2
li $v0, 1
move $a0, $t4
syscall

j end


#Ending Functions-------------------------------------------------------------------------------

#Input is invalid
invalid:
la $a0, invalidPrompt
li $v0, 4
syscall
j end


#End Prgram function
end:
la $a0, endPrompt
li $v0, 4
syscall

li $v0, 10
