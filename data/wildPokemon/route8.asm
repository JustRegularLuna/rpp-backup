Route8Mons:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0F
	db 28,ABRA
	db 28,KADABRA
	db 27,PIDGEOTTO
	db 26,MANKEY
	db 30,PERSIAN
	db 30,PERSIAN
	db 27,GROWLITHE
	db 27,VULPIX
	db 27,HOUNDOUR
	db 28,LICKITUNG

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0F
	db 18,ABRA
	db 18,KADABRA
	db 17,PIDGEOTTO
	db 16,MANKEY
	db 20,MEOWTH
	db 20,MEOWTH
	db 17,GROWLITHE
	db 17,VULPIX
	db 17,HOUNDOUR
	db 18,LICKITUNG

; Water Mons
	db $00
ENDC
