TowerMons7:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0F
	db 31,GASTLY
	db 32,GASTLY
	db 33,GASTLY
	db 34,GASTLY
	db 30,MISDREAVUS
	db 38,MISMAGIUS
	db 32,CUBONE
	db 34,CUBONE
	db 38,HAUNTER
	db 40,HAUNTER

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0F
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 24,GASTLY
	db 20,MISDREAVUS
	db 28,MISMAGIUS
	db 22,CUBONE
	db 24,CUBONE
	db 28,HAUNTER
	db 30,HAUNTER

; Water Mons
	db $00
ENDC
