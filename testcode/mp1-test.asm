; Compute X!, where X is stored at INPUT
; By Michael Chen (mychen5)
ORIGIN 4x0000

SEGMENT CodeSegment:
	LEA R0, DataSegment
	LEA R1, DataSegment
	ADD R1, R1, 1
	LDB R2, R0, TESTLDB
	LDB R3, R1, TESTLDB

TRAPTEST:
	TRAP TEST123 		; TRAP into FACTORIAL Segment
	JSR FACTORIAL 		; Do Factorial Subtroutine
	LEA R0, HALT		;
	JMP R0			; JMP to HALT

FACTORIAL:
	LDR R1, R0, INPUT 	; R1 <= 5 (INPUT Value)
	LDR R2, R0, COUNT	; R2 <= 4 (INPUT - 1), Counter for addition loop
	LDR R4, R0, NEGONE	; R4 <= -1

LOOP0:
	ADD R3, R2, 0		; R3 <= R2

; Use Addition loop to multiply (5*4 = 5+5+5+5)
; Then 20*3 = 20+20+20
LOOP1:
	ADD R5, R5, R1		; R5 <= R5 + R1, Accumulate
	ADD R3, R3, R4		; R3 <= R3 + R4, Decrement counter
	BRp	LOOP1			; Branch back to LOOP1 if positive

	ADD R1, R5, 0		; R1 <= R5 + R0, R1 contains final result
	AND R5, R5, 0		; R5 <= 0, Clear R5
	ADD R2, R2, R4		; R2 <= R2 + R4, Decrement addition loop counter
	BRp LOOP0			; Branch back to LOOP0 if positive

	STR R1, R0, RESULT 	; Factorial stored at RESULT
	RET 				; RETURN to after TRAP
HALT:                   ; Infinite loop to keep the processor
    BRnzp HALT          ; from trying to execute the data below

SEGMENT        DataSegment:
INPUT: 	DATA2 4x0005
COUNT: 	DATA2 4x0004
NEGONE: DATA2 4xFFFF
RESULT: DATA2 4x0000
TESTLDB: DATA2 4xDCAC
TEST123: DATA2 TrapCatch
TrapCatch:ADD R1, R1, 1337
	RET

