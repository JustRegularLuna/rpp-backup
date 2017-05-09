SouthernIslandInsideScript:
	call EnableAutoTextBoxDrawing
	ld hl, SouthernIslandInsideTrainerHeaders
	ld de, SouthernIslandInsideScriptPointers
	ld a, [wSouthernIslandInsideCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSouthernIslandInsideCurScript], a
	ret

SouthernIslandInsideScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SouthernIslandInsideTextPointers:
	dw SouthernIslandInsideText1
	dw SouthernIslandInsideText2
	dw SouthernIslandObjectText

SouthernIslandInsideTrainerHeaders:
SouthernIslandInsideTrainerHeader0:
	db $3 ; flag's bit
	db ($0 << 4) ; trainer's view range
	dw wd85f ; flag's byte
	dw SouthernIslandInsideLatiosText ; TextBeforeBattle
	dw SouthernIslandInsideLatiosText ; TextAfterBattle
	dw SouthernIslandInsideLatiosText ; TextEndBattle
	dw SouthernIslandInsideLatiosText ; TextEndBattle

SouthernIslandInsideTrainerHeader1:
	db $4 ; flag's bit
	db ($0 << 4) ; trainer's view range
	dw wd85f ; flag's byte
	dw SouthernIslandInsideLatiasText ; TextBeforeBattle
	dw SouthernIslandInsideLatiasText ; TextAfterBattle
	dw SouthernIslandInsideLatiasText ; TextEndBattle
	dw SouthernIslandInsideLatiasText ; TextEndBattle
	
	db $ff

SouthernIslandInsideText1:
	TX_ASM
	ld hl, SouthernIslandInsideTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd
	
SouthernIslandInsideText2:
	TX_ASM
	ld hl, SouthernIslandInsideTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SouthernIslandInsideLatiosText:
	TX_FAR _SouthernIslandInsideLatiText
	TX_ASM
	ld a, LATIOS
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
	
SouthernIslandInsideLatiasText:
	TX_FAR _SouthernIslandInsideLatiText
	TX_ASM
	ld a, LATIAS
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

SouthernIslandObjectText:
	text "All dreams are"
	line "but another"
	cont "reality."
	
	para "Never forget...@@"
