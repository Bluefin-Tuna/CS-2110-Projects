;; =============================================================
;; CS 2110 - Fall 2021
;; Project 3 - To Upper
;; =============================================================
;; Name:
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

HALT

LOWER_A     .fill -97
LOWER_Z     .fill -122

STRING      .fill x4000
RESULT      .blkw 1
.end

.orig x4000
.stringz "cOtTonCANdy"
.end
