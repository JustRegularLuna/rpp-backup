SafariZoneCenter_h:
	db SAFARI ; tileset
	db SAFARI_ZONE_CENTER_HEIGHT, SAFARI_ZONE_CENTER_WIDTH ; dimensions (y, x)
	dw SafariZoneCenterBlocks, SafariZoneCenterTextPointers, SafariZoneCenterScript ; blocks, texts, scripts
	db $00 ; connections
	dw SafariZoneCenterObject ; objects
