Route2Script: ; 554e3 (15:54e3)
	jp EnableAutoTextBoxDrawing

Route2TextPointers: ; 554e6 (15:54e6)
	dw Predef5CText
	dw Predef5CText
	dw Route2Text3
	dw Route2Text4
	dw Route2Tree1
	dw Route2Tree2

Route2Text3: ; 554ee (15:54ee)
	TX_FAR _Route2Text3
	db "@"

Route2Text4: ; 554f3 (15:54f3)
	TX_FAR _Route2Text4
	db "@"

Route2Tree1:
	db $08 ; asm
	ld a, 2 ; Tree number
	ld [wWhichTrade],a
	callba BerryTreeScript
	jp TextScriptEnd

Route2Tree2:
	db $08 ; asm
	ld a, 12 ; Tree number
	ld [wWhichTrade],a
	callba BerryTreeScript
	jp TextScriptEnd
