FuchsiaGymObject: ; 0x75658 (size=82)
	db $3 ; border block

	db $2 ; warps
	db $11, $4, $5, $ff
	db $11, $5, $5, $ff

	db $0 ; signs

	db $8 ; objects
	object SPRITE_KOGA, $4, $a, NONE, DOWN, $1, KOGA + $C8, $1
	object SPRITE_ROCKER, $8, $d, NONE, DOWN, $2, JUGGLER + $C8, $7
	object SPRITE_ROCKER, $7, $8, NONE, RIGHT, $3, JUGGLER + $C8, $3
	object SPRITE_ROCKER, $1, $c, NONE, DOWN, $4, JUGGLER + $C8, $8
	object SPRITE_ROCKER, $3, $5, NONE, UP, $5, TAMER + $C8, $1
	object SPRITE_ROCKER, $8, $2, NONE, DOWN, $6, TAMER + $C8, $2
	object SPRITE_ROCKER, $2, $7, NONE, LEFT, $7, JUGGLER + $C8, $4
	object SPRITE_GYM_HELPER, $7, $f, NONE, DOWN, $8 ; person

	; warp-to
	EVENT_DISP FUCHSIA_GYM_WIDTH, $11, $4
	EVENT_DISP FUCHSIA_GYM_WIDTH, $11, $5
