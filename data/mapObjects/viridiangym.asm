ViridianGymObject: ; 0x74bde (size=105)
	db $3 ; border block

	db $2 ; warps
	db $11, $10, $4, $ff
	db $11, $11, $4, $ff

	db $0 ; signs

	db $b ; people
	db SPRITE_GIOVANNI, $1 + 4, $2 + 4, $ff, $d0, TRAINER | $1, GIOVANNI + TRAINER_START, $3
	db SPRITE_BLACK_HAIR_BOY_1, $7 + 4, $c + 4, $ff, $d0, TRAINER | $2, COOLTRAINER_M + TRAINER_START, $9
	db SPRITE_BLACKBELT, $b + 4, $b + 4, $ff, $d1, TRAINER | $3, BLACKBELT + TRAINER_START, $6
	db SPRITE_ROCKER, $7 + 4, $a + 4, $ff, $d0, TRAINER | $4, TAMER + TRAINER_START, $3
	db SPRITE_BLACKBELT, $7 + 4, $3 + 4, $ff, $d2, TRAINER | $5, BLACKBELT + TRAINER_START, $7
	db SPRITE_BLACK_HAIR_BOY_1, $5 + 4, $d + 4, $ff, $d3, TRAINER | $6, COOLTRAINER_M + TRAINER_START, $a
	db SPRITE_BLACKBELT, $1 + 4, $a + 4, $ff, $d0, TRAINER | $7, BLACKBELT + TRAINER_START, $8
	db SPRITE_ROCKER, $10 + 4, $2 + 4, $ff, $d3, TRAINER | $8, TAMER + TRAINER_START, $4
	db SPRITE_BLACK_HAIR_BOY_1, $5 + 4, $6 + 4, $ff, $d0, TRAINER | $9, COOLTRAINER_M + TRAINER_START, $1
	db SPRITE_GYM_HELPER, $f + 4, $10 + 4, $ff, $d0, $a ; person
	db SPRITE_BALL, $9 + 4, $10 + 4, $ff, $ff, ITEM | $b, REVIVE

	; warp-to
	EVENT_DISP VIRIDIAN_GYM_WIDTH, $11, $10
	EVENT_DISP VIRIDIAN_GYM_WIDTH, $11, $11
