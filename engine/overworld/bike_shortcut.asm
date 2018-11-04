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
     jr c,.useItem
     call EnableBikeShortcutText
.useItem
     call UseItem
.cleanUp
     call CloseBikeShortcutText
     ret

TextNoBike:
     TX_FAR _NoBicycleText1
     TX_LINE
     TX_FAR _NoBicycleText2
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
