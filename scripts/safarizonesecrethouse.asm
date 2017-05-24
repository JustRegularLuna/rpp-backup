SafariZoneSecretHouseScript: ; 4a317 (12:6317)
	jp EnableAutoTextBoxDrawing

SafariZoneSecretHouseTextPointers: ; 4a31a (12:631a)
	dw SafariZoneSecretHouseText1

SafariZoneSecretHouseText1: ; 4a31c (12:631c)
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

SafariZoneSecretHouseText_4a350: ; 4a350 (12:6350)
	TX_FAR _SecretHouseText_4a350
	db "@"

ReceivedHM03Text: ; 4a355 (12:6355)
	TX_FAR _ReceivedHM03Text
	db $0B, "@"

HM03ExplanationText: ; 4a35b (12:635b)
	TX_FAR _HM03ExplanationText
	db "@"

HM03NoRoomText: ; 4a360 (12:6360)
	TX_FAR _HM03NoRoomText
	db "@"
