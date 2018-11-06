_PewterGymText_5c4a3::
	text "There are all"
	line "kinds of trainers"
	cont "in the world!"

	para "Some raise #mon"
	line "for fights. Some"
	cont "see them as pets."

	para "I'm in training to"
	line "become a #mon"
	cont "breeder."

	para "If you take your"
	line "#mon training"
	cont "seriously, go"
	cont "visit the Gym in"
	cont "Cerulean and test"
	cont "your abilities!"
	done

_TM34PreReceiveText::
	text "Wait! Take this"
	line "with you!"
	done

_ReceivedTM34Text::
	text "[PLAYER] received"
	line "TM36!@@"

_TM34ExplanationText::
	db $0
	para "A TM contains a"
	line "technique that"
	cont "can be taught to"
	cont "#mon."
	
	para "It can be used"
	line "again and again!"

	para "TM36 contains"
	line "Rock Tomb."

	para "It reduces your"
	line "opponent's speed,"
	cont "helping you get"
	cont "the first hit in!"
	done

_TM34NoRoomText::
	text "You don't have"
	line "room for this!"
	done

_PewterGymText_5c4bc::
	text "I took you for"
	line "granted."

	para "As proof of your"
	line "victory, here's"
	cont "the BoulderBadge!"

	para "[PLAYER] received"
	line "the BoulderBadge!@@"

_PewterGymText_5c4c1::
	db $0
	para "That's an official"
	line "#mon League"
	cont "Badge!"
IF DEF(_HARD)
	para "It's your first"
	line "step on the road"
	cont "to the League!"
ELSE
	para "Its bearer's"
	line "#mon become"
	cont "more powerful!"
ENDC
	para "Also, the move"
	line "Flash can now be"
	cont "used anytime!"
	prompt

_PewterGymBattleText1::
	text "Stop right there,"
	line "kid!"

	para "You're still light"
	line "years from facing"
	cont "Brock!"
	done

_PewterGymEndBattleText1::
	text "Darn!"

	para "Light years isn't"
	line "time! It measures"
	cont "distance!"
	prompt

_PewterGymAfterBattleText1::
	text "You're pretty hot,"
	line "but not as hot"
	cont "as Brock!"
	done

_PewterGymText_5c515::
	text "Hiya! I can tell"
	line "you have what it"
	cont "takes to become a"
	cont "#mon champ!"

	para "I'm no trainer,"
	line "but I can tell"
	cont "you how to win!"

	para "Let me take you"
	line "to the top!"
	done

_PewterGymText_5c51a::
	text "All right! Let's"
	line "get happening!"
	prompt

_PewterGymText_5c51f::
	text "The 1st #mon"
	line "out in a match is"
	cont "at the top of the"
	cont "#mon list!"

	para "By changing the"
	line "order of #mon,"
	cont "matches could be"
	cont "made easier!"
	done

_PewterGymText_5c524::
	text "It's a free"
	line "service! Let's"
	cont "get happening!"
	prompt

_PewterGymText_5c529::
	text "Just as I thought!"
	line "You're #mon"
	cont "champ material!"
	done
