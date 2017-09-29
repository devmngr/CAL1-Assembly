;
; AssemblerApplication1.asm
;
; Created: 06.03.2017 14:28:58
; Author : bogda
;


; Replace with your application code

;;one
  ; LDI R20, -1
  ; LDI R20, 0x25
  ; LDI R21, 0x87
  ; Ldi R25, 0x79



;;two
;  LDi R16, 0x99
;  sts 0x212, R16
 ; Ldi r16, 0x85
 ; sts 0x213, r16
;ldi r16, 0x3f
;sts 0x214, r16
;ldi r16, 0x63
;ldi r16, 0x12
;sts 0x216, r16


;three

;;in r19, pind
  
  start: 
  LDI R20, 0x0A ; after
LDI R16, 0xFF ;Initialize PORTB as output port
OUT DDRB, R16


TURNOFF:
LDI R16, 0xff
OUT PORTB, R16

TURNON:
//LDI R18, 0xDB
//LDI R17, 0xB6
LDI R16, 0x6D
OUT PORTB, R16
Dec R20
brne TURNON
/*
OUT PORTB, R16
OUT PORTB, R17

*/


