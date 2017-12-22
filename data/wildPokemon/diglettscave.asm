CaveMons:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $14
	db 20,DIGLETT
	db 22,DIGLETT
	db 25,DIGLETT
	db 20,DIGLETT
	db 23,DIGLETT
	db 25,DIGLETT
	db 21,DIGLETT
	db 22,DIGLETT
	db 29,DUGTRIO
	db 31,DUGTRIO
	
; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $14
	db 18,DIGLETT
	db 19,DIGLETT
	db 17,DIGLETT
	db 20,DIGLETT
	db 16,DIGLETT
	db 15,DIGLETT
	db 21,DIGLETT
	db 22,DIGLETT
	db 29,DUGTRIO
	db 31,DUGTRIO
	
; Water Mons
	db $00
ENDC
