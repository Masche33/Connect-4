	.text
	.globl play_move

# REQUIRES: $a0: Addres of the game dashboard; $a1: Column (1-7); $a2: Player (1-2)
# RETURN: $v0: The validity of the move
play_move:
	
	move $t0, $fp
	addi $fp, $sp, -4
	sw $t0, 0($fp)
	sw $sp, -4($fp)
	sw $ra, -8($fp)
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	sw $s2, -20($fp)
	sw $s3, -24($fp)
	sw $s4, -28($fp)
	addi $sp, $fp, -28
	
	move $s0, $a0 # Address
	move $s1, $a1 # Column
	move $s2, $a2 # Player
	
	# Ciclo: Se offset arriva a height return 
	
	li $s3, 0 # Offset iterator
	
	try_move:
		move $a0, $s0 # Address
		move $a1, $s1 # Column
		move $a2, $s3 # Offset
		move $a3, $s2 # Player
		jal play_specific_move
		# In $v0 i got the lagality of the move
		beq $v0, 0, illegal # If the move is illegal 
		beq $v0, 1, legal   # If the move is legal 
		legal:
		# Return $v0 1
			li $v0, 1 # The move was legal
			j end     # Return
		illegal:
		# Return $v0 0
			blt $s3, 6, next # Check upper cell
			beq $s3, 6, no_move # There is no more an upper cell
			next:
				addi $s3, $s3, 1 # incrementing offset
				j try_move       # continue
			no_move:
				li $v0, 0        # Return value
				j end		 # Return
	

end:
	
	lw $t0, 0($fp)
	lw $sp, -4($fp)
	lw $ra, -8($fp)
	lw $s0, -12($fp)
	lw $s1, -16($fp)
	lw $s2, -20($fp)
	lw $s3, -24($fp)
	lw $s4, -28($fp)
	move $fp, $t0
	jr $ra

	