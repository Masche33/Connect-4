	.text
	.globl init_dashboard

# REQUIRES:
# RETURNS: ($v0): The address of the game's dashboard
init_dashboard:
	
	# GETTING THE SIZE OF THE ARRAY TO ALLOCATE
	
	la $t0, width   # Storing the address of width in $t0
	la $t1, height  # Storing the address of height in $t1
	

	lw $t0, 0($t0) # Storing in t0 the value in address $t0
	lw $t1, 0($t1) # Storing in t1 the value in address $t1

	move $t3, $t0  # Width (For future counter)
	sub $t4, $t1, 1  # Height - 1 (For future counter)
			
	mul $t0, $t0, $t1 # Product of width and heigth
	mul $t0, $t0, 4   # The nubmer of byte to allocate
	
	move $a0, $t0 	  # Number of byte to allocate
	li $v0, 9        # The code to allocate numbers
	syscall		 # A syscall
		
	move $t5, $v0 	 # The address of the new array
	
	# $t3: Width (For future counter)
	# $t4: Height - 1 (For future counter)
	# $t5: Address of the array
			
	# INITIALIZING THE VALUE OF THE MATRIX
	
	move $t6, $t5 # Coping the address of the matrix to iterate on it
	li $t1, 1     # Rows counter
	sub $t7, $t3, 2 # Getting the number of dots in a line
	
	do_external_rows: # Initializing all rows WITHOUT the last
		# !!ADDING #!!
		
		li $t2, 3 # Loading the value in $t2
		sw $t2, 0($t6) # Storing the value in $t0
		addi $t6, $t6, 4 # Shifting to the next value in the array

		# !!Adding the dots!!
	
		li $t0, 1 	# Initializing the counter
		do_rows: # The internal part of the line			
			li $t2, 0 # Loading the value in $t0
			sw $t2, 0($t6) # Storing the value in $t0
			addi $t6, $t6, 4 # Shifting to the next value
			addi $t0, $t0, 1 # Dots counter
		ble $t0, $t7, do_rows
		
		# !!ADDING #!!
		li $t2, 3 # Loading the value in $t0
		sw $t2, 0($t6) # Storing the value in $t0
		addi $t6, $t6, 4 # Shifting to the next value
		
		addi $t1, $t1, 1 # incrementing the rows counter
	ble $t1, $t4, do_external_rows
	
	li $t0, 1 # Setting the counter to 1
	li $t2, 3 # Setting the value to save to 3
	do_last_rows: # Initilizing the last line
	
		sw $t2, 0($t6) 	  # Stroing the value in $t0
		addi $t6, $t6, 4 # Shifting to the next value
		addi $t0, $t0, 1 # Dots counter
		
	ble $t0, $t3, do_last_rows # Initializing the last line
	
	move $v0, $t5 # Return value is the address of the array
	jr $ra 	      # Return