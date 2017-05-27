MtMoon3Script: ; 49d0b (12:5d0b)
	call EnableAutoTextBoxDrawing
	ld hl, MtMoon3TrainerHeader0
	ld de, MtMoon3ScriptPointers
	ld a, [wMtMoon3CurScript]
	call ExecuteCurMapScriptInTable
	ld [wMtMoon3CurScript], a
	ret

MtMoon3ScriptPointers: ; 49d63 (12:5d63)
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

MtMoon3TextPointers: ; 49e34 (12:5e34)
	dw MtMoon3Text1
	dw MtMoon3Text2
	dw MtMoon3Text3
	dw MtMoon3Text4
	dw MtMoon3Text5
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText

MtMoon3TrainerHeaders: ; 49e48 (12:5e48)
MtMoon3TrainerHeader0:
	dbEventFlagBit EVENT_BEAT_MT_MOON_EXIT_SUPER_NERD
	db ($2 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MT_MOON_EXIT_SUPER_NERD
	dw MtMoon3BattleText1 ; TextBeforeBattle
	dw MtMoon3AfterBattleText1 ; TextAfterBattle
	dw MtMoon3EndBattleText1 ; TextEndBattle
	dw MtMoon3EndBattleText1 ; TextEndBattle

MtMoon3TrainerHeader1: ; 49e48 (12:5e48)
	dbEventFlagBit EVENT_BEAT_MT_MOON_3_TRAINER_0
	db ($4 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MT_MOON_3_TRAINER_0
	dw MtMoon3BattleText2 ; TextBeforeBattle
	dw MtMoon3AfterBattleText2 ; TextAfterBattle
	dw MtMoon3EndBattleText2 ; TextEndBattle
	dw MtMoon3EndBattleText2 ; TextEndBattle

MtMoon3TrainerHeader2: ; 49e54 (12:5e54)
	dbEventFlagBit EVENT_BEAT_MT_MOON_3_TRAINER_2
	db ($4 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MT_MOON_3_TRAINER_2
	dw MtMoon3BattleText3 ; TextBeforeBattle
	dw MtMoon3AfterBattleText3 ; TextAfterBattle
	dw MtMoon3EndBattleText3 ; TextEndBattle
	dw MtMoon3EndBattleText3 ; TextEndBattle

MtMoon3TrainerHeader3: ; 49e60 (12:5e60)
	dbEventFlagBit EVENT_BEAT_MT_MOON_3_TRAINER_3
	db ($4 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MT_MOON_3_TRAINER_3
	dw MtMoon3BattleText4 ; TextBeforeBattle
	dw MtMoon3AfterBattleText4 ; TextAfterBattle
	dw MtMoon3EndBattleText4 ; TextEndBattle
	dw MtMoon3EndBattleText4 ; TextEndBattle

MtMoon3TrainerHeader4: ; 49e6c (12:5e6c)
	dbEventFlagBit EVENT_BEAT_MT_MOON_3_TRAINER_4
	db ($4 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MT_MOON_3_TRAINER_4
	dw MtMoon3BattleText5 ; TextBeforeBattle
	dw MtMoon3AfterBattleText5 ; TextAfterBattle
	dw MtMoon3EndBattleText5 ; TextEndBattle
	dw MtMoon3EndBattleText5 ; TextEndBattle

	db $ff


MtMoon3Text1: ; 49e79 (12:5e79)
	TX_ASM
	ld hl, MtMoon3TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

MtMoon3Text2: ; 49ec1 (12:5ec1)
	TX_ASM
	ld hl, MtMoon3TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

MtMoon3Text3: ; 49ecb (12:5ecb)
	TX_ASM
	ld hl, MtMoon3TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

MtMoon3Text4: ; 49ed5 (12:5ed5)
	TX_ASM
	ld hl, MtMoon3TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

MtMoon3Text5: ; 49edf (12:5edf)
	TX_ASM
	ld hl, MtMoon3TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd


MtMoon3BattleText1: ; 49f85 (12:5f85)
	TX_FAR _MtMoon3BattleText1
	db "@"

MtMoon3EndBattleText1: ; 49f8a (12:5f8a)
	TX_FAR _MtMoon3EndBattleText1
	db "@"

MtMoon3AfterBattleText1: ; 49f8f (12:5f8f)
	TX_FAR _MtMoon3AfterBattleText1
	db "@"

MtMoon3BattleText2: ; 49f9f (12:5f9f)
	TX_FAR _MtMoon3BattleText2
	db "@"

MtMoon3EndBattleText2: ; 49fa4 (12:5fa4)
	TX_FAR _MtMoon3EndBattleText2
	db "@"

MtMoon3AfterBattleText2: ; 49fa9 (12:5fa9)
	TX_FAR _MtMoon3AfterBattleText2
	db "@"

MtMoon3BattleText3: ; 49fae (12:5fae)
	TX_FAR _MtMoon3BattleText3
	db "@"

MtMoon3EndBattleText3: ; 49fb3 (12:5fb3)
	TX_FAR _MtMoon3EndBattleText3
	db "@"

MtMoon3AfterBattleText3: ; 49fb8 (12:5fb8)
	TX_FAR _MtMoon3AfterBattleText3
	db "@"

MtMoon3BattleText4: ; 49fbd (12:5fbd)
	TX_FAR _MtMoon3BattleText4
	db "@"

MtMoon3EndBattleText4: ; 49fc2 (12:5fc2)
	TX_FAR _MtMoon3EndBattleText4
	db "@"

MtMoon3AfterBattleText4: ; 49fc7 (12:5fc7)
	TX_FAR _MtMoon3AfterBattleText4
	db "@"

MtMoon3BattleText5: ; 49fcc (12:5fcc)
	TX_FAR _MtMoon3BattleText5
	db "@"

MtMoon3EndBattleText5: ; 49fd1 (12:5fd1)
	TX_FAR _MtMoon3EndBattleText5
	db "@"

MtMoon3AfterBattleText5: ; 49fd6 (12:5fd6)
	TX_FAR _MtMoon3AfterBattleText5
	db "@"
