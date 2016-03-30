FuchsiaHouse1Object: ; 0x75031 (size=38)
	db $a ; border block

	db $2 ; warps
	db $7, $2, $1, $ff
	db $7, $3, $1, $ff

	db $0 ; signs

	db $3 ; people
	db SPRITE_HIKER, $3 + 4, $2 + 4, $ff, $d3, $1 ; person
	db SPRITE_ERIKA, $3 + 4, $5 + 4, $ff, $d2, $2 ; person
	db SPRITE_LITTLE_GIRL, $2 + 4, $7 + 4, $ff, $d1, $3 ; person

	; warp-to
	EVENT_DISP FUCHSIA_HOUSE_1_WIDTH, $7, $2
	EVENT_DISP FUCHSIA_HOUSE_1_WIDTH, $7, $3
