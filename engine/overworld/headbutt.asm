; Handles functionality for Headbutt outside of battle
; Headbutt Pokemon tables are stored in data/wildPokemon/tree_mons.asm
UseHeadbuttOW::
	xor a
	ld [wActionResultOrTookBattleTurn], a
	ld a, [wCurMapTileset]
	and a ; OVERWORLD
	jr z, .overworld
	cp FOREST
	jr z, .forest
	cp PLATEAU
	jr nz, .noHeadbutt
	ld a, [wTileInFrontOfPlayer]
	cp $17 ; tree corner
	jr z, .useHeadbutt
	jr .noHeadbutt
.forest
	ld a, [wTileInFrontOfPlayer]
	cp $12 ; Tree corner
	jr z, .useHeadbutt
	jr .noHeadbutt
.overworld
	ld a, [wTileInFrontOfPlayer]
	cp $50 ; Tree corner
	jr z, .useHeadbutt
.noHeadbutt
	ld hl, NothingToHeadbuttText
	jp PrintText

.useHeadbutt
	ld [wCutTile], a
	ld a, $1
	ld [wActionResultOrTookBattleTurn], a
	ld a, [wWhichPokemon] ; wWhichPokemon
	ld hl, wPartyMonNicks ; wPartyMonNicks
	call GetPartyMonName
	ld hl, wd730
	set 6, [hl]
	call GBPalWhiteOutWithDelay3
	call ClearSprites
	call RestoreScreenTilesAndReloadTilePatterns
    call ReloadMapData
	ld a, $90
	ld [hWY], a
	call Delay3
	call LoadGBPal
	call LoadCurrentMapView
	call Delay3
	xor a
	ld [hWY], a

UseHeadbuttOW2:: ; for calling it when not in party menu
	ld hl, UsedHeadbuttText
	call PrintText
	ld hl, wd730
	res 6, [hl]
	call ReloadMapData
	jp GetHeadbuttMons

UsedHeadbuttText:
	TX_FAR _UsedHeadbuttText
	db "@"

NothingToHeadbuttText:
	TX_FAR _NothingToHeadbuttText
	db "@"

GetHeadbuttMons:
; First, check to see if we will have an encounter
; If we are, find the appropriate list and load a random encounter
; Else, say nothing happened
	call Random
	cp $D0
	jr c, .getHeadbuttMon

	; If you have a chain going, you always encounter a Pokemon
	; If you haven't started a chain, it can still fail
	ld a, [wChainHeadbuttStreak]
	and a
	jp z, .noHeadbuttMon

.getHeadbuttMon
	ld a, [wCurMap]
	cp REDS_HOUSE_1F
	ld hl, TreeMons1 ; If it isn't in the table, it loads the first list
	jr nc, .skipCalc

	ld hl, TreeMonPointerTable
	ld bc, $2
	call AddNTimes
	; hl now points to entry in the table

	ld a, [hli]
	ld h, [hl]
	ld l, a
	; hl now points to the start of the TreeMon data for that map

.skipCalc
	push hl ; don't lose our place

	ld a, [hRandomSub]
	ld b, a
	ld hl, TreeEncounterRateChances
.determineEncounterSlot
	ld a, [hli]
	cp b
	jr nc, .gotEncounterSlot
	inc hl
	jr .determineEncounterSlot
.gotEncounterSlot
; determine which wild mon will appear
	ld c, [hl]
	pop hl ; get the mon list back
	ld b, 0
	add hl, bc

	call CheckChainHeadbuttShiny

	ld a, 2
	ld [wMoveMissed], a ; fell out of tree text at start of battle
	ld a, [hli]
	ld [wCurEnemyLVL], a
	ld a, [hl]
	ld [wCurOpponent], a
	xor a
	ld [wIsTrainerBattle], a ; make sure this doesn't try to be a glitch trainer
	ret

.noHeadbuttMon
	ld hl, NoHeadbuttMonText
	jp PrintText

; Checks if the pokemon should be shiny, based on the current
; chain the player has built up.
; Sets the "force shiny" flag appropriately.
; Probablities are based on this research: http://mrnbayoh.github.io/pkmn6gen/chain_fishing_shiny/
; Once a chain of 20 is reached, it's approximately a 1/100 chance.
CheckChainHeadbuttShiny:
	push hl
	ld a, [wChainHeadbuttStreak]
	cp 21
	jr c, .ok
	ld a, 20  ; maximum of 20 * 2 attempts at being shiny
.ok
	sla a
	push af
	; increase chain
	ld a, [wChainHeadbuttStreak]
	cp $ff
	jr z, .maxChain
	inc a
	ld [wChainHeadbuttStreak], a
.maxChain
	pop af
	ld e, a  ; e = number of rolls to try and get shiny
	inc e
.loop
	dec e
	jr z, .end
	; Generate a random number and see if its shiny (1/256 now, since 1/1024 for normal wild)
	call Random
	; Check if a = $AA
	cp a, $AA
	jr nz, .loop
	; Force wild pokemon to be shiny
	ld hl, wExtraFlags
	set 0, [hl]
	; Reset chain
	xor a
	ld [wChainHeadbuttStreak], a
.end
	pop hl
	ret

NoHeadbuttMonText:
	TX_FAR _NoHeadbuttMonText
	db "@"

TreeEncounterRateChances:
; There are 10 slots for wild pokemon, and this is the table that defines how common each of
; those 10 slots is. A random number is generated and then the first byte of each pair in this
; table is compared against that random number. If the random number is less than or equal
; to the first byte, then that slot is chosen.  The second byte is double the slot number.
	db $32, $00 ; 51/256 = 19.9% chance of slot 0
	db $65, $02 ; 51/256 = 19.9% chance of slot 1
	db $8C, $04 ; 39/256 = 15.2% chance of slot 2
	db $A5, $06 ; 25/256 =  9.8% chance of slot 3
	db $BE, $08 ; 25/256 =  9.8% chance of slot 4
	db $D7, $0A ; 25/256 =  9.8% chance of slot 5
	db $E4, $0C ; 13/256 =  5.1% chance of slot 6
	db $F1, $0E ; 13/256 =  5.1% chance of slot 7
	db $FC, $10 ; 11/256 =  4.3% chance of slot 8
	db $FF, $12 ;  3/256 =  1.2% chance of slot 9

INCLUDE "data/wildPokemon/tree_mons.asm"
