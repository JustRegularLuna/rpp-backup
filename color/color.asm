SECTION "bank1C_extension",ROMX,BANK[$1C]

; Set all palettes to black at beginning of battle
SetPal_BattleBlack:
	; Code $ff sometimes calls this (by accident?)
	inc b
	ret z

	ld a,$02
	ld [rSVBK],a

	ld d,PAL_BLACK
	ld e,7
.palLoop	; Set all bg and sprite palettes to SGB Palette $1e
	push de
	callba LoadSGBPalette
	pop de
	push de
	callba LoadSGBPalette_Sprite
	pop de
	dec e
	ld a,e
	inc a
	jr nz,.palLoop

	; This prevents extra flickering when entering battle
	xor a
	ld [rBGP],a
	ld [rOBP0],a
	ld [rOBP1],a

	;xor a
	ld [rSVBK],a
	ret

; Set proper palettes for pokemon/trainers
SetPal_Battle:
 	ld a, [wPlayerBattleStatus3]
	ld hl, wBattleMonSpecies        ; player Pokemon ID
	call DetermineBackSpritePaletteID
	ld b, a

	ld a, [wEnemyBattleStatus3]
	ld hl, wEnemyMonSpecies2         ; enemy Pokemon ID
	call DeterminePaletteID
	ld c, a

	ld a,$02
	ld [rSVBK],a

	; Player palette
	push bc
	ld d,b
	ld e,0
	callba LoadSGBPalette

	; Enemy palette
	pop bc
	ld d,c
	ld e,1
	callba LoadSGBPalette

	; Player lifebar
	ld a, [wPlayerHPBarColor]
	add PAL_GREENBAR
	ld d,a
	ld e,2
	callba LoadSGBPalette

	; Enemy lifebar
	ld a, [wEnemyHPBarColor]
	add PAL_GREENBAR
	ld d,a
	ld e,3
	callba LoadSGBPalette

IF GEN_2_GRAPHICS
	; Player exp bar
	ld d, PAL_EXP
ELSE
	; Black palette
	ld d, PAL_BLACK
ENDC
	ld e,4
	callba LoadSGBPalette


	; Now set the tilemap

	xor a
	ld [W2_TileBasedPalettes],a	; Use a direct color map instead of assigning colors to tiles
	ld a,3
	ld [W2_StaticPaletteChanged],a

	; Top half; enemy lifebar
	ld hl,W2_TilesetPaletteMap
	ld a,3
	ld b,4
	ld c,11
	call FillBox

IF GEN_2_GRAPHICS
	; Bottom half; player lifebar
	ld hl,W2_TilesetPaletteMap+7*20+9
	ld a,2
	ld b,4
	ld c,11
	call FillBox

	; Player exp bar
	ld hl, W2_TilesetPaletteMap + 9 + 11 * 20
	ld a, 4
	ld b, 1
	ld c, 11
	call FillBox
ENDC

IF !GEN_2_GRAPHICS
	; Bottom half; player lifebar
	ld hl,W2_TilesetPaletteMap+7*20+9
	ld a,2
	ld b,5
	ld c,11
	call FillBox
ENDC

	; Player pokemon
	ld hl,W2_TilesetPaletteMap+4*20
	ld a,0
	ld b,8
	ld c,9
	call FillBox

	; Enemy pokemon
	ld hl,W2_TilesetPaletteMap + 11
	ld a,1
	ld b,7
	ld c,9
	call FillBox

	; text box
	ld hl,W2_TilesetPaletteMap+12*20
	ld a,0
	ld b,6
	ld c,20
	call FillBox

	; Wait 2 frames before updating palettes
	ld c,2
	call DelayFrames

	; Restore sprite palettes which may have been set to black
	CALL_INDIRECT LoadSpritePalettes

	ld a,1
	ld [W2_UseOBP1],a
	ld [W2_LastBGP],a
	ld [W2_LastOBP0],a	; Palettes must be redrawn
	ld [rSVBK],a

	;ld a,$01
	ld [W_PALREFRESHCMD],a
	ret

; hl: starting address
; a: pal number
; b: number of rows
; c: number of columns
FillBox:
	push af
	ld a, SCREEN_WIDTH
	sub c
	ld e, a
	ld d, 0
	pop af
	push bc
.loop
	ld [hli],a
	dec c
	jr nz,.loop
	add hl,de
	pop bc
	dec b
	push bc
	jr nz,.loop
	pop bc
	ret

; Load town map
SetPal_TownMap:
	ld a,2
	ld [rSVBK],a

	ld d, PAL_TOWNMAP
	ld e,0
	callba LoadSGBPalette

	ld d, PAL_TOWNMAP2
	ld e,1
	callba LoadSGBPalette

	ld a,1
	ld [W2_TileBasedPalettes],a

	ld hl,W2_TilesetPaletteMap
	ld bc, $100
	xor a
	call FillMemory

	; Give tile $65 a different color
	ld hl,W2_TilesetPaletteMap + $65
	ld [hl], 1

	xor a
	ld [rSVBK],a
	ret

; Status screen
SetPal_StatusScreen:
	ld a, [wcf91]
	cp VICTREEBEL + 1
	jr c, .pokemon
	ld a, $1 ; not pokemon
.pokemon
	call DeterminePaletteIDOutOfBattle ; DeterminePaletteID without status check
	ld b,a

	ld a,2
	ld [rSVBK],a

	push bc

	; Load Lifebar palette
	ld a, [wStatusScreenHPBarColor]
	add PAL_GREENBAR
	ld d,a
	ld e,1
	callba LoadSGBPalette
	
IF GEN_2_GRAPHICS
	ld d, PAL_EXP
	ld e,4	
	callba LoadSGBPalette
ENDC	

	; Load pokemon palette
	pop af
	ld d,a
	ld e,0
	callba LoadSGBPalette


	; Set palette map
	xor a
	ld [W2_TileBasedPalettes],a
	ld a,3
	ld [W2_StaticPaletteChanged],a

	; Set everything to the lifebar palette
	ld hl,W2_TilesetPaletteMap
	ld bc,18*20
	ld d,1
.fillLoop
	ld [hl],d
	inc hl
	dec bc
	ld a,b
	or c
	jr nz,.fillLoop

	; Set upper-left to pokemon's palette
	ld hl,W2_TilesetPaletteMap
	ld de,20-8
	ld b,7
	xor a
.drawRow
	ld c,8
.palLoop
	ld [hli],a
	dec c
	jr nz,.palLoop
	add hl,de
	dec b
	jr nz,.drawRow
	
IF GEN_2_GRAPHICS
	; Player exp bar
	ld hl, W2_TilesetPaletteMap + 11 + 5 * SCREEN_WIDTH
	ld b, 8
	ld a, 4
.expLoop
	ld [hli], a
	dec b
	jr nz, .expLoop
ENDC	

	xor a
	ld [rSVBK],a
	ret

; Show pokedex data
SetPal_Pokedex:
	ld a, [wcf91]
	call DeterminePaletteIDOutOfBattle	; Call DeterminePaletteID without status check
	ld d,a
	ld e,0

	ld a,2
	ld [rSVBK],a

	callba LoadSGBPalette

IF DEF(_BLUE)
	ld d,PAL_BLUEMON
ELSE
	ld d,PAL_REDMON
ENDC
	ld e,1
	callba LoadSGBPalette

	ld bc,20*18
	ld hl,W2_TilesetPaletteMap
	ld d,1
.palLoop
	ld [hl],d
	inc hl
	dec bc
	ld a,b
	or c
	jr nz,.palLoop

	ld hl,W2_TilesetPaletteMap + 21
	ld de,20-8
	ld b,7
	xor a
.pokeLoop
	ld c,8
.pokeInnerLoop
	ld [hli],a
	dec c
	jr nz,.pokeInnerLoop
	add hl,de
	dec b
	jr nz,.pokeLoop

	CALL_INDIRECT ClearSpritePaletteMap

	ld a,3
	ld [W2_StaticPaletteChanged],a
	xor a
	ld [W2_TileBasedPalettes],a

	;xor a
	ld [rSVBK],a
	ret

; Slots
SetPal_Slots:
	ld a,2
	ld [rSVBK],a

	ld d, PAL_SLOTS1
	ld e, 0
	callba LoadSGBPalette
	ld d, PAL_SLOTS2
	ld e, 1
	callba LoadSGBPalette
	ld d, PAL_SLOTS3
	ld e, 2
	callba LoadSGBPalette
	ld d, PAL_SLOTS4
	ld e, 3
	callba LoadSGBPalette
	ld d, PAL_SLOTS5
	ld e, 4
	callba LoadSGBPalette

	ld hl, SlotPaletteMap
	ld a, BANK(SlotPaletteMap)
	ld de, W2_TilesetPaletteMap
	ld bc, 20*18
	call FarCopyData

	ld a,3
	ld [W2_StaticPaletteChanged],a

	xor a
	ld [W2_TileBasedPalettes],a

	; Manage sprites

	CALL_INDIRECT LoadAttackSpritePalettes

	xor a
	ld [W2_UseOBP1],a

	ld hl, SlotSpritePaletteMap
	ld a, BANK(SlotSpritePaletteMap)
	ld de, W2_SpritePaletteMap
	ld bc, $18
	call FarCopyData

	xor a
	ld [rSVBK],a
	ret

; Titlescreen with cycling pokemon
SetPal_TitleScreen:
	ld a,[wWhichTrade] ; Get the pokemon on the screen
	call DeterminePaletteIDOutOfBattle
	ld d,a
	ld e,0

	ld a,2
	ld [rSVBK],a

	callba LoadSGBPalette

	ld d,PAL_LOGO2	; Title logo
	ld e,1
	callba LoadSGBPalette

	ld d, PAL_LOGO1
	ld e,2
	callba LoadSGBPalette

	ld d, PAL_BLACK
	ld e,3
	callba LoadSGBPalette

IF GEN_2_GRAPHICS
	ld d, PAL_HERO
ELSE
	ld d, PAL_REDMON
ENDC
	ld e,0
	callba LoadSGBPalette_Sprite

	; Pokemon logo
	ld hl,W2_TilesetPaletteMap
	ld a,1
	ld b,8
.logo2Loop
	ld c,20
.logo2InnerLoop
	ld [hli],a
	dec c
	jr nz,.logo2InnerLoop
	dec b
	jr nz,.logo2Loop

	; "Red/Blue Version"
	ld bc,20
	ld a,2
	call FillMemory

	ld hl, W2_TilesetPaletteMap + 17*20
	ld bc, 20
	ld a,3
	call FillMemory

	ld a,3
	ld [W2_StaticPaletteChanged],a
 	xor a
	ld [W2_TileBasedPalettes],a

	ld a,1
	ld [W2_LastBGP],a	; Palettes must be redrawn

	;ld a,1
	ld [rSVBK],a

	; Execute custom command 0e after titlescreen to clear colors.
	ld a,$e
	ld [W_PALREFRESHCMD],a
	ret

; Called during the intro
SetPal_NidorinoIntro:
	ld a,2
	ld [rSVBK],a

IF GEN_2_GRAPHICS
	ld d, PAL_NIDORINO
ELSE
	ld d, PAL_PURPLEMON
ENDC
	ld e,0
	callba LoadSGBPalette_Sprite

	ld d, PAL_PURPLEMON
	ld e,0
	callba LoadSGBPalette

	ld a,1
	ld [W2_LastOBP0],a
	ld [W2_LastBGP],a	; Palettes must be redrawn

	xor a
	ld [rSVBK],a
	ret

; used mostly for menus and the Oak intro
; Pokedex screen
SetPal_Generic:
	ld a,2
	ld [rSVBK],a

	ld d,PAL_REDBAR	; Red lifebar color (for pokeballs)
	ld e,0
	push de
	callba LoadSGBPalette
	pop de
	inc e
	callba LoadSGBPalette ; Load it into the second slot as well. Prevents a minor glitch.

	ld bc,20*18
	ld hl,W2_TilesetPaletteMap
	xor a
	call FillMemory

	ld a,3
	ld [W2_StaticPaletteChanged],a
	xor a
	ld [W2_TileBasedPalettes],a

	ld a,1
	ld [W2_LastBGP],a

	;xor a
	ld [rSVBK],a
	ret

; uses PalPacket_Empty to build a packet based on the current map
; Loading a map
SetPal_Overworld:
	ld a,2
	ld [rSVBK],a
	dec a ; ld a,1
	ld [W2_TileBasedPalettes],a

	CALL_INDIRECT ClearSpritePaletteMap

	ld a,1
	ld [W2_UseOBP1],a ; Pokecenter uses OBP1 when healing pokemons

	CALL_INDIRECT LoadSpritePalettes
	; Make exclamation mark bubble black & white
	ld a, 5
	ld hl, W2_SpritePaletteMap + $f8
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a

	xor a
	ld [rSVBK],a

	CALL_INDIRECT LoadTilesetPalette

	; Wait 2 frames before updating palettes
	ld c,2
	call DelayFrames

	ld a,2
	ld [rSVBK],a

	; Signal to refresh palettes
	ld a,1
	ld [W2_LastBGP],a
	ld [W2_LastOBP0],a

	;xor a
	ld [rSVBK],a

	ld a,9
	ld [W_PALREFRESHCMD],a
	ret

; Open pokemon menu
SetPal_PartyMenu:
	ld a,2
	ld [rSVBK],a

	CALL_INDIRECT LoadSpritePalettes

	ld d,PAL_GREENBAR	; Filler for palette 0 (technically, green)
	ld e,0
	callba LoadSGBPalette
	ld d,PAL_GREENBAR
	ld e,1
	callba LoadSGBPalette
	ld d,PAL_YELLOWBAR
	ld e,2
	callba LoadSGBPalette
	ld d,PAL_REDBAR
	ld e,3
	callba LoadSGBPalette

	; Palettes were written to a SGB packet. Extract them.
	ld b,9		; there are only 6 pokemon but iterate 9 times to fill the whole screen
	ld hl,wPartyMenuBlkPacket + 9
	ld de,W2_TilesetPaletteMap
.loop
	ld a,[hl]
	and 3

	ld c,40
.loop2
	ld [de],a
	inc de
	dec c
	jr nz,.loop2

	ld a,6
	add l
	ld l,a
	dec b
	jr nz,.loop

	CALL_INDIRECT ClearSpritePaletteMap

	ld a,3
	ld [W2_StaticPaletteChanged],a
	xor a
	ld [W2_TileBasedPalettes],a

	;xor a
	ld [rSVBK],a
	ret


; used when a Pokemon is the only thing on the screen
; such as evolution, trading and the Hall of Fame
; Evolution / Hall of Fame
SetPal_PokemonWholeScreen:
	ld a, c
	dec a
	ld a, PAL_BLACK
	jr z, .loadPalette
	ld a, c
	cp 2
	ld a, PAL_MEWMON
	jr z, .loadPalette
	ld a, [wWholeScreenPaletteMonSpecies]
	; Use the "BackSprite" version for the player sprite in the hall of fame.
	call DetermineBackSpritePaletteID_NoStatusCheck

.loadPalette
	ld d,a
	ld a,2
	ld [rSVBK],a

	ld e,0
	callba LoadSGBPalette

	ld d, PAL_MEWMON
	ld e, 1
	push de
.loop
	callba LoadSGBPalette
	pop de
	ld a, e
	inc a
	ld e, a
	push de
	cp 8
	jr nz, .loop
	pop de

	ld d, PAL_MEWMON
	ld e, 0
	push de
.loop_sprites
	callba LoadSGBPalette_Sprite
	pop de
	ld a, e
	inc a
	ld e, a
	push de
	cp 8
	jr nz, .loop_sprites
	pop de

	xor a
	ld [W2_TileBasedPalettes],a
	ld hl, W2_TilesetPaletteMap
	ld bc, 20*18
	call FillMemory

	inc a ; ld a,1
	ld [W2_LastBGP],a ; Refresh palettes
	ld a,3
	ld [W2_StaticPaletteChanged],a

	xor a
	ld [rSVBK],a
	ret


; Called as the game starts up
SetPal_GameFreakIntro:
	ld a,$02
	ld [rSVBK],a

	; Load default palettes
	ld hl,MapPalettes
	ld a, BANK(MapPalettes)
	ld de,W2_BgPaletteData
	ld bc, $08
	call FarCopyData

	ld d, PAL_GAMEFREAK
	ld e,0
	callba LoadSGBPalette_Sprite

	ld d, PAL_REDMON
	ld e,1
	callba LoadSGBPalette_Sprite

	ld d, PAL_VIRIDIAN
	ld e,2
	callba LoadSGBPalette_Sprite

	ld d, PAL_BLUEMON
	ld e,3
	callba LoadSGBPalette_Sprite

	xor a
	ld [rSVBK],a
 	ret

; Trainer card
SetPal_TrainerCard:
	ld a,2
	ld [rSVBK],a
	
	ld d,PAL_MEWMON
	ld e,0
	callba LoadSGBPalette
	ld d,PAL_BADGE
	ld e,1
	callba LoadSGBPalette
	ld d,PAL_REDMON
	ld e,2
	callba LoadSGBPalette
	ld d,PAL_YELLOWMON
	ld e,3
	callba LoadSGBPalette
	; Red's palette
	IF GEN_2_GRAPHICS
		ld d, PAL_HERO
	ELSE
		ld d, PAL_REDMON
	ENDC
	ld e,4
	callba LoadSGBPalette

	; Load palette map
	ld hl, BadgePalettes
	ld a, BANK(BadgePalettes)
	ld de, W2_TilesetPaletteMap
	ld bc, $60
	call FarCopyData
	; Zero the rest
	push de
	pop hl
	ld bc, $a0
	xor a
	call FillMemory


	; Wait 2 frames before updating palettes
	ld c,2
	call DelayFrames

	ld a,1
	ld [W2_LastBGP],a ; Signal to update palettes
	ld [rSVBK],a
	ret


; Clear colors after titlescreen
PalCmd_0e:
	ld a,2
	ld [rSVBK],a

	xor a
	ld [W2_TileBasedPalettes],a
	ld a,3
	ld [W2_StaticPaletteChanged],a

	ld bc,20*18
	ld hl,W2_TilesetPaletteMap
	ld d,0
.palLoop
	ld [hl],d
	inc hl
	dec bc
	ld a,b
	or c
	jr nz,.palLoop

	xor a
	ld [rSVBK],a
	ret

; Name entry
; Deals with sprites for the pokemon naming screen
PalCmd_0f:
	ld a,2
	ld [rSVBK],a

	CALL_INDIRECT LoadSpritePalettes

	CALL_INDIRECT ClearSpritePaletteMap

	xor a
	ld [rSVBK],a
	ret


; Code for the pokemon in the titlescreen.
; There's no particular reason it needs to be in this bank.
LoadTitleMonTilesAndPalettes:
	push de
	ld b,SET_PAL_TITLE_SCREEN
	call RunPaletteCommand
	pop de
	callba TitleScroll
	ret

ResetPalettes:
	ld a,2
	ld [rSVBK],a
	dec a
	ld [W2_TileBasedPalettes],a
	dec a
	ld hl, W2_TilesetPaletteMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call FillMemory
	ld hl, W2_BgPaletteData
	ld bc, $80
	call FillMemory
	xor a
	ld [rSVBK],a
	ret

INCLUDE "color/refreshmaps.asm"
INCLUDE "color/loadpalettes.asm"
INCLUDE "color/vblank.asm"
INCLUDE "color/sprites.asm"
INCLUDE "color/badgepalettemap.asm" ; This ends up in whatever bank was used last
INCLUDE "color/super_palettes.asm"
