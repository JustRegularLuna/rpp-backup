CeladonMansion3Script:
	jp EnableAutoTextBoxDrawing

CeladonMansion3TextPointers:
	dw ProgrammerText
	dw GraphicArtistText
	dw WriterText
	dw DirectorText
	dw GameFreakPCText1
	dw GameFreakPCText2
	dw GameFreakPCText3
	dw GameFreakSignText

ProgrammerText:
	TX_FAR _ProgrammerText
	db "@"

GraphicArtistText:
	TX_FAR _GraphicArtistText
	db "@"

WriterText:
	TX_FAR _WriterText
	db "@"

DirectorText:
	TX_ASM
	ld a, [wExtraFlags]
	bit 3, a
	jr nz, .alreadyGiven

	; check pokédex
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld a, [wNumSetBits]
	cp 150
	jr nc, .Enough
	
	; if you haven't gotten it yet, and you don't have enough
	ld hl, .GameDesigner
	call PrintText
	jp TextScriptEnd

.Enough
	ld hl, .GameDesignerGiveTicketText
	call PrintText
	ld b, EON_TICKET
	ld c, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, .ReceivedEonTicketText
	call PrintText
	ld hl, wExtraFlags
	set 3, [hl]
.alreadyGiven
	ld hl, .Already
	call PrintText
	jp TextScriptEnd
	
.bagFull
	ld hl, .noRoom
	call PrintText
	jp TextScriptEnd
	
.GameDesigner
	TX_FAR _GameDesignerText
	db "@"
	
.Already
	TX_FAR _GameDesignerAlreadyGivenText
	db "@"
	
.noRoom
	TX_FAR _NoMoreRoomForItemText
	db "@"
	
.GameDesignerGiveTicketText
	TX_FAR _GameDesignerGiveTicketText
	db "@"
	
.ReceivedEonTicketText
	TX_FAR _ReceivedEonTicketText
	db $0B
	db "@"

GameFreakPCText1:
	TX_FAR _CeladonMansion3Text5
	db $6
	TX_ASM
	callba ProgrammerComputerScreen
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	jp TextScriptEnd

GameFreakPCText2:
	TX_FAR _CeladonMansion3Text6
	db $6
	TX_ASM
	callba TetrisComputerScreen
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	jp TextScriptEnd

GameFreakPCText3:
	TX_FAR _CeladonMansion3Text7
	db $6
	TX_ASM
	callba ScriptComputerScreen
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	jp TextScriptEnd

GameFreakSignText:
	TX_FAR _CeladonMansion3Text8
	db "@"
