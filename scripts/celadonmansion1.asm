CeladonMansion1Script: ; 48694 (12:4694)
	jp EnableAutoTextBoxDrawing

CeladonMansion1TextPointers: ; 48697 (12:4697)
	dw CeladonMansion1Text1
	dw CeladonMansion1Text2
	dw CeladonMansion1Text3
	dw CeladonMansion1Text4
	dw CeladonMansion1Text5

CeladonMansion1Text1: ; Old Lady
	TX_FAR _CeladonMansion1Text1
	db "@"

CeladonMansion1Text2: ; Frenzy Plant
	db $08 ; asm
	ld a, 1
	jp CeladonMansionTutors

CeladonMansion1Text3: ; Blast Burn
	db $8
	ld a, 2
	jp CeladonMansionTutors

CeladonMansion1Text4: ; Hydro Cannon
	db $8
	ld a, 3
	jp CeladonMansionTutors

CeladonMansion1Text5: ; Sign on wall
	TX_FAR _CeladonMansion1Text5
	db "@"

CeladonMansionTutors: ; Common to all three tutors
	ld [wWhichTrade], a
	callba MoveTutorScript
	jp TextScriptEnd
	
	ds 4 ; so we don't shift data and mess up saving in Celadon Pokecenter
