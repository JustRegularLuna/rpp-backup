TunnelMonsB1:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0F
	db 24,GOLBAT
	db 25,GOLBAT
	db 27,GRAVELER
	db 25,MACHOP
	db 26,GRAVELER
	db 28,DITTO
	db 25,TORKOAL
	db 27,MACHOP
	db 23,ONIX
	db 25,ONIX

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0F
	db 16,ZUBAT
	db 17,ZUBAT
	db 17,GEODUDE
	db 15,MACHOP
	db 16,GEODUDE
	db 18,DITTO
	db 15,TORKOAL
	db 17,MACHOP
	db 13,ONIX
	db 15,ONIX

; Water Mons
	db $00
ENDC
