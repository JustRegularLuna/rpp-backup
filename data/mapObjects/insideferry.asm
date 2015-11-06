InsideFerryObject:
	db $c ; border block

	db $2 ; warps
	db $1, $5, $2, VERMILION_FERRY_DOCK
	db $1, $6, $2, VERMILION_FERRY_DOCK ; unused

	db $0 ; signs

	db $1 ; people
	db SPRITE_SS_CAPTAIN, $3 + 4, $3 + 4, $ff, $d1, $1 ; person

	; warp-to
	EVENT_DISP INSIDE_FERRY_WIDTH, $1, $5 ; VERMILION_FERRY_DOCK
	EVENT_DISP INSIDE_FERRY_WIDTH, $1, $6 ; unused
