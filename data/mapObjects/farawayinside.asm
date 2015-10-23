FarawayIslandInsideObject:
	db $d ; border block

	db $2 ; warps
	db $13, $c, $1, FARAWAY_ISLAND_OUTSIDE
	db $13, $d, $2, FARAWAY_ISLAND_OUTSIDE

	db $0 ; signs

	db $1 ; people
	db SPRITE_SLOWBRO, $c + 4, $c + 4, $ff, $d0, TRAINER | $1, MEW, 30 | OW_POKEMON

	; warp-to
	EVENT_DISP FARAWAY_ISLAND_INSIDE_WIDTH, $13, $c ; FARAWAY_ISLAND_OUTSIDE
	EVENT_DISP FARAWAY_ISLAND_INSIDE_WIDTH, $13, $d ; FARAWAY_ISLAND_OUTSIDE