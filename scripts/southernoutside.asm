SouthernIslandOutsideScript:
	jp EnableAutoTextBoxDrawing

SouthernIslandOutsideTextPointers:
	dw SouthernIslandCaptainText
	dw SouthernIslandBerryTreeText
	dw SouthernIslandSignText

SouthernIslandCaptainText:
	TX_FAR _FerrySailorText
	db "@"

SouthernIslandBerryTreeText:
	db $08 ; asm
	ld a, 16
	ld [wWhichTrade],a
	callba BerryTreeScript
	jp TextScriptEnd
	
SouthernIslandSignText:
	text "Those whose mem-"
	line "ories fade seek"
	cont "to carve them in"
	cont "their hearts...@@"
