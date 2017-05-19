MtMoon3Object: ; 0x49fdb (size=102)
	db $3 ; border block

	db $5 ; warps
	db $9, $19, $1, MT_MOON_2
	db $11, $15, $4, MT_MOON_2
	db $1b, $f, $5, MT_MOON_2
	db $7, $5, $6, MT_MOON_2
	db $16, $1B, $0, MT_MOON_SQUARE

	db $0 ; signs

	db $9 ; objects
	object SPRITE_BLACK_HAIR_BOY_2, $c, $8, NONE, RIGHT, $1, SUPER_NERD + $C8, $2
	object SPRITE_ROCKET_F, $b, $10, NONE, DOWN, $2, ROCKET_F + $C8, $1
	object SPRITE_JAMES, $f, $16, NONE, DOWN, $3, ROCKET + $C8, $2
	object SPRITE_JESSIE, $1d, $b, NONE, UP, $4, ROCKET_F + $C8, $3
	object SPRITE_ROCKET, $1d, $11, NONE, LEFT, $5, ROCKET + $C8, $4
	object SPRITE_FOSSIL, $c, $6, NONE, NONE, $6, DOME_FOSSIL
	object SPRITE_FOSSIL, $d, $6, NONE, NONE, $7, HELIX_FOSSIL
	object SPRITE_BALL, $19, $15, NONE, NONE, $8, HP_UP
	object SPRITE_BALL, $1d, $5, NONE, NONE, $9, TM_34

	; warp-to
	EVENT_DISP MT_MOON_3_WIDTH, $9, $19 ; MT_MOON_2
	EVENT_DISP MT_MOON_3_WIDTH, $11, $15 ; MT_MOON_2
	EVENT_DISP MT_MOON_3_WIDTH, $1b, $f ; MT_MOON_2
	EVENT_DISP MT_MOON_3_WIDTH, $7, $5 ; MT_MOON_2
	EVENT_DISP MT_MOON_3_WIDTH, $16, $1B ; MT_MOON_SQUARE
