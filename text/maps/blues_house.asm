_DaisyInitialText::
	text "Hi [PLAYER]!"
	line "[RIVAL] is out at"
	cont "Grandpa's lab."
	done

_DaisyOfferMapText::
	text "Grandpa asked you"
	line "to run an errand?"
	cont "Here, this will"
	cont "help you!"
	prompt

_GotMapText::
	text "[PLAYER] got a"
	line "@"
	TX_RAM wcf4b
	text "!@@"

_DaisyBagFullText::
	text "You have too much"
	line "stuff with you."
	done

_DaisyUseMapText::
	text "Use the TOWN MAP"
	line "to find out where"
	cont "you are."
	done

_BluesHouseText2::
	text "#MON are living"
	line "things! If they"
	cont "get tired, give"
	cont "them a rest!"
	done

_BluesHouseText3::
	text "It's a TOWN MAP!"
	
	para "It's open to the"
	line "KANTO region."
	done

_BluesTVText::
	text "There's a show on"
	line "TV."
	
	para "A man in a brown"
	line "pinstripe suit is"
	cont "running toward a"
	cont "blue Police Box."
	
	para "I'd better get"
	line "going too."
	done
	