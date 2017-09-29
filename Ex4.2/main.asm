;
; Ex4.2.asm
;
; Created: 13.03.2017 13:18:26
; Author : bogdan
;
/*//Runs 20.000 times
Ldi			R20,200
	BACK: LDI	R21,100
	
	HERE:	dec R21
	Brne here
	dec R20
	brne back
	*/

	//Runs 1.000.000
	LDI		R20,100
	LDI		R21,100
	LDI		R22,100
	
	LOOP: DEC R22
	BRNE LOOP
	DEC R21
	BRNE LOOP
	DEC R20
	BRNE LOOP

