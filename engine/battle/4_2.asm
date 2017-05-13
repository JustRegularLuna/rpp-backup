RecoilEffect_: ; 1392c (4:792c)
	ld a, [H_WHOSETURN]
	and a
	ld a, [W_PLAYERMOVENUM]
	ld hl, wBattleMonMaxHP
	jr z, .asm_1393d
	ld a, [W_ENEMYMOVENUM]
	ld hl, wEnemyMonMaxHP
.asm_1393d
	ld d, a
	ld a, [W_DAMAGE]
	ld b, a
	ld a, [W_DAMAGE + 1]
	ld c, a
	srl b
	rr c
	ld a, d
	cp STRUGGLE
	jr z, .asm_13953
	srl b
	rr c
.asm_13953
	ld a, b
	or c
	jr nz, .asm_13958
	inc c
.asm_13958
	ld a, [hli]
	ld [wHPBarMaxHP+1], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	push bc
	ld bc, $fff2
	add hl, bc
	pop bc
	ld a, [hl]
	ld [wHPBarOldHP], a
	sub c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	sbc b
	ld [hl], a
	ld [wHPBarNewHP+1], a
	jr nc, .asm_13982
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wHPBarNewHP
	ld [hli], a
	ld [hl], a
.asm_13982
	coord hl, 10, 9
	ld a, [H_WHOSETURN]
	and a
	ld a, $1
	jr z, .asm_13990
	coord hl, 2, 2
	xor a
.asm_13990
	ld [wHPBarType], a
	predef UpdateHPBar2
	ld hl, HitWithRecoilText
	jp PrintText
HitWithRecoilText: ; 1399e (4:799e)
	TX_FAR _HitWithRecoilText
	db "@"

ConversionEffect_: ; 139a3 (4:79a3)
	ld hl, wEnemyMonType1
	ld de, wBattleMonType1
	ld a, [H_WHOSETURN]
	and a
	ld a, [W_ENEMYBATTSTATUS1]
	jr z, .asm_139b8
	push hl
	ld h, d
	ld l, e
	pop de
	ld a, [W_PLAYERBATTSTATUS1]
.asm_139b8
	bit Invulnerable, a ; is mon immune to typical attacks (dig/fly)
	jr nz, PrintButItFailedText
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld hl, PlayCurrentMoveAnimation
	call CallBankF
	ld hl, ConvertedTypeText
	jp PrintText

ConvertedTypeText: ; 139cd (4:79cd)
	TX_FAR _ConvertedTypeText
	db "@"

PrintButItFailedText: ; 139d2 (4:79d2)
	ld hl, PrintButItFailedText_
CallBankF: ; 139d5 (4:79d5)
	ld b, BANK(PrintButItFailedText_)
	jp Bankswitch

HazeEffect_: ; 139da (4:79da)
	ld a, $7
	ld hl, wPlayerMonAttackMod
	call ResetStatMods
	ld hl, wEnemyMonAttackMod
	call ResetStatMods
	ld hl, wPlayerMonUnmodifiedAttack
	ld de, wBattleMonAttack
	call ResetStats
	ld hl, wEnemyMonUnmodifiedAttack
	ld de, wEnemyMonAttack
	call ResetStats
	ld hl, wEnemyMonStatus
	ld de, wEnemySelectedMove
	ld a, [H_WHOSETURN]
	and a
	jr z, .asm_13a09
	ld hl, wBattleMonStatus
	dec de

.asm_13a09
	ld a, [hl]
	ld [hl], $0
	and $27
	jr z, .asm_13a13
	ld a, $ff
	ld [de], a

.asm_13a13
	xor a
	ld [W_PLAYERDISABLEDMOVE], a
	ld [W_ENEMYDISABLEDMOVE], a
	ld hl, wccee
	ld [hli], a
	ld [hl], a
	ld hl, W_PLAYERBATTSTATUS1
	call CureStatuses
	ld hl, W_ENEMYBATTSTATUS1
	call CureStatuses
	ld hl, PlayCurrentMoveAnimation
	call CallBankF
	ld hl, StatusChangesEliminatedText
	jp PrintText

CureStatuses: ; 13a37 (4:7a37)
	res Confused, [hl]
	inc hl ; BATTSTATUS2
	ld a, [hl]
	and (1 << UsingRage) | (1 << NeedsToRecharge) | (1 << HasSubstituteUp) | (1 << 3) ; clear all but these from BATTSTATUS2
	ld [hli], a ; BATTSTATUS3
	ld a, [hl]
	and %11110000 | (1 << Transformed) ; clear Bad Poison, Reflect and Light Screen statuses
	ld [hl], a
	ret

ResetStatMods: ; 13a43 (4:7a43)
	ld b, $8
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

ResetStats: ; 13a4a (4:7a4a)
	ld b, $8
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ret

StatusChangesEliminatedText: ; 13a53 (4:7a53)
	TX_FAR _StatusChangesEliminatedText
	db "@"
