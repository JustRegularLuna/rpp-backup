Route18Mons:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $19
	db 45,SPEAROW
	db 47,FEAROW
	db 45,DODUO
	db 44,DODUO
	db 46,RATICATE
	db 46,SLUGMA
	db 48,SLUGMA
	db 49,LICKITUNG
	db 47,MURKROW
	db 49,MURKROW

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $19
	db 25,SPEAROW
	db 27,FEAROW
	db 25,DODUO
	db 24,DODUO
	db 26,RATICATE
	db 26,SLUGMA
	db 28,SLUGMA
	db 29,LICKITUNG
	db 27,MURKROW
	db 29,MURKROW

; Water Mons
	db $00
ENDC
