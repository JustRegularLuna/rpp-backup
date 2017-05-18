Route20Object: ; 0x50113 (size=106)
	db $43 ; border block

	db $2 ; warps
	db $5, $30, $0, SEAFOAM_ISLANDS_1
	db $9, $3a, $2, SEAFOAM_ISLANDS_1

	db $2 ; signs
	db $7, $33, $b ; Route20Text11
	db $b, $39, $c ; Route20Text12

	db $a ; objects
	object SPRITE_SWIMMER, $57, $8, FACE, UP, $1, SWIMMER + $C8, $9
	object SPRITE_SWIMMER_F, $44, $b, FACE, UP, $2, SWIMMER_F + $C8, $f
	object SPRITE_SWIMMER_F, $2d, $a, FACE, DOWN, $3, SWIMMER_F + $C8, $6
	object SPRITE_SWIMMER_F, $37, $e, FACE, LEFT, $4, SWIMMER_F + $C8, $12
	object SPRITE_SWIMMER, $26, $d, FACE, DOWN, $5, SWIMMER + $C8, $a
	object SPRITE_SWIMMER, $57, $d, FACE, UP, $6, SWIMMER + $C8, $b
	object SPRITE_BLACK_HAIR_BOY_1, $22, $9, FACE, UP, $7, BIRD_KEEPER + $C8, $b
	object SPRITE_SWIMMER_F, $19, $7, FACE, UP, $8, SWIMMER_F + $C8, $7
	object SPRITE_SWIMMER_F, $18, $c, FACE, DOWN, $9, SWIMMER_F + $C8, $11
	object SPRITE_SWIMMER_F, $f, $8, FACE, UP, $a, SWIMMER_F + $C8, $8

	; warp-to
	EVENT_DISP ROUTE_20_WIDTH, $5, $30 ; SEAFOAM_ISLANDS_1
	EVENT_DISP ROUTE_20_WIDTH, $9, $3a ; SEAFOAM_ISLANDS_1
