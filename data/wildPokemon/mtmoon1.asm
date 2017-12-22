MoonMons1:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0A
	db 10,GEODUDE
	db 9,ZUBAT
	db 11,ZUBAT
	db 10,GEODUDE
	db 8,SANDSHREW
	db 12,SANDSHREW
	db 12,GEODUDE
	db 10,PARAS
	db 13,PARAS
	db 10,CLEFAIRY

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 8,GEODUDE
	db 7,ZUBAT
	db 9,ZUBAT
	db 8,GEODUDE
	db 6,SANDSHREW
	db 10,SANDSHREW
	db 10,GEODUDE
	db 8,PARAS
	db 11,PARAS
	db 8,CLEFAIRY

; Water Mons
	db $00
ENDC
