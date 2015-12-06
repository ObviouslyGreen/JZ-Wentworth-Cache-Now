ORIGIN 4x0000

SEGMENT CodeSegment:

	;; asd;ljfka;sdlfjk
	;; as;dljfasd;ljf
	;; as;dlkfjas;dlfkj
;; asd;lfkjas;dfl

	LDR R1, R0, ONE 	; R1<=1
	LDR R2, R0, TWO
	LDR R3, R0, ONE
Loop1:
	SUB R5, R2, R1 
	OR R6, R5, R2
	MULT R4, R6, R2
	XOR R6, R4, R2
	LDR R5, R0, TWELVE
	DIV R1, R5, R4
	
HALT:
	BRnzp HALT

ONE:	DATA2 4x0001
TWO:	DATA2 4x0002
TWELVE: DATA2 4x000c

