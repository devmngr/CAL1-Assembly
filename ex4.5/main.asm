;
; ex4.5.asm
;
; Created: 13.03.2017 14:01:21
; Author : bogdan
;
/*
LDI R16, 0xFF ;Initialize PORTB as output port
OUT DDRB, R16


TURNOFF:
LDI R16, 0xff
OUT PORTB, R16

TURNON1:
LDI R16, 0x6D
OUT PORTB, R16

TURNON2:
LDI R17, 0xB6
OUT PORTB, R16

TURNON3:
LDI R18, 0xDB
OUT PORTB, R16
*/
/*
DELAY:
		ldi r20,150
			loop1:
				ldi r21,150
			loop2:
				ldi r22,150
			loop3:
				dec r22
				brne loop3
				dec r21
				brne loop2
				dec r20
				brne loop1

*/
/*

LDI R16, 0xFF ;Initialize PORTB as output port
OUT DDRB, R16

	LDI		R23,100
	LOOP:	
			//ON-S1	
			LDI R16, 0x6D
			//LDI R16, 0b01101101
			OUT PORTB, R16
			
			///////DELAY
		ldi r20,150
			loop1:
				ldi r21,150
			loop2:
				ldi r22,150
			loop3:
				dec r22
				brne loop3
				dec r21
				brne loop2
				dec r20
				brne loop1
			//OFF
			LDI R16, 0xff
			OUT PORTB, R16

			//ON-S2
			LDI R16, 0xB6
			OUT PORTB, R16


			///////DELAY
		ldi r20,150
			loop11:
				ldi r21,150
			loop22:
				ldi r22,150
			loop33:
				dec r22
				brne loop33
				dec r21
				brne loop22
				dec r20
				brne loop11
			
			//OFF
			LDI R16, 0xff
			OUT PORTB, R16
			
			//ON-S3
			LDI R16, 0xDB
			OUT PORTB, R16

			///////DELAY
		ldi r20,150
			loop111:
				ldi r21,150
			loop222:
				ldi r22,150
			loop333:
				dec r22
				brne loop333
				dec r21
				brne loop222
				dec r20
				brne loop111

			//OFF
			LDI R16, 0xff
			OUT PORTB, R16

			DEC R23		
		BRNE LOOP
		*/

		LDI R16, 0xFF ;Initialize PORTB as output port
		OUT DDRB, R16
			
			LDI R16, 0b01101101
			LDI R17, 0xff
			LDI		R23,100

	
	LOOP:	
			OUT PORTB, R16
			ror r16

			
		///////DELAY
		ldi r20,150
			loop1:
				ldi r21,150
			loop2:
				ldi r22,150
			loop3:
				dec r22
				brne loop3
				dec r21
				brne loop2
				dec r20
				brne loop1

		//OFF
			OUT PORTB, R17
	DEC R23		
		BRNE LOOP