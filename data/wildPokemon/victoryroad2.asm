PlateauMons2:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0A
	db 60,SANDSLASH
	db 62,RHYHORN
	db 61,GOLEM
	db 60,ONIX
	db 61,ONIX
	db 64,RHYDON
	db 61,MACHAMP
	db 60,CROBAT
	db 63,STEELIX
	db 63,MAROWAK

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 40,SANDSLASH
	db 42,RHYHORN
	db 41,GRAVELER
	db 40,ONIX
	db 41,ONIX
	db 42,ONIX
	db 41,MACHOKE
	db 40,CROBAT
	db 40,STEELIX
	db 43,MAROWAK

; Water Mons
	db $00
ENDC
