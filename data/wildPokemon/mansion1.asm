MansionMons1:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0A
	db 47,KOFFING
	db 47,VULPIX
	db 44,GRIMER
	db 45,PONYTA
	db 47,GROWLITHE
	db 48,PONYTA
	db 45,GRIMER
	db 48,PONYTA
	db 49,WEEZING
	db 50,MUK

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 32,KOFFING
	db 30,VULPIX
	db 34,GRIMER
	db 30,PONYTA
	db 34,GROWLITHE
	db 32,PONYTA
	db 30,GRIMER
	db 28,PONYTA
	db 37,WEEZING
	db 39,MUK

; Water Mons
	db $00
ENDC
