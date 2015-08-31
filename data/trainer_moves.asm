TeamMoves:
	db BROCK,$1
    ;Geodude
	db 1,1,TACKLE
	db 1,2,DEFENSE_CURL
	db 1,3,HARDEN
	db 1,4,ROCK_POLISH
    ;Onix
	db 2,1,TACKLE
	db 2,2,BIND
	db 2,3,HARDEN
	db 2,4,ROCK_TOMB
	db 0

	db MISTY,$1
    ;Staryu
	db 1,1,TACKLE
	db 1,2,HARDEN
	db 1,3,RECOVER
	db 1,4,WATER_PULSE
    ;Starmie
	db 2,1,TACKLE
	db 2,2,SWIFT
	db 2,3,RECOVER
	db 2,4,WATER_PULSE
	db 0

	db LT__SURGE,$1
    ;Raichu
	db 1,1,THUNDERBOLT
	db 1,2,MEGA_PUNCH
	db 1,3,AGILITY
	db 1,4,ELECTRO_BALL
	db 0

	db ERIKA,$1
    ;Victreebel
	db 1,1,STUN_SPORE
	db 1,2,ACID
	db 1,3,POISONPOWDER
	db 1,4,GIGA_DRAIN
    ;Tangela
	db 2,1,POISONPOWDER
	db 2,2,CONSTRICT
	db 2,3,VINE_WHIP
	db 2,4,GIGA_DRAIN
    ;Bellossom
	db 3,1,SLEEP_POWDER
	db 3,2,SOLARBEAM
	db 3,3,GIGA_DRAIN
	db 3,4,PETAL_DANCE
	db 0

	db KOGA,$1
    ;Venomoth
	db 1,1,CONFUSION
	db 1,2,GUST
	db 1,3,SUPERSONIC
	db 1,4,TOXIC
    ;Muk
	db 2,1,MINIMIZE
	db 2,2,SLUDGE
	db 2,3,ACID_ARMOR
	db 2,4,TOXIC
    ;Crobat
	db 3,1,DOUBLE_TEAM
	db 3,2,QUICK_ATTACK
	db 3,3,WING_ATTACK
	db 3,4,POISON_FANG
    ;Weezing
	db 4,1,TACKLE
	db 4,2,SLUDGE
	db 4,3,SMOKESCREEN
	db 4,4,TOXIC
	db 0

	db BLAINE,$1
    ;Growlithe
	db 1,1,BITE
	db 1,2,ROAR
	db 1,3,TAKE_DOWN
	db 1,4,FIRE_BLAST
    ;Ponyta
	db 2,1,STOMP
	db 2,2,AGILITY
	db 2,3,FIRE_SPIN
	db 2,4,FIRE_BLAST
    ;Rapidash
	db 3,1,STOMP
	db 3,2,AGILITY
	db 3,3,FIRE_SPIN
	db 3,4,FIRE_BLAST
    ;Arcanine
	db 4,1,BITE
	db 4,2,ROAR
	db 4,3,EXTREMESPEED
	db 4,4,FIRE_BLAST
    ;Magmar
	db 5,1,FIRE_PUNCH
	db 5,2,CONFUSE_RAY
	db 5,3,FIRE_BLAST
	db 5,4,SMOG
	db 0

	db SABRINA,$1
    ;Kadabra
	db 1,1,DISABLE
	db 1,2,PSYBEAM
	db 1,3,RECOVER
	db 1,4,PSYCHIC
    ;Mr. Mime
	db 2,1,CONFUSION
	db 2,2,BARRIER
	db 2,3,LIGHT_SCREEN
	db 2,4,DOUBLESLAP
    ;Espeon
	db 3,1,SAND_ATTACK
	db 3,2,QUICK_ATTACK
	db 3,3,SWIFT
	db 3,4,PSYCHIC
    ;Alakazam
	db 4,1,PSYBEAM
	db 4,2,RECOVER
	db 4,3,PSYWAVE
	db 4,4,REFLECT
	db 0

	db GIOVANNI,$3 ; Only does 1 custom move, rest are natural
    ;Rhydon
	db 1,3,EARTHQUAKE
    ;Steelix
	db 2,3,EARTHQUAKE
    ;Nidoqueen
	db 3,3,EARTHQUAKE
    ;Nidoking
	db 4,3,EARTHQUAKE
    ;Rhyperior
	db 5,3,EARTHQUAKE
	db 0

	db LORELEI,$1
    ;Dewgong
	db 1,1,SURF
	db 1,2,ICE_BEAM
	db 1,3,AURORA_BEAM
	db 1,4,REST
    ;Cloyster
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

	db BRUNO,$1
    ;Onix
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
    ;Steelix
	db 4,1,DOUBLE_EDGE
	db 4,2,IRON_TAIL
	db 4,3,IRON_DEFENSE
	db 4,4,ROCK_TOMB
    ;Machamp
	db 5,1,CROSS_CHOP
	db 5,2,ROCK_TOMB
	db 5,3,STRENGTH
	db 5,4,SUBMISSION
	db 0

	db AGATHA,$1
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

	db LANCE,$1
    ;Gyarados
	db 1,1,DRAGONBREATH
	db 1,2,TWISTER
	db 1,3,HYPER_BEAM
	db 1,4,ICE_FANG
    ;Charizard
	db 2,1,FLAMETHROWER
	db 2,2,DRAGONBREATH
	db 2,3,EARTHQUAKE
	db 2,4,METAL_CLAW
    ;Kingdra
	db 3,1,WHIRLPOOL
	db 3,2,DRAGONBREATH
	db 3,3,DRAGON_PULSE
	db 3,4,FOCUS_ENERGY
    ;Aerodactyl
	db 4,1,AERIAL_ACE
	db 4,2,DRAGONBREATH
	db 4,3,ANCIENTPOWER
	db 4,4,STEEL_WING
    ;Dragonite
	db 5,1,AMNESIA
	db 5,2,DRAGONBREATH
	db 5,3,DRACO_METEOR
	db 5,4,THUNDER_WAVE
	db 0

	db SONY3,$1 ; Player Chose Charmander
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
    ;Rhydon
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

	db SONY3,$2 ; Player Chose Squirtle
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
    ;Rhydon
	db 3,1,TAKE_DOWN
	db 3,2,EARTHQUAKE
	db 3,3,ROCK_TOMB
	db 3,4,LEER
    ;Gyarados
	db 4,1,HYDRO_PUMP
	db 4,2,DRAGON_RAGE
	db 4,3,BITE
	db 4,4,THRASH
    ;Arcanine
	db 5,1,EXTREMESPEED
	db 5,2,FLAMETHROWER
	db 5,3,ROAR
	db 5,4,BITE
    ;Venusaur
	db 6,1,SOLARBEAM
	db 6,2,RECOVER
	db 6,3,GIGA_DRAIN
	db 6,4,GROWTH
	db 0

	db SONY3,$3 ; Player Chose Bulbasaur
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
    ;Rhydon
	db 3,1,TAKE_DOWN
	db 3,2,EARTHQUAKE
	db 3,3,ROCK_TOMB
	db 3,4,LEER
    ;Exeggcutor
	db 4,1,GIGA_DRAIN
	db 4,2,EGG_BOMB
	db 4,3,SLEEP_POWDER
	db 4,4,LIGHT_SCREEN
    ;Gyarados
	db 5,1,HYDRO_PUMP
	db 5,2,DRAGON_RAGE
	db 5,3,BITE
	db 5,4,THRASH
    ;Charizard
	db 6,1,FIRE_BLAST
	db 6,2,AERIAL_ACE
	db 6,3,SLASH
	db 6,4,FLARE_BLITZ
	db 0

	db $ff ; End of custom moves lists
