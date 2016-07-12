TowerMons5:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0A
	db 32,GASTLY
	db 33,GASTLY
	db 34,GASTLY
	db 35,GASTLY
	db 36,MISDREAVUS
	db 31,MISDREAVUS
	db 30,CUBONE
	db 37,CUBONE
	db 32,HAUNTER
	db 37,HAUNTER

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 22,GASTLY
	db 23,GASTLY
	db 24,GASTLY
	db 25,GASTLY
	db 26,MISDREAVUS
	db 21,MISDREAVUS
	db 20,CUBONE
	db 27,CUBONE
	db 22,HAUNTER
	db 27,HAUNTER

; Water Mons
	db $00
ENDC
