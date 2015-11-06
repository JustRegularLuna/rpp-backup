InsideFerry_h:
	db SHIP ; tileset
	db INSIDE_FERRY_HEIGHT, INSIDE_FERRY_WIDTH ; dimensions (y, x)
	dw InsideFerryBlocks, InsideFerryTextPointers, InsideFerryScript ; blocks, texts, scripts
	db $00 ; connections
	dw InsideFerryObject ; objects
