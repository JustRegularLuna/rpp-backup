; creates a set of moves that may be used and returns its address in hl
; unused slots are filled with 0, all used slots may be chosen with equal probability
AIEnemyTrainerChooseMoves:
	ld a, $20 ; for smart AI
	ld hl, wBuffer  ; init temporary move selection array. Only the moves with the lowest numbers are chosen in the end
	ld [hli], a   ; move 1
	ld [hli], a   ; move 2
	ld [hli], a   ; move 3
	ld [hl], a    ; move 4
	ld a, [wEnemyDisabledMove] ; forbid disabled move (if any)
	swap a
	and $f
	jr z, .noMoveDisabled
	ld hl, wBuffer
	dec a
	ld c, a
	ld b, $0
	add hl, bc    ; advance pointer to forbidden move
	ld [hl], $50  ; forbid (highly discourage) disabled move
.noMoveDisabled
	ld hl, TrainerClassMoveChoiceModifications
	ld a, [wTrainerAINumber]
	ld b, a
.loopTrainerClasses
	dec b
	jr z, .readTrainerClassData
.loopTrainerClassData
	ld a, [hli]
	and a
	jr nz, .loopTrainerClassData
	jr .loopTrainerClasses
.readTrainerClassData
	ld a, [hl]
	and a
	jp z, .useOriginalMoveSet
	push hl
.nextMoveChoiceModification
	pop hl
	ld a, [hli]
	and a
	jr z, .loopFindMinimumEntries
	push hl
	ld hl, AIMoveChoiceModificationFunctionPointers
	dec a
	add a
	ld c, a
	ld b, 0
	add hl, bc    ; skip to pointer
	ld a, [hli]   ; read pointer into hl
	ld h, [hl]
	ld l, a
	ld de, .nextMoveChoiceModification  ; set return address
	push de
	jp [hl]       ; execute modification function
.loopFindMinimumEntries ; all entries will be decremented sequentially until one of them is zero
	ld hl, wBuffer  ; temp move selection array
	ld de, wEnemyMonMoves  ; enemy moves
	ld c, NUM_MOVES
.loopDecrementEntries
	ld a, [de]
	inc de
	and a
	jr z, .loopFindMinimumEntries
	dec [hl]
	jr z, .minimumEntriesFound
	inc hl
	dec c
	jr z, .loopFindMinimumEntries
	jr .loopDecrementEntries
.minimumEntriesFound
	ld a, c
.loopUndoPartialIteration ; undo last (partial) loop iteration
	inc [hl]
	dec hl
	inc a
	cp NUM_MOVES + 1
	jr nz, .loopUndoPartialIteration
	ld hl, wBuffer  ; temp move selection array
	ld de, wEnemyMonMoves  ; enemy moves
	ld c, NUM_MOVES
.filterMinimalEntries ; all minimal entries now have value 1. All other slots will be disabled (move set to 0)
	ld a, [de]
	and a
	jr nz, .moveExisting
	ld [hl], a
.moveExisting
	ld a, [hl]
	dec a
	jr z, .slotWithMinimalValue
	xor a
	ld [hli], a     ; disable move slot
	jr .next
.slotWithMinimalValue
	ld a, [de]
	ld [hli], a     ; enable move slot
.next
	inc de
	dec c
	jr nz, .filterMinimalEntries
	ld hl, wBuffer    ; use created temporary array as move set
	ret
.useOriginalMoveSet
	ld hl, wEnemyMonMoves    ; use original move set
	ret

AIMoveChoiceModificationFunctionPointers:
	dw AIMoveChoiceModification1
	dw AIMoveChoiceModification2
	dw AIMoveChoiceModification3
	dw SmartAI

; discourages moves that cause no damage but only a status ailment if player's mon already has one
AIMoveChoiceModification1:
	ld a, [wBattleMonStatus]
	and a
	ret z ; return if no status ailment on player's mon
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z ; no more moves in move set
	inc de
	call ReadMove
	ld a, [wEnemyMovePower]
	and a
	jr nz, .nextMove
	ld a, [wEnemyMoveEffect]
	push hl
	push de
	push bc
	ld hl, StatusAilmentMoveEffects
	ld de, $0001
	call IsInArray
	pop bc
	pop de
	pop hl
	jr nc, .nextMove
	ld a, [hl]
	add $20 ; heavily discourage move
	ld [hl], a
	jr .nextMove

StatusAilmentMoveEffects:
	db $01 ; unused sleep effect
	db SLEEP_EFFECT
	db POISON_EFFECT
	db PARALYZE_EFFECT
	db $FF

SmartAI: ; originally by Dabomstew
; damaging move priority on turn 3+
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement
	cp $2
	jr c, .healingCheck
	ld hl, wBuffer - 1
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.damageLoop
	dec b
	jr z, .healingCheck
	inc hl
	ld a, [de]
	and a
	jr z, .healingCheck
	inc de
	call ReadMove
	ld a, [wEnemyMovePower]
	and a
	jr z, .damageLoop
; encourage by 2
	dec [hl]
	dec [hl]
	jr .damageLoop
; healing moves?
.healingCheck
	ld a, [wEnemyMonMaxHP]
	and a
	jr z, .noscale
	ld b, a
	ld a, [wEnemyMonMaxHP + 1]
	srl b
	rr a
	ld b, a
	ld a, [wEnemyMonHP]
	ld c, a
	ld a, [wEnemyMonHP + 1]
	srl c
	rr a
	ld c, a
	jr .realHealCheck
.noscale
	ld a, [wEnemyMonMaxHP + 1]
	ld b, a
	ld a, [wEnemyMonHP + 1]
	ld c, a
.realHealCheck
	srl b
	ld a, c
	cp b
	ld hl, HealingMoves
	jr nc, .debuffHealingMoves
	ld b, -8
	call Random
	ld a, [hRandomAdd]
	cp $C0 ; 3/4 chance
	jr nc, .dreamEaterCheck
	jr .applyHealingChance
.debuffHealingMoves
	ld b, 10
.applyHealingChance
	call AlterMovePriorityArray
.dreamEaterCheck
	ld a, [wBattleMonStatus]
	and SLP
	ld a, DREAM_EATER
	ld [wAIBuffer1], a
	jr z, .debuffDreamEater
	ld b, -1
	jr .applyDreamEater
.debuffDreamEater
	ld b, 20
.applyDreamEater
	call AlterMovePriority
.hexCheck ; added for Red++ to encourage Hex if opponent has a status condition
	ld a, [wBattleMonStatus]
	and a
	ld a, HEX
	ld [wAIBuffer1], a
	jr z, .debuffHex
	ld b, -1
	jr .applyHex
.debuffHex
	ld b, 2
.applyHex
	call AlterMovePriority
.electroBallCheck ; added for Red++ to encourage Electro Ball if enemy is faster
	ld de, wBattleMonSpeed
	ld hl, wEnemyMonSpeed
	ld c, $2
	call StringCmp ; see who is faster
	ld a, ELECTRO_BALL
	ld [wAIBuffer1], a
	jr nc, .debuffElectroBall
	ld b, -1 ; slightly encourage if speed matches
	jr z, .applyElectroBall
	ld b, -3 ; encourage more if faster
	jr .applyElectroBall
.debuffElectroBall
	ld b, 3 ; discourage if player is faster
.applyElectroBall
	call AlterMovePriority
.effectivenessCheck
; encourage any damaging move with SE, slightly discrouge NVE moves
	ld hl, wBuffer - 1
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.seloop
	dec b
	jr z, .selfBuffCheck
	inc hl
	ld a, [de]
	and a
	jr z, .selfBuffCheck
	inc de
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp SUPER_FANG_EFFECT
	jr z, .seloop
	cp SPECIAL_DAMAGE_EFFECT
	jr z, .seloop
	ld a, [wEnemyMovePower]
	cp 10
	jr c, .seloop
	push hl
	push bc
	push de
	callab AIGetTypeEffectiveness
	pop de
	pop bc
	pop hl
	ld a, [wd11e]
	cp $0a
	jr z, .seloop
	jr c, .nvemove
; strongly encourage SE Move
	rept 4
	dec [hl]
	endr
	cp $15
	jr c, .seloop
; even more strongly encourage 4x SE move
	rept 3
	dec [hl]
	endr
	jr .seloop
.nvemove
; slighly discourage
	inc [hl]
	and a
	jr nz, .seloop
; strongly discourage immunity
	ld a, [hl]
	add 50
	ld [hl], a
	jr .seloop
.selfBuffCheck
; 50% chance to encourage self-buff or status on turn 1/2
	ld a, [wAILayer2Encouragement]
	cp $2
	jr nc, .discourageStatusOnly
	call Random
	ld a, [hRandomAdd]
	cp $80
	jr nc, .discourageStatusOnly
	ld hl, MehStatusMoves
	ld b, -3
	call AlterMovePriorityArray
	ld hl, LightBuffStatusMoves
	ld b, -5
	call AlterMovePriorityArray
	ld hl, HeavyBuffStatusMoves
	ld b, -6
	call AlterMovePriorityArray
.discourageStatusOnly
; if enemy already has a status affliction, don't keep trying to give them one
; this *should* already be part of AIMoveChoiceModification1 but it doesn't always seem to catch them
	ld a, [wBattleMonStatus]
	and a
	ret z
	ld hl, StatusOnlyMoves
	ld b, $20
	call AlterMovePriorityArray
	ret
	
MehStatusMoves:
	db GROWL
	db DISABLE
	db MIST
	db HARDEN
	db WITHDRAW
	db DEFENSE_CURL
	db TAIL_WHIP
	db LEER
	db $FF
	
LightBuffStatusMoves:
	db FOCUS_ENERGY
	db GROWTH
	db MEDITATE
	db AGILITY
	db MINIMIZE
	db DOUBLE_TEAM
	db REFLECT
	db LIGHT_SCREEN
	db BARRIER
	db SUBSTITUTE
	db POISONPOWDER
	db STRING_SHOT
	db SCREECH
	db SMOKESCREEN
	db POISON_GAS
	db FLASH
	db HONE_CLAWS
	db SAND_ATTACK
	db $FF
	
HeavyBuffStatusMoves:
	db IRON_DEFENSE
	db SWORDS_DANCE
	db AMNESIA
	db SING
	db SLEEP_POWDER
	db HYPNOSIS
	db LOVELY_KISS
	db SPORE
	db STUN_SPORE
	db THUNDER_WAVE
	db GLARE
	db CONFUSE_RAY
	db SUPERSONIC
	db $FF
	
HealingMoves:
	db REST
	db RECOVER
	db SOFTBOILED
	db MOONLIGHT
	db $FF
	
StatusOnlyMoves:
	db SUPERSONIC
	db POISONPOWDER
	db STUN_SPORE
	db SLEEP_POWDER
	db THUNDER_WAVE
	db TOXIC
	db HYPNOSIS
	db CONFUSE_RAY
	db GLARE
	db POISON_GAS
	db LOVELY_KISS
	db SPORE
	db SING
	db $FF
	
AlterMovePriority:
; [wAIBuffer1] = move
; b = priority change
	ld hl, wBuffer - 1
	ld de, wEnemyMonMoves
	ld c, NUM_MOVES + 1
.moveLoop
	dec c
	ret z
	inc hl
	ld a, [de]
	and a
	ret z
	inc de
	push bc
	ld b, a
	ld a, [wAIBuffer1]
	cp b
	pop bc
	jr nz, .moveLoop
	ld a, [hl]
	add b
	ld [hl], a
	ret
	
AlterMovePriorityArray:
; hl = move array
; b = priority change
	ld a, h
	ld [wAIBuffer1], a
	ld a, l
	ld [wAIBuffer1 + 1], a
	ld hl, wBuffer - 1
	ld de, wEnemyMonMoves
	ld c, NUM_MOVES + 1
.moveLoop
	dec c
	ret z
	inc hl
	ld a, [de]
	and a
	ret z
	inc de
	push hl
	push de
	push bc
	ld b, a
	ld a, [wAIBuffer1]
	ld h, a
	ld a, [wAIBuffer1 + 1]
	ld l, a
	ld a, b
	ld de, $0001
	call IsInArray
	pop bc
	pop de
	pop hl
	jr nc, .moveLoop
	ld a, [hl]
	add b
	ld [hl], a
	ret

; slightly encourage moves with specific effects.
; in particular, stat-modifying moves and other move effects
; that fall in-between
AIMoveChoiceModification2:
	ld a, [wAILayer2Encouragement]
	cp $1
	ret nz
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z ; no more moves in move set
	inc de
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp ATTACK_UP1_EFFECT
	jr c, .nextMove
	cp BIDE_EFFECT
	jr c, .preferMove
	cp ATTACK_UP2_EFFECT
	jr c, .nextMove
	cp POISON_EFFECT
	jr c, .preferMove
	jr .nextMove
.preferMove
	dec [hl] ; slightly encourage this move
	jr .nextMove

; encourages moves that are effective against the player's mon (even if non-damaging).
; discourage damaging moves that are ineffective or not very effective against the player's mon,
; unless there's no damaging move that deals at least neutral damage
AIMoveChoiceModification3:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z ; no more moves in move set
	inc de
	call ReadMove
	push hl
	push bc
	push de
	callab AIGetTypeEffectiveness
	pop de
	pop bc
	pop hl
	ld a, [wTypeEffectiveness]
	cp $10
	jr z, .nextMove
	jr c, .notEffectiveMove
	dec [hl] ; slightly encourage this move
	jr .nextMove
.notEffectiveMove ; discourages non-effective moves if better moves are available
	push hl
	push de
	push bc
	ld a, [wEnemyMoveType]
	ld d, a
	ld hl, wEnemyMonMoves  ; enemy moves
	ld b, NUM_MOVES + 1
	ld c, $0
.loopMoves
	dec b
	jr z, .done
	ld a, [hli]
	and a
	jr z, .done
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp SUPER_FANG_EFFECT
	jr z, .betterMoveFound ; Super Fang is considered to be a better move
	cp SPECIAL_DAMAGE_EFFECT
	jr z, .betterMoveFound ; any special damage moves are considered to be better moves
	cp FLY_EFFECT
	jr z, .betterMoveFound ; Fly is considered to be a better move
	ld a, [wEnemyMoveType]
	cp d
	jr z, .loopMoves
	ld a, [wEnemyMovePower]
	and a
	jr nz, .betterMoveFound ; damaging moves of a different type are considered to be better moves
	jr .loopMoves
.betterMoveFound
	ld c, a
.done
	ld a, c
	pop bc
	pop de
	pop hl
	and a
	jr z, .nextMove
	inc [hl] ; slightly discourage this move
	jr .nextMove
AIMoveChoiceModification4:
	ret

ReadMove:
	push hl
	push de
	push bc
	dec a
	ld e, a
	callba _ReadMove
	pop bc
	pop de
	pop hl
	ret

; move choice modification methods that are applied for each trainer class
; 0 is sentinel value
TrainerClassMoveChoiceModifications:
IF DEF(_BLUE) ; Hard Version
	db 1,4,0  ; YOUNGSTER
	db 1,4,0  ; BUG CATCHER
	db 1,4,0  ; LASS
	db 1,4,0  ; SAILOR
	db 1,4,0  ; JR__TRAINER_M
	db 1,4,0  ; JR__TRAINER_F
	db 1,4,0  ; POKEMANIAC
	db 1,4,0  ; SUPER_NERD
	db 1,4,0  ; HIKER
	db 1,4,0  ; BIKER
	db 1,4,0  ; BURGLAR
	db 1,4,0  ; ENGINEER
	db 1,4,0  ; Couple
	db 1,4,0  ; FISHER
	db 1,4,0  ; SWIMMER
	db 1,4,0  ; CUE_BALL
	db 1,4,0  ; GAMBLER
	db 1,4,0  ; BEAUTY
	db 1,4,0  ; PSYCHIC_TR
	db 1,4,0  ; ROCKER
	db 1,4,0  ; JUGGLER
	db 1,4,0  ; TAMER
	db 1,4,0  ; BIRD_KEEPER
	db 1,4,0  ; BLACKBELT
	db 1,4,0  ; SONY1
	db 1,4,0  ; SWIMMER_F
	db 1,4,0  ; ROCKET_F
	db 1,4,0  ; SCIENTIST
	db 1,4,0  ; GIOVANNI
	db 1,4,0  ; ROCKET
	db 1,4,0  ; COOLTRAINER_M
	db 1,4,0  ; COOLTRAINER_F
	db 1,4,0  ; BRUNO
	db 1,4,0  ; BROCK
	db 1,4,0  ; MISTY
	db 1,4,0  ; LT_SURGE
	db 1,4,0  ; ERIKA
	db 1,4,0  ; KOGA
	db 1,4,0  ; BLAINE
	db 1,4,0  ; SABRINA
	db 1,4,0  ; GENTLEMAN
	db 1,4,0  ; SONY2
	db 1,4,0  ; SONY3
	db 1,4,0  ; LORELEI
	db 1,4,0  ; CHANNELER
	db 1,4,0  ; AGATHA
	db 1,4,0  ; LANCE
	db 1,4,0  ; HEX_MANIAC
	db 1,4,0  ; TRAINER
ELSE ; Normal Version
	db 0      ; YOUNGSTER
	db 1,0    ; BUG CATCHER
	db 1,0    ; LASS
	db 1,3,0  ; SAILOR
	db 1,0    ; JR_TRAINER_M
	db 1,0    ; JR_TRAINER_F
	db 1,2,3,0; POKEMANIAC
	db 1,2,0  ; SUPER_NERD
	db 1,0    ; HIKER
	db 1,0    ; BIKER
	db 1,3,0  ; BURGLAR
	db 1,0    ; ENGINEER
	db 1,0    ; Couple
	db 1,3,0  ; FISHER
	db 1,3,0  ; SWIMMER
	db 0      ; CUE_BALL
	db 1,0    ; GAMBLER
	db 1,3,0  ; BEAUTY
	db 1,2,0  ; PSYCHIC_TR
	db 1,3,0  ; ROCKER
	db 1,0    ; JUGGLER
	db 1,0    ; TAMER
	db 1,0    ; BIRD_KEEPER
	db 1,0    ; BLACKBELT
	db 1,0    ; SONY1
	db 1,3,0  ; SWIMMER_F
	db 1,2,0  ; ROCKET_F
	db 1,2,0  ; SCIENTIST
	db 1,4,0  ; GIOVANNI
	db 1,0    ; ROCKET
	db 1,3,0  ; COOLTRAINER_M
	db 1,3,0  ; COOLTRAINER_F
	db 1,4,0  ; BRUNO
	db 1,4,0  ; BROCK
	db 1,4,0  ; MISTY
	db 1,4,0  ; LT_SURGE
	db 1,4,0  ; ERIKA
	db 1,4,0  ; KOGA
	db 1,4,0  ; BLAINE
	db 1,4,0  ; SABRINA
	db 1,2,0  ; GENTLEMAN
	db 1,4,0  ; SONY2
	db 1,4,0  ; SONY3
	db 1,4,0  ; LORELEI
	db 1,0    ; CHANNELER
	db 1,4,0  ; AGATHA
	db 1,4,0  ; LANCE
	db 1,0    ; HEX_MANIAC
	db 1,4,0  ; TRAINER
ENDC

TrainerAI:
	and a
	ld a,[wIsInBattle]
	dec a
	ret z ; if not a trainer, we're done here
	ld a,[wLinkState]
	cp LINK_STATE_BATTLING
	ret z
	ld a,[wTrainerAINumber] ; what trainer class is this?
	dec a
	ld c,a
	ld b,0
	ld hl,TrainerAIPointers
	add hl,bc
	add hl,bc
	add hl,bc
	ld a,[wAICount]
	and a
	ret z ; if no AI uses left, we're done here
	inc hl
	inc a
	jr nz,.getpointer
	dec hl
	ld a,[hli]
	ld [wAICount],a
.getpointer
	ld a,[hli]
	ld h,[hl]
	ld l,a
	call Random
	jp [hl]

TrainerAIPointers:
; one entry per trainer class
; first byte, number of times (per Pokémon) it can occur
; next two bytes, pointer to AI subroutine for trainer class
IF DEF(_BLUE) ; Hard Version
	dbw 3,PotionAI ; youngster
	dbw 3,FullHealAI ; bug catcher
	dbw 3,PotionAI ; lass
	dbw 3,SwitchOutAI ; sailor
	dbw 3,BerryUserAI ; camper
	dbw 3,BerryUserAI ; picnicker
	dbw 3,SwitchOrSuperPotionAI ; pokemaniac
	dbw 3,SwitchOutAI ; super nerd
	dbw 3,BerryUserAI ; hiker
	dbw 3,XDefendAI ; biker
	dbw 3,SwitchOutAI ; burglar
	dbw 3,GuardSpecAI ; engineer
	dbw 3,BerryUserAI ; couple
	dbw 3,PotionAI ; fisherman
	dbw 3,GenericAI ; swimmer m
	dbw 3,XAttack1AI ; cue ball
	dbw 3,SwitchOutAI ; gambler
	dbw 3,SuperPotion2AI ; beauty
	dbw 3,SwitchOutAI ; psychic
	dbw 3,SwitchOutAI ; rocker
	dbw 3,SwitchOutAI ; juggler
	dbw 3,XAttack1AI ; tamer
	dbw 3,PotionAI ; bird keeper
	dbw 2,XAttack1AI ; blackbelt
	dbw 3,GenericAI ; rival 1
	dbw 3,GenericAI ; swimmer f
	dbw 1,PotionAI ; rocket f
	dbw 3,FullHealAI ; scientist
	dbw 1,HyperPotion2AI ; giovanni
	dbw 3,PotionAI ; rocket m
	dbw 2,XAttack2AI ; ace trainerm
	dbw 1,SwitchOrHyperPotionAI ; ace trainerf
	dbw 2,XDefendAI ; bruno
	dbw 5,FullHealOrPotionAI ; brock
	dbw 1,FullHealOrPotionAI ; misty
	dbw 1,XSpeedAI ; surge
	dbw 1,SuperPotion1AI ; erika
	dbw 2,XAttack2AI ; koga
	dbw 2,HyperPotionAI ; blaine
	dbw 1,HyperPotionAI ; sabrina
	dbw 3,FullHealAI ; gentleman
	dbw 1,FullHealOrPotionAI ; rival 2
	dbw 1,FullRestoreAI ; rival 3 champion
	dbw 2,SuperPotion2AI ; lorelei
	dbw 3,FullHealAI ; chandler
	dbw 2,SwitchOrSuperPotionAI ; agatha
	dbw 1,HyperPotion2AI ; lance
	dbw 3,PotionAI ; hex maniac
	dbw 3,GenericAI ; trainer (usually overwritten in trainer data)
ELSE
	dbw 3,GenericAI ; youngster
	dbw 3,GenericAI ; bug catcher
	dbw 3,GenericAI ; lass
	dbw 3,GenericAI ; sailor
	dbw 3,GenericAI ; camper
	dbw 3,GenericAI ; picnicker
	dbw 3,GenericAI ; pokemaniac
	dbw 3,GenericAI ; super nerd
	dbw 3,GenericAI ; hiker
	dbw 3,GenericAI ; biker
	dbw 3,GenericAI ; burglar
	dbw 3,GenericAI ; engineer
	dbw 3,GenericAI ; couple
	dbw 3,GenericAI ; fisherman
	dbw 3,GenericAI ; swimmer m
	dbw 3,GenericAI ; cue ball
	dbw 3,GenericAI ; gambler
	dbw 3,GenericAI ; beauty
	dbw 3,GenericAI ; psychic
	dbw 3,GenericAI ; rocker
	dbw 3,SwitchOutAI ; juggler
	dbw 3,GenericAI ; tamer
	dbw 3,GenericAI ; bird keeper
	dbw 2,XAttack1AI ; blackbelt
	dbw 3,GenericAI ; rival 1
	dbw 3,GenericAI ; swimmer f
	dbw 1,GenericAI ; rocket f
	dbw 3,GenericAI ; scientist
	dbw 1,HyperPotion2AI ; giovanni
	dbw 3,GenericAI ; rocket m
	dbw 2,XAttack2AI ; ace trainerm
	dbw 1,SwitchOrHyperPotionAI ; ace trainerf
	dbw 2,XDefendAI ; bruno
	dbw 5,FullHealAI ; brock
	dbw 1,XDefendAI ; misty
	dbw 1,XSpeedAI ; surge
	dbw 1,SuperPotion1AI ; erika
	dbw 2,XAttack2AI ; koga
	dbw 2,HyperPotionAI ; blaine
	dbw 1,HyperPotionAI ; sabrina
	dbw 3,GenericAI ; gentleman
	dbw 1,PotionAI ; rival 2
	dbw 1,FullRestoreAI ; rival 3 champion
	dbw 2,SuperPotion2AI ; lorelei
	dbw 3,GenericAI ; chandler
	dbw 2,SwitchOrSuperPotionAI ; agatha
	dbw 1,HyperPotion2AI ; lance
	dbw 3,GenericAI ; hex maniac
	dbw 3,GenericAI ; trainer (usually overwritten in trainer data)
ENDC

SwitchOutAI:
	cp $40
	ret nc
	jp AISwitchIfEnoughMons

XAttack1AI:
	cp $20
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ret nc
	jp AIUseXAttack

GuardSpecAI:
	cp $40
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ret nc
	jp AIUseGuardSpec

XAttack2AI:
	cp $40
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ret nc
	jp AIUseXAttack

SwitchOrHyperPotionAI:
	cp $40
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ccf
	ret nc ; They can't heal too early
	ld a,$A
	call AICheckIfHPBelowFraction
	jp c,AIUseHyperPotion
	ld a,5
	call AICheckIfHPBelowFraction
	ret nc
	jp AISwitchIfEnoughMons

FullHealOrPotionAI:
	cp $40
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ccf
	ret nc ; They can't heal too early
	ld a,[wEnemyMonStatus]
	and a
	jp nz, AIUseFullHeal
	ld a,5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUsePotion

FullHealAI:
	cp $40
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ccf
	ret nc ; They can't heal too early
; if his active monster has a status condition, use a full heal
	ld a,[wEnemyMonStatus]
	and a
	ret z
	jp AIUseFullHeal

XDefendAI:
	cp $40
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ret nc
	jp AIUseXDefend

XSpeedAI:
	cp $40
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ret nc
	jp AIUseXSpeed

SuperPotion1AI:
	cp $80
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ccf
	ret nc ; They can't heal too early
	ld a,$A
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseSuperPotion

SuperPotion2AI:
	cp $40
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ccf
	ret nc ; They can't heal too early
	ld a,5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseSuperPotion

HyperPotionAI:
	cp $40
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ccf
	ret nc ; They can't heal too early
	ld a,$A
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseHyperPotion

PotionAI:
	cp $20
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ccf
	ret nc ; They can't heal too early
	ld a,5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUsePotion

BerryUserAI: ; used mainly by hikers, campers, and picnickers
	cp $30
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ccf
	ret nc ; They can't heal too early
	ld a,[wEnemyMonStatus]
	and a
	jp nz, AIUseLumBerry
	ld a,5
	call AICheckIfHPBelowFraction
	jp c, AIUseSitrusBerry
	ld a,$A
	call AICheckIfHPBelowFraction
	jp c, AIUseOranBerry
	ret

FullRestoreAI:
	cp $20
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ccf
	ret nc ; They can't heal too early
	ld a,5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseFullRestore

SwitchOrSuperPotionAI:
	cp $14
	jp c,AISwitchIfEnoughMons
	cp $80
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ccf
	ret nc ; They can't heal too early
	ld a,4
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseSuperPotion

HyperPotion2AI:
	cp $80
	ret nc
	ld a, [wAILayer2Encouragement] ; wAILayer2Encouragement (How many turns has it been out?)
	cp 2
	ccf
	ret nc ; They can't heal too early
	ld a,5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseHyperPotion

GenericAI:
	and a ; clear carry
	ret

; end of individual trainer AI routines

DecrementAICount:
	ld hl,wAICount
	dec [hl]
	scf
	ret

AIPlayRestoringSFX:
	ld a,SFX_HEAL_AILMENT
	jp PlaySoundWaitForCurrent

AIUseFullRestore:
	call AICureStatus
	ld a,FULL_RESTORE
	ld [wAIItem],a
	ld de,wHPBarOldHP
	ld hl,wEnemyMonHP + 1
	ld a,[hld]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	inc de
	ld hl,wEnemyMonMaxHP + 1
	ld a,[hld]
	ld [de],a
	inc de
	ld [wHPBarMaxHP],a
	ld [wEnemyMonHP + 1],a
	ld a,[hl]
	ld [de],a
	ld [wHPBarMaxHP+1],a
	ld [wEnemyMonHP],a
	jr AIPrintItemUseAndUpdateHPBar

AIUseOranBerry:
; enemy trainer heals monster with Oran Berry
	ld a,ORAN_BERRY
	ld b,10
	jr AIRecoverHP

AIUsePotion:
; enemy trainer heals his monster with a potion
	ld a,POTION
	ld b,20
	jr AIRecoverHP

AIUseSitrusBerry:
; enemy trainer heals monster with Sitrus Berry
	ld a,SITRUS_BERRY
	ld b,30
	jr AIRecoverHP

AIUseSuperPotion:
; enemy trainer heals his monster with a super potion
	ld a,SUPER_POTION
	ld b,50
	jr AIRecoverHP

AIUseHyperPotion:
; enemy trainer heals his monster with a hyper potion
	ld a,HYPER_POTION
	ld b,200
	; fallthrough

AIRecoverHP:
; heal b HP and print "trainer used $(a) on pokemon!"
	ld [wAIItem],a
	ld hl,wEnemyMonHP + 1
	ld a,[hl]
	ld [wHPBarOldHP],a
	add b
	ld [hld],a
	ld [wHPBarNewHP],a
	ld a,[hl]
	ld [wHPBarOldHP+1],a
	ld [wHPBarNewHP+1],a
	jr nc,.next
	inc a
	ld [hl],a
	ld [wHPBarNewHP+1],a
.next
	inc hl
	ld a,[hld]
	ld b,a
	ld de,wEnemyMonMaxHP + 1
	ld a,[de]
	dec de
	ld [wHPBarMaxHP],a
	sub b
	ld a,[hli]
	ld b,a
	ld a,[de]
	ld [wHPBarMaxHP+1],a
	sbc b
	jr nc,AIPrintItemUseAndUpdateHPBar
	inc de
	ld a,[de]
	dec de
	ld [hld],a
	ld [wHPBarNewHP],a
	ld a,[de]
	ld [hl],a
	ld [wHPBarNewHP+1],a
	; fallthrough

AIPrintItemUseAndUpdateHPBar:
	call AIPrintItemUse_
	coord hl, 2, 2
	xor a
	ld [wHPBarType],a
	predef UpdateHPBar_Hook
	jp DecrementAICount

AISwitchIfEnoughMons:
; enemy trainer switches if there are 3 or more unfainted mons in party
	ld a,[wEnemyPartyCount]
	ld c,a
	ld hl,wEnemyMon1HP

	ld d,0 ; keep count of unfainted monsters

	; count how many monsters haven't fainted yet
.loop
	ld a,[hli]
	ld b,a
	ld a,[hld]
	or b
	jr z,.Fainted ; has monster fainted?
	inc d
.Fainted
	push bc
	ld bc, wEnemyMon2 - wEnemyMon1
	add hl,bc
	pop bc
	dec c
	jr nz,.loop

	ld a,d ; how many available monsters are there?
	cp 2 ; don't bother if only 1 or 2
	jp nc,SwitchEnemyMon
	and a
	ret

SwitchEnemyMon:

; prepare to withdraw the active monster: copy hp, number, and status to roster

	ld a,[wEnemyMonPartyPos]
	ld hl,wEnemyMon1HP
	ld bc,wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld d,h
	ld e,l
	ld hl,wEnemyMonHP
	ld bc,4
	call CopyData

	ld hl, AIBattleWithdrawText
	call PrintText

	; This wFirstMonsNotOutYet variable is abused to prevent the player from
	; switching in a new mon in response to this switch.
	ld a,1
	ld [wFirstMonsNotOutYet],a
	callab EnemySendOut
	xor a
	ld [wFirstMonsNotOutYet],a

	ld a,[wLinkState]
	cp LINK_STATE_BATTLING
	ret z
	scf
	ret

AIBattleWithdrawText:
	TX_FAR _AIBattleWithdrawText
	db "@"

AIUseFullHeal:
	call AIPlayRestoringSFX
	call AICureStatus
	ld a,FULL_HEAL
	jp AIPrintItemUse
	
AIUseLumBerry:
	call AIPlayRestoringSFX
	call AICureStatus
	ld a,LUM_BERRY
	jp AIPrintItemUse

AICureStatus:
; cures the status of enemy's active pokemon
	ld a,[wEnemyMonPartyPos]
	ld hl,wEnemyMon1Status
	ld bc,wEnemyMon2 - wEnemyMon1
	call AddNTimes
	xor a
	ld [hl],a ; clear status in enemy team roster
	ld [wEnemyMonStatus],a ; clear status of active enemy
	ld hl,wEnemyBattleStatus3
	res 0,[hl]
	ret

AIUseXAccuracy: ; unused
	call AIPlayRestoringSFX
	ld hl,wEnemyBattleStatus2
	set 0,[hl]
	ld a,X_ACCURACY
	jp AIPrintItemUse

AIUseGuardSpec:
	call AIPlayRestoringSFX
	ld hl,wEnemyBattleStatus2
	set 1,[hl]
	ld a,GUARD_SPEC
	jp AIPrintItemUse

AIUseDireHit: ; unused
	call AIPlayRestoringSFX
	ld hl,wEnemyBattleStatus2
	set 2,[hl]
	ld a,DIRE_HIT
	jp AIPrintItemUse

AICheckIfHPBelowFraction:
; return carry if enemy trainer's current HP is below 1 / a of the maximum
	ld [H_DIVISOR],a
	ld hl,wEnemyMonMaxHP
	ld a,[hli]
	ld [H_DIVIDEND],a
	ld a,[hl]
	ld [H_DIVIDEND + 1],a
	ld b,2
	call Divide
	ld a,[H_QUOTIENT + 3]
	ld c,a
	ld a,[H_QUOTIENT + 2]
	ld b,a
	ld hl,wEnemyMonHP + 1
	ld a,[hld]
	ld e,a
	ld a,[hl]
	ld d,a
	ld a,d
	sub b
	ret nz
	ld a,e
	sub c
	ret

AIUseXAttack:
	ld b,$A
	ld a,X_ATTACK
	jr AIIncreaseStat

AIUseXDefend:
	ld b,$B
	ld a,X_DEFEND
	jr AIIncreaseStat

AIUseXSpeed:
	ld b,$C
	ld a,X_SPEED
	jr AIIncreaseStat

AIUseXSpecial:
	ld b,$D
	ld a,X_SPECIAL
	; fallthrough

AIIncreaseStat:
	ld [wAIItem],a
	push bc
	call AIPrintItemUse_
	pop bc
	ld hl,wEnemyMoveEffect
	ld a,[hld]
	push af
	ld a,[hl]
	push af
	push hl
	ld a,ANIM_AF
	ld [hli],a
	ld [hl],b
	callab StatModifierUpEffect
	pop hl
	pop af
	ld [hli],a
	pop af
	ld [hl],a
	jp DecrementAICount

AIPrintItemUse:
	ld [wAIItem],a
	call AIPrintItemUse_
	jp DecrementAICount

AIPrintItemUse_:
; print "x used [wAIItem] on z!"
	ld a,[wAIItem]
	ld [wd11e],a
	call GetItemName
	ld hl, AIBattleUseItemText
	jp PrintText

AIBattleUseItemText:
	TX_FAR _AIBattleUseItemText
	db "@"
