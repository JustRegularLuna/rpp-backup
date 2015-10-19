SouthernIslandOutside_h:
	db FERRY ; tileset
	db SOUTHERN_ISLAND_OUTSIDE_HEIGHT, SOUTHERN_ISLAND_OUTSIDE_WIDTH ; dimensions (y, x)
	dw SouthernIslandOutsideBlocks, SouthernIslandOutsideTextPointers, SouthernIslandOutsideScript ; blocks, texts, scripts
	db $00 ; connections
	dw SouthernIslandOutsideObject ; objects