.data
	table: .word 1,2,3,4,5,6,7,8,9,10
	       .word 11,12,13,14,15,16,17,18,19,20
	       .word 21,22,23,24,25,26,27,28,29,30
	       .word 31,32,33,34,35,36,37,38,39,40
	       .word 41,42,43,44,45,46,47,48,49,50
	       .word 51,52,53,54,55,56,57,58,59,60
	       .word 61,62,63,64,65,66,67,68,69,70
	       .word 71,72,73,74,75,76,77,78,79,80
	       .word 81,82,83,84,85,86,87,88,89,90
	       .word 91,92,93,94,95,96,97,98,99,100
	message:.asciiz "End of program.\n"
	newline:.asciiz"\n"
	comma:.asciiz", "
	
	seperator:.asciiz"\n-------------------------------------------------------------------------------\n"
	menuOption1:.asciiz "1) Display Array\n"
	menuOption2:.asciiz "2) Print a row\n"
	menuOption3:.asciiz "3) Print a column\n"
	menuOption4:.asciiz "4) Multiply row by a constant\n"
	menuOption5:.asciiz "5) Add 2 Rows\n"
	menuOption6:.asciiz "6) Swap 2 Rows\n"
	menuOption7:.asciiz "7) Print any cell\n"
	menuOption8:.asciiz "8) Swap 2 cells\n"
	menuOption9:.asciiz "9) Quit\n"
	enterChoice:.asciiz"Enter your choice: "
	
	enterRowNum:.asciiz"Enter a row number: \n"
	enterColNum:.asciiz"Enter a col number: \n"
	enterRowNum1S:.asciiz"Enter the first row number: \n"
	enterColNum1S:.asciiz"Enter the first col number: \n"
	enterRowNum2S:.asciiz"Enter the second row number: \n"
	enterColNum2S:.asciiz"Enter the second col number: \n"
	result1:.asciiz"The cell "
	result2:.asciiz" contains the value of "
	enterConst:.asciiz"Enter a value: \n"
	enterRowNum1:.asciiz"Enter the first row number: \n"
	enterRowNum2:.asciiz"Enter the second row number: \n"
	enterRowNum3:.asciiz"What row do you want to store the result: \n"
	enterRowNum4:.asciiz"Enter the first row to be swapped: \n"
	enterRowNum5:.asciiz"Enter the second row to be swapped: \n"	
	successMessage:.asciiz "The changes have been successfully saved.\n"
	
	
.text
	menuLoop:
		#seperator print out before menu options for readability
		Li $v0, 4
		La $a0, seperator
		syscall
		
		#option 1 is to print the array
		Li $v0, 4
		La $a0, menuOption1
		syscall
		
		#option 2 is to print a row
		Li $v0, 4
		La $a0, menuOption2
		syscall
		
		#option 3 is to print a column
		Li $v0, 4
		La $a0, menuOption3
		syscall
		
		#option 4 is to mult a row by a constant
		Li $v0, 4
		La $a0, menuOption4
		syscall
		
		#option 5 is to add 2 rows
		Li $v0, 4
		La $a0, menuOption5
		syscall
		
		#option 6 is to swap rows
		Li $v0, 4
		La $a0, menuOption6
		syscall
		
		#option 7 is to print a cell
		Li $v0, 4
		La $a0, menuOption7
		syscall
		
		#option 8 quits the program
		Li $v0, 4
		La $a0, menuOption8
		syscall
		
		Li $v0, 4
		La $a0, menuOption9
		syscall
		
		#menu option is stored as an int and kept in register $a1
		Li $v0, 4
		La $a0, enterChoice
		syscall
		
		Li $v0, 5
		syscall
		move $a1, $v0
		
		#newline for readability
		Li $v0, 4
		La $a0, newline
		syscall
		
		beq $a1, 1, printArrayLoad
		beq $a1, 2, printRowPrompt
		beq $a1, 3, printColPrompt
		beq $a1, 4, multRowPrompt
		beq $a1, 5, addTwoRowPrompt
		beq $a1, 6, swapTwoRowPrompt
		beq $a1, 7, printCellPrompt
		beq $a1, 8, cellSwapPrompt
		beq $a1, 9, exit
	#########################################################################
	#	~When the user enters 1, the user is brought to the label	#
	#	printArrayLoad which loads in registers to be used		#
	#	while calculating the offset.				        #
	#	~$t0 and $t1 are for col and row				#
	#	~$t4 contains size of the col					#
	#	~$t5 contains wordsize						#
	#	~s0 and s1 will be used in the loop				#
	#########################################################################
	printArrayLoad:
		Li $t0, 0
		Li $t1, 0
		Li $t4, 10
		Li $t5, 4
		
		Li $s0, 0
		Li $s1, 100
	####################################################################################
	#	~Offset is calculated using the general formula				   #
	#	~offset = rowIndex ($t0) * colSize ($t4) + colIndex ($t1) * wordSize ($t5) #
        #	~the result of offset is then stored in $t2 and to dereference the data    #
        #	from memory, it is stored in $a0 for prinmting purposes                    #
        #	~every 10 rows will result in a newLine being printed 			   #
        ####################################################################################
	printArray:
		beq $s0, $s1, menuLoop
		
		mul $t2, $t0, $t4
		add $t2, $t2, $t1
		mul $t2, $t2, $t5
		#addi $t0, $t0, 1
		addi $t1, $t1, 1
		addi $s0, $s0, 1
		
		Li $v0, 1
		Lw $a0, table($t2)
		syscall
		
		Li $v0, 4
		La $a0, comma
		syscall
		beq $s0, 10, printNewLine
		beq $s0, 20, printNewLine
		beq $s0, 30, printNewLine
		beq $s0, 40, printNewLine
		beq $s0, 50, printNewLine
		beq $s0, 60, printNewLine
		beq $s0, 70, printNewLine
		beq $s0, 80, printNewLine
		beq $s0, 90, printNewLine
		j printArray
		
	#########################################################################
	printNewLine:
		#after every 10 elements, a newline is printed when prinitng the entire array
		#and then jumps back to printArray
		Li $v0, 4
		La $a0, newline
		syscall
		
		j printArray
		
	#########################################################################
	#	~when the user enters 2, they will be transported to		#
	#	~a prompt that asks them what row they want printed		#
	#	and then that row number is stored in $t0			#
	#	~$s0 and $s1 have the values that control the loop		#
	#	~$t4 contains the col size and $t5 the word size		#
	#########################################################################
	printRowPrompt:
		Li $v0, 4
		La $a0, enterRowNum
		syscall
		
		Li $v0, 5
		syscall
		move $t0, $v0
		
		Li $s0, 0
		Li $s1, 10
		
		Li $t4, 10
		Li $t5, 4
		
	#########################################################################################
	#	~offset calculation is the same as before 					#
	#	~offset (t2) = rowIndex ($t0) * colSize ($t4) + colIndex ($s0) * wordSize ($s0) #
	#########################################################################################
	printRow:
		beq $s0, $s1, menuLoop
		
		mul $t2, $t0, $t4
		add $t2, $t2, $s0
		mul $t2, $t2, $t5
		addi $s0, $s0, 1
		
		Li $v0, 1
		Lw $a0, table($t2)
		syscall
		
		Li $v0, 4
		La $a0, comma
		syscall
		
		j printRow

	#########################################################################
	#	~printColPrompt is what the user will come to if they enter 3   #
	#	~similar operation to printRow but now we print the col 	#
	#	~$s0 and $s1 for the loop					#
	#	~$t0 to just print the first elements of the row since          #
	#	~we are printing the whole line					#
	#########################################################################
	
	printColPrompt:
		Li $v0, 4
		La $a0, enterColNum
		syscall
		
		Li $v0, 5
		syscall
		move $t0, $v0
		
		Li $s0, 0
		Li $s1, 10

		Li $t4, 10
		Li $t5, 4
		
	#########################################################################
	#	~math to print a column is slighty modified here		#
	#	~equation:							#
	#	offset ($t2) = rowIndex($s0) * colSize ($t4) + colIndex ($t0)   #
	#	*wordSize ($t5)							#
	#########################################################################
	printCol:
		beq $s0, $s1, menuLoop
		
		mul $t2, $s0, $t4
		add $t2, $t2, $t0
		mul $t2, $t2,$t5
		addi $s0, $s0, 1
		Li $v0, 1
		Lw $a0, table($t2)
		syscall
		Li $v0, 4
		La $a0, comma
		syscall
		
		j printCol
			
	#########################################################################
	#	~multRowPrompt will be prompted when the user			#
	#	enters 4 in the menu						#
	#	~a constant is asked from the user and they enter it		#
	#	~the constant is then stored in $a1				#
	#	~a row number is then requested and stored in $t0		#
	#	~$s0 and $s1 controls the loop					#
	#	~$t4 holds the colSize and $t5 has the word size		#
	#########################################################################
	multRowPrompt:
		Li $v0, 4
		La $a0, enterConst
		syscall
		
		Li $v0, 5
		syscall
		move $a1, $v0
		
		Li $v0, 4
		La $a0, enterRowNum
		syscall
		
		Li $v0, 5
		syscall
		move $t0, $v0
		
		Li $s0, 0
		Li $s1, 9
		
		Li $t4, 10
		Li $t5, 4
		
	#########################################################################
	#	~equation breakdown:						#
	#	offset ($t2) = rowIndex ($t0) * colSize ($t4) + colIndex ($s0)  #
	#	*wordSize($t5)							#
	#	~word derefrenced to $a2 and then multiplied by the const	#
	#	$a1								#
	#	~sw then places the new multiplied number in $a2 back in 	#
	#	the row								#
	#########################################################################
	multNumber:
		bgt $s0, $s1, success
		
		mul $t2, $t0, $t4
		add $t2, $t2, $s0
		mul $t2, $t2, $t5
		addi $s0, $s0, 1
		
		Lw $a2, table($t2)
		mul $a2, $a2, $a1
		sw $a2, table($t2)
				
		j multNumber	
		
	#########################################################################
	#	~addTwoRowPrompt will be prompted to the user once		#
	#	they choose menu option 5.					#
	#	~rowNumber 1 is first asked off and then placed in $t0		#
	#	and rowNumber 2 is stored in $t1				#
	#	~rowNumber3 (the row to have the product of the two rows)	#
	#	will be stored in $t2						#
	#	~$t3 will have colSize and $t4 will have word size		#
	#	~$s0 and $s1 will control the loop				#
	#########################################################################
	addTwoRowPrompt:
		Li $v0, 4
		La $a0, enterRowNum1
		syscall
		
		Li $v0, 5
		syscall
		move $t0, $v0
		
		Li $v0, 4
		La $a0, enterRowNum2
		syscall
		
		Li $v0, 5
		syscall
		move $t1, $v0
		
		Li $v0, 4
		La $a0, enterRowNum3
		syscall
		
		Li $v0, 5
		syscall
		move $t2, $v0
		
		Li $t3, 10
		Li $t4, 4
		
		Li $s0, 0
		Li $s1, 9
		
	#########################################################################
	#	~the memory locations for each row is calculated and stored	#
	#	in three seperate registers.					#
	#	~row1 will be stored in $t5, row2 stored in $t6 and the		#
	#	storing row is stored in $t7					#
	#	~the values of row 1 and 2 is dereferenced and the product 	#
	#	of the paralel cells are added and stored in $a3		#
	#	~then the product is stored in the storing row			#
	#########################################################################
	addTwoRows:
		bgt $s0, $s1, success
		Li $a3, 0
		
		mul $t5, $t0, $t3
		add $t5, $t5, $s0
		mul $t5, $t5, $t4
		
		mul $t6, $t1, $t3
		add $t6, $t6, $s0
		mul $t6, $t6, $t4
		
		mul $t7, $t2, $t3
		add $t7, $t7, $s0
		mul $t7, $t7, $t4
		
		Lw $a1, table($t5)
		Lw $a2, table($t6)
		add $a3, $a1, $a2
		
		Sw $a3, table($t7)
		addi $s0, $s0, 1
		j addTwoRows
	#########################################################################
	#	~swapTwoRows prompt is shown as the 6th menu option and will	#
	#	ask the user to enter two rows to be swapped.			#
	#	~row1 number is stored in $t0 and row2 is stored in $t1		#
	#	~$t2 holds the colSize and $t3 holds the wordSize		#
	#	~$s0 and $s1 controlls the loop					#
	#########################################################################
	swapTwoRowPrompt:
		Li $v0, 4
		La $a0, enterRowNum4
		syscall
		
		Li $v0, 5
		syscall
		move $t0, $v0
		
		Li $v0, 4
		La $a0, enterRowNum5
		syscall
		
		Li $v0, 5
		syscall
		move $t1, $v0
		
		Li $t2, 10
		Li $t3, 4
		
		Li $s0, 0
		Li $s1, 9
		
	#############################################################################
	#	~offset is calculated for both rows				    #
	#	~$t4 holds the offset for row1 and $t5 for row2			    #
	#	~the real values are then dereferenced $a1 (row 1) and $a2 (row 2)  #		
	#	~values are then swapped when referncing memory locations via SW    #
	#############################################################################
	swapRows:
		bgt $s0, $s1, success
		
		mul $t4, $t0, $t2
		add $t4, $t4, $s0
		mul $t4, $t4, $t3
		
		mul $t5, $t1, $t2
		add $t5, $t5, $s0
		mul $t5, $t5, $t3
		
		Lw $a1, table($t4)
		Lw $a2, table($t5)
		
		Sw $a1, table($t5)
		Sw $a2, table($t4)
		
		addi $s0, $s0, 1
		
		j swapRows
	
	#########################################################################
	#	~printCell prompt is the 7th menu choice that asks the user     #
	#	for a rowNumber and then the col number			        #
	#	~rowNumber is stored in $t0 and colNumber is stored in $t1      #
	#	~$t4 holds col index and $t5 in wordSize			#
	#	~$t2 will hold the ofset of the procided cell and then		#
	#	the value is derefernced and stored in $a3			#
	#########################################################################
	printCellPrompt:
		Li $v0, 4
		La $a0, enterRowNum
		syscall
		
		Li $v0, 5
		syscall
		move $t0, $v0
		
		Li $v0, 4
		La $a0, enterColNum
		syscall
		
		Li $v0, 5
		syscall
		move $t1, $v0
		
		Li $t4, 10
		Li $t5, 4
		
		mul $t2, $t4, $t0
		add $t2, $t2, $t1
		mul $t2, $t2, $t5
		
		Lw $a3, table ($t2)
		
		Li $v0, 4
		La $a0, result1
		syscall
		
		Li $v0, 1
		move $a0, $t0
		syscall
		
		Li $v0, 4
		La $a0, comma
		syscall
		
		Li $v0, 1
		move $a0, $t1
		syscall
		
		Li $v0, 4
		La $a0, result2
		syscall
		
		Li $v0, 1
		move $a0, $a3
		syscall
		
		Li $v0, 4
		La $a0, newline
		syscall
		
		j menuLoop
	#########################################################################
	#	~this function is the eighth function and this asks for 	#
	#	~two cells to be inputted and then the values will be swapped   #
	#	~mem location for cell one is in $t2 and cell two in t3		#
	#	~value is then dereferenced in $a1 for cell one and $a2 for 	#
	#	~cell2. Then the values are swapped				#
	#########################################################################
	cellSwapPrompt:
		Li $v0, 4
		La $a0, enterRowNum1S
		syscall
		
		li $v0, 5
		syscall
		move $s0, $v0	
		
		Li $v0, 4
		La $a0, enterColNum1S
		syscall
		
		li $v0, 5
		syscall
		move $s1, $v0	
		
		Li $v0, 4
		La $a0, enterRowNum2S
		syscall
		
		li $v0, 5
		syscall
		move $s2, $v0	
		
		Li $v0, 4
		La $a0, enterColNum2S
		syscall
		
		li $v0, 5
		syscall
		move $s3, $v0	
		
		Li $t4, 10
		Li $t5, 4
		
		mul $t2, $s0, $t4
		add $t2, $t2, $s1
		mul $t2, $t2, $t5
		
		mul $t3, $s2, $t4
		add $t3, $t3, $s3
		mul $t3, $t3, $t5
		
		lw $a1, table($t2)
		lw $a2, table($t3)
		
		sw $a1, table($t3)
		sw $a2, table($t2)
		
		j success
	
	#########################################################################				
	exit:	
		Li $v0, 4
		La $a0, message
		syscall
		
		li $v0,10
		syscall
		
	#########################################################################
	success:
		Li $v0, 4
		La $a0, successMessage
		syscall
		
		j menuLoop
		
	#########################################################################
	returnToMain:
		j menuLoop
		
