TowerMons6:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0F
	db 31,GASTLY
	db 32,GASTLY
	db 33,GASTLY
	db 34,GASTLY
	db 30,MISDREAVUS
	db 29,MISDREAVUS
	db 34,CUBONE
	db 32,CUBONE
	db 36,HAUNTER
	db 38,HAUNTER

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
	db 19,MISDREAVUS
	db 24,CUBONE
	db 22,CUBONE
	db 26,HAUNTER
	db 28,HAUNTER

; Water Mons
	db $00
ENDC
