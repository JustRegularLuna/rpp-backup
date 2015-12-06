_BeachHousePikachuText::
	text "PUKA: Pika-pi!"
	done
	
_BeachHouseGirlText::
	text "I came inside to"
	line "get some more"
	cont "sunscreen."
	done
	
_BeachHouseOldManText::
	text "Oof, I spent too"
	line "long in the sun."
	
	para "I need to rest..."
	done

_BeachHouseGiveSurfText::
	text "Yo! What's up,"
	line "little dude?"
	
	para "So, you saw some"
	line "people out there"
	cont "on the waves,"
	cont "and now you want"
	cont "in on that?"
	
	para "Well you came to"
	line "the right place!"
	prompt
	
_BeachHouseGiveSurfText2::
	text "Yo! What's up,"
	line "little dudette?"
	
	para "So, you saw some"
	line "people out there"
	cont "on the waves,"
	cont "and now you want"
	cont "in on that?"
	
	para "Well you came to"
	line "the right place!"
	prompt

_ReceivedHM03Text::
	text $52, " received"
	line "@"
	TX_RAM wcf4b
	text "!@@"

_HM03ExplanationText::
	text "HM03 is SURF!"

	para "You and your"
	line "#MON can get"
	cont "out there and"
	cont "catch the gnarly"
	cont "waves!"
	done

_HM03NoRoomText::
	text "Whoa, hold up!"
	
	para "You don't have"
	line "room for this"
	cont "sweet HM!"
	done
