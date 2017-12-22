Route15Mons:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0F
	db 45,GLOOM
	db 45,WEEPINBELL
	db 48,GLOOM
	db 48,WEEPINBELL
	db 48,VENONAT
	db 48,DITTO
	db 50,MILTANK
	db 50,MILTANK
	db 47,VENOMOTH
	db 50,VENOMOTH

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0F
	db 25,ODDISH
	db 25,BELLSPROUT
	db 28,GLOOM
	db 28,WEEPINBELL
	db 28,VENONAT
	db 28,DITTO
	db 30,MILTANK
	db 30,MILTANK
	db 27,VENOMOTH
	db 30,VENOMOTH

; Water Mons
	db $00
ENDC
