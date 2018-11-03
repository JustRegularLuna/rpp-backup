BluesHouseObject:
	db $0A ; border block

	db $2 ; warps
	db $7, $2, $1, $FF
	db $7, $3, $1, $FF

	db $4 ; signs
	db $1, $0, $4 ; Stove
	db $1, $1, $5 ; Sink
	db $1, $2, $6 ; Fridge
	db $1, $5, $7 ; TV

	db $3 ; objects
	object SPRITE_DAISY, $2, $4, $FF, $D3, $1 ; Daisy, sitting by map
	object SPRITE_DAISY, $2, $2, $FE, $1, $2, $0 ; Daisy, walking around
	object SPRITE_TOWN_MAP, $3, $4, $FF, $FF, $3, $0 ; map on table

	; warp-to
	EVENT_DISP BLUES_HOUSE_WIDTH, $7, $2
	EVENT_DISP BLUES_HOUSE_WIDTH, $7, $3
