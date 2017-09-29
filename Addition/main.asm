;
; Addition.asm
;
; Created: 30.03.2017 22:41:13
; Author : bogdan
;
start:
   LDI R16,7				//1 Cycle
   LDI R17,4				//1 Cycle
   MOV R18, R16				//1 Cycle
   add R18, R17				//1 Cycle
   jmp start				//3 Cycles


   //ATMEGA 2560 WORKS AT FREQUENCY OF 8MHz = 8000000 Hz
   //EXECUTION TIME = NUMBER OF CYCLES/FREQUENCY
   //Cycle counter : 7 Cycles
   //Total Delay : 0,000000875 seconds