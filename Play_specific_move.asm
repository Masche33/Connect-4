	.text
	.globl play_specific_move
# REQUIRES: $a0: Addres of the game dashboard; $a1: Column (1-7); $a2: Offset (1-7); $a3: Player (1-2)
# RETURN: $v0: The validity of the move
play_specific_move:
	
	move $t0, $a0 # Address of the game's dashboard
	move $t1, $a1 # Column
	move $t2, $a2 # Offset
	move $t3, $a3 # Player
	
	# Gettin the cell
	# (Height - 2 - Offset) * width + column
	
	la $t4, width   # Storing the address of width in $t4
	la $t5, height  # Storing the address of height in $t5
	

	lw $t4, 0($t4) # Storing in t0 the value in address $t0
	lw $t5, 0($t5) # Storing in t1 the value in address $t1
	
	sub $t6, $t5, 2 # Height - 2
	sub $t6, $t6, $t2 # (Height - 2 - Offset)
	mul $t6, $t6, $t4 # (Height - 2 - Offset) * width
	add $t6, $t6, $t1 # Height - 2 - Offset) * width + column
	
	# Byte offset
	mul $t6, $t6, 4 # Offset of the cell
	add $t6, $t6, $t0 # Address of the cell
	
	lw $t7, 0($t6) # Loading the value of the cell

	bnez $t7, full	
empty:
	sw $t3, 0($t6) # Storing the Player in the cell
	li $v0, 1 # The move is legal
	j return
full:
	li $v0, 0 # The cell is illegal
	j return
return:

	jr $ra
	
	
	
	
