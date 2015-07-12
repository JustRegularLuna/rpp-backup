ViridianForestExit_h: ; 0x5d57b to 0x5d587 (12 bytes) (id=47)
	db GATE
	db VIRIDIAN_FOREST_EXIT_HEIGHT, VIRIDIAN_FOREST_EXIT_WIDTH
	dw ViridianForestExitBlocks, ViridianForestExitTextPointers, ViridianForestExitScript
	db 0
	dw ViridianForestExitObject
