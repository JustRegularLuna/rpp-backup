VermilionFerryObject:
	db $0 ; border block

	db $2 ; warps
	db $0, $5, $9, VERMILION_CITY
	db $0, $6, $a, VERMILION_CITY

	db $0 ; signs

	db $1 ; people
	db SPRITE_SS_CAPTAIN, $5 + 4, $5 + 4, $ff, $d1, $1 ; person

	; warp-to
	EVENT_DISP VERMILION_FERRY_DOCK_WIDTH, $0, $5 ; VERMILION_CITY
	EVENT_DISP VERMILION_FERRY_DOCK_WIDTH, $0, $6 ; VERMILION_CITY
	