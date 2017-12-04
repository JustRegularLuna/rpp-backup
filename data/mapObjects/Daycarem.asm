DayCareMObject:
	db $a ; border block

	db $2 ; warps
	db $7, $2, $4, $ff
	db $7, $3, $4, $ff

	db $0 ; signs

	db $3 ; objects
	object SPRITE_OLD_MEDIUM_WOMAN, $2, $3, STAY, RIGHT, $1 ; person
    object SPRITE_OLD_PERSON, $5, $3, STAY, LEFT, $2 ; person
    object SPRITE_GREETER, $6, $1, STAY, DOWN, $3 ; person

	; warp-to
	EVENT_DISP DAYCAREM_WIDTH, $7, $2
	EVENT_DISP DAYCAREM_WIDTH, $7, $3
