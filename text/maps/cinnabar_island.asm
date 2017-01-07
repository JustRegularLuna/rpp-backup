_CinnabarIslandText8:: ; a61cf (29:61cf)
	text "The door is"
	line "locked..."
	done

_CinnabarIslandText1:: ; a61e6 (29:61e6)
	text "Cinnabar Gym's"
	line "Blaine is an odd"
	cont "man who has lived"
	cont "here for decades."
	done

_CinnabarIslandText2:: ; a622a (29:622a)
	db 8
	ld a, 5
	ld [wWhichTrade], a
	callba MoveTutorScript
	jp TextScriptEnd

_CinnabarIslandText3:: ; a6266 (29:6266)
	text "Cinnabar Island"
	
	para "The fiery town of"
	line "burning desire"
	done

_CinnabarIslandText6:: ; a6298 (29:6298)
	text "#mon Lab"
	done

_CinnabarIslandText7:: ; a62a2 (29:62a2)
	text "Cinnabar Island"
	line "#mon Gym"
	cont "Leader: Blaine"

	para "The hot-headed"
	line "quiz master!"
	done

