;
; test.asm
;
; Created: 28.04.2017 16:09:13
; Author : bogda
;


 ; Set up the display output
 LDI	R16, 0xFF						; Load 0xFF into R16orary register
 OUT	DDRA, R16						; Set Port B (LEDs) to output

 ; Set up our answer array
 .equ	MEMSTARTHIGH	= 0x05
 .equ   MEMSTARTLOW		= 0x00
 LDI	R27, MEMSTARTHIGH
 LDI	R26, MEMSTARTLOW

 ; Set up the stack
 LDI	R16, low(RAMEND)
 OUT	SPL, R16
 LDI	R16, high(RAMEND)
 OUT	SPH, R16

 ; =======TARGET NUMBER HERE=======
 .equ	TARGET_NUMBER	= 0x0D			; Anything higher than 0x0D (13) will overflow
 ; ================================

 ; Set up Fib math registers
 .def	FIB_TARGET		= R18			; The Fibonacci number we're looking for
 .def	CURRENT_N		= R19			; The current N (this is our loop counter)
 .def	RESULT			= R20			; The resulting value for the current N

 LDI	FIB_TARGET, TARGET_NUMBER		; Load our target number into the counter
 INC	FIB_TARGET						; Add one to the target (this is clunky, but we need to account for breaking out of our loop as soon as the current matches target)
 LDI	CURRENT_N, 1					; Start with 1 (we have no case for 0, so the program never stops!)

 MAIN:
	CP		CURRENT_N, FIB_TARGET		; See if our current N is the same as the target
	BREQ	DISPLAY						; If they are equal, break out to the display loop
	PUSH	CURRENT_N					; Push the current N onto the stack, to use as an argument in the subroutine
	CALL	FIB							; Call the subroutine
	POP		RESULT						; After the subroutine returns, get the result value off the stack
	ST		X+, RESULT					; Store the result value into our results array
	INC		CURRENT_N					; Increment N, so we can search for the next value
	RJMP	MAIN						; Repeat the loop

FIB:
	; Calling convention setup:

	; Store the working registers
	PUSH	CURRENT_N					; Save the current N register
	PUSH	RESULT						; Save the current result register
	PUSH	R28							; Save the current stack pointer (low) register
	PUSH	R29							; Save the current stack pointer (high) register

	; Set up the stack pointer so we can get our argument
	IN		R28, SPL					; Load the stack pointer (low) into Y register
	IN		R29, SPH					; Load the stack pointer (high) into Y register
	; Set the stack pointer to point to our argument
	ADIW	R28, 9						; Add 9 to stack pointer, to account for our pushes (6 bytes) and for the return pointer (3 bytes) going onto the stack
	LD		CURRENT_N, -Y				; Get the current N value using our pointer in the Y register

	; Handle one/two cases
	CPI		CURRENT_N, 1				; Is the current N value 1?
	BREQ	FIB_1_2						; Go to the loop for handling the 1 and 2 cases
	CPI		CURRENT_N, 2				; Is the current N value 2?
	BREQ	FIB_1_2						; Go to the loop for handling the 1 and 2 cases

	RJMP	FIB_OTHER					; Go to the loop for handling all other cases

	FIB_1_2:							; Loop for handling 1 and 2 cases
		LDI		R16, 0x01
		ST		Y, R16					; Store the value 1 as our answer (N == 1)
		; Restore registers from the stack (in reverse order)
		POP		R29						; Restore the stack pointer (Y high)
		POP		R28						; Restore the stack pointer (Y low)
		POP		RESULT					; Restore the result register
		POP		CURRENT_N				; Restore the N register
		RET								; Return to caller

	FIB_OTHER:							; Loop for handling all cases other than 1 or 2

		; Fib algorithm: N = N-1 + N-2

		; Get the value for N-1
		DEC		CURRENT_N				; Decrement N, to get N-1
		PUSH	CURRENT_N				; Push N so that it is an argument for the FIB subroutine call
		CALL	FIB						; Recursive call back into the FIB subroutine
		POP		RESULT					; Get the result back from the algorithm

		; Get the value for N-2
		DEC		CURRENT_N				; Decrement N, to get N-2
		PUSH	CURRENT_N				; Push N so that it is an argument for the FIB subroutine call
		CALL	FIB						; Recursive call back into FIB algorithm
		POP		CURRENT_N				; Get the result back from the algorithm (We'll store this in the N register)

		ADD		RESULT, CURRENT_N		; Add N-1 and N-2 to get our new N value
		ST		Y, RESULT				; Store our result in the Y stack pointer, which is still conveniently pointing at the argument, so we'll just use it :) 
										; Restore registers from the stack (in reverse order)
		POP		R29						; Restore the stack pointer (Y high)
		POP		R28						; Restore the stack pointer (Y low)
		POP		RESULT					; Restore the result register
		POP		CURRENT_N				; Restore the N register
		RET								; Return to caller

	DISPLAY:							; Display the fib numbers using the LEDs
		LDI R26, 0x00					; Reset the X array pointer to the start of the array
			RUN:							; Loop for sending values to LEDs
			LD R16, X+						; Increment array index
			COM R16						; Turns R16 value to be displayed
			RJMP BLINK						; Run blink loop
			RJMP RUN						; Jump back to start of loop
		LDI R17, 0xFF					; Load LED off value to the R16 port

	BLINK: 
		OUT PORTA, R16					; Send the Fib result value to the LEDs
		CALL DELAY						; Delay
		OUT PORTA, R17					; Turn the LEDs off
		CALL DELAY						; Delay
		RJMP RUN						; Repeat

	
	 DELAY:
				LDI R22, 0XA0
		LOOP3:	LDI R23, 0XA0
		LOOP2:	LDI R24, 0XA0
		LOOP1:	DEC R24 
				BRNE LOOP1 
				DEC R23 
				BRNE LOOP2 
				DEC R22
				BRNE LOOP3 
				RET 	
