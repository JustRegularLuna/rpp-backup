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
	object SPRITE_BLACK_HAIR_BOY_2, $c, $8, STAY, RIGHT, $1, OPP_SUPER_NERD, $2
	object SPRITE_ROCKET_F, $b, $10, STAY, DOWN, $2, OPP_ROCKET_F, $1
	object SPRITE_JAMES, $f, $16, STAY, DOWN, $3, OPP_ROCKET, $2
	object SPRITE_JESSIE, $1d, $b, STAY, UP, $4, OPP_ROCKET_F, $3
	object SPRITE_ROCKET, $1d, $11, STAY, LEFT, $5, OPP_ROCKET, $4
	object SPRITE_FOSSIL, $c, $6, STAY, NONE, $6, DOME_FOSSIL
	object SPRITE_FOSSIL, $d, $6, STAY, NONE, $7, HELIX_FOSSIL
	object SPRITE_BALL, $19, $15, STAY, NONE, $8, HP_UP
	object SPRITE_BALL, $1d, $5, STAY, NONE, $9, TM_34

	; warp-to
	EVENT_DISP MT_MOON_3_WIDTH, $9, $19 ; MT_MOON_2
	EVENT_DISP MT_MOON_3_WIDTH, $11, $15 ; MT_MOON_2
	EVENT_DISP MT_MOON_3_WIDTH, $1b, $f ; MT_MOON_2
	EVENT_DISP MT_MOON_3_WIDTH, $7, $5 ; MT_MOON_2
	EVENT_DISP MT_MOON_3_WIDTH, $16, $1B ; MT_MOON_SQUARE
