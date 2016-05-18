MoveRelearnerText1:
	db 8 ; asm
; Display the list of moves to the player.
	ld hl, MoveRelearnerGreetingText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .exit
	xor a
	ldh [$9f], a
	ldh [$a1], a
	ld a, 5
	ldh [$a0], a  ; 500 money
	call HasEnoughMoney
	jr nc, .enoughMoney
	; not enough money
	ld hl, MoveRelearnerNotEnoughMoneyText
	call PrintText
	jp TextScriptEnd
.enoughMoney
	ld hl, MoveRelearnerSaidYesText
	call PrintText
	; Select pokemon from party.
	call SaveScreenTilesToBuffer2
	xor a
	ld [wListScrollOffset], a
	ld [wd07d], a
	ld [wUpdateSpritesEnabled], a
	ld [wMenuItemToSwap], a
	call DisplayPartyMenu
	push af
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	pop af
	jp c, .exit
	ld a, [wWhichPokemon]
	ld b, a
	push bc
	ld hl, PrepareRelearnableMoveList
	ld b, Bank(PrepareRelearnableMoveList)
	call Bankswitch
	ld a, [wRelearnableMoves]
	and a
	jr nz, .chooseMove
	pop bc
	ld hl, MoveRelearnerNoMovesText
	call PrintText
	jp TextScriptEnd
.chooseMove
	ld hl, MoveRelearnerWhichMoveText
	call PrintText
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld a, MOVESLISTMENU
	ld [wListMenuID], a
	ld de, wRelearnableMoves
	ld hl, wList
	ld [hl], e
	inc hl
	ld [hl], d
	xor a
	ld [wcf93], a ; don't print prices
	call DisplayListMenuID
	pop bc
	jr c, .exit  ; exit if player chose cancel
	push bc
	; Save the selected move id.
	ld a, [wcf91]
	ld [wMoveNum], a
	ld [wd11e],a
	call GetMoveName
	call CopyStringToCF4B ; copy name to wcf4b
	pop bc
	ld a, b
	ld [wWhichPokemon], a
	ld a, [wd358]
	push af
	xor a
	ld [wd358], a
	predef LearnMove
	pop af
	ld [wd358], a
	ld a, b
	and a
	jr z, .exit
	; Charge 500 money
	xor a
	ld [wWhichTrade], a
	ld [wTrainerFacingDirection], a
	ld a, $5
	ld [wTrainerEngageDistance], a
	ld hl, wTrainerFacingDirection
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef
	ld hl, MoveRelearnerByeText
	call PrintText
	jp TextScriptEnd
.exit
	ld hl, MoveRelearnerByeText
	call PrintText
	jp TextScriptEnd

MoveRelearnerGreetingText:
	TX_FAR _MoveRelearnerGreetingText
	db "@"

MoveRelearnerSaidYesText:
	TX_FAR _MoveRelearnerSaidYesText
	db "@"

MoveRelearnerNotEnoughMoneyText:
	TX_FAR _MoveRelearnerNotEnoughMoneyText
	db "@"

MoveRelearnerWhichMoveText:
	TX_FAR _MoveRelearnerWhichMoveText
	db "@"

MoveRelearnerByeText:
	TX_FAR _MoveRelearnerByeText
	db "@"

MoveRelearnerNoMovesText:
	TX_FAR _MoveRelearnerNoMovesText
	db "@"
