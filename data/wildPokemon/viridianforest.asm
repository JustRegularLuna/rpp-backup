ForestMons:
IF DEF(_BLUE) ; Diffuclt Rom
; Grass Mons
	db $19
	db 6,WEEDLE
	db 6,CATERPIE
	db 5,WEEDLE
	db 6,CATERPIE
	db 8,KAKUNA
	db 8,METAPOD
	db 8,KAKUNA
	db 8,METAPOD
	db 6,PIKACHU
	db 8,PIKACHU

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $19
	db 4,WEEDLE
	db 4,CATERPIE
	db 3,WEEDLE
	db 3,CATERPIE
	db 6,KAKUNA
	db 6,METAPOD
	db 5,KAKUNA
	db 5,METAPOD
	db 3,PIKACHU
	db 5,PIKACHU

; Water Mons
	db $00
ENDC
