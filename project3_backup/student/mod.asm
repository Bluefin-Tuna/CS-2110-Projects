;; =============================================================
;; CS 2110 - Fall 2021
;; Project 3 - Modulus
;; =============================================================
;; Name:
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

HALT

A       .fill 5
B       .fill 3
RESULT  .blkw 1
.end
