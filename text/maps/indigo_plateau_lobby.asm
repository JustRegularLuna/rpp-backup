_IndigoPlateauLobbyText1:: ; a13f0 (28:53f0)
	text "Yo! Champ in"
	line "making!"

	para "At #mon League,"
	line "you have to face"
	cont "the Elite Four in"
	cont "succession."

	para "If you lose, you"
	line "have to start all"
	cont "over again! This"
	cont "is it! Go for it!"
	done

_IndigoPlateauLobbyText3:: ; a148b (28:548b)
	db 8
	ld a, 6
	ld [wWhichTrade], a
	callba MoveTutorScript
	jp TextScriptEnd
