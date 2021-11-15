;; =============================================================
;; CS 2110 - Fall 2021
;; Project 3 - Compare
;; =============================================================
;; Name:Vincent Fang
;; =============================================================

;; Suggested Pseudocode (see PDF for explanation)
;;
;; a = mem[A];
;; b = mem[B];
;; diff = a - b;
;; if (diff > 0) {
;;   return 1;
;; } else if (diff < 0) {
;;   return -1;
;; } else {
;;   return 0;
;; } 

.orig x3000
LD R0, A
LD R1, B
NOT R3, R1
ADD R3, R3, 1
AND R2, R2, 0
ADD R3, R0, R3
BRn NEG
BRz ZERO
BRp POS
NEG ADD R2, R2, -1
BR END
ZERO BR END
POS ADD R2, R2, 1
BR END
END
ST R2, RESULT
HALT

A       .fill 10
B       .fill 10
RESULT  .blkw 1
.end
