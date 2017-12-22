TunnelMonsB2:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0F
	db 25,GOLBAT
	db 27,GRAVELER
	db 28,MACHOP
	db 29,GOLBAT
	db 30,GOLBAT
	db 31,GRAVELER
	db 30,MACHOP
	db 24,TORKOAL
	db 28,ONIX
	db 32,ONIX

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0F
	db 20,ZUBAT
	db 17,GEODUDE
	db 18,MACHOP
	db 21,ZUBAT
	db 22,ZUBAT
	db 21,GEODUDE
	db 20,MACHOP
	db 14,TORKOAL
	db 18,ONIX
	db 22,ONIX

; Water Mons
	db $00
ENDC
