;; Shibo Yao
;; Calculate factorial of five and stores it into R1

;; Register Table
;; R0 - Used as a zero value
;; R1 - Contains factorial result
;; R2 - Used as a negative one
;; R3 - Counter for factorial
;; R4 - Counter for multiplication 
;; R5 - Contains current product/sum
ORIGIN 4x0000

SEGMENT  CodeSegment:
    LDR R1, R0, FIVE    ; R1 <= 5
    LDR R2, R0, NEG_ONE ; R2 <= -1
    ADD R3, R1, R2      ; R3 <= R1 - 1
    ADD R3, R3, R2      ; R3 <= R3 - 1 OR R3 <= R1 - 2

FACT:
    ADD R4, R0, R3      ; R4 <= R3

MULT:
    ADD R5, R5, R1      ; R5 <= R5 + R1
    ADD R4, R4, R2      ; R4 <= R4 - 1
    BRzp MULT           ; Add until R4 decrements to zero

    ADD R1, R0, R5      ; R1 <= R5
    AND R5, R0, R0      ; R5 <= 0
    ADD R3, R3, R2      ; R3 <= R3 - 1
    BRzp FACT           ; Add until R3 decrements to zero

    STR R1, R0, RESULT
HALT:
    BRnzp HALT

FIVE:    DATA2 4x0005
NEG_ONE: DATA2 4xFFFF
RESULT:  DATA2 4x0000