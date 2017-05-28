FarawayIslandOutside_h:
	db FERRY ; tileset
	db FARAWAY_ISLAND_OUTSIDE_HEIGHT, FARAWAY_ISLAND_OUTSIDE_WIDTH ; dimensions (y, x)
	dw FarawayIslandOutsideBlocks, FarawayIslandOutsideTextPointers, FarawayIslandOutsideScript ; blocks, texts, scripts
	db $00 ; connections
	dw FarawayIslandOutsideObject ; objects