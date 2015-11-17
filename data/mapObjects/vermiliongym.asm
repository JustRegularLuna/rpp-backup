VermilionGymObject: ; 0x5cbfe (size=58)
	db $3 ; border block

	db $2 ; warps
	db $11, $4, $3, $ff
	db $11, $5, $3, $ff

	db $0 ; signs

	db $5 ; people
	db SPRITE_SURGE, $1 + 4, $5 + 4, $ff, $d0, TRAINER | $1, LT__SURGE + TRAINER_START, $1
	db SPRITE_GENTLEMAN, $6 + 4, $9 + 4, $ff, $d2, TRAINER | $2, GENTLEMAN + TRAINER_START, $3
	db SPRITE_BRUNETTE_GIRL, $8 + 4, $3 + 4, $ff, $d2, TRAINER | $3, ROCKER + TRAINER_START, $1
	db SPRITE_SAILOR, $a + 4, $0 + 4, $ff, $d3, TRAINER | $4, SAILOR + TRAINER_START, $8
	db SPRITE_GYM_HELPER, $e + 4, $4 + 4, $ff, $d0, $5 ; person

	; warp-to
	EVENT_DISP VERMILION_GYM_WIDTH, $11, $4
	EVENT_DISP VERMILION_GYM_WIDTH, $11, $5
