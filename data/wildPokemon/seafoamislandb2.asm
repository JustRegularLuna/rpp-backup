IslandMonsB2:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0A
	db 40,SEEL
	db 40,SLOWBRO
	db 42,SEEL
	db 42,SLOWBRO
	db 48,SEADRA
	db 40,STARYU
	db 40,SEADRA
	db 48,SHELLDER
	db 40,JYNX
	db 43,SLOWKING

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 30,SEEL
	db 30,SLOWPOKE
	db 32,SEEL
	db 32,SLOWPOKE
	db 28,HORSEA
	db 30,STARYU
	db 30,HORSEA
	db 28,SHELLDER
	db 30,JYNX
	db 37,SLOWKING

; Water Mons
	db $00
ENDC
