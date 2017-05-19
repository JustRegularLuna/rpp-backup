Route8Object: ; 0x5814f (size=119)
	db $2c ; border block

	db $5 ; warps
	db $9, $1, $0, ROUTE_8_GATE
	db $a, $1, $1, ROUTE_8_GATE
	db $9, $8, $2, ROUTE_8_GATE
	db $a, $8, $3, ROUTE_8_GATE
	db $3, $d, $0, PATH_ENTRANCE_ROUTE_8

	db $1 ; signs
	db $3, $11, $b ; Route8Text10

	db $A ; objects
	object SPRITE_BLACK_HAIR_BOY_2, $8, $5, NONE, RIGHT, $1, SUPER_NERD + $C8, $3
	object SPRITE_GAMBLER, $d, $9, NONE, UP, $2, GAMBLER + $C8, $5
	object SPRITE_BLACK_HAIR_BOY_2, $2a, $6, NONE, UP, $3, SUPER_NERD + $C8, $4
	object SPRITE_LASS, $1a, $3, NONE, LEFT, $4, LASS + $C8, $d
	object SPRITE_BLACK_HAIR_BOY_2, $1a, $4, NONE, RIGHT, $5, SUPER_NERD + $C8, $5
	object SPRITE_LASS, $1a, $5, NONE, LEFT, $6, LASS + $C8, $e
	object SPRITE_LASS, $1a, $6, NONE, RIGHT, $7, LASS + $C8, $f
	object SPRITE_GAMBLER, $2e, $d, NONE, DOWN, $8, GAMBLER + $C8, $7
	object SPRITE_LASS, $33, $c, NONE, LEFT, $9, LASS + $C8, $10
	object SPRITE_BERRY_TREE, $35, $6, NONE, NONE, $a

	; warp-to
	EVENT_DISP ROUTE_8_WIDTH, $9, $1 ; ROUTE_8_GATE
	EVENT_DISP ROUTE_8_WIDTH, $a, $1 ; ROUTE_8_GATE
	EVENT_DISP ROUTE_8_WIDTH, $9, $8 ; ROUTE_8_GATE
	EVENT_DISP ROUTE_8_WIDTH, $a, $8 ; ROUTE_8_GATE
	EVENT_DISP ROUTE_8_WIDTH, $3, $d ; PATH_ENTRANCE_ROUTE_8
