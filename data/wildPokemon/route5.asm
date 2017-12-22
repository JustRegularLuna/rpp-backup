Route5Mons:
IF DEF(_HARD) ; Difficult Rom
; Grass Mons
	db $0F
	db 17,PIDGEY
	db 18,ODDISH
	db 18,BELLSPROUT
	db 20,PIDGEOTTO
	db 15,MEOWTH
	db 17,MEOWTH
	db 20,MANKEY
	db 20,ABRA
	db 20,BUTTERFREE
	db 20,BEEDRILL

; Water Mons
	db $00

ELSE ; Normal Rom
; Grass Mons
	db $0F
	db 12,PIDGEY
	db 13,ODDISH
	db 13,BELLSPROUT
	db 15,PIDGEOTTO
	db 10,MEOWTH
	db 12,MEOWTH
	db 15,MANKEY
	db 15,ABRA
	db 15,BUTTERFREE
	db 15,BEEDRILL

; Water Mons
	db $00
ENDC
