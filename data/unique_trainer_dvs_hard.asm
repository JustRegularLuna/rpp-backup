UniqueDVTrainerPokemon:
	; TrainerClass, TrainerNo, PartySpecies, Level, AtkDefDV, SpdSpcDV

	; shiny
	db SUPER_NERD, 2, UMBREON, 20, ATKDEFDV_SHINY, SPDSPCDV_SHINY
	db LANCE, 1, DRAGONITE, 79, ATKDEFDV_SHINY, SPDSPCDV_SHINY
	db BEAUTY, 1, BELLOSSOM, 41, ATKDEFDV_SHINY_FEMALE, SPDSPCDV_SHINY
	db LASS, 11, ESPEON, 25, ATKDEFDV_SHINY_FEMALE, SPDSPCDV_SHINY
	
	; other
	db YOUNGSTER, 1, RATTATA, 14, $FF, $FF ; Joey's Top Percentage Rattata
	db COUPLE, 1, WEEPINBELL, 25, $7F, $DF ; One of the Couple's Pokemon has Lass DVs instead of Youngster DVs
	db POKEMANIAC, 4, PIKACHU, 36, $7F, $DF ; Pokemaniac Jessy has female 'mons
	db POKEMANIAC, 4, CUBONE, 36, $7F, $DF ; Pokemaniac Jessy has female 'mons
	
	db $FF ; end
