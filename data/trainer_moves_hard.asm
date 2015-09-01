TeamMoves: ; Created and updated on 28/06/2015 by Neodymium / Free to use and modify without crediting
	db BROCK,$1 ; COMPLETED
    ;Geodude
	db 1,1,ROCK_POLISH
	db 1,2,MUD_SLAP
	db 1,3,ROCK_TOMB
	db 1,4,TACKLE
    ;Kabutops
	db 2,1,AURORA_BEAM
	db 2,2,WATER_GUN
	db 2,3,ROCK_TOMB
	db 2,4,TACKLE
    ;Omastar
	db 3,1,AURORA_BEAM
	db 3,2,WATER_GUN
	db 3,3,ROCK_TOMB
	db 3,4,TACKLE
    ;Aerodactyl
	db 4,1,WING_ATTACK
	db 4,2,SAND_ATTACK
	db 4,3,ROCK_TOMB
	db 4,4,AGILITY
    ;Graveler
	db 5,1,ROCK_POLISH
	db 5,2,MUD_SLAP
	db 5,3,ROCK_TOMB
	db 5,4,TAKE_DOWN
	db 0

	db MISTY,$1 ; COMPLETED
    ;Vaporeon
	db 1,1,AURORA_BEAM
	db 1,2,BODY_SLAM
	db 1,3,SAND_ATTACK
	db 1,4,WATER_PULSE
    ;Poliwrath
	db 2,1,DOUBLESLAP
	db 2,2,AURORA_BEAM
	db 2,3,DIG
	db 2,4,WATER_PULSE
    ;Dewgong
	db 3,1,HORN_ATTACK
	db 3,2,AURORA_BEAM
	db 3,3,BODY_SLAM
	db 3,4,WATER_PULSE
    ;Starmie
	db 4,1,THUNDER_WAVE
	db 4,2,WATER_PULSE
	db 4,3,THUNDERBOLT
	db 4,4,RECOVER
    ;Lapras
	db 5,1,BODY_SLAM
	db 5,2,CONFUSE_RAY
	db 5,3,WATER_PULSE
	db 5,4,AURORA_BEAM
	db 0

	db LT__SURGE,$1 ; COMPLETED
    ;Electrode
	db 1,3,THUNDERBOLT
    ;Magneton
	db 2,3,THUNDERBOLT
    ;Jolteon
	db 3,3,THUNDERBOLT
    ;Electabuzz
	db 4,3,THUNDERBOLT
    ;Raichu
	db 5,3,THUNDERBOLT
	db 0

	db ERIKA,$1 ; COMPLETED
    ;Vileplume
	db 1,3,GIGA_DRAIN
    ;Venusaur
	db 2,3,GIGA_DRAIN
    ;Tangela
	db 3,3,GIGA_DRAIN
    ;Victreebel
	db 4,3,GIGA_DRAIN
    ;Exeggcutor
	db 5,3,GIGA_DRAIN
	db 0
	
	db KOGA,$1 ; COMPLETED
    ;Venomoth
	db 1,3,TOXIC
    ;Weezing
	db 2,3,TOXIC
    ;Nidoking
	db 3,3,TOXIC
    ;Tentacruel
	db 4,3,TOXIC
    ;Gengar
	db 5,3,TOXIC
	db 0

	db BLAINE,$1 ; COMPLETED
    ;Charizard
	db 1,3,FLAMETHROWER
    ;Rapidash
	db 2,3,FLAMETHROWER
    ;Flareon
	db 3,3,FLAMETHROWER
    ;Arcanine
	db 4,3,FLAMETHROWER
    ;Magmar
	db 5,3,FLAMETHROWER
	db 0

	db SABRINA,$1 ; COMPLETED
    ;Jynx
    db 1,3,PSYWAVE
    ;Slowking
	db 2,3,PSYWAVE
    ;Hypno
	db 3,3,PSYWAVE
    ;Alakazam
	db 4,3,PSYWAVE
    ;Slowbro
	db,5,3,PSYWAVE
	db 0

	db GIOVANNI,$3 ; COMPLETED
    ;Gengar
	db 1,3,EARTHQUAKE
    ;Steelix
	db 2,3,EARTHQUAKE
    ;Nidoqueen
	db 3,3,EARTHQUAKE
    ;Nidoking
	db 4,3,EARTHQUAKE
    ;Rhyperior
	db 5,3,EARTHQUAKE
    ;Tauros
    db 6,3,EARTHQUAKE
	db 0

	db LORELEI,$1 ; COMPLETED
    ;Cloyster
	db 1,1,SURF
	db 1,2,ICE_BEAM
	db 1,3,AURORA_BEAM
	db 1,4,REST
    ;Vaporeon
	db 2,1,CLAMP
	db 2,2,SPIKE_CANNON
	db 2,3,ICE_BEAM
	db 2,4,BLIZZARD
    ;Slowking
	db 3,1,ICE_BEAM
	db 3,2,AMNESIA
	db 3,3,SURF
	db 3,4,PSYCHIC
    ;Jynx
	db 4,1,DOUBLESLAP
	db 4,2,ICE_PUNCH
	db 4,3,DRAININGKISS
	db 4,4,LOVELY_KISS
    ;Lapras
	db 5,1,BODY_SLAM
	db 5,2,CONFUSE_RAY
	db 5,3,SURF
	db 5,4,ICE_BEAM
	db 0

	db BRUNO,$1 ; COMPLETED
    ;Steelix
	db 1,1,EARTHQUAKE
	db 1,2,ROCK_TOMB
	db 1,3,IRON_TAIL
	db 1,4,ROAR
    ;Hitmonchan
	db 2,1,SHADOW_PUNCH
	db 2,2,ICE_PUNCH
	db 2,3,THUNDERPUNCH
	db 2,4,FIRE_PUNCH
    ;Hitmonlee
	db 3,1,MEGA_KICK
	db 3,2,HI_JUMP_KICK
	db 3,3,DOUBLE_KICK
	db 3,4,DOUBLE_TEAM
    ;Primeape
	db 4,1,FOCUS_ENERGY
	db 4,2,DYNAMICPUNCH
	db 4,3,CROSS_CHOP
	db 4,4,SCREECH
    ;Machamp
	db 5,1,CROSS_CHOP
	db 5,2,ROCK_TOMB
	db 5,3,STRENGTH
	db 5,4,SUBMISSION
	db 0

	db AGATHA,$1 ; COMPLETED
    ;Misdreavus
	db 1,1,POWER_GEM
	db 1,2,SHADOW_BALL
	db 1,3,HEX
	db 1,4,PSYBEAM
    ;Honchkrow
	db 2,1,NIGHT_SLASH
	db 2,2,HEX
	db 2,3,MOONLIGHT
	db 2,4,ACROBATICS
    ;Houndoom
	db 3,1,FLAMETHROWER
	db 3,2,SHADOW_BALL
	db 3,3,HEX
	db 3,4,BITE
    ;Mismagius
	db 4,1,DARK_PULSE
	db 4,2,NIGHT_SHADE
	db 4,3,HEX
	db 4,4,CONFUSE_RAY
    ;Gengar
	db 5,1,HYPNOSIS
	db 5,2,DREAM_EATER
	db 5,3,HEX
	db 5,4,MOONLIGHT
	db 0

	db LANCE,$1 ; COMPLETED
    ;Gyarados
	db 1,1,OUTRAGE
	db 1,2,TWISTER
	db 1,3,HYPER_BEAM
	db 1,4,ICE_FANG
    ;Charizard
	db 2,1,FLAMETHROWER
	db 2,2,OUTRAGE
	db 2,3,EARTHQUAKE
	db 2,4,METAL_CLAW
    ;Kingdra
	db 3,1,WHIRLPOOL
	db 3,2,OUTRAGE
	db 3,3,DRAGON_PULSE
	db 3,4,WATERFALL
    ;Aerodactyl
	db 4,1,AERIAL_ACE
	db 4,2,OUTRAGE
	db 4,3,ANCIENTPOWER
	db 4,4,STEEL_WING
    ;Dragonite
	db 5,1,AMNESIA
	db 5,2,OUTRAGE
	db 5,3,DRACO_METEOR
	db 5,4,THUNDER_WAVE
	db 0

	db SONY3,$1 ; Player chose Charmander
    ;Pidgeot
	db 1,1,AERIAL_ACE
	db 1,2,ACROBATICS
	db 1,3,SAND_ATTACK
	db 1,4,WHIRLWIND
    ;Alakazam
	db 2,1,PSYCHIC
	db 2,2,SHADOW_BALL
	db 2,3,RECOVER
	db 2,4,REFLECT
    ;Rhyperior
	db 3,1,TAKE_DOWN
	db 3,2,EARTHQUAKE
	db 3,3,ROCK_TOMB
	db 3,4,LEER
    ;Arcanine
	db 4,1,EXTREMESPEED
	db 4,2,FLAMETHROWER
	db 4,3,ROAR
	db 4,4,BITE
    ;Exeggcutor
	db 5,1,GIGA_DRAIN
	db 5,2,EGG_BOMB
	db 5,3,SLEEP_POWDER
	db 5,4,LIGHT_SCREEN
    ;Blastoise
	db 6,1,HYDRO_PUMP
	db 6,2,WITHDRAW
	db 6,3,SKULL_BASH
	db 6,4,BITE
	db 0

	db SONY3,$2 ; Player chose Squirtle
    ;Pidgeot
	db 1,1,AERIAL_ACE
	db 1,2,ACROBATICS
	db 1,3,SAND_ATTACK
	db 1,4,WHIRLWIND
    ;Alakazam
	db 2,1,PSYCHIC
	db 2,2,SHADOW_BALL
	db 2,3,RECOVER
	db 2,4,REFLECT
    ;Rhyperior
	db 3,1,TAKE_DOWN
	db 3,2,EARTHQUAKE
	db 3,3,ROCK_TOMB
	db 3,4,LEER
    ;Arcanine
	db 4,1,EXTREMESPEED
	db 4,2,FLAMETHROWER
	db 4,3,ROAR
	db 4,4,BITE
    ;Exeggcutor
	db 5,1,GIGA_DRAIN
	db 5,2,EGG_BOMB
	db 5,3,SLEEP_POWDER
	db 5,4,LIGHT_SCREEN
    ;Venusaur
	db 6,1,SOLARBEAM
	db 6,2,RECOVER
	db 6,3,GIGA_DRAIN
	db 6,4,GROWTH
	db 0

	db SONY3,$3 ; Player chose Bulbasaur
    ;Pidgeot
	db 1,1,AERIAL_ACE
	db 1,2,ACROBATICS
	db 1,3,SAND_ATTACK
	db 1,4,WHIRLWIND
    ;Alakazam
	db 2,1,PSYCHIC
	db 2,2,SHADOW_BALL
	db 2,3,RECOVER
	db 2,4,REFLECT
    ;Rhyperior
	db 3,1,TAKE_DOWN
	db 3,2,EARTHQUAKE
	db 3,3,ROCK_TOMB
	db 3,4,LEER
    ;Arcanine
	db 4,1,EXTREMESPEED
	db 4,2,FLAMETHROWER
	db 4,3,ROAR
	db 4,4,BITE
    ;Exeggcutor
	db 5,1,GIGA_DRAIN
	db 5,2,EGG_BOMB
	db 5,3,SLEEP_POWDER
	db 5,4,LIGHT_SCREEN
    ;Charizard
	db 6,1,FIRE_BLAST
	db 6,2,AERIAL_ACE
	db 6,3,SLASH
	db 6,4,FLARE_BLITZ
	db 0

	db $ff
