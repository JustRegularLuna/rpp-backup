NavelRockLugiaRoom_h:
	db CAVERN ; tileset
	db NAVEL_ROCK_LUGIA_ROOM_HEIGHT, NAVEL_ROCK_LUGIA_ROOM_WIDTH ; dimensions (y, x)
	dw NavelRockLugiaRoomBlocks, NavelRockLugiaRoomTextPointers, NavelRockLugiaRoomScript ; blocks, texts, scripts
	db $00 ; connections
	dw NavelRockLugiaRoomObject ; objects
