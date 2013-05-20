; Handles sprite attributes

	ORG $2e, $4000

SetSpriteAttributes:
	push af
	push bc
	push de
	and $f8
	ld b,a

	ld a,[$ff8f]
	ld e,a
	ld d,$c1
	ld a,[de]		; Load A with picture ID
	dec a

	ld de, SpritePalettes
	add e
	ld e,a
	jr nc,.noCarry
	inc d
.noCarry
	ld a,[de]		; Get the picture ID's palette

	; If it's 4, that means no particular palette is assigned
	cp 4
	jr nz,.norandomColor

	; This is a (somewhat) random but consistent color
	ld a,[$ff8f]
	swap a
	and 3

.norandomColor

	pop de
	or b
	ld [de],a
	inc hl
	inc e
	pop bc
	pop af
	ret

	ORG $2e, $6000

	jp $4000

PAL_ORANGE	EQU 0
PAL_BLUE	EQU 1
PAL_GREEN	EQU 2
PAL_BROWN	EQU 3

SpritePalettes:
	; SPRITE_RED
	db PAL_ORANGE

	; SPRITE_BLUE
	db PAL_BLUE

	; SPRITE_OAK
	db PAL_BROWN

	; SPRITE_BUG_CATCHER
	db 4

	; SPRITE_SLOWBRO
	db 4

	; SPRITE_LASS
	db 4

	; SPRITE_BLACK_HAIR_BOY_1
	db 4

	; SPRITE_LITTLE_GIRL
	db 4

	; SPRITE_BIRD
	db PAL_ORANGE

	; SPRITE_FAT_BALD_GUY
	db 4

	; SPRITE_GAMBLER
	db 4

	; SPRITE_BLACK_HAIR_BOY_2
	db 4

	; SPRITE_GIRL
	db 4

	; SPRITE_HIKER
	db 4

	; SPRITE_FOULARD_WOMAN
	db 4

	; SPRITE_GENTLEMAN
	db PAL_BLUE

	; SPRITE_DAISY ($10)
	db 4

	; SPRITE_BIKER
	db 4

	; SPRITE_SAILOR
	db 4

	; SPRITE_COOK
	db 4

	; SPRITE_BIKE_SHOP_GUY
	db 4

	; SPRITE_MR_FUJI
	db PAL_GREEN

	; SPRITE_GIOVANNI
	db PAL_BLUE

	; SPRITE_ROCKET
	db 4

	; SPRITE_MEDIUM
	db 4

	; SPRITE_WAITER
	db 4

	; SPRITE_ERIKA
	db 4

	; SPRITE_MOM_GEISHA
	db 4

	; SPRITE_BRUNETTE_GIRL
	db 4

	; SPRITE_LANCE
	db 4

	; SPRITE_OAK_SCIENTIST_AIDE
	db PAL_BROWN

	; SPRITE_OAK_AIDE
	db PAL_BROWN

	; SPRITE_ROCKER ($20)
	db 4

	; SPRITE_SWIMMER
	db 4

	; SPRITE_WHITE_PLAYER
	db 4

	; SPRITE_GYM_HELPER
	db 4

	; SPRITE_OLD_PERSON
	db 4

	; SPRITE_MART_GUY
	db 4

	; SPRITE_FISHER
	db 4

	; SPRITE_OLD_MEDIUM_WOMAN
	db 4

	; SPRITE_NURSE
	db PAL_BLUE

	; SPRITE_CABLE_CLUB_WOMAN
	db PAL_GREEN

	; SPRITE_MR_MASTERBALL
	db 4

	; SPRITE_LAPRAS_GIVER
	db 4

	; SPRITE_WARDEN
	db 4

	; SPRITE_SS_CAPTAIN
	db 4

	; SPRITE_FISHER2
	db 4

	; SPRITE_BLACKBELT
	db 4

	; SPRITE_GUARD ($30)
	db 4

	; $32
	db 4

	; SPRITE_MOM
	db 4

	; SPRITE_BALDING_GUY
	db 4

	; SPRITE_YOUNG_BOY
	db 4

	; SPRITE_GAMEBOY_KID
	db 4

	; SPRITE_GAMEBOY_KID_COPY
	db 4

	; SPRITE_CLEFAIRY
	db PAL_ORANGE

	; SPRITE_AGATHA
	db 4

	; SPRITE_BRUNO
	db 4

	; SPRITE_LORELEI
	db 4

	; SPRITE_SEEL
	db PAL_BLUE

	; SPRITE_BALL
	db PAL_ORANGE

	; SPRITE_OMANYTE
	db 4

	; SPRITE_BOULDER
	db PAL_BROWN

	; SPRITE_PAPER_SHEET
	db PAL_ORANGE

	; SPRITE_BOOK_MAP_DEX
	db PAL_ORANGE

	; SPRITE_CLIPBOARD
	db PAL_ORANGE

	; SPRITE_SNORLAX
	db PAL_ORANGE

	; SPRITE_OLD_AMBER_COPY
	db PAL_BROWN

	; SPRITE_OLD_AMBER
	db PAL_BROWN

	; SPRITE_LYING_OLD_MAN_UNUSED_1
	db 4

	; SPRITE_LYING_OLD_MAN_UNUSED_2
	db 4

	; SPRITE_LYING_OLD_MAN
	db 4
