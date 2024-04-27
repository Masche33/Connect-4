	.data
move_choice: .asciiz "Wich colum to play: "
win_msg:	.asciiz "The winner is Player "
width:  .word 9
height: .word 7

	.text
	.globl width
	.globl height
	
main:
	jal init_dashboard
	move $s0, $v0
	li $s1, 1
	game_loop:
		move $a0, $s0
		jal print_dashboard 
	
		la $a0, move_choice
		li $v0, 4
		syscall
	
		li $v0, 5
		syscall
		
		move $a0, $s0
		move $a1, $v0
		move $a2, $s1
		jal play_move
		
		beq $v0, 0, game_loop # Continue
		beq $s1, 1, O
		X:
			li $s1, 1
			j continue
		O:
			li $s1, 2
			j continue
		continue:
		
		move $a0, $s0
		jal check_win
		bnez $v0, win_detected
		
		
	beq $v0, 0, game_loop
	
	move $a0, $s0
	jal print_dashboard
	
win_detected:

	move $a0, $s0
	jal print_dashboard 
	
	
	move $s0, $v0
	la $a0, win_msg
	li $v0, 4
	syscall
	
	move $a0, $s1
	li $v0, 1	
	syscall

	li $v0, 10
	syscall
