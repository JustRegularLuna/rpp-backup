DayCareMObject: ; 0x56459 (size=26)
	db $a ; border block

	db $2 ; warps
	db $7, $2, $4, $ff
	db $7, $3, $4, $ff

	db $0 ; signs

	db $3 ; objects
	object SPRITE_OLD_MEDIUM_WOMAN, $2, $3, NONE, RIGHT, $1 ; person
    object SPRITE_OLD_PERSON, $5, $3, NONE, LEFT, $2 ; person
    object SPRITE_GREETER, $6, $1, NONE, DOWN, $3 ; person

	; warp-to
	EVENT_DISP DAYCAREM_WIDTH, $7, $2
	EVENT_DISP DAYCAREM_WIDTH, $7, $3
