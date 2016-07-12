Route16Mons:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $19
	db 42,SPEAROW
	db 42,DODUO
	db 43,RATICATE
	db 44,DODUO
	db 44,GRIMER
	db 46,DODUO
	db 43,MURKROW
	db 44,MURKROW
	db 45,SLUGMA
	db 46,SLUGMA

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $19
	db 22,SPEAROW
	db 22,DODUO
	db 23,RATICATE
	db 24,DODUO
	db 24,GRIMER
	db 26,DODUO
	db 23,MURKROW
	db 24,MURKROW
	db 25,SLUGMA
	db 26,SLUGMA

; Water Mons
	db $00
ENDC
