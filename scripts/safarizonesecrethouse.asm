SafariZoneSecretHouseScript: ; 4a317 (12:6317)
	jp EnableAutoTextBoxDrawing

SafariZoneSecretHouseTextPointers: ; 4a31a (12:631a)
	dw SafariZoneSecretHouseText1

SafariZoneSecretHouseText1: ; 4a31c (12:631c)
	db $08 ; asm
	ld a, [wd857]
	bit 0, a
	jr nz, .already_received ; 0x4a322
	ld hl, SafariZoneSecretHouseText_4a350
	call PrintText
	ld bc, (TM_15 << 8) | 1
	call GiveItem
	jr nc, .BagFull
	ld hl, ReceivedTM15Text
	call PrintText
	ld hl, wd857
	set 0, [hl]
	jr .done ; 0x4a33d
.BagFull
	ld hl, TM15NoRoomText
	call PrintText
	jr .done ; 0x4a345
.already_received ; 0x4a347
	ld hl, TM15ExplanationText
	call PrintText
.done ; 0x4a34d
	jp TextScriptEnd

SafariZoneSecretHouseText_4a350: ; 4a350 (12:6350)
	TX_FAR _SecretHouseText_4a350
	db "@"

ReceivedTM15Text: ; 4a355 (12:6355)
	TX_FAR _ReceivedTM15Text
	db $0B, "@"

TM15ExplanationText: ; 4a35b (12:635b)
	TX_FAR _TM15ExplanationText
	db "@"

TM15NoRoomText: ; 4a360 (12:6360)
	TX_FAR _TM15NoRoomText
	db "@"
