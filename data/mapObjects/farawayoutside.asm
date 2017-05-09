FarawayIslandOutsideObject:
	db $10 ; border block

	db $3 ; warps
	db $27, $e, $0, INSIDE_FERRY
	db $7, $16, $0, FARAWAY_ISLAND_INSIDE
	db $7, $17, $1, FARAWAY_ISLAND_INSIDE

	db $1 ; signs
	db $20, $3, $3 ; FarawayIslandSignText

	db $2 ; people
	db SPRITE_SAILOR, $27 + 4, $d + 4, $ff, $d1, $1 ; FarawayIslandCaptainText
	db SPRITE_BERRY_TREE, $e + 4, $14 + 4, $ff, $ff, $2 ; FarawayIslandBerryTreeText

	; warp-to
	EVENT_DISP FARAWAY_ISLAND_OUTSIDE_WIDTH, $27, $e ; INSIDE_FERRY
	EVENT_DISP FARAWAY_ISLAND_OUTSIDE_WIDTH, $7, $16 ; FARAWAY_ISLAND_INSIDE
	EVENT_DISP FARAWAY_ISLAND_OUTSIDE_WIDTH, $7, $17 ; FARAWAY_ISLAND_INSIDE