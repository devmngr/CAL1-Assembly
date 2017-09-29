;
; FIB.asm
;
; Created: 28.04.2017 13:24:08
; Author : bogda
;


; Replace with your application code
start:

	Ldi R20,12
	Mov R16, R20

	LDI R17,0
	Ldi R18,1
	Fib:	CPI R16, 0
			Breq Done
			
			Mov R19,R17
			Add R19,R18
			
			Mov R17,R18
			Mov R18,R19

			Dec R16
			rjmp fib

	Done:	rjmp Done