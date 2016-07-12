PlateauMons2:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0A
	db 50,SANDSLASH
	db 52,RHYHORN
	db 51,GOLEM
	db 50,ONIX
	db 51,ONIX
	db 54,RHYDON
	db 51,MACHAMP
	db 50,CROBAT
	db 53,STEELIX
	db 53,MAROWAK

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
