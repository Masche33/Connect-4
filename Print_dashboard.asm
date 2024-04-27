	.data
nl: .asciiz "\n"
dot: .asciiz ". "
ashtag: .asciiz "# "
X: .asciiz "X "
O: .asciiz "O "

	.text
	.globl print_dashboard
	
#REQUIRES: In $a0 the addres of a dashboard array
print_dashboard:

		
	la $t0, width   # Storing the address of width in $t0
	la $t1, height  # Storing the address of height in $t1
	
	lw $t0, 0($t0) # Storing in t0 the value in address $t0
	lw $t1, 0($t1) # Storing in t1 the value in address $t1
	
	mul $t2, $t0, $t1 # Product of width and heigth
	mul $t2, $t2, 4   # The nubmer of byte to allocate
	
	move $t3, $a0 # Address of the array
	
	li $t4, 1 # Char counter
	li $t5, 1 # Line counter
	
	print_line:
		print_char:
			# LOAD CHAR
			lw $t6, 0($t3)
			
			# SELECT CHAR
			beq $t6, 0, set_dot
			beq $t6, 1, set_X
			beq $t6, 2, set_O
			beq $t6, 3, set_ashtag
			
			
			set_dot:
				la $a0, dot
				j print
			set_ashtag:
				la $a0, ashtag
				j print
			set_X:
				la $a0, X
				j print
			set_O:
				la $a0, O
				j print
			
			# PRINT CHAR
			print:
			li $v0, 4 # The code to print a string
			syscall   # The syscall
			
			
			addi $t3, $t3, 4 # shifting to the next word
			addi $t4, $t4, 1
		ble $t4, $t0, print_char
		
		la $a0, nl   # Loand the \n char
		li $v0, 4    # The code of the syscall 
		syscall      # The syscall
		
		addi $t5, $t5, 1 # Adding one to the line counter
		li $t4, 1 	 # Resetting the char counter
	ble $t5, $t1, print_line 

	jr $ra
	
