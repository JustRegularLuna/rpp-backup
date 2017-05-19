SSAnne9Object: ; 0x61c8d (size=188)
	db $c ; border block

	db $c ; warps
	db $5, $2, $0, SS_ANNE_2
	db $5, $3, $0, SS_ANNE_2
	db $5, $c, $1, SS_ANNE_2
	db $5, $d, $1, SS_ANNE_2
	db $5, $16, $2, SS_ANNE_2
	db $5, $17, $2, SS_ANNE_2
	db $f, $2, $3, SS_ANNE_2
	db $f, $3, $3, SS_ANNE_2
	db $f, $c, $4, SS_ANNE_2
	db $f, $d, $4, SS_ANNE_2
	db $f, $16, $5, SS_ANNE_2
	db $f, $17, $5, SS_ANNE_2

	db $0 ; signs

	db $d ; objects
	object SPRITE_GENTLEMAN, $a, $2, NONE, RIGHT, $1, GENTLEMAN + $C8, $6
	object SPRITE_FISHER2, $d, $4, NONE, LEFT, $2, FISHER + $C8, $1
	object SPRITE_GENTLEMAN, $0, $e, NONE, RIGHT, $3, GENTLEMAN + $C8, $5
	object SPRITE_LASS, $2, $b, NONE, DOWN, $4, LASS + $C8, $c
	object SPRITE_GENTLEMAN, $1, $2, NONE, DOWN, $5 ; person
	object SPRITE_BALL, $c, $1, NONE, NONE, $6, MAX_ETHER
	object SPRITE_GENTLEMAN, $15, $2, NONE, DOWN, $7 ; person
	object SPRITE_OLD_PERSON, $16, $1, NONE, DOWN, $8 ; person
	object SPRITE_BALL, $0, $c, NONE, NONE, $9, RARE_CANDY
	object SPRITE_GENTLEMAN, $c, $c, NONE, DOWN, $a ; person
	object SPRITE_YOUNG_BOY, $b, $e, NONE, NONE, $b ; person
	object SPRITE_BRUNETTE_GIRL, $16, $c, NONE, LEFT, $c ; person
	object SPRITE_FOULARD_WOMAN, $14, $c, NONE, RIGHT, $d ; person

	; warp-to
	EVENT_DISP SS_ANNE_9_WIDTH, $5, $2 ; SS_ANNE_2
	EVENT_DISP SS_ANNE_9_WIDTH, $5, $3 ; SS_ANNE_2
	EVENT_DISP SS_ANNE_9_WIDTH, $5, $c ; SS_ANNE_2
	EVENT_DISP SS_ANNE_9_WIDTH, $5, $d ; SS_ANNE_2
	EVENT_DISP SS_ANNE_9_WIDTH, $5, $16 ; SS_ANNE_2
	EVENT_DISP SS_ANNE_9_WIDTH, $5, $17 ; SS_ANNE_2
	EVENT_DISP SS_ANNE_9_WIDTH, $f, $2 ; SS_ANNE_2
	EVENT_DISP SS_ANNE_9_WIDTH, $f, $3 ; SS_ANNE_2
	EVENT_DISP SS_ANNE_9_WIDTH, $f, $c ; SS_ANNE_2
	EVENT_DISP SS_ANNE_9_WIDTH, $f, $d ; SS_ANNE_2
	EVENT_DISP SS_ANNE_9_WIDTH, $f, $16 ; SS_ANNE_2
	EVENT_DISP SS_ANNE_9_WIDTH, $f, $17 ; SS_ANNE_2
