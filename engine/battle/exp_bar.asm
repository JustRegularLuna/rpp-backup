AnimateEXPBarAgain:
	call LoadMonData
	call IsCurrentMonBattleMon
	ret nz
	xor a
	ld [wEXPBarPixelLength], a
	coord hl, 17, 11
	ld a, $c0
	ld c, $08
.loop
	ld [hld], a
	dec c
	jr nz, .loop
AnimateEXPBar:
	call LoadMonData
	call IsCurrentMonBattleMon
	ret nz
	ld a, [wBattleMonLevel]
	cp 100
	ret z
	ld a, SFX_HEAL_HP
	call PlaySoundWaitForCurrent
	callab CalcEXPBarPixelLength
	ld hl, wEXPBarPixelLength
	ld a, [hl]
	ld b, a
	ld a, [H_QUOTIENT + 3]
	ld [hl], a
	sub b
	jr z, .done
	ld b, a
	ld c, $08
	coord hl, 17, 11
.loop1
	ld a, [hl]
	cp $c8
	jr nz, .loop2
	dec hl
	dec c
	jr z, .done
	jr .loop1
.loop2
	inc a
	ld [hl], a
	call DelayFrame
	dec b
	jr z, .done
	jr .loop1
.done
	ld bc, $08
	coord hl, 10, 11
	ld de, wTileMapBackup + 10 + 11 * 20
	call CopyData
	ld c, $20
	jp DelayFrames

KeepEXPBarFull:
	call IsCurrentMonBattleMon
	ret nz
	ld a, [wEXPBarKeepFullFlag]
	set 0, a
	ld [wEXPBarKeepFullFlag], a
	ld a, [wCurEnemyLVL]
	ret

IsCurrentMonBattleMon:
	ld a, [wPlayerMonNumber]
	ld b, a
	ld a, [wWhichPokemon]
	cp b
	ret
