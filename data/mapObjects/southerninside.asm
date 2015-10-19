SouthernIslandInsideObject:
	db $d ; border block

	db $2 ; warps
	db $13, $c, $1, SOUTHERN_ISLAND_OUTSIDE
	db $13, $d, $2, SOUTHERN_ISLAND_OUTSIDE

	db $0 ; signs

	db $2 ; people
	db SPRITE_BIRD, $c + 4, $c + 4, $ff, $d0, TRAINER | $1, LATIOS, 60
	db SPRITE_BIRD, $f + 4, $c + 4, $ff, $d0, TRAINER | $2, LATIAS, 60

	; warp-to
	EVENT_DISP SOUTHERN_ISLAND_INSIDE_WIDTH, $13, $c ; SOUTHERN_ISLAND_OUTSIDE
	EVENT_DISP SOUTHERN_ISLAND_INSIDE_WIDTH, $13, $d ; SOUTHERN_ISLAND_OUTSIDE