; Handles sprite attributes

PAL_ORANGE	EQU 0
PAL_BLUE	EQU 1
PAL_GREEN	EQU 2
PAL_BROWN	EQU 3

ATK_PAL_GREY	EQU 0
ATK_PAL_BLUE	EQU 1
ATK_PAL_RED		EQU 2
ATK_PAL_BROWN	EQU 3
ATK_PAL_YELLOW	EQU 4
ATK_PAL_GREEN	EQU 5

	ORG $2e, $4000

LoadSpritePalettes:
	ld hl,SpritePalettes
	jr LoadPaletteData

LoadAttackSpritePalettes:
	ld hl,AttackSpritePalettes

LoadPaletteData:
	ld de,W2_SprPaletteData
	ld b,$40
.sprCopyLoop
	ld a,[hli]
	ld [de],a
	inc de
	dec b
	jr nz,.sprCopyLoop
	xor a
	ld [W2_LastOBP0],a
	ret

; Set overworld sprite colors
; On entering, A contains the flags (without a color palette) and de is the destination.
ColorOverworldSprites:
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

	ld de, SpritePaletteAssignments
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

; Currently this just colorized attack sprites but it can be
; used in other non-overworld scenarios.
ColorNonOverworldSprites:
	ld a,2
	ld [rSVBK],a

	ld a,[W2_ColorizeNonOverworldSprites]
	and a
	jr z,.end

	ld hl, W_OAMBUFFER
	ld b, 40
	ld d, W2_SpritePaletteMap>>8
.nextSprite
	ld a,[hli] ; y-coord
	and a
	jr z,.end

	inc hl
	ld a,[hli] ; tile
	ld e, a
	ld c,[hl] ; flags
	ld a,[de]
	cp 8
	jr c,.setPalette

	push hl
	ld a,[$cfd5] ; Move type
	ld hl, TypeColorTable
	add l
	ld l,a
	jr nc,.noCarry
	inc h
.noCarry
	ld a,[hl]
	pop hl

.setPalette
	or c
	ld [hli],a

	dec b
	jr nz, .nextSprite

.end
	xor a
	ld [rSVBK],a
	ret

LoadAnimationTilesetPalettes:
	di
	push de
	ld a,[$D09F] ; Animation tileset
	ld c,a
	ld a,2
	ld [rSVBK],a

	call LoadAttackSpritePalettes

	ld a,c
	and a
	ld hl, AnimationTileset1Palettes
	jr z,.gotPalette
	ld hl, AnimationTileset2Palettes
.gotPalette
	ld de, W2_SpritePaletteMap
	ld b, $80
.copyLoop
	ld a,[hli]
	ld [de],a
	inc e
	dec b
	jr nz,.copyLoop

	xor a
	ld [rSVBK],a

	pop de
	; Next lines were cut out from the caller
	ld hl,AnimationTilesetPointers
	add hl,de
	reti

; Set all sprite palettes to color 0. Non-overworld stuff only.
; ASSUMES THAT WRAM BANK 2 IS LOADED.
ClearSpritePalettes:
	ld hl, W2_SpritePaletteMap
	ld b,$02
	xor a
.loop
	ld [hli],a
	dec b
	jr nz,.loop
	ret

	ORG $2e, $6000

	jp ColorOverworldSprites

SpritePaletteAssignments: ; Characters on the overworld
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
	db PAL_ORANGE

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


AnimationTileset1Palettes:
	INCBIN "color/animtileset1palettes.bin"

AnimationTileset2Palettes:
	INCBIN "color/animtileset2palettes.bin"

TypeColorTable: ; Used for a select few sprites to be colorized based on attack type
	db 0 ; NORMAL EQU $00
	db 0 ; FIGHTING EQU $01
	db 0 ; FLYING EQU $02
	db 0 ; POISON EQU $03
	db 0 ; GROUND EQU $04
	db 0 ; ROCK EQU $05
	db 0
	db 0 ; BUG EQU $07
	db 0 ; GHOST EQU $08
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 2 ; FIRE EQU $14
	db 1 ; WATER EQU $15
	db 0 ; GRASS EQU $16
	db 0 ; ELECTRIC EQU $17
	db 0 ; PSYCHIC EQU $18
	db 0 ; ICE EQU $19
	db 1 ; DRAGON EQU $1A

INCLUDE "color/spritepalettes.asm"
