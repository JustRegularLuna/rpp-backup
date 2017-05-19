Route21Object: ; 0x55021 (size=76)
	db $43 ; border block

	db $0 ; warps

	db $0 ; signs

	db $9 ; objects
	object SPRITE_FISHER2, $4, $18, NONE, LEFT, $1, FISHER + $C8, $7
	object SPRITE_FISHER2, $6, $19, NONE, DOWN, $2, FISHER + $C8, $9
	object SPRITE_SWIMMER, $a, $1f, NONE, UP, $3, SWIMMER + $C8, $c
	object SPRITE_SWIMMER, $c, $1e, NONE, RIGHT, $4, SWIMMER + $C8, $10
	object SPRITE_SWIMMER, $10, $3f, NONE, DOWN, $5, SWIMMER + $C8, $d
	object SPRITE_SWIMMER, $5, $47, NONE, RIGHT, $6, SWIMMER + $C8, $e
	object SPRITE_SWIMMER, $f, $47, NONE, LEFT, $7, SWIMMER + $C8, $f
	object SPRITE_FISHER2, $e, $38, NONE, LEFT, $8, FISHER + $C8, $8
	object SPRITE_FISHER2, $11, $39, NONE, RIGHT, $9, FISHER + $C8, $a
