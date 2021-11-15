	;; =============================================================
;; CS 2110 - Fall 2021
;; Project 3 - To Upper
;; =============================================================
;; Name: Vincent Fang
;; =============================================================

;; Suggested Pseudocode (see PDF for explanation)
;;
;; index = mem[STRING];
;; lowerBound = 97;
;; upperBound = 122;
;; 
;; while (mem[index] != 0) {
;; char = mem[STRING + index];
;;   if (char >= lowerBound && char <= upperBound) {
;;     char = char - 32;
;;     mem[index] = char;
;;   }
;; 
;;   index++;
;; }

.orig x3000

;; Your code here!!
LD R0, LOWER_A
LD R1, LOWER_Z
LD R2, STRING
BR START 

WHILE 
ADD R4, R3, R0
BRzp PASSLOWER
INCR ADD R2, R2, 1
START LDR R3, R2, 0
BRnp WHILE
BR END

PASSLOWER ADD R4, R3, R1
BRnz PASSHIGHER
BR START

PASSHIGHER ADD R3, R3, -16
ADD R3, R3, -16
STR R3, R2, 0
BR INCR

END
HALT

LOWER_A     .fill -97
LOWER_Z     .fill -122

STRING      .fill x4000
RESULT      .blkw 1
.end

.orig x4000
.stringz "cOtTonCANdy"
.end
