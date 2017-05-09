UndergroundPathNS_h: ; 0x61f1a to 0x61f26 (12 bytes) (id=119)
	db GATE
	db UNDERGROUND_PATH_NS_HEIGHT, UNDERGROUND_PATH_NS_WIDTH
	dw UndergroundPathNSBlocks, UndergroundPathNSTextPointers, UndergroundPathNSScript
	db 0
	dw UndergroundPathNSObject
