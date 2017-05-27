MtMoon3Script:
	call EnableAutoTextBoxDrawing
	ld hl, MtMoon3TrainerHeader0
	ld de, MtMoon3ScriptPointers
	ld a, [wMtMoon3CurScript]
	call ExecuteCurMapScriptInTable
	ld [wMtMoon3CurScript], a
	ret

MtMoon3ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

MtMoon3TextPointers:
	dw MtMoon3Text1
	dw MtMoon3Text2
	dw MtMoon3Text3
	dw MtMoon3Text4
	dw MtMoon3Text5
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText

MtMoon3TrainerHeaders:
MtMoon3TrainerHeader0:
	dbEventFlagBit EVENT_BEAT_MT_MOON_EXIT_SUPER_NERD
	db ($2 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MT_MOON_EXIT_SUPER_NERD
	dw MtMoon3BattleText1 ; TextBeforeBattle
	dw MtMoon3AfterBattleText1 ; TextAfterBattle
	dw MtMoon3EndBattleText1 ; TextEndBattle
	dw MtMoon3EndBattleText1 ; TextEndBattle

MtMoon3TrainerHeader1:
	dbEventFlagBit EVENT_BEAT_MT_MOON_3_TRAINER_0
	db ($4 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MT_MOON_3_TRAINER_0
	dw MtMoon3BattleText2 ; TextBeforeBattle
	dw MtMoon3AfterBattleText2 ; TextAfterBattle
	dw MtMoon3EndBattleText2 ; TextEndBattle
	dw MtMoon3EndBattleText2 ; TextEndBattle

MtMoon3TrainerHeader2:
	dbEventFlagBit EVENT_BEAT_MT_MOON_3_TRAINER_2
	db ($4 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MT_MOON_3_TRAINER_2
	dw MtMoon3BattleText3 ; TextBeforeBattle
	dw MtMoon3AfterBattleText3 ; TextAfterBattle
	dw MtMoon3EndBattleText3 ; TextEndBattle
	dw MtMoon3EndBattleText3 ; TextEndBattle

MtMoon3TrainerHeader3:
	dbEventFlagBit EVENT_BEAT_MT_MOON_3_TRAINER_3
	db ($4 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MT_MOON_3_TRAINER_3
	dw MtMoon3BattleText4 ; TextBeforeBattle
	dw MtMoon3AfterBattleText4 ; TextAfterBattle
	dw MtMoon3EndBattleText4 ; TextEndBattle
	dw MtMoon3EndBattleText4 ; TextEndBattle

MtMoon3TrainerHeader4:
	dbEventFlagBit EVENT_BEAT_MT_MOON_3_TRAINER_4
	db ($4 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MT_MOON_3_TRAINER_4
	dw MtMoon3BattleText5 ; TextBeforeBattle
	dw MtMoon3AfterBattleText5 ; TextAfterBattle
	dw MtMoon3EndBattleText5 ; TextEndBattle
	dw MtMoon3EndBattleText5 ; TextEndBattle

	db $ff


MtMoon3Text1:
	TX_ASM
	ld hl, MtMoon3TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

MtMoon3Text2:
	TX_ASM
	ld hl, MtMoon3TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

MtMoon3Text3:
	TX_ASM
	ld hl, MtMoon3TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

MtMoon3Text4:
	TX_ASM
	ld hl, MtMoon3TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

MtMoon3Text5:
	TX_ASM
	ld hl, MtMoon3TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd


MtMoon3BattleText1:
	TX_FAR _MtMoon3BattleText1
	db "@"

MtMoon3EndBattleText1:
	TX_FAR _MtMoon3EndBattleText1
	db "@"

MtMoon3AfterBattleText1:
	TX_FAR _MtMoon3AfterBattleText1
	db "@"

MtMoon3BattleText2:
	TX_FAR _MtMoon3BattleText2
	db "@"

MtMoon3EndBattleText2:
	TX_FAR _MtMoon3EndBattleText2
	db "@"

MtMoon3AfterBattleText2:
	TX_FAR _MtMoon3AfterBattleText2
	db "@"

MtMoon3BattleText3:
	TX_FAR _MtMoon3BattleText3
	db "@"

MtMoon3EndBattleText3:
	TX_FAR _MtMoon3EndBattleText3
	db "@"

MtMoon3AfterBattleText3:
	TX_FAR _MtMoon3AfterBattleText3
	db "@"

MtMoon3BattleText4:
	TX_FAR _MtMoon3BattleText4
	db "@"

MtMoon3EndBattleText4:
	TX_FAR _MtMoon3EndBattleText4
	db "@"

MtMoon3AfterBattleText4:
	TX_FAR _MtMoon3AfterBattleText4
	db "@"

MtMoon3BattleText5:
	TX_FAR _MtMoon3BattleText5
	db "@"

MtMoon3EndBattleText5:
	TX_FAR _MtMoon3EndBattleText5
	db "@"

MtMoon3AfterBattleText5:
	TX_FAR _MtMoon3AfterBattleText5
	db "@"
