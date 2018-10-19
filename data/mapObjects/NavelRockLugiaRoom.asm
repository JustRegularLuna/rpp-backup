NavelRockLugiaRoomObject:
	db $19 ; border block

	db $2 ; warps
	db 14, 16, $5, NAVEL_ROCK_CAVE_2 ; Lugia Chamber Warp
	db 31, 17, $6, NAVEL_ROCK_CAVE_2 ; Ho-oh Chamber Warp

	db $0 ; signs

	db $2 ; people
	db SPRITE_BIRD, 7 + 4, 13 + 4, $ff, $d0, TRAINER | $1, LUGIA, 40 | OW_POKEMON
	db SPRITE_BIRD, 27 + 4, 13 + 4, $ff, $d0, TRAINER | $2, HO_OH, 40 | OW_POKEMON

	; warp-to
	EVENT_DISP NAVEL_ROCK_LUGIA_ROOM_WIDTH, 14, 16 ; NAVEL_ROCK_CAVE_2 ; Lugia Exit
	EVENT_DISP NAVEL_ROCK_LUGIA_ROOM_WIDTH, 31, 17 ; NAVEL_ROCK_CAVE_2 ; Ho-oh Exit
