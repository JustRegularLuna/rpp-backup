; Handles functionality for Headbutt outside of battle
; Headbutt Pokemon tables are stored in data/wildPokemon/tree_mons.asm
; engine/battle/16.asm needs to include the check for W_MOVEMISSED being 2 for _FellOutOfTreeText
; without that check, it will claim the Pokemon was hooked by a rod
UseHeadbuttOW::
	xor a
	ld [wActionResultOrTookBattleTurn], a
	ld a, [W_CURMAPTILESET]
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
	cp $A0
	jr c, .getHeadbuttMon
	ld hl, NoHeadbuttMonText
	jp PrintText

.getHeadbuttMon
	ld a, [W_CURMAP]
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
	ld a, 2
	ld [W_MOVEMISSED], a ; fell out of tree text at start of battle
	ld a, [hli]
	ld [W_CURENEMYLVL], a
	ld a, [hl]
	ld [W_CUROPPONENT], a
	xor a
	ld [wIsTrainerBattle], a ; make sure this doesn't try to be a glitch trainer
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
