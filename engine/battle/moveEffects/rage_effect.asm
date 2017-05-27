; this function raises the attack modifier of a pokemon using Rage when that pokemon is attacked
HandleBuildingRage_: ; 3e2b6 (f:62b6)
; values for the player turn
	ld hl,wEnemyBattleStatus2
	ld de,wEnemyMonStatMods
	ld bc,wEnemyMoveNum
	ld a,[H_WHOSETURN]
	and a
	jr z,.next
; values for the enemy turn
	ld hl,wPlayerBattleStatus2
	ld de,wPlayerMonStatMods
	ld bc,wPlayerMoveNum
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
