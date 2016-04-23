CeladonMansion1Object: ; 0x486cf (size=71)
	db $f ; border block

	db $5 ; warps
	db $b, $4, $2, $ff
	db $b, $5, $2, $ff
	db $0, $4, $4, $ff
	db $1, $7, $1, CELADON_MANSION_2
	db $1, $2, $2, CELADON_MANSION_2

	db $1 ; signs
	db $9, $4, $5 ; CeladonMansion1Text5

	db $4 ; people
	db SPRITE_OLD_MEDIUM_WOMAN, $4 + 4, $3 + 4, $ff, $d1, $1 ; person
	db SPRITE_FOULARD_WOMAN, $5 + 4, $0 + 4, $ff, $d0, $2 ; person
	db SPRITE_HIKER, $5 + 4, $1 + 4, $ff, $d0, $3 ; person
	db SPRITE_BRUNETTE_GIRL, $6 + 4, $2 + 4, $ff, $d2, $4 ; person

	; warp-to
	EVENT_DISP CELADON_MANSION_1_WIDTH, $b, $4
	EVENT_DISP CELADON_MANSION_1_WIDTH, $b, $5
	EVENT_DISP CELADON_MANSION_1_WIDTH, $0, $4
	EVENT_DISP CELADON_MANSION_1_WIDTH, $1, $7 ; CELADON_MANSION_2
	EVENT_DISP CELADON_MANSION_1_WIDTH, $1, $2 ; CELADON_MANSION_2
