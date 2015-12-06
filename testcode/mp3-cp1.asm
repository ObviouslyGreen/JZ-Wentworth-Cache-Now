ORIGIN 4x0000
SEGMENT  CodeSegment:
   
   LDR  R1, R0, NEGTWO  ; R1 <= -2
   LDI  R2, R0, TEST    ; R2 <= 0x34
   LDR  R4, R0, ONE     ; R4 <= 1
   NOP
   NOP
   NOP
   NOP
   NOP
   BRnzp LOOP
   NOP
   NOP
   NOP
   NOP

TEST:   DATA2 4x001c
TEST1:  DATA2 4x1234
ONE:    DATA2 4x0001
NEGTWO: DATA2 4xFFFE
TEMP1:  DATA2 4x0001
GOOD:   DATA2 4x600D
BADD:   DATA2 4xBADD

LOOP:
   ADD R3, R1, R2       ; R3 <= R1 + R2
   AND R5, R1, R4       ; R5 <= R1 AND R4
   NOT R6, R1           ; R6 <= NOT R1
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   STR R6, R0, TEMP1    ; M[TEMP1] <= R6
   LDR R7, R0, TEMP1    ; R7 <= M[TEMP1]
   STI R3, R0, TEST
   LDI R6, R0, TEST
   ADD R1, R1, R4       ; R1 <= R1+1
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   BRp LOOP2
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   BRnzp LOOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP

LOOP2:
   ADD R1, R0, 1
   LDB R2, R0, TEST1
   NOP
   NOP
   NOP
   NOP
   LDB R4, R1, TEST1
   NOP
   NOP
   NOP
   NOP
   STB R2, R0, TEST
   NOP
   NOP
   NOP
   NOP
   STB R4, R1, TEST
   NOP
   NOP
   NOP
   NOP
   LDR R5, R0, TEST
   NOP
   NOP
   NOP
   NOP

HALT:
   LDR  R1, R0, BADD
   BRnzp HALT
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP

DONE:
   LDR  R1, R0, GOOD
   BRnzp DONE
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
