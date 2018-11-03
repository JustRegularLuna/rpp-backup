LavenderTownObject:
	db $2c ; border block

	db $6 ; warps
	db  5,  7, $0, LAVENDER_POKECENTER
	db  5, 18, $0, POKEMONTOWER_1
	db  9, 11, $0, LAVENDER_HOUSE_1
	db 13, 19, $0, LAVENDER_MART
	db 13,  7, $0, LAVENDER_HOUSE_2
	db 13, 11, $0, NAME_RATERS_HOUSE

	db $6 ; signs
	db  9, 15, $4 ; LavenderTownText4
	db  3, 13, $5 ; LavenderTownText5
	db 13, 20, $6 ; MartSignText
	db  5,  8, $7 ; PokeCenterSignText
	db  9,  9, $8 ; LavenderTownText8
	db  7, 21, $9 ; LavenderTownText9

	db $4 ; objects
	object SPRITE_LITTLE_GIRL, 19, 9, WALK, $0, $1 ; person
	object SPRITE_BLACK_HAIR_BOY_1, 13, 10, STAY, NONE, $2 ; person
	object SPRITE_BLACK_HAIR_BOY_2, 12, 7, WALK, $2, $3 ; person
	object SPRITE_BENCH_GUY, $0, $4, STAY, NONE, $4

	; warp-to
	EVENT_DISP LAVENDER_TOWN_WIDTH,  5,  7 ; LAVENDER_POKECENTER
	EVENT_DISP LAVENDER_TOWN_WIDTH,  5, 18 ; POKEMONTOWER_1
	EVENT_DISP LAVENDER_TOWN_WIDTH,  9, 11 ; LAVENDER_HOUSE_1
	EVENT_DISP LAVENDER_TOWN_WIDTH, 13, 19 ; LAVENDER_MART
	EVENT_DISP LAVENDER_TOWN_WIDTH, 13,  7 ; LAVENDER_HOUSE_2
	EVENT_DISP LAVENDER_TOWN_WIDTH, 13, 11 ; NAME_RATERS_HOUSE
