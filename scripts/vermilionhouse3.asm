VermilionHouse3Script:
	jp EnableAutoTextBoxDrawing

VermilionHouse3TextPointers:
	dw VermilionHouse3Text1

VermilionHouse3Text1:
	TX_ASM
	ld hl, Trader4Name
	call SetCustomName
	ld a, $4
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	jp TextScriptEnd

Trader4Name:
	db "Jenny@"
