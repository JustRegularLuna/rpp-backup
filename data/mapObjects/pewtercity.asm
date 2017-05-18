PewterCityObject: ; 0x18577 (size=111)
	db $f ; border block

	db $7 ; warps
	db $7, $e, $0, MUSEUM_1F
	db $5, $13, $2, MUSEUM_1F
	db $11, $10, $0, PEWTER_GYM
	db $d, $1d, $0, PEWTER_HOUSE_1
	db $11, $17, $0, PEWTER_MART
	db $1d, $7, $0, PEWTER_HOUSE_2
	db $19, $d, $0, PEWTER_POKECENTER

	db $7 ; signs
	db $1d, $13, $8 ; PewterCityText6
	db $13, $21, $9 ; PewterCityText7
	db $11, $18, $a ; MartSignText
	db $19, $e, $b ; PokeCenterSignText
	db $9, $f, $c ; PewterCityText10
	db $11, $b, $d ; PewterCityText11
	db $17, $19, $e ; PewterCityText12

	db $7 ; objects
	object SPRITE_LASS, $8, $f, FACE, STAY, $1 ; person
	object SPRITE_BLACK_HAIR_BOY_1, $11, $19, FACE, STAY, $2 ; person
	object SPRITE_BLACK_HAIR_BOY_2, $1b, $11, FACE, STAY, $3 ; person
	object SPRITE_BLACK_HAIR_BOY_2, $1a, $19, WALK, $2, $4 ; person
	object SPRITE_BUG_CATCHER, $23, $10, FACE, DOWN, $5 ; person
	object SPRITE_BERRY_TREE, $1E, $3, FACE, STAY, $6 ; person
	object SPRITE_BERRY_TREE, $20, $3, FACE, STAY, $7 ; person

	; warp-to
	EVENT_DISP PEWTER_CITY_WIDTH, $7, $e ; MUSEUM_1F
	EVENT_DISP PEWTER_CITY_WIDTH, $5, $13 ; MUSEUM_1F
	EVENT_DISP PEWTER_CITY_WIDTH, $11, $10 ; PEWTER_GYM
	EVENT_DISP PEWTER_CITY_WIDTH, $d, $1d ; PEWTER_HOUSE_1
	EVENT_DISP PEWTER_CITY_WIDTH, $11, $17 ; PEWTER_MART
	EVENT_DISP PEWTER_CITY_WIDTH, $1d, $7 ; PEWTER_HOUSE_2
	EVENT_DISP PEWTER_CITY_WIDTH, $19, $d ; PEWTER_POKECENTER
