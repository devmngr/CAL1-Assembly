;
; Ex1.asm
;
; Created: 27.02.2017 12:52:31
; Author : bogdan
;
start:

;ldi r16 , 0x66
;ldi r17, 3
;asr r16

;asr r16
;rjmp start

.DEF  ANS = R0            ;To hold answer     
.DEF  REM = R2            ;To hold remainder
.DEF    A = R16           ;To hold dividend
.DEF    B = R18           ;To hold divisor   
.DEF    C = R20           ;Bit Counter

        LDI A,0x66         ;Load dividend into A
        LDI B,0x3           ;Load divisor into B

        LDI C,9           ;Load bit counter
        SUB REM,REM       ;Clear Remainder and Carry
        MOV ANS,A         ;Copy Dividend to Answer
LOOP:   ROL ANS           ;Shift the answer to the left
        DEC C             ;Decrement Counter
         BREQ DONE        ;Exit if eight bits done
        ROL REM           ;Shift the remainder to the left
        SUB REM,B         ;Try to Subtract divisor from remainder
         BRCC SKIP        ;If the result was negative then
        ADD REM,B         ;reverse the subtraction to try again
        CLC               ;Clear Carry Flag so zero shifted into A 
         RJMP LOOP        ;Loop Back
SKIP:   SEC               ;Set Carry Flag to be shifted into A
         RJMP LOOP
DONE:

	


   
