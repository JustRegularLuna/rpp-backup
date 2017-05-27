_CinnabarIslandText8::
	text "The door is"
	line "locked..."
	done

_CinnabarIslandText1::
	text "Cinnabar Gym's"
	line "Blaine is an odd"
	cont "man who has lived"
	cont "here for decades."
	done

_CinnabarIslandText2::
	db 8
	ld a, 5
	ld [wWhichTrade], a
	callba MoveTutorScript
	jp TextScriptEnd

_CinnabarIslandText3::
	text "Cinnabar Island"
	
	para "The fiery town of"
	line "burning desire"
	done

_CinnabarIslandText6::
	text "#mon Lab"
	done

_CinnabarIslandText7::
	text "Cinnabar Island"
	line "#mon Gym"
	cont "Leader: Blaine"

	para "The hot-headed"
	line "quiz master!"
	done

