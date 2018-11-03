RedsHouse1FObject:
	db $0A ; border block

	db $3 ; warps
	db $7, $2, $0, $FF ; exit1
	db $7, $3, $0, $FF ; exit2
	db $0, $7, $0, REDS_HOUSE_2F ; staircase

	db $4 ; signs
	db $1, $5, $2 ; TV
	db $1, $2, $3 ; Fridge
	db $1, $0, $4 ; Stove
	db $1, $1, $5 ; Sink

	db $1 ; objects
	object SPRITE_MOM, $5, $4, $FF, $D2, $1 ; Mom

	; warp-to
	EVENT_DISP REDS_HOUSE_1F_WIDTH, $7, $2
	EVENT_DISP REDS_HOUSE_1F_WIDTH, $7, $3
	EVENT_DISP REDS_HOUSE_1F_WIDTH, $0, $7
