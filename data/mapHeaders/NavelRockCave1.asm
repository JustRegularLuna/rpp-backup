NavelRockCave1_h:
	db CAVERN ; tileset
	db NAVEL_ROCK_CAVE_1_HEIGHT, NAVEL_ROCK_CAVE_1_WIDTH ; dimensions (y, x)
	dw NavelRockCave1Blocks, NavelRockCave1TextPointers, NavelRockCave1Script ; blocks, texts, scripts
	db $00 ; connections
	dw NavelRockCave1Object ; objects
