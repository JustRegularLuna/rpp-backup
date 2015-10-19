SouthernIslandInside_h:
	db FERRY ; tileset
	db SOUTHERN_ISLAND_INSIDE_HEIGHT, SOUTHERN_ISLAND_INSIDE_WIDTH ; dimensions (y, x)
	dw SouthernIslandInsideBlocks, SouthernIslandInsideTextPointers, SouthernIslandInsideScript ; blocks, texts, scripts
	db $00 ; connections
	dw SouthernIslandInsideObject ; objects