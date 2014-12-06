#tester1 for sw
.data 0x2000 #note that this might not be accurate initial data vals
player_loc:	.word	0x4000
player_icon:	.word	2
big_data:       .space 4

.text 0x0000			# Be sure to set memory configuration Compact, Text at 0
	
loop:
    addi	$sp, $0, 0x20fc	# top of the stack is the word at address 20fc-20ff

    addi 	$sp, $sp, -4	#push ra to stack
    sw	$ra, 0($sp)
    jal clear_player
    lw 	$ra, 4($sp)	#get the appropriate return reg
    addi	$sp, $sp, 4

    addi 	$sp, $sp, -4	#push ra to stack
    sw	$ra, 0($sp)
    jal move
    lw 	$ra, 4($sp)	#get the appropriate return reg
    addi	$sp, $sp, 4

    addi 	$sp, $sp, -4	#push ra to stack
    sw	$ra, 0($sp)
    jal display_update
    lw 	$ra, 4($sp)	#get the appropriate return reg
    addi	$sp, $sp, 4
    j loop

move:
    lw $t0, 0x2008($0) #big data for player
    addi $t0, $t0, 1 #add 1
    sw $t0, 0x2008($0) #store big data
    lw $t1, 0x2008($0) # get player location from big data
    srl $t1, $t1, 16 #git top ten bits
    addi $t1, $t1, 0x4000
    sw $t1, 0x2000($0)
move_finish:
	jr 	$ra

clear_player:
	lw 	$t1, 0x2000($0) # get location of current player
	addi	$t0, $0, 0	# blank the location of the player
	sw	$t0, 0($t1)# put blank square on board
	jr 	$ra
	
display_update:
    lw	$t0, 0x2004($0) # get sprite
    lw	$t1, 0x2000($0) # get location
    sw	$t0, 0x0000($t1)# put player on board
    jr 	$ra