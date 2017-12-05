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
	TX_NUM wDayCareNumLevelsGrown,$1,$3
	text "!"

	para "Aren't I great?"
	prompt

_DayCareOweMoneyText::
	text "You owe me ¥@"
	TX_BCD wDayCareTotalCost, $c2
	db $0
	line "for the return"
	cont "of this #mon."
	done

_DayCareGotMonBackText::
	text "[PLAYER] got"
	line "@"
	TX_RAM wDayCareMonName
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
	TX_RAM wDayCareMon2Name
	text " back!"
	done

