BeachHouseObject: ; 0x1df07 (size=32)
	db $a ; border block

	db $2 ; warps
	db $7, $2, $3, $ff
	db $7, $3, $3, $ff

	db $0 ; signs

	db $4 ; objects
	object SPRITE_FISHER, $2, $4, NONE, RIGHT, $1 ; person
	object SPRITE_SURF_PIKACHU, $2, $3, NONE, RIGHT, $2 ; person
	object SPRITE_BRUNETTE_GIRL, $9, $5, NONE, UP, $3 ; person
	object SPRITE_LYING_OLD_MAN, $a, $7, NONE, NONE, $4 ; person

	; warp-to
	EVENT_DISP BEACH_HOUSE_WIDTH, $7, $2
	EVENT_DISP BEACH_HOUSE_WIDTH, $7, $3
