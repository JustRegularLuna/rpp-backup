NavelRockCave2_h:
	db CAVERN ; tileset
	db NAVEL_ROCK_CAVE_2_HEIGHT, NAVEL_ROCK_CAVE_2_WIDTH ; dimensions (y, x)
	dw NavelRockCave2Blocks, NavelRockCave2TextPointers, NavelRockCave2Script ; blocks, texts, scripts
	db $00 ; connections
	dw NavelRockCave2Object ; objects
