InsideFerryScript: ; setup the stuff when you walk inside
	ld hl, wd126
	bit 5, [hl]
	res 5, [hl]
	push hl
	call nz, InsideFerry_GetLastWarp
	pop hl
	bit 7, [hl]
	res 7, [hl]
	call nz, InsideFerry_ShakeElevator
	xor a
	ld [wAutoTextBoxDrawingControl], a
	inc a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ret

InsideFerry_GetLastWarp:
	ld hl, wWarpEntries
	ld a, [wWarpedFromWhichWarp] ; last warped number
	ld b, a
	ld a, [wWarpedFromWhichMap] ; last warped map
	ld c, a
	call InsideFerry_ApplyWarpData

InsideFerry_ApplyWarpData:
	inc hl
	inc hl
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ret

InsideFerry_ShakeElevator:
	ld b, BANK(ShakeElevator)
	ld hl, ShakeElevator
	jp Bankswitch

InsideFerryTextPointers:
	dw InsideFerryText1

InsideFerryText1:
	TX_ASM
	callba EventIslandsFerryScript
	jp TextScriptEnd
