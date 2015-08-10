DayCareMObject: ; 0x56459 (size=26)
	db $a ; border block

	db $2 ; warps
	db $7, $2, $4, $ff
	db $7, $3, $4, $ff

	db $0 ; signs

	db $3 ; people
	db SPRITE_OLD_MEDIUM_WOMAN, $3 + 4, $2 + 4, $ff, $d3, $1 ; person
    db SPRITE_OLD_PERSON, $3 + 4, $5 + 4, $ff, $d2, $2 ; person
    db SPRITE_DITTO, $1 + 4, $6 + 4, $ff, $ff, $3 ; person

	; warp-to
	EVENT_DISP DAYCAREM_WIDTH, $7, $2
	EVENT_DISP DAYCAREM_WIDTH, $7, $3
