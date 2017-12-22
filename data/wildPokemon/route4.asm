Route4Mons:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $14
	db 14,SPEAROW
	db 14,SPEAROW
	db 12,RATTATA
	db 10,EKANS
	db 12,EKANS
	db 14,MANKEY
	db 16,SANDSHREW
	db 16,SANDSHREW
	db 16,MURKROW
	db 16,JIGGLYPUFF

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $14
	db 10,SPEAROW
	db 10,SPEAROW
	db 8,RATTATA
	db 6,EKANS
	db 8,EKANS
	db 10,MANKEY
	db 12,SANDSHREW
	db 12,SANDSHREW
	db 12,MURKROW
	db 12,JIGGLYPUFF

; Water Mons
	db $00
ENDC
