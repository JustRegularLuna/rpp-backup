LavenderHouse2Script:
	call EnableAutoTextBoxDrawing
	ret

LavenderHouse2TextPointers:
	dw LavenderHouse2Text1
	dw LavenderHouse2Text2

LavenderHouse2Text1:
	TX_FAR _LavenderHouse2Text1
	TX_ASM
	ld a, CUBONE
	call PlayCry
	jp TextScriptEnd

LavenderHouse2Text2:
	TX_ASM
	ld a, 8
	ld [wWhichTrade], a
	callba MoveTutorScript
	jp TextScriptEnd
