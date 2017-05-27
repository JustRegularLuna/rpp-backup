SafariZoneNorth_h:
	db SAFARI ; tileset
	db SAFARI_ZONE_NORTH_HEIGHT, SAFARI_ZONE_NORTH_WIDTH ; dimensions (y, x)
	dw SafariZoneNorthBlocks, SafariZoneNorthTextPointers, SafariZoneNorthScript ; blocks, texts, scripts
	db $00 ; connections
	dw SafariZoneNorthObject ; objects
