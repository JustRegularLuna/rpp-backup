TryRideBike::
	xor a
.setUp
	ld a,BICYCLE
	ld [wcf91],a
	ld [wPseudoItemID],a
	ld [wd11e],a ; store item ID for GetItemName
	call GetItemName
	call CopyStringToCF4B ; copy name to wcf4b
.tryForBike
	ld b,BICYCLE
	call IsItemInBag
	jr nz,.hasBike
	call EnableBikeShortcutText
	ld hl,TextNoBike ; if no bike
	call PrintText
	jr .cleanUp
.hasBike
	farcall IsBikeRidingAllowed
	jr c,.checkSurfing
	call EnableBikeShortcutText
.checkSurfing
	ld a,[wWalkBikeSurfState]
	cp a,2
	jr nz,.checkCyclingRoad ; if not surfing
	call EnableBikeShortcutText
.checkCyclingRoad
	ld a,[wd732] ; cycling road
	bit 5,a
	jr z,.useItem ;if not on cycling road skip text
	call EnableBikeShortcutText
.useItem
	call UseItem
.cleanUp
	call CloseBikeShortcutText
	ret

TextNoBike:
	TX_FAR _NoBicycleText1
	db "@"

EnableBikeShortcutText: ; Gets everything setup to let you display text properly
	call EnableAutoTextBoxDrawing
	ld a, 1 ; not 0
	ld [hSpriteIndexOrTextID], a
	farcall DisplayTextIDInit
	ret

CloseBikeShortcutText: ; Closes the text out properly to prevent glitches
	ld a,[H_LOADEDROMBANK]
	push af
	jp CloseTextDisplay
