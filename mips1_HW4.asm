#Thejaswin Kumaran
#TXK210042
#CS 2340-501

#Nhut Nguyen
#HW 4

.data #Library of labels----------------------------------------------------------------------------

firstPrompt:  .asciiz  "How many circle pizzas have you sold today?\n"
secondPrompt: .asciiz	"How many square pizzas have you sold today\n"
thirdPrompt:  .asciiz	"What is an estimate of the pizza sold measured in square feet?\n"

fourthPrompt: .asciiz  "Total amount of pizzas sold (in square feet) >>> "
fifthPrompt:  .asciiz  "Square Feet of circular pizza sold >>> "
sixthPrompt:  .asciiz  "Square Feet of square pizza sold >>> "

wosh: .asciiz  "Woosh!"
bum:  .asciiz  "Bummer!"

inchFoot: .float 144.00
pi: .float 3.141592
temp2: .float 0.00
newLine:      .asciiz  "\n"

#Variables:

#temp1 - $t2

#Circle pizzas count - $s0
#Square pizzas count - $s1
#Given estimate of pizza sold [as a floating point] - $s2
#Square inches of Circular pizza - $s3
#Square inches of Square pizza - $s4
#Actual sum of pizza sold by square inch [stored by floating point] - $s5
#

#Square feet of circular pizza sold - $f1
#Count of pizzas / Square feet of square pizza sold - $f2
#Diameter - $f3
#pi / temp3 - $f4
#Temp / Sum - $f5
#Temp2 - temp2:





.text #Executable stuff-----------------------------------------------------------------------------

#Prompting the user for the first value:
la $a0, firstPrompt #Gives the address of the prompt
li $v0, 4
syscall

#Recieving user input:
li $v0, 5
syscall
move $s0, $v0 #Circle pizzas count - $s0

#Prompts user for the second value:
la $a0, secondPrompt
li $v0, 4
syscall

li $v0, 5
syscall
move $s1, $v0 #Square pizzas count - $s1


#Prompting the user for the floating point value:
la $a0, thirdPrompt
li $v0, 4
syscall

#Stores the square feet of pizza in a floating point
li $v0, 6 
syscall
swc1 $f0, temp2 #Given estimate of pizza sold - $s2


#Calculation for the actual amount of pizza sold

mtc1 $zero, $f1
cvt.s.w $f1 $f1

#Circular pizza:
mtc1 $s0, $f2
cvt.s.w $f2, $f2

li $t1, 11 #Load Diameter

srl $t1, $t1, 1

mtc1 $t1, $f3
cvt.s.w $f3 $f3 #Converts a value form int to float
lwc1 $f4, pi #lwc1 to load the value of PI to help the find the total area of circle pizzas sold

li $t2, 2
mtc1 $t2, $f5
cvt.s.w $f3 $f5

#Find the radius
#div.s $f3, $f3, $f5
mul.s $f3, $f3, $f3
mul.s $f3, $f3, $f4
mul.s $f2, $f2, $f3

#Conversion from square inches to square feet
lwc1 $f5, inchFoot
div.s $f2, $f2, $f5

add.s $f1, $f1, $f2


#li $t2, 30.25    #30.25 = the radius of the pizza squared
#mul $s3, $s0, $t2


#Square pizza:
li $t2, 9
mul $s4, $t2, $t2
mul $s4, $s4, $s1
add $s5, $s5, $s4 #The square inches of pizzas sold

mtc1 $t1, $f2
cvt.s.w $f2 $f2
lwc1 $f5, inchFoot
div.s $f2, $f2, $f5

#Total square feet of pizza sold is calculated just before printing



#3a---Output--------------------------------------------------------------------------
la $a0, newLine
li $v0, 4
syscall

#Prints the total pizza sales
add $t2, $s0, $s1
la $a0, fourthPrompt
li $v0, 4
syscall

add.s $f5, $f1, $f2 #Gets the total square feet of pizza sold
li $v0 2
mov.s $f12, $f5
syscall

#Printing circular pizza sales
la $a0, newLine
li $v0, 4
syscall

la $a0, fifthPrompt
li $v0, 4
syscall

li $v0 2
mov.s $f12, $f1
syscall


#Printing square pizza sales
la $a0, newLine
li $v0, 4
syscall

la $a0, sixthPrompt
li $v0, 4
syscall

li $v0 2
mov.s $f12, $f2
syscall


#Prints Woosh/Bummer
la $a0, newLine
li $v0, 4
syscall


lwc1 $f4, temp2
#bgt $f5, $f4, lbl

c.le.s $f4, $f5
bc1t lbl

la $a0, wosh
li $v0, 4
syscall
j out

lbl:
la $a0, bum
li $v0, 4
syscall

out:

#Ending program
li $v0, 10
syscall
