RedsHouse1FScript:
	jp EnableAutoTextBoxDrawing

RedsHouse1FTextPointers:
	dw RedsHouse1FText1
	dw RedsHouse1FText2
	dw RedsHouse1FText3
	dw RedsHouse1FText4
	dw RedsHouse1FText5

RedsHouse1FText1: ; Mom
	TX_ASM
	ld a, [wd72e]
	bit 3, a
	jr nz, .heal ; if player has received a Pokémon from Oak, heal team
	ld a, [wPlayerGender]
	and a
	jr nz, .girl
	ld hl, MomWakeUpText
	call PrintText
	jr .done
.girl
	ld hl, MomWakeUpText2
	call PrintText
	jr .done
.heal
	call MomHealPokemon
.done
	jp TextScriptEnd

MomWakeUpText:
	TX_FAR _MomWakeUpText
	db "@"
	
MomWakeUpText2:
	TX_FAR _MomWakeUpText2
	db "@"

MomHealPokemon:
	ld hl, MomHealText1
	call PrintText
	call GBFadeOutToWhite
	call ReloadMapData
	predef HealParty
	ld a, MUSIC_PKMN_HEALED
	ld [wNewSoundID], a
	call PlaySound
.next
	ld a, [wChannelSoundIDs]
	cp MUSIC_PKMN_HEALED
	jr z, .next
	ld a, [wMapMusicSoundID]
	ld [wNewSoundID], a
	call PlaySound
	call GBFadeInFromWhite
	ld hl, MomHealText2
	jp PrintText

MomHealText1:
	TX_FAR _MomHealText1
	db "@"
MomHealText2:
	TX_FAR _MomHealText2
	db "@"

RedsHouse1FText2: ; TV
	TX_ASM
	ld a,[wSpriteStateData1 + 9]
	cp SPRITE_FACING_UP
	ld hl,TVWrongSideText
	jr nz,.done ; if player is not facing up
	ld a, [wPlayerGender]
	and a
	jr nz, .girl
	ld hl,StandByMeText
	jr .done
.girl
	ld hl,WizardOfOzText
.done
	call PrintText
	jp TextScriptEnd

StandByMeText:
	TX_FAR _StandByMeText
	db "@"
	
WizardOfOzText:
	TX_FAR _WizardOfOzText
	db "@"

TVWrongSideText:
	TX_FAR _TVWrongSideText
	db "@"

RedsHouse1FText3:
	TX_FAR _FridgeText
	db "@"
	
RedsHouse1FText4:
	TX_FAR _StoveText
	db "@"
	
RedsHouse1FText5:
	TX_FAR _SinkText
	db "@"
	