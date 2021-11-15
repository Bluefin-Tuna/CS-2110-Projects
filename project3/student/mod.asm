;; =============================================================
;; CS 2110 - Fall 2021
;; Project 3 - Modulus
;; =============================================================
;; Name: Vincent Fang
;; =============================================================

;; Suggested Pseudocode (see PDF for explanation)
;;
;; a = mem[A];
;; b = mem[B];
;; 
;; if (a < 0) {
;;   a = ~a + 1;
;; }
;; 
;; if (b < 0) {
;;   b = ~b + 1;
;; }
;; 
;; while (a >= b) {
;;   a = a - b;
;; }
;; 
;; mem[RESULT] = a

.orig x3000

;; Your code here!!
LD R0, A
BRzp LOADB
NOT R0, R0
ADD R0, R0, 1

LOADB LD R1, B
BRzp ABSEND
NOT R1, R1
ADD R1, R1, 1
BR ABSEND

ABSEND NOT R3, R1
ADD R3, R3, 1

WHILE ADD R0, R0, R3
BRzp WHILE

ADD R0, R0, R1
ST R0, RESULT
 

HALT

A       .fill 1
B       .fill 1
RESULT  .blkw 1
.end
