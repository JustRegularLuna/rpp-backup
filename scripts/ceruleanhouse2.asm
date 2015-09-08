CeruleanHouse2Script: ; 74e09 (1d:4e09)
	ld a, $1
	ld [wAutoTextBoxDrawingControl], a
	dec a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ret

CeruleanHouse2TextPointers: ; 74e13 (1d:4e13)
	dw CeruleanHouse2Text1

CeruleanHouse2Text1: ; 74e15 (1d:4e15)
	db $8
	ld hl, CeruleanHouse2Text_74e77
	call PrintText
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
.asm_74e23
	ld hl, CeruleanHouse2Text_74e7c
	call PrintText
	ld hl, BerryItemList
	call LoadItemList
	ld hl, wStringBuffer2 + 11
	ld a, l
	ld [wList], a
	ld a, h
	ld [wList + 1], a
	xor a
	ld [wcf93], a
	ld [wMenuItemToSwap], a
	ld a, SPECIALLISTMENU
	ld [wListMenuID], a
	call DisplayListMenuID
	jr c, .asm_74e60 ; 0x74e49 $15
	ld hl, MenuTextPointers
	ld a, [wcf91]
	sub ORAN_BERRY
	add a
	ld d, $0
	ld e, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	jr .asm_74e23 ; 0x74e5e $c3
.asm_74e60
	xor a
	ld [wListScrollOffset], a
	ld hl, CeruleanHouse2Text_74e81
	call PrintText
	jp TextScriptEnd

BerryItemList: ; 74e6d (1d:4e6d)
	db 10,ORAN_BERRY,SITRUS_BERRY,LEPPA_BERRY,PECHA_BERRY,RAWST_BERRY,ASPEAR_BERRY,CHESTO_BERRY,CHERI_BERRY,LUM_BERRY,SWEG_BERRY,$FF

CeruleanHouse2Text_74e77: ; 74e77 (1d:4e77)
	TX_FAR _CeruleanHouse2Text_74e77
	db "@"

CeruleanHouse2Text_74e7c: ; 74e7c (1d:4e7c)
	TX_FAR _CeruleanHouse2Text_74e7c
	db "@"

CeruleanHouse2Text_74e81: ; 74e81 (1d:4e81)
	TX_FAR _CeruleanHouse2Text_74e81
	db "@"

MenuTextPointers:
	dw OranBerryText
	dw SitrusBerryText
	dw LeppaBerryText
	dw PechaBerryText
	dw RawstBerryText
	dw AspearBerryText
	dw ChestoBerryText
	dw CheriBerryText
    dw LumBerryText
    dw SwegBerryText

OranBerryText:
	TX_FAR _OranBerryText
	db "@"

SitrusBerryText:
	TX_FAR _SitrusBerryText
	db "@"

LeppaBerryText:
	TX_FAR _LeppaBerryText
	db "@"

PechaBerryText:
	TX_FAR _PechaBerryText
	db "@"

RawstBerryText:
	TX_FAR _RawstBerryText
	db "@"

AspearBerryText:
	TX_FAR _AspearBerryText
	db "@"

ChestoBerryText:
	TX_FAR _ChestoBerryText
	db "@"

CheriBerryText:
	TX_FAR _CheriBerryText
	db "@"
    
LumBerryText:
    TX_FAR _LumBerryText
    db "@"
    
SwegBerryText:
    TX_FAR _SwegBerryText
    db "@"
