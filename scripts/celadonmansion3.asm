CeladonMansion3Script: ; 48790 (12:4790)
	jp EnableAutoTextBoxDrawing

CeladonMansion3TextPointers: ; 48793 (12:4793)
	dw ProgrammerText
	dw GraphicArtistText
	dw WriterText
	dw DirectorText
	dw GameFreakPCText1
	dw GameFreakPCText2
	dw GameFreakPCText3
	dw GameFreakSignText

ProgrammerText: ; 487a3 (12:47a3)
	TX_FAR _ProgrammerText
	db "@"

GraphicArtistText: ; 487a8 (12:47a8)
	TX_FAR _GraphicArtistText
	db "@"

WriterText: ; 487ad (12:47ad)
	TX_FAR _WriterText
	db "@"

DirectorText: ; 487b2 (12:47b2)
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
	
.GameDesigner ; 487d0 (12:47d0)
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

GameFreakPCText1: ; 487eb (12:47eb)
	TX_FAR _CeladonMansion3Text5
	db $6
	TX_ASM
	callba ProgrammerComputerScreen
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	jp TextScriptEnd

GameFreakPCText2: ; 487f0 (12:47f0)
	TX_FAR _CeladonMansion3Text6
	db $6
	TX_ASM
	callba TetrisComputerScreen
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	jp TextScriptEnd

GameFreakPCText3: ; 487f5 (12:47f5)
	TX_FAR _CeladonMansion3Text7
	db $6
	TX_ASM
	callba ScriptComputerScreen
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	jp TextScriptEnd

GameFreakSignText: ; 487fa (12:47fa)
	TX_FAR _CeladonMansion3Text8
	db "@"
