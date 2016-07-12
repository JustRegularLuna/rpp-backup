Route17Mons:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $19
	db 46,DODUO
	db 47,FEAROW
	db 47,DODUO
	db 48,GRIMER
	db 48,PONYTA
	db 50,RAPIDASH
	db 49,SLUGMA
	db 48,SLUGMA
	db 42,MUK
	db 42,DODRIO

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $19
	db 26,DODUO
	db 27,FEAROW
	db 27,DODUO
	db 28,GRIMER
	db 28,PONYTA
	db 30,PONYTA
	db 29,SLUGMA
	db 28,SLUGMA
	db 32,MUK
	db 32,DODRIO

; Water Mons
	db $00
ENDC
