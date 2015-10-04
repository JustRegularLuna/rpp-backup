DoWonderTradeDialogue:: ; Called by an event to start the Wonder Trade process
	; Save a backup of the screen so we can get it back later
	call SaveScreenTilesToBuffer2
	
	; Display the "Welcome to the Global Terminal" text
	ld hl, WelcomeToGlobalText
	call PrintText
	call ManualTextScroll
	
	; Check if the player has a Pokedex yet
	ld a, [wd74b]
	bit 5,a ; does the player have the Pokedex?
	jr nz, .hasPokedex ; If you do, jump to the rest of the routine
	
	; If the player DOES NOT have a Pokedex, say they can't trade yet
	ld hl, BeingAdjustedText
	jp PrintText
	
	; If the player has a Pokedex, go on to ask if they want to make a Wonder Trade
.hasPokedex
	ld hl, WouldYouLikeToWonderTradeText
	call PrintText
	call YesNoChoice
	ld a,[wCurrentMenuItem]
	and a
	jr nz,.comeAgain
	call WonderTrade_DoTrade
	jr c, .comeAgain ; If the trade failed, go to the "please come again" text
	ld hl, CompletedWonderTradeText ; Otherwise do the "completed a trade" text
	jp PrintText
.comeAgain
	ld hl, ComeAgainText
	jp PrintText


; Main routine for making Wonder Trade happen
; Most of this copied directly from the in-game trade function and modified to work the way we want
WonderTrade_DoTrade:
	; Open a normal party menu and let the player choose a Pokemon
	xor a
	ld [wd07d],a
	dec a
	ld [wUpdateSpritesEnabled],a
	call DisplayPartyMenu
	push af
	call WonderTrade_RestoreScreen
	pop af
	ld a,$1
	jp c,.tradeFailed ; jump if the player didn't select a pokemon
	
	; Make sure they didn't try to offer something the game can't give in return
	ld a, [wcf91] ; Pokemon you selected
	call CheckForBanned ; Check to make sure this isn't a banned Pokemon
	and a 
	jr nz, .keepGoing ; if it wasn't banned, keep going with the trade
	ld hl, BannedMonText
	call PrintText
	call ManualTextScroll
	jr WonderTrade_DoTrade ; If it was banned, let them try again
	
	; If it wasn't banned, set what they offered as the GiveMon
.keepGoing
	ld a, [wcf91] ; Grab the Pokemon we chose from the menu again
	ld [wInGameTradeGiveMonSpecies], a ; store as the GiveMon
	ld de,wInGameTradeGiveMonName ; Location to copy its name to
	call WonderTrade_GetMonName   ; Copy the name of the Pokemon the player chose into this address
	
	; Ask if the player is sure they want to trade this Pokemon
	ld hl, AreYouSureText
	call PrintText
	call YesNoChoice
	ld a,[wCurrentMenuItem]
	and a
	jr nz,.tradeFailed ; If not, cancel the trade
	
	; Setup the variables for the Received Pokemon name and ID before the trade
	call GetWonderTradeReceiveMon ; Come up with a Random Pokemon for them to receive
	ld [wInGameTradeReceiveMonSpecies],a ; Store this as the ReceiveMon
	ld de,wInGameTradeReceiveMonName ; Location to copy its name to
	call WonderTrade_GetMonName      ; Copy the name of the Pokemon to this address
	ld a, [wInGameTradeReceiveMonSpecies] ; Load the receivemon back into a
	ld de, wInGameTradeMonNick  ; Location to copy its name to again
	call WonderTrade_GetMonName ; Copy its name to be the Nickname
	
	; Take whatever level the Pokemon you offered was, and set it to be the level the received 'mon will be
	ld a,[wWhichPokemon]
	ld hl,wPartyMon1Level
	ld bc,$002c
	call AddNTimes
	ld a,[hl]
	ld [W_CURENEMYLVL],a
	
	; Connet the link cable like so
	ld hl, WonderConnectCableText
	call PrintText
	
	; Do the actual trade stuff
	ld a,[wWhichPokemon]
	push af
	ld a,[W_CURENEMYLVL]
	push af
	call LoadHpBarAndStatusTilePatterns
	call WonderTrade_PrepareTradeData
	predef Func_410e2
	pop af
	ld [W_CURENEMYLVL],a
	pop af
	ld [wWhichPokemon],a
	ld a,[wInGameTradeReceiveMonSpecies]
	ld [wcf91],a
	xor a
	ld [wcc49],a
	ld [wcf95],a
	call RemovePokemon
	ld a,$80
	ld [wcc49],a
	call AddPartyMon
	call WonderTrade_CopyDataToReceivedMon
	callab EvolveTradeMon
	call ClearScreen
	call WonderTrade_RestoreScreen
	callba RedrawMapView
	and a
	ld a,$3
	jr .tradeSucceeded
.tradeFailed
	scf
.tradeSucceeded
	ret

WonderTrade_RestoreScreen: ; Restore the screen stuff when we're done
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call ReloadTilesetTilePatterns
	call LoadScreenTilesFromBuffer2
	call Delay3
	call LoadGBPal
	ld c, 10
	call DelayFrames
	ld b, BANK(LoadWildData)
	ld hl, LoadWildData
	jp Bankswitch

WonderTrade_PrepareTradeData: ; Get the data setup for the trade
	ld hl, wTradedPlayerMonSpecies
	ld a, [wInGameTradeGiveMonSpecies]
	ld [hli], a ; wTradedPlayerMonSpecies
	ld a, [wInGameTradeReceiveMonSpecies]
	ld [hl], a ; wTradedEnemyMonSpecies
	ld hl, wPartyMonOT
	ld bc, $b
	ld a, [wWhichPokemon]
	call AddNTimes
	ld de, wTradedPlayerMonOT
	ld bc, $b
	call WonderTrade_CopyData
	ld hl, WonderTrade_TrainerString
	ld de, wcd4e
	call WonderTrade_CopyData
	ld de, W_GRASSRATE
	call WonderTrade_CopyData
	ld hl, wPartyMon1OTID
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes
	ld de, wTradedPlayerMonOTID
	ld bc, $2
	call WonderTrade_CopyData
	call Random
	ld hl, hRandomAdd
	ld de, wTradedEnemyMonOTID
	jp CopyData

; copies name of species a to hl
WonderTrade_GetMonName:
	push de
	ld [wd11e],a
	call GetMonName
	ld hl,wcd6d
	pop de
	ld bc,$b
	jp CopyData

; Copy data without losing your place
WonderTrade_CopyData:
	push hl
	push bc
	call CopyData
	pop bc
	pop hl
	ret

WonderTrade_CopyDataToReceivedMon: ; Copy the Nickname and OT from RAM to the Pokemon
	ld hl, wPartyMonNicks
	ld bc, $b
	call WonderTrade_GetReceivedMonPointer
	ld hl, wInGameTradeMonNick
	ld bc, $b
	call CopyData
	ld hl, wPartyMonOT
	ld bc, $b
	call WonderTrade_GetReceivedMonPointer
	ld hl, WonderTrade_TrainerString
	ld bc, $b
	call CopyData
	ld hl, wPartyMon1OTID
	ld bc, wPartyMon2 - wPartyMon1
	call WonderTrade_GetReceivedMonPointer
	ld hl, wTradedEnemyMonOTID
	ld bc, $2
	jp CopyData

; the received mon's index is (partyCount - 1),
; so this adds bc to hl (partyCount - 1) times and moves the result to de
WonderTrade_GetReceivedMonPointer:
	ld a, [wPartyCount]
	dec a
	call AddNTimes
	ld e, l
	ld d, h
	ret

WonderTrade_TrainerString:
	db "MYSTERY@@@@"

; Stores a random Pokemon ID into register a
; Makes sure it is a valid Pokemon ID
; Makes sure it is NOT in the list of banned pokemon
GetWonderTradeReceiveMon:
	call Random ; Get a random number
	and a ; Check if it was 0
	jr z, GetWonderTradeReceiveMon ; If it was zero, try again
	cp NUM_POKEMON + 1 ; Make sure it is a valid Pokemon ID
	jr nc, GetWonderTradeReceiveMon ; If it wasn't, try again
	ld b, a ; Store this in Register b so we don't lose it
	ld hl, BannedMons ; Load the table of Pokemon that we don't need showing up in Wonder Trade
.loop
	ld a, [hli] ; Read entry from list
	cp b ; See if it matches the ID we generated
	jr z, GetWonderTradeReceiveMon ; If it does, try again
	inc a ; Increase it, to see if we hit the end of the list ($FF)
	jr nz, .loop ; If we haven't hit the end of the list, keep checking
	ld a,b ; If we made it through the list ok, put the ID we generated back into a where it needs to be
	ret ; We're done here

CheckForBanned: ; Check if the player tried to trade a banned Pokemon
	ld b,a ; store in b so we don't lose it
	ld hl,BannedMons ; load table of banned mons
.loop
	ld a, [hli] ; read the entry from the list
	cp b ; see if it matches the one the player chose
	jr z, .banned ; if it did, mark that as a banned Pokemon
	inc a ; otherwise, check to see if we are at the end of the list
	jr nz, .loop ; if we aren't, loop again to keep reading the list
	ld a,b ; if we're done, put the Pokemon ID back in a 
	ret
.banned ; if the Pokemon was banned, set a to zero
	xor a
	ret

BannedMons: ; List of Pokemon not allowed to show up in Wonder Trade
db ARTICUNO
db ZAPDOS
db MOLTRES
db MEWTWO
db MEW
db LUGIA
db LATIOS
db LATIAS
db $FF

WonderConnectCableText:
	TX_FAR _ConnectCableText
	db "@"

WelcomeToGlobalText:
	text "Connecting to the"
	line "GLOBAL TERMINAL.@@"

BeingAdjustedText:
	text "The system is"
	line "currently under"
	cont "maintenance."
	
	para "Please try back"
	line "later.@@"

WouldYouLikeToWonderTradeText:
	text "Would you like to"
	line "use WONDER TRADE?@@"
	
ComeAgainText:
	text "Come again!@@"
	
CompletedWonderTradeText:
	text $52," completed"
	line "a WONDER TRADE!@@"
	
BannedMonText:
	text "Error! That"
	line "#MON is not"
	cont "allowed."
	
	para "Please choose"
	line "again.@@"
	
AreYouSureText:
	text "You will not be"
	line "able to get your"
	cont "#MON back if"
	cont "you continue."
	
	para "Are you sure you"
	line "want to trade?@@"
