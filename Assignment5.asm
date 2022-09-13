.data
	prompt:.asciiz "Input a number please: \n"
	theNum:.asciiz "You entered: "
	newline:.asciiz "\n"
	comma:.asciiz" ,"
	max:.asciiz "The max number is "
	less:.asciiz "The smallest number is "
	average:.asciiz "The average number is "
.text
	#reg $t0 is given the value of -10000 because
	#it can be assumed the user will enter a non negative number
	#and when comapred, it will be greater than what is in $t0
	Li $v0, 4
	La $a0, prompt
	syscall
	Li $v0, 5
	syscall
	move $t0, $v0 
	
	Li $v0, 4
	La $a0, theNum
	syscall
	#the int value of the users inputted number is printed
	#after being transfered to $a0
	Li $v0, 1
	move $a0, $v0
	syscall
	#newline is printed after the int value is printed at the end of theNum string
	Li $v0, 4
	La $a0, newline
	syscall

	#s0 is loaded with value 0. this is the value
	#that counts how many times it has gone through the loop
	Li $s0, 0
	#$s1 contains a value of how many times we want our while loop to execute. 
	#We want the loop to execute 10 times
	Li $s1, 8
	
	#while statement will continue until it reaches 10 iterations
	#once $s0 has the value of 10 and it is compared to 10, it will stop and go to label exit
	#and print out the max of the numbers entered and then exit the program
	while:
		bgt $s0, $s1, exit
		
		#prompt for the user to enter a number
		Li $v0, 4
		La $a0, prompt
		syscall
		
		#capture of input and value in $t0 transfered to $t1
		Li $v0, 5
		syscall
		move $t1, $v0
		
		#function compareNum will compare values in $t0 and $t1 (is $t1>$t0)
		jal compareNum
		#jal compareNum2
		#function printNum prints out the value the user entered 
		jal printNum
		#value of 1 added to $s0 to note that the loop has gone through once
		addi $s0,$s0,1
		#j while jumps back to the while loop
		J while
	
	exit:
		#string that says the max number
		Li $v0, 4
		La $a0, less
		syscall
		#the greatest number is stored in $t0 and then printed after being moved to $a0
		Li $v0, 1
		move $a0, $t0
		syscall
		
		Li $v0, 4
		La $a0, newline
		syscall
		
		Li $v0, 4
		La $a0, max
		syscall
		#the greatest number is stored in $t0 and then printed after being moved to $a0
		Li $v0, 1
		move $a0, $t1
		syscall
		
		Li $v0, 4
		La $a0, newline
		syscall
		
		add $s2, $t0, $t1
		div $s2, $s2, 2
		
		Li $v0, 4
		La $a0, average
		syscall
		
		Li $v0, 1
		move $a0, $s2
		syscall
		
		#exits program
		Li $v0, 10
		syscall
	printNum:
		#string that states that the user number
		Li $v0, 4
		La $a0, theNum
		syscall
		#the int value of the users inputted number is printed
		#after being transfered to $a0
		Li $v0, 1
		move $a0, $t1
		syscall
		#newline is printed after the int value is printed at the end of theNum string
		Li $v0, 4
		La $a0, newline
		syscall
		#jr will tell the PC the memory location of the next instr. in our loop as $ra contains a memory location
		jr $ra
		
	compareNum:
		#comparrison of the two registers are done
		#if the value in $t1 is greater than $t0, it will then do the move instruction
		#and then exit once it reaches thje done label.
		#if the value in $t0 is bigger than $t1, it will then branch to the done label
		#and return to the while loop
		bgt $t0, $t1, returnToLoop
		else:
			move $t3, $t0
			jr $ra
			syscall
		#blt 
	
	returnToLoop:
		move $t1, $t0
		jr $ra
		syscall
		
		
						
		
			
		
	
