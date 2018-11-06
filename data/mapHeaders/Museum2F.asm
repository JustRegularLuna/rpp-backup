Museum2F_h:
	db MUSEUM_2 ; tileset
	db MUSEUM_2F_HEIGHT, MUSEUM_2F_WIDTH ; dimensions (y, x)
	dw Museum2FBlocks, Museum2FTextPointers, Museum2FScript ; blocks, texts, scripts
	db $00 ; connections
	dw Museum2FObject ; objects
