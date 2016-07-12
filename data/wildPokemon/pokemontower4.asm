TowerMons4:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0A
	db 30,GASTLY
	db 31,GASTLY
	db 32,GASTLY
	db 33,GASTLY
	db 29,MISDREAVUS
	db 28,MISDREAVUS
	db 35,CUBONE
	db 30,CUBONE
	db 32,HAUNTER
	db 34,HAUNTER

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 20,GASTLY
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 19,MISDREAVUS
	db 18,MISDREAVUS
	db 25,CUBONE
	db 20,CUBONE
	db 22,HAUNTER
	db 24,HAUNTER

; Water Mons
	db $00
ENDC
