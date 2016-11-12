MtMoonPokecenterText4: ; Repointed to end of bank to expand this without breaking saves
	db $08 ; asm
	ld a, [wd7c6]
	add a
	jp c, .alreadyBoughtMagikarp
	ld hl, MtMoonPokecenterText_4935c
	call PrintText
	ld a, $13
	ld [wTextBoxID], a
	call DisplayTextBoxID
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .choseNo
	ldh [$9f], a
	ldh [$a1], a
	ld a, $5
	ldh [$a0], a
	call HasEnoughMoney
	jr nc, .enoughMoney
	ld hl, MtMoonPokecenterText_49366
	jr .printText
.enoughMoney
	; this Magikarp is shiny
	ld hl, wExtraFlags
	set 0, [hl]
	lb bc, MAGIKARP, 5
	call GivePokemon
	jr nc, .done
	xor a
	ld [wWhichTrade], a
	ld [wTrainerFacingDirection], a
	ld a, $5
	ld [wTrainerEngageDistance], a
	ld hl, wTrainerFacingDirection
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef
	ld a, $13
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wd7c6
	set 7, [hl]
	jr .done
.choseNo
	ld hl, MtMoonPokecenterText_49361
	jr .printText
.alreadyBoughtMagikarp
	ld hl, MtMoonPokecenterText_4936b
.printText
	call PrintText
.done
	; reset the shiny flag just in case buying it failed, so the next wildmon isn't accidentally shiny
	ld hl, wExtraFlags
	res 0, [hl]
	jp TextScriptEnd