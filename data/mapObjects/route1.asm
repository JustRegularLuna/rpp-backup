Route1Object: ; 0x1c0e5 (size=19)
	db $f ; border block

	db $0 ; warps

	db $1 ; signs
	db $1b, $9, $4 ; Route1Text3

	db $3 ; people
	db SPRITE_BUG_CATCHER, $18 + 4, $5 + 4, $fe, $1, $1 ; person
	db SPRITE_BUG_CATCHER, $d + 4, $f + 4, $fe, $2, $2 ; person
	db SPRITE_BERRY_TREE, $7 + 4, $6 + 4, $ff, $ff, $3 ; person

	; warp-to (unused)
	EVENT_DISP $4, $7, $2
