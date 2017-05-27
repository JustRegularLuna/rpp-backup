SafariZoneEast_h:
	db SAFARI ; tileset
	db SAFARI_ZONE_EAST_HEIGHT, SAFARI_ZONE_EAST_WIDTH ; dimensions (y, x)
	dw SafariZoneEastBlocks, SafariZoneEastTextPointers, SafariZoneEastScript ; blocks, texts, scripts
	db $00 ; connections
	dw SafariZoneEastObject ; objects
