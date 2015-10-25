NavelRockFerryDock_h:
	db FERRY ; tileset
	db NAVEL_ROCK_FERRY_DOCK_HEIGHT, NAVEL_ROCK_FERRY_DOCK_WIDTH ; dimensions (y, x)
	dw NavelRockFerryBlocks, NavelRockFerryTextPointers, NavelRockFerryScript ; blocks, texts, scripts
	db $00 ; connections
	dw NavelRockFerryObject ; objects
