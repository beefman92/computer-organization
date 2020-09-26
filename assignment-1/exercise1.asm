.data:
	buffer: .asciiz "a"
	size: .word 2
	newline: .asciiz "\n"
	aStr: .asciiz "alpha"
	bStr: .asciiz "bravo"
	cStr: .asciiz "china"
	dStr: .asciiz "delta"
	eStr: .asciiz "echo"
	fStr: .asciiz "foxtrot"
	gStr: .asciiz "golf"
	hStr: .asciiz "hotel"
	iStr: .asciiz "india"
	jStr: .asciiz "juliet"
	kStr: .asciiz "kilo"
	lStr: .asciiz "lima"
	mStr: .asciiz "mary"
	nStr: .asciiz "november"
	oStr: .asciiz "oscar"
	pStr: .asciiz "paper"
	qStr: .asciiz "quebec"
	rStr: .asciiz "research"
	sStr: .asciiz "sierra"
	tStr: .asciiz "tango"
	uStr: .asciiz "uniform"
	vStr: .asciiz "victor"
	wStr: .asciiz "whisky"
	xStr: .asciiz "x-ray"
	yStr: .asciiz "yankee"
	zStr: .asciiz "zulu"
	oneStr: .asciiz "First"
	twoStr: .asciiz "Second"
	threeStr: .asciiz "Third"
	fourStr: .asciiz "Fourth"
	fiveStr: .asciiz "Fifth"
	sixStr: .asciiz "Sixth"
	sevenStr: .asciiz "Seventh"
	eightStr: .asciiz "Eighth"
	nineStr: .asciiz "Ninth"
	zeroStr: .asciiz "zero"
	otherStr: .asciiz "*"
	
.text:
loop:	la $a0, buffer
	la $t0, size
	lw $a1, 0($t0)
	li $v0, 8
	syscall
	# Always print a newline after reading a character
	lb $t0, 0($a0)
	beq $t0, 10, printOutput
	add $a0, $0, $0
	jal println 
printOutput:
	# Get output string
	la $a0, buffer
	lb $a0, 0($a0)
	add $a1, $0, $a0
	addi $t0, $0, 63
	beq $t0, $a0, end
	jal convert
	add $a0, $0, $v0
	jal println
	j loop
end:	addi $v0, $0, 10
	syscall

# void println(char* a)
# if a == NULL, only print newline character
# else print the string and a newline character
println:
	beq $a0, $0, printNewLine
	addi $v0, $0, 4
	syscall
printNewLine:
	la $a0, newline
	addi $v0, $0, 4
	syscall
	jr $ra
	
# char* convert(char c)
# Convert a character to its corresponding string
convert:
	la $v0, otherStr
	# if c is a digit
	addi $t2, $0, 47
	addi $t3, $0, 58
	add $t0, $0, $0
	add $t1, $0, $0
	slt $t0, $a0, $t3
	slt $t1, $t2, $a0
	and $t0, $t0, $t1
	bne $t0, $0, isDigit
	# if c is an uppercase letter
	addi $t2, $0, 64
	addi $t3, $0, 91
	add $t0, $0, $0
	add $t1, $0, $0
	slt $t0, $a0, $t3
	slt $t1, $t2, $a0
	and $t0, $t0, $t1
	add $a1, $0, $a0
	bne $t0, $0, isUppercase
	# if c is a lowercase letter
	addi $t2, $0, 96
	addi $t3, $0, 123
	add $t0, $0, $0
	add $t1, $0, $0
	slt $t0, $a0, $t3
	slt $t1, $t2, $a0
	and $t0, $t0, $t1
	add $a1, $0, $a0
	bne $t0, $0, isLowercase
exitConvert:
	jr $ra
	
isDigit:
	la $v0, zeroStr
	beq $a0, 48, exitConvert
	la $v0, oneStr
	beq $a0, 49, exitConvert
	la $v0, twoStr
	beq $a0, 50, exitConvert
	la $v0, threeStr
	beq $a0, 51, exitConvert
	la $v0, fourStr
	beq $a0, 52, exitConvert
	la $v0, fiveStr
	beq $a0, 53, exitConvert
	la $v0, sixStr
	beq $a0, 54, exitConvert
	la $v0, sevenStr
	beq $a0, 55, exitConvert
	la $v0, eightStr
	beq $a0, 56, exitConvert
	la $v0, nineStr
	beq $a0, 57, exitConvert
	j exitConvert

	# For uppercase and lowercase letters, they share same string
	# We only change the first character in the string based on case.
isUppercase:
	addi $a0, $a0, 32
	j isLowercase

isLowercase:
	la $v0, aStr
	beq $a0, 97, _1
	la $v0, bStr
	beq $a0, 98, _1
	la $v0, cStr
	beq $a0, 99, _1
	la $v0, dStr
	beq $a0, 100, _1
	la $v0, eStr
	beq $a0, 101, _1
	la $v0, fStr
	beq $a0, 102, _1
	la $v0, gStr
	beq $a0, 103, _1
	la $v0, hStr
	beq $a0, 104, _1
	la $v0, iStr
	beq $a0, 105, _1
	la $v0, jStr
	beq $a0, 106, _1
	la $v0, kStr
	beq $a0, 107, _1
	la $v0, lStr
	beq $a0, 108, _1
	la $v0, mStr
	beq $a0, 109, _1
	la $v0, nStr
	beq $a0, 110, _1
	la $v0, oStr
	beq $a0, 111, _1
	la $v0, pStr
	beq $a0, 112, _1
	la $v0, qStr
	beq $a0, 113, _1
	la $v0, rStr
	beq $a0, 114, _1
	la $v0, sStr
	beq $a0, 115, _1
	la $v0, tStr
	beq $a0, 116, _1
	la $v0, uStr
	beq $a0, 117, _1
	la $v0, vStr
	beq $a0, 118, _1
	la $v0, wStr
	beq $a0, 119, _1
	la $v0, xStr
	beq $a0, 120, _1
	la $v0, yStr
	beq $a0, 121, _1
	la $v0, zStr
	beq $a0, 122, _1
_1:	
	sb $a1, 0($v0)
	j exitConvert