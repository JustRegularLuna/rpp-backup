MoonMonsB1:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0A
	db 11,ZUBAT
	db 10,SANDSHREW
	db 10,GEODUDE
	db 11,GEODUDE
	db 12,GEODUDE
	db 13,PARAS
	db 13,PARAS
	db 14,ONIX
	db 12,CLEFAIRY
	db 12,CLEFAIRY

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 8,ZUBAT
	db 7,SANDSHREW
	db 7,GEODUDE
	db 8,GEODUDE
	db 9,GEODUDE
	db 10,PARAS
	db 10,PARAS
	db 11,ONIX
	db 9,CLEFAIRY
	db 9,CLEFAIRY

; Water Mons
	db $00
ENDC
