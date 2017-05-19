Route19Object: ; 0x54e9a (size=87)
	db $43 ; border block

	db $4 ; warps
	db $1, $7, $2, ROUTE_19_GATE
	db $1, $8, $3, ROUTE_19_GATE
	db $5, $7, $0, ROUTE_19_GATE
	db $d, $3, $0, BEACH_HOUSE


	db $1 ; signs
	db $d, $b, $b ; Route19Text11


	db $a ; objects
	object SPRITE_BLACK_HAIR_BOY_1, $8, $e, NONE, LEFT, 1, SWIMMER + $C8, 2
	object SPRITE_BLACK_HAIR_BOY_1, $d, $e, NONE, LEFT, 2, SWIMMER + $C8, 3
	object SPRITE_SWIMMER, $d, $19, NONE, LEFT, $3, SWIMMER + $C8, $4
	object SPRITE_SWIMMER, $4, $1b, NONE, RIGHT, $4, SWIMMER + $C8, $5
	object SPRITE_SWIMMER, $10, $1f, NONE, UP, $5, SWIMMER + $C8, $6
	object SPRITE_SWIMMER, $9, $12, NONE, DOWN, $6, SWIMMER + $C8, $7
	object SPRITE_SWIMMER_F, $8, $2b, NONE, LEFT, $7, SWIMMER_F + $C8, $c
	object SPRITE_SWIMMER_F, $b, $2b, NONE, RIGHT, $8, SWIMMER_F + $C8, $d
	object SPRITE_SWIMMER, $9, $2a, NONE, UP, $9, SWIMMER + $C8, $8
	object SPRITE_SWIMMER_F, $a, $2c, NONE, DOWN, $a, SWIMMER_F + $C8, $e

	; warp-to
	EVENT_DISP ROUTE_19_WIDTH, $1, $7 ; ROUTE_19_GATE
	EVENT_DISP ROUTE_19_WIDTH, $1, $8 ; ROUTE_19_GATE
	EVENT_DISP ROUTE_19_WIDTH, $5, $7 ; ROUTE_19_GATE
	EVENT_DISP ROUTE_19_WIDTH, $d, $3 ; BEACH_HOUSE
