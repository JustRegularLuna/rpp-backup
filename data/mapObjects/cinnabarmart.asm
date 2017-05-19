CinnabarMartObject: ; 0x75e91 (size=38)
	db $0 ; border block

	db $2 ; warps
	db $7, $3, $4, $ff
	db $7, $4, $4, $ff

	db $0 ; signs

	db $3 ; objects
	object SPRITE_MART_GUY, $0, $5, NONE, RIGHT, $1 ; person
	object SPRITE_LASS, $6, $2, NONE, NONE, $2 ; person
	object SPRITE_OAK_AIDE, $3, $4, NONE, NONE, $3 ; person

	; warp-to
	EVENT_DISP CINNABAR_MART_WIDTH, $7, $3
	EVENT_DISP CINNABAR_MART_WIDTH, $7, $4
