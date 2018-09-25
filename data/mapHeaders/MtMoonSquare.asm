MtMoonSquare_h:
	db OVERWORLD ; tileset
	db MT_MOON_SQUARE_HEIGHT, MT_MOON_SQUARE_WIDTH ; dimensions (y, x)
	dw MtMoonSquareBlocks, MtMoonSquareTextPointers, MtMoonSquareScript ; blocks, texts, scripts
	db $00 ; connections
	dw MtMoonSquareObject ; objects
