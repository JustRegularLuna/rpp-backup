MoonMonsB2:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0A
	db 11,ZUBAT
	db 11,GEODUDE
	db 12,ZUBAT
	db 12,GEODUDE
	db 13,SANDSHREW
	db 12,PARAS
	db 14,PARAS
	db 12,ONIX
	db 14,CLEFAIRY
	db 14,CLEFAIRY

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0A
	db 9,ZUBAT
	db 9,GEODUDE
	db 10,ZUBAT
	db 10,GEODUDE
	db 11,SANDSHREW
	db 10,PARAS
	db 12,PARAS
	db 10,ONIX
	db 12,CLEFAIRY
	db 12,CLEFAIRY

; Water Mons
	db $00
ENDC
