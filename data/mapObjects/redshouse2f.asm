RedsHouse2FObject: ; 0x5c0d0 ?
	db $0A ; border block

	db $1 ; warps
	db $0, $7, $1, FARAWAY_ISLAND_OUTSIDE

	db $0 ; signs

	db $0 ; people

	; warp-to
	EVENT_DISP REDS_HOUSE_2F_WIDTH, $0, $7
