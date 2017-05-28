NavelRockOutside_h:
	db OVERWORLD ; tileset
	db NAVEL_ROCK_OUTSIDE_HEIGHT, NAVEL_ROCK_OUTSIDE_WIDTH ; dimensions (y, x)
	dw NavelRockOutsideBlocks, NavelRockOutsideTextPointers, NavelRockOutsideScript ; blocks, texts, scripts
	db $00 ; connections
	dw NavelRockOutsideObject ; objects