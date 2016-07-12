Route2Mons:
IF DEF(_BLUE) ; Difficult rom
; Grass Mons
	db $19
	db 4,RATTATA
	db 4,PIDGEY
	db 5,PIDGEY
	db 5,RATTATA
	db 6,NIDORAN_M
	db 6,NIDORAN_F
	db 4,WEEDLE
	db 4,CATERPIE
	db 6,WEEDLE
	db 6,CATERPIE

; Water Mons
	db $00

ELSE ; Normal rom
; Grass Mons
	db $19
	db 3,RATTATA
	db 3,PIDGEY
	db 4,PIDGEY
	db 4,RATTATA
	db 5,NIDORAN_M
	db 5,NIDORAN_F
	db 3,WEEDLE
	db 3,CATERPIE
	db 5,WEEDLE
	db 5,CATERPIE

; Water Mons
	db $00
ENDC
