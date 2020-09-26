.data
	successMessage: .asciiz "Success! Location: "
	failMessage: .asciiz "Fail!"
	newline: .asciiz "\n"
	buffer: .space 1024
	size: .word 1024
	charBuffer: .space 2
	charBufferSize: .word 2
.text
	# read string
	la $a0, buffer
	la $a1, size
	lw $a1, 0($a1)
	addi $v0, $0, 8
	syscall
readLoop:
	la $a0, charBuffer
	la $a1, charBufferSize
	lw $a1, 0($a1)
	addi $v0, $0, 8
	syscall
	# Always print a newline after reading a character
	lb $s0, 0($a0)
	beq $s0, 10, find
	add $a0, $0, $0
	jal println 
find:
	# check if ?
	addi $t0, $0, 63
	beq $s0, $t0, end
	# search the input character in the string
	la $s1, buffer
	lb $t0, 0($s1)
findLoop:
	beq $t0, $0, endOfString
	bne $s0, $t0, nextIteration
	# print success message
	la $a0, successMessage
	jal print
	# compute the index and print
	la $t0, buffer
	sub $t0, $s1, $t0
	addi $a0, $t0, 1
	addi $v0, $0, 1
	syscall
	add $a0, $0, $0
	jal println
	j readLoop
nextIteration:
	addi $s1, $s1, 1
	lb $t0, 0($s1)
	j findLoop
endOfString:
	# Cannot find target character, read next target
	la $a0, failMessage
	jal println
	j readLoop
end:	
	addi $v0, $0, 10
	syscall

# void print(char* a)
# if a == NULL, print nothing
# else print string
print:
	beq $a0, $0, printEnd
	addi $v0, $0, 4
	syscall
printEnd:
	jr $ra

# void println(char* a)
# if a == NULL, only print newline character
# else print the string and a newline character
println:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal print
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	la $a0, newline
	addi $v0, $0, 4
	syscall
	jr $ra
