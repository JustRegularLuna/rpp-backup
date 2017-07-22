; Called from "UpdateHPBar_AnimateHPBar" in "engine/hp_bar.asm" when healthbars are
; moving. Applies to battles and the party screen, probably won't work on status screen.
;
; d: length of bar (tiles)
; e: # pixels to fill
; hl: where to draw
DrawHPBarWithColor
	call DrawHPBar
	push bc
	push de
	push hl

	; Set hl to point to appropriate color var
	ld a, [wHPBarType]
	or a
	ld hl, wEnemyHPBarColor
	jr z,.gotHPBarColorVar
	dec a
	ld hl, wPlayerHPBarColor
	jr z,.gotHPBarColorVar

	; Party menu
	ld hl, wPartyMenuHPBarColors
	ld b, 0
	ld a, [wCurrentMenuItem]
	ld c, a
	add hl, bc

.gotHPBarColorVar
	call GetHealthBarColor ; Reads value of 'e' (bar length) to determine color

	ld a,2
	ld [rSVBK],a

	; wHPBarType = 0 for enemy hp bar, 1 for player hp bar, 2 for pokemon menu.
	ld a,[wHPBarType]
	ld c,a

	cp 2
	jr nz,.inBattle

.inMenu
	ld a, [hl]
	push af
	ld hl, W2_TilesetPaletteMap
	ld bc, SCREEN_WIDTH*2 ; 2 rows for each pokemon in the menu
	ld a, [wCurrentMenuItem]
	call AddNTimes

	ld bc, SCREEN_WIDTH*2
	pop af ; Get palette #
	inc a
	call FillMemory

	ld a,3
	ld [W2_StaticPaletteMapChanged],a
	jr .done

.inBattle
	ld a,[hl] ; Palette # was stored to here
	add PAL_GREENBAR
	ld d,a

	ld a,c
	and a ; Check: enemy or player
	ld e,2
	jr nz,.loadPalette
	inc e
.loadPalette
	CALL_INDIRECT LoadSGBPalette

.done
	ld a,1
	ld [W2_ForceBGPUpdate],a

	xor a
	ld [rSVBK],a

	pop hl
	pop de
	pop bc
	ret
