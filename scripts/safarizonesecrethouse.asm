SafariZoneSecretHouseScript:
	jp EnableAutoTextBoxDrawing

SafariZoneSecretHouseTextPointers:
	dw SafariZoneSecretHouseText1

SafariZoneSecretHouseText1:
	TX_ASM
	CheckEvent EVENT_GOT_HM03
	jr nz, .already_received
	ld hl, SafariZoneSecretHouseText_4a350
	call PrintText
	lb bc, HM_03, 1
	call GiveItem
	jr nc, .BagFull
	ld hl, ReceivedHM03Text
	call PrintText
	SetEvent EVENT_GOT_HM03
	jr .done
.BagFull
	ld hl, HM03NoRoomText
	call PrintText
	jr .done
.already_received
	ld hl, HM03ExplanationText
	call PrintText
.done
	jp TextScriptEnd

SafariZoneSecretHouseText_4a350:
	TX_FAR _SecretHouseText_4a350
	db "@"

ReceivedHM03Text:
	TX_FAR _ReceivedHM03Text
	TX_SFX_ITEM_1
	db "@"

HM03ExplanationText:
	TX_FAR _HM03ExplanationText
	db "@"

HM03NoRoomText:
	TX_FAR _HM03NoRoomText
	db "@"
