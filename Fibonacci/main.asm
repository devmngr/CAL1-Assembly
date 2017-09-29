;
; Fibonacci.asm
;
; Created: 28.04.2017 12:14:13
; Author :	Bogdan Mitarche - Student Nr. 245488    
;			Marian Pogor - Student Nr. 239783
;

;Set up the answer array
 .equ MEMSTARTHIGH = 0x05
 .equ MEMSTARTLOW = 0x00
 .def N = R20				;register to hold the Fibonacci number we are starting with
 .def fib_nr = R21			;register to hold the fibonaci value

 ;Initializing the array pointers to the start of the array where we will store the Fibonaccis-numbers
 LDI R27, MEMSTARTHIGH
 LDI R26, MEMSTARTLOW

 ;Memory tests
	LDI R17, 0x55			; load 0x55 into R17
	ST	 X+, R17			; store in X the value inside R17 and increment the poiner 
	LDI R17, 0xAA			; load 0xAA into R17
	ST  X, R17				; store in X the value inside R17
	LD	 R17, X				; load into R17 the value of what X is pointing at
	LD   R18,-X				; decrement pointer in X and load the value which is pointing at into R18
	ADD R18, R17			; add to R18 the value in R17
	CPI  R18, 0xFF			; compare if the value in R18 is 0xFF
	BRNE ERROR				; if the value in R 18 is not equal to 0xFF than RAM is faulty


	; Set up the LEDs
ldi r16,0xff			; Load 0xFF
out ddrA,r16			; Set Port A to output (used for the Leds)

;N holds the Fibonacci number we are starting with. If N = 1, ; we are starting to display the fibonacci numbers starting from fibonaci 1;
LDI N, 1
NEXT:	CPI N, 14			; Check if n is the same as 14 (we use 14, so we cand display the first 13 fibonaccy numbers which can be represented with 8-bit)
 		BREQ Display		; If they are equal, go to the display loop
		PUSH N			; Setup call, pushing the argument:
		CALL FIB			; CALL the subroutine:							
		POP fib_nr				; Retrieve the result (return value)
		ST X+, fib_nr			; Store the results
		INC N				; Increment N
		JMP NEXT			; Repeat the loop

FIB: 	
	PUSH	N				; Save the N register
	PUSH	fib_nr				; Save the result register
	PUSH	R28				; Save the current stack pointer (low) register
	PUSH	R29				; Save the current stack pointer (high) register

; Set up the stack pointer so we can get our argument
	IN		R28, SPL		; Load the stack pointer (low) into Y register
	IN		R29, SPH		; Load the stack pointer (high) into Y register


; Set the stack pointer to point to our argument
	ADIW	R28, 9			; Add 9 to stack pointer, to account for our pushes (6 bytes) and for the return pointer (3 bytes) going onto the stack
	LD		N, -Y			; Get the N value using our pointer in the Y register

; Handling the cases for fibonaci 1 and 2
	CPI		N, 1			; Is N=1 ?
	BREQ	Fib_1And2			; Go to the loop used for this case
	CPI		N, 2			; Is N=2?
	BREQ	Fib_1And2			; Go to the loop used for this case
	RJMP	FIB_Other		; Go to the loop used for all other cases

; Loop used for fibonaci 1 and 2
	Fib_1And2:				
		LDI		R16, 0x01
		ST		Y, R16		; Store the value 1 as our answer (N == 1)

; Restore registers from the stack (in reverse order)
		POP		R29			; Restore the stack pointer (Y high)
		POP		R28			; Restore the stack pointer (Y low)
		POP		fib_nr			; Restore the result register
		POP		N			; Restore the N register
		RET					; Return to caller

; Loop used for all other cases
	FIB_Other:				

; Fibonaci algorithm: N = N-1 + N-2
; Get the value for N-1
		DEC		N			; Decrement N, to get N-1
		PUSH	N			; Push N
		CALL	FIB			; Recursive call
		POP		fib_nr			; Get the result

; Get the value for N-2
		DEC		N			; Decrement N, to get N-2
		PUSH	N			; Push N
		CALL	FIB			; Recursive call
		POP		N			; Get the result
		ADD		fib_nr, N	; Add N-1 and N-2 to get the new N value
		ST		Y, fib_nr		; Store the result in the Y stack pointer

; Restore registers from the stack (in reverse order)
		POP		R29			; Restore the stack pointer (Y high)
		POP		R28			; Restore the stack pointer (Y low)
		POP		fib_nr			; Restore the result register
		POP		N			; Restore the N register
		RET	

; Display the fib numbers using the LEDs
	DISPLAY:						
		LDI R26, 0x00		; Reset the X array pointer to the start of the array
		RUN:				; Loop for sending values to LEDs
		LD R16, X+			; Increment array index
		COM R16				; Turns R16 value to be displayed
		RJMP BLINK			; Run blink loop
		RJMP RUN			; Jump back to start of loop

	BLINK: 
		OUT PortA, r16		; Send the Fib number to to the LEDs
		CALL DELAY			; Delay
		OUT PortA, R17		; Turn the LEDs off
		CALL DELAY			; Delay
		RJMP RUN			; Repeat


ERROR:
	LDI r17, 0xFF
	OUT PortA, R17		; Turn the LEDs off
	
DELAY:
	LDI N,70
	LOOP3:	LDI fib_nr,255
	LOOP2:	LDI R22,255
	LOOP1:	DEC R22
		BRNE LOOP1
		DEC fib_nr
		BRNE LOOP2
		DEC N
		BRNE LOOP3
		RET
