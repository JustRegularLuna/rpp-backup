BeachHouseObject: ; 0x1df07 (size=32)
	db $a ; border block

	db $2 ; warps
	db $7, $2, $3, $ff
	db $7, $3, $3, $ff

	db $0 ; signs

	db $4 ; people
	db SPRITE_FISHER, $4 + 4, $2 + 4, $ff, $d3, $1 ; person
	db SPRITE_CLEFAIRY, $3 + 4, $2 + 4, $ff, $d3, $2 ; person
	db SPRITE_BRUNETTE_GIRL, $5 + 4, $9 + 4, $ff, $d1, $3 ; person
	db SPRITE_LYING_OLD_MAN, $7 + 4, $a + 4, $ff, $ff, $4 ; person

	; warp-to
	EVENT_DISP BEACH_HOUSE_WIDTH, $7, $2
	EVENT_DISP BEACH_HOUSE_WIDTH, $7, $3
