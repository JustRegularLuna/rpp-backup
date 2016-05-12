LavenderHouse2Script: ; 1d9ae (7:59ae)
	call EnableAutoTextBoxDrawing
	ret

LavenderHouse2TextPointers: ; 1d9b2 (7:59b2)
	dw LavenderHouse2Text1
	dw LavenderHouse2Text2

LavenderHouse2Text1: ; 1d9b6 (7:59b6)
	TX_FAR _LavenderHouse2Text1
	db $8
	ld a, CUBONE
	call PlayCry
	jp TextScriptEnd

LavenderHouse2Text2: ; 1d9c3 (7:59c3)
	db $08 ; asm
	ld a, 8
	ld [wWhichTrade], a
	callba MoveTutorScript
	jp TextScriptEnd
