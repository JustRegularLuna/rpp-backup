_MoveTutorWelcomeText::
	text "Hello, I am a"
	line "MOVE TUTOR."
	
	para "For only ¥500, I"
	line "can teach a move"
	cont "to one of your"
	cont "#MON."
	prompt
	
_TeachTutorMoveText::
	text "Want me to teach"
	line "@"
	TX_RAM wcf4b
	db $0
	cont "to a #MON?"
	done

_MoveTutorComeAgainText::
	text "Come again!"
	done

_MonCannotLearnTutorMoveText::
	text "Oh, I can't teach"
	line "that #MON"
	cont "@"
	TX_RAM wcf4b
	text "."
	prompt

_MoveTutorNotEnoughMoneyText::
	text "I'm sorry, you"
	line "don't have enough"
	cont "money."
	done
