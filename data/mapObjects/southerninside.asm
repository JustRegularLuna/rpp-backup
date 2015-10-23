SouthernIslandInsideObject:
	db $d ; border block

	db $2 ; warps
	db $15, $c, $1, SOUTHERN_ISLAND_OUTSIDE
	db $15, $d, $2, SOUTHERN_ISLAND_OUTSIDE

	db $0 ; signs

	db $2 ; people
	db SPRITE_BIRD, $b + 4, $c + 4, $ff, $d0, TRAINER | $1, LATIOS, 60 | OW_POKEMON
	db SPRITE_BIRD, $b + 4, $e + 4, $ff, $d0, TRAINER | $2, LATIAS, 60 | OW_POKEMON

	; warp-to
	EVENT_DISP SOUTHERN_ISLAND_INSIDE_WIDTH, $15, $c ; SOUTHERN_ISLAND_OUTSIDE
	EVENT_DISP SOUTHERN_ISLAND_INSIDE_WIDTH, $15, $d ; SOUTHERN_ISLAND_OUTSIDE