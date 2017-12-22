PlateauMons3:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0F
	db 60,SANDSLASH
	db 62,RHYHORN
	db 61,GRAVELER
	db 69,ONIX
	db 66,GRAVELER
	db 61,GRAVELER
	db 62,GOLBAT
	db 65,MACHOKE
	db 67,STEELIX
	db 69,MAROWAK

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
