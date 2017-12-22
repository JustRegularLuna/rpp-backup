MansionMons2:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0A
	db 47,GROWLITHE
	db 47,VULPIX
	db 48,KOFFING
	db 46,PONYTA
	db 47,KOFFING
	db 50,NINETALES
	db 47,GRIMER
	db 48,MUK
	db 49,WEEZING
	db 50,MAGMAR

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 32,GROWLITHE
	db 34,VULPIX
	db 34,KOFFING
	db 30,PONYTA
	db 30,KOFFING
	db 32,NINETALES
	db 30,GRIMER
	db 28,MUK
	db 39,WEEZING
	db 37,MAGMAR

; Water Mons
	db $00
ENDC
