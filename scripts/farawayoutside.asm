FarawayIslandOutsideScript:
	jp EnableAutoTextBoxDrawing

FarawayIslandOutsideTextPointers:
	dw FarawayIslandCaptainText
	dw FarawayIslandBerryTreeText
	dw FarawayIslandSignText

FarawayIslandCaptainText:
	TX_FAR _FerrySailorText
	db "@"

FarawayIslandBerryTreeText:
	db $08 ; asm
	ld a, 15
	ld [wWhichTrade],a
	callba BerryTreeScript
	jp TextScriptEnd
	
FarawayIslandSignText:
	text "The writing is"
	line "fading as if it"
	cont "was written long"
	cont "ago."
	
	para "...ber, 6th day"
	line "If any human..."
	cont "sets foot here..."
	cont "again...et it be"
	cont "a kindhearted"
	cont "pers..."
	
	para "...ith that hope,"
	line "I depar..."
	
	para "...JI@@"