SSAnne8Object: ; 0x61a60 (size=127)
	db $c ; border block

	db $6 ; warps
	db $0, $0, $2, SS_ANNE_1
	db $0, $a, $3, SS_ANNE_1
	db $0, $14, $4, SS_ANNE_1
	db $a, $0, $5, SS_ANNE_1
	db $a, $a, $6, SS_ANNE_1
	db $a, $14, $7, SS_ANNE_1

	db $0 ; signs

	db $b ; objects
	object SPRITE_GENTLEMAN, $2, $3, NONE, LEFT, $1, GENTLEMAN + $C8, $1
	object SPRITE_GENTLEMAN, $b, $4, NONE, UP, $2, GENTLEMAN + $C8, $2
	object SPRITE_BUG_CATCHER, $b, $e, NONE, UP, $3, YOUNGSTER + $C8, $8
	object SPRITE_LASS, $d, $b, NONE, LEFT, $4, LASS + $C8, $b
	object SPRITE_GIRL, $16, $3, WALK, $1, $5 ; person
	object SPRITE_FAT_BALD_GUY, $0, $e, NONE, NONE, $6 ; person
	object SPRITE_LITTLE_GIRL, $2, $b, NONE, DOWN, $7 ; person
	object SPRITE_CLEFAIRY, $3, $b, NONE, DOWN, $8 ; person
	object SPRITE_GIRL, $a, $d, NONE, RIGHT, $9 ; person
	object SPRITE_BALL, $c, $f, NONE, NONE, $a, TM_08
	object SPRITE_LOOKER, $15, $d, WALK, $2, $b ; person

	; warp-to
	EVENT_DISP SS_ANNE_8_WIDTH, $0, $0 ; SS_ANNE_1
	EVENT_DISP SS_ANNE_8_WIDTH, $0, $a ; SS_ANNE_1
	EVENT_DISP SS_ANNE_8_WIDTH, $0, $14 ; SS_ANNE_1
	EVENT_DISP SS_ANNE_8_WIDTH, $a, $0 ; SS_ANNE_1
	EVENT_DISP SS_ANNE_8_WIDTH, $a, $a ; SS_ANNE_1
	EVENT_DISP SS_ANNE_8_WIDTH, $a, $14 ; SS_ANNE_1
