VictoryRoad1Object: ; 0x5dab8 (size=76)
	db $7d ; border block

	db $3 ; warps
	db $11, $8, $2, $ff
	db $11, $9, $2, $ff
	db $1, $1, $0, VICTORY_ROAD_2

	db $0 ; signs

	db $7 ; objects
	object SPRITE_BRUNETTE_GIRL, $7, $5, STAY, RIGHT, $1, PKMN_TRAINER + $C8, $2
	object SPRITE_BLACK_HAIR_BOY_1, $3, $2, STAY, DOWN, $2, COOLTRAINER_M + $C8, $5
	object SPRITE_BALL, $b, $0, STAY, NONE, $3, TM_15
	object SPRITE_BALL, $9, $2, STAY, NONE, $4, RARE_CANDY
	object SPRITE_BOULDER, $5, $f, NONE, BOULDER_MOVEMENT_BYTE_2, $5 ; person
	object SPRITE_BOULDER, $e, $2, NONE, BOULDER_MOVEMENT_BYTE_2, $6 ; person
	object SPRITE_BOULDER, $2, $a, NONE, BOULDER_MOVEMENT_BYTE_2, $7 ; person

	; warp-to
	EVENT_DISP VICTORY_ROAD_1_WIDTH, $11, $8
	EVENT_DISP VICTORY_ROAD_1_WIDTH, $11, $9
	EVENT_DISP VICTORY_ROAD_1_WIDTH, $1, $1 ; VICTORY_ROAD_2
