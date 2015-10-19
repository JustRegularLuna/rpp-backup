SouthernIslandOutsideObject:
	db $10 ; border block

	db $3 ; warps
	db $17, $e, $2, VERMILION_FERRY_DOCK
	db $5, $e, $0, SOUTHERN_ISLAND_INSIDE
	db $5, $f, $1, SOUTHERN_ISLAND_INSIDE

	db $1 ; signs
	db $7, $10, $3 ; SouthernIslandSignText

	db $2 ; people
	db SPRITE_SS_CAPTAIN, $17 + 4, $d + 4, $ff, $d1, $1 ; SouthernIslandCaptainText
	db SPRITE_BERRY_TREE, $7 + 4, $b + 4, $ff, $ff, $2 ; SouthernIslandBerryTreeText

	; warp-to
	EVENT_DISP SOUTHERN_ISLAND_OUTSIDE_WIDTH, $17, $e ; VERMILION_FERRY_DOCK
	EVENT_DISP SOUTHERN_ISLAND_OUTSIDE_WIDTH, $5, $e ; SOUTHERN_ISLAND_INSIDE
	EVENT_DISP SOUTHERN_ISLAND_OUTSIDE_WIDTH, $5, $f ; SOUTHERN_ISLAND_INSIDE