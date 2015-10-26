NavelRockOutsideObject:
	db $43 ; border block

	db $3 ; warps
	db $17, $e, $0, NAVEL_ROCK_CAVE_1
	db $5, $e, $0, NAVEL_ROCK_FERRY_DOCK
	db $5, $f, $1, NAVEL_ROCK_FERRY_DOCK

	db $0 ; signs

	db $1 ; people
	db SPRITE_SS_CAPTAIN, $17 + 4, $d + 4, $ff, $d1, $1 ; NavelRockCaptainText

	; warp-to
	EVENT_DISP NAVEL_ROCK_OUTSIDE_WIDTH, $17, $e ; NAVEL_ROCK_CAVE_1
	EVENT_DISP NAVEL_ROCK_OUTSIDE_WIDTH, $5, $e ; NAVEL_ROCK_FERRY_DOCK
	EVENT_DISP NAVEL_ROCK_OUTSIDE_WIDTH, $5, $f ; NAVEL_ROCK_FERRY_DOCK