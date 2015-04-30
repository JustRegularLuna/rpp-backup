BerryTreeScript::
; Display the "It's a fruit-bearing tree." text
	call EnableAutoTextBoxDrawing
	ld hl, FruitTreeText
	call PrintText
	
; Check to see if the player can get a berry from this tree right now
	ld a, [wWhichTrade] ; Which tree is this?
	ld c, a ; We need this in register c
	ld b, 2 ; We want to read this value to see if it's been taken or not
	ld hl, W_BERRYTREEFLAGS
	predef FlagActionPredef
	ld a, c ; Let's get the result of that check
	and a ; Make sure the flag isn't set
	jp nz, .NothingHereScript ; If it is, you got the berry, so the tree is empty
	
; Time to give the berry
	ld a, [wWhichTrade]
	dec a
	ld c, a
	ld b, 0
	ld hl, BerryTable
	add hl, bc
	ld a, [hl]
	ld b, a
	ld c, 1
	call GiveItem
	jr nc, .BagFull
	
; Mark the berry as taken
	ld a, [wWhichTrade] ; Which tree is this?
	ld c, a ; We need this in c
	ld b, 1 ; We want to set this tree's bit
	ld hl, W_BERRYTREEFLAGS
	predef FlagActionPredef
	
; Show "Found (Berry Name)!" text
	ld hl, FoundBerryText
	jr .print
	
; Runs if the berry has already been taken from this tree
.NothingHereScript
	ld hl, NoBerryText
	jr .print
	
; Runs when the bag is full
.BagFull
	ld hl, PackFullText
.print
	call PrintText
	ret
	
FruitTreeText:
	text "It's a fruit-"
	line "bearing tree."
	prompt
	db "@"
	
NoBerryText:
	text "Looks like there's"
	line "nothing here."
	done
	db "@"
	
FoundBerryText:
	TX_FAR _FoundItemText
	db $0B
	db "@"
	
PackFullText:
	TX_FAR _NoMoreRoomForItemText
	db "@"
	
; The table is not terminated, so don't use invalid tree numbers
BerryTable:
	db ORAN_BERRY ; Route 1
	db ORAN_BERRY ; Route 2
	db ORAN_BERRY ; Pewter City 1
	db ORAN_BERRY ; Pewter City 2
	db ORAN_BERRY ; Route 8
	db ORAN_BERRY ; Route 11
	db ORAN_BERRY ; Fuchsia City
	db ORAN_BERRY ; Tree 8
	db ORAN_BERRY ; Tree 9
	db ORAN_BERRY ; Tree 10
	db ORAN_BERRY ; Tree 11
	db ORAN_BERRY ; Tree 12
	db ORAN_BERRY ; Tree 13
	db ORAN_BERRY ; Tree 14
	db ORAN_BERRY ; Tree 15
	db ORAN_BERRY ; Tree 16	
	
	