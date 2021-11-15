;; =============================================================
;; CS 2110 - Fall 2021
;; Project 3 - Dot Product
;; =============================================================
;; Name:
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
;;   while (elementB > 0) {
;;     multSum += elementA;
;;     if (elementB < 0) {
;;       elementB++;
;;     } else if (elementB > 0) {
;;       elementB--;
;;     }
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

;; Your code here!!

HALT

VECTOR_A    .fill x4000
VECTOR_B    .fill x4100
LENGTH      .fill 3
RESULT      .blkw 1
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