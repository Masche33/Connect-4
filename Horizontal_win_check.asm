	.text
	.globl check_horizontal_win
	


# REQUIRES: $a0: Address of the game's dashboard
# RETURN: $v0: he winner (1-2) if there is a win; 0 in else case
check_horizontal_win:
	
	move $t0, $a0
	
	la $t1, width   # Storing the address of width in $t0
	la $t2, height  # Storing the address of height in $t1
	
	lw $t1, 0($t1) # Storing in t0 the value in address $t0
	lw $t2, 0($t2) # Storing in t1 the value in address $t1
	
	sub $t2, $t2, 1 # Height - 1
	  
	mul $t1, $t2, $t1 # Width * (hegiht - 1)
	mul $t1, $t1, 4   # 4(Width * (hegiht - 1)
	sub $t1, $t1, 3   # 4(Width * (hegiht - 1) - 3
	add $t1, $t1, $t0 # Adding the game's dashboard 
		
	do:
		lw $t3, ($t0)
		beqz $t3, skip
		beq $t3, 3, skip
		lw $t4, 4($t0)
		bne $t3, $t4, skip
		lw $t4, 8($t0)
		bne $t3, $t4, skip
		lw $t4, 12($t0)
		bne $t3, $t4, skip
		li $v0, 1
		jr $ra
	skip:
		addi $t0, $t0, 4
	blt $t0, $t1, do
	
	li $v0,0
	jr $ra

