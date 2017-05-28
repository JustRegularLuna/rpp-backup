UndergroundPathEntranceRoute5Script:
	ld a, ROUTE_5
	ld [wLastMap], a
	ret

UndergroundPathEntranceRoute5_5d6af:
	db "@"

UndergroundPathEntranceRoute5TextPointers:
	dw UndergroundPathEntranceRoute5Text1

UndergroundPathEntranceRoute5Text1:
	TX_ASM
	ld hl, Trader3Name
	call SetCustomName
	ld a, $3
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	ld hl, UndergroundPathEntranceRoute5_5d6af
	ret

Trader3Name:
	db "Sally@"
