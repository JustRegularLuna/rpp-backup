MtMoon3Script: ; 49d0b (12:5d0b)
	call EnableAutoTextBoxDrawing
	ld hl, MtMoon3TrainerHeader0 ; $5e48
	ld de, MtMoon3ScriptPointers
	ld a, [W_MTMOON3CURSCRIPT]
	call ExecuteCurMapScriptInTable
	ld [W_MTMOON3CURSCRIPT], a
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
	dw Predef5CText
	dw Predef5CText
	dw Predef5CText
	dw Predef5CText

MtMoon3TrainerHeaders: ; 49e48 (12:5e48)
MtMoon3TrainerHeader0:
	db $1 ; flag's bit
	db ($2 << 4) ; trainer's view range
	dw wd7f6 ; flag's byte
	dw MtMoon3BattleText1 ; TextBeforeBattle
	dw MtMoon3AfterBattleText1 ; TextAfterBattle
	dw MtMoon3EndBattleText1 ; TextEndBattle
	dw MtMoon3EndBattleText1 ; TextEndBattle

MtMoon3TrainerHeader1: ; 49e48 (12:5e48)
	db $2 ; flag's bit
	db ($4 << 4) ; trainer's view range
	dw wd7f6 ; flag's byte
	dw MtMoon3BattleText2 ; 0x5f9f TextBeforeBattle
	dw MtMoon3AfterBattleText2 ; 0x5fa9 TextAfterBattle
	dw MtMoon3EndBattleText2 ; 0x5fa4 TextEndBattle
	dw MtMoon3EndBattleText2 ; 0x5fa4 TextEndBattle

MtMoon3TrainerHeader2: ; 49e54 (12:5e54)
	db $3 ; flag's bit
	db ($4 << 4) ; trainer's view range
	dw wd7f6 ; flag's byte
	dw MtMoon3BattleText3 ; 0x5fae TextBeforeBattle
	dw MtMoon3AfterBattleText3 ; 0x5fb8 TextAfterBattle
	dw MtMoon3EndBattleText3 ; 0x5fb3 TextEndBattle
	dw MtMoon3EndBattleText3 ; 0x5fb3 TextEndBattle

MtMoon3TrainerHeader3: ; 49e60 (12:5e60)
	db $4 ; flag's bit
	db ($4 << 4) ; trainer's view range
	dw wd7f6 ; flag's byte
	dw MtMoon3BattleText4 ; 0x5fbd TextBeforeBattle
	dw MtMoon3AfterBattleText4 ; 0x5fc7 TextAfterBattle
	dw MtMoon3EndBattleText4 ; 0x5fc2 TextEndBattle
	dw MtMoon3EndBattleText4 ; 0x5fc2 TextEndBattle

MtMoon3TrainerHeader4: ; 49e6c (12:5e6c)
	db $5 ; flag's bit
	db ($4 << 4) ; trainer's view range
	dw wd7f6 ; flag's byte
	dw MtMoon3BattleText5 ; 0x5fcc TextBeforeBattle
	dw MtMoon3AfterBattleText5 ; 0x5fd6 TextAfterBattle
	dw MtMoon3EndBattleText5 ; 0x5fd1 TextEndBattle
	dw MtMoon3EndBattleText5 ; 0x5fd1 TextEndBattle

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
	ld hl, MtMoon3TrainerHeader4 ; $5e6c
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
