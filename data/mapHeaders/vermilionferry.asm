VermilionFerryDock_h:
	db FERRY ; tileset
	db VERMILION_FERRY_DOCK_HEIGHT, VERMILION_FERRY_DOCK_WIDTH ; dimensions (y, x)
	dw VermilionFerryBlocks, VermilionFerryTextPointers, VermilionFerryScript ; blocks, texts, scripts
	db $00 ; connections
	dw VermilionFerryObject ; objects
