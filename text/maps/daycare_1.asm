_DayCareIntroText::
	text "We run a Day Care."
	line "Would you like me"
	cont "to raise one of"
	cont "your #mon?"
	done

_DayCareWhichMonText::
	text "Which #mon"
	line "should I raise?"
	prompt

_DayCareWillLookAfterMonText::
	text "Fine, I'll look"
	line "after @"
	TX_RAM wcd6d
	db $0
	cont "for a while."
	prompt

_DayCareComeSeeMeInAWhileText::
	text "Come see me in"
	line "a while."
	done

_DayCareMonHasGrownText::
	text "Your @"
	TX_RAM wcd6d
	db $0
	line "has grown a lot!"

	para "By level, it's"
	line "grown by @"

DayCareMText_8ac67::
	TX_NUM wTrainerEngageDistance,$1,$3
	text "!"

	para "Aren't I great?"
	prompt

_DayCareOweMoneyText::
	text "You owe me ¥@"
	TX_BCD wcd3f, $c2
	db $0
	line "for the return"
	cont "of this #mon."
	done

_DayCareGotMonBackText::
	text "[PLAYER] got"
	line "@"
	TX_RAM W_DAYCAREMONNAME
	text " back!"
	done

_DayCareMonNeedsMoreTimeText::
	text "Back already?"
	line "Your @"
	TX_RAM wcd6d
	db $0
	cont "needs some more"
	cont "time with us."
	prompt

_DayCareGotMonBackText2::
	text "[PLAYER] got"
	line "@"
	TX_RAM W_DAYCAREMON2NAME
	text " back!"
	done

