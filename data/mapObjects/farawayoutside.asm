FarawayIslandOutsideObject:
	db $10 ; border block

	db $2 ; warps
	db $7, $16, $0, FARAWAY_ISLAND_INSIDE
	db $7, $17, $1, FARAWAY_ISLAND_INSIDE

	db $1 ; signs
	db $3, $4, $2 ; FarawayIslandSignText

	db $1 ; people
	db SPRITE_SS_CAPTAIN, $5 + 4, $5 + 4, $ff, $d1, $1 ; FarawayIslandCaptainText

	; warp-to
	EVENT_DISP FARAWAY_ISLAND_OUTSIDE_WIDTH, $7, $16 ; FARAWAY_ISLAND_INSIDE
	EVENT_DISP FARAWAY_ISLAND_OUTSIDE_WIDTH, $7, $17 ; FARAWAY_ISLAND_INSIDE