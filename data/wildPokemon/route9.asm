Route9Mons:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $0F
	db 21,EKANS
	db 21,SANDSHREW
	db 19,NIDORAN_M
	db 19,NIDORAN_F
	db 20,SPEAROW
	db 22,FEAROW
	db 19,CUBONE
	db 18,VENONAT
	db 23,MAROWAK
	db 22,VENOMOTH

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0F
	db 16,EKANS
	db 16,SANDSHREW
	db 14,NIDORAN_M
	db 14,NIDORAN_F
	db 15,SPEAROW
	db 17,FEAROW
	db 14,CUBONE
	db 13,VENONAT
	db 18,MAROWAK
	db 17,VENOMOTH

; Water Mons
	db $00
ENDC
