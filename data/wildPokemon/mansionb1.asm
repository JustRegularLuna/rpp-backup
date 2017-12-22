MansionMonsB1:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0A
	db 47,KOFFING
	db 48,VULPIX
	db 48,GROWLITHE
	db 47,PONYTA
	db 46,KOFFING
	db 50,WEEZING
	db 47,PONYTA
	db 46,HOUNDOUR
	db 50,MAGMAR
	db 50,MAGMORTAR

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 33,KOFFING
	db 31,VULPIX
	db 35,GROWLITHE
	db 32,PONYTA
	db 31,KOFFING
	db 40,WEEZING
	db 34,PONYTA
	db 35,HOUNDOUR
	db 42,MAGMAR
	db 42,MAGMAR

; Water Mons
	db $00
ENDC
