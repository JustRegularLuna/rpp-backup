SECTION "bank1C_extension",ROMX,BANK[$1C]

; Set all palettes to black at beginning of battle
SendPalPacket_Black:
	; Code $ff sometimes calls this (by accident?)
	inc b
	ret z

	ld a,$02
	ld [rSVBK],a

	ld d,$1e	; Black palette
	ld e,7
.palLoop	; Set all bg and sprite palettes to SGB Palette $1e
	push de
	call LoadSGBPalette
	pop de
	push de
	call LoadSGBPalette_Sprite
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
BuildBattlePalPacket:
 	ld a, [W_PLAYERBATTSTATUS3]
	ld hl, wBattleMonSpecies        ; player Pokemon ID
	call DetermineBackSpritePaletteID
	ld b, a

	ld a, [W_ENEMYBATTSTATUS3]
	ld hl, wEnemyMonSpecies2         ; enemy Pokemon ID
	call DeterminePaletteID
	ld c, a

	ld a,$02
	ld [rSVBK],a

	; Player palette
	push bc
	ld d,b
	ld e,0
	call LoadSGBPalette

	; Enemy palette
	pop bc
	ld d,c
	ld e,1
	call LoadSGBPalette

	; Player lifebar
	ld a, [$cf1d]
	add $1f
	ld d,a
	ld e,2
	call LoadSGBPalette

	; Enemy lifebar
	ld a, [$cf1e]
	add $1f
	ld d,a
	ld e,3
	call LoadSGBPalette

	; Black palette
	ld d, PAL_BLACK
	ld e,4
	call LoadSGBPalette

	; Restore sprite palettes which may have been set to black
	CALL_INDIRECT LoadSpritePalettes


	; Now set the tilemap

	xor a
	ld [W2_TileBasedPalettes],a	; Use a direct color map instead of assigning colors to tiles
	ld a,3
	ld [W2_StaticPaletteChanged],a

	; Top half; enemy lifebar
	ld hl,$d200
	ld d,3
	ld bc,20*6
.eFillLoop
	ld [hl],d
	inc hl
	dec bc
	ld a,b
	or c
	jr nz,.eFillLoop

	; Bottom half; player lifebar
	ld hl,$d200+6*20
	ld d,2
	ld bc,20*12
.pFillLoop
	ld [hl],d
	inc hl
	dec bc
	ld a,b
	or c
	jr nz,.pFillLoop

	; Player pokemon
	ld hl,$d200+4*20
	ld de,20-9
	ld b,8
	ld a,0
.pDrawLine
	ld c,9
.pPalLoop
	ld [hli],a
	dec c
	jr nz,.pPalLoop
	add hl,de
	dec b
	jr nz,.pDrawLine

	; Enemy pokemon
	ld hl,$d200 + 11
	ld de,20-9
	ld b,7
	ld a,1
.eDrawLine
	ld c,9
.ePalLoop
	ld [hli],a
	dec c
	jr nz,.ePalLoop
	add hl,de
	dec b
	jr nz,.eDrawLine

	; Wait 2 frames before updating palettes
	ld c,2
	call DelayFrames

	ld a,1
	ld [W2_UseOBP1],a
	ld [W2_LastBGP],a
	ld [W2_LastOBP0],a	; Palettes must be redrawn
	ld [rSVBK],a

	;ld a,$01
	ld [W_PALREFRESHCMD],a
	ret

; Load town map
SendPalPacket_TownMap:
	ld a,2
	ld [rSVBK],a

	ld d, PAL_TOWNMAP
	ld e,0
	call LoadSGBPalette

	ld d, PAL_TOWNMAP2
	ld e,1
	call LoadSGBPalette

	ld a,1
	ld [W2_TileBasedPalettes],a

	ld hl,$d200
	ld bc, $100
	xor a
	call FillMemory

	; Give tile $65 a different color
	ld hl,$d265
	ld [hl], 1

	xor a
	ld [rSVBK],a
	ret

; Status screen
BuildStatusScreenPalPacket:
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
	ld a, [wcf25]
	add $1f
	ld d,a
	ld e,1
	call LoadSGBPalette	

	; Load pokemon palette
	pop af
	ld d,a
	ld e,0
	call LoadSGBPalette


	; Set palette map
	xor a
	ld [W2_TileBasedPalettes],a
	ld a,3
	ld [W2_StaticPaletteChanged],a

	; Set everything to the lifebar palette
	ld hl,$d200
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
	ld hl,$d200
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

	xor a
	ld [rSVBK],a
	ret

; Show pokedex data
SendPalPacket_Pokedex:
	ld a, [wcf91]
	call DeterminePaletteIDOutOfBattle	; Call DeterminePaletteID without status check
	ld d,a
	ld e,0

	ld a,2
	ld [rSVBK],a

	call LoadSGBPalette

IF _BLUE
	ld d,$11	; PAL_BLUEMON
ELSE
	ld d,$12	; PAL_REDMON
ENDC
	ld e,1
	call LoadSGBPalette

	ld bc,20*18
	ld hl,$d200
	ld d,1
.palLoop
	ld [hl],d
	inc hl
	dec bc
	ld a,b
	or c
	jr nz,.palLoop

	ld hl,$d201+20
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
SendPalPacket_Slots:
	ld a,2
	ld [rSVBK],a

	ld d, PAL_SLOTS1
	ld e, 0
	call LoadSGBPalette
	ld d, PAL_SLOTS2
	ld e, 1
	call LoadSGBPalette
	ld d, PAL_SLOTS3
	ld e, 2
	call LoadSGBPalette
	ld d, PAL_SLOTS4
	ld e, 3
	call LoadSGBPalette
	ld d, PAL_SLOTS5
	ld e, 4
	call LoadSGBPalette

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
SendPalPacket_Titlescreen:
	ld a,[wWhichTrade] ; Get the pokemon on the screen
	call DeterminePaletteIDOutOfBattle
	ld d,a
	ld e,0

	ld a,2
	ld [rSVBK],a

	call LoadSGBPalette

	ld d,$e	; Title logo
	ld e,1
	call LoadSGBPalette

	ld d, PAL_LOGO1
	ld e,2
	call LoadSGBPalette

	ld d, PAL_BLACK
	ld e,3
	call LoadSGBPalette

	CALL_INDIRECT LoadSpritePalettes

	; Pokemon logo
	ld hl,$d200
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

	ld hl, $d200 + 17*20
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
SendPalPacket_NidorinoIntro:
	ld a,2
	ld [rSVBK],a

	ld d, PAL_PURPLEMON
	ld e,0
	call LoadSGBPalette_Sprite

	ld a,1
	ld [W2_LastOBP0],a
	xor a
	ld [rSVBK],a
	ret

; used mostly for menus and the Oak intro
; Pokedex screen
SendPalPacket_Generic:
	ld a,2
	ld [rSVBK],a

	ld d,$21	; Red lifebar color (for pokeballs)
	ld e,0
	push de
	call LoadSGBPalette
	pop de
	inc e
	call LoadSGBPalette ; Load it into the second slot as well. Prevents a minor glitch.

	ld bc,20*18
	ld hl,$d200
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
BuildOverworldPalPacket:
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
SendPalPacket_PartyMenu:
	ld a,2
	ld [rSVBK],a

	CALL_INDIRECT LoadSpritePalettes

	ld d,$1f	; Filler for palette 0 (technically, green)
	ld e,0
	call LoadSGBPalette
	ld d,$1f	; Green
	ld e,1
	call LoadSGBPalette
	ld d,$20	; Yellow
	ld e,2
	call LoadSGBPalette
	ld d,$21	; Red
	ld e,3
	call LoadSGBPalette

	; Palettes were written to a SGB packet. Extract them.
	ld b,9		; there are only 6 pokemon but iterate 9 times to fill the whole screen
	ld hl,$cf37
	ld de,$d200
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
SendPokemonPalette_WholeScreen:
	ld a, c
	and a
	ld a, $1e ; Black palette
	jr nz, .loadPalette
	ld a, [$cf1d]
	; Use the "BackSprite" version for the player sprite in the hall of fame.
	call DetermineBackSpritePaletteID_NoStatusCheck

.loadPalette
	ld d,a
	ld a,2
	ld [rSVBK],a

	ld e,0
	call LoadSGBPalette

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
SendPalPacket_GameFreakIntro:
	ld a,$02
	ld [rSVBK],a

	; Load default palettes
	ld hl,MapPalettes
	ld a, BANK(MapPalettes)
	ld de,W2_BgPaletteData
	ld bc, $08
	call FarCopyData

	CALL_INDIRECT LoadSpritePalettes

	xor a
	ld [rSVBK],a
 	ret

; Trainer card
BuildTrainerCardPalPacket:
	ld a,2
	ld [rSVBK],a
	
	ld d,$10
	ld e,0
	call LoadSGBPalette
	ld d,$22
	ld e,1
	call LoadSGBPalette
	ld d,$12
	ld e,2
	call LoadSGBPalette
	ld d,$18
	ld e,3
	call LoadSGBPalette
	; Red's palette
	IF GEN_2_GRAPHICS
		ld d, $84
	ELSE
		ld d, PAL_REDMON
	ENDC
	ld e,4
	call LoadSGBPalette

	; Load palette map
	ld hl, BadgePalettes
	ld a, BANK(BadgePalettes)
	ld de, $d200
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
	ld hl,$d200
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
	ld b,6
	call GoPAL_SET
	pop de
	ld b, BANK(TitleScroll)
	ld hl, TitleScroll
	call Bankswitch ; indirect jump to TitleScroll (37258 (d:7258))
	ret

INCLUDE "color/refreshmaps.asm"
INCLUDE "color/loadpalettes.asm"
INCLUDE "color/vblank.asm"
INCLUDE "color/sprites.asm"
INCLUDE "color/badgepalettemap.asm" ; This ends up in whatever bank was used last

SECTION "bank30",ROMX,BANK[$30]
INCBIN "color/bank30.bin",$0000,$c4000-$c0000


SECTION "bank31",ROMX,BANK[$31]
INCBIN "color/bank31.bin",$0000,$c8000-$c4000
