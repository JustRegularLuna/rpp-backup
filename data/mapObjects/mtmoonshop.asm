MtMoonShopObject: ; 0x49b06 (size=145)
	db $0A ; border block

	db $2 ; warps
	db $7, $2, $1, MT_MOON_SQUARE
	db $7, $3, $1, MT_MOON_SQUARE

	db $0 ; signs

	db $3 ; people
	db SPRITE_OLD_PERSON, $3 + 4, $0 + 4, $ff, $d3, $1 ; person
	db SPRITE_BUG_CATCHER, $3 + 4, $4 + 4, $ff, $d3, $2 ; person
	db SPRITE_LASS, $4 + 4, $7 + 4, $ff, $d2, $3 ; person

	; warp-to
	EVENT_DISP MT_MOON_SHOP_WIDTH, $7, $2
	EVENT_DISP MT_MOON_SHOP_WIDTH, $7, $3

