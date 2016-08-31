MoveDeleterText1:
	db 8 ; asm
	ld hl, MoveDeleterGreetingText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .exit
	ld hl, MoveDeleterSaidYesText
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
	call PrepareDeletableMoveList
	pop bc
	ld a, [wDeletableMoves]
	cp 2
	jr nc, .chooseMove
	pop bc
	ld hl, MoveDeleterOneMoveText
	call PrintText
	jp TextScriptEnd
.chooseMove
	push bc
	xor a
	ld [wListScrollOffset], a
	ld [wCurrentMenuItem], a
	ld hl, MoveDeleterWhichMoveText
	call PrintText
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
	; Save the selected move id.
	ld a, [wcf91]
	ld d, a
	push de
	push bc
	ld [wMoveNum], a
	ld [wd11e],a
	call GetMoveName
	call CopyStringToCF4B ; copy name to wcf4b
	ld hl, MoveDeleterConfirmText
	call PrintText
	call YesNoChoice
	pop bc
	pop de
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .chooseMove
	push de
	ld a, b ; a = mon index
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	; hl = pointer to mon's moves
	; Search for the move, and set it to 0.
	pop de ; d = move id
	call DeleteMove
	ld hl, MoveDeleterForgotText
	call PrintText
.exit
	ld hl, MoveDeleterByeText
	call PrintText
	jp TextScriptEnd

DeleteMove:
; d = move id
	ld b, 0
.searchLoop
	ld a, [hli]
	cp d
	jr z, .foundMoveLoop
	inc b
	jr .searchLoop
.foundMoveLoop
	ld a, b
	cp 3
	jr z, .zeroLastMove
	ld a, [hl]
	dec hl
	ld [hli], a
	push hl
	ld de, wPartyMon1PP - wPartyMon1Moves
	add hl, de
	ld a, [hld]
	ld [hl], a ; copy move's PP
	pop hl
	inc hl
	inc b
	jr .foundMoveLoop
.zeroLastMove
	dec hl
	xor a
	ld [hl], a
	ld de, wPartyMon1PP - wPartyMon1Moves
	add hl, de
	ld [hl], a ; clear last move's PP
	ret

PrepareDeletableMoveList:
; Places a list of the selected pokemon's moves at wDeletableMoves.
; First byte is count, and last byte is $ff.
; Input: party mon index = [wWhichPokemon]
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	; hl = pointer to mon's 4 moves
	ld b, 0 ; count of moves
	ld c, 4 + 1 ; 4 moves
	ld de, wDeletableMoves + 1
.loop
	dec c
	jr z, .done
	ld a, [hli]
	and a
	jr z, .loop
	ld [de], a
	inc de
	inc b
	jr .loop
.done
	ld a, $ff  ; terminate the list
	ld [de], a
	ld a, b  ; store number of moves
	ld [wDeletableMoves], a
	ret

MoveDeleterGreetingText:
	TX_FAR _MoveDeleterGreetingText
	db "@"

MoveDeleterSaidYesText:
	TX_FAR _MoveDeleterSaidYesText
	db "@"

MoveDeleterWhichMoveText:
	TX_FAR _MoveDeleterWhichMoveText
	db "@"

MoveDeleterConfirmText:
	TX_FAR _MoveDeleterConfirmText
	db "@"

MoveDeleterForgotText:
	TX_FAR _MoveDeleterForgotText
	db "@"

MoveDeleterByeText:
	TX_FAR _MoveDeleterByeText
	db "@"

MoveDeleterOneMoveText:
	TX_FAR _MoveDeleterOneMoveText
	db "@"
