Route19Gate_h:
	db GATE ; tileset
	db ROUTE_19_GATE_HEIGHT, ROUTE_19_GATE_WIDTH ; dimensions (y, x)
	dw Route19GateBlocks, Route19GateTextPointers, Route19GateScript ; blocks, texts, scripts
	db $00 ; connections
	dw Route19GateObject ; objects
