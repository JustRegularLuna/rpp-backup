MtMoonSquareObject:
	db $2C ; border block

	db $2 ; warps
	db $b, $18, $4, MT_MOON_3
	db $7, $11, $0, MT_MOON_SHOP

	db $1 ; signs
	db $9, $13, $4

	db $3 ; people
	db SPRITE_BERRY_TREE, $6 + 4, $16 + 4, $ff, $ff, $1 ; person
	db SPRITE_BUG_CATCHER, $7 + 4, $7 + 4, $ff, $d3, $2 ; person
	db SPRITE_LASS, $b + 4, $11 + 4, $ff, $d0, $3 ; person

	; warp-to
	EVENT_DISP MT_MOON_SQUARE_WIDTH, $b, $18
	EVENT_DISP MT_MOON_SQUARE_WIDTH, $7, $11
