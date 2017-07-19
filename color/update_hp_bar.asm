; Functions relating to updating the HP bar color

; compares old HP and new HP and sets c and z flags accordingly
; HAX: this function also updates HP color.
UpdateHPBar_CompareNewHPToOldHP:
	push bc
	push de
	push hl
	call UpdateHPBar_Palettes
	pop hl
	pop de
	pop bc
	ld a, d
	sub b
	ret nz
	ld a, e
	sub c
	ret

UpdateHPBar_Palettes:
	; Store variables to be retrieved after the Bankswitch function.
	; Using Predef causes glitches, because this is called FROM a predef.
	ld a, [wLoadedMonMaxHP]
	ld d, a
	ld a, [wLoadedMonMaxHP + 1]
	ld e, a

	ld hl,wPredefRegisters + 2
	ld a,d
	ld [hli],a
	ld a,e
	ld [hli],a

	; ld wPredefRegisters + 4,bc
	ld a,b
	ld [hli],a
	ld [hl],c

	; Convert hp into another format (??)
	CALL_INDIRECT HPBarLength

	; Pass this other hp format to Func_3df9 which determines HP bar color
	ld hl, wPlayerHPBarColor
	call GetHealthBarColor

	ld a,2
	ld [rSVBK],a

	; wListMenuID = 0 for enemy hp bar, 1 for player hp bar, 2 for pokemon menu.
	ld a,[wListMenuID]
	ld c,a

	cp 2
	jr nz,.inBattle

.inMenu
	ld hl, W2_TilesetPaletteMap
	ld bc, SCREEN_WIDTH*2 ; 2 rows for each pokemon in the menu
	ld a, [wLastMenuItem]
	call AddNTimes

	ld bc, SCREEN_WIDTH*2
	ld a, [wPlayerHPBarColor] ; Palette # was stored to here
	inc a
	call FillMemory

	ld a,3
	ld [W2_StaticPaletteMapChanged],a
	jr .done

.inBattle
	ld a,[wPlayerHPBarColor] ; Palette # was stored to here
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
	ret

UpdateHPBar_Hook:
	push bc
	push de
	push hl

	ld a,[wListMenuID]
	cp 2
	jr nz,.inBattle
	
	; In the pokemon menu
	ld a, [wCurrentMenuItem]
	ld bc, wPartyMon2 - wPartyMon1
	ld hl, wPartyMon1
	call AddNTimes
	ld bc, wPartyMon1Level - wPartyMon1
	add hl,bc
	jr .gotPokemon

.inBattle
	and a
	jr nz,.playerPokemon
.enemyPokemon
	ld hl, wEnemyMonLevel
	jr .gotPokemon
.playerPokemon
	ld hl, wBattleMonLevel ; $d022
;	jr .gotPokemon

	; Load pokemon data
.gotPokemon
	ld de, wLoadedMonLevel
	ld bc, $b
	call CopyData

.gotData
	pop hl
	pop de
	pop bc
	; Animate the hp bar
	jp UpdateHPBar
