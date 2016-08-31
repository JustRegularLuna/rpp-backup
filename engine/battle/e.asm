INCLUDE "text/trainer_names.asm"

; formats a string at wMovesString that lists the moves at wMoves
FormatMovesString: ; 39b87 (e:5b87)
	ld hl, wMoves
	ld de, wMovesString
	ld b, $0
.printMoveNameLoop
	ld a, [hli]
	and a ; end of move list?
	jr z, .printDashLoop ; print dashes when no moves are left
	push hl
	ld [wd0b5], a
	ld a, BANK(MoveNames)
	ld [wPredefBank], a
	ld a, MOVE_NAME
	ld [wNameListType], a
	call GetName
	ld hl, wcd6d
.copyNameLoop
	ld a, [hli]
	cp $50
	jr z, .doneCopyingName
	ld [de], a
	inc de
	jr .copyNameLoop
.doneCopyingName
	ld a, b
	ld [wcd6c], a
	inc b
	ld a, $4e ; line break
	ld [de], a
	inc de
	pop hl
	ld a, b
	cp NUM_MOVES
	jr z, .done
	jr .printMoveNameLoop
.printDashLoop
	ld a, "-"
	ld [de], a
	inc de
	inc b
	ld a, b
	cp NUM_MOVES
	jr z, .done
	ld a, $4e ; line break
	ld [de], a
	inc de
	jr .printDashLoop
.done
	ld a, "@"
	ld [de], a
	ret

; XXX this is called in a few places, but it doesn't appear to do anything useful
Func_39bd5: ; 39bd5 (e:5bd5)
	ld a, [wd11b]
	cp $1
	jr nz, .asm_39be6
	ld hl, wEnemyPartyCount
	ld de, wEnemyMonOT
	ld a, ENEMYOT_NAME
	jr .asm_39c18
.asm_39be6
	cp $4
	jr nz, .calcAttackStat4
	ld hl, wPartyCount
	ld de, wPartyMonOT
	ld a, PLAYEROT_NAME
	jr .asm_39c18
.calcAttackStat4
	cp $5
	jr nz, .asm_39c02
	ld hl, wStringBuffer2 + 11
	ld de, MonsterNames
	ld a, MONSTER_NAME
	jr .asm_39c18
.asm_39c02
	cp $2
	jr nz, .asm_39c10
	ld hl, wNumBagItems
	ld de, ItemNames
	ld a, ITEM_NAME
	jr .asm_39c18
.asm_39c10
	ld hl, wStringBuffer2 + 11
	ld de, ItemNames
	ld a, ITEM_NAME
.asm_39c18
	ld [wNameListType], a
	ld a, l
	ld [wList], a
	ld a, h
	ld [wList + 1], a
	ld a, e
	ld [wcf8d], a
	ld a, d
	ld [wcf8e], a
	ld bc, ItemPrices
	ld a, c
	ld [wItemPrices], a
	ld a, b
	ld [wItemPrices + 1], a
	ret

; get species of mon e in list [wcc49] for LoadMonData
GetMonSpecies: ; 39c37 (e:5c37)
	ld hl, wPartySpecies
	ld a, [wcc49]
	and a
	jr z, .getSpecies
	dec a
	jr z, .enemyParty
	ld hl, wBoxSpecies
	jr .getSpecies
.enemyParty
	ld hl, wEnemyPartyMons
.getSpecies
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wcf91], a
	ret

DrawAllPokeballs: ; 3a849 (e:6849)
	call LoadPartyPokeballGfx
	call SetupOwnPartyPokeballs
	ld a, [W_ISINBATTLE] ; W_ISINBATTLE
	dec a
	ret z ; return if wild pokémon
	jp SetupEnemyPartyPokeballs

DrawEnemyPokeballs: ; 0x3a857
	call LoadPartyPokeballGfx
	jp SetupEnemyPartyPokeballs

LoadPartyPokeballGfx: ; 3a85d (e:685d)
	ld de, PokeballTileGraphics ; $697e
	ld hl, vSprites + $310
	ld bc, (BANK(PokeballTileGraphics) << 8) + $04
	jp CopyVideoData

SetupOwnPartyPokeballs: ; 3a869 (e:6869)
	call PlacePlayerHUDTiles
	ld hl, wPartyMon1
	ld de, wPartyCount ; wPartyCount
	call SetupPokeballs
	ld a, $60
	ld hl, W_BASECOORDX ; wd081
	ld [hli], a
	ld [hl], a
	ld a, $8
	ld [wTrainerEngageDistance], a
	ld hl, wOAMBuffer
	jp WritePokeballOAMData

SetupEnemyPartyPokeballs: ; 3a887 (e:6887)
	call PlaceEnemyHUDTiles
	ld hl, wEnemyMons
	ld de, wEnemyPartyCount ; wEnemyPartyCount
	call SetupPokeballs
	ld hl, W_BASECOORDX ; wd081
	ld a, $48
	ld [hli], a
	ld [hl], $20
	ld a, $f8
	ld [wTrainerEngageDistance], a
	ld hl, wOAMBuffer + PARTY_LENGTH * 4
	jp WritePokeballOAMData

SetupPokeballs: ; 0x3a8a6
	ld a, [de]
	push af
	ld de, wBuffer
	ld c, PARTY_LENGTH
	ld a, $34 ; empty pokeball
.emptyloop
	ld [de], a
	inc de
	dec c
	jr nz, .emptyloop
	pop af
	ld de, wBuffer
.monloop
	push af
	call PickPokeball
	inc de
	pop af
	dec a
	jr nz, .monloop
	ret

PickPokeball: ; 3a8c2 (e:68c2)
	inc hl
	ld a, [hli]
	and a
	jr nz, .alive
	ld a, [hl]
	and a
	ld b, $33 ; crossed ball (fainted)
	jr z, .done_fainted
.alive
	inc hl
	inc hl
	ld a, [hl] ; status
	and a
	ld b, $32 ; black ball (status)
	jr nz, .done
	dec b ; regular ball
	jr .done
.done_fainted
	inc hl
	inc hl
.done
	ld a, b
	ld [de], a
	ld bc, $0028 ; rest of mon struct
	add hl, bc
	ret

WritePokeballOAMData: ; 3a8e1 (e:68e1)
	ld de, wBuffer
	ld c, PARTY_LENGTH
.loop
	ld a, [W_BASECOORDY] ; wd082
	ld [hli], a
	ld a, [W_BASECOORDX] ; wd081
	ld [hli], a
	ld a, [de]
	ld [hli], a
	xor a
	ld [hli], a
	ld a, [W_BASECOORDX] ; wd081
	ld b, a
	ld a, [wTrainerEngageDistance]
	add b
	ld [W_BASECOORDX], a ; wd081
	inc de
	dec c
	jr nz, .loop
	ret

PlacePlayerHUDTiles: ; 3a902 (e:6902)
	ld hl, PlayerBattleHUDGraphicsTiles ; $6916
	ld de, wTrainerFacingDirection
	ld bc, $3
	call CopyData
	hlCoord 18, 10
	ld de, rIE ; $ffff
	jr PlaceHUDTiles

PlayerBattleHUDGraphicsTiles: ; 3a916 (e:6916)
; The tile numbers for specific parts of the battle display for the player's pokemon
	db $73 ; unused ($73 is hardcoded into the routine that uses these bytes)
	db $77 ; lower-right corner tile of the HUD
	db $6F ; lower-left triangle tile of the HUD

PlaceEnemyHUDTiles: ; 3a919 (e:6919)
	ld hl, EnemyBattleHUDGraphicsTiles ; $692d
	ld de, wTrainerFacingDirection
	ld bc, $3
	call CopyData
	hlCoord 1, 2
	ld de, $1
	jp EnemyHealthBarUpdated
	jr PlaceHUDTiles

EnemyBattleHUDGraphicsTiles: ; 3a92d (e:692d)
; The tile numbers for specific parts of the battle display for the enemy
	db $73 ; unused ($73 is hardcoded in the routine that uses these bytes)
	db $74 ; lower-left corner tile of the HUD
	db $78 ; lower-right triangle tile of the HUD

PlaceHUDTiles: ; 3a930 (e:6930)
	ld [hl], $73
HealthBarUpdateDone:	
	ld bc, $14
	add hl, bc
	ld a, [wTrainerScreenY]
	ld [hl], a
	ld a, $8
.asm_3a93c
	add hl, de
	ld [hl], $76
	dec a
	jr nz, .asm_3a93c
	add hl, de
	ld a, [wTrainerScreenX]
	ld [hl], a
	ret

SetupPlayerAndEnemyPokeballs: ; 3a948 (e:6948)
	call LoadPartyPokeballGfx
	ld hl, wPartyMon1Species ; wPartyMon1Species (aliases: wPartyMon1)
	ld de, wPartyCount ; wPartyCount
	call SetupPokeballs
	ld hl, W_BASECOORDX ; wd081
	ld a, $50
	ld [hli], a
	ld [hl], $40
	ld a, $8
	ld [wTrainerEngageDistance], a
	ld hl, wOAMBuffer
	call WritePokeballOAMData
	ld hl, wEnemyMons ; wEnemyMon1Species
	ld de, wEnemyPartyCount ; wEnemyPartyCount
	call SetupPokeballs
	ld hl, W_BASECOORDX ; wd081
	ld a, $50
	ld [hli], a
	ld [hl], $68
	ld hl, wOAMBuffer + $18
	jp WritePokeballOAMData

; four tiles: pokeball, black pokeball (status ailment), crossed out pokeball (faited) and pokeball slot (no mon)
PokeballTileGraphics:: ; 3a97e (e:697e)
	INCBIN "gfx/pokeball.2bpp"

; this function raises the attack modifier of a pokemon using Rage when that pokemon is attacked
HandleBuildingRage_: ; 3e2b6 (f:62b6)
; values for the player turn
	ld hl,W_ENEMYBATTSTATUS2
	ld de,wEnemyMonStatMods
	ld bc,W_ENEMYMOVENUM
	ld a,[H_WHOSETURN]
	and a
	jr z,.next
; values for the enemy turn
	ld hl,W_PLAYERBATTSTATUS2
	ld de,wPlayerMonStatMods
	ld bc,W_PLAYERMOVENUM
.next
	bit UsingRage,[hl] ; is the pokemon being attacked under the effect of Rage?
	ret z ; return if not
	ld a,[de]
	cp a,$0d ; maximum stat modifier value
	ret z ; return if attack modifier is already maxed
	ld a,[H_WHOSETURN]
	xor a,$01 ; flip turn for the stat modifier raising function
	ld [H_WHOSETURN],a
; temporarily change the target pokemon's move to $00 and the effect to the one
; that causes the attack modifier to go up one stage
	ld h,b
	ld l,c
	ld [hl],$00 ; null move number
	inc hl
	ld [hl],ATTACK_UP1_EFFECT
	push hl
	ld hl,BuildingRageText
	call PrintText
	callab StatModifierUpEffect ; stat modifier raising function
	pop hl
	xor a
	ldd [hl],a ; null move effect
	ld a,RAGE
	ld [hl],a ; restore the target pokemon's move number to Rage
	ld a,[H_WHOSETURN]
	xor a,$01 ; flip turn back to the way it was
	ld [H_WHOSETURN],a
	ret

BuildingRageText: ; 3e2f8 (f:62f8)
	TX_FAR _BuildingRageText
	db "@"
