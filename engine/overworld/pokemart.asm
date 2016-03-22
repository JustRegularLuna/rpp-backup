DisplayPokemartDialogue_: ; 6c20 (1:6c20)
	ld a,[wListScrollOffset]
	ld [wd07e],a
	call UpdateSprites ; move sprites
	xor a
	ld [wcf0a],a ; flag that is set if something is sold or bought
.loop
	xor a
	ld [wListScrollOffset],a
	ld [wCurrentMenuItem],a
	ld [wPlayerMonNumber],a
	inc a
	ld [wcf93],a
	ld a,MONEY_BOX
	ld [wTextBoxID],a
	call DisplayTextBoxID ; draw money text box
	ld a,BUY_SELL_QUIT_MENU
	ld [wTextBoxID],a
	call DisplayTextBoxID ; do buy/sell/quit menu
	ld hl,wd128 ; pointer to this pokemart's inventory
	ld a,[hli]
	ld l,[hl]
	ld h,a ; hl = address of inventory
	ld a,[wd12e]
	cp a,$02
	jp z,.done
	ld a,[wd12d] ; ID of the chosen menu item
	and a ; buying?
	jp z,.buyMenu
	dec a ; selling?
	jp z,.sellMenu
	dec a ; quitting?
	jp z,.done
.sellMenu
	xor a
	ld [wcf93],a
	ld a,$02
	ld [wd11b],a
	callab Func_39bd5
	ld a,[wNumBagItems]
	and a
	jp z,.bagEmpty
	ld hl,PokemonSellingGreetingText
	call PrintText
	call SaveScreenTilesToBuffer1 ; save screen
.sellMenuLoop
	call LoadScreenTilesFromBuffer1 ; restore saved screen
	ld a,MONEY_BOX
	ld [wTextBoxID],a
	call DisplayTextBoxID ; draw money text box
	ld hl,wNumBagItems
	ld a,l
	ld [wList],a
	ld a,h
	ld [wList + 1],a
	xor a
	ld [wcf93],a
	ld [wCurrentMenuItem],a
	ld a,ITEMLISTMENU
	ld [wListMenuID],a
	call DisplayListMenuID
	jp c,.returnToMainPokemartMenu ; if the player closed the menu
.confirmItemSale ; if the player is trying to sell a specific item
	call IsKeyItem ; check if item is unsellable
	ld a,[wd124]
	and a
	jr nz,.unsellableItem
	ld a,[wcf91]
	call IsItemHM
	jr c,.unsellableItem
	ld a,PRICEDITEMLISTMENU
	ld [wListMenuID],a
	ld [$ff8e],a ; halve prices when selling
	call DisplayChooseQuantityMenu
	inc a
	jr z,.sellMenuLoop ; if the player closed the choose quantity menu with the B button
	ld hl,PokemartTellSellPriceText
	ld bc,$0e01
	call PrintText
	hlCoord 14, 7
	ld bc,$080f
	ld a,TWO_OPTION_MENU
	ld [wTextBoxID],a
	call DisplayTextBoxID ; yes/no menu
	ld a,[wd12e]
	cp a,$02
	jr z,.sellMenuLoop ; if the player pressed the B button
	ld a,[wd12d] ; ID of the chosen menu item
	dec a
	jr z,.sellMenuLoop ; if the player chose No
.sellItem
	ld a,[wcf0a] ; flag that is set if something is sold or bought
	and a
	jr nz,.skipSettingFlag1
	inc a
	ld [wcf0a],a
.skipSettingFlag1
	call AddAmountSoldToMoney
	ld hl,wNumBagItems
	call RemoveItemFromInventory
	jp .sellMenuLoop
.unsellableItem
	ld hl,PokemartUnsellableItemText
	call PrintText
	jp .returnToMainPokemartMenu
.bagEmpty
	ld hl,PokemartItemBagEmptyText
	call PrintText
	call SaveScreenTilesToBuffer1 ; save screen
	jp .returnToMainPokemartMenu
.buyMenu
	ld a,$01
	ld [wcf93],a
	ld a,$03
	ld [wd11b],a
	callab Func_39bd5
	ld hl,PokemartBuyingGreetingText
	call PrintText
	call SaveScreenTilesToBuffer1 ; save screen
.buyMenuLoop
	call LoadScreenTilesFromBuffer1 ; restore saved screen
	ld a,MONEY_BOX
	ld [wTextBoxID],a
	call DisplayTextBoxID ; draw money text box
	ld hl,wStringBuffer2 + 11
	ld a,l
	ld [wList],a
	ld a,h
	ld [wList + 1],a
	xor a
	ld [wCurrentMenuItem],a
	inc a
	ld [wcf93],a
	inc a ; a = 2 (PRICEDITEMLISTMENU)
	ld [wListMenuID],a
	call DisplayListMenuID_Mart
	jr c,.returnToMainPokemartMenu ; if the player closed the menu
	ld a,$63
	ld [wcf97],a
	xor a
	ld [$ff8e],a
	call DisplayChooseQuantityMenu
	inc a
	jr z,.buyMenuLoop ; if the player closed the choose quantity menu with the B button
	ld a,[wcf91] ; item ID
	ld [wd11e],a ; store item ID for GetItemName
	call GetItemName
	call CopyStringToCF4B ; copy name to wcf4b
	ld hl,PokemartTellBuyPriceText
	call PrintText
	hlCoord 14, 7
	ld bc,$080f
	ld a,TWO_OPTION_MENU
	ld [wTextBoxID],a
	call DisplayTextBoxID ; yes/no menu
	ld a,[wd12e]
	cp a,$02
	jp z,.buyMenuLoop ; if the player pressed the B button
	ld a,[wd12d] ; ID of the chosen menu item
	dec a
	jr z,.buyMenuLoop ; if the player chose No
.buyItem
	call .isThereEnoughMoney
	jr c,.notEnoughMoney
	ld hl,wNumBagItems
	call AddItemToInventory
	jr nc,.bagFull
	call SubtractAmountPaidFromMoney
	ld a,[wcf0a] ; flag that is set if something is sold or bought
	and a
	jr nz,.skipSettingFlag2
	ld a,$01
	ld [wcf0a],a
.skipSettingFlag2
	ld a,(SFX_02_5a - SFX_Headers_02) / 3
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	ld hl,PokemartBoughtItemText
	call PrintText
	jp .buyMenuLoop
.returnToMainPokemartMenu
	call LoadScreenTilesFromBuffer1
	ld a,MONEY_BOX
	ld [wTextBoxID],a
	call DisplayTextBoxID ; draw money text box
	ld hl,PokemartAnythingElseText
	call PrintText
	jp .loop
.isThereEnoughMoney
	ld de,wPlayerMoney
	ld hl,$ff9f ; item price
	ld c,3 ; length of money in bytes
	jp StringCmp
.notEnoughMoney
	ld hl,PokemartNotEnoughMoneyText
	call PrintText
	jr .returnToMainPokemartMenu
.bagFull
	ld hl,PokemartItemBagFullText
	call PrintText
	jr .returnToMainPokemartMenu
.done
	ld hl,PokemartThankYouText
	call PrintText
	ld a,$01
	ld [wUpdateSpritesEnabled],a
	call UpdateSprites ; move sprites
	ld a,[wd07e]
	ld [wListScrollOffset],a
	ret

PokemartBuyingGreetingText: ; 6e0c (1:6e0c)
	TX_FAR _PokemartBuyingGreetingText
	db "@"

PokemartTellBuyPriceText: ; 6e11 (1:6e11)
	TX_FAR _PokemartTellBuyPriceText
	db "@"

PokemartBoughtItemText: ; 6e16 (1:6e16)
	TX_FAR _PokemartBoughtItemText
	db "@"

PokemartNotEnoughMoneyText: ; 6e1b (1:6e1b)
	TX_FAR _PokemartNotEnoughMoneyText
	db "@"

PokemartItemBagFullText: ; 6e20 (1:6e20)
	TX_FAR _PokemartItemBagFullText
	db "@"

PokemonSellingGreetingText: ; 6e25 (1:6e25)
	TX_FAR _PokemonSellingGreetingText
	db "@"

PokemartTellSellPriceText: ; 6e2a (1:6e2a)
	TX_FAR _PokemartTellSellPriceText
	db "@"

PokemartItemBagEmptyText: ; 6e2f (1:6e2f)
	TX_FAR _PokemartItemBagEmptyText
	db "@"

PokemartUnsellableItemText: ; 6e34 (1:6e34)
	TX_FAR _PokemartUnsellableItemText
	db "@"

PokemartThankYouText: ; 6e39 (1:6e39)
	TX_FAR _PokemartThankYouText
	db "@"

PokemartAnythingElseText: ; 6e3e (1:6e3e)
	TX_FAR _PokemartAnythingElseText
	db "@"

DisplayListMenuID_Mart::
	xor a
	ld [H_AUTOBGTRANSFERENABLED],a ; disable auto-transfer
	ld a,1
	ld [hJoy7],a ; joypad state update flag
	ld hl,wd730
	set 6,[hl] ; turn off letter printing delay
	xor a
	ld [wMenuItemToSwap],a ; 0 means no item is currently being swapped
	ld [wd12a],a
	ld a,[wList]
	ld l,a
	ld a,[wList + 1]
	ld h,a ; hl = address of the list
	ld a,[hl] ; the first byte is the number of entries in the list
	ld [wd12a],a
	ld a,LIST_MENU_BOX
	ld [wTextBoxID],a
	callab DisplayTextBoxID ; draw the menu text box
	call UpdateSprites ; disable sprites behind the text box
; the code up to .skipMovingSprites appears to be useless
	coord hl, 4, 2 ; coordinates of upper left corner of menu text box
	lb de, 9, 14 ; height and width of menu text box
	ld a,1 ; max menu item ID is 1 if the list has less than 2 entries
	ld [wcc37],a
	ld a,[wd12a]
	cp a,2 ; does the list have less than 2 entries?
	jr c,.setMenuVariables
	ld a,2 ; max menu item ID is 2 if the list has at least 2 entries
.setMenuVariables
	ld [wMaxMenuItem],a
	ld a,4
	ld [wTopMenuItemY],a
	ld a,5
	ld [wTopMenuItemX],a
	ld a,A_BUTTON | B_BUTTON | SELECT
	ld [wMenuWatchedKeys],a
	ld c,10
	call DelayFrames
	call PrintItemDescription_Mart

DisplayListMenuIDLoop_Mart:: ; 2c53 (0:2c53)
	xor a
	ld [H_AUTOBGTRANSFERENABLED],a ; disable transfer
	call PrintListMenuEntries
	ld a,1
	ld [H_AUTOBGTRANSFERENABLED],a ; enable transfer
	call Delay3
	ld a,[W_BATTLETYPE]
	and a ; is it the Old Man battle?
	jr z,.notOldManBattle
.oldManBattle
	ld a,"▶"
	Coorda 5, 4 ; place menu cursor in front of first menu entry
	ld c,80
	call DelayFrames
	xor a
	ld [wCurrentMenuItem],a
	coord hl, 5, 4
	ld a,l
	ld [wMenuCursorLocation],a
	ld a,h
	ld [wMenuCursorLocation + 1],a
	jr .buttonAPressed
.notOldManBattle
	call LoadGBPal
	call HandleMenuInput_Mart
	push af
	call PlaceMenuCursor
	pop af
	bit 0,a ; was the A button pressed?
	jp z,.checkOtherKeys
.buttonAPressed
	ld a,[wCurrentMenuItem]
	call PlaceUnfilledArrowMenuCursor

; pointless because both values are overwritten before they are read
	ld a,$01
	ld [wd12e],a
	ld [wd12d],a

	xor a
	ld [wcc37],a
	ld a,[wCurrentMenuItem]
	ld c,a
	ld a,[wListScrollOffset]
	add c
	ld c,a
	ld a,[wd12a]
	and a ; is the list empty?
	jp z,ExitListMenu_Mart ; if so, exit the menu
	dec a
	cp c ; did the player select Cancel?
	jp c,ExitListMenu_Mart ; if so, exit the menu
	ld a,c
	ld [wWhichPokemon],a
	ld a,[wListMenuID]
	cp a,ITEMLISTMENU
	jr nz,.skipMultiplying
; if it's an item menu
	sla c ; item entries are 2 bytes long, so multiply by 2
.skipMultiplying
	ld a,[wList]
	ld l,a
	ld a,[wList + 1]
	ld h,a
	inc hl ; hl = beginning of list entries
	ld b,0
	add hl,bc
	ld a,[hl]
	ld [wcf91],a
	ld a,[wListMenuID]
	and a ; is it a PC pokemon list?
	jr z,.pokemonList
	push hl
	call GetItemPrice
	pop hl
	ld a,[wListMenuID]
	cp a,ITEMLISTMENU
	jr nz,.skipGettingQuantity
; if it's an item menu
	inc hl
	ld a,[hl] ; a = item quantity
	ld [wcf97],a
.skipGettingQuantity
	ld a,[wcf91]
	ld [wd0b5],a
	ld a,BANK(ItemNames)
	ld [wPredefBank],a
	call GetName
	jr .storeChosenEntry
.pokemonList
	ld hl,wPartyCount
	ld a,[wList]
	cp l ; is it a list of party pokemon or box pokemon?
	ld hl,wPartyMonNicks
	jr z,.getPokemonName
	ld hl, wBoxMonNicks ; box pokemon names
.getPokemonName
	ld a,[wWhichPokemon]
	call GetPartyMonName
.storeChosenEntry ; store the menu entry that the player chose and return
	ld de,wcd6d
	call CopyStringToCF4B ; copy name to wcf4b
	ld a,1
	ld [wd12e],a
	ld a,[wCurrentMenuItem]
	ld [wd12d],a
	xor a
	ld [hJoy7],a ; joypad state update flag
	ld hl,wd730
	res 6,[hl] ; turn on letter printing delay
	ret
.checkOtherKeys ; check B, SELECT, Up, and Down keys
	bit 1,a ; was the B button pressed?
	jp nz,ExitListMenu_Mart ; if so, exit the menu
	bit 2,a ; was the select button pressed?
	jp nz,HandleItemListSwapping ; if so, allow the player to swap menu entries
	ld b,a
	bit 7,b ; was Down pressed?
	ld hl,wListScrollOffset
	jr z,.upPressed
.downPressed
	ld a,[hl]
	add a,3
	ld b,a
	ld a,[wd12a]
	cp b ; will going down scroll past the Cancel button?
	jp c,DisplayListMenuIDLoop_Mart
	inc [hl] ; if not, go down
	call PrintItemDescription_Mart
	jp DisplayListMenuIDLoop_Mart
.upPressed
	ld a,[hl]
	and a
	jp z,DisplayListMenuIDLoop_Mart
	dec [hl]
	call PrintItemDescription_Mart
	jp DisplayListMenuIDLoop_Mart

PrintItemDescription_Mart::
	push bc
	push de
	push hl
	; Get item id.
	ld a, [wCurrentMenuItem]
	ld c, a
	ld a, [wListScrollOffset]
	add c
	ld c, a
	ld hl, wList
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	inc de  ; de = pointer to list
	ld h, d
	ld l, e
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld d, a ; d = item id
	callab FlashItemDescription_Mart
	pop hl
	pop de
	pop bc
	ret

ExitListMenu_Mart:: ; 2e3b (0:2e3b)
	ld a,[wCurrentMenuItem]
	ld [wd12d],a
	ld a,2
	ld [wd12e],a
	ld [wcc37],a
	xor a
	ld [hJoy7],a
	ld hl,wd730
	res 6,[hl]
	xor a
	ld [wMenuItemToSwap],a ; 0 means no item is currently being swapped
	scf
	ret

HandleMenuInput_Mart:: ; 3abe (0:3abe)
	xor a
	ld [wd09b],a
	ld a,[H_DOWNARROWBLINKCNT1]
	push af
	ld a,[H_DOWNARROWBLINKCNT2]
	push af ; save existing values on stack
	xor a
	ld [H_DOWNARROWBLINKCNT1],a ; blinking down arrow timing value 1
	ld a,$06
	ld [H_DOWNARROWBLINKCNT2],a ; blinking down arrow timing value 2
.loop1
	xor a
	ld [W_SUBANIMTRANSFORM],a ; counter for pokemon shaking animation
	call PlaceMenuCursor
	call Delay3
.loop2
	push hl
	ld a,[wd09b]
	and a ; is it a pokemon selection menu?
	jr z,.getJoypadState
	callba AnimatePartyMon ; shake mini sprite of selected pokemon
.getJoypadState
	pop hl
	call JoypadLowSensitivity
	ld a,[hJoy5]
	and a ; was a key pressed?
	jr nz,.keyPressed
	push hl
	hlCoord 18, 11 ; coordinates of blinking down arrow in some menus
	call HandleDownArrowBlinkTiming ; blink down arrow (if any)
	pop hl
	ld a,[wMenuJoypadPollCount]
	dec a
	jr z,.giveUpWaiting
	jr .loop2
.giveUpWaiting
; if a key wasn't pressed within the specified number of checks
	pop af
	ld [H_DOWNARROWBLINKCNT2],a
	pop af
	ld [H_DOWNARROWBLINKCNT1],a ; restore previous values
	xor a
	ld [wMenuWrappingEnabled],a ; disable menu wrapping
	ret
.keyPressed
	xor a
	ld [wcc4b],a
	ld a,[hJoy5]
	ld b,a
	bit 6,a ; pressed Up key?
	jr z,.checkIfDownPressed
.upPressed
	ld a,[wCurrentMenuItem] ; selected menu item
	and a ; already at the top of the menu?
	jr z,.alreadyAtTop
.notAtTop
	dec a
	ld [wCurrentMenuItem],a ; move selected menu item up one space
	call PrintItemDescription_Mart
	jr .checkOtherKeys
.alreadyAtTop
	ld a,[wMenuWrappingEnabled]
	and a ; is wrapping around enabled?
	jr z,.noWrappingAround
	ld a,[wMaxMenuItem]
	ld [wCurrentMenuItem],a ; wrap to the bottom of the menu
	jr .checkOtherKeys
.checkIfDownPressed
	bit 7,a
	jr z,.checkOtherKeys
.downPressed
	ld a,[wCurrentMenuItem]
	inc a
	ld c,a
	ld a,[wMaxMenuItem]
	cp c
	jr nc,.notAtBottom
.alreadyAtBottom
	ld a,[wMenuWrappingEnabled]
	and a ; is wrapping around enabled?
	jr z,.noWrappingAround
	ld c,$00 ; wrap from bottom to top
.notAtBottom
	ld a,c
	ld [wCurrentMenuItem],a
	call PrintItemDescription_Mart
.checkOtherKeys
	ld a,[wMenuWatchedKeys]
	and b ; does the menu care about any of the pressed keys?
	jp z,.loop1
.checkIfAButtonOrBButtonPressed
	ld a,[hJoy5]
	and A_BUTTON | B_BUTTON
	jr z,.skipPlayingSound
.AButtonOrBButtonPressed
	push hl
	ld hl,wFlags_0xcd60
	bit 5,[hl]
	pop hl
	jr nz,.skipPlayingSound
	ld a,(SFX_02_40 - SFX_Headers_02) / 3
	call PlaySound ; play sound
.skipPlayingSound
	pop af
	ld [H_DOWNARROWBLINKCNT2],a
	pop af
	ld [H_DOWNARROWBLINKCNT1],a ; restore previous values
	xor a
	ld [wMenuWrappingEnabled],a ; disable menu wrapping
	ld a,[hJoy5]
	ret
.noWrappingAround
	ld a,[wcc37]
	and a ; should we return if the user tried to go past the top or bottom?
	jr z,.checkOtherKeys
	jr .checkIfAButtonOrBButtonPressed