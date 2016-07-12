TowerMons3:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0A
	db 30,GASTLY
	db 31,GASTLY
	db 32,GASTLY
	db 33,GASTLY
	db 30,MISDREAVUS
	db 29,MISDREAVUS
	db 28,CUBONE
	db 35,CUBONE
	db 30,HAUNTER
	db 35,HAUNTER

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 20,GASTLY
	db 21,GASTLY
	db 22,GASTLY
	db 23,GASTLY
	db 20,MISDREAVUS
	db 19,MISDREAVUS
	db 18,CUBONE
	db 25,CUBONE
	db 20,HAUNTER
	db 25,HAUNTER

; Water Mons
	db $00
ENDC
