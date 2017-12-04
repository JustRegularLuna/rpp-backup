NavelRockCave2Object:
	db $19 ; border block

	db $b ; warps
	db $20, $6, $2, NAVEL_ROCK_CAVE_1  ;00 Goes to entry room
	db $2, $e, $2, NAVEL_ROCK_CAVE_2   ;01 Top right fork, connects to top right small room
	db $3, $23, $1, NAVEL_ROCK_CAVE_2  ;02 Up Stairs in top right room, connects to Top Right Fork
	db $5, $25, $4, NAVEL_ROCK_CAVE_2  ;03 Down Stairs in top right room, connects to Middle Right room
	db $11, $25, $3, NAVEL_ROCK_CAVE_2 ;04 Up Stairs in middle right room, connects to Top Right Room
	db $f, $23, $6, NAVEL_ROCK_CAVE_2  ;05 Down Stairs in middle right room, connects to Bottom Right Room
	db $1b, $23, $5, NAVEL_ROCK_CAVE_2 ;06 Up Stairs in bottom right room, connect to Middle Right Room
	db $1d, $25, $8, NAVEL_ROCK_CAVE_2 ;07 Down Stairs in bottom right room, connect to Bottom Left room
	db $1d, $17, $7, NAVEL_ROCK_CAVE_2 ;08 Up Stairs in bottom left room, connects to bottom right room
	db $1b, $15, $0, NAVEL_ROCK_LUGIA_ROOM ; 09 Connects to Lugia Room
	db $2, $2, $0, $ff                     ; 0A Unused, will warp to Ho-Oh's side later

	db $0 ; signs

	db $0 ; people

	; warp-to
	EVENT_DISP NAVEL_ROCK_CAVE_2_WIDTH, $20, $6  ; 00
	EVENT_DISP NAVEL_ROCK_CAVE_2_WIDTH, $2, $e   ; 01
	EVENT_DISP NAVEL_ROCK_CAVE_2_WIDTH, $3, $23  ; 02
	EVENT_DISP NAVEL_ROCK_CAVE_2_WIDTH, $5, $25  ; 03
	EVENT_DISP NAVEL_ROCK_CAVE_2_WIDTH, $11, $25 ; 04
	EVENT_DISP NAVEL_ROCK_CAVE_2_WIDTH, $f, $23  ; 05
	EVENT_DISP NAVEL_ROCK_CAVE_2_WIDTH, $1b, $23 ; 06
	EVENT_DISP NAVEL_ROCK_CAVE_2_WIDTH, $1d, $25 ; 07
	EVENT_DISP NAVEL_ROCK_CAVE_2_WIDTH, $1d, $17 ; 08
	EVENT_DISP NAVEL_ROCK_CAVE_2_WIDTH, $1b, $15 ; 09
	EVENT_DISP NAVEL_ROCK_CAVE_2_WIDTH, $2, $2   ; 0A
