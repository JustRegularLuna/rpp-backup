; Handles Move Tutor functionality
; Costs ¥500, the same as the Move Relearner
; To make a person a tutor, have their Text Pointer point to a structure like this example

;ExamplePersonScript:
;	db 8 ;TX_ASM
;	ld a, Move Tutor Number
;	ld [wWhichTrade], a
;	callba MoveTutorScript
;	jp TextScriptEnd

MoveTutorScriptSpecial::
; This code is for the NPC who teaches Signature Moves to fully evolved starters 
; Handles choosing Frenzy Plant, Hydro Cannon, or Blast Burn, then teaching the move
	call SaveScreenTilesToBuffer2
	call EnableAutoTextBoxDrawing
	ld hl,MoveTutorWelcomeText
	call PrintText

	; display the menu to choose which move to learn
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld a, $3
	ld [wMenuWatchedKeys], a
	ld a, $3
	ld [wMaxMenuItem], a
	ld a, $5
	ld [wTopMenuItemY], a
	ld a, $1
	ld [wTopMenuItemX], a
	ld hl, wd730
	set 6, [hl]
	coord hl, 0, 3
	ld b, $8
	ld c, $d
	call TextBoxBorder
	call UpdateSprites
	coord hl, 2, 5
	ld de, ElementalHyperbeamsText
	call PlaceString
	ld hl, wd730
	res 6, [hl]
	call HandleMenuInput
	bit 1, a
	jr nz, .done
	ld a, [wCurrentMenuItem]
	cp $3
	jr z, .done

	; convert wCurrentMenuItem to a Move Tutor ID and continue
	inc a
	jr DisplayTeachTutorMoveText

.done
	ld hl,MoveTutorComeAgainText
	jp PrintText


MoveTutorScript::
; This is used by all other Move Tutors, who only teach one move
	call SaveScreenTilesToBuffer2
	call EnableAutoTextBoxDrawing
	ld hl,MoveTutorWelcomeText
	call PrintText
	ld a,[wWhichTrade] ; which move tutor is this?
	; fallthrough

DisplayTeachTutorMoveText:
	ld [wd11e],a
	callba TutorToMove
	ld a,[wd11e]
	ld [wMoveNum],a
	call GetMoveName
	call CopyStringToCF4B ; copy name to wcf4b
	ld hl,TeachTutorMoveText
	call PrintText
	coord hl, 14, 7
	ld bc,$080f
	ld a,TWO_OPTION_MENU
	ld [wTextBoxID],a
	call DisplayTextBoxID ; yes/no menu
	ld a,[wCurrentMenuItem]
	and a
	jr z,.checkMoney
	; chose no
	ld hl,MoveTutorComeAgainText
	jp PrintText
	
.checkMoney ; If you said yes, Make sure you have money
	xor a
	ldh [$9f], a
	ldh [$a1], a
	ld a, 5
	ldh [$a0], a  ; 500 money
	call HasEnoughMoney
	jr nc, .chooseMon ; Go ahead if you have enough
	
	; not enough money
	ld hl, MoveTutorNotEnoughMoneyText
	jp PrintText

.chooseMon
	ld hl,wcf4b
	ld de,wd036
	ld bc,14
	call CopyData
	xor a
	ld [wUpdateSpritesEnabled],a
	ld a,$06 ; move tutor party menu
	ld [wPartyMenuTypeOrMessageID],a
	call DisplayPartyMenu
	push af
	ld hl,wd036
	ld de,wcf4b
	ld bc,14
	call CopyData
	pop af
	jr nc,.checkIfAbleToLearnMove
; if the player canceled teaching the move
	jr .done
	
.checkIfAbleToLearnMove
	callba CanLearnTutor ; check if the pokemon can learn the move
	ld a,[wWhichPokemon]
	ld hl,wPartyMonNicks
	call GetPartyMonName
	ld a, [wTempMoveID]
	and a ; can the pokemon learn the move?
	jr nz,.checkIfAlreadyLearnedMove
; if the pokemon can't learn the move
	ld a,(SFX_02_51 - SFX_Headers_02) / 3
	call PlaySoundWaitForCurrent ; play sound
	ld hl,MonCannotLearnTutorMoveText
	call PrintText
	jr .chooseMon

.checkIfAlreadyLearnedMove
	callba CheckIfMoveIsKnown ; check if the pokemon already knows the move
	jr c,.chooseMon
	predef LearnMove ; teach move
	ld a, b
	and a ; did you learn the move, or cancel learning?
	jr z, .done

	; Charge 500 money if you learned it
	xor a
	ld [wWhichTrade], a
	ld [wTrainerFacingDirection], a
	ld a, $5
	ld [wTrainerEngageDistance], a
	ld hl, wTrainerFacingDirection
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef

.done
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	ld hl,MoveTutorComeAgainText
	jp PrintText

MoveTutorWelcomeText:
	TX_FAR _MoveTutorWelcomeText
	db "@"

TeachTutorMoveText:
	TX_FAR _TeachTutorMoveText
	db "@"

MoveTutorComeAgainText:
	TX_FAR _MoveTutorComeAgainText
	db "@"

MonCannotLearnTutorMoveText:
	TX_FAR _MonCannotLearnTutorMoveText
	db "@"

MoveTutorNotEnoughMoneyText:
	TX_FAR _MoveTutorNotEnoughMoneyText
	db "@"

ElementalHyperbeamsText:
	db   "Frenzy Plant"
	next "Blast Burn"
	next "Hydro Cannon"
	next "Cancel@"
