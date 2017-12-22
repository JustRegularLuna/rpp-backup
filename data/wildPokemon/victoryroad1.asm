PlateauMons1:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0F
	db 60,SANDSLASH
	db 62,RHYHORN
	db 61,GRAVELER
	db 60,ONIX
	db 61,ONIX
	db 62,ONIX
	db 64,RHYDON
	db 64,CROBAT
	db 62,STEELIX
	db 63,MAROWAK

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
