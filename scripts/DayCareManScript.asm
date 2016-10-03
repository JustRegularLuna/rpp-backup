DayCareManScript::
; Handles breeding the DayCareMon with the Day Care Man's Ditto
    ld a, [W_DAYCARE_IN_USE]
    and a
    jp z, .NoDayCareMon
    ld hl, DayCareManText1 ; Your (daycare mon) has been hanging out with my Ditto
    call PrintText
    call IsABabymon ; Baby Pokemon cannot breed
    jp c, .isBaby
    call CanBreed ; Check if it is in the No Breed List (legendaries and Ditto)
    jp c, .cannotBreed
    ld hl, wExtraFlags ; Extra Flags
    bit 1, [hl] ; Check to see if there is a baby
    jp z, .noEggs
    ld a, [wPartyCount]
    cp $06
    jp z, .partyFull
    ld hl, DayCareManText2 ; It looks like they had an egg! Do you want the Pokemon that hatched from it?
    call PrintText
    call YesNoChoice
    ld a, [wCurrentMenuItem]
    and a
    jp nz, .nevermind
    call GetBabyID ; Reads the entry from the table, and stores it in register b
    ld c, $5
    call GivePokemon
    call SetupBabymonStats
    ld hl, wExtraFlags ; Extra flags
    res 1, [hl] ; Mark there not being a babymon at Day Care
    ret
    
.NoDayCareMon ; Runs if you don't have a Pokemon in the Day Care
    ld hl, DayCareManText3 ; Come back and see me later
    call PrintText
    ret
    
.isBaby
    ld hl, DayCareManText4 ; That Pokemon is just a baby
    call PrintText
    ret
    
.cannotBreed
    ld hl, DayCareManText5 ; I don't think that will breed
    call PrintText
    ret
    
.noEggs
    ld hl, DayCareManText6 ; They seem to be getting along ok, come back later
    call PrintText
    ret
    
.partyFull
    ld hl, DayCareManText7 ; You have no room for it, though
    call PrintText
    ret
    
.nevermind
    ld hl, wExtraFlags ; Extra Flags
    res 1, [hl] ; Mark there not being a babymon at Day Care
    ld hl, DayCareManText8 ; Ok, I'll give this to someone else, then
    call PrintText
    ret
    
IsABabymon: ; Checks if the Pokemon with the Day Care Lady is a baby
    ld hl, BabyMonList
    ld a, [wDayCareMonSpecies]
    ld b, a
.loop
    ld a, [hli]
    cp b
    jr z, .baby
    inc a
    jr nz, .loop
    xor a
    ret
.baby
    scf
    ret
    
CanBreed: ; Checks if the Pokemon cannot breed (Legendaries and Ditto)
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
    
GetBabyID: ; Read the table to determine which baby the Pokemon had
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
	ld de, DayCareManDittoDVs + 1
	ld a, [de]
	ld [hld], a
	jr .doneCopyingDVs
	
.parents2 ; same as above, but copies from opposite parents
	ld de, DayCareManDittoDVs
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

DayCareManDittoDVs: ; placeholder until there is a second daycaremon
	db ATKDEFDV_SHINY, SPDSPCDV_SHINY

INCLUDE "data/breeding_list.asm"
INCLUDE "data/no_breed_list.asm"
INCLUDE "data/babymon_list.asm"

DayCareManText1:
    text "Your @"
    TX_RAM W_DAYCAREMONNAME
    db $0
    line "has been playing"
    cont "with my DITTO."
    prompt
    db "@"
    
DayCareManText2:
    text "It looks like they"
    line "had an EGG!"
    
    para "Do you want the"
    line "#MON that"
    cont "hatched from it?@@"
    
DayCareManText3:
    TX_FAR _DayCareMText2
    db "@"
    
DayCareManText4:
    text "It's just a baby,"
    line "though."
    
    para "You'll have to"
    line "wait until later"
    cont "if you want to"
    cont "breed it.@@"
    
DayCareManText5:
    text "I don't think that"
    line "#MON can breed"
    cont "with my DITTO,"
    cont "though.@@"
    
DayCareManText6:
    text "They seem to be"
    line "getting on pretty"
    cont "well."
    
    para "You should come"
    line "back and see me"
    cont "later.@@"
    
DayCareManText7:
    text "It looks like they"
    line "had an EGG!"
    
    para "You don't seem to"
    line "have any room for"
    cont "this, though.@@"
    
DayCareManText8:
    text "Ok, I'll give this"
    line "to someone else,"
    cont "then.@@"
    
    