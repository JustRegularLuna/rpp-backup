_TM35PreReceiveText:: ; a0f09 (28:4f09)
	text "I'm giving out"
	line "free TMs."

	para "Here you go, take"
	line "one!"
	prompt

_ReceivedTM35Text:: ; a0f48 (28:4f48)
	text "[PLAYER] received "
	line "@"
	TX_RAM wcf4b
	text "!@@"

_TM35ExplanationText:: ; a0f5d (28:4f5d)
	text "That TM teaches a"
	line "#MON to use"
	cont "AncientPower!"

	para "It was discovered"
	line "while researching"
	cont "fossils here in"
	cont "the lab."
	done

_TM35NoRoomText:: ; a0fc7 (28:4fc7)
	text "Your pack is"
	line "crammed full!"
	done

_Lab3Text2:: ; a0fe3 (28:4fe3)
	text "Eevee can evolve"
	line "into 1 of 8 kinds"
	cont "of #mon."
	done

_Lab3Text3:: ; a1010 (28:5010)
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

_Lab3Text5:: ; a10d8 (28:50d8)
	text "An amber pipe!"
	done

