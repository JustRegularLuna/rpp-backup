_TM35PreReceiveText::
	text "I'm giving out"
	line "free TMs."

	para "Here you go, take"
	line "one!"
	prompt

_ReceivedTM35Text::
	text "[PLAYER] received "
	line "@"
	TX_RAM wcf4b
	text "!@@"

_TM35ExplanationText::
	text "That TM teaches a"
	line "#MON to use"
	cont "AncientPower!"

	para "It was discovered"
	line "while researching"
	cont "fossils here in"
	cont "the lab."
	done

_TM35NoRoomText::
	text "Your pack is"
	line "crammed full!"
	done

_Lab3Text2::
	text "Eevee can evolve"
	line "into 1 of 8 kinds"
	cont "of #mon."
	done

_Lab3Text3::
	text "There's an e-mail"
	line "message!"

	para "..."

	para "The 3 legendary"
	line "bird #mon are"
	cont "Articuno, Zapdos"
	cont "and Moltres."

	para "Their whereabouts"
	line "are unknown."

	para "We plan to explore"
	line "the cavern close"
	cont "to Cerulean."

	para "From: #mon"
	line "Research Team"

	para "..."
	done

_Lab3Text5::
	text "An amber pipe!"
	done
