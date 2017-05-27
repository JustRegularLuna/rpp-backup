UndergroundPathNS_h:
	db GATE
	db UNDERGROUND_PATH_NS_HEIGHT, UNDERGROUND_PATH_NS_WIDTH
	dw UndergroundPathNSBlocks, UndergroundPathNSTextPointers, UndergroundPathNSScript
	db 0
	dw UndergroundPathNSObject
