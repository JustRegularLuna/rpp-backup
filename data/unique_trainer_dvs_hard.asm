UniqueDVTrainerPokemon:
	; TrainerClass, TrainerNo, PartySpecies, Level, AtkDefDV, SpdSpcDV

	; shiny
	db SUPER_NERD, 2, UMBREON, 20, ATKDEFDV_SHINY, SPDSPCDV_SHINY
	db LANCE, 1, DRAGONITE, 79, ATKDEFDV_SHINY, SPDSPCDV_SHINY
	
	; other
	db YOUNGSTER, 1, RATTATA, 14, $FF, $FF ; Joey's Top Percentage Rattata
	db COUPLE, 1, WEEPINBELL, 25, $7F, $DF ; One of the Couple's Pokemon has Lass DVs instead of Youngster DVs
	
	db $FF ; end
