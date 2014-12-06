
#################################################
.data 0x2000 #note that this might not be accurate initial data vals
player_loc:	.word	0x4000
player_icon:	.word	2

.text 0x0000			# Be sure to set memory configuration Compact, Text at 0
	addi	$t5, $0, 0
	addi	$t0, $0, 0
	addi	$v0, $0, 0
wait1:
	addi $v0, $v0, 1
	addi $v1, $0, 300
	beq $v0, $v1 display_update_reset
	addi	$t0, $0, 0
	j wait
wait:
	addi $t0, $t0, 1
	addi $t6, $0, 3000
	beq $t0, $t6 wait1
	j wait
display_update_reset:
	addi	$v0, $0, 0
	addi	$t0, $0, 0
	addi $t5, $t5, 1
	addi $t3, $0, 0
display_update:
	addi	$t4, $0, 1200
	beq	$t3, $t4, wait1
	sw	$t5, 0x4000($t3)
	addi	$t3, $t3, 1	#itterate a counter
	j display_update
	
#####################################33
#tester1 for sw
.data 0x2000 #note that this might not be accurate initial data vals
player_loc:	.word	0x4000
player_icon:	.word	2

.text 0x0000			# Be sure to set memory configuration Compact, Text at 0
	addi	$t5, $0, 0
	addi	$t0, $0, 0
	addi	$v0, $0, 0
display_update_reset:
	addi	$v0, $0, 0
	addi	$t0, $0, 0
	addi $t5, $t5, 1
	addi $t3, $0, 0
display_update:
	addi	$t4, $0, 255
	beq	$t3, $t4, display_update_reset
	sw	$t5, 0x4000($t3)
	sw	$t5, 0x2000($t3)
	addi	$t3, $t3, 1	#itterate a counter
	j display_update


	
