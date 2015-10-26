NavelRockLugiaRoomObject:
	db $19 ; border block

	db $1 ; warps
	db $13, $c, $1, NAVEL_ROCK_CAVE_2

	db $0 ; signs

	db $1 ; people
	db SPRITE_BIRD, $c + 4, $c + 4, $ff, $d0, TRAINER | $1, LUGIA, 40 | OW_POKEMON

	; warp-to
	EVENT_DISP NAVEL_ROCK_LUGIA_ROOM_WIDTH, $13, $c ; NAVEL_ROCK_CAVE_2
