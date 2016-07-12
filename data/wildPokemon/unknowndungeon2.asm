DungeonMons2:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0F
	db 62,CROBAT
	db 67,CROBAT
	db 60,GRAVELER
	db 66,SANDSLASH
	db 60,RHYHORN
	db 60,DITTO
	db 68,ONIX
	db 68,LICKITUNG
	db 68,RHYPERIOR
	db 66,LICKILICKY

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0F
	db 52,CROBAT
	db 57,CROBAT
	db 50,GRAVELER
	db 56,SANDSLASH
	db 50,RHYHORN
	db 60,DITTO
	db 58,ONIX
	db 58,LICKITUNG
	db 58,RHYPERIOR
	db 60,LICKILICKY

; Water Mons
	db $00
ENDC
