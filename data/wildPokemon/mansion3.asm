MansionMons3:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0A
	db 47,KOFFING
	db 48,GROWLITHE
	db 45,VULPIX
	db 49,HOUNDOUR
	db 49,NINETALES
	db 46,WEEZING
	db 44,GRIMER
	db 48,WEEZING
	db 46,ARCANINE
	db 50,MUK

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 31,KOFFING
	db 33,GROWLITHE
	db 35,VULPIX
	db 32,HOUNDOUR
	db 34,NINETALES
	db 40,WEEZING
	db 34,GRIMER
	db 38,WEEZING
	db 36,ARCANINE
	db 42,MUK

; Water Mons
	db $00
ENDC
