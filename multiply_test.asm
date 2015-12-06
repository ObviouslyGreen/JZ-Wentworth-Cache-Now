ORIGIN 4x0000

SEGMENT CodeSegment:

	LDR R1, R0, ONE 
	LDR R2, R0, TWO
	LDR R3, R0, FIVE
	LDR R4, R0, TEN
	LDR R5, R0, ZERO

# ADD 5 to R5 10 times
Loop1:
	ADD R5, R3, R5
	SUB R4, R4, R1
	BRnz multiply
	
multiply:
	MULT R6, R3, R4

HALT:
	BRnzp HALT
ZERO: 	DATA2 4x0000
ONE:	DATA2 4x0001
TWO:	DATA2 4x0002
FIVE: 	DATA2 4x0005
TEN:	DATA2 4x000A