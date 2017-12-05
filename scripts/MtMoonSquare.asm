MtMoonSquareScript:
	jp EnableAutoTextBoxDrawing

MtMoonSquareTextPointers:
	dw MtMoonSquareText1
	dw MtMoonSquareText2
	dw MtMoonSquareText3
	dw MtMoonSquareText4

MtMoonSquareText1:
	TX_ASM
	ld a, 7
	ld [wWhichTrade],a
	callba BerryTreeScript
	jp TextScriptEnd

MtMoonSquareText2:
	TX_ASM
	ld a, 7 ; Moonblast Tutor
	ld [wWhichTrade], a
	callba MoveTutorScript
	jp TextScriptEnd

MtMoonSquareText3:
	text "My Eevee loves it"
	line "here!"
	
	para "Apparently, so do"
	line "the Clefairy."
	done
	db "@"
	
MtMoonSquareText4:
	text "Mt. Moon Square"
	done
	db "@"
