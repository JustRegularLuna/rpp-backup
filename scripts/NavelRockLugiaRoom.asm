NavelRockLugiaRoomScript:
	call EnableAutoTextBoxDrawing
	ld hl, NavelRockLugiaRoomTrainerHeaders
	ld de, NavelRockLugiaRoomScriptPointers
	ld a, [wNavelRockLugiaRoomCurScript]
	call ExecuteCurMapScriptInTable
	ld [wNavelRockLugiaRoomCurScript], a
	ret

NavelRockLugiaRoomScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

NavelRockLugiaRoomTextPointers:
	dw NavelRockLugiaRoomText1 ; Lugia
	dw NavelRockLugiaRoomText2 ; Ho-oh

NavelRockLugiaRoomTrainerHeaders:
NavelRockLugiaRoomTrainerHeader0:
	dbEventFlagBit EVENT_BEAT_LUGIA
	db ($0 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_LUGIA
	dw NavelRockLugiaRoomLugiaText ; TextBeforeBattle
	dw NavelRockLugiaRoomLugiaText ; TextAfterBattle
	dw NavelRockLugiaRoomLugiaText ; TextEndBattle
	dw NavelRockLugiaRoomLugiaText ; TextEndBattle

NavelRockLugiaRoomTrainerHeader1:
	dbEventFlagBit EVENT_BEAT_HO_OH
	db ($0 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_HO_OH
	dw NavelRockLugiaRoomHoohText ; TextBeforeBattle
	dw NavelRockLugiaRoomHoohText ; TextAfterBattle
	dw NavelRockLugiaRoomHoohText ; TextEndBattle
	dw NavelRockLugiaRoomHoohText ; TextEndBattle

	db $ff

NavelRockLugiaRoomText1:
	TX_ASM
	ld hl, NavelRockLugiaRoomTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

NavelRockLugiaRoomText2:
	TX_ASM
	ld hl, NavelRockLugiaRoomTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

NavelRockLugiaRoomLugiaText:
	TX_FAR _NavelRockLugiaRoomLugiaText
	TX_ASM
	ld a, LUGIA
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

NavelRockLugiaRoomHoohText:
	TX_FAR _NavelRockLugiaRoomHoohText
	TX_ASM
	ld a, HO_OH
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
