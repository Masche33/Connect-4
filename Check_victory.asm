	.text
	.globl check_win
# REQUIRES: $a0: Address of the game's dashboard
# RETURN: $v0: he winner (1-2) if there is a win; 0 in else case
check_win:
	
	move $t0, $fp
	addi $fp, $sp, -4
	sw $t0, 0($fp)
	sw $sp, -4($fp)
	sw $ra, -8($fp)
	addi $sp, $fp, -8
	
	
	jal check_horizontal_win
	bnez $v0, return # If $v0 is not a zero, then there's a win
	
	jal check_vertical_win
	bnez $v0, return # If $v0 is not a zero, then there's a win
	
	jal check_diagonal_win
	bnez $v0, return # If $v0 is not a zero, then there's a win
	
	jal check_anti_diagonal_win
	bnez $v0, return # If $v0 is not a zero, then there's a win
		
	li $v0, 0
	# Check if there is a winner




return:
	lw $t0, 0($fp)
	lw $sp, -4($fp)
	lw $ra, -8($fp)
	move $fp, $t0
	jr $ra

