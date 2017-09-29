;
; ex4.1.asm
;
; Created: 08.03.2017 10:47:46
; Author : bogdan
;

start:
  /*  
LDI R16,100
LDI R20, 0
LDI R21, 3
AGAIN:
ADD R20, R21
DEC R16
BRNE AGAIN
OUT PORTB, R20
END:
JMP END
    rjmp start
	*/
LDi r16,7
LDI r17,8
LDI r18,0
LDI r19,0

Loop:
	CP R19, R17
	breq end
	add r18,r16
	inc r19
	rjmp Loop

end: 
	rjmp end
	