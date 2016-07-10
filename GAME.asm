.data

begin: .asciiz "\nYou enter the dungeon and decide it's best to proceed without any preparations.\n"
cave_of_cacophony: .asciiz "\nYou are in the Cave of Cacophony.  You see a path east.\nPlease enter a direction.\n"
twisty_tunnel: .asciiz "\nYou enter the Twisty Tunnel.  You can go in any direction.\nPlease enter a direction.\n"
potion_parlor: .asciiz "\nYou enter the Potion Parlor and pocket a potion.  You can only go south.\nPlease enter a direction.\n"
potion_parlor_again: .asciiz "\nInside of the Potion Parlor, you see a wall filled with potions.  Shame you already have one.\nYou only see a path to the south.  Please enter a direction.\n"
rapid_river: .asciiz "\nWading through the Rapid River, you notice paths to the north, east and west.\nPlease enter a direction.\n"
secret_sword_stash: .asciiz "\nEntering the room, you find a sowrd.  Convenient!\nYou can only go east back to the Rapid River.\nPlease enter a direction.\n"
secret_sword_stash_again: .asciiz "\nInside of what you now know is the secret sword stash, you see racks full of swords.  Unfortunately, you can only carry one.\nYou only see the path east to the Rapid River.  Please enter a direction.\n"
lengthy_labyrinth: .asciiz "\nLooking around, you realize you are in Lengthy Labyrinth.  There's a path north, east and west.\nPlease enter a direction.\n"
mini_maze: .asciiz "\nYou get lost in the Mini-Maze before finding two paths: one leading east and one leading south.\nPlease enter a direction.\n"
hall_of_mirrors: .asciiz "\nYou walk through the Hall of Mirrors along with hundreds of your reflections.  There appears to be a path south and west.\nPlease enter a direction.\n"
dragons_den: .asciiz "\nYou enter the Dragon's Den.  I hope you're prepared...\n"
victory_vault: .asciiz "\Turns out you are.\nWith apparant ease, you slay the dragon and enter the Victory Vault to enjoy the spoils of Victory, whatever they may be in this case."
grievous_graveyard:  .asciiz "\nYou are not.  You hold up your fists to defend against the dragon.\nNice try.  Perhaps the next adventurer will have the foresight to prepare."
grievous_graveyard_potion: .asciiz "\nYou are not.  The dragon eats you.\nAs you enter the dragon's stomach, you decide now might be a good time for one last drink.\nYou open the potion and begin to drink.\n"
reset: .asciiz "\nEverything goes dark and you wake up outside of a dungeon.  That was a strange dream.\n"
victory_vault_potion: .asciiz "\nAnd you still have your potion. You dog, you.\n"
insert_into: .word 4

.text

main:
	li $s0, 'n'
	li $s1, 'e'
	li $s2, 's'
	li $s3, 'w'
	add $s4, $zero, $zero #POTION
	add $s5, $zero, $zero #SWORD
	li $s6, 'r' #For resetting

	la $a0, begin
	li $v0, 4
	syscall

CaveOfCacophony:
	la $a0, cave_of_cacophony
	li $v0, 4
	syscall
	
	la $a0, insert_into
	la $a1, insert_into
	li $v0, 8
	syscall

	lb $t0, insert_into
	beq $t0, $s1, TwistyTunnel
	beq $t0, $s6, RESET
	
	j CaveOfCacophony

TwistyTunnel:
	la $a0, twisty_tunnel
	li $v0, 4
	syscall

	la $a0, insert_into
	la $a1, insert_into
	li $v0, 8
	syscall

	lb $t0, insert_into
	beq $t0, $s0, PotionParlor
	beq $t0, $s1, LengthyLabyrinth
	beq $t0, $s2, RapidRiver
	beq $t0, $s3, CaveOfCacophony
	beq $t0, $s6, RESET

	j TwistyTunnel

PotionParlor:

	bne $s4, $zero, PotionParlorAgain

	addi $s4, $zero, 1 #ASSERT POTION

	la $a0, potion_parlor
	li $v0, 4
	syscall

	la $a0, insert_into
	la $a1, insert_into
	li $v0, 8
	syscall

	lb $t0, insert_into
	beq $t0, $s2, TwistyTunnel
	beq $t0, $s6, RESET

	j PotionParlor

PotionParlorAgain:
	la $a0, potion_parlor_again
	li $v0, 4
	syscall

	la $a0, insert_into
	la $a1, insert_into
	li $v0, 8
	syscall

	lb $t0, insert_into
	beq $t0, $s2, TwistyTunnel
	beq $t0, $s6, RESET

	j PotionParlorAgain

RapidRiver:
	la $a0, rapid_river
	li $v0, 4
	syscall

	la $a0, insert_into
	la $a1, insert_into
	li $v0, 8
	syscall

	lb $t0, insert_into
	beq $t0, $s3, SecretSwordStash
	beq $t0, $s1, DragonsDen
	beq $t0, $s0, TwistyTunnel
	beq $t0, $s6, RESET

	j RapidRiver

SecretSwordStash:
	bne $s5, $zero, SecretSwordStashAgain

	addi $s5, $zero, 1
	la $a0, secret_sword_stash
	li $v0, 4
	syscall

	la $a0, insert_into
	la $a1, insert_into
	li $v0, 8
	syscall

	lb $t0, insert_into
	beq $t0, $s1, RapidRiver
	beq $t0, $s6, RESET

	j SecretSwordStash

SecretSwordStashAgain:
	la $a0, secret_sword_stash_again
	li $v0, 4
	syscall

	la $a0, insert_into
	la $a1, insert_into
	li $v0, 8
	syscall

	lb $t0, insert_into
	beq $t0, $s1, RapidRiver
	beq $t0, $s6, RESET

	j SecretSwordStashAgain

LengthyLabyrinth:
	la $a0, lengthy_labyrinth
	li $v0, 4
	syscall

	la $a0, insert_into
	la $a1, insert_into
	li $v0, 8
	syscall

	lb $t0, insert_into
	beq $t0, $s0, MiniMaze
	beq $t0, $s1, HallOfMirrors
	beq $t0, $s3, TwistyTunnel
	beq $t0, $s6, RESET

	j LengthyLabyrinth

MiniMaze:
	la $a0, mini_maze
	li $v0, 4
	syscall

	la $a0, insert_into
	la $a1, insert_into
	li $v0, 8
	syscall

	lb $t0, insert_into
	beq $t0, $s1, HallOfMirrors
	beq $t0, $s2, LengthyLabyrinth
	beq $t0, $s6, RESET

	j MiniMaze

HallOfMirrors:
	la $a0, hall_of_mirrors
	li $v0, 4
	syscall

	la $a0, insert_into
	la $a1, insert_into
	li $v0, 8
	syscall

	lb $t0, insert_into
	beq $t0, $s2, LengthyLabyrinth
	beq $t0, $s3, MiniMaze
	beq $t0, $s6, RESET

	j HallOfMirrors

DragonsDen:
	la $a0, dragons_den
	li $v0, 4
	syscall

	bne $s5, $zero, VictoryVault
	bne $s4, $zero, GrievousGraveyardPotion

	j GrievousGraveyardDeath

VictoryVault:
	la $a0, victory_vault
	li $v0, 4
	syscall
	
	beq $s4, $zero, EXIT
	
	la $a0, victory_vault_potion
	li $v0, 4
	syscall

	j EXIT

GrievousGraveyardPotion:
	la $a0, grievous_graveyard_potion
	li $v0, 4
	syscall

	la $a0, reset
	li $v0, 4
	syscall

	j main

GrievousGraveyardDeath:
	la $a0, grievous_graveyard
	li $v0, 4
	syscall

	j EXIT

RESET:
	la $a0, reset
	li $v0, 4
	syscall
	
	j main

EXIT:
	li $v0, 10
	syscall
