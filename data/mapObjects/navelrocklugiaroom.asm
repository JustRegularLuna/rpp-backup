NavelRockLugiaRoomObject:
	db $19 ; border block

	db $1 ; warps
	db $18, $10, $9, NAVEL_ROCK_CAVE_2

	db $0 ; signs

	db $1 ; people
	db SPRITE_BIRD, $11 + 4, $d + 4, $ff, $d0, TRAINER | $1, LUGIA, 40 | OW_POKEMON

	; warp-to
	EVENT_DISP NAVEL_ROCK_LUGIA_ROOM_WIDTH, $18, $10 ; NAVEL_ROCK_CAVE_2
