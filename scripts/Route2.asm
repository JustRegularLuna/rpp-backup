Route2Script:
	jp EnableAutoTextBoxDrawing

Route2TextPointers:
	dw PickUpItemText
	dw PickUpItemText
   	dw Route2Tree1
	dw Route2Tree2
	dw Route2Text3
	dw Route2Text4

Route2Text3:
	TX_FAR _Route2Text3
	db "@"

Route2Text4:
	TX_FAR _Route2Text4
	db "@"

Route2Tree1:
	TX_ASM
	ld a, 2 ; Tree number
	ld [wWhichTrade],a
	callba BerryTreeScript
	jp TextScriptEnd

Route2Tree2:
	TX_ASM
	ld a, 12 ; Tree number
	ld [wWhichTrade],a
	callba BerryTreeScript
	jp TextScriptEnd
