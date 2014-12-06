#tester1 for sw
.data 0x2000 #note that this might not be accurate initial data vals
player_loc:	.word	0x4000 #0x2000
player_icon:	.word	2	#0x2004
big_data:       .space 4		#0x2008
move_vector:	.space 4	#0x200c
big_constant:	.space 4	#0x2010
player_loc_prev:	.space 4	#0x2014
keyboard_val:	.space 4	#0x2018

.text 0x0000			# Be sure to set memory configuration Compact, Text at 0
addi $t0, $0, 0
addi $t1, $0, 0
addi $t2, $0, 0
	
loop:
    addi	$sp, $0, 0x20fc	# top of the stack is the word at address 20fc-20ff
   #check keyboard
   jal check_keyboard
   #move the player    
    jal move   
    ##Clear old player
    jal clear_player
    #update the display
    jal display_update
    #loop back
    j loop
#######################################################################
move:
    addi 	$sp, $sp, -4	#push ra to stack
    sw	$ra, 0($sp)
move_logic:
    lw $t0, 0x2008($0) #big data for player
    addi $t0, $t0, 1 #add 1
    sw $t0, 0x2008($0) #store big data
    srl $t0, $t0, 20 #get top bits to delay
    #how long to loop
    lw	$t2, 0x2010($0) #load in big constant for comparison
    bne $t2, $t0, move_logic # slt is 0 if the counter is less than the constant. If so we are done waiting
    #else loop until sufficent time
move_finish:
    	sw $0, 0x2008($0) #store big data, reset
    	lw $t1, 0x2000($0) #get current location
    	lw $t0, 0x200c($0) #get movement vector
    	add $t1, $t1, $t0 #new location
    	sw $t1, 0x2000($0)
    	lw 	$ra, 0($sp)	#get the appropriate return reg
    	addi	$sp, $sp, 4
	jr 	$ra
#######################################################################################
clear_player:
	addi 	$sp, $sp, -4	#push ra to stack
   	 sw	$ra, 0($sp)
	lw 	$t1, 0x2014($0) # get location of prev player
	addi	$t0, $0, 0	# blank the location of the player
	sw	$t0, 0($t1)# put blank square on board
	lw	$t1, 0x2000($0) # get location of current player
	sw	$t1, 0x2014($0) #store current location in prev
	lw 	$ra, 0($sp)	#get the appropriate return reg
    	addi	$sp, $sp, 4
	jr 	$ra
##########################################################################################	
display_update:
    addi 	$sp, $sp, -4	#push ra to stack
    sw	$ra, 0($sp)
    lw	$t0, 0x2004($0) # get sprite
    lw	$t1, 0x2000($0) # get location
    sw	$t0, 0x0000($t1)# put player on board
    lw 	$ra, 0($sp)	#get the appropriate return reg
    addi	$sp, $sp, 4
    jr 	$ra
#######################################################################################
check_keyboard:
	addi 	$sp, $sp, -4	#push ra to stack
    	sw	$ra, 0($sp)	#push ra to stack
	lw $t0, 0x6000($0) # get the current value of keyboard
	sw $t0, 0x2018($0) #store it because this is actually a critical section (it could change)
right:
	addi	$t1, $0, 0x0023 # t1 is set to right key constant
	bne	$t0, $t1, left #skip if not our key
	addi 	$t3, $0, 1	#RIGHT VECTOR
	sw	$t3, 0x200c($0) #store the vector
	j	end_loop
left:
	addi	$t1, $0, 0x001c # t1 is set to left key constant
	bne	$t0, $t1, up #i
	addi 	$t3, $0, -1	#LEFT VECTOR
	sw	$t3, 0x200c($0) #store the vector
	j 	end_loop
up:
	addi	$t1, $0, 0x001d # t1 is set to right key constant
	bne	$t0, $t1, down #
	addi 	$t3, $0, -40	#UP VECTOR
	sw	$t3, 0x200c($0) #store the vector
	j 	end_loop
down:
	addi	$t1, $0, 0x001b # t1 is set to right key constant
	bne	$t0, $t1, end_loop #i
	addi 	$t3, $0, 40	#DOWN VECTOR
	sw	$t3, 0x200c($0) #store the vector
	j 	end_loop
end_loop:
	lw 	$ra, 0($sp)	#get the appropriate return reg
    	addi	$sp, $sp, 4
	jr 	$ra