.data
	theParameter: 	.word 0
	theVar1: 	.word 0
	theVar2: 	.word 0
	
	newLine:		.asciiz "\n"
	welcomeMessage: 		.asciiz "Welcome for using MIPS calculator!\n"
	chooseMessage: 		.asciiz "Choose the function you want: \n"
	funcMessage1: 		.asciiz "1.  Addition\n"
	funcMessage2: 		.asciiz "2.  Subtraction\n"
	funcMessage3: 		.asciiz "3.  Multiplication\n"
	funcMessage4: 		.asciiz "4.  Division\n"
	funcMessage5: 		.asciiz "5.  Conversions\n"
	funcMessage10: 		.asciiz "10. Exit\n"
	EinputMessage: 		.asciiz "Sorry, cannot find the function you want!\n"
	convMessage1: 		.asciiz "1. Decimal to Binary\n"
	convMessage2: 		.asciiz "2. Decimal to Hexa\n"
	convMessage3: 		.asciiz "3. Hexa to Binary\n"
	convMessage4: 		.asciiz "4. Hexa to Decimal\n"
	convMessage5: 		.asciiz "5. Binary to Decimal\n"
	convMessage6: 		.asciiz "6. Binary to Hexa\n"
	convMessage7: 		.asciiz "7. To Main Menu\n"
	convMessage10: 		.asciiz "10. Exit\n"
	
	askFunc1: 		.asciiz "Please type the first numb: \n"
	askFunc2: 		.asciiz "Please type the second numb: \n"
	askFunc3: 		.asciiz "Please type the multiplicand: \n"
	askFunc4: 		.asciiz "Please type the multiplier: \n"
	askFunc5: 		.asciiz "Please type the dividend: \n"
	askFunc6: 		.asciiz "Please type the divisor: \n"
	askFunc7: 		.asciiz "Please type the decimal: \n"
	askFunc8: 		.asciiz "Please type the hexa: \n"
	askFunc9: 		.asciiz "Please type the binary: \n"
	
	addFunc: 		.asciiz "You are in addition function right now!\n"
	subFunc: 		.asciiz "You are in subtraction function right now!\n"
	mulFunc: 		.asciiz "You are in multiplication function right now!\n"
	divFunc: 		.asciiz "You are in division function right now!\n"
	convFunc: 		.asciiz "You are in Converse function right now!\n"
	resultMessage: 		.asciiz "The answer is: \n"
	remainderMessage: 		.asciiz "The remainder is: \n"
	
	obufe:
	hexInput:   .asciiz     "Here is the input in hexadecimal: "
	binaryInput:    .asciiz "Here is the input in binary: "
	decimalInput:    .asciiz "Here is the input in decimal: "
	hexDigit:   .asciiz     "0123456789ABCDEF"
	buffer: .space 9
	empty: .space 17
	
	

.text
.globl main

main:       
			#printout messagea
			li $v0, 4
			la $a0, welcomeMessage
			syscall
			
			#user choose the function they want
			j functionChoose
			
functionChoose:	
			# reset zero
			move $v0, $0
			move $v1, $0
			
			#print all the function information
			li $v0, 4
			la $a0, chooseMessage
			syscall
			
			li $v0, 4
			la $a0, funcMessage1
			syscall
			
			li $v0, 4
			la $a0, funcMessage2
			syscall
			
			li $v0, 4
			la $a0, funcMessage3
			syscall
			
			li $v0, 4
			la $a0, funcMessage4
			syscall
			
			li $v0, 4
			la $a0, funcMessage5
			syscall
			
			li $v0, 4
			la $a0, funcMessage10
			syscall
			
			li $v0, 5
			syscall
			sw $v0, theParameter
			
			lw $v1, theParameter
			
			#function choosing, like if sentence in other language
			addi $v1, $v1, -1
			beq $v1, $0, theAddition
			addi $v1, $v1, 1
			
			addi $v1, $v1, -2
			beq $v1, $0, theSubtraction
			addi $v1, $v1, 2
			
			addi $v1, $v1, -3
			beq $v1, $0, theMultiplication
			addi $v1, $v1, 3
			
			addi $v1, $v1, -4
			beq $v1, $0, theDivision
			addi $v1, $v1, 4
			
			addi $v1, $v1, -5
			beq $v1, $0, theConversion
			addi $v1, $v1, 5
			
			addi $v1, $v1, -10
			beq $v1, $0, theEnd
			addi $v1, $v1, 10
			
			li $v0, 4
			la $a0, EinputMessage
			syscall
			
			j functionChoose
			
theAddition:
			li $v0, 4
			la $a0, addFunc
			syscall 
			
			li $v0, 4
			la $a0, askFunc1
			syscall
			
			li $v0, 5
			syscall
			sw $v0, theVar1
			
			li $v0, 4
			la $a0, askFunc2
			syscall 
			
			li $v0, 5
			syscall
			sw $v0, theVar2
			
			#add function
			lw $v0, theVar1
			lw $v1, theVar2
			add $t0, $v0, $v1
			
			j theResult
			
theSubtraction:
			li $v0, 4
			la $a0, subFunc
			syscall 
			
			li $v0, 4
			la $a0, askFunc1
			syscall 
			
			li $v0, 5
			syscall
			sw $v0, theVar1
			
			li $v0, 4
			la $a0, askFunc2
			syscall 
			
			li $v0, 5
			syscall
			sw $v0, theVar2
			
			#sub function
			lw $v0, theVar1
			lw $v1, theVar2
			sub $t0, $v0, $v1
			
			j theResult
theMultiplication:
			
			li $v0, 4
			la $a0, mulFunc
			syscall
			
			addi $sp, $sp, -12	# Allocating space on the stack
			sw $ra, 24($sp)
			sw $t5, 28($sp)
			sw $t6, 32($sp)
    
			#jal readint
			#move $t5, $a0
			#move $t6, $a1
    
			# print message to input first number
			li $v0, 4		# load print string instruction
			la $a0, askFunc3	# load address of first_num into register $a0
			syscall
        
			# save user input into $s1
			li $v0, 5		# load read int instruction
			syscall
			move $t5, $v0
    
			# print message to input second number
			li $v0, 4
			la $a0, askFunc4
			syscall
    
			# save user input into $s2
			li $v0, 5		# load read int instruction
			syscall
			move $t6, $v0

			mul $t0, $t5, $t6 
    
			lw $t6, 32($sp)
			lw $t5, 28($sp)
			lw $ra, 24($sp)
			addi $sp, $sp, 12
			
			li $v0, 4
			la $a0, resultMessage
			syscall
			
			li $v0,1  
			move $a0,$t0
			syscall
			
			li $v0, 4
			la $a0, newLine
			syscall
			
			j functionChoose
			
			
theDivision:
			li $v0, 4
			la $a0, mulFunc
			syscall
			
			addi $sp, $sp, -12	# Allocating space on the stack
			sw $ra, 24($sp)
			sw $t5, 28($sp)
			sw $t6, 32($sp)
    
			#jal readint
			#move $t5, $a0
			#move $t6, $a1
    
			# print message to input first number
			li $v0, 4		# load print string instruction
			la $a0, askFunc5	# load address of first_num into register $a0
			syscall
        
			# save user input into $s1
			li $v0, 5		# load read int instruction
			syscall
			move $t5, $v0
    
			# print message to input second number
			li $v0, 4
			la $a0, askFunc6
			syscall
    
			# save user input into $s2
			li $v0, 5		# load read int instruction
			syscall
			move $t6, $v0

			div $t5, $t6 
			mfhi $t1
			mflo $t0
			
			lw $t6, 32($sp)
			lw $t5, 28($sp)
			lw $ra, 24($sp)
			addi $sp, $sp, 12
			
			li $v0, 4
			la $a0, resultMessage
			syscall
			
			li $v0,1  
			move $a0,$t0
			syscall
			
			li $v0, 4
			la $a0, newLine
			syscall
			
			li $v0, 4
			la $a0, remainderMessage
			syscall
			
			li $v0,1  
			move $a0,$t1
			syscall
			
			li $v0, 4
			la $a0, newLine
			syscall
			
			j functionChoose
			
theConversion:
			li $v0, 4
			la $a0, convFunc
			syscall
			
			li $v0, 4
			la $a0, chooseMessage
			syscall
			
			li $v0, 4
			la $a0, convMessage1
			syscall
			
			li $v0, 4
			la $a0, convMessage2
			syscall
			
			li $v0, 4
			la $a0, convMessage3
			syscall
			
			li $v0, 4
			la $a0, convMessage4
			syscall
			
			li $v0, 4
			la $a0, convMessage5
			syscall
			
			li $v0, 4
			la $a0, convMessage6
			syscall
			
			li $v0, 4
			la $a0, convMessage7
			syscall
			
			li $v0, 4
			la $a0, convMessage10
			syscall
			
			li $v0, 5
			syscall
			sw $v0, theParameter
			
			lw $v1, theParameter
			addi $v1, $v1, -1
			beq $v1, $0, theDTB
			addi $v1, $v1, 1
			
			addi $v1, $v1, -2
			beq $v1, $0, theDTH
			addi $v1, $v1, 2
			
			addi $v1, $v1, -3
			beq $v1, $0, theHTB
			addi $v1, $v1, 3
			
			addi $v1, $v1, -4
			beq $v1, $0, theHTD
			addi $v1, $v1, 4
			
			addi $v1, $v1, -5
			beq $v1, $0, theBTD
			addi $v1, $v1, 5
			
			addi $v1, $v1, -6
			beq $v1, $0, theBTH
			addi $v1, $v1, 6
			
			addi $v1, $v1, -7
			beq $v1, $0, functionChoose
			addi $v1, $v1, 7
			
			addi $v1, $v1, -10
			beq $v1, $0, theEnd
			addi $v1, $v1, 10
			
			li $v0, 4
			la $a0, EinputMessage
			syscall
			
			j theConversion

theDTB:
			li $v0,4
			la $a0,askFunc7
			syscall
			
			li $v0,5
			syscall
			move $s0,$v0
			
			la $a0, binaryInput
			li $a1, 32
			
			li $a2, 1
			j prtany
theDTH:
			li $v0,4
			la $a0,askFunc7
			syscall
			
			li $v0,5
			syscall
			move $s0,$v0
	
			la $a0, hexInput
			li $a1, 32
			
			li $a2, 4
			j prtany

theHTB:
			#reset zero
			move $t0, $0
			move $t1, $0
			move $t2, $0
			move $t3, $0
			move $t4, $0
			move $t5, $0
			move $t6, $0
			move $t7, $0
			move $t8, $0
			move $t9, $0
			
			li $v0,4
			la $a0,askFunc8
			syscall
			
			li $v0,8        #take in input
			la $a0,buffer   #load argument with byte space
			li $a1,9        #allot byte space for string
			add $s0,$zero,$a0  #load user input into register
			syscall
			add $t0,$zero,$s0 #load string into temporary register for loop
			add $t3,$zero,$s0 #load string into temporary register for count_string loop
			addi $t4,$zero,10 #load newline value into a temporary register
			
			jal count_string_loop
			
			move $s0, $a0
			
			la $a0,binaryInput
			li $a1,32
			
			li $a2,1                   # bit width of number base digit
			j prtany
theHTD:
			#reset zero
			move $t0, $0
			move $t1, $0
			move $t2, $0
			move $t3, $0
			move $t4, $0
			move $t5, $0
			move $t6, $0
			move $t7, $0
			move $t8, $0
			move $t9, $0
			
			li $v0,4
			la $a0,askFunc8
			syscall
			
			li $v0,8        #take in input
			la $a0,buffer   #load argument with byte space
			li $a1,9        #allot byte space for string
			add $s0,$zero,$a0  #load user input into register
			syscall
			add $t0,$zero,$s0 #load string into temporary register for loop
			add $t3,$zero,$s0 #load string into temporary register for count_string loop
			addi $t4,$zero,10 #load newline value into a temporary register
			
			jal count_string_loop
			
			move $s0, $a0
			
			li $v0, 4
			la $a0, decimalInput
			syscall
			
			li $v0, 1
			move $a0, $s0
			syscall
			
			li $v0, 4
			la $a0, newLine
			syscall
			
			j theConversion
theBTD:
			li $v0,4
			la $a0,askFunc9
			syscall
			
			la $a0, empty
			li $a1, 16              # load 16 as max length to read into $a1
			li $v0,8                # 8 is string system call
			syscall
			li $t4, 0               # initialize sum to 0
			la $t1, empty
			li $t9, 16             # initialize counter to 16
			
			jal firstByte

			li $v0, 4
			la $a0, decimalInput
			syscall
			
			move $a0, $t4      # load sum
			li $v0, 1      # print int
			syscall
			
			li $v0, 4
			la $a0, newLine
			syscall
			
			j theConversion
theBTH:
			li $v0,4
			la $a0,askFunc9
			syscall
			
			la $a0, empty
			li $a1, 16              # load 16 as max length to read into $a1
			li $v0,8                # 8 is string system call
			syscall
			li $t4, 0               # initialize sum to 0
			la $t1, empty
			li $t9, 16             # initialize counter to 16
			
			jal firstByte
			
			move $s0,$t4
	
			la $a0, hexInput
			li $a1, 32
			
			li $a2, 4
			j prtany
			
prtany:
			move $t7, $0
			move $t6, $0
			move $t5, $0
			
			li      $t7,1
			sllv    $t7,$t7,$a2             # get mask + 1
			subu    $t7,$t7,1               # get mask for digit

			la      $t6,obufe               # point one past end of buffer
			subu    $t6,$t6,1               # point to last char in buffer
			sb      $zero,0($t6)            # store string EOS

			move    $t5,$s0                 # get number

prtany_loop:
			and     $t0,$t5,$t7             # isolate digit
			lb      $t0,hexDigit($t0)       # get ascii digit

			subu    $t6,$t6,1               # move output pointer one left
			sb      $t0,0($t6)              # store into output buffer

			srlv    $t5,$t5,$a2             # slide next number digit into lower bits
			sub     $a1,$a1,$a2             # bump down remaining bit count
			bgtz    $a1,prtany_loop         # more to do? if yes, loop

			# output string
			li      $v0,4
			syscall

			# output the number
			move    $a0,$t6                 # point to ascii digit string start
			syscall

			# output newline
			la      $a0,newLine
			syscall

			j theConversion                     # return
theResult:
			li $v0, 4
			la $a0, resultMessage
			syscall
			
			li $v0,1  
			move $a0,$t0
			syscall
			
			li $v0, 4
			la $a0, newLine
			syscall
			
			j functionChoose

count_string_loop:
			lb $t5,0($t3) 			#load first byte of string
			beq $t4,$t5,count_string_exit   			#checks to see if it is the end of the string
			beq $zero,$t5,count_string_exit  			#checks to see if it is the end of the string
			addi $t6,$t6,1 			#increment character counter and store it in register
			addi $t3,$t3,1 			#change current byte, at the end of loop length of string is stored in $t6
			j count_string_loop
count_string_exit:
	
			addi $t8,$t6,-1   #initialize index to length - 1
loop:
			lb $t1,0($t0) 			#load first byte of string
			beq $t4,$t1,loop_exit 			#checks to see if it is the end of the string
			beq $zero,$t1,loop_exit 			##checks to see if it is the end of the string	
			blt $t1,48,invalid 			#checks if character is less than 48, branches to invalid section if true
			blt $t1,58,check_num 			#goes to get value of char since it's valid
			blt $t1,65,invalid 			#checks if character is less than 65, branches to invalid section if true
			blt $t1,71,check_uppercase 			#goes to get value of char since it's valid
			blt $t1,97,invalid 				#checks if character is less than 97, branches to invalid section if true
			blt $t1,103,check_lowercase 		#goes to get value of char since it's valid
			j invalid
	
 
check_num:
			addi $t2,$t1,-48 	 #convert 0-9 ascii to 0-9 hex
			j compute_sum  		#jump to compute exponent
	
check_uppercase:
			addi $t2,$t1,-55   	#convert A-F ascii to 10-15 hex
			j compute_sum   	#jump to compute exponent

check_lowercase:
			addi $t2,$t1,-87     	#convert a-f ascii to 10-15 hex
			j compute_sum   	#jump to compute exponent
	


compute_sum:
			sll $t7,$t7, 4
			add $t7,$t7,$t2
	
			addi $t0,$t0,1                #increments $t0 by one to point to next element in the string
			addi $t8,$t8,-1               #decrement index by 1
			addi $t3,$t3,-4               #decrement shift amount by four
			j loop                        #jumps back to beginning of loop
loop_exit:

			addi $s4,$zero,7                  #initializes a register with the value seven
			bgt $t6,$s4,special_output        #jumps to special output register if length of string is less than zero
			li $v0,1                          #load code for printing an integer
			add $a0,$zero,$t7                     #load argument with decimal number
			

end:
			jr $ra

invalid:
			la $a0,str2                  #load argument with invalid string
			li $v0,4                     #load with code to print a string
			syscall
			j end
	
special_output:
			addi $s5,$0,10000         #initializes register with 10,000 for special output
			divu $t7,$s5                  #divide sum by 10,000
			mflo $s6                     #move quotient from low
			mfhi $s7                     #move remainder from high
			li $v0,1                     #load code to print integer
			add $a0,$0,$s6                   #load argument with quotient
			syscall
			li $v0,1                     #load code to print integer
			add $a0,$0,$s7            #load argument with remainder
			syscall
			j end     	                 #jump to end

firstByte:
			lb $a0, ($t1)      
			blt $a0, 48, printSum   
			addi $t1, $t1, 1          
			addi $a0, $a0, -48         
			addi $t9, $t9, -1          
			beq $a0, 0, isZero
			beq $a0, 1, isOne
			j convert

isZero:
			j firstByte

isOne:
			li $t8, 1               
			sllv $t5, $t8, $t9   
			add $t4, $t4, $t5         

			move $a0, $t4
			j firstByte

convert:

printSum:
			srlv $t4, $t4, $t9
			
			jr $ra
			
theEnd:
			li $v0, 10
			syscall
			
			