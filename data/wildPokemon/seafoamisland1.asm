IslandMons1:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0F
	db 40,SEEL
	db 40,GOLDUCK
	db 40,STARYU
	db 40,KINGLER
	db 48,KRABBY
	db 41,GOLBAT
	db 49,GOLBAT
	db 48,SLOWBRO
	db 48,STARYU
	db 42,SLOWKING

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0F
	db 30,SEEL
	db 30,PSYDUCK
	db 30,STARYU
	db 30,KRABBY
	db 28,KRABBY
	db 21,ZUBAT
	db 29,GOLBAT
	db 28,SLOWPOKE
	db 28,STARYU
	db 38,SLOWBRO

; Water Mons
	db $00
ENDC
