IslandMonsB4:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0A
	db 46,GOLBAT
	db 46,ZUBAT
	db 40,KRABBY
	db 42,KINGLER
	db 48,SEEL
	db 42,SEEL
	db 47,GOLBAT
	db 45,ZUBAT
	db 40,DEWGONG
	db 44,DEWGONG

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 36,GOLBAT
	db 36,ZUBAT
	db 30,KRABBY
	db 32,KINGLER
	db 28,SEEL
	db 32,SEEL
	db 27,GOLBAT
	db 45,ZUBAT
	db 30,DEWGONG
	db 34,DEWGONG

; Water Mons
	db $00
ENDC
