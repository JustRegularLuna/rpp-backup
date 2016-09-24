ReadTrainer: ; 39c53 (e:5c53)

; don't change any moves in a link battle
	ld a,[wLinkState]
	and a
	ret nz

; set [wEnemyPartyCount] to 0, [wEnemyPartyMons] to FF
; XXX first is total enemy pokemon?
; XXX second is species of first pokemon?
	ld hl,wEnemyPartyCount
	xor a
	ld [hli],a
	dec a
	ld [hl],a

; get the pointer to trainer data for this class
	ld a, [W_TRAINERCLASS]
	dec a
	add a,a
	ld hl,TrainerDataPointers
	ld c,a
	ld b,0
	add hl,bc ; hl points to trainer class
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[W_TRAINERNO]
	ld b,a
; At this point b contains the trainer number,
; and hl points to the trainer class.
; Our next task is to iterate through the trainers,
; decrementing b each time, until we get to the right one.
.outer
	dec b
	jr z,.IterateTrainer
.inner
	ld a,[hli]
	cp $FF
	jr nz,.inner
	jr .outer

; if the first byte of trainer data is FF,
; - each pokemon has a specific level
;      (as opposed to the whole team being of the same level)
; - if [W_LONEATTACKNO] != 0, one pokemon on the team has a special move
; else the first byte is the level of every pokemon on the team
.IterateTrainer
	call SetCustomName
	ld a,[hli]
	cp SPECIAL_TRAINER ; is the trainer special?
	jr z,.SpecialTrainer ; if so, check for special moves
	cp SPECIAL_TRAINER2 ; is this an extra-special trainer?
	jr z,.SpecialTrainer2 ; if so, read the Pic and AI numbers
	cp CUSTOM_PIC ; is this a custom-pic-only trainer?
	jr z,.PicOnly ; if so, read the pic
	cp SPECIAL_LEVELS ; custom levels only?
	jr z, .SpecialLevelsOnly
.GenericTrainer ; else, it's a generic trainer
	ld [W_CURENEMYLVL],a
.LoopTrainerData
	ld a,[hli]
	cp $FF ; have we reached the end of the trainer data?
	jr z,.FinishUp
	ld [wcf91],a ; write species somewhere (XXX why?)
	ld a,1
	ld [wcc49],a
	push hl
	call AddPartyMon
	pop hl
	jr .LoopTrainerData
	
.PicOnly
	ld a,[hli] ; get pic ID
	ld [wTrainerPicID], a
	ld a, [hli] ; get the level for that team's Pokemon
	jr .GenericTrainer
	
.SpecialTrainer2
	ld a, [hli] ; get pic ID
	ld [wTrainerPicID], a
	ld a, [hli] ; get AI ID
	ld [wTrainerAINumber], a
	; fallthrough to normal "SpecialTrainer" behaviour
.SpecialTrainer
; if this code is being run:
; - each pokemon has a specific level
; - each pokemon has a custom moveset
	ld a,[hli]
	cp $FF ; have we reached the end of the trainer data?
	jr z,.FinishUp
	ld [W_CURENEMYLVL],a
	ld a,[hli]
	ld [wcf91],a
	ld a,1
	ld [wcc49],a
	push hl
	call AddPartyMon
	pop hl
	call AddCustomMoves
	jr .SpecialTrainer
.SpecialLevelsOnly
; if this code is being run:
; - each pokemon has a specific level
; - just uses default moves for each mon like a normal trainer
	ld a,[hli]
	cp $FF ; have we reached the end of the trainer data?
	jr z,.FinishUp
	ld [W_CURENEMYLVL],a
	ld a,[hli]
	ld [wcf91],a
	ld a,1
	ld [wcc49],a
	push hl
	call AddPartyMon
	pop hl
	jr .SpecialLevelsOnly
.FinishUp ; XXX this needs documenting
	xor a       ; clear D079-D07B
	ld de,wd079
	ld [de],a
	inc de
	ld [de],a
	inc de
	ld [de],a
	ld a,[W_CURENEMYLVL]
	ld b,a
.LastLoop
	ld hl,wd047
	ld c,2
	push bc
	predef AddBCDPredef
	pop bc
	inc de
	inc de
	dec b
	jr nz,.LastLoop
	ret
; Original R/B Routine removed
; Custom routine to add moves stored after each Pokemon/Level combo
AddCustomMoves:
	push hl
	ld a, [wEnemyPartyCount] ; which mon is this?
	dec a
	ld hl, wEnemyMon1Moves
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld d, h
	ld e, l ; de now holds this mon's moves
	pop hl ; get our spot back in the party data
	ld b, NUM_MOVES
.addMoveLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .addMoveLoop
	ret

GetTrainerMonDVs:: ; called from engine/battle/core.asm
; returns trainer's DVs in wTempDVs
	push hl
	
	call GetUniqueTrainerDVs
	jr z, .done
	
	ld a, [wTrainerAINumber]
	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerClassDVs
	add hl, bc
	add hl, bc
	ld de, wTempDVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
.done
	pop hl
	ret

GetUniqueTrainerDVs:
; returns z, and unique DVs in wTempDVs if DVs are unique
; adapted from Polished Crystal
	ld hl, UniqueDVTrainerPokemon
.loop
	ld a, [hli] ; TrainerClass
	cp -1
	jr z, .notunique
	ld b, a
	ld a, [W_TRAINERCLASS]
	cp b
	jr nz, .inc5andloop
	ld a, [hli] ; TrainerID
	ld b, a
	ld a, [W_TRAINERNO]
	cp b
	jr nz, .inc4andloop
	ld a, [hli] ; PartySpecies
	ld b, a
	ld a, [wd0b5] ; should always be mon's species, when called from AddPartyMon or LoadEnemyMonData
	cp b
	jr nz, .inc3andloop
	ld a, [hli] ; Level
	ld b, a
	ld a, [W_CURENEMYLVL]
	cp b
	jr nz, .inc2andloop
.unique
	ld de, wTempDVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	xor a
	and a
	ret
.inc5andloop
	inc hl
.inc4andloop
	inc hl
.inc3andloop
	inc hl
.inc2andloop
	inc hl
	inc hl
	jp .loop
.notunique
	ld a, 1
	and a
	ret

IF DEF(_BLUE) ; Difficult rom
	INCLUDE "data/trainer_dvs_hard.asm"
	INCLUDE "data/unique_trainer_dvs_hard.asm"
	INCLUDE "data/trainer_parties_hard.asm"
ELSE ; Normal rom
	INCLUDE "data/trainer_dvs.asm"
	INCLUDE "data/unique_trainer_dvs.asm"
	INCLUDE "data/trainer_parties.asm"
ENDC
