; New script for Red++
; Based on a combination of Fossil Lab and Elevator Menus
; Allows travel to any Event Island based on which tickets the player has in the pack
EventIslandsFerryScript::
	ld hl, WelcomeToSeagallopText
	call PrintText	
	call GetFerryTickets
	ld a, [wcd37] ; wFilteredBagItemsCount
	and a
	jr z, .noTicket
	call DoIslandMenu
	ret

.noTicket
	call ManualTextScroll
	ld hl,NoTicketText
	call PrintText
	ret

GetFerryTickets:
; generate a list in wram of all Event Items the player has
	xor a
	ld [wcd37], a ; wFilteredBagItemsCount
	ld de, wcc5b  ; wFilteredBagItems
	ld hl, TicketList
.loop
	ld a, [hli]
	and a
	jr z, .done
	push hl
	push de
	ld [wd11e], a
	ld b, a
	predef IsItemInBag_
	pop de
	pop hl
	ld a, b
	and a
	jr z, .loop

	; A ticket's in the bag
	ld a, [wd11e]
	ld [de], a
	inc de
	push hl
	ld hl, wcd37 ; wFilteredBagItemsCount
	inc [hl]
	pop hl
	jr .loop
.done
	ld hl, wcd37 ; wFilteredBagItemsCount
	ld a, [hl]
	and a
	jr z, .endList ; if no items are in the pack, don't add "Go Home" option

	; add Vermilion to the list if there is one, to get back home
	ld a, GO_HOME
	ld [de],a
	inc de
	inc [hl] ; increase item count so GO HOME shows up

.endList
	ld a, $ff ; End of list
	ld [de], a
	ret

TicketList:
	db OLD_SEA_MAP
	db EON_TICKET
	db MYSTIC_TICKET
	db $00

PrintTicketsInBag:
; Print the list of names inside the menu box we drew
	ld hl, wcc5b
	xor a
	ld [$ffdb], a
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wd11e], a
	call GetItemName
	coord hl, 2, 2
	ld a, [$ffdb]
	ld bc, $28
	call AddNTimes
	ld de, wcd6d
	call PlaceString
	ld hl, $ffdb
	inc [hl]
	pop hl
	jr .loop

DoIslandMenu:
; Display the menu we generated earlier, let the player choose an item to use,
; then do the elevator thing and update the warps accordingly
	ld hl, wd730
	set 6, [hl]
	xor a
	ld [wCurrentMenuItem], a
	ld a, $3 ; A_BUTTON | B_BUTTON
	ld [wMenuWatchedKeys], a
	ld a, [wcd37] ; wFilteredBagItemsCount
	dec a
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 1
	ld [wTopMenuItemX], a
	ld a, [wcd37] ; wFilteredBagItemsCount
	dec a
	ld bc, 2
	ld hl, 3
	call AddNTimes
	dec l
	ld b, l
	ld c, $d
	ld hl, wTileMap
	call TextBoxBorder
	call UpdateSprites
	call PrintTicketsInBag
	ld hl, wd730
	res 6, [hl]
	call HandleMenuInput
	bit 1, a ; Pressed B?
	jr nz, .cancelledChoosingTicket
	ld hl, wcc5b ; wFilteredBagItems
	ld a, [wCurrentMenuItem]
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	ld [$ffdb], a
	cp OLD_SEA_MAP
	jr z, .choseFarawayIsland
	cp EON_TICKET
	jr z, .choseSouthernIsland
	cp MYSTIC_TICKET
	jr z, .choseNavelRock

;choseVermilion
	ld b, 2
	ld c, VERMILION_FERRY_DOCK
	jr .islandSelected

.choseFarawayIsland
	ld b, 0
	ld c, FARAWAY_ISLAND_OUTSIDE
	jr .islandSelected

.choseSouthernIsland
	ld b, 0
	ld c, SOUTHERN_ISLAND_OUTSIDE
	jr .islandSelected

.choseNavelRock
	ld b, 2
	ld c, NAVEL_ROCK_FERRY_DOCK
	; fallthrough

.islandSelected
; First, see if we need to update the warps
	ld a, [wWarpEntries + 3] ; Map ID of first warp
	cp c ; see if we're already at the place we tried to go
	jr z, .alreadyThere

; Hold onto the warp entry we selected
	push bc
	
; Mark for it to do the shake animation
	ld hl, wd126
	set 7, [hl]
	
; Announce that we are leaving
	ld hl, AllAboardText
	call PrintText
	
; Update the warp entries to match the ones for that island
	pop bc ; get the warp IDs back
	ld hl, wWarpEntries
	call .doWarpStuff

; This is called once to update the first warp, then it falls through to run again and update the second warp
.doWarpStuff
	inc hl
	inc hl
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ret

.cancelledChoosingTicket
	ld hl, GoingNowhereText
	call PrintText
	ret
	
.alreadyThere
	ld hl, AlreadyThereText
	call PrintText
	ret
	
WelcomeToSeagallopText:
	text "Welcome aboard"
	line "the Seagallop"
	cont "Ferry!"
	
	para "We travel all"
	line "over carrying"
	cont "passengers."
	
	para "Do you have a"
	line "ticket to travel"
	cont "with us today?@@"

NoTicketText:
	text "No? That's too"
	line "bad."
	
	para "Come back and see"
	line "us later."
	prompt
	db "@"
	
GoingNowhereText:
	text "Come back and see"
	line "us later."
	prompt
	db "@"

AllAboardText:
	text "All aboard!"
	prompt
	db "@"
	
AlreadyThereText:
	text "We're already"
	line "there!"
	prompt
	db "@"
