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

CeladonMansion1Text2: ; Tutor 1
	TX_ASM
	ld a, 9 ; Thunder Punch
	jp CeladonMansionTutors

CeladonMansion1Text3: ; Tutor 2
	TX_ASM
	ld a, 10 ; Fire Punch
	jp CeladonMansionTutors

CeladonMansion1Text4: ; Tutor 3
	TX_ASM
	ld a, 11 ; Ice Punch
	jp CeladonMansionTutors

CeladonMansion1Text5: ; Sign on wall
	TX_FAR _CeladonMansion1Text5
	db "@"

CeladonMansionTutors: ; Common to all three tutors
	ld [wWhichTrade], a
	callba MoveTutorScript
	jp TextScriptEnd
