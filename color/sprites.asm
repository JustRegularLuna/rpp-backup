; Handles sprite attributes

ATK_PAL_GREY    EQU 0
ATK_PAL_BLUE    EQU 1
ATK_PAL_RED     EQU 2
ATK_PAL_BROWN   EQU 3
ATK_PAL_YELLOW  EQU 4
ATK_PAL_GREEN   EQU 5
ATK_PAL_ICE	EQU 6
ATK_PAL_PURPLE	EQU 7
; 8: color based on attack type
; 9: don't change color palette (assume it's already set properly from elsewhere)


PAL_OW_RED		EQU 0
PAL_OW_BLUE		EQU 1
PAL_OW_GREEN	EQU 2
PAL_OW_BROWN	EQU 3
PAL_OW_PURPLE	EQU 4
PAL_OW_EMOJI	EQU 5
PAL_OW_TREE		EQU 6
PAL_OW_ROCK		EQU 7
PAL_OW_RANDOM	EQU 8 ; pseudorandom

LoadOverworldSpritePalettes:
	ld a,[rSVBK]
	ld b,a
	xor a
	ld [rSVBK],a
	push bc

	; Does the map we're on use dark/night palettes?
	; Load the matching Object Pals if so
	ld a, [wCurMapTileset]
	ld hl,SpritePalettesNite
	cp ICE_CAVERN
	jr z, .gotPaletteList
	cp CAVERN
	jr z, .gotPaletteList
	cp FOREST
	jr z, .gotPaletteList
	; If it is the Pokemon Center, load different pals for the Heal Machine to flash
	ld hl,SpritePalettesPokecenter
	cp POKECENTER
	jr z, .gotPaletteList
	; If not, load the normal Object Pals
	ld hl,SpritePalettes
.gotPaletteList
	pop bc
	ld a, b
	ld [rSVBK], a
	
	jr LoadSpritePaletteData

LoadAttackSpritePalettes:
	ld hl,AttackSpritePalettes

LoadSpritePaletteData:
	ld a,[rSVBK]
	ld b,a
	ld a,2
	ld [rSVBK],a
	push bc

	ld de,W2_SprPaletteData
	ld b,$40
.sprCopyLoop
	ld a,[hli]
	ld [de],a
	inc de
	dec b
	jr nz,.sprCopyLoop
	ld a,1
	ld [W2_ForceOBPUpdate],a

	pop af
	ld [rSVBK],a
	ret

; Set an overworld sprite's colors
; On entering, A contains the flags (without a color palette) and de is the destination.
; This is called in the middle of a loop in engine/overworld/oam.asm, once per sprite.
ColorOverworldSprite:
	push af
	push bc
	push de
	and $f8
	ld b,a

	ld a,[hSpriteOffset2]
	ld e,a
	ld d,wSpriteStateData1>>8
	ld a,[de]		; Load A with picture ID
	dec a
	and a
	jr z, .playerSprite

	ld de, SpritePaletteAssignments
	add e
	ld e,a
	jr nc,.noCarry
	inc d
.noCarry
	ld a,[de]		; Get the picture ID's palette
	jr .continue

.playerSprite
	ld a, [wPlayerGender]
	and a
	ld a, PAL_OW_RED
	jr z, .continue
	ld a, PAL_OW_GREEN

.continue
	; If it's PAL_OW_RANDOM, that means no particular palette is assigned
	cp PAL_OW_RANDOM
	jr nz,.norandomColor

	; This is a (somewhat) random but consistent color
	; (cannot be PAL_OW_PURPLE)
	ld a,[hSpriteOffset2]
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

; This is called whenever [wUpdateSpritesEnabled] != 1 (overworld sprites not enabled?).
;
; This sometimes does occur on the overworld, such as when exclamation marks appear, and
; when trees are being cut or boulders are being moved. Though, when in the overworld,
; W2_SpritePaletteMap is all blanked out (set to 9) except for the exclamation mark tile,
; so this function usually won't do anything.
;
; This colorizes: attack sprites, party menu, exclamation mark, trades, perhaps more?
ColorNonOverworldSprites:
	ld a,2
	ld [rSVBK],a

	ld hl, wOAMBuffer
	ld b, 40

.spriteLoop
	inc hl
	inc hl
	ld a,[hli] ; tile
	ld e, a
	ld d, W2_SpritePaletteMap>>8
	ld a,[de]
	cp 8 ; if 8, colorize based on attack type
	jr z,.getAttackType
	cp 9 ; if 9, do not colorize (use whatever palette it's set to already)
	jr z,.nextSprite
	cp 10 ; if 10 (used in game freak intro), color based on sprite number
	jr z, .gameFreakIntro
	jr .setPalette ; Otherwise, use the value as-is

.gameFreakIntro: ; The stars under the logo all get different colors
	ld a,b
	and 3
	add 4
	jr .setPalette

.getAttackType
	push hl

	; Load animation (move) being used
	xor a
	ld [rSVBK],a
	ld a,[wAnimationID]
	ld d,a
	ld a,2
	ld [rSVBK],a

	; If the absorb animation is playing, it's always green. (Needed for leech seed)
	ld a,d
	cp ABSORB
	ld a,GRASS
	jr z,.gotType

	; Make stun spore and solarbeam yellow, despite being grass moves
	ld a,d
	cp STUN_SPORE
	ld a,ELECTRIC
	jr z,.gotType
	ld a,d
	cp SOLARBEAM
	ld a,ELECTRIC
	jr z,.gotType

	; Make tri-attack yellow, despite being a normal move
	ld a,d
	cp TRI_ATTACK
	ld a,ELECTRIC
	jr z,.gotType

	ld a,[H_WHOSETURN]
	and a
	jr z,.playersTurn
	ld a,[wEnemyMoveType] ; Enemy move type
	jr .gotType
.playersTurn
	ld a,[wPlayerMoveType] ; Move type
.gotType
	ld hl, TypeColorTable
	add l
	ld l,a
	jr nc,.noCarry
	inc h
.noCarry
	ld a,[hl]
	pop hl

.setPalette
	ld c,a
	ld a,$f8
	and [hl]
	or c
	ld [hl],a

.nextSprite
	inc hl
	dec b
	jr nz, .spriteLoop

.end
	xor a
	ld [rSVBK],a
	ret

; Called whenever an animation plays in-battle. There are two animation tilesets, each
; with its own palette.
LoadAnimationTilesetPalettes:
	push de
	ld a,[wWhichBattleAnimTileset] ; Animation tileset (0-2)
	ld c,a
	ld a,2
	ld [rSVBK],a

	xor a
	ld [W2_UseOBP1],a

	call LoadAttackSpritePalettes

	; Indices 0 and 2 both refer to "AnimationTileset1", just different amounts of it.
	; 0 is in-battle, 2 is during a trade.
	; Index 1 refers to "AnimationTileset2".
	ld a,c
	cp 1
	ld hl, AnimationTileset2Palettes
	jr z,.gotPalette
	ld hl, AnimationTileset1Palettes
.gotPalette
	ld de, W2_SpritePaletteMap
	ld b, $80
.copyLoop
	ld a,[hli]
	ld [de],a
	inc e
	dec b
	jr nz,.copyLoop

	; If in a trade, some of the tiles near the end are different. Override some tiles
	; for the link cable, and replace the "purple" palette to match the exact color of
	; the link cable.
	ld a,c
	cp 2
	jr nz,.done

	; Replace ATK_PAL_PURPLE with PAL_MEWMON
	ld d, PAL_MEWMON
	ld e, ATK_PAL_PURPLE
	call LoadSGBPalette_Sprite

	; Set the link cable sprite tiles
	ld a, ATK_PAL_PURPLE
	ld hl, W2_SpritePaletteMap+$7e
	ld [hli],a
	ld [hli],a

.done
	ld a,1
	ld [W2_ForceOBPUpdate],a

	xor a
	ld [rSVBK],a

	pop de
	ret


; Set all sprite palettes to not be colorized by "ColorNonOverworldSprites".
ClearSpritePaletteMap:
	ld a,[rSVBK]
	ld b,a
	ld a,2
	ld [rSVBK],a
	push bc

	ld hl, W2_SpritePaletteMap
	ld b,$0 ; $100
	ld a,9
.loop
	ld [hli],a
	dec b
	jr nz,.loop

	pop af
	ld [rSVBK],a
	ret


SpritePaletteAssignments: ; Characters on the overworld
	; 0x01: SPRITE_RED
	db PAL_OW_RED

	; 0x02: SPRITE_BLUE
	db PAL_OW_BLUE

	; 0x03: SPRITE_OAK
	db PAL_OW_BROWN

	; 0x04: SPRITE_BUG_CATCHER
	db PAL_OW_RANDOM

	; 0x05: SPRITE_SLOWBRO
	db PAL_OW_RED

	; 0x06: SPRITE_LASS
	db PAL_OW_RANDOM

	; 0x07: SPRITE_BLACK_HAIR_BOY_1
	db PAL_OW_RANDOM

	; 0x08: SPRITE_LITTLE_GIRL
	db PAL_OW_RANDOM

	; 0x09: SPRITE_BIRD
	db PAL_OW_RED

	; 0x0a: SPRITE_FAT_BALD_GUY
	db PAL_OW_RANDOM

	; 0x0b: SPRITE_GAMBLER
	db PAL_OW_RANDOM

	; 0x0c: SPRITE_BLACK_HAIR_BOY_2
	db PAL_OW_RANDOM

	; 0x0d: SPRITE_GIRL
	db PAL_OW_RANDOM

	; 0x0e: SPRITE_HIKER
	db PAL_OW_RANDOM

	; 0x0f: SPRITE_FOULARD_WOMAN
	db PAL_OW_RANDOM

	; 0x10: SPRITE_GENTLEMAN
	db PAL_OW_BLUE

	; 0x11: SPRITE_DAISY
	db PAL_OW_BLUE

	; 0x12: SPRITE_BIKER
	db PAL_OW_RANDOM

	; 0x13: SPRITE_SAILOR
	db PAL_OW_BLUE

	; 0x14: SPRITE_COOK
	db PAL_OW_RED

	; 0x15: SPRITE_BIKE_SHOP_GUY
	db PAL_OW_RANDOM

	; 0x16: SPRITE_MR_FUJI
	db PAL_OW_GREEN

	; 0x17: SPRITE_GIOVANNI
	db PAL_OW_BLUE

	; 0x18: SPRITE_ROCKET
	db PAL_OW_BROWN

	; 0x19: SPRITE_MEDIUM
	db PAL_OW_BLUE

	; 0x1a: SPRITE_WAITER
	db PAL_OW_RANDOM

	; 0x1b: SPRITE_ERIKA
	db PAL_OW_GREEN

	; 0x1c: SPRITE_MOM_GEISHA
	db PAL_OW_RANDOM

	; 0x1d: SPRITE_BRUNETTE_GIRL
	db PAL_OW_RANDOM

	; 0x1e: SPRITE_LANCE
	db PAL_OW_RED

	; 0x1f: SPRITE_OAK_SCIENTIST_AIDE
	db PAL_OW_BLUE

	; 0x20: SPRITE_OAK_AIDE
	db PAL_OW_BLUE

	; 0x21: SPRITE_ROCKER ($20)
	db PAL_OW_RANDOM

	; 0x22: SPRITE_SWIMMER
	db PAL_OW_BLUE

	; 0x23: SPRITE_WHITE_PLAYER
	db PAL_OW_RANDOM

	; 0x24: SPRITE_GYM_HELPER
	db PAL_OW_BLUE

	; 0x25: SPRITE_OLD_PERSON
	db PAL_OW_RANDOM

	; 0x26: SPRITE_MART_GUY
	db PAL_OW_BLUE

	; 0x27: SPRITE_FISHER
	db PAL_OW_RANDOM

	; 0x28: SPRITE_OLD_MEDIUM_WOMAN
	db PAL_OW_BROWN

	; 0x29: SPRITE_NURSE
	db PAL_OW_RED

	; 0x2a: SPRITE_CABLE_CLUB_WOMAN
	db PAL_OW_GREEN

	; 0x2b: SPRITE_MR_MASTERBALL
	db PAL_OW_PURPLE

	; 0x2c: SPRITE_LAPRAS_GIVER
	db PAL_OW_BROWN

	; 0x2d: SPRITE_WARDEN
	db PAL_OW_GREEN

	; 0x2e: SPRITE_SS_CAPTAIN
	db PAL_OW_PURPLE

	; 0x2f: SPRITE_FISHER2
	db PAL_OW_GREEN

	; 0x30: SPRITE_BLACKBELT
	db PAL_OW_BROWN

	; 0x31: SPRITE_GUARD ($30)
	db PAL_OW_BLUE

	; 0x32: SPRITE_ROCKET_F
	db PAL_OW_RED

	; 0x33: SPRITE_MOM
	db PAL_OW_RED

	; 0x34: SPRITE_BALDING_GUY
	db PAL_OW_RANDOM

	; 0x35: SPRITE_YOUNG_BOY
	db PAL_OW_RANDOM

	; 0x36: SPRITE_GAMEBOY_KID
	db PAL_OW_RANDOM

	; 0x37: SPRITE_GAMEBOY_KID_COPY
	db PAL_OW_RANDOM

	; 0x38: SPRITE_CLEFAIRY
	db PAL_OW_RED

	; 0x39: SPRITE_AGATHA
	db PAL_OW_BROWN

	; 0x3a: SPRITE_BRUNO
	db PAL_OW_BROWN

	; 0x3b: SPRITE_LORELEI
	db PAL_OW_RED

	; 0x3c: SPRITE_SEEL
	db PAL_OW_RED

	; 0x3d: SPRITE_BROCK
	db PAL_OW_BROWN

	; 0x3e: SPRITE_MISTY
	db PAL_OW_RED

	; 0x3f: SPRITE_SURGE
	db PAL_OW_GREEN

	; 0x40: SPRITE_SABRINA
	db PAL_OW_RED

	; 0x41: SPRITE_KOGA
	db PAL_OW_PURPLE

	; 0x42: SPRITE_BLAINE
	db PAL_OW_BROWN

	; 0x43: SPRITE_BRENDAN
	db PAL_OW_RED

	; 0x44: SPRITE_FLANNERY
	db PAL_OW_RED

	; 0x45: SPRITE_GREETER
	db PAL_OW_BLUE

	; 0x46: SPRITE_LAPRAS
	db PAL_OW_BLUE

	; 0x47: SPRITE_SURF_PIKACHU
	db PAL_OW_RED

	; 0x48: SPRITE_LOOKER
	db PAL_OW_BROWN

	; 0x49: SPRITE_SWIMMER_F
	db PAL_OW_GREEN

	; 0x4a: SPRITE_OFFICER_JENNY
	db PAL_OW_BLUE

	; 0x4b: SPRITE_JESSIE
	db PAL_OW_RED

	; 0x4c: SPRITE_JAMES
	db PAL_OW_BLUE

	; 0x4d: SPRITE_HIRO
	db PAL_OW_RED

	; 0x4e: SPRITE_KRIS
	db PAL_OW_BLUE

	; 0x4f: SPRITE_SILVER
	db PAL_OW_RED
	
	; SPRITE_BILL
	db PAL_OW_RED

	; 0x50: SPRITE_BALL
	db PAL_OW_RED

	; 0x51: SPRITE_OMANYTE
	db PAL_OW_ROCK

	; 0x52: SPRITE_BOULDER
	db PAL_OW_ROCK

	; 0x53: SPRITE_PAPER_SHEET
	db PAL_OW_BROWN

	; 0x54: SPRITE_BOOK_MAP_DEX
	db PAL_OW_RED

	; 0x55: SPRITE_CLIPBOARD
	db PAL_OW_BROWN

	; 0x56: SPRITE_SNORLAX
	db PAL_OW_BLUE

	; 0x57: SPRITE_OLD_AMBER_COPY
	db PAL_OW_BROWN

	; 0x58: SPRITE_OLD_AMBER
	db PAL_OW_BROWN

	; 0x59: SPRITE_POKEDEX
	db PAL_OW_RED

	; 0x5a: SPRITE_BERRY_TREE
	db PAL_OW_TREE

	; 0x5b: SPRITE_LYING_OLD_MAN
	db PAL_OW_BROWN

	; 0x5c: SPRITE_SUDOWOODO
	db PAL_OW_GREEN

	; 0x5d: SPRITE_POKEY
	db PAL_OW_RED

	; 0x5e: SPRITE_DITTO
	db PAL_OW_PURPLE

	; 0x5f: SPRITE_CELEBI
	db PAL_OW_GREEN

	; 0x60: SPRITE_FOSSIL
	db PAL_OW_ROCK

	; 0x61: SPRITE_TOWN_MAP
	db PAL_OW_BLUE
	
	; 0x62: SPRITE_BENCH_GUY
	db PAL_OW_BROWN


AnimationTileset1Palettes:
	INCBIN "color/data/animtileset1palettes.bin"

AnimationTileset2Palettes:
	INCBIN "color/data/animtileset2palettes.bin"

TypeColorTable: ; Used for a select few sprites to be colorized based on attack type
	db 0 ; NORMAL EQU $00
	db 0 ; FIGHTING EQU $01
	db 0 ; FLYING EQU $02
	db 7 ; POISON EQU $03
	db 3 ; GROUND EQU $04
	db 3 ; ROCK EQU $05
	db 0
	db 5 ; BUG EQU $07
	db 7 ; GHOST EQU $08
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
	db 5 ; GRASS EQU $16
	db 4 ; ELECTRIC EQU $17
	db 7 ; PSYCHIC EQU $18
	db 6 ; ICE EQU $19
	db 1 ; DRAGON EQU $1A

INCLUDE "color/data/spritepalettes.asm"
