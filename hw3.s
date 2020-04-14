#############################################################################
## 
##       		     HOMEWORK 3
##
## - Fill in the five functions described below.
## - Modify only the function bodies.  Do not modify any of the function
##   names or other parts of this file.
## - All of your implementations should adhere to MIPS calling conventions.
## - When working correctly, your file should print out the following (one
##   line of output for each question):	
##
##	$ spim -file tkp2108.s
##      SPIM Version 6.5 of January 4, 2003
##      Copyright 1990-2003 by James R. Larus (larus@cs.wisc.edu).
##      All Rights Reserved.
##      See the file README for a full copyright notice.
##      Loaded: /opt/spim-6.5/share/spim-6.5/trap.handler
##      Problem 1: 18 625 30
##      Problem 2: 1 10 0
##      Problem 3: 2 -1 -1 0
##      Problem 4: 1 1 0
##      Problem 5: 0 2 2 4
##	
##                Administrative Instructions
##	
## - We will be testing your programs using QtSPIM
## - For download, from http://spimsimulator.sourceforge.net/
## - Documentation can be found here:
##         http://spimsimulator.sourceforge.net/further.html
## - To turn in your code
##      1. Rename this file from UNI.s to your UNI (e.g. "mv UNI.s tkp2108.s")
##	    2. Upload your file to Courseworks
##
##   NB: The entire file is a single namespace, meaning your label names
##   need to be globally unique.
##	
##################################################################### 

	      .data
newline:      .asciiz "\n"
problem:      .asciiz "Problem"
somechars:    .asciiz "ABC?.3"
hello:	      .asciiz "hello"
world:	      .asciiz "world"
help:	      .asciiz "help"
vec1:	      .word 40, 100, 0
vec2:	      .word 40, 35, 47, 200, 43, 37, 31, 90, 62
vec3:	      .word -5, 0
vec4:	      .word 0
	      
	      .text
	      .globl main
	      
##################################################################### 
##    		 PROBLEM 1: weighted_avg
##
## Compute a weighted average of three 32-bit numbers, A, B, and C
## 	return (.25A + .25B + .5C)
## A,B, and C are in $a0, $a1, and $a2 respectively.  The result
## should be returned in $v0.
##	
## HINT: Do not use mult/div or floating point values.  To keep
## precision for as long as possible, minimize the number of
## division operations.	
##################################################################### 
				    
weighted_avg:

	# YOUR CODE HERE
		
	#multiply .25A
	li	$t0, 25	#b
	li	$t1, 0	#result
	li	$t2, 0	#odd/even
	li	$t3, 1	#one
			
	mult_loop1:
		beq	$t0, 0, save1
		
		andi	$t2, $t0, 1
		
		beq	$t2, 0, skip1
		
		add	$t1, $t1, $a0
	skip1:
		sll	$a0, $a0, 1
		srl	$t0, $t0, 1
		
		j mult_loop1
		
	save1:
		la	$a0, ($t1)
	
	#multiply 25b
	li	$t0, 25	#b
	li	$t1, 0	#result
	li	$t2, 0	#odd/even
	li	$t3, 1	#one
			
	mult_loop2:
		beq	$t0, 0, save2
		
		andi	$t2, $t0, 1
		
		beq	$t2, 0, skip2
		
		add	$t1, $t1, $a1
	skip2:
		sll	$a1, $a1, 1
		srl	$t0, $t0, 1
		
		j mult_loop2
		
	save2:
		la	$a1, ($t1)
		
	
	#multiply 50c
	li	$t0, 50	#b
	li	$t1, 0	#result
	li	$t2, 0	#odd/even
	li	$t3, 1	#one
			
	mult_loop3:
		beq	$t0, 0, save3
		
		andi	$t2, $t0, 1
		
		beq	$t2, 0, skip3
		
		add	$t1, $t1, $a2
	skip3:
		sll	$a2, $a2, 1
		srl	$t0, $t0, 1
		
		j mult_loop3
		
	save3:
		la	$a2, ($t1)
	    	
	#at this point, all values are calculated and stored in a0, a1, a2
	
	#add add the values
	add	$a0, $a0, $a1
	add	$a0, $a0, $a2
	divu	$v0, $a0, 100
	
	
	jr	$ra
##################################################################### 
##    		  PROBLEM 2: min4
##
## Return the minimum, assuming unsigned integers, of $a0, $a1, $a2,
## and $a3 in $v0.
##################################################################### 	
	      
min4:
	# YOUR CODE HERE
		
	slt	$t0, $a0, $a1	#if $a0 < $a1, $t0 = 1
	beq	$t0, 1, comp1	#a0
	beq	$t0, 0, comp2	#a1
	
	comp1:
		slt	$t0, $a0, $a2	#if $a0 < $a2, $t0 = 1
		beq	$t0, 1, comp3	#a0
		beq	$t0, 0, comp4	#a2
		
	comp2:
		slt	$t0, $a1, $a2	#if $a1 < $a2, $t0 = 1
		beq	$t0, 1, comp5	#a1
		beq	$t0, 0, comp4	#a2
		
	comp3:
		slt	$t0, $a0, $a3	#if $a0 < $a3, $t0 = 1
		beq	$t0, 1, result0	#a0
		beq	$t0, 0, result3	#a3
		
	comp4:
		slt	$t0, $a2, $a3	#if $a2 < $a3, $t0 = 1
		beq	$t0, 1, result2	#a2
		beq	$t0, 0, result3	#a3
		
	comp5:
		slt	$t0, $a1, $a3	#if $a0 < $a1, $t0 = 1
		beq	$t0, 1, result1	#a1
		beq	$t0, 0, result3	#a3
		
	result0:
		la	$v0, ($a0)
		jr	$ra
		
	result1:
		la	$v0, ($a1)
		jr	$ra
		
	result2:
		la	$v0, ($a2)
		jr	$ra
		
	result3:
		la	$v0, ($a3)
		jr	$ra
		
		jr    $ra
##################################################################### 
##    		PROBLEM 3: length
##
## Given a zero-terminated list of 4 byte integers ranging from 1-100
## (inclusive), count the number of elements in the list.
##  - The terminating zero should not be included in the count.
##  - If a value outside of legal range (1 >= x <= 100) is found
##    indicate an error by returning -1.
##  - Function takes one argument, a pointer to the start of the list
##################################################################### 
	
length:	 
	# YOUR CODE HERE
	
	li	$t0, 0		#counter     
	li	$t4, 1
	li	$t3, 100
 	
 	
 	loop_q3:
 		lb	$t1, 0($a0)	#load first array val
 	
 		#if = 0
 		beq	$t1, $zero, zero_exit
 	
 		#if less than 1
 		slt 	$t5, $t1, $t4
 		beq	$t5, 1, invalid_exit
 		
 		#if greater than 100
 		sgt 	$t5, $t1, $t3
 		beq	$t5, 1, invalid_exit
 		
 		b increment
 		
 	invalid_exit:
 		la	$v0, -1
 		jr	$ra
 		
 	zero_exit:
 		la	$v0, ($t0)
 		jr	$ra
 		
 	increment:
 		addiu	$t0, $t0, 1
 		addiu	$a0, $a0, 4
 		b loop_q3

#####################################################################
##    		    PROBLEM 4: diffchar
##	
##  Given two ASCII characters in $a0 and $a1, return
##     - 1 if they are different
##     - 0 if they are the same
#####################################################################

diffchar:     
	# YOUR CODE HERE
	
	beq	$a0, $a1, eq
	
	li	$v0, 1
	jr	$ra
	
	eq:
		li	$v0, 0
		jr	$ra

#####################################################################
##	        PROBLEM 5: hamming
##
##  Compute the hamming distance (i.e., number of different characters)
##  between two strings.
##  - The two arguments are pointers to two null-terminated strings
##    of characters.
##  - If one string is shorter than the other, the mismatches all
##    count as 1, e.g., hello
##                      help
##                      00011 = hamming distance of 2        
##  - You should use your diffchar function from problem 4.
#####################################################################
	
hamming:      
	# YOUR CODE HERE
	
	li	$t0, 0		#counter
	
	loop_q5:
	
		lb	$t1, 0($a0)	#load first value in string1
		lb	$t2, 0($a1)	#load first value in string2
		
		beq	$t1, $zero, end_str1
		beq	$t2, $zero, end_str2
		
		bne	$t1, $t2, cntr_increment
		beq 	$t1, $t2, str_increment
	
	cntr_increment:
		addiu	$t0, $t0, 1	#increment counter + 1
 	
 	str_increment:
 		addiu	$a0, $a0, 1	#increment string1, char = 1 byte
 		addiu	$a1, $a1, 1	#increment string2, char = 1 byte
 		
 		b loop_q5
 	
 	end_str1:
 		beq	$t2, $zero, complete
 		
 		addiu	$t0, $t0, 1	#increment counter + 1
 		addiu	$a1, $a1, 1	#increment string2, char = 1 byte
 		
 		b loop_q5
 		
 	end_str2:
 		beq	$t1, $zero, complete
 		
 		addiu	$t0, $t0, 1	#increment counter + 1
 		addiu	$a0, $a0, 1	#increment string1, char = 1 byte
 		
 		b loop_q5
 		
 	complete:
 		la	$v0, ($t0)
 		jr	$ra

####################################################################
##            DO NOT MODIFY BELOW THIS LINE                       ##
####################################################################

main:
########################################
##         TEST PROBLEM 1             ##
########################################

	      li    $a0, 1
	      jal   print_problem_header

	      li    $a0, 42
	      li    $a1, 10
	      li    $a2, 10
	      jal   weighted_avg              # weighted_avg = 18
	      move  $a0, $v0
	      jal   print_int
	      jal   print_space

	      li    $a0, 500
	      li    $a1, 1000
	      li    $a2, 500
	      jal   weighted_avg              # weighted_avg = 625
	      move  $a0, $v0
	      jal   print_int
	      jal   print_space

	      li    $a0, 30
	      li    $a1, 31
	      li    $a2, 30
	      jal   weighted_avg              # weighted_avg = 30
	      move  $a0, $v0
	      jal   print_int
	      jal   print_newline

########################################
##            TEST PROBLEM 2          ##
########################################

	      li    $a0, 2
	      jal   print_problem_header

	      li    $a0, 1
	      li    $a1, 10
	      li    $a2, 100
	      li    $a3, 1000
	      jal   min4              # min4 = 1
	      move  $a0, $v0
	      jal   print_int
	      jal   print_space

	      li    $a0, 1000
	      li    $a1, 10
	      li    $a2, 100
	      li    $a3, 1000
	      jal   min4              # min4 = 10
	      move  $a0, $v0
	      jal   print_int
	      jal   print_space

	      li    $a0, 10
	      li    $a1, 1
	      li    $a2, 0
	      li    $a3, 8
	      jal   min4              # min4 = 0
	      move  $a0, $v0
	      jal   print_int
	      jal   print_newline

########################################
##            TEST PROBLEM 3          ##
########################################

	      li    $a0, 3
	      jal   print_problem_header

	      la    $a0, vec1
	      jal   length            # length = 3
	      move  $a0, $v0
	      jal   print_int
	      jal   print_space

	      la    $a0, vec2
	      jal   length            # length = -1
	      move  $a0, $v0
	      jal   print_int
	      jal   print_space

	      la    $a0, vec3
	      jal   length            # length = -1
	      move  $a0, $v0
	      jal   print_int
	      jal   print_space

	      la    $a0, vec4
	      jal   length            # length = 0
	      move  $a0, $v0
	      jal   print_int
	      jal   print_newline

########################################
##            TEST PROBLEM 4          ##
########################################

	      li    $a0, 4
	      jal   print_problem_header

	      la    $s0, somechars

	      la    $a0, 42($a0)
	      la    $a1, 1($s0)
	      jal   diffchar         # diffchar = 1
	      move  $a0, $v0
	      jal   print_int
	      jal   print_space


	      la    $a0, 4($s0)
	      la    $a1, 5($s0)
	      jal   diffchar        # diffchar = 1
	      move  $a0, $v0
	      jal   print_int
	      jal   print_space

	      la    $a0, 2($s0)
	      la    $a1, 2($s0)
	      jal   diffchar        # diffchar = 0
	      move  $a0, $v0
	      jal   print_int
	      jal   print_newline

########################################
##            TEST PROBLEM 5          ##
########################################

	      li    $a0, 5
	      jal   print_problem_header

	      la    $a0, hello
	      la    $a1, hello
	      jal   hamming         # hamming = 0
	      move  $a0, $v0
	      jal   print_int
	      jal   print_space

	      la    $a0, hello
	      la    $a1, help
	      jal   hamming         # hamming = 2
	      move  $a0, $v0
	      jal   print_int
	      jal   print_space

	      la    $a0, help
	      la    $a1, hello
	      jal   hamming         # hamming = 2
	      move  $a0, $v0
	      jal   print_int
	      jal   print_space

	      la    $a0, hello
	      la    $a1, world
	      jal   hamming         # hamming = 4
	      move  $a0, $v0
	      jal   print_int
	      jal   print_newline


########################################
##            EXIT                    ##
########################################

	      li    $v0, 10
	      syscall


####################################################################
##                      HELPER FUNCTIONS                          ##
####################################################################

print_problem_header:
	      addi  $sp, $sp -8
	      sw    $s0, 0($sp)
	      sw    $ra, 4($sp)
	      move  $s0, $a0
	      la    $a0, problem
	      jal   print_string
	      jal   print_space
	      move  $a0, $s0
	      jal   print_int
	      li    $a0, 58
	      jal   print_char
	      jal   print_space
	      lw    $s0, 0($sp)
	      lw    $ra, 4($sp)
	      addi  $sp, $sp, 8
	      jr    $ra

print_string:
	      li    $v0, 4
	      syscall
	      jr    $ra

print_char:   li    $v0, 11
	      syscall
	      jr    $ra
	      
print_int:    li    $v0, 1 
	      syscall
	      jr    $ra

print_space:
	li    $a0, 32
	li    $v0, 11
	syscall
	jr    $ra
	
print_newline:
	      la    $a0, newline
	      li    $v0, 4
	      syscall
	      jr    $ra

####################################################################
##                       END OF FILE                              ##
####################################################################
	
