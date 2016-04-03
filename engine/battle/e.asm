; does nothing since no stats are ever selected (barring glitches)
DoubleSelectedStats: ; 39680 (e:5680)
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerStatsToDouble]
	ld hl, wBattleMonAttack + 1
	jr z, .notEnemyTurn
	ld a, [wEnemyStatsToDouble]
	ld hl, wEnemyMonAttack + 1
.notEnemyTurn
	ld c, 4
	ld b, a
.loop
	srl b
	call c, .doubleStat
	inc hl
	inc hl
	dec c
	ret z
	jr .loop

.doubleStat
	ld a, [hl]
	add a
	ld [hld], a
	ld a, [hl]
	rl a
	ld [hli], a
	ret

; does nothing since no stats are ever selected (barring glitches)
HalveSelectedStats: ; 396a7 (e:56a7)
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerStatsToHalve]
	ld hl, wBattleMonAttack
	jr z, .notEnemyTurn
	ld a, [wEnemyStatsToHalve]
	ld hl, wEnemyMonAttack
.notEnemyTurn
	ld c, 4
	ld b, a
.loop
	srl b
	call c, .halveStat
	inc hl
	inc hl
	dec c
	ret z
	jr .loop

.halveStat
	ld a, [hl]
	srl a
	ld [hli], a
	rr [hl]
	or [hl]
	jr nz, .nonzeroStat
	ld [hl], 1
.nonzeroStat
	dec hl
	ret

_ScrollTrainerPicAfterBattle: ; 396d3 (e:56d3)
; Load the enemy trainer's pic and scrolls it into
; the screen from the right.
	xor a
	ld [wEnemyMonSpecies2], a
	ld b, $1
	call GoPAL_SET
	callab _LoadTrainerPic
	hlCoord 19, 0
	ld c, $0
.scrollLoop
	inc c
	ld a, c
	cp 7
	ret z
	ld d, $0
	push bc
	push hl
.drawTrainerPicLoop
	call DrawTrainerPicColumn
	inc hl
	ld a, 7
	add d
	ld d, a
	dec c
	jr nz, .drawTrainerPicLoop
	ld c, 4
	call DelayFrames
	pop hl
	pop bc
	dec hl
	jr .scrollLoop

; write one 7-tile column of the trainer pic to the tilemap
DrawTrainerPicColumn: ; 39707 (e:5707)
	push hl
	push de
	push bc
	ld e, 7
.loop
	ld [hl], d
	ld bc, SCREEN_WIDTH
	add hl, bc
	inc d
	dec e
	jr nz, .loop
	pop bc
	pop de
	pop hl
	ret

; creates a set of moves that may be used and returns its address in hl
; unused slots are filled with 0, all used slots may be chosen with equal probability
AIEnemyTrainerChooseMoves: ; 39719 (e:5719)
	ld a, $14 ; for smart AI
	ld hl, wHPBarMaxHP  ; init temporary move selection array. Only the moves with the lowest numbers are chosen in the end
	ld [hli], a   ; move 1
	ld [hli], a   ; move 2
	ld [hli], a   ; move 3
	ld [hl], a    ; move 4
	ld a, [W_ENEMYDISABLEDMOVE] ; forbid disabled move (if any)
	swap a
	and $f
	jr z, .noMoveDisabled
	ld hl, wHPBarMaxHP
	dec a
	ld c, a
	ld b, $0
	add hl, bc    ; advance pointer to forbidden move
	ld [hl], $50  ; forbid (highly discourage) disabled move
.noMoveDisabled
	ld hl, TrainerClassMoveChoiceModifications ; 589B
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
	ld hl, AIMoveChoiceModificationFunctionPointers ; $57a3
	dec a
	add a
	ld c, a
	ld b, $0
	add hl, bc    ; skip to pointer
	ld a, [hli]   ; read pointer into hl
	ld h, [hl]
	ld l, a
	ld de, .nextMoveChoiceModification  ; set return address
	push de
	jp [hl]       ; execute modification function
.loopFindMinimumEntries ; all entries will be decremented sequentially until one of them is zero
	ld hl, wHPBarMaxHP  ; temp move selection array
	ld de, wEnemyMonMoves  ; enemy moves
	ld c, $4
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
	cp $5
	jr nz, .loopUndoPartialIteration
	ld hl, wHPBarMaxHP  ; temp move selection array
	ld de, wEnemyMonMoves  ; enemy moves
	ld c, $4
.filterMinimalEntries ; all minimal entries now have value 1. All other slots will be disabled (move set to 0)
	ld a, [de]
	and a
	jr nz, .moveExisting ; 0x3978a $1
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
	ld hl, wHPBarMaxHP    ; use created temporary array as move set
	ret
.useOriginalMoveSet
	ld hl, wEnemyMonMoves    ; use original move set
	ret

AIMoveChoiceModificationFunctionPointers: ; 397a3 (e:57a3)
	dw AIMoveChoiceModification1
	dw AIMoveChoiceModification2
	dw AIMoveChoiceModification3
	dw SmartAI

; discourages moves that cause no damage but only a status ailment if player's mon already has one
AIMoveChoiceModification1: ; 397ab (e:57ab)
	ld a, [wBattleMonStatus]
	and a
	ret z       ; return if no status ailment on player's mon
	ld hl, wBuffer - 1  ; temp move selection array (-1 byte offest)
	ld de, wEnemyMonMoves  ; enemy moves
	ld b, $5
.nextMove
	dec b
	ret z         ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z         ; no more moves in move set
	inc de
	call ReadMove
	ld a, [W_ENEMYMOVEPOWER]
	and a
	jr nz, .nextMove
	ld a, [W_ENEMYMOVEEFFECT]
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
	add $20       ; discourage move
	ld [hl], a
	jr .nextMove

StatusAilmentMoveEffects ; 57e2
	db $01 ; some sleep effect?
	db SLEEP_EFFECT
	db POISON_EFFECT
	db PARALYZE_EFFECT
	db $FF

SmartAI: ; originally by Dabomstew
; damaging move priority on turn 3+
	ld a, [wccd5] ; wAILayer2Encouragement
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
	ld a, [W_ENEMYMOVEPOWER]
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
	ld [W_AIBUFFER1], a
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
	ld [W_AIBUFFER1], a
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
	ld [W_AIBUFFER1], a
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
	ld a, [W_ENEMYMOVEEFFECT]
	cp SUPER_FANG_EFFECT
	jr z, .seloop
	cp SPECIAL_DAMAGE_EFFECT
	jr z, .seloop
	ld a, [W_ENEMYMOVEPOWER]
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
	ld a, [wccd5]
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
	ld a, [wBattleMonStatus]
	and a
	ret z
	ld hl, StatusOnlyMoves
	ld b, 20
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
	db SHARPEN
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
	db $FF
	
AlterMovePriority:
; [W_AIBUFFER1] = move
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
	ld a, [W_AIBUFFER1]
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
	ld [W_AIBUFFER1], a
	ld a, l
	ld [W_AIBUFFER1 + 1], a
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
	ld a, [W_AIBUFFER1]
	ld h, a
	ld a, [W_AIBUFFER1 + 1]
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

; slightly encourage moves with specific effects
AIMoveChoiceModification2: ; 397e7 (e:57e7)
	ld a, [wccd5]
	cp $1
	ret nz
	ld hl, wBuffer - 1  ; temp move selection array (-1 byte offest)
	ld de, wEnemyMonMoves  ; enemy moves
	ld b, $5
.nextMove
	dec b
	ret z         ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z         ; no more moves in move set
	inc de
	call ReadMove
	ld a, [W_ENEMYMOVEEFFECT]
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
	dec [hl]       ; slighly encourage this move
	jr .nextMove

; encourages moves that are effective against the player's mon
AIMoveChoiceModification3: ; 39817 (e:5817)
	ld hl, wBuffer - 1  ; temp move selection array (-1 byte offest)
	ld de, wEnemyMonMoves  ; enemy moves
	ld b, $5
.nextMove
	dec b
	ret z         ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z         ; no more moves in move set
	inc de
	call ReadMove
	push hl
	push bc
	push de
	callab AIGetTypeEffectiveness
	pop de
	pop bc
	pop hl
	ld a, [wd11e]
	cp $10
	jr z, .nextMove
	jr c, .notEffectiveMove
	dec [hl]       ; slighly encourage this move
	jr .nextMove
.notEffectiveMove  ; discourages non-effective moves if better moves are available
	push hl
	push de
	push bc
	ld a, [W_ENEMYMOVETYPE]
	ld d, a
	ld hl, wEnemyMonMoves  ; enemy moves
	ld b, $5
	ld c, $0
.loopMoves
	dec b
	jr z, .done
	ld a, [hli]
	and a
	jr z, .done
	call ReadMove
	ld a, [W_ENEMYMOVEEFFECT]
	cp SUPER_FANG_EFFECT
	jr z, .betterMoveFound      ; Super Fang is considered to be a better move
	cp SPECIAL_DAMAGE_EFFECT
	jr z, .betterMoveFound      ; any special damage moves are considered to be better moves
	cp FLY_EFFECT
	jr z, .betterMoveFound      ; Fly is considered to be a better move
	ld a, [W_ENEMYMOVETYPE]
	cp d
	jr z, .loopMoves
	ld a, [W_ENEMYMOVEPOWER]
	and a
	jr nz, .betterMoveFound      ; damaging moves of a different type are considered to be better moves
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
	inc [hl]       ; slighly discourage this move
	jr .nextMove
AIMoveChoiceModification4: ; 39883 (e:5883)
	ret

ReadMove: ; 39884 (e:5884)
	push hl
	push de
	push bc
	dec a
	ld hl,Moves
	ld bc,6
	call AddNTimes
	ld de,W_ENEMYMOVENUM
	call CopyData
	pop bc
	pop de
	pop hl
	ret

; move choice modification methods that are applied for each trainer class
; 0 is sentinel value
TrainerClassMoveChoiceModifications: ; 3989b (e:589b)
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
	db 1,4,0  ; LT__SURGE
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
	db 1,0    ; JR__TRAINER_M
	db 1,0    ; JR__TRAINER_F
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
	db 1,4,0  ; LT__SURGE
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

TrainerPicAndMoneyPointers: ; 39914 (e:5914)
; trainer pic pointers and base money.
; money received after battle = base money × level of highest-level enemy mon
;	dw YoungsterPic
	money 1500

;	dw BugCatcherPic
	money 1000

;	dw LassPic
	money 1500

;	dw SailorPic
	money 3000

;	dw JrTrainerMPic
	money 2000

;	dw JrTrainerFPic
	money 2000

;	dw PokemaniacPic
	money 5000

;	dw SuperNerdPic
	money 2500

;	dw HikerPic
	money 3500

;	dw BikerPic
	money 2000

;	dw BurglarPic
	money 9000

;	dw EngineerPic
	money 5000

;	dw YoungCouplePic
	money 3500

;	dw FisherPic
	money 3500

;	dw SwimmerPic
	money 500

;	dw CueBallPic
	money 2500

;	dw GamblerPic
	money 7000

;	dw BeautyPic
	money 7000

;	dw PsychicPic
	money 1000

;	dw RockerPic
	money 2500

;	dw JugglerPic
	money 3500

;	dw TamerPic
	money 4000

;	dw BirdKeeperPic
	money 2500

;	dw BlackbeltPic
	money 2500

;	dw Rival1Pic
	money 3500

;	dw SwimmerFPic
	money 500

;	dw RocketFPic
	money 3000

;	dw ScientistPic
	money 5000

;	dw GiovanniPic
	money 9900

;	dw RocketPic
	money 3000

;	dw CooltrainerMPic
	money 3500

;	dw CooltrainerFPic
	money 3500

;	dw BrunoPic
	money 9900

;	dw BrockPic
	money 9900

;	dw MistyPic
	money 9900

;	dw LtSurgePic
	money 9900

;	dw ErikaPic
	money 9900

;	dw KogaPic
	money 9900

;	dw BlainePic
	money 9900

;	dw SabrinaPic
	money 9900

;	dw GentlemanPic
	money 7000

;	dw Rival2Pic
	money 6500

;	dw Rival3Pic
	money 9900

;	dw LoreleiPic
	money 9900

;	dw ChannelerPic
	money 3000

;	dw AgathaPic
	money 9900

;	dw LancePic
	money 9900
    
 ;   dw HexManiacPic
    money 5000
	
;	dw TrainerPic
	money 5000

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

TrainerAI: ; 3a52e (e:652e)
;XXX called at 34964, 3c342, 3c398
	and a
	ld a,[W_ISINBATTLE]
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

TrainerAIPointers: ; 3a55c (e:655c)
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
	dbw 1,GuardSpecAI ; giovanni
	dbw 3,PotionAI ; rocket m
	dbw 2,XAttack2AI ; ace trainerm
	dbw 1,SwitchOrHyperPotionAI ; ace trainerf
	dbw 2,XDefendAI ; bruno
	dbw 5,FullHealOrPotionAI ; brock
	dbw 1,FullHealOrPotionAI ; misty
	dbw 1,XSpeedAI ; surge
	dbw 1,SuperPotion1AI ; erika
	dbw 2,XAttack2AI ; koga
	dbw 2,SuperPotion2AI ; blaine
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
	dbw 1,GuardSpecAI ; giovanni
	dbw 3,GenericAI ; rocket m
	dbw 2,XAttack2AI ; ace trainerm
	dbw 1,SwitchOrHyperPotionAI ; ace trainerf
	dbw 2,XDefendAI ; bruno
	dbw 5,FullHealAI ; brock
	dbw 1,XDefendAI ; misty
	dbw 1,XSpeedAI ; surge
	dbw 1,SuperPotion1AI ; erika
	dbw 2,XAttack2AI ; koga
	dbw 2,SuperPotion2AI ; blaine
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

SwitchOutAI: ; 3a5e9 (e:65e9)
	cp $40
	ret nc
	jp AISwitchIfEnoughMons

XAttack1AI: ; 3a5ef (e:65ef)
	cp $20
	ret nc
	jp AIUseXAttack

GuardSpecAI: ; 3a5f5 (e:65f5)
	cp $40
	ret nc
	jp AIUseGuardSpec

XAttack2AI: ; 3a5fb (e:65fb)
	cp $40
	ret nc
	jp AIUseXAttack

SwitchOrHyperPotionAI: ; 3a601 (e:6601)
	cp $40
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
	ld a,[wEnemyMonStatus]
	and a
	jp nz, AIUseFullHeal
	ld a,5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUsePotion

FullHealAI: ; 3a614 (e:6614)
; if his active monster has a status condition, use a full heal
	ld a,[wEnemyMonStatus]
	and a
	ret z
	jp AIUseFullHeal

XDefendAI: ; 3a61c (e:661c)
	cp $40
	ret nc
	jp AIUseXDefend

XSpeedAI: ; 3a622 (e:6622)
	cp $40
	ret nc
	jp AIUseXSpeed

SuperPotion1AI: ; 3a628 (e:6628)
	cp $80
	ret nc
	ld a,$A
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseSuperPotion

SuperPotion2AI: ; 3a63a (e:663a)
	cp $40
	ret nc
	ld a,5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseSuperPotion

HyperPotionAI: ; 3a640 (e:6640)
	cp $40
	ret nc
	ld a,$A
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseHyperPotion

PotionAI: ; 3a64c (e:664c)
	cp $20
	ret nc
	ld a,5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUsePotion

BerryUserAI: ; used mainly by hikers, campers, and picnickers
	cp $30
	ret nc
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

FullRestoreAI: ; 3a658 (e:6658)
	cp $20
	ret nc
	ld a,5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseFullRestore

SwitchOrSuperPotionAI: ; 3a676 (e:6676)
	cp $14
	jp c,AISwitchIfEnoughMons
	cp $80
	ret nc
	ld a,4
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseSuperPotion

HyperPotion2AI: ; 3a687 (e:6687)
	cp $80
	ret nc
	ld a,5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseHyperPotion

GenericAI: ; 3a693 (e:6693)
	and a ; clear carry
	ret

; end of individual trainer AI routines

DecrementAICount: ; 3a695 (e:6695)
	ld hl,wAICount
	dec [hl]
	scf
	ret

Func_3a69b: ; 3a69b (e:669b)
	ld a,(SFX_08_3e - SFX_Headers_08) / 3
	jp PlaySoundWaitForCurrent

AIUseFullRestore: ; 3a6a0 (e:66a0)
	call AICureStatus
	ld a,FULL_RESTORE
	ld [wcf05],a
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

AIUsePotion: ; 3a6ca (e:66ca)
; enemy trainer heals his monster with a potion
	ld a,POTION
	ld b,20
	jr AIRecoverHP

AIUseSitrusBerry:
; enemy trainer heals monster with Sitrus Berry
	ld a,SITRUS_BERRY
	ld b,30
	jr AIRecoverHP

AIUseSuperPotion: ; 3a6d0 (e:66d0)
; enemy trainer heals his monster with a super potion
	ld a,SUPER_POTION
	ld b,50
	jr AIRecoverHP

AIUseHyperPotion: ; 3a6d6 (e:66d6)
; enemy trainer heals his monster with a hyper potion
	ld a,HYPER_POTION
	ld b,200
	; fallthrough

AIRecoverHP: ; 3a6da (e:66da)
; heal b HP and print "trainer used $(a) on pokemon!"
	ld [wcf05],a
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

AIPrintItemUseAndUpdateHPBar: ; 3a718 (e:6718)
	call AIPrintItemUse_
	hlCoord 2, 2
	xor a
	ld [wHPBarType],a
	predef UpdateHPBar2
	jp DecrementAICount

AISwitchIfEnoughMons: ; 3a72a (e:672a)
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
	ld bc,$2C
	add hl,bc
	pop bc
	dec c
	jr nz,.loop

	ld a,d ; how many available monsters are there?
	cp 2 ; don't bother if only 1 or 2
	jp nc,SwitchEnemyMon
	and a
	ret

SwitchEnemyMon: ; 3a74b (e:674b)

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

	ld a,1
	ld [wd11d],a
	callab EnemySendOut
	xor a
	ld [wd11d],a

	ld a,[wLinkState]
	cp LINK_STATE_BATTLING
	ret z
	scf
	ret

AIBattleWithdrawText: ; 3a781 (e:6781)
	TX_FAR _AIBattleWithdrawText
	db "@"

AIUseFullHeal: ; 3a786 (e:6786)
	call Func_3a69b
	call AICureStatus
	ld a,FULL_HEAL
	jp AIPrintItemUse
	
AIUseLumBerry: ; 3a786 (e:6786)
	call Func_3a69b
	call AICureStatus
	ld a,LUM_BERRY
	jp AIPrintItemUse

AICureStatus: ; 3a791 (e:6791)
; cures the status of enemy's active pokemon
	ld a,[wEnemyMonPartyPos]
	ld hl,wEnemyMon1Status
	ld bc,wEnemyMon2 - wEnemyMon1
	call AddNTimes
	xor a
	ld [hl],a ; clear status in enemy team roster
	ld [wEnemyMonStatus],a ; clear status of active enemy
	ld hl,W_ENEMYBATTSTATUS3
	res 0,[hl]
	ret

AIUseXAccuracy: ; 0x3a7a8 unused
	call Func_3a69b
	ld hl,W_ENEMYBATTSTATUS2
	set 0,[hl]
	ld a,X_ACCURACY
	jp AIPrintItemUse

AIUseGuardSpec: ; 3a7b5 (e:67b5)
	call Func_3a69b
	ld hl,W_ENEMYBATTSTATUS2
	set 1,[hl]
	ld a,GUARD_SPEC_
	jp AIPrintItemUse

AIUseDireHit: ; 0x3a7c2 unused
	call Func_3a69b
	ld hl,W_ENEMYBATTSTATUS2
	set 2,[hl]
	ld a,DIRE_HIT
	jp AIPrintItemUse

AICheckIfHPBelowFraction: ; 3a7cf (e:67cf)
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

AIUseXAttack: ; 3a7f2 (e:67f2)
	ld b,$A
	ld a,X_ATTACK
	jr AIIncreaseStat

AIUseXDefend: ; 3a7f8 (e:67f8)
	ld b,$B
	ld a,X_DEFEND
	jr AIIncreaseStat

AIUseXSpeed: ; 3a7fe (e:67fe)
	ld b,$C
	ld a,X_SPEED
	jr AIIncreaseStat

AIUseXSpecial: ; 3a804 (e:6804)
	ld b,$D
	ld a,X_SPECIAL
	; fallthrough

AIIncreaseStat: ; 3a808 (e:6808)
	ld [wcf05],a
	push bc
	call AIPrintItemUse_
	pop bc
	ld hl,W_ENEMYMOVEEFFECT
	ld a,[hld]
	push af
	ld a,[hl]
	push af
	push hl
	ld a,$AF
	ld [hli],a
	ld [hl],b
	callab StatModifierUpEffect
	pop hl
	pop af
	ld [hli],a
	pop af
	ld [hl],a
	jp DecrementAICount

AIPrintItemUse: ; 3a82c (e:682c)
	ld [wcf05],a
	call AIPrintItemUse_
	jp DecrementAICount

AIPrintItemUse_: ; 3a835 (e:6835)
; print "x used [wcf05] on z!"
	ld a,[wcf05]
	ld [wd11e],a
	call GetItemName
	ld hl, AIBattleUseItemText
	jp PrintText

AIBattleUseItemText: ; 3a844 (e:6844)
	TX_FAR _AIBattleUseItemText
	db "@"

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
