IslandMonsB3:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0A
	db 41,SEADRA
	db 41,SEEL
	db 43,SEADRA
	db 43,SEEL
	db 49,KRABBY
	db 41,STARYU
	db 41,KINGLER
	db 49,STARYU
	db 49,SLOWKING
	db 43,DEWGONG

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 31,HORSEA
	db 31,SEEL
	db 33,HORSEA
	db 33,SEEL
	db 29,KRABBY
	db 31,STARYU
	db 31,KRABBY
	db 29,STARYU
	db 39,SLOWKING
	db 37,DEWGONG

; Water Mons
	db $00
ENDC
