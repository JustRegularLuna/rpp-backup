_SecretHouseText_4a350:: ; 858a4 (21:58a4)
	text "Ah! Finally!"

	para "You're the first"
	line "person to reach"
	cont "the SECRET HOUSE!"

	para "I was getting"
	line "worried that no"
	cont "one would win our"
	cont "campaign prize."

	para "Congratulations!"
	line "You have won!"
	prompt

_ReceivedTM15Text:: ; 85943 (21:5943)
	text $52, " received"
	line "@"
	TX_RAM wcf4b
	text "!@@"

_TM15ExplanationText:: ; 85957 (21:5957)
	text "TM15 teaches"
	line "HYPER BEAM!"

	para "It's a powerful"
	line "move, but your"
	cont "#MON has to"
	cont "recharge after"
	cont "using it."

	para "You're super lucky"
	line "for winning this"
	cont "fabulous prize!"
	done

_TM15NoRoomText:: ; 85a02 (21:5a02)
	text "You don't have"
	line "room for this"
	cont "fabulous prize!"
	done

