;; =============================================================
;; CS 2110 - Fall 2021
;; Project 3 - Collatz Conjecture
;; =============================================================
;; Name:Vincent Fang
;; =============================================================

;; !!!! PLEASE READ !!!!!
;; - The specification for each subroutine can be found right after the corresponding
;;   label for the subroutine. It contains information about the input register(s),
;;   output register(s), and the operation that needs to be carried out
;; 
;; - For some subroutines, we ask that you follow the pseudocode provided in the pdf.
;;   You are welcome to deviate from it, but we won't be able to help you in case you
;;   run into issues with the autograder 
;; 
;; - To test your subroutines, we highly recommend that you to use complx before
;;	 running the autograder. Details on how to run subroutines in complx can be found
;;   in the project pdf. We have covered this in lab too, so feel free to rewatch one
;;   of the lab recordings on this. Doing it this way will save you a TON of time.

.orig x3000

;; DO NOT CHANGE THIS CODE

	LD R0, COLLATZ_ADDY
	JMP R0

	HALT

COLLATZ_ADDY	.fill x3300
.end

.orig x3100

SHIFTLEFT
;; Shifts a binary number a certain number of times to the left.
;;
;; input:		R1 = value, R1 = num_of_times
;; output:		R0 = value shifted num_of_times times to the left

;; SHIFTLEFT Suggested Pseudocode (see PDF for explanation)
;;
;; while (value > 0) {
;;	 value += value;
;;	 num_of_times -= 1;
;; }

;; Your code here!!
ST R2, SAVER2L
ST R3, SAVER3L

AND R2, R2, 0
ADD R2, R1, 0
BR STARTL
WHILEL ADD R0, R0, R0
ADD R2, R2, -1 
STARTL ADD R2, R2, 0
BRp WHILEL

LD R2, SAVER2L
LD R3, SAVER3L
RET

SAVER2L .blkw 1
SAVER3L .blkw 1

	HALT
.end

.orig x3200

SHIFTRIGHT
;; Shifts a binary number a certain number of times to the right.
;;
;; input:		R1 = value, R1 = num_of_times
;; output:		R0 = value shifted num_of_times times to the right

;; SHIFTRIGHT Suggested Pseudocode (see PDF for explanation)
;;
;; result = 0
;;    
;; while (num_of_times < 16) {
;;     result = result + result;
;;     if (value < 0) {
;;         result++;
;;     }
;;     value = value + value;
;;     num_of_times++;
;; }
;;
;;
;; Your code here!!
ST R2, SAVER2R
ST R3, SAVER3R

AND R2, R2, 0
ADD R2, R1, 0
AND R3, R3, 0
BR STARTR
WHILER ADD R3, R3, R3
ADD R0, R0, 0
BRn NEG
NEGEND ADD R0, R0, R0
ADD R2, R2, 1
STARTR ADD R4,R2,-16
BRn WHILER
BR END

NEG ADD R3, R3, 1
BR NEGEND

END AND R0, R0, 0
ADD R0, R3, 0

LD R2, SAVER2R
LD R3, SAVER3R
RET

SAVER2R .blkw 1
SAVER3R .blkw 1
	HALT
.end

.orig x3300

COLLATZCONJECTURE
;; Performs the Collatz Conjecture algorithm:
;;		Even Numbers: Divide by 2
;;		Odd Numbers: Multiply by 3 and add 1
;;      Count the number of iterations it takes to reach 1
;;
;; Examples:
;;		value = 6
;;					(1) 6   /   2	=  3
;;					(2) 3 * 3 + 1   =  10
;;					(3) 10  /	2	=  5
;;					(4) 5 * 3 + 1   =  16
;;					(5) 16  /	2	=  8
;;					(6) 8   /	2	=  4
;;					(7) 4   /	2	=  2
;;					(8) 2   /	2	=  1
;;											num_of_iterations = 8
;;		value = 64
;;					(1) 64  /   2	=  32
;;					(2) 32  /	2	=  16
;;					(3) 16  /	2	=  8
;;					(4) 8   /	2	=  4
;;					(5) 4   /	2	=  2
;;					(6) 2   /	2	=  1
;;											num_of_iterations = 6

;; COLLATZCONJECTURE Suggested Pseudocode (see PDF for explanation)
;;
;; value = mem[VALUE];
;; num_of_iterations = 0;
;; while (value > 1) {
;;   if (value % 2 != 0) {
;;      value = shiftleft(value, 1);
;;      value += value
;;      value += 1;
;;   } else {
;;      value = shiftright(value, 1);
;;   }
;;	 num_of_iterations += 1;
;; }
;;
;; mem[RESULT] = num_of_iterations;

;; Your code here!!

LD R0, VALUE ; Value
AND R1, R1, 0
ADD R1, R1, 1 ; Reserving R1 for shift paramters
AND R2, R2, 0 ; Iterations
BR START


WHILEM AND R3, R0, 1   ;Odd or Even
ADD R3, R3, 0
BRnp LEFT
BR RIGHT
MODEND

ADD R2, R2, 1
START ADD R3, R0, -1 
BRp WHILEM
BR ENDM

LEFT AND R3, R3, 0
ADD R3, R0, 0
JSR SHIFTLEFT
ADD R0, R0, R3
ADD R0, R0, 1
BR MODEND

RIGHT JSR SHIFTRIGHT
BR MODEND

ENDM ST R2, RESULT

	HALT

VALUE       .fill 15
RESULT      .blkw 1
.end
