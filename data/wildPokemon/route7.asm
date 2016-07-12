Route7Mons:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0F
	db 29,MANKEY
	db 29,ABRA
	db 28,MEOWTH
	db 30,MEOWTH
	db 28,VULPIX
	db 28,GROWLITHE
	db 30,VULPIX
	db 30,GROWLITHE
	db 29,HOUNDOUR
	db 30,MURKROW

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0F
	db 19,MANKEY
	db 19,ABRA
	db 18,MEOWTH
	db 20,MEOWTH
	db 18,VULPIX
	db 18,GROWLITHE
	db 20,VULPIX
	db 20,GROWLITHE
	db 19,HOUNDOUR
	db 20,MURKROW

; Water Mons
	db $00
ENDC
