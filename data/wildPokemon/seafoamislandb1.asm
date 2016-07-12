IslandMonsB1:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0A
	db 40,STARYU
	db 40,SEADRA
	db 42,SHELLDER
	db 42,SEADRA
	db 48,SLOWBRO
	db 40,SEEL
	db 40,SLOWBRO
	db 48,SEEL
	db 43,DEWGONG
	db 40,JYNX

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 30,STARYU
	db 30,HORSEA
	db 32,SHELLDER
	db 32,HORSEA
	db 28,SLOWPOKE
	db 30,SEEL
	db 30,SLOWPOKE
	db 28,SEEL
	db 38,DEWGONG
	db 37,JYNX

; Water Mons
	db $00
ENDC
