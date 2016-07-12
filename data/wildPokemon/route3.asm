Route3Mons:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $14
	db 8,SPEAROW
	db 9,NIDORAN_M
	db 9,NIDORAN_F
	db 8,RATTATA
	db 9,SANDSHREW
	db 10,EKANS
	db 10,PIDGEY
	db 10,MANKEY
	db 7,JIGGLYPUFF
	db 9,JIGGLYPUFF

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $14
	db 6,SPEAROW
	db 7,NIDORAN_M
	db 7,NIDORAN_F
	db 6,RATTATA
	db 7,SANDSHREW
	db 8,EKANS
	db 8,PIDGEY
	db 9,MANKEY
	db 5,JIGGLYPUFF
	db 7,JIGGLYPUFF

; Water Mons
	db $00
ENDC
