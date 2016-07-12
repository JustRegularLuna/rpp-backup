PlateauMons1:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0F
	db 50,SANDSLASH
	db 52,RHYHORN
	db 51,GRAVELER
	db 50,ONIX
	db 51,ONIX
	db 52,ONIX
	db 54,RHYDON
	db 54,CROBAT
	db 52,STEELIX
	db 53,MAROWAK

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0F
	db 40,SANDSLASH
	db 42,RHYHORN
	db 41,GRAVELER
	db 40,ONIX
	db 41,ONIX
	db 42,ONIX
	db 44,RHYDON
	db 44,CROBAT
	db 42,STEELIX
	db 43,MAROWAK

; Water Mons
	db $00
ENDC
