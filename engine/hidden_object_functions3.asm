; prints text for bookshelves in buildings without sign events
PrintBookshelfText:
	ld a, [wCurMapTileset]
	ld b, a
	ld a, [wTileInFrontOfPlayer]
	ld c, a
	ld hl, BookshelfTileIDs
.loop
	ld a, [hli]
	cp $ff
	jr z, .noMatch
	cp b
	jr nz, .nextBookshelfEntry1
	ld a, [hli]
	cp c
	jr nz, .nextBookshelfEntry2
	ld a, [hl]
	push af
	call EnableAutoTextBoxDrawing
	pop af
	call PrintPredefTextID
	xor a
	ld [$ffdb], a
	ret
.nextBookshelfEntry1
	inc hl
.nextBookshelfEntry2
	inc hl
	jr .loop
.noMatch
	ld a, $ff
	ld [$ffdb], a
	jpba PrintCardKeyText

; format: db tileset id, bookshelf tile id, text id
BookshelfTileIDs:
	db LAB,          40
	db_tx_pre BookOrSculptureText
	db MART,         26
	db_tx_pre PokemonStuffText
	db MART,         28
	db_tx_pre PokemonStuffText
	db MART,         54
	db_tx_pre PokemonStuffText
	db MART,         58
	db_tx_pre PokemonStuffText
	db MART,         60
	db_tx_pre PokemonStuffText
	db MART,         90
	db_tx_pre PokemonStuffText
	db MART,         92
	db_tx_pre PokemonStuffText
	db OAK_TS,       92
	db_tx_pre BookOrSculptureText
	db OAK_TS,       94
	db_tx_pre BookOrSculptureText
	db MANSION,      50
	db_tx_pre BookOrSculptureText
	db GATE,         34
	db_tx_pre BookOrSculptureText
	db SHIP,         54
	db_tx_pre BookOrSculptureText
	db REDS_HOUSE_1, 50
	db_tx_pre BookOrSculptureText
	db PLATEAU,      48
	db_tx_pre IndigoPlateauStatues
	db HOUSE,        60
	db_tx_pre TownMapText
	db HOUSE,        50
	db_tx_pre BookOrSculptureText
	db GYM,          29
	db_tx_pre BookOrSculptureText
	db POKECENTER,   41
	db_tx_pre WonderTradeMachineText
	db LOBBY,        22
	db_tx_pre ElevatorText
	db $FF

IndigoPlateauStatues:
	TX_ASM
	ld hl, IndigoPlateauStatuesText1
	call PrintText
	ld a, [wXCoord]
	bit 0, a
	ld hl, IndigoPlateauStatuesText2
	jr nz, .ok
	ld hl, IndigoPlateauStatuesText3
.ok
	call PrintText
	jp TextScriptEnd

IndigoPlateauStatuesText1:
	TX_FAR _IndigoPlateauStatuesText1
	db "@"

IndigoPlateauStatuesText2:
	TX_FAR _IndigoPlateauStatuesText2
	db "@"

IndigoPlateauStatuesText3:
	TX_FAR _IndigoPlateauStatuesText3
	db "@"

BookOrSculptureText:
	TX_ASM
	ld hl, PokemonBooksText
	ld a, [wCurMapTileset]
	cp MANSION ; Celadon Mansion tileset
	jr nz, .ok
	aCoord 8, 6
	cp $38
	jr nz, .ok
	ld hl, DiglettSculptureText
.ok
	call PrintText
	jp TextScriptEnd

PokemonBooksText:
	TX_FAR _PokemonBooksText
	db "@"

DiglettSculptureText:
	TX_FAR _DiglettSculptureText
	db "@"

ElevatorText:
	TX_FAR _ElevatorText
	db "@"

TownMapText:
	TX_FAR _TownMapText
	TX_BLINK
	TX_ASM
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, wd730
	set 6, [hl]
	call GBPalWhiteOutWithDelay3
	xor a
	ld [hWY], a
	inc a
	ld [H_AUTOBGTRANSFERENABLED], a
	call LoadFontTilePatterns
	callba DisplayTownMap
	ld hl, wd730
	res 6, [hl]
	ld de, TextScriptEnd
	push de
	ld a, [H_LOADEDROMBANK]
	push af
	jp CloseTextDisplay

PokemonStuffText:
	TX_FAR _PokemonStuffText
	db "@"

WonderTradeMachineText:
	TX_ASM
	callba DoWonderTradeDialogue
	jp TextScriptEnd
