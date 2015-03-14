PickupItem:
	call EnableAutoTextBoxDrawing

	ld a, [H_DOWNARROWBLINKCNT2] ; $ff8c
	ld b, a
	ld hl, W_MISSABLEOBJECTLIST
.missableObjectsListLoop
	ld a, [hli]
	cp $ff
	; changed the ret z command to a jump, so it will do my berry thing if it isn't a hideable event
	jr z, .isBerryTree
	; original script resumes below
	cp b
	jr z, .isMissable
	inc hl
	jr .missableObjectsListLoop
; This is the same as an item ball, but it doesn't try to hide the event
.isBerryTree
	ld a, [W_PLAYERBATTSTATUS1] ; reset each time there is a battle
	and a
	jp z, .doBerry
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, .NothingHereText
	jp .print
.doBerry
	ld a, [hl]
	ld [$ffdb], a

	ld hl, W_MAPSPRITEEXTRADATA
	ld a, [H_DOWNARROWBLINKCNT2] ; $ff8c
	dec a
	add a
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	ld b, a ; item
	ld c, 1 ; quantity
	call GiveItem
	jr nc, .BagFull

	ld a, [$ffdb]
	ld [wcc4d], a
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, 1
	ld [W_PLAYERBATTSTATUS1], a
	ld hl, FoundItemText
	jr .print
.isMissable
	ld a, [hl]
	ld [$ffdb], a

	ld hl, W_MAPSPRITEEXTRADATA
	ld a, [H_DOWNARROWBLINKCNT2] ; $ff8c
	dec a
	add a
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	ld b, a ; item
	ld c, 1 ; quantity
	call GiveItem
	jr nc, .BagFull

	ld a, [$ffdb]
	ld [wcc4d], a
	predef HideObject
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, FoundItemText
	jr .print
.BagFull
	ld hl, NoMoreRoomForItemText
.print
	call PrintText
	ret

.NothingHereText: ; calls an existing text string
	TX_FAR _NothingHereText
	db "@"
	
FoundItemText:
	TX_FAR _FoundItemText
	db $0B
	db "@"

NoMoreRoomForItemText:
	TX_FAR _NoMoreRoomForItemText
	db "@"
