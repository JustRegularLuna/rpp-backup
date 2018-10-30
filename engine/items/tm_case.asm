ShowTMCaseMenu:
	call GBPalWhiteOut
	call ClearScreen
	call UpdateSprites
	ld a,[wListScrollOffset]
	push af
	xor a
	ld [wCurrentMenuItem],a
	ld [wListScrollOffset],a
	ld [wLastMenuItem],a
	inc a
	ld [wd11e],a
	ld [hJoy7],a
.setUpGraphics
	ld b, SET_PAL_GENERIC
	call RunPaletteCommand
	callab LoadPokedexTilePatterns
.doPokemonListMenu
	ld hl,wTopMenuItemY
	ld a,3
	ld [hli],a ; top menu item Y
	xor a
	ld [hli],a ; top menu item X
	inc a
	ld [wMenuWatchMovingOutOfBounds],a
	inc hl
	inc hl
	ld a,6
	ld [hli],a ; max menu item ID
	ld [hl],D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
	call HandleTMCaseListMenu
	jr c,.goToSideMenu ; if the player chose a TM from the list
.exitTMCase
	xor a
	ld [wMenuWatchMovingOutOfBounds],a
	ld [wCurrentMenuItem],a
	ld [wLastMenuItem],a
	ld [hJoy7],a
	ld [wWastedByteCD3A],a
	ld [wOverrideSimulatedJoypadStatesMask],a
	pop af
	ld [wListScrollOffset],a
	call GBPalWhiteOutWithDelay3
	call RunDefaultPaletteCommand
	jp ReloadMapData
.goToSideMenu
;	call HandleTMCaseSideMenu
;	dec b
;	jr z,.exitTMCase ; if the player chose Quit
;	dec b
;	jr z,.doPokemonListMenu ; if pokemon not seen or player pressed B button
;	jp .setUpGraphics ; if pokemon data or area was shown
	jr .exitTMCase

; handles the list of TMs
; sets carry flag if player presses A, unsets carry flag if player presses B
HandleTMCaseListMenu:
	xor a
	ld [H_AUTOBGTRANSFERENABLED],a
	coord hl, 0, 0
	ld de,TMCaseContentsText
	call PlaceString
; find the highest TM number the player has obtained
	ld hl,wObtainedTMsEnd - 1
	ld b,(wObtainedTMsEnd - wObtainedTMs) * 8 + 1
.maxOwnedTMLoop
	ld a,[hld]
	ld c,8
.maxOwnedTMInnerLoop
	dec b
	sla a
	jr c,.storemaxOwnedTM
	dec c
	jr nz,.maxOwnedTMInnerLoop
	jr .maxOwnedTMLoop

.storemaxOwnedTM
	ld a,b
	ld [wDexMaxSeenMon],a
.loop
	xor a
	ld [H_AUTOBGTRANSFERENABLED],a
	coord hl, 4, 2
	lb bc, 14, 14
	call ClearScreenArea
	coord hl, 1, 3
	ld a,[wListScrollOffset]
	ld [wd11e],a
	ld d,7
	ld a,[wDexMaxSeenMon]
	cp a,7
	jr nc,.printMoveNameLoop
	ld d,a
	dec a
	ld [wMaxMenuItem],a
; loop to print TM numbers and Move names
.printMoveNameLoop
	ld a,[wd11e]
	inc a
	ld [wd11e],a
	push af
	push de
	push hl
	ld de,-SCREEN_WIDTH
	add hl,de
	ld de,wd11e
	lb bc, LEADING_ZEROES | 1, 2
	call PrintNumber ; print the TM number
	ld de,SCREEN_WIDTH
	add hl,de
	push hl

	ld hl,wObtainedTMs
	ld a,[wd11e]
	dec a
	ld c,a
	ld b,FLAG_TEST
	predef FlagActionPredef
	ld a,c
	and a

	jr nz,.getMoveName ; if the player has the TM
	ld de,.dashedLine ; print a dashed line in place of the name if the player hasn't got the TM
	jr .skipGettingName
.dashedLine ; for unowned TMs
	db "----------@"
.getMoveName
	predef TMToMove
	call GetMoveName
.skipGettingName
	pop hl
	call PlaceString
	pop hl
	ld bc,2 * SCREEN_WIDTH
	add hl,bc
	pop de
	pop af
	ld [wd11e],a
	dec d
	jr nz,.printMoveNameLoop
	ld a,01
	ld [H_AUTOBGTRANSFERENABLED],a
	call Delay3
	call GBPalNormal
	call HandleMenuInput
	bit 1,a ; was the B button pressed?
	jp nz,.buttonBPressed
.checkIfUpPressed
	bit 6,a ; was Up pressed?
	jr z,.checkIfDownPressed
.upPressed ; scroll up one row
	ld a,[wListScrollOffset]
	and a
	jp z,.loop
	dec a
	ld [wListScrollOffset],a
	jp .loop
.checkIfDownPressed
	bit 7,a ; was Down pressed?
	jr z,.checkIfRightPressed
.downPressed ; scroll down one row
	ld a,[wDexMaxSeenMon]
	cp a,7
	jp c,.loop ; can't if the list is shorter than 7
	sub a,7
	ld b,a
	ld a,[wListScrollOffset]
	cp b
	jp z,.loop
	inc a
	ld [wListScrollOffset],a
	jp .loop
.checkIfRightPressed
	bit 4,a ; was Right pressed?
	jr z,.checkIfLeftPressed
.rightPressed ; scroll down 7 rows
	ld a,[wDexMaxSeenMon]
	cp a,7
	jp c,.loop ; can't if the list is shorter than 7
	sub a,6
	ld b,a
	ld a,[wListScrollOffset]
	add a,7
	ld [wListScrollOffset],a
	cp b
	jp c,.loop
	dec b
	ld a,b
	ld [wListScrollOffset],a
	jp .loop
.checkIfLeftPressed ; scroll up 7 rows
	bit 5,a ; was Left pressed?
	jr z,.buttonAPressed
.leftPressed
	ld a,[wListScrollOffset]
	sub a,7
	ld [wListScrollOffset],a
	jp nc,.loop
	xor a
	ld [wListScrollOffset],a
	jp .loop
.buttonAPressed
	scf
	ret
.buttonBPressed
	and a
	ret

TMCaseContentsText:
	db "TM/HM Case@"

wObtainedTMs: ; placeholder
	tmlearn 1,2,3,4,5,6,7,8
	tmlearn 9,10,11,12,13,14,15,16
	tmlearn 17,18,19,20,21,22,23,24
	tmlearn 25,26,27,28,29,30,31,32
	tmlearn 33,34,35,36,37,38,39,40
	tmlearn 41,42,43,44,45,46,47,48
	tmlearn 49,50,51,52,53,54,55
wObtainedTMsEnd:
