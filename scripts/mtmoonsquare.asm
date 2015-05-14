MtMoonSquareScript:
	jp EnableAutoTextBoxDrawing

MtMoonSquareTextPointers:
	dw MtMoonSquareText1
	dw MtMoonSquareText2
	dw MtMoonSquareText3
	dw MtMoonSquareText4

MtMoonSquareText1:
	db $08 ; asm
	ld a, 7
	ld [wWhichTrade],a
	callba BerryTreeScript
	jp TextScriptEnd

MtMoonSquareText2:
	text "There is a strange"
	line "aura in the area"
	cont "lately."
	
	para "It must be from"
	line "the meteorite."
	done
	db "@"

MtMoonSquareText3:
	text "My EEVEE loves it"
	line "here!"
	
	para "Apparently, so do"
	line "the CLEFAIRY."
	done
	db "@"
	
MtMoonSquareText4:
	text "MT. MOON SQUARE"
	done
	db "@"
