#Thejaswin Kumaran
#TXK210042
#CS 2340-501

#Nhut Nguyen
#HW 1

.data #Library of labels----------------------------------------------------------------------------

#labelName: .asciiz (Redirective that translates text into bytecode)
firstLabel:  .asciiz     "Please enter your first number: "
secondLabel: .asciiz     "Please enter your second number: "
thirdLabel: .asciiz     "Result: "

.text #Executable stuff-----------------------------------------------------------------------------

#Prompting the user for the first value:
la $a0, firstLabel #Gives the address of the prompt
li $v0, 4
syscall #Actual print statement

#Recieving user input:
li $v0, 5
syscall
move $s0, $v0 #Storing input in $s0


#Prompts user for the second value:
la $a0, secondLabel
li $v0, 4
syscall

li $v0, 5
syscall
move $s1, $v0

#Displayng result prompt:
li $v0, 4
la $a0, thirdLabel
syscall

#Creating the argument and moving it to $a0:
sub $s3, $s0, $s1
move $a0, $s3

li $v0, 1
syscall


#Erasing register
li $v0, 10
syscall