BeachHouse_h:
	db HOUSE ; tileset
	db BEACH_HOUSE_HEIGHT, BEACH_HOUSE_WIDTH ; dimensions (y, x)
	dw BeachHouseBlocks, BeachHouseTextPointers, BeachHouseScript ; blocks, texts, scripts
	db $00 ; connections
	dw BeachHouseObject ; objects
