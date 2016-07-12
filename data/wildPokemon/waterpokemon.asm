WaterMons:
IF DEF(_BLUE) ; Difficult Rom
; Grass Mons
	db $00

; Water Mons
	db $05
	db 40,TENTACOOL
	db 40,GOLDEEN
	db 45,KRABBY
	db 45,TENTACOOL
	db 40,STARYU
	db 45,STARYU
	db 50,STARMIE
	db 55,KINGLER
	db 55,TENTACOOL
	db 60,TENTACRUEL

ELSE ; Normal Rom
; Grass Mons
	db $00

; Water Mons
	db $05
	db 20,TENTACOOL
	db 20,GOLDEEN
	db 25,KRABBY
	db 25,TENTACOOL
	db 20,STARYU
	db 25,STARYU
	db 30,STARMIE
	db 35,KINGLER
	db 35,TENTACOOL
	db 40,TENTACRUEL
ENDC
