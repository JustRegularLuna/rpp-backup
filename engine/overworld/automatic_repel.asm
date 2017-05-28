; Port of the BW2 Repel System
; Based heavily on code from Pokemon Maize
; Credit goes to Shanty Town
_DisplayRepelWoreOffText::
	; Display "Repel's Effect Wore Off"
	ld hl, RepelWoreOffText
	call PrintText
	
	; Check for more Repels
	ld b, REPEL
	call IsItemInBag
	ld b, REPEL
	jr nz, .gotItem
	ld b, SUPER_REPEL
	call IsItemInBag
	ld b, SUPER_REPEL
	jr nz, .gotItem
	ld b, MAX_REPEL
	call IsItemInBag
	ld b, MAX_REPEL
	ret z ; Return if there were no Repels left
	
.gotItem
	; register b holds the item ID
	push bc ; don't lose the item ID
	ld a, b
	ld [wd11e], a
	call GetItemName
	call CopyStringToCF4B
	ld hl, UseAnotherText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .saidNo
	pop bc ; get the item ID back so we can put it where it needs to be
	ld a,b
	ld [wcf91], a
	ld [wPseudoItemID], a
	
	; get ready to find which item slot the repel is in, so we don't remove the wrong item
	ld hl, wBagItems
	ld c, 0 ; initialize the slot number to first item
	
	; Find the item in the pack, so we can store the slot in wWhichPokemon for use by UseItem
.loop
	ld a, [hli]  ; read the item ID for that slot
	cp b         ; check it against the item we are looking for
	jr z, .found ; jump if we found it, otherwise...
	inc c        ; increase the slot count
	inc hl       ; skip the item's quantity
	jr .loop     ; and keep looking
	
	; once we've found the item's slot number
.found
	ld a, c ; get the slot number we found
	ld [wWhichPokemon], a ; store it here
	call UseItem ; use the Repel
	jr .done
	
.saidNo
	pop bc
.done
	ret

RepelWoreOffText:: ; Moved out of Bank 0
	TX_FAR _RepelWoreOffText
	db "@"

UseAnotherText:
	text "Use another one?@@"
