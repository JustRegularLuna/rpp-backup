BeachHouseScript:
	jp EnableAutoTextBoxDrawing

BeachHouseTextPointers:
	dw BeachHouseText1
	dw BeachHouseText2
	dw BeachHouseText3
	dw BeachHouseText4

BeachHouseText1: ; Surfing Pikachu Tutor
	TX_FAR _BeachHouseDudeText
	TX_ASM
	ld a, 4
	ld [wWhichTrade], a
	callba MoveTutorScript
	jp TextScriptEnd

BeachHouseText2: ; Pikachu
	TX_FAR _BeachHousePikachuText
	TX_ASM
	ld a, PIKACHU
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

BeachHouseText3: ; give TM 15
	TX_ASM
	CheckEvent EVENT_GOT_TM15
	jr nz, .already_received
	ld hl, BeachHouseGiveSurfText
	call PrintText
	lb bc, TM_15, 1
	call GiveItem
	jr nc, .BagFull
	ld hl, ReceivedTM15Text
	call PrintText
	SetEvent EVENT_GOT_TM15
	jr .done
.BagFull
	ld hl, TM15NoRoomText
	call PrintText
	jr .done
.already_received
	ld hl, TM15ExplanationText
	call PrintText
.done
	jp TextScriptEnd

BeachHouseGiveSurfText:
	TX_FAR _BeachHouseGiveSurfText
	db "@"

ReceivedTM15Text:
	TX_FAR _ReceivedTM15Text
	db $0B, "@"

TM15ExplanationText:
	TX_FAR _TM15ExplanationText
	db "@"

TM15NoRoomText:
	TX_FAR _TM15NoRoomText
	db "@"
	
BeachHouseText4:
	TX_FAR _BeachHouseOldManText
	db "@"
