NavelRockCave1Object:
	db $19 ; border block

	db $3 ; warps
	db $7, $2, $0, NAVEL_ROCK_OUTSIDE
	db $7, $3, $0, NAVEL_ROCK_OUTSIDE
	db $4, $4, $0, NAVEL_ROCK_CAVE_2

	db $0 ; signs

	db $0 ; people

	; warp-to
	EVENT_DISP NAVEL_ROCK_CAVE_1_WIDTH, $7, $2 ; NAVEL_ROCK_OUTSIDE
	EVENT_DISP NAVEL_ROCK_CAVE_1_WIDTH, $7, $3 ; NAVEL_ROCK_OUTSIDE
	EVENT_DISP NAVEL_ROCK_CAVE_1_WIDTH, $4, $4 ; NAVEL_ROCK_CAVE_2
