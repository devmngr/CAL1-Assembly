;
; Calculator.asm
;
; Created: 13.03.2017 12:48:05
; Author : bogdan
;

START:
	LDI R19,0  ;	NUMBER CHECKER
	LDI R25,0  ;	LEDS VALUE
	LDI R18,0  ;	SWITCHES VALUE
	LDI R17,0  ;    2. Number
	LDI R16,0  ;    1. Number
	LDI R30,0  ;	STATE
	LDI R31,255;    255
	OUT DDRA,R31
	CALL DELAY

AGAIN:
	COM R25
	OUT PORTA,R25
	IN R18,PINB
	CPI R18,0
	BRNE PRESSED
	JMP AGAIN

;PRESSED is used for selecting the first number and confirming it with number 7
;after entering the first number STATE is called and the value is saved
;after first value is saved, NEXT is called and the value for the second number needs to be entered
;after saving the second number THE OPERATION is called and switch 0 needs to be pressed to add the 2 values entered
;the result is shown on the leds 


;PRESSED is used for selecting the first number and confirming it with pin number 7
PRESSED:
	SBIS PINB,7
	BRNE STATE
	COM R18
	EOR R25,R18
	COM R25
	CALL DELAY
	JMP AGAIN

STATE:
	INC R30
	CPI R30,1
	BREQ NEXT
	CPI R30,2
	BREQ OPERATION

;goes to next value
NEXT:
	COM R25
	MOV R16,R25
	CLR R25
	OUT PORTA,R31
	CALL DELAY
	JMP AGAIN

;OPERATION is used for selecting the operation to perdorm (only addition is implemented) 
;Pin number 0 is used for addition
OPERATION:
	COM R25
	MOV R17,R25
	OUT PORTA,R31
	CALL DELAY
	OPERATORLOOP:
		CLR R1
		SBIS PINB,0
		JMP ADDITION
	JMP OPERATORLOOP

;ADDITION is the function used for adding two values
ADDITION:
	ADD R16,R17
	COM R16
	JMP RESULT


;RESULT is used for dysplaing the final result
RESULT:	
	OUT PORTA,R31
	CALL DELAY
	OUT PORTA,R16
	CALL DELAY
	SBIS PINB,0
	JMP start
	JMP RESULT

DELAY:
		LDI R20,15
LOOP3:	LDI R21,255
LOOP2:	LDI R22,255
LOOP1:	DEC R22
		BRNE LOOP1
		DEC R21
		BRNE LOOP2
		DEC R20
		BRNE LOOP3
		RET
