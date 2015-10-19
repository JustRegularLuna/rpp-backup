SouthernIslandOutsideObject:
	db $10 ; border block

	db $3 ; warps
	db $27, $e, $2, VERMILION_FERRY_DOCK
	db $7, $16, $0, SOUTHERN_ISLAND_INSIDE
	db $7, $17, $1, SOUTHERN_ISLAND_INSIDE

	db $1 ; signs
	db $20, $3, $3 ; SouthernIslandSignText

	db $2 ; people
	db SPRITE_SS_CAPTAIN, $27 + 4, $d + 4, $ff, $d1, $1 ; SouthernIslandCaptainText
	db SPRITE_BERRY_TREE, $e + 4, $14 + 4, $ff, $ff, $2 ; SouthernIslandBerryTreeText

	; warp-to
	EVENT_DISP SOUTHERN_ISLAND_OUTSIDE_WIDTH, $27, $e ; VERMILION_FERRY_DOCK
	EVENT_DISP SOUTHERN_ISLAND_OUTSIDE_WIDTH, $7, $16 ; SOUTHERN_ISLAND_INSIDE
	EVENT_DISP SOUTHERN_ISLAND_OUTSIDE_WIDTH, $7, $17 ; SOUTHERN_ISLAND_INSIDE