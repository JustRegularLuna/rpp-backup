DayCareBreederScript::
; Handles breeding DayCareMon with DayCareMon2
	ld a, [wDayCareInUse]
	bit 0, a ; is a mon with Day Care Lady?
	jp z, .NoDayCareMon
	bit 1, a ; is a mon with Day Care Man?
	jp z, .NoDayCareMon
	ld hl, DayCareBreederText1 ; Your (daycare mon) has been hanging out with (daycare mon 2)
	call PrintText
	call IsABabymon ; Baby Pokemon cannot breed
	jp c, .isBaby
	call CanBreed ; Check if it is in the No Breed List (legendaries)
	jp c, .cannotBreed
	ld a, [wDayCareInUse]
	bit 2, a ; Check to see if there is a baby
	jp z, .noEggs
	ld a, [wPartyCount]
	cp $06
	jp z, .partyFull
	ld hl, DayCareBreederText2 ; It looks like they had an egg! Do you want the Pokemon that hatched from it?
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .nevermind
	call GetBabyID ; Reads the entry from the table, and stores it in register b
	ld c, $5
	call GivePokemon
	call SetupBabymonStats
	ld hl, wDayCareInUse
	res 2, [hl] ; Mark there not being a babymon at Day Care
	ret
	
.NoDayCareMon ; Runs if you don't have a Pokemon in the Day Care
	ld hl, DayCareBreederText3 ; Come back and see me later
	jp PrintText

.isBaby
	ld hl, DayCareBreederText4 ; That Pokemon is just a baby
	jp PrintText

.cannotBreed
	ld hl, DayCareBreederText5 ; I don't think that will breed
	jp PrintText

.noEggs
	ld hl, DayCareBreederText6 ; They seem to be getting along ok, come back later
	jp PrintText

.partyFull
	ld hl, DayCareBreederText7 ; You have no room for it, though
	jp PrintText

.nevermind
	ld hl, wDayCareInUse
	res 2, [hl] ; Mark there not being a babymon at Day Care
	ld hl, DayCareBreederText8 ; Ok, I'll give this to someone else, then
	jp PrintText

IsABabymon:
; is the mon with Day Care Lady a baby?
	ld hl, BabyMonList
	ld a, [wDayCareMonSpecies]
	ld b, a
.loop
	ld a, [hli]
	cp b
	jr z, .baby
	inc a
	jr nz, .loop

; if not, is the mon with the Day Care Man a baby?
	ld hl, BabyMonList
	ld a, [wDayCareMon2Species]
	ld b, a
.loop2
	ld a, [hli]
	cp b
	jr z, .baby
	inc a
	jr nz, .loop2

.notBaby
	xor a
	ret

.baby
	scf
	ret
	
CanBreed: ; Needs to be completely redone to include checks for Gender and Egg Groups
	ld hl, NoBreedList
	ld a, [wDayCareMonSpecies]
	ld b, a
.loop
	ld a, [hli]
	cp b
	jr z, .cannot
	inc a
	jr nz, .loop
	xor a
	ret
.cannot
	scf
	ret
	
GetBabyID: ; Needs to be redone to get the egg from the Female/Non-Ditto parent
	ld a, [wDayCareMonSpecies]
	dec a
	ld c, a
	ld b, 0
	ld hl, BreedingList
	add hl,bc
	ld a, [hl]
	ld b, a
	ret

SetupBabymonStats: ; Inherit stuff from the parents, currently just DVs for now
	; Determine which 'mon this is (last in party)
	ld a, [wPartyCount]
	dec a
	push af
	ld bc, wPartyMon2 - wPartyMon1
	push bc
	ld hl, wPartyMon1DVs
	call AddNTimes
	
	; determines which DVs come from which parents
	call Random
	bit 1, a
	jr nz, .parents2
	
	ld de, wDayCareMonDVs
	ld a, [de]
	ld [hli], a
	ld de, wDayCareMon2DVs + 1
	ld a, [de]
	ld [hld], a
	jr .doneCopyingDVs
	
.parents2 ; same as above, but copies from opposite parents
	ld de, wDayCareMon2DVs
	ld a, [de]
	ld [hli], a
	ld de, wDayCareMonDVs + 1
	ld a, [de]
	ld [hld], a
	
.doneCopyingDVs
	; determine if we will randomly overwrite two of the copied DVs with new ones
	ld a, [hRandomAdd]
	bit 3, a
	jr nz, .skipNewDVs
	
	; determine which DVs to overwrite
	bit 0, a
	jr z, .firstDVbyte
	inc hl
.firstDVbyte
	ld a, [hRandomSub]
	ld [hl], a
	
.skipNewDVs
	; recalculate stats with the new DVs
	pop bc
	pop af
	ld hl, wPartyMon1Stats
	call AddNTimes
	ld d, h
	ld e, l
	ld bc, (wPartyMon1Exp + 2) - wPartyMon1Stats
	add hl, bc
	ld b, 0
	call CalcStats
	
	; set their HP equal to their new Max HP
	ld a, [wPartyCount]
	dec a
	ld bc, wPartyMon2 - wPartyMon1
	ld hl, wPartyMon1HP
	call AddNTimes
	ld d, h
	ld e, l
	ld bc, wPartyMon1MaxHP - wPartyMon1HP
	add hl, bc
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	
	;@@@ Later, there will be code for passing down Egg Moves
	ret

INCLUDE "data/breeding_list.asm"
INCLUDE "data/no_breed_list.asm"
INCLUDE "data/babymon_list.asm"

DayCareBreederText1:
	text "Your @"
	TX_RAM wDayCareMonName
	db $0
	line "has been playing"
	cont "with @"
	TX_RAM wDayCareMon2Name
	text "!"
	prompt
	db "@"
	
DayCareBreederText2:
	text "It looks like they"
	line "had an Egg!"
	
	para "Do you want the"
	line "#mon that"
	cont "hatched from it?@@"
	
DayCareBreederText3:
	TX_FAR _DayCareMText2
	db "@"
	
DayCareBreederText4:
	text "It's just a baby,"
	line "though."
	
	para "You'll have to"
	line "wait until later"
	cont "if you want to"
	cont "breed it.@@"
	
DayCareBreederText5:
	text "I don't think that"
	line "those two are able"
	cont "to breed, though.@@"
	
DayCareBreederText6:
	text "They seem to be"
	line "getting on pretty"
	cont "well."
	
	para "You should come"
	line "back and see me"
	cont "later.@@"
	
DayCareBreederText7:
	text "It looks like they"
	line "had an Egg!"
	
	para "You don't seem to"
	line "have any room for"
	cont "this, though.@@"
	
DayCareBreederText8:
	text "Ok, I'll give this"
	line "to someone else,"
	cont "then.@@"
	
	