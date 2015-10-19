SouthernIslandOutsideScript:
	jp EnableAutoTextBoxDrawing

SouthernIslandOutsideTextPointers:
	dw SouthernIslandCaptainText
	dw SouthernIslandBerryTreeText
	dw SouthernIslandSignText

SouthernIslandCaptainText:
	TX_FAR _ViridianForestEntranceText1 ; placeholder
	db "@"

SouthernIslandBerryTreeText:
	db $08 ; asm
	ld a, 16
	ld [wWhichTrade],a
	callba BerryTreeScript
	jp TextScriptEnd
	
SouthernIslandSignText:
	text "The writing is"
	line "fading as if it"
	cont "was written long"
	cont "ago.@@"
	