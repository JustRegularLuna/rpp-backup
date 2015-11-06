VermilionFerryObject:
	db $0 ; border block

	db $3 ; warps
	db $0, $5, $9, VERMILION_CITY
	db $0, $6, $a, VERMILION_CITY
	db $5, $6, $0, INSIDE_FERRY

	db $0 ; signs

	db $1 ; people
	db SPRITE_SAILOR, $5 + 4, $5 + 4, $ff, $d1, $1 ; person

	; warp-to
	EVENT_DISP VERMILION_FERRY_DOCK_WIDTH, $0, $5 ; VERMILION_CITY
	EVENT_DISP VERMILION_FERRY_DOCK_WIDTH, $0, $6 ; VERMILION_CITY
	EVENT_DISP VERMILION_FERRY_DOCK_WIDTH, $5, $6 ; INSIDE_FERRY
	