_Route8BattleText1::
	text "You look good at"
	line "#mon, but"
	cont "how's your chem?"
	done

_Route8EndBattleText1::
	text "Ow!"
	line "Meltdown!"
	prompt

_Route8AfterBattleText1::
	text "I am better at"
	line "school than this!"
	done

_Route8BattleText2::
	text "All right! Let's"
	line "roll the dice!"
	done

_Route8EndBattleText2::
	text "Drat!"
	line "Came up short!"
	prompt

_Route8AfterBattleText2::
	text "Lady Luck's not"
	line "with me today!"
	done

_Route8BattleText3::
	text "You need strategy"
	line "to win at this!"
	done

_Route8EndBattleText3::
	text "It's not logical!"
	prompt

_Route8AfterBattleText3::
IF DEF(_HARD)
	text "Go with Muk"
ELSE
	text "Go with Grimer"
ENDC
	line "first...and..."
	cont "...and...then..."
	done

_Route8BattleText4::
	text "I like Nidoran, so"
	line "I collect them!"
	done

_Route8EndBattleText4::
	text "Why? Why??"
	prompt

_Route8AfterBattleText4::
	text "When #mon grow"
	line "up they get ugly!"
	cont "They shouldn't"
	cont "evolve!"
	done

_Route8BattleText5::
	text "School is fun, but"
	line "so are #mon."
	done

_Route8EndBattleText5::
	text "I'll stay with"
	line "school."
	prompt

_Route8AfterBattleText5::
	text "We're stuck here"
	line "because of the"
	cont "gates at Saffron."
	done

_Route8BattleText6::
	text "I like skirts,"
	line "they're cute and"
    cont "comfy to wear!"
	done

_Route8EndBattleText6::
	text "Oh my!"
	prompt

_Route8AfterBattleText6::
	text "Oh well, I'm more"
	line "worried about"
	cont "having fun than"
    cont "being competitive."
	done

_Route8BattleText7::
	text "We must look"
	line "silly standing"
	cont "here like this!"
	done

_Route8EndBattleText7::
	text "Look what you"
	line "did!"
	prompt

_Route8AfterBattleText7::
	text "Saffron's gate-"
	line "keeper won't let"
	cont "us through."
	cont "He's so mean!"
	done

_Route8BattleText8::
	text "I'm a rambling,"
	line "gambling dude!"
	done

_Route8EndBattleText8::
	text "Missed the big"
	line "score!"
	prompt

_Route8AfterBattleText8::
	text "Gambling and"
	line "#mon are like"
	cont "eating peanuts!"
	cont "Just can't stop!"
	done

_Route8BattleText9::
	text "What's a cute,"
	line "round and fluffy"
	cont "#mon?"
	done

_Route8EndBattleText9::
	text "Stop!"

	para "Don't be so mean"
IF DEF(_HARD)
	line "to my clefable!"
ELSE
	line "to my Clefairy!"
ENDC
	prompt

_Route8AfterBattleText9::
IF DEF(_HARD)
	text "Did you know"
ELSE
	text "I heard that"
ENDC
	line "Clefairy evolves"
	cont "when it's exposed"
IF DEF(_HARD)
	cont "to a Moon Stone?"
ELSE
	cont "to a Moon Stone."
ENDC
	done

_Route8Text10::
	text "Underground Path"
	line "Lavender Town -"
	cont "Celadon City"
	done
