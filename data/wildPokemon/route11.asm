Route11Mons:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0F
	db 19,MEOWTH
	db 20,SANDSHREW
	db 19,SPEAROW
	db 15,EKANS
	db 20,EKANS
	db 20,SANDSHREW
	db 22,NIDORINO
	db 22,NIDORINA
	db 16,DROWZEE
	db 20,DROWZEE

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0F
	db 14,MEOWTH
	db 15,SANDSHREW
	db 14,SPEAROW
	db 10,EKANS
	db 15,EKANS
	db 15,SANDSHREW
	db 17,NIDORINO
	db 17,NIDORINA
	db 11,DROWZEE
	db 15,DROWZEE

; Water Mons
	db $00
ENDC
