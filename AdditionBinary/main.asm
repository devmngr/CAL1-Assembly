;
; AdditionBinary.asm
;
; Created: 20.03.2017 13:25:30
; Author : bogda
;


; Replace with your application code
start:
  
LDI R16, 0xFF ;Initialize PORTB as output port
		OUT DDRB, R16

LDI R16, 0x00
	out DDRA, R16






    rjmp start
