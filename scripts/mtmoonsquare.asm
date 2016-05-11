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
	db 8
	ld a, 7 ; Moonblast Tutor
	ld [wWhichTrade], a
	callba MoveTutorScript
	jp TextScriptEnd

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
