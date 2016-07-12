PlateauMons3:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0F
	db 50,SANDSLASH
	db 52,RHYHORN
	db 51,GRAVELER
	db 59,ONIX
	db 56,GRAVELER
	db 51,GRAVELER
	db 52,GOLBAT
	db 55,MACHOKE
	db 57,STEELIX
	db 59,MAROWAK

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0F
	db 40,SANDSLASH
	db 42,RHYHORN
	db 41,GRAVELER
	db 49,ONIX
	db 46,GRAVELER
	db 41,GRAVELER
	db 42,GOLBAT
	db 45,MACHOKE
	db 47,STEELIX
	db 49,MAROWAK

; Water Mons
	db $00
ENDC
