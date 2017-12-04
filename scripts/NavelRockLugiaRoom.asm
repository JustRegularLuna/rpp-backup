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
	dw NavelRockLugiaRoomText1

NavelRockLugiaRoomTrainerHeaders:
NavelRockLugiaRoomTrainerHeader0:
	dbEventFlagBit EVENT_BEAT_LUGIA
	db ($0 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_LUGIA
	dw NavelRockLugiaRoomLugiaText ; TextBeforeBattle
	dw NavelRockLugiaRoomLugiaText ; TextAfterBattle
	dw NavelRockLugiaRoomLugiaText ; TextEndBattle
	dw NavelRockLugiaRoomLugiaText ; TextEndBattle

	db $ff

NavelRockLugiaRoomText1:
	TX_ASM
	ld hl, NavelRockLugiaRoomTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

NavelRockLugiaRoomLugiaText:
	TX_FAR _NavelRockLugiaRoomLugiaText
	TX_ASM
	ld a, LUGIA
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
