Route7Script:
	jp EnableAutoTextBoxDrawing

Route7TextPointers:
	dw Route7Tree1
	dw Route7Text1

Route7Text1:
	TX_FAR _Route7Text1
	db "@"

Route7Tree1:
	TX_ASM
	ld a, 14
	ld [wWhichTrade], a
	callba BerryTreeScript
	jp TextScriptEnd
