FarawayIslandInside_h:
	db FERRY ; tileset
	db FARAWAY_ISLAND_INSIDE_HEIGHT, FARAWAY_ISLAND_INSIDE_WIDTH ; dimensions (y, x)
	dw FarawayIslandInsideBlocks, FarawayIslandInsideTextPointers, FarawayIslandInsideScript ; blocks, texts, scripts
	db $00 ; connections
	dw FarawayIslandInsideObject ; objects
