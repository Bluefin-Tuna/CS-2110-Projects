;; =============================================================
;; CS 2110 - Fall 2021
;; Project 3 - Dot Product
;; =============================================================
;; Name: Vincent Fang
;; =============================================================

;; Suggested Pseudocode (see PDF for explanation)
;;
;; vector_A_init = mem[VECTOR_A];
;; vector_B_init = mem[VECTOR_B];
;; index = mem[LENGTH];
;; index -= 1;
;; result = 0
;; 
;; while (index >= 0) {
;;   elementA = mem[vector_A_init + index];
;;   elementB = meM[vector_B_init + index];
;;   multSum = 0
;;   
;;   while (elementB != 0) {
;;     multSum += elementA;
;;     if (elementB < 0) {
;;       elementB++;
;;     } else if (elementB > 0) {
;;       elementB--;
;;     }
;;   }
;; 
;;   if (elementA > 0) {
;;     if (elementB < 0) {
;;        multSum = ~multSum + 1;
;;     }
;;   } else if (elementA < 0) {
;;     if (elementB < 0) {
;;        multSum = ~multSum + 1;
;;     }
;;   }
;;   
;;   result += multSum;
;;   index--;
;; }
;;
;; mem[RESULT] = result;

.orig x3000



LD R2, LENGTH ;; Your code here!!
ADD R2, R2, -1   ;; R2 is Index
AND R3, R3, 0    ;; R3 is Result
AND R4, R4, 0    ;; R4 is Intermediate Sum

BR START

WHILE LD R0, VECTOR_A  ;; Reloading R0 
LD R1, VECTOR_B  ;; Reloading R1
ADD R0, R0, R2
ADD R1, R1, R2
BR MULT
MULTEND ADD R0, R0, 0
BRp APOS
BRn ANEG

SIGNEND ADD R3, R3, R4
ADD R2, R2, -1
START ADD R2, R2, 0 
BRzp WHILE 
BR END

WMULT ST R1, TEMPB

ADD R4, R4, R0
ADD R1, R1, 0
BRn NEG
BRp POS
MULT ADD R1, R1, 0
BRnp WMULT

LD R1, TEMPB
BR MULTEND

NEG ADD R1, R1, 1
BR MULT

POS ADD R1, R1, -1
BR MULT

;; ----------------------------------------------------------------------------------------------------------------------------------
APOS ADD R1, R1, 0
BRn APOSBNEG
BR SIGNEND

APOSBNEG NOT R4, R4
ADD R4, R4, 1
BR SIGNEND

ANEG ADD R1, R1, 0
BRp ANEGBPOS
BR SIGNEND

ANEGBPOS NOT R4, R4
ADD R4, R4, 1
BR SIGNEND

END ST R3, RESULT
HALT

VECTOR_A    .fill x4000
VECTOR_B    .fill x4100
LENGTH      .fill 3
RESULT      .blkw 1
TEMPB       .blkw 1
.end

.orig x4000
    .fill 1
    .fill -2
    .fill 4
.end

.orig x4100
    .fill -1
    .fill -2
    .fill 3
.end